Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADC7ED7B86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhe-0003eY-Ba; Tue, 14 Apr 2026 04:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhY-0003ZD-Fa; Tue, 14 Apr 2026 04:00:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhW-00060M-F4; Tue, 14 Apr 2026 04:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERjXc6EzoKNK4vNA1lECWSPdZBSfmp9Z10nG0W0Kg/BPk2KAEv1f5z4ZM7WPmgXXMZdhr4JuuZ/GCDL56uLIFvyH5R49aq5RYVNhopHMPcneN09Zc1dLFd++otFcuOVmHHqmAulO3xvFS+Ks1oJWnkutyHL46KKarqrgMltFhiczEegii75Zhhly+19PQbvuAmn4+23iTmY1GeW4fumrCtqob9qMYTn8kWISez5hdwE3WLbSQXMwwblE0SOwwKkwxlh5Ov1PYz3DDq+XgKXMKyQWm/qYmvqn/tUomWTfIzBAOh58nLwiV+8FNPLzDUil34O6Y7D+AwEYag+UuyCMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SttPpTtS2xkODYGwFInJuvplfMl6KLJGD8oXhnldHOI=;
 b=FUhfwhDtYOmaDVqwB1Sqx30ML6rcyfcxWB5WDg34HD3QwGCw1/AeRlKiedSu1m3oQULPgB/0fHU1guj3zxh5a+FnbBqGJFC72akakCbHprKQNiKWePGozdJ7mUUqJZ+KMw+cENCgSvBeZJYioNZMCtYcuTPeRC4UvlqNFgJTbl7IQuvjJ486HDH9AEtS/YiKw2ct1gPQZ74c1KIt5XsrXtN8IW+stYO2BqGRQg7a0eWaxsfViJqUXd1iQvZdMd0vWCXBiUcsdJn+znebI8KsVPenX8Tu4LGW2VlFMdWnDB4C0jstKTo83nqB/wBa1dSzzCXUpatHrKNAFq2bDLQHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SttPpTtS2xkODYGwFInJuvplfMl6KLJGD8oXhnldHOI=;
 b=jYZpsxi0f9lc0E2scSyOKkx78zBo/UbFKTLDwTGsM0AjDQ4B2NGyBeDlG5r9AYfSF9EHUR62KVgutBSmzT2VR7eE+hIEIITWSb10AzOsuJfIlB1DcgkqkeM6YYIDau1S2re37IFezTp0CbcUgIizD4SUbs8ECtmeVO7bfVEfQCV+EK7xfCKdRuUdjDuyfNxGwWUi1wjLjG8wEMfQaY3U1dGUdGvGUdD5/zqk9/+VygM3xTmWPpCtgYdAZv88zW5FNhxwUd/QvHw8p8dY1BpdV/OnQTs01IPcikfvHXmiIIZAnqVATFTEFUoPaD/NtexN0wX5a/6wnwovXbeNudQPvg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:38 +0000
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
Subject: [PATCH v2 10/17] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v2 10/17] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHcy+THb5qoE5nHt0KpM8UKVJWg5A==
Date: Tue, 14 Apr 2026 08:00:38 +0000
Message-ID: <20260414080025.3005916-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a54e93b4-2270-45ce-0cb8-08de99fbeabe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: khaOERuK5IUJ1GHYZ5eGt6rOcYXIqDBLENSN5sCEjoKcYvmelbCCaG8CAv7mWS9PlwpkhQJ9xilNT+BSlt3vtS14qEYThcWrjVYy1TrBLPHXNLkdRyrp052BJG2omWXS9/78aodf5fgVNxaspnc+a/85asH1YXP0tU8VGZG617K3XGhMAzPn9ld0DhAPO3cx1lgfJvjxmEC2dJtcJqnL32I3TitguJjb+YBeEM/Fu8SJd2lxLAThscOW6/E0Jy/GjRwS0G0xMrPcspC89Onk74/xhuFzmLM6kYf97T4EGxnLzbXm27/Goob4hHixaK48kOYmMk/UZp75GCFpq8rq0VbcXbKS8PZAc9Tw4TBVwwow0TQc8lx/8TMXM+rT9UXWH7GAtPdzexPMue1ovtjCNFrhHGZcoBSVdcqOc+rwi/q1yXBdaFzJyl/ml4U0u+CJAkYCrzbDf1m/kWcWqMjhaSSzmaVVntw8MdoG2Re0rugsGZq6Mtjkw2ikv8qDzSOzMSHRAg8mVO172vHETc9vzjYYf2poK1RjN7zPa8EgSdDTyvX66WZbIjDqYjzkCQEXxm8WMSTkJD1y3xNyP5l9F4p1nX/YOvK9RJmQGKvjh+le0BogNTKbLY7T/xbwm/Nt3a5jDZ7H/+cntcu/jrbOz8OBas+IANxTUtuKGj+7p7Gh4b+W1PFxwzsHlqkWqw6lLMMGLYWxBpjYcXlW372FTCcuEKo0AnktbHjOGcqbJEheVFv7vv4nRzF3huRv80FvXpX2FqUnGo53JcR887biDgDC1wUtB82hmZKN8VAlMzM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zMbOsGZltDQvWIKr16NY5W9ecCWcGFmAmnNMEO9gzEpokKGDqkMqc3FhGb?=
 =?iso-8859-1?Q?tm957euxHkTqxbxFVuy+8CGA2wf8l+kwhMA8HvQ5IfOiN9P3Cm5L/Hayh8?=
 =?iso-8859-1?Q?p2wZOcN2c9pWWSy6DsDZoeVPKD0aPWkBmLpMKgk9XyMyAThdSOS30/xG4d?=
 =?iso-8859-1?Q?uVBnCJzgvb+Fpg0x2vuBFm2QaHhy1KYpMVMFlRRBDRJ9R/ILlrggnMHNso?=
 =?iso-8859-1?Q?y1mdu/SA8lBGWYDrSbD3WdYDZD1KwvOygCPqbgdy9ouYqooRN1t0ah8pPn?=
 =?iso-8859-1?Q?IXixi3q0YX2iFBQaKWPt3Yl3/plwMVwvpM4HiXToEcPPnsDXMvBPg2suBf?=
 =?iso-8859-1?Q?WNIdHLk8Dy/cmsFsBR93oZ8wiDNQfCUNcrOTnm6hTZ4aAHSh6J2G9N5Ujw?=
 =?iso-8859-1?Q?7GoTYWIWpKUtHjAyQkLfPTTmnLq6+c3wwbx7QCKI6vm2ECb7j1mGXHb/lu?=
 =?iso-8859-1?Q?Ph11VLcYsIN4z47DFH4HU5LLpyq5oXAUOxfiZ7ys5R3B4gJ/k11Q8xc8TH?=
 =?iso-8859-1?Q?2k4BF9RxKMSV1vCodckj7Jp2EDa0CG+Oi+nSfxi2XB3hRdjPUO5PCAqPBF?=
 =?iso-8859-1?Q?3NEaZ2reOFnL8bYsqghoH5IwWjf0zNu99h2BjuQvsZ6izDyod4LgL6qa8H?=
 =?iso-8859-1?Q?yZWllIcHs7Hw6Omw4Yj7jTV/kzp49DzIsdF4cKt1T7LslSALMnEbGhK/+H?=
 =?iso-8859-1?Q?TCcsJuR69pvIEq+K1sHaZL2veMTKfjI7T1eqxqY/dkLqO54IA6xHe4VKk9?=
 =?iso-8859-1?Q?Q4374zNyu1SIP8pSw3regCnFKUcAXEOVeyYC49RXhl3JbpgUq+/cP6ytQl?=
 =?iso-8859-1?Q?hzcQoBelwLWQk0uZA2jzvtrN002hQwUuSCMhy3jfJXVJ2vtwuL3UfB+5M0?=
 =?iso-8859-1?Q?jD+GY9S3LiO6EUBOpppEzB7tawNmsltSYPI7iViTS3GaYi5S9ojk2F5B/Z?=
 =?iso-8859-1?Q?jqzTzyjtYQEN0ApBwnhtF8WZalLeKoHjcnzH5xDCVqC25X77ynGIuEyc8a?=
 =?iso-8859-1?Q?HQQw/znsvnndodH5gTGImG2oesZLQttsBjl+svxGfXIBRNbwpq0GNVROa3?=
 =?iso-8859-1?Q?tEApUED6Av8E+dP4hkwHMyAMWRBet5mtCAt/wGaxl0U6JuEo+7nQyB2fK3?=
 =?iso-8859-1?Q?HoLNrWK/hR9CA6KO6jOFJcNhWQYJvEnrbebZcz/jNEvfueYjyYd2+eHL5/?=
 =?iso-8859-1?Q?9Xz+ZaFLZO1QJvjrJPlshMi7gcmh61ccNUMTsoHiBalotSOoBw/njkNPjh?=
 =?iso-8859-1?Q?IhgWKTzfd9dkaC70gk+tbYjNRkvulUdVrcNqRSV5UlGCBGw7INs/AumP2b?=
 =?iso-8859-1?Q?pXWSraLXtgQ1/98xrpYXkqtSFgQnmNi4ODNmQlScbmdRgNu9w8NIWMwD2k?=
 =?iso-8859-1?Q?+ICpD2FZfYZT3eEhN4rqMCL6o05OiE6Jg7HNTv+JWIEnT9fISbP36+aU6K?=
 =?iso-8859-1?Q?+9MD5IzvDOHh8V253vEEbaG8TO2e0jXz2uEKemuKEZR9Vv7EeRImWxNPQV?=
 =?iso-8859-1?Q?0wW/ZeSQo7hfpKga9DGEr5DESm6ApWJmB0DX+n+j3SR+l9kpqjaPF1X1Ab?=
 =?iso-8859-1?Q?s5Uixs/ugcMWFK4tnOI+RxeMS3Zoo6/HX2NfBjGIPgMipyYZoXn+D7aUsM?=
 =?iso-8859-1?Q?KjUkBycXKfZ5z74DP1+tqGQLIvH9fOZOFCAGdhEdGB6mY7gdM+rKoz+rgb?=
 =?iso-8859-1?Q?2fOifWqVallYFbyX3AnRuB1oN0Q4Z1uERQBUBijcKS/BHjeWrGJvzN/ihT?=
 =?iso-8859-1?Q?kki5NHLR8ZK6vhTzg4/cKuFzL0ZrmzQvoKeAmA03rQhT0VL9fKXHb5w65p?=
 =?iso-8859-1?Q?6jvqI2oQYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rx0awyTsD2N6pii0+jPq5cCo7ZUEmEmezlNcKIOZGGFwzrTQn9wnoGRf47ex6gExmQU5TaAoL3IpqaZcIPnJlLWIjdZ+M8si86Z6bSzumQA+yPbxTQFLwrQFe1TGsh9nu/z+CpcG4pq5Wu3UixwEWEsOJJnBvoalTfIdZ99a6ta8j/EA9BMwBDodFiy/e3fb/CxFiMfHDrW9j4DZR5uXtd2q4pjhlxdIZKAKpaLMHG3bQ1JdhhIVuxLxbhp49NLyPiWLttd6P5daUepTCJ7WUEuyWUgfksZyJAkyxNwW+pJtsdYTkMmVeq4tMRpF5SXZkooQ4qLBzh+3oEbCMBzdAw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54e93b4-2270-45ce-0cb8-08de99fbeabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:38.1020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMKJneo8VjixtYtzFP6lQTrQ1lPzE4SN9rPMWK5ZyqR7xDxCJpsvI+SjSYz8CVC9Q0WXTi9DmQUDMbG8UgQVw3Iffj7iEfStsS2m+av9cMA=
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
index d1d68b0342..5d070e204f 100644=0A=
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

