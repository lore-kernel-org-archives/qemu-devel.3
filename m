Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7997BFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBY2-0005Li-CU; Fri, 24 Apr 2026 04:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXc-00050m-Oz; Fri, 24 Apr 2026 04:05:37 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXZ-0001I1-QF; Fri, 24 Apr 2026 04:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb5xlbvTLIjM+oBl33teAcl7LsV4mTMIOyvZqPSvjd0hCy/rA52BUJTrgq1F8Dq43EauajC10uOiGxqAjlBWLKbb78SRmFBLaTI18mgtBU/tGlrTdw/tOZ914u9h75WwcU0IcpPxy+LY9Zcdeg+falWzUODBdjwDrhk/oT81etJKe6oGRQ9kBwc9DWH7tadWhz11ngnJkvIdhmdLjHqEiaj07qSlarEMdVs2hs6tF8L6+kCUdO10H3Fg+YRO06pqAwUjtJBF6KfyFnpk5KDKp4eVdpwy2mFFeLnvoK/McwZkk80K6RYmnT11N5m/EzoWnGjjfWIxjQ2FJbLJX/vquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFOELu8oTQ/WwEAUGoYbARJdiQvzMwqAzJ6SrDyqixc=;
 b=lyQ6zjmooE5SeRUnrmgc7YYWPUiO65xzZ2ZdRimUSxmm42q0tsyHW/hm7wQ5ifrnE+LKTpSFx2eUcChKqzXsstbUHkMW3ElJnXaUXGEAHRTIxF4ARAv/S+dfZoQnUvCEXAr+mHMVrn9xBz1a9apjPGgoIIoKu85NhIFSRBMol3IV0Z1VuyKVcfCaN4ksF2raFUGqdo3k+1V8f3qXlD63+l74TXtVulMo3yLVtkBTepzEyHeRz5qvn+wNQllKz9XBm8ZsuS5yO8I/rsHsMsUGyU9+uC5DAm+hGab9oryjMA338Fyxh4zaQODZ4FDTwuVOUKGjoVWR29DWhKwYsxaDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFOELu8oTQ/WwEAUGoYbARJdiQvzMwqAzJ6SrDyqixc=;
 b=qxRi3CCZaiiDI5blCTOQYrDVY281yGL8oS5VgMu7nkVSBljWkNpP+exKIPCtdX8r+nk6oCRe7xnCvj1X3WpPUYNva9+sRpzy7fh8X4akxY28IlVEGJFhOZOJGDYoEHIJAul1jcWif9cn4DAFWoZChmSwkb8U5M7dh1a1OXYHGuBhLggYJs7Ofb/14db6xn7OSE+DPZUYsTQ1cLEADMNEc0+ZfUt/7b3A98jTXPsBlKpRxCJ6BKFNZ0OIIm50wr0xx17j2cBHF28zHZtpmAzNPyQur9sVeF6gKko3w7dKsTdU+srd8pvVQ9Cxs+vNeDOinDpdZGPvPvHuwKJqSCiEEQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:sPAPR pseries"
 <qemu-ppc@nongnu.org>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 09/18] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Thread-Topic: [PATCH v5 09/18] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Thread-Index: AQHc08EYYUN1mfu+bEu2EU/IZp57Og==
Date: Fri, 24 Apr 2026 08:05:21 +0000
Message-ID: <20260424080508.53992-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: d7861b86-ac9d-4b9c-f033-08dea1d83c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: eddfnbZB1M7fReIKDbNsualXjZMoxM9owUai6/1P3puOAbquECj988JLXraj91EAG9DuITD4wnr6yxSJEjocziNFLi+LngY85FL1UWfbvaujbGoLnWbuEKl0WUAotdp3N6rE2R1eUVcS6+3C53Y/3S3t9pH25P8cg+Qecj9QACsVlwd6CtL8jVbdJVzjhzlhBoNn1YAKih2AhRSZeu5aKWNIFdR8T4DIN3iM/0PC6yuIUa5YEpM1THKgSwlySZZ401i6+Bw0VZx6cFgNoxScmHdP5FR66X6TtFkE5nVQbc2kR64C6zD2ORel2/2fZ67jFw4uqZTG4BS3b+yyWM7tgYP5linkPiJSxjP6oLJhkaQi2FAXJ4ULcx5lXPFusbvT/rTjxMjYvgYHciJYPuoeNkSf0kZmLy4BP4d9uvfNUWy+clp6n304r91G9f/VPAtj8kF5v3daLc1KSH/N/AyHBS6WVINr8t62wSUJxVITK2e2kiQp/0Q9tGp7pbKzbMag7t05jJNxSXA5HC7dDc7ivpzt14g2Jk1Fa1puJy2DmpbjWu2rcX62fAWXSbG3sPRdyuZtvmJR0DZdMJYEykQKa5rev3KyJJpo0Uv46SI+V4AXHeEvj8qmIfI3JwshqCmAV4lq7wUoNn7kxbjneDSrHjU+tLWgtO4cwmjus7s918LXjXAavtT9wDjTWto6uCwGCV32mVK3JSsPv51K/iWQb4pMlYLte8CWJZ4Aat+8kZcwdVjFmvCZ4q0Bl2MrWqopt8ie6++QqdK9nNqbOGrZyHPJ+MdnpTGdjoRIVv/X2HqH/OIJqZr6IdpGGctoZJTX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xl4Oz71naSENqBicsqC+tgEAoxCdymi+nqG4pUeJoRJBG3qOcaAwL3CJx4?=
 =?iso-8859-1?Q?rv9b7eN50UbPwvXwCN7Dih0Zf71y9+DCferOMMaEihvz3JZeYyoF7owdDo?=
 =?iso-8859-1?Q?h3gV4OyHNIrBTDqrf/ReGhtLbFol0kIsVhSPtKJ5H/nLzZXbd2sOML+UH+?=
 =?iso-8859-1?Q?U4R0UCeSPmL0EgU7tXaz1ik18bFvrHJjHMWkUYwgPK9BVoZHj6puCNoIYU?=
 =?iso-8859-1?Q?sYak0QuQ/HW14nyHzqxjpUqwqa7LGkOYau4ls8WjBPf7XpiAEfLYQfMUsW?=
 =?iso-8859-1?Q?YEiteXqfNLo6u6rgEuFBjfSgi1ntQ392hU8kCtqPf8R+JO71tfYXRjN7kF?=
 =?iso-8859-1?Q?NBksez0RSSioCMMBDghcfuot6UTPcOksbthiYefKns98uLVRKQd9gVDuIu?=
 =?iso-8859-1?Q?Hv5x2rSilqmzmG5Tj2YRvm7Qe3+BUkgkCUCbh6aE2J+TDsqrrOo9ONzeVX?=
 =?iso-8859-1?Q?VNg/wcRIr2dSnA1ZqAre7dPg/bA6P8rhqDMbtLW0CtSj8z9UAXl9nVCA/6?=
 =?iso-8859-1?Q?doINfT685Za0r7NkgVpQtsHeBnGLBBGM6sv7e3wi4M0Di63AcljjZQ110g?=
 =?iso-8859-1?Q?Hzuo5RgX1oFbAiLPu1peNd9p2UUx8IMXfbTi09YD0uncWXONHxhkTbkGS1?=
 =?iso-8859-1?Q?f4MoYYIpCuRsTUgYiCIGsevm2V1J7WxLv3A6vAyc6mjF9fydPFilSGk5Tr?=
 =?iso-8859-1?Q?CTnDczoFyZT0gmzor6vd9Z/Y4U//Mf5tjLMYXOLajPr+VPLjujgREt/+7M?=
 =?iso-8859-1?Q?1iLupIy52zSWbPdp9+Rk5gMRYP3cNFzDmcXj4LyTJGMErrTWl+PSnKW6H+?=
 =?iso-8859-1?Q?luR0mMV0htVxEiPlticVnyOpSSkPCgalRFXdzmDuDA7DiLXxMaAjsWZG37?=
 =?iso-8859-1?Q?RRmZ91xWot4WjUn6IFIYO/3C7rEL6ldflZwzRE5MWeeS3ZVAGY+Qv2gfeD?=
 =?iso-8859-1?Q?2Vsz6biknRD8/ZQwyjmFBBrKwWYUGPcl0ojOlRGiIfMnhqsJl/f5+IdvOL?=
 =?iso-8859-1?Q?I1DnSGfSKhHxkomZyja5XKs3h6sT5CoHMWjtA0qEY6jWQD8ntJMIrPmA3i?=
 =?iso-8859-1?Q?0fqTX2ArbLaiFqRS5lO1y7arr/Ztt4zYVsqcNj4VqbsceLNjPw/QDb/2IH?=
 =?iso-8859-1?Q?qkewYnNQQl4VrMXfK/sGREeKwGk7BUDcLLzrXHQB1S40b7QzbczYmi5WBa?=
 =?iso-8859-1?Q?RgklHhL0yQMoQWGkTiaYNJ5lmIc3tD8ElqvscCc8UvEqLMtgqfvr/PZ5JT?=
 =?iso-8859-1?Q?KO4TYqvDc6gDfGxurskR2/JEWWbzH4UwnflCkjYJAQYwxQAnyVKPKBrDJe?=
 =?iso-8859-1?Q?M7/u8w4gWxHTBTp7zeSUrPXSzgA7zIalQuDh0T66j9sm0sUxeoEhvgNLIV?=
 =?iso-8859-1?Q?O6AxiceAveG1O76iEiYt+dLAjhTDBlw4rUnQdo/w9++vUvHqBbK8GswiqR?=
 =?iso-8859-1?Q?xp8m1QNkDlLFT3exzjXB4AbfF4u4h3bryN9tODZtLf+8AuM2Vd0C1RsjvP?=
 =?iso-8859-1?Q?BoASoMfEHqWXKXngbVC/flZdr/TVAsPAAdGwsHwxyW6gsEm1NlexR0CoBc?=
 =?iso-8859-1?Q?8oh3zZWhkHahYK1sqQErpfRxGotI+WiwYWrDHbW2qAtCbxPou2v0gxpeGi?=
 =?iso-8859-1?Q?SrH6UcusJlkcEQhuHCGBRuFf2gooi48TJttC/X4yHR0sWETpKe5q1RmNkg?=
 =?iso-8859-1?Q?6P5fXw7hFqxuxDaDsAb4XS4ubij+5yJUpeKMoZzmqhmziFV/rnQd48DILw?=
 =?iso-8859-1?Q?AuSD97usYsBKquzjPbF8zudMB3Te+cIff2VowFehie7rNMNZ5r3dVFXhAu?=
 =?iso-8859-1?Q?uNogED7+9Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HT56WYCQ/7/4Sp9fe0f05If2J4IwasV9K/GZn4xc5oWCZx2XznYo6qHU/zzf5KuRHnt+K6aRsL9jzrHHRYKyqda3c7Gr3+72UrnvOKcan9ukIWhLz741lkJPWS6+GyK0MxoWaVhRZSKrZ47tyi0o+N78Ltkpi0AwB6xtytFgQgW6FLvhWJFb2mmZI2d9Yi4ThNtusMsLEFZCf9XTiWoQPVd5et4CLGz7njaLE9ZRZzWE1/49JLNOCjGBntTplXePA7kGSBslmDQxysMXHfq0E4hbx57PYRIvmDFw2rw7LGtvuz1HlRRsbsQ6rykPKXKWN4IczK59c1jqTqIT5Q3J6A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7861b86-ac9d-4b9c-f033-08dea1d83c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:21.5197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1RWgsECpuPpMEmy2PRd+UsY7nqMVTkJkUYK1PpUFBKoXkxrN56vXatPyqnAQ3jVQJE2yK5anpTak6A9sS7XhbsqaRaGOxNzywNkP2YipjE=
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

Change internal EHCI descriptor addresses from uint32_t to uint64_t.=0A=
=0A=
The following fields are updated:=0A=
- EHCIPacket::qtdaddr=0A=
- EHCIQueue::{qhaddr, qtdaddr}=0A=
- EHCIState::{a_fetch_addr, p_fetch_addr}=0A=
=0A=
Update get_dwords() and put_dwords() to take 64-bit addresses and=0A=
propagate the type change through the descriptor traversal paths.=0A=
=0A=
Adjust NLPTR_GET() to operate on 64-bit values:=0A=
=0A=
    #define NLPTR_GET(x) ((x) & ~0x1fULL)=0A=
=0A=
so that link pointer masking works correctly when descriptor=0A=
addresses exceed 32-bit space. The previous mask (0xffffffe0)=0A=
implicitly truncated addresses to 32 bits.=0A=
=0A=
This patch does not change the on-wire descriptor layout yet.=0A=
It only removes the internal 32-bit address limit and prepares=0A=
for later patches that will add full 64-bit QH/qTD/iTD/siTD support.=0A=
=0A=
Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to=0A=
use uint64_t for the address argument and print it with PRIx64. This=0A=
ensures full 64-bit addresses are shown in trace output and improves=0A=
debugging of queue heads and transfer descriptors.=0A=
=0A=
Migration compatibility:=0A=
=0A=
To preserve backward migration compatibility, keep the legacy 32-bit=0A=
fetch address fields (a_fetch_addr_32, p_fetch_addr_32) alongside the=0A=
new 64-bit fields.=0A=
=0A=
Migration format is selected using a machine compat property=0A=
"x-migrate-fetch-addr-64bit":=0A=
=0A=
- Old machine types migrate 32-bit fetch addresses=0A=
- New machine types migrate full 64-bit fetch addresses=0A=
=0A=
This is implemented using VMSTATE_UINT32_TEST() and=0A=
VMSTATE_UINT64_TEST() so that only the appropriate format is migrated.=0A=
=0A=
In pre_save, the 32-bit shadow fields are populated when migrating=0A=
to old machine types. In post_load, the 32-bit values are restored=0A=
into the 64-bit fields when loading old migration streams.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   | 17 +++++++----=0A=
 hw/core/machine.c   |  5 +++-=0A=
 hw/usb/hcd-ehci.c   | 72 ++++++++++++++++++++++++++++++++-------------=0A=
 hw/usb/trace-events | 24 +++++++--------=0A=
 4 files changed, 78 insertions(+), 40 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index d038ee1e31..3acbddfc5c 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -208,7 +208,7 @@ struct EHCIPacket {=0A=
     QTAILQ_ENTRY(EHCIPacket) next;=0A=
 =0A=
     EHCIqtd qtd;           /* copy of current QTD (being worked on) */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                 */=0A=
 =0A=
     USBPacket packet;=0A=
     QEMUSGList sgl;=0A=
@@ -229,8 +229,8 @@ struct EHCIQueue {=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
-    uint32_t qhaddr;       /* address QH read from                 */=0A=
-    uint32_t qtdaddr;      /* address QTD read from                */=0A=
+    uint64_t qhaddr;       /* address QH read from                 */=0A=
+    uint64_t qtdaddr;      /* address QTD read from                */=0A=
     int last_pid;          /* pid of last packet executed          */=0A=
     USBDevice *dev;=0A=
     QTAILQ_HEAD(, EHCIPacket) packets;=0A=
@@ -256,6 +256,7 @@ struct EHCIState {=0A=
 =0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
+    bool migrate_fetch_addr_64bit;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -294,8 +295,10 @@ struct EHCIState {=0A=
     EHCIQueueHead pqueues;=0A=
 =0A=
     /* which address to look at next */=0A=
-    uint32_t a_fetch_addr;=0A=
-    uint32_t p_fetch_addr;=0A=
+    uint32_t a_fetch_addr_32;=0A=
+    uint32_t p_fetch_addr_32;=0A=
+    uint64_t a_fetch_addr;=0A=
+    uint64_t p_fetch_addr;=0A=
 =0A=
     USBPacket ipacket;=0A=
     QEMUSGList isgl;=0A=
@@ -308,7 +311,9 @@ struct EHCIState {=0A=
 };=0A=
 =0A=
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
-    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)=0A=
+    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \=0A=
+    DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
+                     ehci.migrate_fetch_addr_64bit, true)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 1abc8ae737..b0c1580b16 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -38,7 +38,10 @@=0A=
 #include "hw/acpi/generic_event_device.h"=0A=
 #include "qemu/audio.h"=0A=
 =0A=
-GlobalProperty hw_compat_11_0[] =3D {};=0A=
+GlobalProperty hw_compat_11_0[] =3D {=0A=
+    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+};=0A=
 const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0);=0A=
 =0A=
 GlobalProperty hw_compat_10_2[] =3D {=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 28a60e4c1a..0c8bdb48ad 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -72,7 +72,7 @@ typedef enum {=0A=
 } EHCI_STATES;=0A=
 =0A=
 /* macros for accessing fields within next link pointer entry */=0A=
-#define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
+#define NLPTR_GET(x)             ((x) & ~0x1fULL)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
 #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
@@ -287,7 +287,7 @@ static int ehci_get_state(EHCIState *s, int async)=0A=
     return async ? s->astate : s->pstate;=0A=
 }=0A=
 =0A=
-static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)=0A=
+static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)=0A=
 {=0A=
     if (async) {=0A=
         s->a_fetch_addr =3D addr;=0A=
@@ -296,7 +296,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async=
, uint32_t addr)=0A=
     }=0A=
 }=0A=
 =0A=
-static int ehci_get_fetch_addr(EHCIState *s, int async)=0A=
+static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)=0A=
 {=0A=
     return async ? s->a_fetch_addr : s->p_fetch_addr;=0A=
 }=0A=
@@ -373,7 +373,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)=
=0A=
 }=0A=
 =0A=
 /* Get an array of dwords from main memory */=0A=
-static inline int get_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int get_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -395,7 +395,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t =
addr,=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
-static inline int put_dwords(EHCIState *ehci, uint32_t addr,=0A=
+static inline int put_dwords(EHCIState *ehci, uint64_t addr,=0A=
                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
@@ -549,7 +549,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
 =0A=
 /* queue management */=0A=
 =0A=
-static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint32_t addr, int asy=
nc)=0A=
+static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint64_t addr, int asy=
nc)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
     EHCIQueue *q;=0A=
@@ -622,7 +622,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *w=
arn)=0A=
     g_free(q);=0A=
 }=0A=
 =0A=
-static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,=0A=
+static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,=0A=
                                         int async)=0A=
 {=0A=
     EHCIQueueHead *head =3D async ? &ehci->aqueues : &ehci->pqueues;=0A=
@@ -1135,7 +1135,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
 {=0A=
     uint32_t *qh =3D (uint32_t *) &q->qh;=0A=
     uint32_t dwords =3D sizeof(EHCIqh) >> 2;=0A=
-    uint32_t addr =3D NLPTR_GET(q->qhaddr);=0A=
+    uint64_t addr =3D NLPTR_GET(q->qhaddr);=0A=
 =0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
@@ -1406,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *=
action)=0A=
 /* 4.7.2 */=0A=
 static int ehci_process_itd(EHCIState *ehci,=0A=
                             EHCIitd *itd,=0A=
-                            uint32_t addr)=0A=
+                            uint64_t addr)=0A=
 {=0A=
     USBDevice *dev;=0A=
     USBEndpoint *ep;=0A=
     uint32_t i, len, pid, dir, devaddr, endp;=0A=
-    uint32_t pg, off, ptr1, ptr2, max, mult;=0A=
+    uint32_t pg, off, max, mult;=0A=
+    uint64_t ptr1, ptr2;=0A=
 =0A=
     ehci->periodic_sched_active =3D PERIODIC_ACTIVE;=0A=
 =0A=
@@ -1528,7 +1529,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D ehci->asynclistaddr;=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1578,7 +1579,7 @@ out:=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
     int again =3D 0;=0A=
-    uint32_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
+    uint64_t entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
     if (NLPTR_TBIT(entry)) {=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
@@ -1611,7 +1612,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "FETCHENTRY: entry at 0x%x is of type %u "=0A=
+                      "FETCHENTRY: entry at %" PRIx64 "is of type %" PRIu6=
4=0A=
                       "which is not supported yet\n",=0A=
                       entry, NLPTR_TYPE_GET(entry));=0A=
         return -1;=0A=
@@ -1623,7 +1624,7 @@ out:=0A=
 =0A=
 static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIQueue *q;=0A=
     EHCIqh qh;=0A=
 =0A=
@@ -1712,7 +1713,7 @@ out:=0A=
 =0A=
 static int ehci_state_fetchitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIitd itd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1738,7 +1739,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
 static int ehci_state_fetchsitd(EHCIState *ehci, int async)=0A=
 {=0A=
-    uint32_t entry;=0A=
+    uint64_t entry;=0A=
     EHCIsitd sitd;=0A=
 =0A=
     assert(!async);=0A=
@@ -1802,7 +1803,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     EHCIqtd qtd;=0A=
     EHCIPacket *p;=0A=
     int again =3D 1;=0A=
-    uint32_t addr;=0A=
+    uint64_t addr;=0A=
 =0A=
     addr =3D NLPTR_GET(q->qtdaddr);=0A=
     if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {=0A=
@@ -1885,7 +1886,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
     USBEndpoint *ep =3D p->packet.ep;=0A=
     EHCIQueue *q =3D p->queue;=0A=
     EHCIqtd qtd =3D p->qtd;=0A=
-    uint32_t qtdaddr;=0A=
+    uint64_t qtdaddr;=0A=
 =0A=
     for (;;) {=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
@@ -2008,7 +2009,8 @@ static int ehci_state_executing(EHCIQueue *q)=0A=
 static int ehci_state_writeback(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
-    uint32_t *qtd, addr;=0A=
+    uint32_t *qtd;=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
     /*  Write back the QTD from the QH area */=0A=
@@ -2414,6 +2416,18 @@ static USBBusOps ehci_bus_ops_standalone =3D {=0A=
     .wakeup_endpoint =3D ehci_wakeup_endpoint,=0A=
 };=0A=
 =0A=
+static bool ehci_fetch_addr_64_needed(void *opaque, int version_id)=0A=
+{=0A=
+    EHCIState *s =3D opaque;=0A=
+=0A=
+    return s->migrate_fetch_addr_64bit;=0A=
+}=0A=
+=0A=
+static bool ehci_fetch_addr_32_needed(void *opaque, int version_id)=0A=
+{=0A=
+    return !ehci_fetch_addr_64_needed(opaque, version_id);=0A=
+}=0A=
+=0A=
 static int usb_ehci_pre_save(void *opaque)=0A=
 {=0A=
     EHCIState *ehci =3D opaque;=0A=
@@ -2424,6 +2438,11 @@ static int usb_ehci_pre_save(void *opaque)=0A=
     ehci->last_run_ns -=3D (ehci->frindex - new_frindex) * UFRAME_TIMER_NS=
;=0A=
     ehci->frindex =3D new_frindex;=0A=
 =0A=
+    if (!ehci->migrate_fetch_addr_64bit) {=0A=
+        ehci->a_fetch_addr_32 =3D ehci->a_fetch_addr;=0A=
+        ehci->p_fetch_addr_32 =3D ehci->p_fetch_addr;=0A=
+    }=0A=
+=0A=
     return 0;=0A=
 }=0A=
 =0A=
@@ -2444,6 +2463,11 @@ static int usb_ehci_post_load(void *opaque, int vers=
ion_id)=0A=
         }=0A=
     }=0A=
 =0A=
+    if (!s->migrate_fetch_addr_64bit) {=0A=
+        s->a_fetch_addr =3D s->a_fetch_addr_32;=0A=
+        s->p_fetch_addr =3D s->p_fetch_addr_32;=0A=
+    }=0A=
+=0A=
     return 0;=0A=
 }=0A=
 =0A=
@@ -2504,8 +2528,14 @@ const VMStateDescription vmstate_ehci =3D {=0A=
         /* schedule state */=0A=
         VMSTATE_UINT32(astate, EHCIState),=0A=
         VMSTATE_UINT32(pstate, EHCIState),=0A=
-        VMSTATE_UINT32(a_fetch_addr, EHCIState),=0A=
-        VMSTATE_UINT32(p_fetch_addr, EHCIState),=0A=
+        VMSTATE_UINT32_TEST(a_fetch_addr_32, EHCIState,=0A=
+                            ehci_fetch_addr_32_needed),=0A=
+        VMSTATE_UINT32_TEST(p_fetch_addr_32, EHCIState,=0A=
+                            ehci_fetch_addr_32_needed),=0A=
+        VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,=0A=
+                            ehci_fetch_addr_64_needed),=0A=
+        VMSTATE_UINT64_TEST(p_fetch_addr, EHCIState,=0A=
+                            ehci_fetch_addr_64_needed),=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 0d4318dcf1..8c90688bb3 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -86,15 +86,15 @@ usb_ehci_portsc_write(uint32_t addr, uint32_t port, uin=
t32_t val) "wr mmio 0x%04=0A=
 usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_=
t old) "ch mmio 0x%04x [port %d] =3D 0x%x (old: 0x%x)"=0A=
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"=0A=
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"=
=0A=
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qh_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%" PRIx64 ": next 0x%08x qtds 0=
x%08x,0x%08x,0x%08x"=0A=
+usb_ehci_qh_fields(uint64_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%" PRIx64 " - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
+usb_ehci_qh_bits(uint64_t addr, int c, int h, int dtc, int i) "QH @ 0x%" P=
RIx64 " - c %d, h %d, dtc %d, i %d"=0A=
 usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"=0A=
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %=
d, ep %d, dev %d"=0A=
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x:=
 next 0x%08x - active %d"=0A=
+usb_ehci_qtd_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%" PRIx64 ": next 0x%08x altnext 0x%08x"=0A=
+usb_ehci_qtd_fields(uint64_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%" PRIx64 " - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
+usb_ehci_qtd_bits(uint64_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%" PRIx64 " - ioc %d, active %d, halt %d, babble %d=
, xacterr %d"=0A=
+usb_ehci_itd(uint64_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%" PRIx64 ": next 0x%08x - mplen %d,=
 mult %d, ep %d, dev %d"=0A=
+usb_ehci_sitd(uint64_t addr, uint32_t nxt, uint32_t active) "SITD @ 0x%" P=
RIx64 ": next 0x%08x - active %d"=0A=
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device)=
 "attach port #%d, owner %s, device %s"=0A=
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, o=
wner %s"=0A=
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"=0A=
@@ -104,15 +104,15 @@ usb_ehci_port_resume(uint32_t port) "port #%d"=0A=
 usb_ehci_port_disable(uint32_t port) "port #%d"=0A=
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"=0A=
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %=
s"=0A=
-usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%x, ne=
xt=3D0x%x, qtd=3D0x%x, pid=3D0x%x, len=3D%zd, endp=3D0x%x, status=3D%d, act=
ual_length=3D%d"=0A=
+usb_ehci_packet_submit(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%" PRI=
x64 ", next=3D0x%x, qtd=3D0x%" PRIx64 ", pid=3D0x%x, len=3D%zd, endp=3D0x%x=
, status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask=
) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"=0A=
 usb_ehci_guest_bug(const char *reason) "%s"=0A=
 usb_ehci_doorbell_ring(void) ""=0A=
 usb_ehci_doorbell_ack(void) ""=0A=
 usb_ehci_dma_error(void) ""=0A=
-usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%x, next=3D0x%x, qtdaddr=3D0x%=
x, status=3D%d, actual_length=3D%d"=0A=
-usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, recla=
mation status reset - done processing"=0A=
-usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08=
x"=0A=
+usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
+usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
+usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
 usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
-- =0A=
2.43.0=0A=

