Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE241075277
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38qn-0001ov-JX; Thu, 19 Mar 2026 04:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38qT-0001i4-Sh; Thu, 19 Mar 2026 04:35:13 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38qR-0001GJ-38; Thu, 19 Mar 2026 04:35:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGXbqlCu43px32xaJeZcmyjpwhioBBzOmSi1DVH4p6ZDwgZZ2Ue2V8kpcmO0GXKAnHQvYy+t7Dj3EST4KBO+56kTxSQEHXCvEIAYU+8ASR/zFFrLQfxyXdbG1qjWA3vfkphjHr7lA/iCWe5HoY8nIRV1UcMvUCNgfDTcHtkS2ag4TGC1FdL6mmV3eSelPHhWi3vB64dWu4m1KSwgrkp0L6OfwAXL3FWu3fXUQ8tpg2yKELLUBqwlOF/o4ih/EpMUIJRYSkF/bS3zIA8rAMiJ5UhquspKO6fHrMQBVjEOz1JDVIk+HqjPJiFbp2poVzqny1Nh4tm7hGyHr5NhLAHW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNe3htYzTI0pMrEdGpl/LxGRNTdfE53+bHGUI7yP/94=;
 b=mLJKWJcqURjZ2SMYUjcKAZDkp2TOo/ZOfZP+HnA5ZNvDNMZNNh4iDVN9YOTxqmAyP73xuNsmr3mWvalsujM2ag8n8CXKILwABzoYb4CeFXE/eW8EqM1evNUVeV/hkSibrAocFAmwPtXQxNQUnnySFl2OZwnEvGhMyW6IkJloA8bIgbB2nV6G/kUMGGfzAqIUSNRgFK05S/m628LgUS+F5KHGx/Am8sa7aY0M8LH45iRKBb1TjXPVAmRgQ7F1vzjF6DfX8AKwolLkBaeZSH0XF/23/zQFyXv9H/nnSacNNZAiWGtUHbuyAb8N7qds3Omk+/SbTnlxa9sVX7bt4CynHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNe3htYzTI0pMrEdGpl/LxGRNTdfE53+bHGUI7yP/94=;
 b=HWj2vlJSjEpRzRB2ef7iCSZH0qGSJbJsqt6kOkI0hxscy8mDnP6D6Su7zC9eYnvgLx40YZ1VCfSyGZ11Z5+nfOVBAEVZeRBJ5uFAGoDQ8DnXXjs8hHZrGt7yxDC8vd0qnO9RCPE53Jy1N5A9J7WK1jiF5Ot2+kbsTPyqNlZDl4q+5zRmTEKkq78POXjIgfk7V/g41dp+XNr72CqJlobqR57R9Ou135SSuZjwV2PLbySxscDyJWQ9CxFfElo4W/6eI8aZkmyUZdSmy9miOG774R+MEZIoJ0K3Bp3Kr8VXEYsgNrBx/y3S/BrEf+U+pCfHaxt3xERtJbdWyp6pswjCxA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 08:35:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:35:01 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Topic: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Index: AQHctwf6OwrZMOQjTES+TWh1wPCW57W1iFJA
Date: Thu, 19 Mar 2026 08:35:01 +0000
Message-ID: <CH3PR12MB75483B9876A99AE0BCA4A57FAB4FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-6-nathanc@nvidia.com>
In-Reply-To: <20260318184907.4060030-6-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB6633:EE_
x-ms-office365-filtering-correlation-id: 4eb2c379-5871-4e4e-94c5-08de8592695d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: fiiUG02qC9TAf2kSBRVtFnJFHKhPyZu799gQeQdjvLoSZqT/S0JB4G4TSznNSa15f/Q20qP5U2PWclHZEu2k76tlgUW7qIL9nOYgFu1YwD841YI1O/c+qvljrPHDNp1ZDJglJrkNnyDqCaDo+fKbwlH6F0rpy53dX/U6kZLBpxBKhoXEOqXV4heUC4Ke7XNIEF7uZWvR68qwXHj8NV1dA5CB0z/Tw3oZVM4gS0tggZN7Yj8QkCzcOpUcvu5fwHn1wzTQ+T+Kh7TgjYv1uwurtCZsKfxB6kvFJ6eNK3OchP6BCgXZYnIiBmH968wnAUSEvLPSHlgajIOdml6Pf6bZxUitCPsIig1tiwET39dxLPsDDyS3N1bqjLjLfBRqXREMvKtH3E2+j9zEx0dNkl8VdiRuTybNcZo4MTgHdPT3+x1NOWKN1/keubYXt8UdEJ3dMy6KvUYmi+bSg5gy5qLyv885oKCKj94Tbi0hP4IoIof9NEyVFiLY7f1/ijPB6qKgqoVGGSCXqHvg6GSCItGFWySfZZSCL6ASIPbyeojuEnAd9jyNNAsaBhq/U9OMQm6/Nf2h8yC3MmPn+1vcYaJSq/IMboOrLhObuDe5VvpewVK0XG24gfGadqxgEcW6gHDimwT1u9ygSG5eT+vKWRGNum86ocy/BGQ3Be/5UfKiVz6l7KPjOvgHK3nHeTFwDw7LUAvjIenygLvkY1hXcSUruGtBuio/KIjV6aCG2ussvtpTPpDEFIX0npny/Lh7IpBbasQIczmXv+Ww6fX8DKrpHYrvhbhJw2i4dP1guAayuqI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SdZsrmy7qC66TZscQ/3MTi/WgCytIu/rnUSavVJShPGRFtFx83UVQjsVLE?=
 =?iso-8859-1?Q?TIzjO2cEIJBGY6G0zke6jQEzsDMsWRwedKLoWWwTVjuNWbI5a2pOYWimsi?=
 =?iso-8859-1?Q?542E+lol65bSCb0SH99VUUSy34VzGKee7dvrHsxM8+3szSSCK2FhGGl4fv?=
 =?iso-8859-1?Q?ZThJk70AFBoUNPmaOYuotp4v86VlgjrFdyQ38ej/rOOBjwNyWa127UJIHM?=
 =?iso-8859-1?Q?t+uDvyyXx6A0wYpVsni0tJnQ2AEJerVLR1PuSdeWmTNpaganvH4duVeh2K?=
 =?iso-8859-1?Q?0Ww2OjDIIzepB9/uwnylwfTqjZtvRlfwlueqtWWTaRBm1678CfCs4LXLnD?=
 =?iso-8859-1?Q?onv5XbrB+vbKpbi6Dh3FGQ3OQUMjWy9aHj7TvBWc7LG8fM3lv4JYTVAonL?=
 =?iso-8859-1?Q?Hgw/baaanHwPTQ/R49H4i3LgdT2oL2qMnInjrOoNGIqYcjtb0eXgSstRa0?=
 =?iso-8859-1?Q?cfTGe13w5zBXHunNbvp03xjUNkVWT52xU+llQS7hcKfaOs3V65iEXtrHqS?=
 =?iso-8859-1?Q?9E343YyGGgbU4tdSf99wcJOBnXewPhiGVPkf2HV/Ki9ivahdnU/UEz6mhv?=
 =?iso-8859-1?Q?nuV0yF5jgXeRKor9e6NlLkJQ+Jx6IfNnlVkDpZG1s5KkYTCe0YSo+EEbJm?=
 =?iso-8859-1?Q?cW8cj++0I8uHJ+yc52u6Ku0HpJsPHpwshBFl/bhDMoCLbsrT7VlDuOI3Py?=
 =?iso-8859-1?Q?7B/e45OPtpeRcR0Jjg1TJrd00VaBo+Q1Xt/duzAoTLSJbxB2yQBujQY472?=
 =?iso-8859-1?Q?SDOOgiCBWyPRM2u2WBm63Wo5D6gf6NUQKhGrBbS2Z72iTkLKDGriqpCnSG?=
 =?iso-8859-1?Q?L3/EKOwbnr8XTcy+413coIyOpFiMr5QyWhs53ywqdglqlGyVUsp5dwx5ZS?=
 =?iso-8859-1?Q?JBq1O57XZhyKyr8vl96c+zAgz9NjTrOJWj6Te4AJ9oMfvNZVdCBvjl70RQ?=
 =?iso-8859-1?Q?mjJqsqKDfHpDPB0/6FpNLViK2JTSVixD/bQJRB44c7svtkn0gTEh9V4gWW?=
 =?iso-8859-1?Q?pcnRht3VXk2xIuBOMwNHlwdCMGelyXxEnXgWFMOwd5+QIPfMJ1N2pAGWuj?=
 =?iso-8859-1?Q?20/JCnHr74qnDKOzqX5tLgw12h7V2y/BSZYt3KfzGcY9r1MKYcVoV8EhYC?=
 =?iso-8859-1?Q?ut/c4JZvWcV7Ok8T0y4qXnY9rtvvHkPC/bP7Ea4c0iTHyoU88BbH8xll7A?=
 =?iso-8859-1?Q?2vNKT1eOauEntFpetVAa8JK7T0/05xk9FIYDvwkM1aWc+2fAdCmA7E5Vot?=
 =?iso-8859-1?Q?/Vpqqsjcyqxn1FhGzd7NcwLcld86XcuULXXNaw/X8l5SWwMpj4hBUUBeQp?=
 =?iso-8859-1?Q?23xzF/nrOwvvhEzGvZj+jKYtWARlwwo/KraR5JfeByB1PR6f/1XRCoofyG?=
 =?iso-8859-1?Q?mNru8tXYYYQZGbAFbxcgMeckWUw6F+Hhz08lgl6NmtQlk9bTfHzW6FIPLW?=
 =?iso-8859-1?Q?HBOiqrzsgLM0qFbR+IVoVogJ3LynO+7gwNiK1Zq4QYiAY7a4PYUDeH9Rxg?=
 =?iso-8859-1?Q?1p63NHW05hAfOjkNXfOJFwQzMY8MjgIZIHTVyiBhA4UqinW+MPeQDx4rMR?=
 =?iso-8859-1?Q?LWISkWAmCGhK8j6yL6xOnFMORbYW9Gcqbxsj+bwnkmfsXxxg6hsV5VVmjJ?=
 =?iso-8859-1?Q?MOCDdd3IPmRbQUMrtVX8QWqEGmRlzSCYmbg+dx0u9eF+Mi+tjnMCyo5lDE?=
 =?iso-8859-1?Q?nAUT8GzDp+uWPGexEHh2IGl52ZMfDEtkBIggU9oEr4BjYNh5z2BcqohIzM?=
 =?iso-8859-1?Q?AA5olkOIXpGzwjL54vDxLZ63T9jV1ePGjGHQDPGQjEiMkJL0KNISVu0i+X?=
 =?iso-8859-1?Q?3am9fIk7fw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb2c379-5871-4e4e-94c5-08de8592695d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:35:01.1863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1B3WD27sGj6loQXkyLteYX+aefgFS8ATutEEqtkeNJvj28eqwArksFlLthyuQM7jg1yIbA6ohCGmWdodgNabNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
> Sent: 18 March 2026 18:49
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Michael S . Tsirkin <mst@redhat.com>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
> SsidSizeMode
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
> The 'auto' value is not implemented, as this commit is meant to set the
> property to the correct type and avoid breaking JSON/QMP when the auto
> mode is introduced. A future patch will implement resolution of 'auto'
> value to match the host SMMUv3 SSIDSIZE value.
>=20
> Fixes: b8c6f8a69d27 ("hw/arm/smmuv3-accel: Make SubstreamID support
> configurable")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

