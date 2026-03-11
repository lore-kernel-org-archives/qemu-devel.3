Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FACFD0644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dyp-0003vo-BJ; Wed, 11 Mar 2026 03:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxo-00031k-7q; Wed, 11 Mar 2026 03:26:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxm-00052E-6H; Wed, 11 Mar 2026 03:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiO/m6wt313HHMGKRfjie5EwXH/FRJfL9Mt6QVdJGA/fIL27xfGBoZmDoSCBWlJvvhCNY585qe0VQiZtHWoOI0OIebDGsuRjVxuIRBgqwHuqIj6vwOPNUV8msul3kUTbooku14UV2YgbI23UyqqsXFOctYLU3MevoQXh35/Jp3PEnUNDqs+IwBbYV/aj81lETLYzxVJ1Y3et+rbSgi0mlmv0ossvA4C1OFQPvbTC47f3HXC/5ZmC7BX2KGAhEPoSHX9gMs4WpqZyPew4q+H0o0lU85PClo6oxPEpXoCdlIkfdIPgBqdWuCHJ0xslrhxX3d7xI9LgTGiIi1Yq/xfQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6FY/tDF0ifIB3DvrNWxZVPFw+9/Lcgex2hiIADFYSI=;
 b=hrgxbP/Of79lDEbYXRdI6Rav1x8JvxXfE/T3vsJU3GFUXBSuQ/nuL1Z6zX6o5hjEMMo7vC6xQ7JWlSiKSA+lI9idL0iMmlXGKWtfEO/gJuIkNLCPWkPjgUKsPAYf+dQpF3iWriFM2dmGQ+22336HEGyVFZv8n07V63anaoQeqsLEu6X2TteCvMxFEww9/mQzDujVD4f9FoudMZIah9dzu7AvIJ5p7ecKZnOkPv/lhYX5JoBKdqHfE7OLII8Yq02xugz7989ChbNfWa/IXUfLhFDFR79xLOQpek0B3erJDCNmpQrg5TP6WO+6RTOyCMFMrfhKfWy2yQex/haHeZwOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6FY/tDF0ifIB3DvrNWxZVPFw+9/Lcgex2hiIADFYSI=;
 b=pXRjlYRSmPxqMBZMjDcI4N7vlVLlQlEu8v0jG5geQ1Ho6nk1dDuV+K5OwRaEtYz7sDgtTXSAZO5hfgc7IWBh9kbpW6n+OgUSEgUTgSsSQAOkF5qFF/hgFzi/a5+k+hZEVcgWQ3/T9NYe0mpYR83qWRm7dN6ETuo1wNdnbZ447ZDof0pxJzc7eX24UjcwUagT2PdlJfbPrejbgWUi1eVR2e9FE3vyyHvsGkz/FFpszyOHdndCb/UGfkJZ+DM+p1rNFZp2nQm2Ug5sfZGcv+vFA4hsRH8lvP6FKAlJuoK+Vp5xuu2eH/sgZ7pO3JXlwsPNv6jwJVScZjPzfaXvff90zg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 05/13] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v1 05/13] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHcsShcgT5EU12HfkqR/CpqCddQAA==
Date: Wed, 11 Mar 2026 07:26:21 +0000
Message-ID: <20260311072614.1095587-6-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: 070550ac-8fff-4b95-cf6d-08de7f3f7eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: spZaI4+Genl/mxQfhthN3YHFwKGzd0ZcSpCJVonUhzCWwgeHBriF4ngvNzzSLuMdvswOW3iPUQ9Z6wCvxMNaBVZ+yOLKyIHwmP0InGYT+OyPcmJM5uBCkcPdRYZ1ffwcDCyfzaquBFZQMh1w86pag0XeiP/dEDLv/XmmbN+FiVQb1+r+gvBq4U4yxGLkRElP6Tl0ya36J/HcicSpEG9XTwZT7ZRL7UygVK6AJRvgxgE6kKr3JnnBMedYsSmlvzAk6EUSgJafXqOxiouXxgkVup233Eg90AfBas9xfEjF/JRUienRGJEdUhjpEyA5Tf+piI1VoNfxX+wNXTrMPAOIWmE8eP95mIwiygzmWRjTBL57zAPz9xsDbq3d98i7ztn9GKxMzdTn4wAgxYraqI8lbT92oRJb0+VmMDmuQZQbPgyYV8cUr2306iQUyXFhmrMY9YvY3rVeyfFLtVN1VkRD5Czbw0aX0gTuXazF1PGMabdQ32HMuNrzad692JV5knWshCK27hd2wwRnrXQLdBITMp7QCEygPhDw0FYrMA1xdiKRs6FCs/SdM6/WeUcEU04uakCQrzK71LueLKhAYpkOfOUq5dtAFCS+rV1bDgnWWtTvj7ypfKXIwJ7S3HGCzJP8bnJnnPXRwQW1sKixYKADNFm8j1TD0P+p/H4FQtRUu5lyOJrAL9JCg68BjfNjpq/6F+faYfsYyt851vyQJ/ujRJEHf+uQWGrD6YFeps55ZaxE4i3WPjv/TSHezIRB1OSbGhimv2qK/tE8hiqHVifA9zWB+RobCI31yhLTI5krOlc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BIS2E/uUJvRLAw5FlZkGH+P2PP1LqfnAvgcnm1FuO7O++OIyJe96IuPfCx?=
 =?iso-8859-1?Q?SUy2pKsdKfGym+V8FH7vsKu2grY3tFRTwKOo8/CS4BO7EtI49Ir5rqgwTl?=
 =?iso-8859-1?Q?NSEqwloN6WCAq0EEjlaNu+QOLJ3E9qGj8ovG2q88HnIuZ8dgpCE7e/atQG?=
 =?iso-8859-1?Q?vdwBG1j5+BaIFUcqSQCMwRzlEdxG4w2+Mgnz+JVqmu3rH6Rreb++Xm9jwU?=
 =?iso-8859-1?Q?2I/mdtz1cWC79/9Z18M7TRdL6LnHo8UCeKO7TUFcLhHI7TI2iMyKE+tN24?=
 =?iso-8859-1?Q?bG6kwVsVI6mmjDwZXwDEQ2mywywFl7mGHV4YoDhLubqHh5O6XKC/VMmGCA?=
 =?iso-8859-1?Q?EaxBzGcCxhtE+hbnayvfR6s2fsyTq5PIwh7c9kJ1DueAeIfKxOuMfKo0Qv?=
 =?iso-8859-1?Q?4ULypc/z4aQpclxjeZs2Qk1xqCdkbLsF+QWdJEGCBLk+0NvWoNNZKgV4cn?=
 =?iso-8859-1?Q?dNdvvc7rTQ4CCmMN3Piz7JriZWvgz0KWKAaywpTnmjZbL5QA4yZz2eDhQi?=
 =?iso-8859-1?Q?X275TU29auuNhSmLQV+Ishz0JsgdP1RVrYCoiPhQv1XobjgY+M3TY2ldfu?=
 =?iso-8859-1?Q?jOuF3zzC4SsaGRGKovRe/Cg2f3qfdOIQqbrkYjjU7YY1dLAVsnJa59Nu7C?=
 =?iso-8859-1?Q?OP16yROQJ0Ay0ps5nlQmXiOH7SF2NtE35q7qlhpG2uLUwa3yEVUPZtQuRJ?=
 =?iso-8859-1?Q?DOckGgABkSSS38Bt79wWfXgDZ0KigjlmM87zWQtqPrLDh4lMumAEoj3Lm1?=
 =?iso-8859-1?Q?q6/RA5/mxc2HP0/KIII2Y/i+A/N4qZBF8Ts09v0RCbkroMGrLhORecjAVm?=
 =?iso-8859-1?Q?y7woUb6pFLG33VQi+7ebe7sEYyma/2h7qN3ZzjB0yRHfvHMPSJW/OCOdNc?=
 =?iso-8859-1?Q?iecn7/BPhlqgoKZqX0kUqfkt0OmyjUIeYTpi3vgNtrBkFqfSLvBdwTAock?=
 =?iso-8859-1?Q?Uz2kfqMGjhDzpb+1cPkOw0KzSlxFdxhR2VEA/HpvTCBmsztjrbYVDq1W9z?=
 =?iso-8859-1?Q?z9XmjavJIY5z2xDdaaA56eBSCFHePQnw3RSOsBm+dHlsbQ9zNdwxvpJq8U?=
 =?iso-8859-1?Q?TaBnmZuID37gpjXCu1dPzFWNgaPVjv01fpISY23CXgXkF+zoWD93UneD8H?=
 =?iso-8859-1?Q?sfGhk8ADjCOUqfCraTq2jz6HWgK3cDvyK52D2OVOjy5V1st8n/DzLxPg1V?=
 =?iso-8859-1?Q?gAyewiQ/QxKEDHMO+1uCJ6vcEt7ld7Xj4Saftva/+arw1anLgBXvw0oPXe?=
 =?iso-8859-1?Q?hJOmUuPiG68ULP3Gf54H6Zw/shUPBI1KxikJoIoRkSMR0HDYzqnbNAuwD7?=
 =?iso-8859-1?Q?mAZusE26fjtRgHoexwsrWqUqUnQf3LfGeQsbCb8bsCCudkjCX+TDjR4ZZO?=
 =?iso-8859-1?Q?5rFqtmvriu3FCTA7dDN6P5zv3ZtlLk8UmC0Diw9FbsDmjJgdIKAAx8DS1s?=
 =?iso-8859-1?Q?A47LDWBErFRFeFdNpRTx+CsDpDt0wINKrhW6aPSY5m4MFhtqo060o34Bm4?=
 =?iso-8859-1?Q?yxNnww0DLTdk7HepN9JRFhBpjsyRaAaOUPYX8NxKSNez8yNZO9qxPqUFgg?=
 =?iso-8859-1?Q?qAWGhO1sDBCCQsYlkYR6c/UbBe82NLaFx8R+xrw07XtHG5haGAcr11a9K6?=
 =?iso-8859-1?Q?+GMNsHvdiSxeeibFlBWbKvHYS3ehwFiQsTNluNlUjz+CNb1fvtKSjyEBEA?=
 =?iso-8859-1?Q?uXlfPqVJszSutUQuXJ33BUJGTx3t6Jm99+8x8OIXjyYZELuM9Y0vkcpsDt?=
 =?iso-8859-1?Q?z7Vk2ZO6s8ov5fQEgwQQn+e/SExP0YXB5QhGayJKoQAaklXLgFF1+Tm3WZ?=
 =?iso-8859-1?Q?VBTOgI1q5g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sC3WBCSFIf7yrtd77jHamdiHQ392s4DNebCkuomkEwzTMdRT3O46iAoLMKlu2yj2VAJP/Ktr/ju32jxkoqBcHl4ESOvm1OCih2sTd7nhbsMmPX9RrW8CV5OBmfJkepuJujdDcYG0wi+3Xvs5scmnOH0GLEiGJnkqsdENlu/B6mSU0eZBZT31hCVi7k+C7w37k/bQs8XP5bcPJcZ1D7E/ZZ1/0L+65HoQ6AfLDllhi6wDalpp3fOWmaPz3mWOjP+2VpqbOPocEeLTilIt6z2FCc/UosvBW4wQ6/c8GVur7Jt7o6uaauqR612jn+rqzIWMtZMlZX8Q0nWTW11ffHcvjw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070550ac-8fff-4b95-cf6d-08de7f3f7eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:21.9610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGX/qbwDLjikVuQiRThPgV5KTEh9L4Mvi2ynX2VQTdnulTVOkB7RHvg25udRE6oKgMDjCJEIBbMqOmuZWhN4j7KPZAUsy5gOYJXPBt4KEQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
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
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 1 +=0A=
 hw/usb/hcd-ehci-pci.c    | 2 ++=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 ++=0A=
 hw/usb/hcd-ehci.c        | 5 ++++-=0A=
 4 files changed, 9 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index df87f8145f..7dc6d151cc 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -274,6 +274,7 @@ struct EHCIState {=0A=
 =0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
+    bool caps_64bit_addr;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 9febcc1031..2ea8549db9 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -137,6 +137,8 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, u=
int32_t addr,=0A=
 =0A=
 static const Property ehci_pci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr=
,=0A=
+                     false),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index b31032bbf3..61215e9f3d 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -34,6 +34,8 @@ static const Property ehci_sysbus_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),=
=0A=
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_e=
nable,=0A=
                      false),=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_a=
ddr,=0A=
+                     false),=0A=
 };=0A=
 =0A=
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 87c3991313..9e82328116 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -2538,6 +2538,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
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
@@ -2597,7 +2600,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)=0A=
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

