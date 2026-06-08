Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46DECD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe7y-0000FS-8U; Mon, 08 Jun 2026 13:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWe7d-00088m-Lg; Mon, 08 Jun 2026 13:50:55 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWe7Z-0007iP-19; Mon, 08 Jun 2026 13:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppV83s85z+B6yVVvXs4uceW0ktdXlvOF/6nRGHQIj/fpkki2+qQSpianthY127K/x2gx2dKnhpomzc0FO4eoRaV4TSKDqw0grAWbYpEqstjxPrnh5qj80lxt772oEZz2uX7i5IeYdg7yRQjwRgNpZpAJQUiLosHIe1heVps8Vt4hgH1WIAxoqtRqtd5yLg8vs0UfqYcP94fDXQxQDJP3iqZIhNBZHdSAMWXPjNCAU4XwNpf3z8MDcRmsraBDRDP+DZ1y6ioc49xRrwNvbjwB6L1yZng+f4ys/jO8++8hyKeoT6Bd48p4mmU+kfyKXOqRRUTDv0MVyUGLiICbeToR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6sCXhty+JSdk0DGUgvRQrqCvoyQRfOslubanEUWm1I=;
 b=KSsecwFvedF0IZ+urhi7BiDT9CP5WRUgNcqxTY5DHGrevEpk1BMSweuLVAnvV191Jjj9IaXopCzLsDBUzax7I9RLn2OUSXJHHL5vNPXGTdzjxLTsGl7eTZmIxDEMpELxASXxc5Fdi3gD2w69hkMTNmf4Brh+QcHPFVKzLit0EU0V+0esvEwTvMksAX1HP9OmopAKIlOL661Ztccn/PxMbTUQTAbyPfGLiDpKwf2S00WswU2BNrZvCAJKWFWEHFnyte0Ev0maQxS0QJlAb6S3aCxtowcVZxKdLPgsvpg42O1ZT8X1jprGsE+oiZIgfRqbsqxtfefrUj/b5ez6ebxrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6sCXhty+JSdk0DGUgvRQrqCvoyQRfOslubanEUWm1I=;
 b=fy70AScGciKJyJ/b5+A3yv8hIQaNQ3eUeC5nAxv5S13mYwoG9vjqFKSewszbz76y+AeWeXhs+mQnsqyPfHMA+9KLJKPK48zBGlY5LeQbWrrbkf17hhiMB0nfwOVwt5FxsbJuB55laCOOm87PCxXttFqoLn3us2mgt2BKaV0Zd4RUo/aoa3pEMukKWq0a0vsoFbeeHLKswjFVwehrOyQh2amBqDJhOIsn88YFsAGEcqBVu6u8As7TBZlkkeIyWlmxwCKvBKf76/Qr0TRvN5n1cNIX0t0k20x9kcCkQnJ6CR0+7oL3aKySPVbAu2HxKtp6cKI9tj3d5cThkM9j7avxtA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 17:50:33 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:50:33 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: RE: [PATCH v6 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Thread-Topic: [PATCH v6 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Thread-Index: AQHc928imFZdbGtFLUaRh+0h79wKCrY076Iw
Date: Mon, 8 Jun 2026 17:50:32 +0000
Message-ID: <SJ0PR12MB86143264A7E6D48C1240A069AB1C2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
 <20260608174900.2227340-3-nathanc@nvidia.com>
In-Reply-To: <20260608174900.2227340-3-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM6PR12MB4186:EE_
x-ms-office365-filtering-correlation-id: cb014ae4-69f7-4cce-ca98-08dec5867006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: jTOVuwZXAA0YR0KAE/YqVQc7k95HN2uVFTZaLfGfAAuU3aRid/Y0bf29BnxuCkX6RmztW3JsqyPWGAD5ggZK9JZDIPElfvNOrr0Lpe+z2XOrDI0f+xL8LTt78tDQTnEz4dY9s8NoIIiIepM3DKi41FOkNLW99QTcX9tX5q995o9NYDFfW8T0uqtRf0hb46DM6A7U6GmKHUxdywv7OvGfZHGjDX58ZJybJO/2nZUX4EuGQjfAy6gnj+b1x3SrOqdxCn4+vaAPlamq/l0v2lrRXTjhoBmhsxK6ctuDf+TTiYzo/gNIx1/WgG3OvTQAEFiyzDMBZbiy5DawD714aviINeMYI8eDO8Mn8XGbtJwd5keuBxKId638M7XAju4WB93SV5mtMZIL9LMXYA1SLCjg8VsmEGn/lf+fiNzMffKqanhvIjxTlymUe3PlKGnEaQdygui6T+GNsw4y7ID66DBe3pcJwfolPZnt8WONLJDQhfqldOjx+H+WdlkQmbYyHBM7cZ6jZSGks6vJZRNWPCYPtotTJebwAP7SULZmdoL9nlMNyMIz+WguG7XJ58F3d3VZLBncdfu1ss2hTb4LNW8maL4MWIYhPiLGIAk5wlqlOiBFJHb2pKAJmElqq9C4c+gYqggff642Cd5KAbVzOqKN3EDgq1nrjo7OGyTR7IDvnJz8PX98IMk16XAodh/oxYx4B50ZRXIA960JJQvGmRUIRIzjEJaooYMv0tF5RkYXToqQByna6Q96U/ONCrKn9MI3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v6yr4hlsqFETzT8HjTDI3jAwNCnV3tMFq0pmz7lb7mFcIYU3fALTAl3qgm?=
 =?iso-8859-1?Q?xh4ru4ZfJfFQfmaj4r+4gwnXTZTiAeA3QAbWS66U7bP8UPE4Cg274tweiP?=
 =?iso-8859-1?Q?geSmnnMuP8uwyt8PTj0Q3fb3+UjAcuJ3Bmwl31qyPynijqRCZzbAX02wmD?=
 =?iso-8859-1?Q?jCOxgdFZHt5Bi/Opmm78D78OHeWShmGAakERsAfsD0A8Y3KnUn4pBt+BMZ?=
 =?iso-8859-1?Q?HnAeJ9IqUY8m4F1z6zpg1FLkXaFWeyBjDLzFWfwm/VMpaWFVrvhedXX6HU?=
 =?iso-8859-1?Q?zpTcLwYaL6HDVlWz4r1EV76ON+W1vMLnpBItz3v5QQpGSo/W5Xep3R3I5O?=
 =?iso-8859-1?Q?mRbIuH4fvAK3OlHvXWrf7Bqek45/azUpULoRjRIQr+zzxvIFzkZr7haeq8?=
 =?iso-8859-1?Q?9jNxyd4TRi4JBUs79yP/0i7Ksb99IgX56eY7THBVoWk0xJyChbJJY4SgGR?=
 =?iso-8859-1?Q?q+p4AzqWoiQHSm/FVLCB8wIqn8lmI5+9KzcOKxfXhxPZd/os9UcYWVk3EZ?=
 =?iso-8859-1?Q?81vood8GQRy8f07uZ/38YJlLFvev40x1rDEXrQf+96ohTIGbj2ESPy+Zk3?=
 =?iso-8859-1?Q?FBGh7IV0IWqbJMTQgne2mdqFJJZI4mHn0dKKnlObz2ixudZrGKNdhdlTKK?=
 =?iso-8859-1?Q?9vj+u17W2ESNzs7sIioROKMO73P6vDfDjoMKINO6zVxw0X21X9JUTBZPVt?=
 =?iso-8859-1?Q?OrlwqLWgWMhlECgJFU9oisuR7EJQhZ/SMGXK2SsKCfCg671xOoRv/msBwi?=
 =?iso-8859-1?Q?4iBvor03SzSkRYvn/P0NY3vBCFkCQdfBjTdgXepmkNuERXIIrEDJoILhiD?=
 =?iso-8859-1?Q?SFVKiUV4o4OhKFvSX7fPdgkclmOh7BImLAHCQ2nuzFoMNnUF9KRz0kkgZ1?=
 =?iso-8859-1?Q?wUS1K/nLr1b9/d/dRFgtUG03hAa1rV5li32PhMu/D5U3vDuvoePDVydlGH?=
 =?iso-8859-1?Q?4uJyEWaBFWAvyeXO95ZTYVZltiYAT0yFx9yt67Z/rfz91U3MNCqhzbdZQG?=
 =?iso-8859-1?Q?TiPJGjeck+WbUUUDe54ztzdYGyrAbDVYQz99JNIF4+mY7PNBne+UF+P2U2?=
 =?iso-8859-1?Q?Om1J+Z1Oe5Ik/PCbO3nBFhbRhaXd1fZkOKYW4zJXG9Pot/U8EV0pB4ziSz?=
 =?iso-8859-1?Q?/MY0hAbuuWCdQCanREXmxdazLKSiE9nvzLjcgZmqOq6mMpXjDRdECKhOxx?=
 =?iso-8859-1?Q?YN7Yox4hIy1PaYsvjhfTh87Sbv5pmuwQStOsONCHA5TqSaHNcTO2zKG+kb?=
 =?iso-8859-1?Q?EIrD7p93gQIoGrOhznk15pjObLxc2x/i685/dMOOlY1Cs3Hf8aaPXgyW0U?=
 =?iso-8859-1?Q?oG9eXFberUQU0urkalixocyZIZmiSCJ6WWDC2WeH8xvz88gib2EgNCVmxt?=
 =?iso-8859-1?Q?WC621AMXfky5AxScgJUz4SsMLduuIraW9JDk5Le0Hs9b9rtPFlu3hCz0nP?=
 =?iso-8859-1?Q?8DPOLJCAgY2IyJGmuN7gkXcF81F1T6XlL0+8riIrIpYIDQIeMd8H/S8K55?=
 =?iso-8859-1?Q?j/iccOITvBDJbr5furv8T+5wmMVDM76nS9eIzBzd1ysfPQkWVrng+1+5xa?=
 =?iso-8859-1?Q?O4jI/AyDRAroDyVKciV717BFJWfa9W+tDY6XYU8XEN0WSXqF3toXDqSZcX?=
 =?iso-8859-1?Q?3OsGAfHlJo3OTsOkwWCYD/AQsSJgon/QCEk7wCNwoWj2nQAT0LpgI6es6l?=
 =?iso-8859-1?Q?8KxxKugRpG9Eh9H3GJqmQgZtmsWG9GBnCqtRQFm10djxbMrRzQTAzQl29L?=
 =?iso-8859-1?Q?pY8o3nhFAiSaGh8c15vWWd9oY4ubDfLYcxBnKyO+AFVrAsagx2C0jkdT0i?=
 =?iso-8859-1?Q?4lJk54D36A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb014ae4-69f7-4cce-ca98-08dec5867006
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 17:50:32.8272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVUOUG5+pQMdGm6S741xmvG0Rf+ibnIti+Su8D5b0Ivzbn9Ig4jmooRmErgrNPEgdrmmUrWoWfIfBfrWY7oDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 08 June 2026 18:49
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@mailo.com>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; qemu-
> stable@nongnu.org
> Subject: [PATCH v6 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
> documentation
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Add a statement to clarify that the host SMMUv3 must support HW-
> accelerated vfio-pci device assignment when setting accel=3Don.
>=20
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

