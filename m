Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75408F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsR-0008Kj-ID; Wed, 15 Apr 2026 21:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsG-0008Di-AU; Wed, 15 Apr 2026 21:50:32 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsE-0007Ut-KI; Wed, 15 Apr 2026 21:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYzSSGUll0UOJRtqIj4qAAVF2qnyTnNQy+ylOlpjNNW33sJx9fUVDkCl6EmuYMmkZeQYZ0r4zW2Tl8j2++zbd+XUqVqKfitsyUSFyRXvsvhr2QGRIGERwQO4dldogUyO3oitmU2J0jRUo4DtAZSCcsVj0MqHnMq1yfrC6ktAX55qohYQSw3bETgEZaD85r0YfkVLUEIG1mrd9ZHmDzU96PX6ntW2KVh9Q+jkcrCm66Epv34dGS2KIiS1Hw5MYnhjCTkaQ4+9E+UpvcAhJ36ahjO8bcUnHtFkrqTwnKe+Q0pu1xbAHWBUTinoKDwIJyI5T2Ij+bKTr5LMKsI4tkkiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44rpxeLfE5TPz6spo1KIHa0PrIgf0BKFvdSNvgiaWTE=;
 b=VpJBJf6EcPhDG0KUyAHCMKJGGmjrAWyTlE+LoLbDX1yX6h1o286d4Jfv0sRtX/3xyyN33pYC5sm2+sLDv0wd8CkPS+n+DG8vhJ8VnMf2FrSm9NpdOuhhCcKGIfA5okkwkhH62EkqLIsK7242dGFr6Vr6BajEIHbclb0VJF1yJuJ2iEp3hmQFBsG/0erFgEjUqFj8VsSFCf5FmRfEMvWxHSMe3h7+bJiXn1DWxUJb82DnZhoh3CLg0+gAloF2JZvF4T/PWpysoeMsTW56OzxihsQaBKk4qBtcsLInRUilW3hi60AwDLPsRRpj1b29jKwDZqRcM0r1uVPfctHXxlu/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44rpxeLfE5TPz6spo1KIHa0PrIgf0BKFvdSNvgiaWTE=;
 b=BqWRd7+BOwQ3To62J7RvrsOALvz1/lEMzZw+Kj4HaxUAFF2jfuO0VZG3UgnaUzWzEkSdFF2+LmDr2+EOCNKGOcqwUtSdMRTCo0GQrxmA+2oCx3gUEBZkBZYrfFNC/P0kiYWHwDHEmcZ98CInroUvc9qTomgNfDin/U7em23K5zuzK7TyPVEg4UuvKWp10z8pD2EjzvftIZGV9mVvjy2SaW/St4kOiSrOrNS3oLt4jyZUmdI774GgffKvWVleupOFcNspH2o9NwbEJt0yYltC5r2h485T6vioJChMLJubCv9bLk99VXYdBS3yif64xpkkuHCx0AKemzAo2d7Tkt3ENg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:57 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:57 +0000
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
Subject: [PATCH v3 12/17] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v3 12/17] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHczUNTnR/OW0Fgz0S9st3V80uVyg==
Date: Thu, 16 Apr 2026 01:49:56 +0000
Message-ID: <20260416014928.1279360-13-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c5bda57a-d4da-4b5a-31eb-08de9b5a7677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: r//FrmjIKE105pGtijZyPZTLoECXTK7jenJWV0pbYltoCTysK26uwmy4csbg2YKZltg81lHqn5l0GzqqzzLV4wGCJiLRIsDjSdMOmSKpvSMz1V6fSSr8aGMzIu+QPNwkcj4XeGBnjumcgfiKQIkL1BR2L0MY78xgZPeqtyJpSd4UgxutydTTbnlXGnzZfI95ykJdbcTxydv6OGSyP/1ZfC0bXfoUyQjDHZCdcce98r74SeP7Rrp0rXor0+/Ls9s/UTzNaWDYmrhBvnEqaEKhS9fUwYwJXBJ/mS9CreiKe4sAn/7vDrbsZBl6MoRyocoOsdgdEZ1Q4aUMiAGVu5aGqMjnwsNScGYIQC2saI6mZtsVnayMC32z5kfJnZdUAXoeKbUrDmO7CrbsiALmkXf8F6WJD1V1JcsCHemBbdvxxxnyp3D/TdqnXunVBlVBDH9xY1kx/fvNNyuwT6uPWZ1BHzMBdaJM2RiRk2+PMR+6hvPe9tyVEvQD6biV6O9dlsKj+LL1ZH0JhlFmRKXmHGZhehwlrwVHza4IZPZIQkhFcKDTdqwcox+0DMNpNogmoqacEHEW7s2Sc4m10SXhXulc5IBWFH7S+Uf/qYsRnJgMNaawdbNBSfbSJ+JlYTny3ZFIaJEZgj9ByFB9qOFQCiSWvM2pJH+Nm77WpuhjF5CDs4m+4LkM0lI9ijhsQJy1yOKU3DJGNxJKZRFt+4yc5UKbueVuqZZleJum5HcSHAeJeXuykvTP2xtTjoERsE1tzdEPhcojppjyDVwgJqyxq1aAipTPR2zb/OAKXmj0/e9CcS92hWgcCFyFSOiwVpEe9mov
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kVA2ZH2xAVgw81G+VxzF3xe9Rupt27VhyJJXL89+fLVqX9Hgxc3YKz2/7W?=
 =?iso-8859-1?Q?fpGzoOq5V34nPEbsrIZbrYjqutIfrSYD1TY54ly0s9115ZqI/fHp6IB/vZ?=
 =?iso-8859-1?Q?0zrZrMrwuh+R/y37cw1csc2AFkPvg4VHYJ40dWxw0SOAQmRpZMXHYKyTKA?=
 =?iso-8859-1?Q?tYly75q/NlxCURhEPLWROXV7gecFW4PNlB3JgyJOYWakDw2jSHLS2ODDHj?=
 =?iso-8859-1?Q?+AYhHqxkST6Qb1ACWiOSghMF+s4D72dYx/sdMirMl/0f54djRSdHQxJwY+?=
 =?iso-8859-1?Q?jhB+qqD3porU4eCe6XcJEWhQvAaq9DS9c6a8MH1cDQR4J/535JBFWKeLje?=
 =?iso-8859-1?Q?n4TJFg0b36DuVPbYKHtNsPxpeTRLvmtAEIGsDPSEavmGRNLyT6e8fTVWhR?=
 =?iso-8859-1?Q?ahaZUEw3cI1qYasU4AtirNCPBrhMQ57Kbu5hGR4Ig0YQVjkeEeOy60CP4Z?=
 =?iso-8859-1?Q?Cuj22BmaHqqBmTwXJuR0PhYN61y5Mff6D5S+JKXAe8BjMt+0ZhYLJi83Jc?=
 =?iso-8859-1?Q?EDujkKX7b5uzwOfvtyYzJ6F70wQ8JurgN/tr/Di37hL6GD+xNJ5qJnXpEz?=
 =?iso-8859-1?Q?jMe+ninb9RoeY+LfqjPtBcxzyjQqg7Cy3JxY1yoEMLCzlkOrwsqoEdf3ky?=
 =?iso-8859-1?Q?B8lvnqNFhPC7vzZWUnIFNx3Ez1NS+gj7J7elehom422QM74RHeGxxjxV2w?=
 =?iso-8859-1?Q?HJ2bE/kfzxc/rM4RQMcpbd8NVuoh76XYpCv5gnsevKeOWaCpCQC5staDD3?=
 =?iso-8859-1?Q?gko68G3wRufacb5IUIBZ7qOHRiaJArMTnBEmCMXk99boWTqzaHNvJBpLCG?=
 =?iso-8859-1?Q?1IvpTlX4KqCNE5LkbwRtgCn8uPsgjPQzz8t4GYGcZRumHYDpaz8dmWLuns?=
 =?iso-8859-1?Q?E5zC2gM0qYEwIBGypfFU3l/oE77+uasL5+3wLdfZDlRGAplRATBOBykUmu?=
 =?iso-8859-1?Q?hEmzPxcSu7XrqPwZorqr4q01Sx+dHzEzSfBeP3xOA4ZBdpCtPgoIScnnu3?=
 =?iso-8859-1?Q?UilVJkGKIDkTpGqveCEfGjlyM/Sd2BxiHS2APYAsSnqPtiTjMuLWJpLcx/?=
 =?iso-8859-1?Q?rGfAC7S3fkc6UlU4HFbxNW7lFFufKTfZyZ9rfpk+wr8PRCcRNESw7ciR82?=
 =?iso-8859-1?Q?Rimo/fvT4pqFf0KSOnLzsnOXTpigVRlDfTr2b5xjU7hondtst2obwJBdOX?=
 =?iso-8859-1?Q?c/9jZWjqIuqDR1qKdiBq7k3o0y9uocSf+LGbPoC9p4j3x6/7e2wZWZGTIY?=
 =?iso-8859-1?Q?u9q8ho255HU6zT0PQFdHgE1SG7+4SqXzaj2JVg4BFfQd8Qm9+xBpoHH5Q3?=
 =?iso-8859-1?Q?3ej1zz19LArF5HFB5iIqugA3y8JimAuWzMg3HmjKH3raOGMR9dLLUUWOHY?=
 =?iso-8859-1?Q?JAAEQoDlPzbk2TGtuQ8WiphCnN9/zgAvDtV21ac06m9FhRgOUWF6dGh2ts?=
 =?iso-8859-1?Q?fOVsbsZfZOK9Y7FxK621kiE7//1nTudY8tq2KK2sD4RYY/NlX6mlcxpztl?=
 =?iso-8859-1?Q?wUkw54JyxjS05x/nWyAoti0flTLN4P+FwvJ9v1pzfVvx/hmVBtn0dDemPl?=
 =?iso-8859-1?Q?XkD2JmJa2mumVCAYn86dsLuSNqobWQTm4yoI/dQIn2stexrwAz9sf4ikGn?=
 =?iso-8859-1?Q?FKCSPIIBJy1cmM6hne+W9zfAW1W/Q4YUo21b+2qVis5tU34EDmQZjBTWp0?=
 =?iso-8859-1?Q?DmEGk3DzDBLYedIngSuBeBYDjElGW81WzTio4YWfIw8YoGKya3mR0BuJRY?=
 =?iso-8859-1?Q?NH0EG1VJFc7ebcotxjTkwj4UVS3ZufDBcwlxtQ7cbLVU3MMEZrFMHV7lzF?=
 =?iso-8859-1?Q?V2mCeCcm0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gfdpLbq29CeAUiAQg1v7Krh+NCWydkoVSciCAM6ef3E6fCiNFTkdxe5KqajGI/L4btDscF94fbOLeQe+1YuHq55dbmC78sBJtFupK5gfeRNT2RPJDUcyrtfWa5RWKhtRZ3JQKh+daXuBzoqrux3gKb/FgjfttCUodFsR3j/AcxZA++LoTklNWdbFiIaJv20doM4kdJq2hkPW+CK8rF74QHfAeKLSE/7dcj1U8YyqseXwv4PIVPtp4WTyCWy0JG12aglL0KNevQzNsLf2Qwzd4HVY7/od9VUv5uHZ3ocdHznxHa7BcaNEIH9Kye0WoEBphk/lJL92JH86YkqN2Majkw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bda57a-d4da-4b5a-31eb-08de9b5a7677
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:56.9792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jVCjunBv73pX6KfaTr/oq8FaCURZTHp8D8LfxxFvueVd6khX/vwjzf/Laro/JKe2t3IMlSLwzx0N06hya/gl+Xvhcmf52HADAvOzcKv9Vc=
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for siTD buffer pointers.=0A=
Add bufptr_hi[] fields to EHCIsitd and use ehci_get_buf_addr() to=0A=
construct full 64-bit buffer addresses from bufptr[] and bufptr_hi[]=0A=
when processing split isochronous transfers. This allows buffers=0A=
above 4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 2 files changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index af8c080c60..6406f536e8 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -109,6 +109,7 @@ typedef struct EHCIsitd {=0A=
 #define SITD_BUFPTR_TCNT_MASK         0x00000007=0A=
 =0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
+    uint32_t bufptr_hi[2];=0A=
 } EHCIsitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 3db1c25e4d..e1d5ecbad7 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1791,7 +1791,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

