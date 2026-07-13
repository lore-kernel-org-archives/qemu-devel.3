Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F30DC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7Kb-0000Bh-26; Sun, 12 Jul 2026 23:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KK-00008y-HU; Sun, 12 Jul 2026 23:27:28 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KG-0006V2-NU; Sun, 12 Jul 2026 23:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBIDOohNxV0xn7E+Feu4+hKtOdaVh42pPIUT1BlAfhZnFGLIpJuZdN9oP6dkUbX7OF3j7rMFpZDKrGk+T2nBE9PxgnaBENCWeJtWYBkNpyU0ATotRwfa3dTodgGpT7M3rSmNEgEFVO2SnPy+s+eCgy2A6ideVBDZDPi53UnNm+ReZ14CvCCBg68lY8XXHdJK73nW1RU91lhFh8dWdL3D0Kvu0UqIUUwlltm+9wCR08V3nZWMPKzkd642SofWxrk+0kA9f9Acq/infONtW6paxQosObCodJpiIfMlym7WQt93ZBhFDmu+4UcIHQ3yHLO3GbChYMUxYIDRB8TF6138bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUY/FV2gobkv8fY0ddb17z2UA4FGou2DvIaYYpI4HLE=;
 b=kT7l3rTGaUN9IfbGwr34Gs2Gl3omAsfS6Gjl5Q94vr3cUTDGCqWUMFfPpBkEgjHaDL1EOj3JO/7TsJm0+HL2z8JyZKxtjHjCp23to/L039mVZdVr1zsownpYZn9MRz7qR5bEpcnaQF3d6Opj8Xk87AUMYfCFBXGyUYeYm7EGByedjO7SMOBb1Ldowwh/3jOK5vWanc/YQT60hmEU2xVP3NGRtSx0flyidn/JlegptI8cMP8TAbhqqVRWp2N5Zyb89C6Hi/XY19uBjWS4Z+Zky26X2YJJPmwl1KyRdk0TfjxQ5Jz8yDbfjBAKNTuSurFt6MQvJOjylfLfVvCrcR+E1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUY/FV2gobkv8fY0ddb17z2UA4FGou2DvIaYYpI4HLE=;
 b=Aswx4TrMAFVT+bExdIR48m2b3IH5YQA9IjDdRoT/2DPvk1LM52Vn48rONkZN6CC5C21YcRF2WhCBt/jaitfJCmtxBs4zQlpzOW4MRdoua+sTsni1RgNC1257PDNUNjfK7hYEez9EAIQyolj4Yd6emDYKwcErNczOcDoGMzMeJHsa4eZwrXbFPD8VP9PwY7ddK0ZVWlFPl2Wjkxo0td1vW2fBp5ckJBtzCe8uCbWs3my5Zv39J9SEGMZf9w0O+iswjudGcr8gaWgbhPr1oX0aR74gDJ9/0BBkaXmM1lXjE2cvQmNu4en0y+wayEVVM1+w8voapYrOtBP7gFyQxeYS+w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:14 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: [PATCH v7 05/10] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v7 05/10] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHdEnd/jwRPgkQplUK2XiiNUvVz7A==
Date: Mon, 13 Jul 2026 03:27:13 +0000
Message-ID: <20260713032704.3583103-6-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: 6b24f06a-d4d2-4bad-a968-08dee08ea1fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|921020;
x-microsoft-antispam-message-info: BT7inN6tm8qgMj1seU2VLu22VDjpHGOJT+ZGxRumLniOkv/uPXlWaNL3QyStRYzBqtxmqXgCLSbYenP3XcyJAXzuFV3uQm7YAPndn1/43oDgUvkW7XSpcxRdCTSwoCeQgcTVqlkNOhPjYO6IOpdyAoGhV8Et0wV2s0ygZeSDd9otQh6XdoeIzoYR0xu9W0nd6o66lWG0fw83Fp326YOmuEg5Pk0VkjeXCGkxuLX4SqbW2Z5Ac271PMHIYHLEKC+P303NcX/tl951kJHZ3V4y5DOGES99jiRdv3nsapsmYcRJIgs+AjvgIhL08XcXDhzFTxAebRVTp6ozIIIekIZy1dr237BCdbih7JtY36Y8em1DXqF7pLCytqmaE0Q/5AqXr9rbVjTLlEmzD4U3Et2OVZX8PGvTCFe7CtmZVPDaoQAj1QVcMzbgQXlnnuYSD3KI4x25iheZW/lJpAtZNB7+0O7PLQeBVUHZzY43AXgZgtovq9wdZmhX7DIqvQLEt2An/LUGLsR0olvmdEVnvQNJbqO5L+0R37TQC0dzFQ0YA1a5jbQWnIjVT9SD99OYUxql5aI8ehHUqCBSLT3E52ZzqL8upfG7WvBGN1TdDwz6QMO55rTDe0eF/vvLOa4hPO8rLh08lnhXeiXxmeYth96X4/gSUuIxqg9tbD4UpESbDLmwKTYsvs481zr+rJ5yTpPCuWq4TiakACQEYr89Q5jmSwm5ckR+bhdtMxVq3z6yWOQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JpdBjxixbHnTI6u8LonknbOlAm30/nLmYhnd9s1Sum0oz9XHN5ySLuyWQ1?=
 =?iso-8859-1?Q?FJJqVA1qgldL0Rh/xgO6Mg3g6D1Bq1vZcvCU+wDdC/HeeiaUfgeLN6jDtj?=
 =?iso-8859-1?Q?67GQtxp8iSv0DroDjbC7QvNhevx52GTBnTRj81DY50oUjsKlXx9faKEpW9?=
 =?iso-8859-1?Q?yFChkol1zqNolNGmq58dakDj66BneTgRoY1okCpraxZjmiFQBblKi0shkE?=
 =?iso-8859-1?Q?QGuUQLcIr8AroTmbt5vfHt/nb6NixIomfjOHNxoM9Ru04+k2eJHRrhI+TO?=
 =?iso-8859-1?Q?nr85juB2ekI6h2d3g95IKMY9BgYaZF54Ac0NI6tq06az+99YcSkJkkiawZ?=
 =?iso-8859-1?Q?NKmdgnJ/Dbiekhv/RJ4eUBHte/n/P1jzHWvbop706tXlcXLSTyiPK3KBxG?=
 =?iso-8859-1?Q?GMN2tF2jkV7F+kLKPx+rKca0QEY+F6bAZ3Emi4nCk1878TS4ERsDnorhxq?=
 =?iso-8859-1?Q?EDGlm0vPEQ6hLaXVDouQZ3qOOZtLGXRED6sJ4agnFd/1AVDW7kjIj2l81l?=
 =?iso-8859-1?Q?W70k05XPI66bX/hFr4+PWign07uoDk3ZJIr8KH9aP29XvkY/CNFxKUtTXR?=
 =?iso-8859-1?Q?ZZHBjGeX9ZhbgxUYOFSMfud3VX/YU/S7BzlDxhIhMC7SM+7lLY1TVtCldc?=
 =?iso-8859-1?Q?Jd/D6wAaOfbMKRUAIRoP2Pf/i7Dt9MR6oqK+coqWC40te74bUW3Xu7beqX?=
 =?iso-8859-1?Q?cfZpDWbDJNboi+DpCpD2GU6S0EzGBBeBfv6GHPhkJ1pnpSaPGTpHYAZgMz?=
 =?iso-8859-1?Q?XUfiPBzhzR2nAjek3QX+mPgWEb+LMsz22qONc3Nea9/x4lFm+qXvSwzEly?=
 =?iso-8859-1?Q?zaqtjNhKqBfNtsQfkFsnxJi7zoB1bYFHcWAFTchsmDD9kLDxkbxQuLumNV?=
 =?iso-8859-1?Q?+aPTm3XNgX6m+ryk6aVcMqMCfKgcJaicQ5CMN+iyDktmoJ0m4JLbEuaAQA?=
 =?iso-8859-1?Q?RtRgWJX6gP6hNwI95GwYjOKehmif+iIxNHlMt2cooHg5UWrHad0qFLDdVq?=
 =?iso-8859-1?Q?Lgh4BYaKcS8g2dFP1DbqFJJcn3/2hdm71dEa6hBT40Jm9YzDULMUWBDWIL?=
 =?iso-8859-1?Q?X81p9MHXDUPTrFWBBagVo3272AgxmZHvj4djAxmFwJpOlhp5JR2eQKkOTw?=
 =?iso-8859-1?Q?lUng8rbrfowwIYmil2WvKik5bfapBc5SHeRwh9DCtblQvvVOtzjzNnGyWq?=
 =?iso-8859-1?Q?VAiasd46MXIKt4wQSasR/nQIANHoC+hIo8MotjSq7JMsAW5baLR1yPI4ZF?=
 =?iso-8859-1?Q?n/Kj/vhK08RU4du9lnSAPs3KBZGLGnu56igy284ZSc07ISrlyalp/g20v6?=
 =?iso-8859-1?Q?feD3KvsU5mzVrekzhIKxNYH5zSu+LVtayjWTNNigzsi/ao7+kQ2NHlESh/?=
 =?iso-8859-1?Q?IEyZKWjdJJG2p9uZZ18/s/1ME9G2E9H2WHVYkeQPJSeVYYUfSytrUsT0hW?=
 =?iso-8859-1?Q?zh2S+dSf/TallZf/Y5JydP1HlnsxH9uHZep7mwtWBYc3PLzWQENaaa2/st?=
 =?iso-8859-1?Q?ltfyqhY/jfiL8/yRuv+mRr0zvO8Nk1aTKKzmGIhOnPBnbbTuDdjIBc4t20?=
 =?iso-8859-1?Q?0Vmjt/QwdDAIZaGgQQYaiCOTNTlkOg3qJjwG8AnnXtLZ+YWQp8XMsh3x7x?=
 =?iso-8859-1?Q?GTNIz8SVWjYIdkNeLnCo8oBDIeCC9P5/nOf/MEbJiU8EMpsAQbHRKJn/dK?=
 =?iso-8859-1?Q?DiQ0LuNWgqM6HEKNfceny+tA47lu+aSt8Kd8cg5emOjKqzNdsuJkMdhrS+?=
 =?iso-8859-1?Q?kW5LUQRZLvyIoBilcerRf/YX94E1dk3WOz1Euot9dUZ6Bz2s0Ay52jnM+W?=
 =?iso-8859-1?Q?zwy92UYeEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tB4XpYfWS59KTD1hyztZq4eX2zaocnDNPExM3Crs0QKF7OvbUVnqizASANAxasS05BNwIVVPQVkxQx/QZ2NCzjI/n2lUeP2JYVgV42DyBTxpXsZDo9AyjRgO7rsG5LFbKr9YbHKGXudbuIkRTp3ax9a+oBELepNHxtB7ZPH+gjov1nQ8udZ3TxqlDcGwAAgea4m5vNgxUpdV35LvIuD3KlnZxOU/dXMJn2qeQepjLZWOov3sMEAF4swHbIA7xxZ+jDZZrcALkAqpB/luXsML5X0+qqTyJsrsrLmG2gG0+7nMUuBc1bTktOL+xtSPMqKYo/6kkmiXF4ACAERo3kE9PQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b24f06a-d4d2-4bad-a968-08dee08ea1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:13.6173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3C6Rmy5Y1iLCLVqolZrbFoJlpyq1xzEPro5kleEkFgbTyOuZ6CsBszfs11PNK+Ai8A5ycQ4I3v4vLVI4gz2i/ma/clIczovDoEiONRDhiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
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
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 20 +++++++++++++++-----=0A=
 2 files changed, 16 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 7fed206906..49176f3fd2 100644=0A=
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
index 947af86ac4..1a286c32e6 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -105,6 +105,7 @@ typedef enum {=0A=
  */=0A=
 #define EHCI_QH_DWORDS_32   (offsetof(EHCIqh, bufptr_hi) / sizeof(uint32_t=
))=0A=
 #define EHCI_QTD_DWORDS_32  (offsetof(EHCIqtd, bufptr_hi) / sizeof(uint32_=
t))=0A=
+#define EHCI_ITD_DWORDS_32  (offsetof(EHCIitd, bufptr_hi) / sizeof(uint32_=
t))=0A=
 =0A=
 static const char *ehci_state_names[] =3D {=0A=
     [EST_INACTIVE]     =3D "INACTIVE",=0A=
@@ -184,6 +185,11 @@ static uint32_t ehci_qtd_dwords(const EHCIState *s)=0A=
     return s->caps_64bit_addr ? (sizeof(EHCIqtd) >> 2) : EHCI_QTD_DWORDS_3=
2;=0A=
 }=0A=
 =0A=
+static uint32_t ehci_itd_dwords(const EHCIState *s)=0A=
+{=0A=
+    return s->caps_64bit_addr ? (sizeof(EHCIitd) >> 2) : EHCI_ITD_DWORDS_3=
2;=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -1486,7 +1492,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1494,7 +1501,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
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
@@ -1774,8 +1783,9 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
     assert(!async);=0A=
     entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
+    memset(&itd, 0, sizeof(itd));=0A=
     if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
-                   sizeof(EHCIitd) >> 2) < 0) {=0A=
+                   ehci_itd_dwords(ehci)) < 0) {=0A=
         return -1;=0A=
     }=0A=
     ehci_trace_itd(ehci, entry, &itd);=0A=
@@ -1785,8 +1795,8 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
     }=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
-               sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+               ehci_itd_dwords(ehci));=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

