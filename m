Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911A8ED7B88
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhb-0003cS-SR; Tue, 14 Apr 2026 04:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhZ-0003a8-1E; Tue, 14 Apr 2026 04:00:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhX-0005tv-26; Tue, 14 Apr 2026 04:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbF2RLU3bZ3qT6yvB2fAddgNnbeUyq0kxSfKjY0Okx27dYDL5ZTQFdqpBBJYBZ0aFeRrFCEHsNX/4tkcmaBW9ZpoEa+i5ouGgwSD6m7yHAhaweG/KNmorSck1FKon6B2e+0zm7C7cfacJ/5yZDPUGb0BS8cR0Ez5bmQpmnd3/qQvxk7wzNRe+T74YfKbakLcW+9FntX/JuDOmKEsj970D0/i+VQxA9J73WGDK9+/kyWBkrjVJia/cLt/EXchg3Q1Ito8n4JxXDF5wviBrDoWV7oK8tHBdaj4mOPesPnCWdG3CGIUKCCC8diuHov/r3//JmS4S1U9VmYLlM94dR97AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuWKDDsk6LX2zEwkIhjM2Aljgzp3WQcUCNwUlAYTDws=;
 b=NciMAIUM0P5wOE7ZkPzEStH70ZUSgHG548tvXJCFemSK3kCk4m4LLerKJlWD4lDeYsn7oPWFGXKccf0/yuB/0v2quG+oyhR4O0axRHEW4AQwX/KGeUrw43EGXM5R1YRTtZ6OsyWI9higoUjgYi7Q+ox9++o9OiDJqdM5yk5lOTIO3Yz+NwA1YfAzcKWdMNSN7ai40QdtozJICcbl9E/D0NNo/+FDiBHHhv4sdgRmRjD24edtIq6y/GLfiu9JdUszo6l2rhIEajYsgaG5OcbCLSq0CcFS2LRl9t0HErRixBWtqccDnjFErcgpLxCo8J5e35soIBx3Alu7ZVJftBAXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuWKDDsk6LX2zEwkIhjM2Aljgzp3WQcUCNwUlAYTDws=;
 b=ktvScOWaKO0tgL0nwjp7p367v+VRg9T1xgvn8ohA2F6oyFciO+GMZq3ASoGw5T+05Cqp6r1SrYeY8PDZecmTL3lbA/DCpRvT1cdDVe23Tx27ofNkXt6wSzSF8BMqxzaw004bRIRlb/+ChPUfbIAeLeHl+cdMH2aFoX7KOFKKJhO0vSpavVi6s7ZRvzgfVOWZtHPmI1Q1dPyov6FqbxfM4mbz2VisjxCEm62vtxrn1G6Mj5PKcXDsRYsbSYXP6QfEjZwSq0ACQkefhJJv5yFHEDG3enOBRR4uztCbmE+AorvRr0wXyTXtoBH6raf3X7OlFQT5zv+IAe/Wsa/MMx1icA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 11/17] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v2 11/17] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHcy+TIqGBEg6o9N0ylzvr2+zYkwg==
Date: Tue, 14 Apr 2026 08:00:39 +0000
Message-ID: <20260414080025.3005916-12-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: b58410ad-8e2e-4287-1483-08de99fbeb11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: xjVkEeHbOkqw7UlVEJA/9Kektn0s8S4Kw1QAuzOXxMbMNa28KrNxAmlSA5D6biMlO8FqrVKKPO93vprfWFeeKDqvQcQ00qekMDjpM77D7klHIZgpBa2KQR5vOg50HooWPdI5g0iUN5KNNKQOa1BBX+Z5nhPqqzXN+GQIs2VdO2jlU1r/QKqrdw3OOwZii965IZunLzFHBmO/wOuG4ysA+2FbJSh6syvcsOYsxgs5oQT6DHBCB7iPDO0zrXlzmXoWfJ+Q/5EgT+2pAq2bR8940aAKMSjDUZ4KGUZAaNSuxLU8GbdfOyN5M4VP8e0zyATqclrZtESCkbCSt0GNIDmlZadNquI8QU8fRoON1sHUP/LR/gqLIh27do8GaVRXKGXksjS+ciUedivsoMuqX7NLWVx+n5VrErumhp846kdZEyGSGY5hoR9v+qN3YLlxdiXlr7Ei6cpnl3t2/yWu5RpDci+IyEPuAS0v1/LeNL04sg297G0bssMnC7tGKJq304AkbOEDiLavtoIQ1NWQfKqa2mHCBAhfXKtP/vcHXRt7+P6mTqk2lZDrKBs+mTulkNeT06aVjjy3vgK8cPOu8bsD/fX7pcD/0ZnyrrSqSvyz/o4a2l96BNEJJmYxoDdzzt4O7QQjS1UG1Xdd7Yd+pIuYIm3VUPTzCDyEQ2Wn5fuQKz6WtGrgak5ffZBiMrv5eh2AYL9l3ya2bvqYhws71JiDTB9yXd9xuOswdwRK3tcCUIUZuuPExvWq21ZBrhCXbfX5fk4iDmiWCt2qpWqSKO5eGEL+d2tx+dKPKuraOS8jfsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FmZhJXfe3jrBs6nTPiLdhBrRmPtqJfPYh+wwUI5imiQ/5OVOBRPIxuhrRZ?=
 =?iso-8859-1?Q?UiJJwje7QdmieNjpighT4wy8ftR3FBVa7vK2BQOcylv3sghgceeIGaPkNH?=
 =?iso-8859-1?Q?2e0Z5P9mliSKVNTMDrFjq5t649IB7jA0SKNfpFp1jQAT7v2u9kTIZyjQG7?=
 =?iso-8859-1?Q?1weZES6cM194ClX22NFklnUvC+jJtc6m/NnMTRoQUTmOohRsbHAxVAtDds?=
 =?iso-8859-1?Q?gTKeWZL2ZS9wCgfROQzCwOLDy7yIhs0GPuoFG2iMDV5HPC0Ee9wMhAJTzC?=
 =?iso-8859-1?Q?r/h935aj11N2a8QSZqpU6+pt0NtObLCQWm0Y7gSJHWO690BcyALNDicPYZ?=
 =?iso-8859-1?Q?xiegwLldTaeNfIaoPlazAEzmWrtD1NOmviD1HeQV4Di65J9wVP/U5flmKS?=
 =?iso-8859-1?Q?FUP4suMkAsubeRK6v7sbpKR3VjLNH5YOD7mOXfIBgvz2+yY8CtMqDPi537?=
 =?iso-8859-1?Q?lVhQKvcC0rjFDzycZhcRT1kCFrxfuHDTFrkPu5I04xdIQGIsT1ReS32FSC?=
 =?iso-8859-1?Q?HGDTo8nUCmKlO4EiQV7j2rliE25TL0RcyGXi4WEEMiuGrW0yOREKx4HHA8?=
 =?iso-8859-1?Q?QjxRGr68xS8PvfsBLJy5aMx2RLzUDaEQe7MaZfnSX3LAePHrWxFpJoG256?=
 =?iso-8859-1?Q?D33TWhRqDeekP2ZF72lbXU3lc1sZlTKkHbkU00RDED7DW77N2vV+X25aap?=
 =?iso-8859-1?Q?H3x9A8JxeYucd8APPc8y2VZWzJgCZrQaqL1whlDZ7vL9reknyKvEUPfmGS?=
 =?iso-8859-1?Q?AUo2Wx1JiHaehtNoHIOS1/dso/IQRmbJqfU6CER+JbINewuNJcLW1DAydX?=
 =?iso-8859-1?Q?EBBt/PQKo+oDwC6+03HVSHF3pLlVl+VlwzZiVvjc5ImTJoXMI268z/xXCw?=
 =?iso-8859-1?Q?2mLuI32P3GielwWiwbVzLQGFoA3BTPs9RWov5vp/CCpBfPaIJp7nAHiRyb?=
 =?iso-8859-1?Q?IF5UV3jwAdBuDkJ09AH1i2+0u2ZIuE5sNsKnmcDGyNKp0+P6fXSdXc3GNo?=
 =?iso-8859-1?Q?7YartmqRU7+yLRaknCFiTkiRp6Yj5ublmQcu9VF5ocvuvsO8bs65E9CyuR?=
 =?iso-8859-1?Q?bUCqjGHFTztngLMuGynS1T648jyrQPEhgsjRwP53K2iSTcyLnz9y9TLni3?=
 =?iso-8859-1?Q?xnCmJxFvfyacShEzTKNSo7541BGB6eyV0ewuaO3J6n5Bd0n69RRv4aAj2i?=
 =?iso-8859-1?Q?pvJdjjCltys1TDB6RU4CVNKk2wQkJQzln9AzgWdtraGJweldJ+T95zEgV3?=
 =?iso-8859-1?Q?ZUOcha4ciwJw3Op39bofBAdEzwzcgyGFnTObZYMiVn9bbskk9rdnbI4tAD?=
 =?iso-8859-1?Q?kRfdLClPzXPbzkITwySOXJiqekmBXOPQ4Z9drN0p/o21H3yASmwqrdmb0c?=
 =?iso-8859-1?Q?+PGSXuUA0zydF6tb7GFw1EiFzaJeuIn2G+WQ0LRQeNH+7Dx2Aipyxwg7yT?=
 =?iso-8859-1?Q?Zgzf4CanLspf8VQHoL7LURdL0Gac2FB1hxP5pUEdK6paSalAt7m/cVFEZU?=
 =?iso-8859-1?Q?33Bzai9N5+cX8yTTDkJUs3m4kM+QMGLIZd9Czuco4CqyetqoU1fsOn+nwZ?=
 =?iso-8859-1?Q?KAl7Ock+RlGG4i8BA6pghfOQmAd/Iu4Q+mfnsCyChbX8O4TaZGatmtzu9o?=
 =?iso-8859-1?Q?wFv7Qt+JeQIsqSfhOhWHlc2Q6dI3hq/COL3KbNzR+70/Cv/+Dh6wd4HHNF?=
 =?iso-8859-1?Q?/t0eqboWNmtbciGQnf6dZk3rx3VEHrztcfXoFOjaSUKTk1ry/7z8VEo8Vq?=
 =?iso-8859-1?Q?bhlVNzW7MjL+cSShgScuhchg6Pk5VL6ai6vkFbulA9+r2DBFQQQesFFz2v?=
 =?iso-8859-1?Q?1iO+zlyP9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nG97YbWyHEXIKPZE2cmm3bQQ8/WzVZlqWvufYIahAafRD4b1FU1Cl8VTDURd8eYc8Jsui1UmEJGcEB5QoDWCph/HrIfE39fbshEqsTxAUrg/S7SWm+bNQ7gnfggffixmJm1UT/GQt+lY4z85dt/2N5iwa2Qel4LOv17RF5zs8zSr6yP46RE3+uZFl7Dgcevy9W0+VUu0EnhnxvoIr+fxI5ReNuVQShAloU1G2lcycm3+F5ayRcS73o4N/HChumYv+r01hX420OM0d7NXUhWRgqJejNiBgLlY7RxoG7Ix5Pg7R+WdHe5Df5s8AacBKo4aS5CeDMBGE48q7VQJLXZmow==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58410ad-8e2e-4287-1483-08de99fbeb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:39.2124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLRAwxUlgi1mHmvhaeeO2gh1tsp8au1lapBZjHZu8t0sldd8iorz3GHklqNraJhQgWcaTxwON8oTbeYLALrVc/a8X5faCy3mQTkEhenNacI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
iTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the iTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for iTD buffer pointers.=0A=
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct=0A=
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields=0A=
when processing isochronous transfers. This allows buffers above=0A=
4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 9 ++++++---=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 712de9d50e..af8c080c60 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -63,6 +63,7 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MAXPKT_SH     0=0A=
 #define ITD_BUFPTR_MULT_MASK     0x00000003=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
+    uint32_t bufptr_hi[7];=0A=
 } EHCIitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5d070e204f..5d61b1dd64 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1463,7 +1463,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1471,7 +1472,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     qemu_sglist_destroy(&ehci->isgl);=0A=
                     return -1;  /* avoid page pg + 1 */=0A=
                 }=0A=
-                ptr2 =3D (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);=0A=
+                ptr2 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],=
=0A=
+                                         itd->bufptr[pg + 1],=0A=
+                                         ITD_BUFPTR_MASK);=0A=
                 uint32_t len2 =3D off + len - 4096;=0A=
                 uint32_t len1 =3D len - len2;=0A=
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);=0A=
@@ -1761,7 +1764,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
                sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

