Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2702FED7B86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhd-0003eN-Sy; Tue, 14 Apr 2026 04:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhb-0003bn-GH; Tue, 14 Apr 2026 04:00:55 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhZ-0005mG-Se; Tue, 14 Apr 2026 04:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNHvsCJWgjXaVWd9qLf4GIjyWF8QkN5Wi5hQLz8LtALiCh/0GN0yby7wk0py8PAfbdWjJ10rZltdy1WcpisDbVmCEsyMiag86YFLwPCF3GVKacE+6cA+WUm/X9NsmCWjKiyZ2/yZAb5YZ4eydUgyEosGH0hlsIkhVR+xStplUqwXioY9zooq11XcehWCDXEy2YNa3NCdgrTLa5kFqPDG2CtN9f0vYF9MJDozrVFf+Dggfn7PYoSzrAK6aa25Dd6K7LueOQk4gMzhLwb8/CfNVQT8bRcpv2Lyaftz30nXfKnxeA29IerZluGrI3vckUg/BqR41/FT2AbH/j2Vg2YfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUPW8ChXKsCgsbAjQSVjeZnlRz6pA1jlUQphP5cVbYw=;
 b=saQQ8JSs/scMuMxNpR10sT/Ccg5PNsVRBujFhdzY8UmDW6qo4qKXfe1RtyMvzQGWIk4GrjSV0mfI90JIlR3kChbznY9iykyUKOlyk/OS3FC7AHTRU88oczASadOkSXUkmOwc6jIhTmpvLBJ33yfSQ0Xfr8Dl06shk5nsWinU9kgBquiG1lLsoEgVH3r417pIekykQf9+pxVWGH6FUlBF91K9uzNUWg8Bs7kyZ2FKCLrJy4WBmhDztv3tzfOvGwo6WDZu62KUQhuat+4sf52N1pBaYAQInwhNmPIu7j9cvrFwG3gzGlH6JKGS1hwSOb/+Zg+q3frqAn2OlPngZeHCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUPW8ChXKsCgsbAjQSVjeZnlRz6pA1jlUQphP5cVbYw=;
 b=czReLdSolwtb0cz5baCT+Jg2PYnA5vXgaw9bKrwejBV80dp7rJcDQKreMEBqG83R7LOy/5xOgkNtREqxEcqkPgAdPxKCrYU67ZrPLUHz076QoYM3lvPtSIi+oLbJWEV3DBCiuCvGbfgX2Il4M/EdlpUEXbfr0V32+mrYYfOGyF41i8FjpYGe4qkUsCwyiXv2xXWkguqY/LVlTRM6S9DrdaQvNiTr2T+tqlJdowU8jWdYKi2FHk8075Lzyh//cEnvNAH/a4p0Pdd/1jcxG0EjetXq/Vm7fUoaJvUzgA6AOhQEd2NxVRZMkc6Vj/uwk77NMvvjLuBHFqG3NlHkhgXgfg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 07/17] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v2 07/17] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHcy+TFdtAGW3rvZUye0YiGqef7VQ==
Date: Tue, 14 Apr 2026 08:00:34 +0000
Message-ID: <20260414080025.3005916-8-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: dfc2d845-3e11-49ad-3186-08de99fbe855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: IHeHjfU0Suyel8heFHkOUvuMDWdd8sGb5JcJCnq0Okf1QigQG5kOQfrKDFGastWWZG+w3TsoeoqaQiwmEwKwYA9uiJTZXFZOmk2poqcSaG3oQZVpWf9LxDI5eRjMTNNPd7dXeuFaCKy2FUd/c3DI5WTYOliT3Uu9JEWybcab63FxwklHTug8+xHVbMNlvOIKSd8FQ1tNX4kOOglw3Q5CAps8/uF6lXyYXvAdZWBJeenPrc8lrFBSc7h8fi6GWimHgveOOfnjx3VWck5Re1E4Osmf9LX+2BdvMX97/ufMnnSSoYunNNrMzPRYGr7+pO9uxdARClbj2JkUEL29HcQx/QhrsqhBK9DtTlrYIbtfG06DvM19ZH9GFQdAP39RcAKdlo4QxM4oNWBaeS111g2h9JshyJgdpMvtct2uCKh7xuPYrfUN1M4gYC8iQYYv1GOZnUDpOo9ITLz/yKVDJ1NXQ5CyND1sFu1O4zFVWIs7T4iTmohjQSXBUseHTpZHjvio+qyNhCP1WVP2Ut+lCvQjOi7uhu7uSZxMbXIuKt9ZBFLp9u6uGJCJD9SJnz0CRN15SvrfVGpA4TxRwUNy9DC7ZO2H9fasu6Is4dX7b3SJezhWF3a3SeOZdACeun+WINspo0XyfuaJUjMRQZKzGd88TwpKuu3DMQ+U+xg8h5sNuXiifOGnQn2709WejgTNhkEzoo2DW3TPqsctqN/27d1+SWqPjwjtss3qlRmQp7ZJbJW1TxtumRxOMEAYBNu/NayqUzX6I0VYsSToe4DBlBlCa+svsSPxLErV8w2e3b68qLc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LjE+nfgPxbhdlFdHQ9dt1sGyZGsablbz05KN1iDlXxeiFPDeb3FefDPYFB?=
 =?iso-8859-1?Q?oFpuuW+jZkxMk+ifL4AaSKmd7+V4R6jiXERXV+EhU5yLLDG0IBETYAkA85?=
 =?iso-8859-1?Q?m52bFZ/vjvDQjtnOSy9V6gjVflVkhINM5Ptf/N1oCqCbgy9rR2gymMi47a?=
 =?iso-8859-1?Q?Dlxfq7QTUS7EPkp+ySttKIZNGQsICg9/N8wnwlPWzFaswx57mD9Ies89WV?=
 =?iso-8859-1?Q?7fAB+rSAowgGCZ2IAlNFv4WmRf0s2M2wG4Ez+J0gS5vhy95sGNQHkoY5V6?=
 =?iso-8859-1?Q?4TbWcv2IjSr9fXLmCo8qGxn3k1s93o4THQ9+1dShlLKNfBDZD6dI5CiaZa?=
 =?iso-8859-1?Q?ptoTAhfQYtstVPaIwtof23rDtUkuRLOLUOhXZD/eIvlsN5OKFXzBzjlMpg?=
 =?iso-8859-1?Q?SCFyrlv9Jwm+OG1gkHtVgwuMmffc2NKpZkBCJhn8IHxA8DQjaZnAcSgS5a?=
 =?iso-8859-1?Q?FgQ7pwoBLy1xasRKWnjbAetRV1yAHw5u/zlvuHKHtbXrtYg9Zu2h6/j87O?=
 =?iso-8859-1?Q?VJU7RaUDQ+3Ya2r9GAoRrO2JxdA5d9i5Dpnzy82Z6lPlBojzTwsKThBRkp?=
 =?iso-8859-1?Q?7UG9D1I1H9e4Un4dVjURqGuXkG0764fjMUIpqgmft1E6v3PTX9aW0ERoD7?=
 =?iso-8859-1?Q?X3FACvHDzfPbWUaPtSoZzQ9PfUMd+RwJ3jICeBFAqO/CpVYdiG2RY6UsKM?=
 =?iso-8859-1?Q?Qfi+P6q/+X9XpBARNZBScI625YU1FjAevscWxkHDJEAmj2A1ti7I16Az33?=
 =?iso-8859-1?Q?VyRG5VxeJqT4ob+7oN5rMPmbyDxm9ql1wrcsYvkDZmoRuUsDSemxr0NbuD?=
 =?iso-8859-1?Q?YwDzR2MXu6tAnrXPk8VLZvhYGLeZykcbuzTGVLpJcNK3pbvDglzauSc2bx?=
 =?iso-8859-1?Q?Ed7+i1yl+HuZoPzYizGXYtNwXv0Qm8iLVTyATnuTiSnn09B2zuKZWcdLsz?=
 =?iso-8859-1?Q?KyePGplQfylREMnZZzMwTbQiiqJSm0N1MVv3WEJNIkrIPfIOguasuG/mRJ?=
 =?iso-8859-1?Q?Oi8XVTNuAszG1p1ebL1h5sYN65F4SsOBNCA3CaAUqwQ4dLmiYRUEaBXy6g?=
 =?iso-8859-1?Q?i7AtVhP5y7tnbuDOHq2BwdnHbM5BOI6IFyvb0Osg4u/Cw9pb7VS0oc//MM?=
 =?iso-8859-1?Q?VjLhWCCKlbwgjZ44PC+7/kZwJu8tiWwfzRRbVom0zOhe8icwoOGHQvycot?=
 =?iso-8859-1?Q?BiqcDcns8O/o6tzj31NpVJzs5ruPcF2SsHOKWCpuqnTs6MXeF0W5HhoK63?=
 =?iso-8859-1?Q?jVMrTgFfSh2M/Ix7LMbHvv5nPz2Y6JdDFph//NFyTFUGokqodFGHsohPZx?=
 =?iso-8859-1?Q?jOjP85WvBLXgQ46xCGNdAJXYX3+VugNt3PP02V8X48/YuHRK4oFs6Hl41M?=
 =?iso-8859-1?Q?3f7Z0lJUUzGKbFXtfFUo7TH7XZqC6EC4RD+ApBgXA309ieLbc++2ons1eM?=
 =?iso-8859-1?Q?b2bc0KoN2Y4hy/jBQugKKz+3+uzBhIm5nqz2RODEZGRPAXztkrlyibpWjE?=
 =?iso-8859-1?Q?IhrY9cJyd3fygg95bbozwAjzbgp/WKQe+62LsjcxupVOBtn+NBtZ70vVtU?=
 =?iso-8859-1?Q?f5rVAhM6uwuOv60Cn5VH0p9Mgd/+ck+WgmIWz4cPZzADynN0myNszy/79l?=
 =?iso-8859-1?Q?OowaLfCuw0QoNw9kMzwK6XHDTy+xW5QrigPL1h2++5EXEdpn2cIPmimW6l?=
 =?iso-8859-1?Q?GCzCYTp8kDgjtIETKHtop/PkdioDchMa63/gzzP+bKknsjN2mmxJkpcToc?=
 =?iso-8859-1?Q?+1qS0GI3KYSGLYZJu85ZWYKFhK0Vczp3omVUVraGqzc2K7wTXgpyfdzo8X?=
 =?iso-8859-1?Q?EIgZgTPbRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qUTbLYLnQ/1z3ePl7bVYUnQMKhLB0t8ieWjbvN7ISdMFgGepbdsYpIxAwRj9NYyuURe6L9xRxEWfIMYuxxQgbIHmONemG1AZ2utkt8neidihYjdCybVTay57SUCRVUJh8uXKxmatKU0rmuvBcoKBNYDRMlYEkKHyWypgV+OHbiuOxVwL+u2h58Im0WCJ/XhZTqAxtLJMVrTSpGTokfGXjOHMyuxbRrTr0zeJhhEFnZowybCKM7PerUfbRC+IGAMTnSH9L8BddLV2911bMIry3Uw8LOFIPr7wDxzO7fIzkGoZ44cFLZzkoEl1fruTtBg0tzbbTKxe+pzTQEUOrcTcDQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc2d845-3e11-49ad-3186-08de99fbe855
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:34.6455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbpvdjauO8aXz6t5qcOAhl4tkBJM1AjSVqdZxObaeHPBA+QrMXmCTy3MbTOt7RY9awn1VDRxaJA9NfJVIp4UQlLCbtZA/ftiVryN0MLBito=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 1 +=0A=
 hw/usb/hcd-ehci-pci.c    | 2 ++=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 ++=0A=
 hw/usb/hcd-ehci.c        | 5 ++++-=0A=
 4 files changed, 9 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 24eea9d23b..fe4c508c32 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -256,6 +256,7 @@ struct EHCIState {=0A=
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
index 315e8813f5..e3bff8e518 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -2532,6 +2532,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
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
@@ -2591,7 +2594,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)=0A=
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

