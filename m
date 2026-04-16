Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8C5F433D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsM-0008I1-TV; Wed, 15 Apr 2026 21:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrt-0007x8-3M; Wed, 15 Apr 2026 21:50:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrq-0007Ut-Fj; Wed, 15 Apr 2026 21:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvL8ohI71zBiyrV8kp9/JlOhH4zrbWjpmlkDSW/srL7JSz+5Hhfyp5WjOrV3iqiNvFHEpTDbik6p11iS+G5rKRpY/tZwWLCNLiUlDG/oFzOldXVjwqeuMXXQ0gCpZ3KI86FWmDqtN2xdaIjKX2n7EEzXvQqfnO46jSsr0TcREXxf5IT4zkgBulTTBc2+fsVCVrMNA5Je10FZxq2TpfLqijJohhoXBYKl90Ot4cv3SFz8USs5RT/tlp8ZT3Lt9vYARV7jYzEHNH/zzCfnAu04N91x7CuRlRNPa9ne2HrrcD3swDSPBZfeR2saGAPaKNpz8dMxKqekOhnO84eLYGBQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPhEhpq+DhJQDsAJX7pRkTya1i1/friyIRpgRGF/I7s=;
 b=XzdTc+lcjz0xln/0FBOzzlcZDf3yUnj5NhMLFHsjXgtfkGIVdPTXSDTZtqA2kPfjlw7Z69frd7KF+aUwawmp4HYEi8nC55jbzyvy07PIc07nXWqDt0NejBhog15KlW2HG3ygNcf/QnVf2EchNjzjV0zNFWwVae6v3RIWEcucxzUU0zbvLkz5BoAuwZ3IoekwGZtsrBpONsin5YRYdMeo42Ufa/UmFrMgfJ9W5CvhsGdPrdcQOAJm61q9CfezEXtpgT8uhodAs3Ew84M+PG8PxcxIr2ts4cNm82Eku2yOh+OG6rMksgcnLtmPqNTB+qXbSVsLGOSCG7V3tZ7lEQaCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPhEhpq+DhJQDsAJX7pRkTya1i1/friyIRpgRGF/I7s=;
 b=bfbcbfq/pnW5GP41pcOnESIw+jNxPCyK9fbTy6Kizj9IDPjU3A6nFMegtaLfrdb+nRYNkxbs3R01zfXR24srY+6ZK+YxMD43fOWVGqM9hOecJE6gtfcAVg0Q25/jwkzG+PXqbgM5mhDRu4xq9ca7tY/oC8fcvAAXr75RQAs220FoY2Lx6KHF0L6yleSAXgj3BO8qzMLfg6i59S9GZ7ctsgcI2ng4bv82vIR7L+s6hLnPGG2oNi4A2SjUqHz8mhS91ZzNBeHBOg9O1coMtiO6EZpSYVTjbQwzLeMkrjZaYuWjWm2Ur/jiEjGv6Q7SFnEMN9A43AFUUm1dzuo34uynjQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 10/17] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v3 10/17] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHczUNSBpnWfju2SUWu/W6t8ouqgw==
Date: Thu, 16 Apr 2026 01:49:53 +0000
Message-ID: <20260416014928.1279360-11-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 5d1cda28-fa1e-4e04-4113-08de9b5a749e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: N6cuoNI1yBSx/raL4JFpMcE77V51Y0poxkvPkukK9X/YhxtHfhv/MWJ04cBcXy/Jrtc8lwHkArKmcBfQtryzXG/ClM72i5abJVuNS3ztppSCQ33K4IuQ2B1yfd2ZFFCMqR+cwtqGJSZ9hjbmhFEX+HdfpwxHiDQqUpPVOWb8eQUpPK2j7Hcb83pBRCUBWB8SWe2oUSCMki5MGq/VFLzyjrz2UpVeGz2CN8gpj0MdCKi28frS+GYd2I2HpfA6aWyCFO69B0zkBaIIo4XtLwOvROh0QYhydXb+uaYHTFhDSj1XAizmPFwTNiSFq+SHXxlbizNe4/B6GkekalLKI+UUOs6nU9wc74k9kvnfJONCJogbCmJzXR4OmsnPZsGcDe4QNuC2o/T0+kc2NZKxOhbtI6spvT2AVfGjf6yF6C+Ek/GJLDYU9S0+sbKLOHZA/qlVwZqhBkskyj48z4e5dyW/fjOFvfLfpmocBqzEFZ6hnGLEypyhxDQCksIXHW/KeYoWjlskiuk8ODOtTMNbDE03Kgr7UJz1HGytK7LglABs2CcJcFx89Ry4l4/ki6SA8lt5H3sqITbqUrjvLRHSmFbWQbSxomMVOlY31aeEa25B3Pum4jo/Fv28v6EFXJxW4Vbaa7MZNyr0XZVQaDrRXUxPszSMuQaEa1jRvklSfoHBKA2G4Y9Gq15k9BCoDFqRYq7tdYT4Q2bZ7yH91jOf2FhscOD93K9LFgqQ+9WtKTXu0SRoMqMVi0p4Ov2zh8LwWMF96iyJaVMweewLg9IvUssGRUqiOaGRLKmXwZuBteqQqdMrNysblullJ2eS2RH+sJbM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?04MYQ2VEJllpwggz29oFutstwX2WQAfidqUkRjCAIyUfif7YHBAID/fYaf?=
 =?iso-8859-1?Q?zYdbk0WnQj86M+dDj6iu7nP0bu34NrDKG4Mom7NQ6Q/ONG9McCKrA2PwxN?=
 =?iso-8859-1?Q?VaX0LlJ+4QUPwowjE8Ga9JDkaWwYCGl6tvT5z52manD9NJZTdcolXuISjl?=
 =?iso-8859-1?Q?QJLVblh4gKa3zMj7awbN1khh2ziRkGutJnyexseww788I+1XH8V4ykHM9L?=
 =?iso-8859-1?Q?WMphtpI3eJ41KwpcerRoZkkhAOMyVVuGzPL20kGu4KWm4A/+AXQnyiJ4LL?=
 =?iso-8859-1?Q?/tRd6ull1rui7oQRXx8K9rEEfcEuMMQWYWT4tAbyiyg7L7BOesmBqLMHcu?=
 =?iso-8859-1?Q?Eg+L1vlos1So1OapCYYY3M3D98LZcerRKwIUQOUd/bSqmk6thPqgt0SXG2?=
 =?iso-8859-1?Q?m90NVIODS7RyyTmg1MZ9jaw840ni2FZcFDNw/zNM6Kppcoa2bNR44NRUKr?=
 =?iso-8859-1?Q?vpHpRmJ+XvmV/+6nNwxr1IYgz4LdA0928CxanUWBCHjk1PL6dsOle6mP8j?=
 =?iso-8859-1?Q?7vBnBFj7NrK8hAasSODeojfKAxFSRwt7AneIJ+tdX3lKApU+YQKnfRB5Ol?=
 =?iso-8859-1?Q?jmmX9dEEiPSkmf2W+wbVXspFidFxyfyORlWu+SXgYLbDUqIE8H7kH3DmOz?=
 =?iso-8859-1?Q?P+XjLqYrZpmDHPq6FNitdjgRGO76QT4D7F2QTwb97gtMpwUCJIK6yWbmdG?=
 =?iso-8859-1?Q?Doab+ckFxlnvcO6y5ebNYudnsjCeagQXDIidgoKMYf/gngN4WI0QxBdxt+?=
 =?iso-8859-1?Q?RRjBcTLN5DCxB85l+gjWP4ZLboDkTGAw71T1JywXDI7YLIIXbEyrWErxC0?=
 =?iso-8859-1?Q?tT1gP7WJuB0Kr85s8bFAV8TIZPH6UkUIT774AWJPNX0q3BwrkGsewyOU4O?=
 =?iso-8859-1?Q?xSboZq+wcUrD364vCh9dVx80SIEBvBfDkZvO/edPotGQobKjyR+v6BheB+?=
 =?iso-8859-1?Q?XeENWDl1i2ag3+g7PWvg9PK3YTHmr3HKugTw6pZlYCR1tuaqGD1ZXiCf8o?=
 =?iso-8859-1?Q?iGAyPjoALIRBpoSgUidmFx15rBL2PqOjntE51xsfHWL0C9NuLTUdQQYDer?=
 =?iso-8859-1?Q?oRytXckTGvThZ8BrcbkjnSZLPdiBuqo1Iscyyi660bEitL06FCd7hLzOgD?=
 =?iso-8859-1?Q?LyUAxQ83FUIDVO9Og06MD5c/J7THDoyM1ba7rVs5ndANlzMJWCPwjV63bJ?=
 =?iso-8859-1?Q?WszdKfZ+xkd84nJmEVfMvN5hmehxpKbzt0WFjriKwv8V/XM5+1LOoO+ekM?=
 =?iso-8859-1?Q?TFqxPZcpcySFRkAE3UHN+pO9vvP6jabCKbIvH1gFAs0LXIyKHfRR+RkKhT?=
 =?iso-8859-1?Q?tHHLKMu61IDbwZ1hliafKaQ+DRPLO4S79JNpZp5QYEZoRYXuE3vofF733N?=
 =?iso-8859-1?Q?tHSXTF+yzbCYmLn3PeBceY6pU8KfB3XesqendcZCwQnN6o1T36oS/uPG59?=
 =?iso-8859-1?Q?x/2H4gYOJJRfPyPs2Y4T+M9pyIP5L+7ADgcNvgf7GQ5p/DNmSVrRNuxmXU?=
 =?iso-8859-1?Q?Q1a4POAcMp6+u4K01Ss5gGsRa12iDVzkvN8Oa0pwEZh9pM05IPVkHw2WHy?=
 =?iso-8859-1?Q?ujkW78cWThSjFHXgnH042lyNfz68LRFUSSioaMa1rheZvDTtqgTfbSXavN?=
 =?iso-8859-1?Q?yqOh6HkVT271LwjEmia5ZRx0HD6JUtTZDPci7rwD3L2WnfoTAcPK18DUNG?=
 =?iso-8859-1?Q?Z4nSQiOGZ4K3Jl/rcmIAyZ2GwhP5y5sqdYmFHCgHQ88rzcpN/2FHW84KiK?=
 =?iso-8859-1?Q?imGSAJbXsTdbOFlEwFCzyn+Be6rM/dWg8Sw7EXsB+5OG2s+Dmh5mQg3FW4?=
 =?iso-8859-1?Q?n2Gf7Ue79A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i1Fj0iBm3KCFwOEuRNCPGl5UhwaOkF8RC1dXZBulglxEUGLgI53VCrmtTV329TSVAOTQLQlsPQXDP2o54k/ygBI5Cud6oJGTwpHjxMowphJcrP1DD6FQIkRWUrDX9bWxWQvpHSUfYkPIqnphMFMNCO8Wtr1yEqE6ADhALor5XT3t4zrDes5WwzxKkHleUg6BMyusOkP0qAjXJYOXr/mNg37Tx61HvsOxg4lNqGMlq8UupzA49xbsgsMq3TBsX0OKaZMCmDX0Yyd4TwazHFWkD9dyGaDp5nuXZz0X0oMUHYphm5XperDp3LLxAHkEUvDKyiM7/bEtMh9tpM4/xtGcjA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1cda28-fa1e-4e04-4113-08de9b5a749e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:53.8640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jBb2h0rPlg/tlmb4IFX0AYCqsrB6Nund+piyAkAsAj3zkq6n3YHKIq/L7HQv3+qlyCmZxiP5S5CFHzfralVSZG4oxKwxB7bwSR2Vy7r7Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 19 ++++++++++++-------=0A=
 2 files changed, 13 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 773f376834..712de9d50e 100644=0A=
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
index 37ae637e08..d93d227e6f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -473,7 +473,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd=
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
@@ -1199,6 +1200,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 =0A=
     for (i =3D 0; i < 5; i++) {=0A=
         q->qh.bufptr[i] =3D p->qtd.bufptr[i];=0A=
+        q->qh.bufptr_hi[i] =3D p->qtd.bufptr_hi[i];=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
@@ -1232,7 +1234,8 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
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
@@ -1726,7 +1729,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&=0A=
                (NLPTR_TBIT(q->qh.current_qtd) =3D=3D 0) &&=0A=
                (q->qh.current_qtd !=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.current_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(ehci, q->qh.current_qtd);=0A=
         ehci_set_state(ehci, async, EST_FETCHQTD);=0A=
 =0A=
     } else {=0A=
@@ -1798,14 +1801,14 @@ static int ehci_state_advqueue(EHCIQueue *q)=0A=
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
@@ -1834,7 +1837,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
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
@@ -1915,7 +1920,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
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

