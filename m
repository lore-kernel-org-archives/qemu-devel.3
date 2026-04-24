Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1EFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXx-0005IG-Lk; Fri, 24 Apr 2026 04:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXc-00050j-Ie; Fri, 24 Apr 2026 04:05:37 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXa-0001GV-MZ; Fri, 24 Apr 2026 04:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC+s/RNkumoDTapN4QGsmtwaQBSbB+QHL1wjNuC34N5hlg/hJC7opaqoJA4bzkJ/uHHGnRGZ8DSXEm6DPhjZwpk5d318jjGPGDbe35MDoxEtpnLKIyw+dpEqU3RN0zT3qcrIhzOBoABJwPDsVZByz46Y1xdn3etm1k3Fx9n3734IaKZFRR1brdAcGQd7XrPkCbKWm9xb1MhLCCZiqnYqU21c4DtJiKSQEzasZbhY4QW12VlasB6s8aQvoP17SYJsFltZBa6xeLW81iCrvzrwO6f1/YhxKA9a8xwCrueGo9CNgXB2neg/j7tGXICyfQysAlH0/tySVWV25eWq41CeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXoR4UdLkGjcJ3WfUu+Cs03fPTbZxQW3bPIQfbCHMKc=;
 b=Q2cKCGYjaCL97MT23oHKLUm4ymtPzMlQcdPAHmtszf789I7ITL4w7YbGwfXRg9q6sn6RcKOOnjHuWmyQ5HcoN7GSi/xhhMxhtzh/e7/xPhVghsARDR2fWdWgJNX2B1IGJdF5QfSVxXl3pA7X8eA3Fai4uN1utg6Env44S8ItCD0IFhBaWZvzBE4qVBzwpngzMkpdMBS5pAnS9yRh5QYN9Us34GKXsREJkMlKYBMNhsjGCvfIPdwX6xBodZnZcxKZ0TtJ0gq4UvxuKfXWS1WLuoqOXEQ9XtnEEGpVEmpFOUdt4fnvFyqb1GEJlB6cjUAPoT+iww1I2Vpu2TCRnDD5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXoR4UdLkGjcJ3WfUu+Cs03fPTbZxQW3bPIQfbCHMKc=;
 b=q0ODvRTy6Cl/BC8GGDAMTjMVFxZCYIune8yMxi8EAOO2YtVdpM4Op8Din2keCJsksfQgVKuJfOPVNoK/302OxSQXBYqnzkRSmzCuR1jxAFeJnEP1m+0FexyQrCz6jafu75WLq+XdkBzcNvjwBGFasGnacyyj/Ypo6Johe+UR4VBdfN0i3Y44Gig4SHLy8BYos80jyLKfKbDneCuqMdxlfMjLWNzYTojK32wjmrSFZnq9aj0/gMaAClSo7Rm/LVlvWVHco3YL3PAq4uGmYxqbgzSkfx2JsMUs7oXSl5enKfGNaFKzCDeGVUaXheKW1MWpvE3oZc7zYBErZXX4+QSF8Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 10/18] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v5 10/18] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHc08EZ0uYcgSAJ1kCww/BzBJkpZA==
Date: Fri, 24 Apr 2026 08:05:22 +0000
Message-ID: <20260424080508.53992-11-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: abc60844-b3a4-49ae-569e-08dea1d83c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: NsEaSgBCdKV0Z7ohzyUzUssSyPZ9DoZlEtA94dNsvxdtM8ic8CJ/NzVORHYr/TNzpfbLUlUvu965kHcZRf0FA4a0gmYU5GWZzoJGb3hlzBJRBD38Ls1rqTX5fBIcb0SV5BEvxzSnX/YYMsFR6LbnoZURmMUjU/GrGezX0zhC2a5VBYEPs5ko1DNNWtknaxP1/FHYLeDP8Z/OCvmpQr76pz0LlIWH48sH1Ig03nOSfJtpVaib3KqdJhSXSeiXn3YhG+oH/F+fWnz+FqOSex5j68eaGGhxwvODGRJWtG+k4e0eaKhLriH4Xhci36FtkD33yWC8r3UENgjUU4Q0jDLazrcb58y2uZABFckThBhpR4NyAAuLRs2FXd01GjqG2UbGS2qUb9iJ8Z3U3kVuzJcygzCIiX1e1ekvEVLZWsqFGZRRnIYPmgeJ+WDTl+WZt5y0fbXuEJm9quEWfymrSWU90NaFupXrBXvkuk2Lt3zuMyTEsdqXLs+vQmsJc6mLodWHqv/Rw6eJ0EnGHhQkzcw01RKemUwyrDDSX6cJIFHFjmiqisdeaLKT6AK+LRCdKaF8Q/3q0bgjVj1Kd4ZKosyXXKXRTaZwOsJC7OEdcegbl1QEEE5x2XWOyEMl0rPjcVjJpJ9m0mzokp7H3pkL9i8cJ2+OrF7bSz0x9LHQDyN4CLdLQ+jpmuFWfo4Gm3H5CPHzOsxHqwoq+37lQ6l3zXeqgGxNQjCvOiXiKNW28+O4biBoTNNat46w/qzIvyWSesPWtElZ0RRbnO6VKNv0/ZHzaizSyoKcm/rlm8SRwnQqPEKILCs0IqkTeO1Mc7waUU49
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zc9SBCsMBguwROyCi1y6k4G/f+HK47iwFYRtHUOsLq4Wvnr85R8A0P1Qij?=
 =?iso-8859-1?Q?KBMAjsOHpXY324H1Y/neEFZXZhSXdqd/LHzqESqF+206Qsr2QBOUU0Ax3Q?=
 =?iso-8859-1?Q?zHon4cmtBibd2FQW9THS2l3fI2tDELnTSij38D/x9te00PemWFDS34LUGn?=
 =?iso-8859-1?Q?YJWA2ERU1F9H0fjDoiSrhornGIBN1fOYRRYvNLBce+Zyl8t4Jrkjo5k/t5?=
 =?iso-8859-1?Q?+HR+TriheWr47Ah/n8UAIiQUY1SEFcuKzLEMMKrRKCtVp934uZL2IqUmzk?=
 =?iso-8859-1?Q?szVQ4Rf44T4bUwWKt0ig6+kINMK7xsuOa2TpnTbxDul4n0YP49SbHVacMO?=
 =?iso-8859-1?Q?E/6pDo8wsMfuz5z78MvzeZwKrsn7vClZLNqha0VMBIDLnwMZYEfoyD+Yn4?=
 =?iso-8859-1?Q?kvPwB3lQ9L6uxKvzJkEaBnqDvd+UTF7q37mvWu1ULSDo9o64dGSKHW9AjG?=
 =?iso-8859-1?Q?xDew/BGPVbKz3JWtyjxArEsGRzLwyLDxdCxHVGBRnchLbcgTNz54/I39la?=
 =?iso-8859-1?Q?bquWJL2HTZ5u89uppoWhvRUhRmUr8+3Hiy9NctOWPcd80E1xVOZrrgoX8i?=
 =?iso-8859-1?Q?EyZn7dsNriDqO+gsF8Y3yRqP/eHIzWhJ2jJlj3w3owOzbujYJul2y3XlE6?=
 =?iso-8859-1?Q?apMqtnJcB//W9a/d/Cm8f9kA8yPTbT51g1wQvoo4xMamdKbCNMMgaqXdX0?=
 =?iso-8859-1?Q?Zwhiu0UwpodwqTr66AP2E+RXNjNXom26XGu9SEOiIpJhzW1GG34XtwBe+F?=
 =?iso-8859-1?Q?Ts7AY6AB9wCGjpJTz5KQrU5cioHZ7ITbVvf7h0jnM1TO8Oju1s/m1oD8UJ?=
 =?iso-8859-1?Q?1Pp6LZBcp+OgnX6K/LTJsWDx8xeAgS1Rzqn6Ddd/ZzvF4rRfNQfSjFFiK4?=
 =?iso-8859-1?Q?Z8PCb7aeY1oRf7uYcUYi120KsONcpurbc0Q2RezfJULe60h+uVyDfiqBS1?=
 =?iso-8859-1?Q?XoLi8QrlRoaCgzWA70VGrQkkyUAN7fx9WPSXxsqTQtPfXrZl7vOjoStPM6?=
 =?iso-8859-1?Q?3B6PhcegFuk0FN23Rv9uzhWk3Gdgo1P6Q/+7xN9qoTf6SekQkwQjwvGGY4?=
 =?iso-8859-1?Q?d0DZMgvs5shc9qMndxSM2xzLW46NdeRLo2GuZuIZT0FVIJK60jL+Xso7GL?=
 =?iso-8859-1?Q?4On6mRAFJDBCisZX+66tTBKggjUVNYeVjaJWc2DCXsAHyPXhF/HFcVWJ21?=
 =?iso-8859-1?Q?K+J7Zwa+8EqQ2HX5keUp9OQQePH8C1LSMDD/6DGZG4IgHrzS1GKkHJXCzJ?=
 =?iso-8859-1?Q?1zFzJ1+z+W9KSr56t913CU33kFhDoQJ0lVRrkMKABVKO5pjvNQ6sqGF3AV?=
 =?iso-8859-1?Q?sekgqtqYy1UrXhsYCve1zGB4P4Sx6CBss9T+yB2I3RZC8i7N64515vK5cH?=
 =?iso-8859-1?Q?eQVz7aO8V97ap960Z79bX+/OuDPW84Bc/2qkIYYniZ1arQgL0sDWjy9rCP?=
 =?iso-8859-1?Q?zR9iaHTEpt8UzoO6Lkt16HqQSMrVXjl1t8IkM1xK8lt7gTJKQ3HPHm0T5t?=
 =?iso-8859-1?Q?kmMI+2Vj19cqoHbUhiNVglB7nn9aS0mfUfPlMUO6BLWOEI1VVKk4KnRxX2?=
 =?iso-8859-1?Q?UC6Lvtjvr7+bh86CoAZpQI4WRhSWBizC3c1N3htpb6GLZIU8hJk0ORifH4?=
 =?iso-8859-1?Q?3nmlEtoJqj9I/bszjUX4maZCJYchZsa2J2rpEosckDRfakiyAB/lLl5bVM?=
 =?iso-8859-1?Q?mYDLHlK8oiQmLeYG11b6HVg7lppfSw5E0pdB/cy4oN95Mi8E+YgMAdwIK0?=
 =?iso-8859-1?Q?2tOQysLU4wr1EXdF+I4RCIdFiNllDdD4cNGJ6yrSeh43IrxOmY5DavAcII?=
 =?iso-8859-1?Q?aGXNDO+Fjg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BeWpvcyuykgbAd0hI7IepepNproQsSLIxlllAs8qc9Z24GscX6WrwWB2JnvINZlG1gLcx9A5vpSMG+xyM9/hfsVZ3GWfB1wloONpwq8yHoh+lPSSKfALAE3I+UbMAOeLT/fAJfl8zlfJLbdIgsCfZrBDu7w/SL88/usrKDWiucWUhIFVMmTpZpCLIfkFT+gGo/pyswC9m+20PLRiOBoXvlCrfyhHZGJHmA7ev9EfZY8IICQYLsBuq8R9nWrrr/UFTn2h3g3WUtn1SHCAe6nojlhFyj61UQgZr2aGbU9tzs7i8ky1jzH7PbYU4Q8Te0FOwpJFiVOrXX5N+Td1txjqLg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc60844-b3a4-49ae-569e-08dea1d83c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:22.9342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUU/6DweLO7M6ukCkp7pBY1oeX5qVESBkR8DZVHzk9Pst9DlN6C5n1SYSvu9dYjRKT1bi0ytc4HgCTYK2+DBHFI/upY0UBzQJDVJef0Xphs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Introduce a new boolean property, "caps-64bit-addr", to control=0A=
HCCPARAMS[0] (64-bit Addressing Capability).=0A=
=0A=
When enabled, the EHCI controller advertises support for 64-bit=0A=
address memory pointers as defined in the EHCI specification=0A=
(Table 2-7, HCCPARAMS). This allows software to use the 64-bit=0A=
data structure formats described in Appendix B.=0A=
=0A=
When disabled (default), the controller reports 32-bit addressing=0A=
capability and uses the standard 32-bit data structures.=0A=
=0A=
The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to=
=0A=
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0=0A=
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit=0A=
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads=0A=
must return zero.=0A=
=0A=
Add a capability check in the operational register write handler and=0A=
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is=0A=
not enabled.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  5 ++++-=0A=
 hw/usb/hcd-ehci.c | 14 +++++++++++++-=0A=
 2 files changed, 17 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3acbddfc5c..f1f2fde578 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -257,6 +257,7 @@ struct EHCIState {=0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
     bool migrate_fetch_addr_64bit;=0A=
+    bool caps_64bit_addr;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -313,7 +314,9 @@ struct EHCIState {=0A=
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
     DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
-                     ehci.migrate_fetch_addr_64bit, true)=0A=
+                     ehci.migrate_fetch_addr_64bit, true), \=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
+                     ehci.caps_64bit_addr, false)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 0c8bdb48ad..b23ff92e12 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1109,6 +1109,15 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
         }=0A=
         break;=0A=
 =0A=
+    case CTRLDSSEGMENT:=0A=
+        if (!s->caps_64bit_addr) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "ehci: write to CTRLDSSEGMENT while "=0A=
+                          "      64-bit addressing capability is disabled\=
n");=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
+=0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -2554,6 +2563,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
 Error **errp)=0A=
                    s->maxframes);=0A=
         return;=0A=
     }=0A=
+    if (s->caps_64bit_addr) {=0A=
+        s->caps[0x08] |=3D BIT(0);=0A=
+    }=0A=
 =0A=
     memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);=0A=
     memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);=0A=
@@ -2613,7 +2625,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)=0A=
     s->caps[0x05] =3D 0x00;        /* No companion ports at present */=0A=
     s->caps[0x06] =3D 0x00;=0A=
     s->caps[0x07] =3D 0x00;=0A=
-    s->caps[0x08] =3D 0x80;        /* We can cache whole frame, no 64-bit =
*/=0A=
+    s->caps[0x08] =3D 0x80;        /* We can cache whole frame */=0A=
     s->caps[0x0a] =3D 0x00;=0A=
     s->caps[0x0b] =3D 0x00;=0A=
 =0A=
-- =0A=
2.43.0=0A=

