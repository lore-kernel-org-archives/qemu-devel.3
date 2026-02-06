Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DEAECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCNy-0000SO-Og; Thu, 05 Feb 2026 22:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNm-0000Pv-FM; Thu, 05 Feb 2026 22:19:49 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNj-0008HM-TI; Thu, 05 Feb 2026 22:19:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS0OhUfoIZfdqqxOBItvKJ0Txay7Zxh+K38hAetg3ZE2VVJiwoQdY7xrjnJB34qRiMXMBsrgAg5lAE6F8xQd4BnROgGz8J/o47xCGzPl5f4w+ypLdUZWLC3stylZ9kU7wbzce/n9PH6+ghnj3dJ1+kuOCQr0HNFNbOJB/1lHVKcD+2Mj8WAcB7KXewd6Z80gqBRkXw53qxFj1UUsM5O9gawew31fmXwz/lP8zT6iUd5Z77dQvLqPcZNmP7lc8tA/LNHSemb6ijNxm0cqYnMlHZrDlCMb1ecxhNaE1QbAAdnDkxfunLJdavx0qNIHOt/bpfUwm1XArrnbt3mYj6MwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS0ASIo8L08F8DHN2AgvcB3bjMTC/ycPgk6DjlBkdzM=;
 b=CXbGyk4FLKmqPF4eNXgEyw5Eh0FSxykiAnoUqhtceziSwHGhgIMwf4JBhnHRUYLNobC9AYfA6Xox9EOhseTFiLl7rcs0stWZvKNPDryF8rb4oUv4p7pEVhE2PHLwiPUSZFQe3O7f1/zBoFLJb9JQzVXzTWdN+YxCSU4ZcrOyDqQn+FMYmDjEHE+no2NYHUnkOKgm5XeDObJ02OXrEAXMdWAJ0eh2FxbXqvKcD//LKE1conXFakQotySumWuy2Gb8HPHEpkQX9vhsJFGs323ZzxO/GqGBhhDnlw7R40nQlOBK1s3KPQF4i7tu0hbJvJ7VlQQwUF3J/0oe5t5ZEMBEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS0ASIo8L08F8DHN2AgvcB3bjMTC/ycPgk6DjlBkdzM=;
 b=kYXNThml5E+SZDEjEy3HhPSqwSs/akeCMOKjyHku27wqMRDGTLckL22GMooBMIszZUZn7ieSq3/iWDAKl2O/UDdomfvCDpLHdCRFptMFTmCnM7L/RkJV/D8tbzmtD3xR/MfrtgVpr03abg1kBr1rZSFPw2sfTUa16oc0+m4NJnHqtWWEaA1jTrD+85YZaDhxFUZqFjSLDqfWtIcZjZto2vrs521KF8t9LtnVQlTedyODvNQV7jRWWDU3GQMuK0IyJegpDli+6+VAt0iQU9pwn3KgfqjfrWZbWBLOVyzJP/yrRHHXcf16yvc1dZhZR69CKfBTjLH3KBb3/kZUcDX0Sw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v3 03/20] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Topic: [PATCH v3 03/20] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Index: AQHclxdpChl5oA4ZIk6I0qfUGz6ASA==
Date: Fri, 6 Feb 2026 03:19:32 +0000
Message-ID: <20260206031926.3227848-4-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 664f3919-6952-4fd1-7316-08de652e8bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2/2F6A0u65gDtB5oB1tMQrn5B7SBkhqE/6hu3ikKVfs45oMEOwlXpbdIho?=
 =?iso-8859-1?Q?s4uiHI21nkttF65VwZXz/ncSD3FC9Vpr6rVVISjf3OlKCWaEygQ9LfpTya?=
 =?iso-8859-1?Q?8RPsI4KRfMp6tj7ObGsDniCYMJN1b5GOMz93YrR/b1CkU0ic41CGkZvFEd?=
 =?iso-8859-1?Q?9KBZOpbW+JgUFgfsI8xh1Qvhs/3d2z6NyTYzi4R5Nf7RZlWQQ4vrH23GqI?=
 =?iso-8859-1?Q?y8k9clHN+u33NUAQaJWIDOKSwVpnJebOK0vOxc7E/rgGurSw1izHXe71YK?=
 =?iso-8859-1?Q?d0Smr1p3g+NEw4dn5WNsvB8ZzqkhHBLc6BDTiU3YyI83sz2jo42/JYDcKY?=
 =?iso-8859-1?Q?go0b2YkEHejj+DNz+rB6jOjAQ0XzPvPZ7GpccgJKpJPAVRMc7+EEY3KYqB?=
 =?iso-8859-1?Q?WX0rb89bul+ajshQdn/xXJlWJ9TFq3T1DY4WQZkxsEmksJfpxVt+BZT0eU?=
 =?iso-8859-1?Q?wPqyYV3QIJHfixt/YW/skmS73CXQTeqa6EhNomly/0UQO6aF8isg0yYmHr?=
 =?iso-8859-1?Q?Zypf8saUnFcCesCK5ktDgSFqFrhZss9bH0D9UXEzIoh7Pj2NlITaYNUF/E?=
 =?iso-8859-1?Q?FBAGRInk05AeGyzPwww9wrBWTfU1+ny2uo0FZcwbaKpGlM86oBrBHR+pae?=
 =?iso-8859-1?Q?mNY8TuBOXZlBXs4pFSTcZurvj17k+yy9n/4e3zsO9oRWIoeifeyyHalhc+?=
 =?iso-8859-1?Q?8ZSTIFQW2kU84DFkS2kNesItKJXm+uQIo5DFaOLnXDhC1mo/5sbx3Lpa+j?=
 =?iso-8859-1?Q?IITB/far+TYGZKK62zNG4zMobPNesnqw3HhRM+9TulnHz3rawU6oUi5r7M?=
 =?iso-8859-1?Q?YhTKhtjygHUchCznunCrjg7u0cSgdmBP8WtCqTlD659wOiOJ4JaofH71iS?=
 =?iso-8859-1?Q?mkLI4J9t3gNNCufCwBnRd6EWmXDezh53XU7YRkrwzYlLVI6jDoViRAoS+j?=
 =?iso-8859-1?Q?wVOiyda8E6cMq6g+w8IPGesesljJQtujWWUZbLwP1gT74d75CHByoIxBsx?=
 =?iso-8859-1?Q?Jx6Y8isQeqRn5TEEgdBLsyonNi9YR3QajpyQzJw1PY9DAbMkAyh68L2R3q?=
 =?iso-8859-1?Q?ObojYNGbEjcZQXNtvK7/zx0VtdBEGO9E4ScUCnENdNp0fxTz2mH8N+ETOl?=
 =?iso-8859-1?Q?t2ok1kWasNDUUSCvPe9aAOOZ1zXJs8r6y2jInaq2U9HWZJDUyCjiY8YVdw?=
 =?iso-8859-1?Q?WcryVCzu38RFH+K5WlR37nrEDApIP8bgXe6c+pEifmb3v+YN3CtVccak0k?=
 =?iso-8859-1?Q?K19IWprN2WGOOhU6O98KgNXnnf8EFg0S9y/3jXeaRABU7Xmst11ZDy6dcr?=
 =?iso-8859-1?Q?SDS38BTLPyOMUJDuGZ0quxqo5j66Bph/qTOtR336oG2np2thtu5Gh8mWtP?=
 =?iso-8859-1?Q?5bN5kqr7QreE8CrIjqMU67NHTYF/ybM5Fo1sk9mt3qNptwobZeHR8jT1RP?=
 =?iso-8859-1?Q?4unpDuXTR67KAjHFkEYs4Gsh/HswCJJqE1ABdlQImdpOvkJMrX+JalUJPu?=
 =?iso-8859-1?Q?NRJNbd1g5tGWp9FdjwaJ0c/UTbumo6C0oiMMEWKd6IRn7bXEyB0dPsYnQU?=
 =?iso-8859-1?Q?sPPyYZFoU8FZDWlIsFq1CwJBy+noIiVDg2CiJVWlrSlJyx8E5XujtxRW9l?=
 =?iso-8859-1?Q?JqKgCIff6P/2BiQ34Fq11Sv/MBsmMSJTzdQ9lqUAZC0Rz5pQ3bLtimfiov?=
 =?iso-8859-1?Q?HoBVh9w97CXBTMgaHanf02OsTHD9vThfeMAg6iXq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1SBshv0HqJtod6A8B+dejb5VYcZUA7cRSX38jhWNAjHs9e0xD8+p4yTD3w?=
 =?iso-8859-1?Q?WJQJliHytZgygrRgjwbGyofzWkI64TZQRpE0t2vwfocVw7qLC9xOgZGJWu?=
 =?iso-8859-1?Q?9epoyVtmW2s38ZIWrotuuDVyhbUm0cVLKfFBfJjVWBOV7v+Fmwg2odIa7F?=
 =?iso-8859-1?Q?Nbwec+qu5PfusNV2gkbi2RAC+IIMay+9eCvhrkICnOJGILrgMXavqoiZte?=
 =?iso-8859-1?Q?kikMVkOO6+kY3HWCR5YoA/ozpdX1bS1DYIngRabypCKte99k+BJbzQbgyX?=
 =?iso-8859-1?Q?iBN55nazljrdfDpxUxVwCXyxZLY//jLUy/lgmfZ+dSBtZFZ7mZtBz3Bnud?=
 =?iso-8859-1?Q?Daw0HNz5S6NaXQhrL/cVptZiMHq+Y7M/jO6u7Tcxps4aTAg7Fv0a9uWZXm?=
 =?iso-8859-1?Q?Xc0S699NIFkmqcWg2RZWsKbINBHmVJQ1rFiodHEH6gV+fy2SIcnVP+FZjs?=
 =?iso-8859-1?Q?Jiu7Q+AOfuSCTQwL8jUi/qB5zOn0moo2DgSCNT7KAfx7jI8IwqV0xXufP4?=
 =?iso-8859-1?Q?HUtd6DsXrP/neYYAMwwZqtoSR4W+Fq9xK28hzPj7cuWXHJpQZkTbBqdpgs?=
 =?iso-8859-1?Q?KOSDLKQoGgCilM1Rr6/0Xyds1ITi0OmMHETHY7oX+51KCfc4G33svcxyQ5?=
 =?iso-8859-1?Q?hlx8QXYlCFm/ub4qANJQfgey6ybsYJ5zoAk8Rg8ID9GauAyQay9GDm3daI?=
 =?iso-8859-1?Q?XGa+mJW3ZW+dEA+WL0ZNMrWbvTnMSoBgTjJrpLrAVcvwpMbRgmw4B0/EtO?=
 =?iso-8859-1?Q?5xGWph9nLyTZY3bwiK6EOkTQtAghUKVzYZCVvKFk/G32Y4/62nSrqVWUzw?=
 =?iso-8859-1?Q?qUOUXIP+klDf05kQDPKMzFq7LGkiihgllHCAnYyiPee4pqHZw8VKo/C6DY?=
 =?iso-8859-1?Q?+nz039DlbztmrNPdoNoUcofuzM17fktA04vwJoDwG3wFdruALLsY/Sm3Li?=
 =?iso-8859-1?Q?B5xkYEYJzBSm7X1HUdJTdJRCUcXA5yyUkDAR7DdXVogjWBJLKWN1m7Fbtr?=
 =?iso-8859-1?Q?3J8qgr8KjxgtG5FqUgyNrzaMTNc3oBuAJXzXgeIhqHVphr3TCMw/+6cXEA?=
 =?iso-8859-1?Q?Kp9NZXgfqFAiU10vG0ui7WLqU2wR2e1Esvl+A+Bv6nbl7Vh8evZdyFfoLI?=
 =?iso-8859-1?Q?PkNL4wbxus+yF6Onq8dWzGY4VZfW45SxOkoepZtcaVrH2nFtEqQeR78ND+?=
 =?iso-8859-1?Q?79ZrSXSlWKc3b4RrRefumVPZPBZ0YFfyLNsqaGTSxCnyIpOfueJhbnZ97R?=
 =?iso-8859-1?Q?irsS1QY9CL2kCzjpSwKFWtjwnohiyfUh/LY1+8B+eOl/dcqJExQ2oRz7Sj?=
 =?iso-8859-1?Q?nBHhRGQK+nJC9YaZbNX2aWXaLV4Dvz7lz9UVpAlhKfix5RlQc1YKkLXteH?=
 =?iso-8859-1?Q?33IRq4IMsa5f3DS0Q0NigihmPZ1rEDPm07eirueE1Nq2o+SZ5dBVKXFl2R?=
 =?iso-8859-1?Q?V0UOvaeda9nlYbAiNIU/6YcHT0v7GuTEspf36lDYbURV19Xa+GCcxo6RQ8?=
 =?iso-8859-1?Q?6L1pJRZwiCV8PP9I59wYi4/opY7PCw82x/sJ4DLYFUXHF/DFM+1JpBkZvR?=
 =?iso-8859-1?Q?82B0ih9YOK3dJEqfG65neWsADMTQEeAzQ6WLNw9MlYfu1YJKo6/YyFxeFU?=
 =?iso-8859-1?Q?y7r+bEz8EHRJ1lAnydFc6MC6+LiGWQpcPbDFUfVZ+uSAbNf0LH7rZCditM?=
 =?iso-8859-1?Q?IRbi8sIE1Gn4VUzyPVTC5AyWXXfgoSTh5gkw2JFSIBaf4RLCtjffoq6BSu?=
 =?iso-8859-1?Q?IJgbqv+EzQdKW+tMQ1yj2ERi3CDZj1eLa327qHa9TAg4B9xVd8mE/ZHuHT?=
 =?iso-8859-1?Q?/8RiTbAdDw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664f3919-6952-4fd1-7316-08de652e8bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:32.1745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42NWOecB27Rfv1uEHg6+oYwTOUubNcLQVjCOls9rWLALc0YCrqylhP201Yif84pYBArtkbOQkBjlqxrOmpev7R+nTioNkLouR/gFkUaShMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Aspeed I3C IP block is technically an Aspeed IP block that manages=0A=
6 DW I3C controllers.=0A=
=0A=
To help reflect this better and to make it easier for other SoCs to use=0A=
the DW I3C model, we'll split out the DW portion from the Aspeed=0A=
portion.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h |  19 +---=0A=
 include/hw/i3c/dw-i3c.h     |  35 +++++++=0A=
 hw/i3c/aspeed_i3c.c         | 183 +-------------------------------=0A=
 hw/i3c/dw-i3c.c             | 204 ++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/i3c/Kconfig              |   3 +=0A=
 hw/i3c/meson.build          |   1 +=0A=
 hw/i3c/trace-events         |   6 +-=0A=
 8 files changed, 254 insertions(+), 198 deletions(-)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 7a984e1f01..f8e13b6fab 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -10,29 +10,15 @@=0A=
 #ifndef ASPEED_I3C_H=0A=
 #define ASPEED_I3C_H=0A=
 =0A=
+#include "hw/i3c/dw-i3c.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
 #define TYPE_ASPEED_I3C "aspeed.i3c"=0A=
-#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"=0A=
 OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)=0A=
 =0A=
 #define ASPEED_I3C_NR_REGS (0x70 >> 2)=0A=
-#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-typedef struct AspeedI3CDevice {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
-=0A=
-    /* <public> */=0A=
-    MemoryRegion mr;=0A=
-    qemu_irq irq;=0A=
-=0A=
-    uint8_t id;=0A=
-    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-} AspeedI3CDevice;=0A=
-=0A=
 typedef struct AspeedI3CState {=0A=
     /* <private> */=0A=
     SysBusDevice parent;=0A=
@@ -43,6 +29,7 @@ typedef struct AspeedI3CState {=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
-    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
+    DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
+    uint8_t id;=0A=
 } AspeedI3CState;=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
new file mode 100644=0A=
index 0000000000..4550ea45fe=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -0,0 +1,35 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef DW_I3C_H=0A=
+#define DW_I3C_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_DW_I3C "dw.i3c"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)=0A=
+=0A=
+#define DW_I3C_NR_REGS (0x300 >> 2)=0A=
+=0A=
+typedef struct DWI3C {=0A=
+    /* <private> */=0A=
+    SysBusDevice parent;=0A=
+=0A=
+    /* <public> */=0A=
+    MemoryRegion mr;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint8_t id;=0A=
+    uint32_t regs[DW_I3C_NR_REGS];=0A=
+} DWI3C;=0A=
+=0A=
+/* Extern for other controllers that use DesignWare I3C. */=0A=
+extern const VMStateDescription vmstate_dw_i3c;=0A=
+=0A=
+#endif /* DW_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index fff259ff66..b0844d4da2 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -2,6 +2,7 @@=0A=
  * ASPEED I3C Controller=0A=
  *=0A=
  * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
  *=0A=
  * This code is licensed under the GPL version 2 or later.  See=0A=
  * the COPYING file in the top-level directory.=0A=
@@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
     FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
 =0A=
-/* I3C Device Registers */=0A=
-REG32(DEVICE_CTRL,                  0x00)=0A=
-REG32(DEVICE_ADDR,                  0x04)=0A=
-REG32(HW_CAPABILITY,                0x08)=0A=
-REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
-REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
-REG32(RX_TX_DATA_PORT,              0x14)=0A=
-REG32(IBI_QUEUE_STATUS,             0x18)=0A=
-REG32(IBI_QUEUE_DATA,               0x18)=0A=
-REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
-REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
-REG32(IBI_QUEUE_CTRL,               0x24)=0A=
-REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
-REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
-REG32(RESET_CTRL,                   0x34)=0A=
-REG32(SLV_EVENT_CTRL,               0x38)=0A=
-REG32(INTR_STATUS,                  0x3c)=0A=
-REG32(INTR_STATUS_EN,               0x40)=0A=
-REG32(INTR_SIGNAL_EN,               0x44)=0A=
-REG32(INTR_FORCE,                   0x48)=0A=
-REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
-REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
-REG32(PRESENT_STATE,                0x54)=0A=
-REG32(CCC_DEVICE_STATUS,            0x58)=0A=
-REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
-REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
-REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
-REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
-REG32(SLV_PID_VALUE,                0x74)=0A=
-REG32(SLV_CHAR_CTRL,                0x78)=0A=
-REG32(SLV_MAX_LEN,                  0x7c)=0A=
-REG32(MAX_READ_TURNAROUND,          0x80)=0A=
-REG32(MAX_DATA_SPEED,               0x84)=0A=
-REG32(SLV_DEBUG_STATUS,             0x88)=0A=
-REG32(SLV_INTR_REQ,                 0x8c)=0A=
-REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
-REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
-REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
-REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
-REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
-REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
-REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
-REG32(BUS_FREE_TIMING,              0xd4)=0A=
-REG32(BUS_IDLE_TIMING,              0xd8)=0A=
-REG32(I3C_VER_ID,                   0xe0)=0A=
-REG32(I3C_VER_TYPE,                 0xe4)=0A=
-REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
-REG32(SLAVE_CONFIG,                 0xec)=0A=
-=0A=
-static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS]=
 =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
-    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
-    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
-    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
-    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
-    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
-    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
-};=0A=
-=0A=
-static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,=0A=
-                                       unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-    uint64_t value;=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_COMMAND_QUEUE_PORT:=0A=
-        value =3D 0;=0A=
-        break;=0A=
-    default:=0A=
-        value =3D s->regs[addr];=0A=
-        break;=0A=
-    }=0A=
-=0A=
-    trace_aspeed_i3c_device_read(s->id, offset, value);=0A=
-=0A=
-    return value;=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_write(void *opaque, hwaddr offset,=0A=
-                                    uint64_t value, unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-=0A=
-    trace_aspeed_i3c_device_write(s->id, offset, value);=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_HW_CAPABILITY:=0A=
-    case R_RESPONSE_QUEUE_PORT:=0A=
-    case R_IBI_QUEUE_DATA:=0A=
-    case R_QUEUE_STATUS_LEVEL:=0A=
-    case R_PRESENT_STATE:=0A=
-    case R_CCC_DEVICE_STATUS:=0A=
-    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
-    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
-    case R_SLV_CHAR_CTRL:=0A=
-    case R_SLV_MAX_LEN:=0A=
-    case R_MAX_READ_TURNAROUND:=0A=
-    case R_I3C_VER_ID:=0A=
-    case R_I3C_VER_TYPE:=0A=
-    case R_EXTENDED_CAPABILITY:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
-                      "] =3D 0x%08" PRIx64 "\n",=0A=
-                      __func__, offset, value);=0A=
-        break;=0A=
-    case R_RX_TX_DATA_PORT:=0A=
-        break;=0A=
-    case R_RESET_CTRL:=0A=
-        break;=0A=
-    default:=0A=
-        s->regs[addr] =3D value;=0A=
-        break;=0A=
-    }=0A=
-}=0A=
-=0A=
-static const VMStateDescription aspeed_i3c_device_vmstate =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
-    .fields =3D (const VMStateField[]){=0A=
-        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_R=
EGS),=0A=
-        VMSTATE_END_OF_LIST(),=0A=
-    }=0A=
-};=0A=
-=0A=
-static const MemoryRegionOps aspeed_i3c_device_ops =3D {=0A=
-    .read =3D aspeed_i3c_device_read,=0A=
-    .write =3D aspeed_i3c_device_write,=0A=
-    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_reset(DeviceState *dev)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-=0A=
-    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-    g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d"=
,=0A=
-                                            s->id);=0A=
-=0A=
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
-=0A=
-    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,=0A=
-                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);=0A=
-}=0A=
-=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)=0A=
 =0A=
     for (i =3D 0; i < ASPEED_I3C_NR_DEVICES; ++i) {=0A=
         object_initialize_child(obj, "device[*]", &s->devices[i],=0A=
-                TYPE_ASPEED_I3C_DEVICE);=0A=
+                TYPE_DW_I3C);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -323,27 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error=
 **errp)=0A=
 =0A=
 }=0A=
 =0A=
-static const Property aspeed_i3c_device_properties[] =3D {=0A=
-    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *d=
ata)=0A=
-{=0A=
-    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
-=0A=
-    dc->desc =3D "Aspeed I3C Device";=0A=
-    dc->realize =3D aspeed_i3c_device_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);=0A=
-    device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
-}=0A=
-=0A=
-static const TypeInfo aspeed_i3c_device_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-    .class_init =3D aspeed_i3c_device_class_init,=0A=
-};=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -351,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c =3D =
{=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),=0A=
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICE=
S, 1,=0A=
-                             aspeed_i3c_device_vmstate, AspeedI3CDevice),=
=0A=
+                             vmstate_dw_i3c, DWI3C),=0A=
         VMSTATE_END_OF_LIST(),=0A=
     }=0A=
 };=0A=
@@ -376,7 +200,6 @@ static const TypeInfo aspeed_i3c_info =3D {=0A=
 =0A=
 static void aspeed_i3c_register_types(void)=0A=
 {=0A=
-    type_register_static(&aspeed_i3c_device_info);=0A=
     type_register_static(&aspeed_i3c_info);=0A=
 }=0A=
 =0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
new file mode 100644=0A=
index 0000000000..c949579ea1=0A=
--- /dev/null=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -0,0 +1,204 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/dw-i3c.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(DEVICE_CTRL,                  0x00)=0A=
+REG32(DEVICE_ADDR,                  0x04)=0A=
+REG32(HW_CAPABILITY,                0x08)=0A=
+REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+REG32(RX_TX_DATA_PORT,              0x14)=0A=
+REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+REG32(IBI_QUEUE_DATA,               0x18)=0A=
+REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
+REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
+REG32(RESET_CTRL,                   0x34)=0A=
+REG32(SLV_EVENT_CTRL,               0x38)=0A=
+REG32(INTR_STATUS,                  0x3c)=0A=
+REG32(INTR_STATUS_EN,               0x40)=0A=
+REG32(INTR_SIGNAL_EN,               0x44)=0A=
+REG32(INTR_FORCE,                   0x48)=0A=
+REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+REG32(PRESENT_STATE,                0x54)=0A=
+REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
+REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
+REG32(SLV_PID_VALUE,                0x74)=0A=
+REG32(SLV_CHAR_CTRL,                0x78)=0A=
+REG32(SLV_MAX_LEN,                  0x7c)=0A=
+REG32(MAX_READ_TURNAROUND,          0x80)=0A=
+REG32(MAX_DATA_SPEED,               0x84)=0A=
+REG32(SLV_DEBUG_STATUS,             0x88)=0A=
+REG32(SLV_INTR_REQ,                 0x8c)=0A=
+REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
+REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
+REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
+REG32(BUS_FREE_TIMING,              0xd4)=0A=
+REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+REG32(I3C_VER_ID,                   0xe0)=0A=
+REG32(I3C_VER_TYPE,                 0xe4)=0A=
+REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
+REG32(SLAVE_CONFIG,                 0xec)=0A=
+=0A=
+static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
+    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+};=0A=
+=0A=
+static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+    uint64_t value;=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_COMMAND_QUEUE_PORT:=0A=
+        value =3D 0;=0A=
+        break;=0A=
+    default:=0A=
+        value =3D s->regs[addr];=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_read(s->id, offset, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,=0A=
+                         unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+=0A=
+    trace_dw_i3c_write(s->id, offset, value);=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_HW_CAPABILITY:=0A=
+    case R_RESPONSE_QUEUE_PORT:=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+    case R_QUEUE_STATUS_LEVEL:=0A=
+    case R_PRESENT_STATE:=0A=
+    case R_CCC_DEVICE_STATUS:=0A=
+    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
+    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
+    case R_SLV_CHAR_CTRL:=0A=
+    case R_SLV_MAX_LEN:=0A=
+    case R_MAX_READ_TURNAROUND:=0A=
+    case R_I3C_VER_ID:=0A=
+    case R_I3C_VER_TYPE:=0A=
+    case R_EXTENDED_CAPABILITY:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
+                      "] =3D 0x%08" PRIx64 "\n",=0A=
+                      __func__, offset, value);=0A=
+        break;=0A=
+    case R_RX_TX_DATA_PORT:=0A=
+        break;=0A=
+    case R_RESET_CTRL:=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[addr] =3D value;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+const VMStateDescription vmstate_dw_i3c =3D {=0A=
+    .name =3D TYPE_DW_I3C,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (VMStateField[]){=0A=
+        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),=0A=
+        VMSTATE_END_OF_LIST(),=0A=
+    }=0A=
+};=0A=
+=0A=
+static const MemoryRegionOps dw_i3c_ops =3D {=0A=
+    .read =3D dw_i3c_read,=0A=
+    .write =3D dw_i3c_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+};=0A=
+=0A=
+static void dw_i3c_reset_enter(Object *obj, ResetType type)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(obj);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void dw_i3c_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->id);=
=0A=
+=0A=
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
+=0A=
+    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,=0A=
+                          DW_I3C_NR_REGS << 2);=0A=
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
+}=0A=
+=0A=
+static const Property dw_i3c_properties[] =3D {=0A=
+    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),=0A=
+};=0A=
+=0A=
+static void dw_i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    rc->phases.enter =3D dw_i3c_reset_enter;=0A=
+=0A=
+    dc->desc =3D "DesignWare I3C Controller";=0A=
+    dc->realize =3D dw_i3c_realize;=0A=
+    dc->vmsd =3D &vmstate_dw_i3c;=0A=
+    device_class_set_props(dc, dw_i3c_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo dw_i3c_info =3D {=0A=
+    .name =3D TYPE_DW_I3C,=0A=
+    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+    .instance_size =3D sizeof(DWI3C),=0A=
+    .class_init =3D dw_i3c_class_init,=0A=
+};=0A=
+=0A=
+static void dw_i3c_register_types(void)=0A=
+{=0A=
+    type_register_static(&dw_i3c_info);=0A=
+}=0A=
+=0A=
+type_init(dw_i3c_register_types);=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index 8344b9769f..d545ecd712 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -546,6 +546,7 @@ config ASPEED_SOC=0A=
     select FTGMAC100=0A=
     select I2C=0A=
     select I3C=0A=
+    select DW_I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index e07fe445c6..ecec77d6fc 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -1,2 +1,5 @@=0A=
 config I3C=0A=
     bool=0A=
+=0A=
+config DW_I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index fb127613fe..83d75e7d5c 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -1,4 +1,5 @@=0A=
 i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index cdf7cb07f6..2d944387db 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -3,8 +3,10 @@=0A=
 # aspeed_i3c.c=0A=
 aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+=0A=
+# dw-i3c,c=0A=
+dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u=
] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 =0A=
 # core.c=0A=
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
-- =0A=
2.43.0=0A=

