Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86431FAD40F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSz-0007yp-Gf; Thu, 23 Apr 2026 01:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSl-0007ec-FW; Thu, 23 Apr 2026 01:18:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSi-0003Bi-Mn; Thu, 23 Apr 2026 01:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brToAyJLlW3cejg+WiLB96rE2MBf1a/YDvvEUifD7sy+XtdJGWU5B1SQTNBeqbE5SNRJ9S22Cvf5m6luTVzBJIGnc1IglXxU/pEnWSZ05wlzj+vh1GCgzNsTwpaL4PuiOnmbP8y2q+KtisY7cb/CsgSW+s/MpZNoCBs/tXc3eWegRtuAq0L7Eg+0Z+fTSgICCIMmgefI7ElxZ5svD2B9KfzZbVpfsp7DTEckJzNlNeuKkVdI4GXxyyyRaY4ixXSaM30a8zh6CgJKxPdurAXXZWUcp8Yn0qJ9bT5z9WQhoHp8amXKEa/KZezCCKBU2yrOd8qyagY25YAyUWT0bYyLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rRaAH+M0gmGI75Fu9T+UdOCeNggmfgzhvnjrKg1krs=;
 b=JzxVkmEIKQwRoT2zqeuyu0yxrthTGwbkfvuwkWiPkugEPR/hPm3lbJzhXF9zX3goJ3FzLAXyvODjf0Ih0lsGL4Qq5s+Jkaibm3bBVH/kN+1Jztw7dHJ2RC4Dh4MMOI/qh+COogHArCrYB8jc+7wUjClgYORUvPn2OER+TsElYBEbqdNHCH+1FJfhOVSn6KAQnHMBV1sdZGS3GMHZ3W7FWyLKNzAUrPn1wmOZjyCmnlLcW9KwzkuzY1ioVdCc+vkyWJMoZgV5LhtJHiGvCtMjwMdm4+26D0Zy5yp1xZaRttkUiR7uICQTcQ8SI9UQJKG04y61gHm5oyzWvnwcYtG+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rRaAH+M0gmGI75Fu9T+UdOCeNggmfgzhvnjrKg1krs=;
 b=mDau36gO6PBsHN4FotY6z1172hlCGnix1rCfMuTX3vGDDI8juRn5fDWL5Iimn8ENRUlm0LLQrCEx1so3AoFHDlA0z21kgIIydIfmmUclPjITFaUVufBELSQGe4/psLE+yKmxogMUC58L1dG1RBHyimyp6K74Q4fxToX04x1L/bVZkRg8uSENYsbBH2hFivVlMZ+1six7uqIz6o52B+d/Oy51hfTOZc6XiFxIen9jxukWzw7eGbzvmWfa7i+VSDKS0fE3LJ//fyxRhokXDy0KEItiYHT0/fTouz5lA/R7ps2V81w/ID+rH3cKedNXzcaLEkEKpD6fGaShxnFCu85FXQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 11/17] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v4 11/17] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHc0uCYq6WxQ7L2K0eBau4NvrkAqA==
Date: Thu, 23 Apr 2026 05:18:19 +0000
Message-ID: <20260423051804.362095-12-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 42e7a575-c727-4365-9476-08dea0f7bb33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 2kD+IP7QU2zPPR+tLLhzkAhOasYfWdOPVMEZqE+eS/f9TBb9ckCgtHKG9a52+HNp3D3tgtadU6bbjkoUnqH+SV6lNM7dw4X7Bc6v6XZ66xnKHtoHRm1tDm8PV60Vp3q3bPgsAlmFEQLUgIFY5p7Yo9GM4MzvZuWxbOJABdQzGRuf6BMKVjeGgSxmIp3WgNCvOjBdxLvpUBoXQuBT49y5Ndchgw+cBq3lXlxxC1KLDu4ZaUXFW9LeMtR9ubPoyFHOHXxE9bOJ7yLKCr8gfgRrbpmsEyx/2kZxn3bUyJwwxi9wCOq8psBLmopYh4cXadwXF0x0yquaQn2KDH4LPsLLxzYgNRCeXnBtnnsCREM+uV6k3v55/LhEXBQobor+CCSRURzJdjSudZOUC/A/Wux8Yk+szap4zDPYU/HR4XAq/7pjIrqUByWXl87JXMjFOBHBkCSKnHZk9p6p6EsM4pyrr7QapjUT3gqdSPC8GklGKxVuFP8IO/9iT2NX55fwLAv7Cckk/HUvpkOQglKd5uw25ifHsZRTCQkg5lEZVeoCA2I6biK5MbDswK68Q7obR4x6q3xJ1eG11m0ykpNK+Kq75VM3TU0pIpSEkZp3xn1V0cxvJGfcTWHphlyyGeR1fYnV/thiUv2z6eR8yOxn5lpVl3mXdpy8IkeBz1CvSMcfXYFarb6sz5PH+QlUunrpJzdpvBlpyU6T2XN9uhUmdEkko+HM3CwLblRTDaUCXnEfrLGI/hU9MeNpYInPgaEBFan9rQIpXiUeIOxkhh3R1B+rANt/LtzT/QSMfF+ahSk60KVPpu0XvZmBYx/jc7DIY0wU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T3dg9r6qqG6xHFQ1+IP+4ZSQWXZ9jnYpZQSx3NKCjqloSmivtOj6a/8Usv?=
 =?iso-8859-1?Q?9TkY8oYtV2IHkNgDBymeRzRBBVkIinMD09bBx3k4069rhgqV24O+a2UWYv?=
 =?iso-8859-1?Q?RV0m6Yi3KD5D5lWhAAHKP5NGE4u2EdS5XJ9LD6gKSUdZ4fOHZZYhRCArm3?=
 =?iso-8859-1?Q?/VN1ZeHErV9YfFUoYIT3x7RZbLVnnP9LfmVSHBxzA1nZxG3j/aUmJ45fgU?=
 =?iso-8859-1?Q?zPVMASYpCExqxqC201g9CbMnuOsXeO57CC9qysCAUGeIcBrntse8LkMYPI?=
 =?iso-8859-1?Q?U/FiwbpghhOg3uFUaGZjg6p5Z49UMyWcuSPXWiMUIo4yOAAgzqYpdTC2sG?=
 =?iso-8859-1?Q?6/C5H5SLDiyLg6fkqI2PT1jkuOl02rbRN+IvcRYpYSf7mbySHDUW1W6a/0?=
 =?iso-8859-1?Q?mDNMzRoberS3nAS8aMaC42s0pURUc/SzDQkYEJu/3wKNeGte+SFyxwGGTW?=
 =?iso-8859-1?Q?nTEfpGAzq73T4Mf5ToMul0/kTNCukRIax9J5wInALQIL1oxuhYgRrDZFqJ?=
 =?iso-8859-1?Q?up+O5zJxUSKLCS2OMceP/IOtHLe8EzU39nsNUivzathxZ/O+ukdrTcHwsU?=
 =?iso-8859-1?Q?i5dKYGQRh8cEbsbg8lEIz5novzp/zL6qnLSObgnjL2mG2twOasochUKcJn?=
 =?iso-8859-1?Q?uA+/tUxYu4QW20Iuvx9UbEZa6kBAqFj0eNwSAxb0ZC5BZaj9WqfbdVerEc?=
 =?iso-8859-1?Q?NxSSaBFpTOSnU0ouu8dTO5gkV+9TSoZpeypKfQ55fC/cwEM4wthkjefs3y?=
 =?iso-8859-1?Q?dIyXwp13PGwrGqBUsIfD1HUOk/FRsUE4kGwcVFHPZTH083hU3EK0ce9JPZ?=
 =?iso-8859-1?Q?RDT93hbeuF+D88J59wsDEw/WigoNwbcG3tq6HsC8XKbFTFPyntvcL06D/T?=
 =?iso-8859-1?Q?WuzNgv9XoPZApV+YkeLdNaz+90MJ4C54ilex04t9Z4fy3ETQi86ks7+wj0?=
 =?iso-8859-1?Q?9z9AvBjx0vC7Mt//Rb733u6BxIcWgmxJp+bykIhAAsoeMLpLqINRl7pApK?=
 =?iso-8859-1?Q?7yxf/uRywbpSQlPImGnV3lQlZ8eqDvSRn3ddKJx3lI+thq+cvlbeYr0BYl?=
 =?iso-8859-1?Q?f3HKe1IWTyd40v6VrRMZhUblC82rNMZx8Q52Gp07XN1q/GFx3araRTMgL3?=
 =?iso-8859-1?Q?z4Qfj1GoB+gKgjWY4Dv6UCb+1e7H1QQZR8JCHQLLIzVomaqoVSTaxU2i2J?=
 =?iso-8859-1?Q?woV8/TJd/CbzooaUWeH5e/z/TZOhrgYoDIQ7K3TVp+M4H0ae0CNcI70Z4W?=
 =?iso-8859-1?Q?moApyusUJx/e/pdD0kMAnCODNV9FZHiRGFhs6QM+m7hZSGKNuU8mXX6VPU?=
 =?iso-8859-1?Q?OrzihZINpQy5m72/Ynz5XrdY7ZeQbwwuHIcswxVWzrjzvFPPifS2GFZTbT?=
 =?iso-8859-1?Q?GqfD2zRuNyXibwKYy6R7OELsH95pxytaEtdFE2SwLlejosiP4gsaGFxD5a?=
 =?iso-8859-1?Q?FYZTPdZUdSstsX8gsmQG4k90sBcFBevBnbzG4U0PJalTa+3+IHdQeGV2DO?=
 =?iso-8859-1?Q?H7pTzkn7glDn6mltNc7XJyYFIMU8R9L9TO9ad6VuaffrAhzU5nv9lO0ev9?=
 =?iso-8859-1?Q?80WxNeEb+p7nGNgTuJF3yAoIvUPNOZ9k4rf3pWkj50FYEAt005EToP0qaf?=
 =?iso-8859-1?Q?VtODwtv0oFeMigutVMI/pzFhSo3tOfhuBj35YtRfhhONsRZCaK5mLv2Y8y?=
 =?iso-8859-1?Q?i8YyAbX++0LvuKUZXXQDZSY3QyF2IifnG36R5JK79T09DC0qjq7bE1qXu8?=
 =?iso-8859-1?Q?fmgslGlVvScOPCx2+XC7mFLRPl+x9eFpMvyGwa5i7jnkz2bYyz2+D3Ylye?=
 =?iso-8859-1?Q?SlOCNxykQg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m4toN6JUfe9XDLWjoOcGjQRTaiOMfMP4e3EOuQLD14eSWrRBBBnIGmFxZFnh5NbTneYgD/FYqKxAfGOyadCJAlLpUP5FF0shQNrITA0xhNtwXtwMmKJlGy+ogqFoCkGQODc1xOy9BUlM1IYxhYaH+fjmoy1Rbi/8HkmYTEoSIn9n8/k7zarhbng6jmyUkfdgg/qlPlLrTs47rmMFqEMXBOcSPiblHvgE1JTUJNF2MiGNwTlKTMa6Nvj/TeKMTC/lbcfdtrfgYlts08xHTKHkE/9pcrhN6yyg8FjqqpO3wK6GhlFZ7CvYd7h1L5vF8touFLOKaMNsXjlymUB7f1kpKQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e7a575-c727-4365-9476-08dea0f7bb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:19.0096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70LPUF6374XUpme07KqrzNRZOz5Dd6c4SJaiTkVen4vP7uxJZQfZu4v9B/aZstUdoOuRF4twTRwshM+/wXp+CiRxg5ZxLvDwvssGtKjN5cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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

EHCI supports 64-bit addressing when the 64-bit Addressing Capability=0A=
bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register=0A=
provides the upper 32 bits that are concatenated with 32-bit link=0A=
pointer values to form 64-bit control data structure addresses=0A=
(EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)=0A=
are stored as 32-bit values in the data structures and must be=0A=
expanded to full 64-bit descriptor addresses when 64-bit mode is=0A=
enabled. Update the qTD traversal paths to use ehci_get_desc_addr()=0A=
when following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for qTD buffer pointers.=0A=
Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay=0A=
handling to load and propagate the high buffer pointer fields.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 19 ++++++++++++-------=0A=
 2 files changed, 13 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3428839ec6..fc66aacd9f 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -139,6 +139,7 @@ typedef struct EHCIqtd {=0A=
     uint32_t bufptr[5];               /* Standard buffer pointer */=0A=
 #define QTD_BUFPTR_MASK               0xfffff000=0A=
 #define QTD_BUFPTR_SH                 12=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqtd;=0A=
 =0A=
 /* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5ffd4c9885..e82e0f625c 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -472,7 +472,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd=
)=0A=
             (p->qtd.next !=3D qtd->next)) ||=0A=
         (!NLPTR_TBIT(p->qtd.altnext) && (p->qtd.altnext !=3D qtd->altnext)=
) ||=0A=
         p->qtd.token !=3D qtd->token ||=0A=
-        p->qtd.bufptr[0] !=3D qtd->bufptr[0]) {=0A=
+        p->qtd.bufptr[0] !=3D qtd->bufptr[0] ||=0A=
+        p->qtd.bufptr_hi[0] !=3D qtd->bufptr_hi[0]) {=0A=
         return false;=0A=
     } else {=0A=
         return true;=0A=
@@ -1200,6 +1201,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 =0A=
     for (i =3D 0; i < 5; i++) {=0A=
         q->qh.bufptr[i] =3D p->qtd.bufptr[i];=0A=
+        q->qh.bufptr_hi[i] =3D p->qtd.bufptr_hi[i];=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
@@ -1233,7 +1235,8 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
             return -1;=0A=
         }=0A=
 =0A=
-        page  =3D p->qtd.bufptr[cpage] & QTD_BUFPTR_MASK;=0A=
+        page =3D ehci_get_buf_addr(p->queue->ehci, p->qtd.bufptr_hi[cpage]=
,=0A=
+                                 p->qtd.bufptr[cpage], QTD_BUFPTR_MASK);=
=0A=
         page +=3D offset;=0A=
         plen  =3D bytes;=0A=
         if (plen > 4096 - offset) {=0A=
@@ -1727,7 +1730,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&=0A=
                (NLPTR_TBIT(q->qh.current_qtd) =3D=3D 0) &&=0A=
                (q->qh.current_qtd !=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.current_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(ehci, q->qh.current_qtd);=0A=
         ehci_set_state(ehci, async, EST_FETCHQTD);=0A=
 =0A=
     } else {=0A=
@@ -1805,14 +1808,14 @@ static int ehci_state_advqueue(EHCIQueue *q)=0A=
      */=0A=
     if (((q->qh.token & QTD_TOKEN_TBYTES_MASK) !=3D 0) &&=0A=
         (NLPTR_TBIT(q->qh.altnext_qtd) =3D=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.altnext_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.altnext_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
      *  next qTD is valid=0A=
      */=0A=
     } else if (NLPTR_TBIT(q->qh.next_qtd) =3D=3D 0) {=0A=
-        q->qtdaddr =3D q->qh.next_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.next_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
@@ -1841,7 +1844,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||=0A=
         get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||=0A=
         get_dwords(q->ehci, addr + 12, qtd.bufptr,=0A=
-                   ARRAY_SIZE(qtd.bufptr)) < 0) {=0A=
+                   ARRAY_SIZE(qtd.bufptr)) < 0 ||=0A=
+        get_dwords(q->ehci, addr + 32, qtd.bufptr_hi,=0A=
+                   ARRAY_SIZE(qtd.bufptr_hi)) < 0) {=0A=
         return 0;=0A=
     }=0A=
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);=0A=
@@ -1922,7 +1927,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
             break;=0A=
         }=0A=
-        qtdaddr =3D qtd.next;=0A=
+        qtdaddr =3D ehci_get_desc_addr(q->ehci, qtd.next);=0A=
         /*=0A=
          * Detect circular td lists, Windows creates these, counting on th=
e=0A=
          * active bit going low after execution to make the queue stop.=0A=
-- =0A=
2.43.0=0A=

