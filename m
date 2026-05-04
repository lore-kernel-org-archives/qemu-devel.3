Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF9CD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRd-0001ao-BP; Sun, 03 May 2026 22:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRX-0001Wv-2y; Sun, 03 May 2026 22:53:59 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRV-000403-5F; Sun, 03 May 2026 22:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdLxu89RSSnY06TCVOh/Yivy0SJ1kcw9GGrdBumFymKQtg7hwfSx7haBRPbltFY7QA/fZVoD0YxVtJZccKkh0z2NsaLKmYeyMfKofobHzvxrgQY869hGiyRhXr8uCPW/tVVA1HlOqVRgRHN4jUfeBq9EiCBRfk0HGXvCVl64qy/qTz1US1o4iBjp/bw0xzB2jWApZyM5y5/1u2n76MRXL5w1YlR/SseAfoBVZwoQ8YIR0Ch2ccsrxqHbv9GDDeDo97m1DGo+H29sRvyucSD4ROw3g+NZW9iG0vIsDW8MahlucFp/QAKee2QAdzzCqx0BCw6BBNF+x2mrfDuDFklilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRNT6cKI+GntcOBpk2TLwkRHFyDRSAaU1uULt+xMJ0o=;
 b=m2GqFIv7xlTjsvHadQe6IwaEqbPr1WtAoafnPZ9a2ZvV0IdezgAZYww3ApddK+bjxT/p5wc7veoaPFRUtr70LuiB88M+6iN7i3OQtNEGK5pzpe6ASHLp5Sqo/YpUwAVRVEP17Mj7X9OkiUepz3qIT3UGTSnFzHohCko7p1ws9GuL1weR38EhPbCsW4RykXRhECF2oDxv0H4V6wC3w8y1ANOFs9fa+SLWX2qvvUBqfJi95B8wwhYpPoYcpeYGFtJHWn2Ge4P/fL00GSa2H5GG45uwCpcGFPZjXbLNqojkbSei1O7INd2tk/6CqGG0nW/AOG1zDII9BROjRf3NIcDxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRNT6cKI+GntcOBpk2TLwkRHFyDRSAaU1uULt+xMJ0o=;
 b=HKhJ1o2aDYVF/jYlnB23Ifi2U8Obk/mFFO74nGJa7HxkM7T19YMpbZfjk+KmYnozHmwH3hQhe6yalQb0V10YnztjwwyPnlgbIIxMUIH04jTJ2Jj5moOldYnGXkzoTY7Uf9VqVITbLQdOsV8IzwlnTIsuTJbi6mswpf1zwL65J8MzL3SlTMg+uRFlvhTIUHR2Gz0+p/Pm9wEG7aYDfEAxzr2QlEw9RLbl78VGvrBweIqVPDJtrS9dglHkFyvURF0+Yhib+IeccZoWqnDUgGBZeKXSMskcuAVWlmBqOwPvtqwCd0Y+3+q1e4U82BNUpfCv4uugDw3LLzdni7h/jpK6Dw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8442.apcprd06.prod.outlook.com (2603:1096:604:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:49 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v6 05/11] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v6 05/11] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHc23E74ZBaR5tI2UyI+h2eiu20cg==
Date: Mon, 4 May 2026 02:53:49 +0000
Message-ID: <20260504025342.1452605-6-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8442:EE_
x-ms-office365-filtering-correlation-id: 96d9aa65-2bc1-4e2e-8d50-08dea9885e08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info: wCzm/uBOiZDMPnPwPC6uJhXG3EVEhFBwcqmvrjxf4fMYE2albkWZOfJlXWTf7tfj1AyIpQozHpNA+fosZKvwoYX5ieAh9F5L/cR7Ww7XhIzwxGhbhFxP/DUg6Zr8K8fxegC7dqLWHJSDLenMG1bWX4y6iFiMxyOcCzLzDgsa8awOQMyWHyoQmZmc77v34XcClBCD/SNWghHL9EEW1yEBQNtJCa7MJ7iOQWsGTRmMa/hC5HBaae1sZY1uJrYyQ0wRQLvGW0l4/atncDZqKmB8M40ccwp6xursGR1ajnV/dNwPLyHGi4Gx4boWWpeBbsJTYbOnNYnn9GepMQ40hco3cKcLIUPTr4+FnEX3TiIECSJlf3SdF61I5WavF2QJorFSP5xCudT5XGPxVSWmfwYB24SFv+6WaDPe6qkj+0WO2ALhPruONC2T4xJkIPrMg6MSAOYOPellnsKVgyElbJTHwC4XZN86yau/psGBBVcrobh+8VnMmBP1vxQQjsbb4kCWP5w7Reaexr4/6kBaR0OZggD38Jwx9FYB4i8fGe6scPLYZnp8/4XhdOCTzXw3NogtyM7R1mWtWTT4PqaiTlukC2SPa7QaoGiqMDCozn7LGWiHqPCOHFejPqjHvE127USbq1uO3BAivYd3js3zZgO06kDEy8yFPSYUg62GtCyhgjN9nFPC/uM0yBpHfwT6DSeXMc5TQQf7pyFVW65N+RibY9jz0Bzq+KOsJu8vagQACn3hZPgXhTZg/31VUmcBA6YuyoL1wcAxfh+nLzFiypIOZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OIIUEhRYvKll++z9v0spamG4rTYA5IJRnziNCinI/+ds08GlfErFa+bMl3?=
 =?iso-8859-1?Q?ELV3R6AvXvYor38Tcddb67g9Jc4cJmnyXSYAEEPrNw+wcEjXqqnTVOTvLc?=
 =?iso-8859-1?Q?6igOYVXbXLWOjVOXY7IfQ8Dn1/mwzjpzYrAbhUt1pNvzYA+rrAetei7JB1?=
 =?iso-8859-1?Q?2PlmhGwqosTKYHust16eow/JjjGYwpfxpsviytzlIyQn8bZ/AC3wU5e5sE?=
 =?iso-8859-1?Q?bQSfM87eJ3VMN0cBrN1+5zD9WNPagfG9Wwd25D4PTqU4iRoCSFbYQG8l3K?=
 =?iso-8859-1?Q?eBNccnuEUfvIdmfvqAw4rQ1vKOvsOYfCUGBkq/Hsc8/od523G0Y4srCryS?=
 =?iso-8859-1?Q?haqZWOFS/x9VBJsT7d5Tzhw+s0y6TgowACTRbI1KtzGqZjaqPAE29Xi6Ru?=
 =?iso-8859-1?Q?whKEWwBAPebM8q+RuHWSIaRPoCFfSUI/j7Es5o2up7w5LItcHhpGeq/5OC?=
 =?iso-8859-1?Q?AwozP29ftJE8v/pGiLDVXU5sXgULV8GVKENlklVX3dlF17uaaZBGWRBqpk?=
 =?iso-8859-1?Q?jAzJH8RcG0eLUkNNeaiNVBLMQe2OD2MCD+lXL6zTAcTEevbceasCn/kzEN?=
 =?iso-8859-1?Q?QPNDOmOvtfkm7pZQMLTOUzG1eDRNsh6ISE4zXZYatLISocpzNapn1jZSLI?=
 =?iso-8859-1?Q?4bX40FQi6JJyhBomTn6/vfWmfkO+Y1CToS2t4skD/clh/ZieLIzkzSRzRS?=
 =?iso-8859-1?Q?2YHj/RwIGtAy2L55BARsjW9tW/UghjPSTIMbT0Ww1xxiPB4tTjD6DI9fGj?=
 =?iso-8859-1?Q?Z49eFa6NhZ6aMTgxDrjQpLzp/q1VEcQbBdKxYsm7zbn8Tps6XOeFG0CL1p?=
 =?iso-8859-1?Q?G/x2NNw7j9FvXMmLrvBhUzKls/vT++k6WPGM45d3SKdN4X/dGOY6/+W5SO?=
 =?iso-8859-1?Q?x3xMGSH8rrMQpzbjBQA3UimAmYsGRgi7fHiuad4gKKOt7Ey/qOTqckmIT0?=
 =?iso-8859-1?Q?J09x5XQmk6VgNhqxOTdDJgPa1WKHeJ7nj9nVGTeRqoP3Ke8m1jIB+wLMtV?=
 =?iso-8859-1?Q?f9foV3mmZzv8cgHaVt7HJFOg/nm0+xg0CUdoo8NtZPjocE4xRqpHlii69j?=
 =?iso-8859-1?Q?Fv6btkGNs4CycfVxxYFhVLhizjaIWflDqLrlCAMKn4TLz8I/emKCPhwipY?=
 =?iso-8859-1?Q?TpvAgD2b3wkl9OvBHynxuZANI/nTj+ilS1bB/oHofF6lWIjtE7uq1s5bnd?=
 =?iso-8859-1?Q?BA/26XYspylMnnte6KsIvE4ENUc+MAR/WGcjtxFd90GhoJNnVx3JuisMEq?=
 =?iso-8859-1?Q?Y6t2efI0Nx0CKJk6E4n6Vuy80Y67bUs++qyFVKJCCe+Zay+BEHPZMdLfhO?=
 =?iso-8859-1?Q?Jhi3j/tEC75Wzm35ABnN7iNTFZZ9Se5S9jcIn5Iq9V7+xxhD9yIu/Q7ahQ?=
 =?iso-8859-1?Q?yBRFMJL2fbnRyMU0sQtqNr6ON0A/qGI8O7dPspLhpUQBXPLuWHGvQm3xjL?=
 =?iso-8859-1?Q?L/qbgVYtQS0BWRdivGopMlnifHuzksBHbpVb3pR8AVYxQ8KfjLH7jXrJkf?=
 =?iso-8859-1?Q?53G8vu0ZNV8aG9iMgQNDQF4kSBd00fVBaIrQwQNjo1Rl6a+QGet3TKYbfe?=
 =?iso-8859-1?Q?odAQL4DE3CjrSg8uJ9HJCdxKG4SMIRSl+09bt7JEoRESka4VEGPK4xexxG?=
 =?iso-8859-1?Q?4EHOu4Uj00ypt86kyY9YMN9c1qmoneDceu0w19a3zQUn+g9+TelnbiLZGC?=
 =?iso-8859-1?Q?rnD65tLitSh5FsqiAs7r5TMzzGyfCNB4/YPAkeWJCpi4FEFr3+M6tohbtq?=
 =?iso-8859-1?Q?bUsSfPWRYrcNsWia/oPngcK1z5dC2xS1udjjo82dGSU0xQZMTlau3BpyH3?=
 =?iso-8859-1?Q?nJW4fW0PIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fB20cY/HfQ3LZ3iB3D2wYyTMCoYbUKf+Gf5sAiNc8rtNlprH1IMC/CXMUOsKGw2z8hjmr3eXR3KWMfa4jJ07IARnsz67i/NP6oGv7fJbK9FHlIouaYCAGMZsI/9ppK9cZaH3cuXGB5HXDMfZjK5q0HOepsw8Q/+lCr1O39QXWHo7+rLAAPORrgXphfJmP5OL6wFn1f96bCgrMZKeWYYVkkad5Osg4N7HD6gExEvCxntTwDCoP480c4sskIUm0d9RhZThCCmKpJoLZXUN9PxBPJc659bv7dkJRPwsrR7jxmI8Lv8V/3KeUtn+96wyjnvuPDlPHX9XxTY/SO+epeGZVA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d9aa65-2bc1-4e2e-8d50-08dea9885e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:49.0863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFaXDCj6+vgWe0D6cZMx596/2Fo7o3WDfGreY8mUTXC7oUQYQ2JRQRhUL7zm/sdizmbxTEMyuVNi9DLYFVwyQeyPerrgLGOAwPqcU8E8wgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8442
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
index e770f0a7fa..238f08b4a5 100644=0A=
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

