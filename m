Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BD8C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suQ-00063v-Qr; Sun, 30 Aug 2026 23:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suO-00063E-M4; Sun, 30 Aug 2026 23:42:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suM-0006yv-6s; Sun, 30 Aug 2026 23:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgwZQbLv/1UMd6iNL+6BGDjZaf/Mv508q3ArzKQAbpRcuMmATvm0vqnfGwpxUPHKXU/F+Dl2d/9C7n0a29GGMRIlxE42c75pjSn19eracBcuPynI4KOvgmA7u/KRWdxX7e0hncWQdRC2LZ1fLGBbtkmAfTdHXMQBCdmalyMBEI/wa7UMSxFyJnietOTZFza5ZufQqvWRlI1b4tRKOcIWoiAMNNA2RpbZjDLpzWCFRFUfJUn77wPDTds1VDwsAPosUcZL3RBEIM1u4AZss206LFGXOWMorQwe+5oJrbE3CqiP7jaHFA4I8lbbxr64S/wWa8zy/WAbJ9AdsrSYAl1O0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOFQW9VGzhCVe8V8/eMlMR9nbM8WGJRSgQ4Zk48s5og=;
 b=bewvWGC37nJ2SSdwdASDll9Y+WCgeT+HgcIQDjyBmsaP4j3Ska8FgOl6d3r3XwQr1wnxnlTpm5gbcpOrz4hMPgVkiEA4A2zJ28KlHVy3jXMjIP3Ii0kCnijIToXnYzafSB6Xbg4An6BL38sL+mWfEnRsSTgoqV2/yVGykjntFyVAxi+dv4eb7TinjQVyj5M+qGpJumSYOWbBMKsbx5Vp7TKAwcl7q5uBA/azHWvOZe6qYbk4XyEsfa6u4/qkO6AfVoanD88Mq6mSzBha0Wf/TvgDVXxUzcbSuWW5VYq/BefxCoMYTKgx03jaHFMfD3pD0q+Y+7EyzVjfhCUKgg5JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOFQW9VGzhCVe8V8/eMlMR9nbM8WGJRSgQ4Zk48s5og=;
 b=o87D5MjOKSlprW7Kx1rri+UNcM1j0yJIxQytHHjFMiySJ7+E3zM9mjRWn2KNv1+y4TgpGiNA3UFgYiq+XeRPobFbXVFsGnFMkhMZ6Hn++xjG+83eWQmD/40PgSxVxKzr4FP91c2Alg71kbQK+rOld5XaZyrVzyyTz+aG5kNJKe3RDjEfYogPAZmD0OlxsilrTO28FZYQWk/oWWMku5aANnyRGnSk4zhZpyYmcKaG2ohrf3gi5n8bDvr8OR1jRCfE2QoEX8BpLMRmSMGGwhkJmE1TV6Pw+RMhzriES6NX20P9nIYmr9z/mdalhuhBiQkiS4JFwZ/UyH92pS5BXbAU5Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:42:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:42:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 5/9] tests/crypto: Add ECDSA sign/verify tests
Thread-Topic: [PATCH v3 5/9] tests/crypto: Add ECDSA sign/verify tests
Thread-Index: AQHdOPquecSz/W8IM06VPvW/WLAK5w==
Date: Mon, 31 Aug 2026 03:42:00 +0000
Message-ID: <20260831034153.192916-6-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8096:EE_
x-ms-office365-filtering-correlation-id: 5c508993-20cc-4119-06cc-08df0711d0b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 1tU0wc/S0xjSFN8rdWy78jISMUCErjGuzc5vtf8AXz4DtJDPhuKDqfX0BRkPdElrCbQ+VBJE9QH7HKIGSKUokO07vVRZ2JRlDQ5dDPYhcNLeShYzPymS6ORYj/xx/CWgetMykK+qBwSefsqNnEpy5RB6UYH3TneYpN/VNTi122wHze83U1Q47+gpJU6Wfoab+R+jojp5uExj1CqHdFOnQvW/9E1DyLGnvCrJEj8dQIjhNQ4sUUFRrJoq1+Ato3NQ8JTs4NZfJk8lEpr7ixpi+SgSm5RVZsYR37zQAP/jXYww3R58UEhpijIzeeZxUOgvzlL5AYJosI4E6J1DDr+trCt/iwkxSv4DjJDTGfY1A2lll1sbX7EDw6van3dzBVuqARDUfIjnjkpzZJfuIxyGs10Uglbp5v81xjYw/kpshEEr46kdiegILZxGr0TrPs8F7szgPXn0KdhMWa/aq6bPIKMsdEHpzP9OfWcjEY4Eb41ReyA6ZpEPuopaoiceMNssm3jINtxa/QCCoG5GO5zjjLPPUtlBwfcS94FXT4IWZK0BJkcx5YhpSV08kw6NnvxVH27AiO22Z/MT+WEwCaOqiU5N7KIQd4hV1LCfzBIXj5fEFzlGmjc3nkgvkHej/maByAGGVFnvnRxeKktsfI1wbSjj2+MHDdU9Rp+6wpZ09Y8r65UR7Amchr4P/6jPte83qszDSA7XIEF9U3Dag1c+Co+dkjvbgCzKMwbG0+w3zqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0IQ7eeMN+AyMrfQsotJdkc3hOn+MHucZAjD7vtoJieI0ct15VqKHYtNakt?=
 =?iso-8859-1?Q?Mrxi97yqNxZiyB/EapCSenLiojnNQ1KmZRI6Meewkg+N0yQorU38pVifvK?=
 =?iso-8859-1?Q?xRfp7yp7K54SzRs59FalmirGCJlSK0FJJjypps/vyMWBhLoDUzCfjCGead?=
 =?iso-8859-1?Q?kn496Oa4A1DN8Se5baE+x8Q83L1rOLkNK0HJZvK/KB3aeo0moSSzf+TN4m?=
 =?iso-8859-1?Q?L8lZPeHbT9bxquRbb9n2Q8sZXJqDfwLNUJwLgHAsd1F2qVubGihgFvjOuB?=
 =?iso-8859-1?Q?eT3NPZ/HJbHdXkvnZ/nGFqiPN+hBQ2ukvyEeEymDi8GFEpqYO/uw6WA3BR?=
 =?iso-8859-1?Q?jqIP5NsNIqWc0QQ20IvfQxTC2flpOpXyeeUACkTtfKj/5KtOVaYclIVL9a?=
 =?iso-8859-1?Q?xzB7CQz7FWQ16kChkzWBJcvO76htmshvZan11NS1Fc01gb0kIc2f1l8pC0?=
 =?iso-8859-1?Q?Lc0FLayPbUr8bYwbUdTTt/81Afgkg1OnSLbV13+1WVz+bEal6B80LRwSNj?=
 =?iso-8859-1?Q?AImqyjBnI9qfeR9yg/D1Z7VlGo6GV7TYMBGyOpz7v8inBFkOB99/2UtTAF?=
 =?iso-8859-1?Q?/f4SLKNr5byASlXsAnED2cmUkqExuFPZBCe+QdG1XdPT5UQ30+HVGkJFEz?=
 =?iso-8859-1?Q?kANSyvHMtmYbiXzm01NxZM8C/N6w5ocLOg1eObh+TyoBfxuHSAVUnePd4Q?=
 =?iso-8859-1?Q?mXp6fDt4viWWHJMErgbb62v+t1zwI+UOKavfvs1DDwoDkEpD2u6kExLt9t?=
 =?iso-8859-1?Q?SEle3l0g7Xw5sUWlfCcPIm4IhmE4PSIPt8TZ30+s+pp7CnypVKty9RvL7o?=
 =?iso-8859-1?Q?ro6iU615o+A8lcZrEc5HIVfxAYuLXuL+KuI5sleb6o81wDAU6KbiCm+dDr?=
 =?iso-8859-1?Q?coAeuahonEMnfLm7Hy3GQzMwyN8KmpDtgKdWdsBu75PcYJi5aIVhrLAzkg?=
 =?iso-8859-1?Q?unwq4qHpqq29MJcLiz6hYncJs3GWcqIgRhAyKED4LCSI3wxaurav+Oa1Ha?=
 =?iso-8859-1?Q?TGdKb6320e1pID2KYEy9P9H62klHri2iAzRDgPMx53Sb/bg5FKs/AsL0hO?=
 =?iso-8859-1?Q?yhPGk0wTmnSMUj3ghKUxJ7dqjroxKcTGCAtNH/wdtqyPK4QF2ZGlgNRDLm?=
 =?iso-8859-1?Q?fAXYoksCW3HwWArHNtyzFsGsRstX2gNSvDt6SWPLp9yRCa/TPRHCcJAzRu?=
 =?iso-8859-1?Q?roaqbv/iY/K3yYzIXqnnHtAuLyL4sT/ATGVBdMaSEtBsF+uSRWAAQmgUHd?=
 =?iso-8859-1?Q?dXKJCjI5jxbCbvFAHRWRzcz2xgl8ZOeUDle+2+eyw0UT2xBIskkL1+N3b+?=
 =?iso-8859-1?Q?UvXa7jZ9eONYgA2nQdaHIYk+LZqkYLuZvXNlHyTq//XpN0mk8SX+m7ijhG?=
 =?iso-8859-1?Q?Y98sGJcNSjZ3wGhJNcu5t7ZdMb1tA0OfB6sI/1CHgUxCT5v7am564y7Gpm?=
 =?iso-8859-1?Q?vPyHmAKmpJAeH1ODxkC8+kQUZlyd6dfcFFooTVQSuf1HyXdXvQ22QMNct/?=
 =?iso-8859-1?Q?2Yl3CLDin2oRAIQV3kbewZc9i2iTftFoxw0oasIp0ocHlVuxoSbNo2hK3C?=
 =?iso-8859-1?Q?EBO7BR4LrtY3B4a0XXA5PvMntP7oqDq7M7cFcHML/e8K7WIMSPaT4RUr56?=
 =?iso-8859-1?Q?TvXz8tFU6ps0xlTImrCajUSk/SPF9QEvYS+6iMBGt+vnHorJ9JJpO647HT?=
 =?iso-8859-1?Q?9qdJ7oIorWPJcgaW+3fS4PNcCMDfJnkZvRTsUUejGpOaNzDVdEnezPqeXq?=
 =?iso-8859-1?Q?1MMozVGZgSLja234x2pOkEof0RjuYxWBwl6hoMDrUR5e6QhULtV/micrvs?=
 =?iso-8859-1?Q?U+fiG0q4CQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v3JYqBUJ3Ubl0wtawF1GpxcXQWKhlx/UUe+OrzEx0RfizMlJanj4WiEPjJHD+BBNTyANbOeH4Cbkz23mqcSpncoLObWC/Dn1aHOH6FscZemUeRTlksZ44JZPL0H1e9ZgvIpVLltTvvE4z9xA6AGeAXg4rnfJjJj8v0WH7k6oj5o+W7VzEzG/qDeklK/G//8n9PTzgUGVbSw6hst+1ifyoLhT4kk55U/iXnJTmbSCY6xbY3Huh+Ad8x0Uc0mQuM1oWC6lRTS1VHQJKRtGO2DZoGIufp1OjX0/FEifio5wK7rBESOcfyjjfJK8XvwyimOGsLnQmEYAi6S83O4Od+GtZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c508993-20cc-4119-06cc-08df0711d0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:42:00.7186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzh3RKvdXRZ9QtSiXkdPqmNK8j1S1LpzRA7bZqR2AnvPXdcPrlVfHIfMV1YuEkYVKzPcn/UmjtlN6FFx94WY0cBFhjjVs9bvZbWUJ23SCPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add unit tests for ECDSA prime256v1 and secp384r1, using the=0A=
RFC 6979 (Deterministic ECDSA) "sample" known-answer vectors. The same=0A=
key pair drives the verify test (against the RFC's known signature) and=0A=
the sign test, which signs the digest with the private key and checks=0A=
that the result verifies with the public key. Each test skips=0A=
(g_test_skip) when the crypto backend does not support ECDSA, via=0A=
qcrypto_akcipher_supports().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 tests/unit/test-crypto-akcipher.c | 236 ++++++++++++++++++++++++++++++=0A=
 1 file changed, 236 insertions(+)=0A=
=0A=
diff --git a/tests/unit/test-crypto-akcipher.c b/tests/unit/test-crypto-akc=
ipher.c=0A=
index 53c2211ba8..fb1a6163e9 100644=0A=
--- a/tests/unit/test-crypto-akcipher.c=0A=
+++ b/tests/unit/test-crypto-akcipher.c=0A=
@@ -658,6 +658,117 @@ static const uint8_t rsa_public_key_extra_elem[] =3D =
{=0A=
     0x02, 0x06, 0xe1, 0x22, 0xdb, 0xe1, 0x22, 0xdb,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * ECDSA known-answer vectors from RFC 6979 (Deterministic ECDSA), message=
=0A=
+ * "sample", decoded into raw big-endian form. The same key pair drives bo=
th=0A=
+ * the verify test (against the RFC's known signature) and the sign round-=
trip=0A=
+ * test:=0A=
+ *   - private key: the scalar d (curve size)=0A=
+ *   - public key: Qx || Qy (2 * curve size)=0A=
+ *   - dgst: the message digest (curve size)=0A=
+ *   - signature: r || s (2 * curve size)=0A=
+ *=0A=
+ * prime256v1 / SHA-256 (RFC 6979 A.2.5):=0A=
+ */=0A=
+static const uint8_t ecdsa_p256_privkey[32] =3D {=0A=
+    0xc9, 0xaf, 0xa9, 0xd8, 0x45, 0xba, 0x75, 0x16,=0A=
+    0x6b, 0x5c, 0x21, 0x57, 0x67, 0xb1, 0xd6, 0x93,=0A=
+    0x4e, 0x50, 0xc3, 0xdb, 0x36, 0xe8, 0x9b, 0x12,=0A=
+    0x7b, 0x8a, 0x62, 0x2b, 0x12, 0x0f, 0x67, 0x21,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p256_pubkey[64] =3D {=0A=
+    0x60, 0xfe, 0xd4, 0xba, 0x25, 0x5a, 0x9d, 0x31,=0A=
+    0xc9, 0x61, 0xeb, 0x74, 0xc6, 0x35, 0x6d, 0x68,=0A=
+    0xc0, 0x49, 0xb8, 0x92, 0x3b, 0x61, 0xfa, 0x6c,=0A=
+    0xe6, 0x69, 0x62, 0x2e, 0x60, 0xf2, 0x9f, 0xb6,=0A=
+    0x79, 0x03, 0xfe, 0x10, 0x08, 0xb8, 0xbc, 0x99,=0A=
+    0xa4, 0x1a, 0xe9, 0xe9, 0x56, 0x28, 0xbc, 0x64,=0A=
+    0xf2, 0xf1, 0xb2, 0x0c, 0x2d, 0x7e, 0x9f, 0x51,=0A=
+    0x77, 0xa3, 0xc2, 0x94, 0xd4, 0x46, 0x22, 0x99,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p256_dgst[32] =3D {=0A=
+    0xaf, 0x2b, 0xdb, 0xe1, 0xaa, 0x9b, 0x6e, 0xc1,=0A=
+    0xe2, 0xad, 0xe1, 0xd6, 0x94, 0xf4, 0x1f, 0xc7,=0A=
+    0x1a, 0x83, 0x1d, 0x02, 0x68, 0xe9, 0x89, 0x15,=0A=
+    0x62, 0x11, 0x3d, 0x8a, 0x62, 0xad, 0xd1, 0xbf,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p256_signature[64] =3D {=0A=
+    0xef, 0xd4, 0x8b, 0x2a, 0xac, 0xb6, 0xa8, 0xfd,=0A=
+    0x11, 0x40, 0xdd, 0x9c, 0xd4, 0x5e, 0x81, 0xd6,=0A=
+    0x9d, 0x2c, 0x87, 0x7b, 0x56, 0xaa, 0xf9, 0x91,=0A=
+    0xc3, 0x4d, 0x0e, 0xa8, 0x4e, 0xaf, 0x37, 0x16,=0A=
+    0xf7, 0xcb, 0x1c, 0x94, 0x2d, 0x65, 0x7c, 0x41,=0A=
+    0xd4, 0x36, 0xc7, 0xa1, 0xb6, 0xe2, 0x9f, 0x65,=0A=
+    0xf3, 0xe9, 0x00, 0xdb, 0xb9, 0xaf, 0xf4, 0x06,=0A=
+    0x4d, 0xc4, 0xab, 0x2f, 0x84, 0x3a, 0xcd, 0xa8,=0A=
+};=0A=
+=0A=
+/* secp384r1 / SHA-384 (RFC 6979 A.2.6): */=0A=
+static const uint8_t ecdsa_p384_privkey[48] =3D {=0A=
+    0x6b, 0x9d, 0x3d, 0xad, 0x2e, 0x1b, 0x8c, 0x1c,=0A=
+    0x05, 0xb1, 0x98, 0x75, 0xb6, 0x65, 0x9f, 0x4d,=0A=
+    0xe2, 0x3c, 0x3b, 0x66, 0x7b, 0xf2, 0x97, 0xba,=0A=
+    0x9a, 0xa4, 0x77, 0x40, 0x78, 0x71, 0x37, 0xd8,=0A=
+    0x96, 0xd5, 0x72, 0x4e, 0x4c, 0x70, 0xa8, 0x25,=0A=
+    0xf8, 0x72, 0xc9, 0xea, 0x60, 0xd2, 0xed, 0xf5,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_pubkey[96] =3D {=0A=
+    0xec, 0x3a, 0x4e, 0x41, 0x5b, 0x4e, 0x19, 0xa4,=0A=
+    0x56, 0x86, 0x18, 0x02, 0x9f, 0x42, 0x7f, 0xa5,=0A=
+    0xda, 0x9a, 0x8b, 0xc4, 0xae, 0x92, 0xe0, 0x2e,=0A=
+    0x06, 0xaa, 0xe5, 0x28, 0x6b, 0x30, 0x0c, 0x64,=0A=
+    0xde, 0xf8, 0xf0, 0xea, 0x90, 0x55, 0x86, 0x60,=0A=
+    0x64, 0xa2, 0x54, 0x51, 0x54, 0x80, 0xbc, 0x13,=0A=
+    0x80, 0x15, 0xd9, 0xb7, 0x2d, 0x7d, 0x57, 0x24,=0A=
+    0x4e, 0xa8, 0xef, 0x9a, 0xc0, 0xc6, 0x21, 0x89,=0A=
+    0x67, 0x08, 0xa5, 0x93, 0x67, 0xf9, 0xdf, 0xb9,=0A=
+    0xf5, 0x4c, 0xa8, 0x4b, 0x3f, 0x1c, 0x9d, 0xb1,=0A=
+    0x28, 0x8b, 0x23, 0x1c, 0x3a, 0xe0, 0xd4, 0xfe,=0A=
+    0x73, 0x44, 0xfd, 0x25, 0x33, 0x26, 0x47, 0x20,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_dgst[48] =3D {=0A=
+    0x9a, 0x90, 0x83, 0x50, 0x5b, 0xc9, 0x22, 0x76,=0A=
+    0xae, 0xc4, 0xbe, 0x31, 0x26, 0x96, 0xef, 0x7b,=0A=
+    0xf3, 0xbf, 0x60, 0x3f, 0x4b, 0xbd, 0x38, 0x11,=0A=
+    0x96, 0xa0, 0x29, 0xf3, 0x40, 0x58, 0x53, 0x12,=0A=
+    0x31, 0x3b, 0xca, 0x4a, 0x9b, 0x5b, 0x89, 0x0e,=0A=
+    0xfe, 0xe4, 0x2c, 0x77, 0xb1, 0xee, 0x25, 0xfe,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_signature[96] =3D {=0A=
+    0x94, 0xed, 0xbb, 0x92, 0xa5, 0xec, 0xb8, 0xaa,=0A=
+    0xd4, 0x73, 0x6e, 0x56, 0xc6, 0x91, 0x91, 0x6b,=0A=
+    0x3f, 0x88, 0x14, 0x06, 0x66, 0xce, 0x9f, 0xa7,=0A=
+    0x3d, 0x64, 0xc4, 0xea, 0x95, 0xad, 0x13, 0x3c,=0A=
+    0x81, 0xa6, 0x48, 0x15, 0x2e, 0x44, 0xac, 0xf9,=0A=
+    0x6e, 0x36, 0xdd, 0x1e, 0x80, 0xfa, 0xbe, 0x46,=0A=
+    0x99, 0xef, 0x4a, 0xeb, 0x15, 0xf1, 0x78, 0xce,=0A=
+    0xa1, 0xfe, 0x40, 0xdb, 0x26, 0x03, 0x13, 0x8f,=0A=
+    0x13, 0x0e, 0x74, 0x0a, 0x19, 0x62, 0x45, 0x26,=0A=
+    0x20, 0x3b, 0x63, 0x51, 0xd0, 0xa3, 0xa9, 0x4f,=0A=
+    0xa3, 0x29, 0xc1, 0x45, 0x78, 0x6e, 0x67, 0x9e,=0A=
+    0x7b, 0x82, 0xc7, 0x1a, 0x38, 0x62, 0x8a, 0xc8,=0A=
+};=0A=
+=0A=
+typedef struct QCryptoECDSATestData QCryptoECDSATestData;=0A=
+struct QCryptoECDSATestData {=0A=
+    const char *path;=0A=
+    QCryptoCurveID curve_id;=0A=
+    const uint8_t *priv_key;=0A=
+    size_t priv_key_len;=0A=
+    const uint8_t *pub_key;=0A=
+    size_t pub_key_len;=0A=
+    const uint8_t *dgst;=0A=
+    size_t dlen;=0A=
+    const uint8_t *signature;=0A=
+    size_t slen;=0A=
+};=0A=
+=0A=
 typedef struct QCryptoRSAKeyTestData QCryptoRSAKeyTestData;=0A=
 struct QCryptoRSAKeyTestData {=0A=
     const char *path;=0A=
@@ -969,6 +1080,120 @@ static void test_rsakey(const void *opaque)=0A=
     g_assert(qcrypto_akcipher_max_dgst_len(key) =3D=3D data->exp_key_len);=
=0A=
 }=0A=
 =0A=
+static QCryptoECDSATestData ecdsa_test_data[] =3D {=0A=
+    {=0A=
+        .path =3D "/crypto/akcipher/ecdsa-prime256v1",=0A=
+        .curve_id =3D QCRYPTO_CURVE_ID_PRIME256V1,=0A=
+        .priv_key =3D ecdsa_p256_privkey,=0A=
+        .priv_key_len =3D sizeof(ecdsa_p256_privkey),=0A=
+        .pub_key =3D ecdsa_p256_pubkey,=0A=
+        .pub_key_len =3D sizeof(ecdsa_p256_pubkey),=0A=
+        .dgst =3D ecdsa_p256_dgst,=0A=
+        .dlen =3D sizeof(ecdsa_p256_dgst),=0A=
+        .signature =3D ecdsa_p256_signature,=0A=
+        .slen =3D sizeof(ecdsa_p256_signature),=0A=
+    },=0A=
+    {=0A=
+        .path =3D "/crypto/akcipher/ecdsa-secp384r1",=0A=
+        .curve_id =3D QCRYPTO_CURVE_ID_SECP384R1,=0A=
+        .priv_key =3D ecdsa_p384_privkey,=0A=
+        .priv_key_len =3D sizeof(ecdsa_p384_privkey),=0A=
+        .pub_key =3D ecdsa_p384_pubkey,=0A=
+        .pub_key_len =3D sizeof(ecdsa_p384_pubkey),=0A=
+        .dgst =3D ecdsa_p384_dgst,=0A=
+        .dlen =3D sizeof(ecdsa_p384_dgst),=0A=
+        .signature =3D ecdsa_p384_signature,=0A=
+        .slen =3D sizeof(ecdsa_p384_signature),=0A=
+    },=0A=
+    /* Add more curves here as they gain backend support. */=0A=
+};=0A=
+=0A=
+static void test_ecdsa_verify(const void *opaque)=0A=
+{=0A=
+    const QCryptoECDSATestData *data =3D opaque;=0A=
+    QCryptoAkCipherOptions opt =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa =3D {=0A=
+            .curve_id =3D data->curve_id,=0A=
+        },=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) pub_key =3D NULL;=0A=
+    g_autofree uint8_t *signature =3D NULL;=0A=
+    g_autofree uint8_t *dgst =3D NULL;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opt)) {=0A=
+        g_test_skip("ECDSA is not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    pub_key =3D qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                   data->pub_key, data->pub_key_len,=0A=
+                                   &error_abort);=0A=
+    g_assert(pub_key !=3D NULL);=0A=
+    g_assert(qcrypto_akcipher_max_signature_len(pub_key) =3D=3D data->slen=
);=0A=
+    g_assert(qcrypto_akcipher_max_dgst_len(pub_key) =3D=3D data->dlen);=0A=
+=0A=
+    /* A valid signature must verify. */=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, data->signature, data->slen,=
=0A=
+                                     data->dgst, data->dlen,=0A=
+                                     &error_abort) =3D=3D 0);=0A=
+=0A=
+    /* A tampered signature must fail (error is expected, so ignore it). *=
/=0A=
+    signature =3D g_memdup2(data->signature, data->slen);=0A=
+    signature[0]++;=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, signature, data->slen,=0A=
+                                     data->dgst, data->dlen, NULL) !=3D 0)=
;=0A=
+=0A=
+    /* A tampered digest must also fail. */=0A=
+    dgst =3D g_memdup2(data->dgst, data->dlen);=0A=
+    dgst[0]++;=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, data->signature, data->slen,=
=0A=
+                                     dgst, data->dlen, NULL) !=3D 0);=0A=
+}=0A=
+=0A=
+static void test_ecdsa_sign(const void *opaque)=0A=
+{=0A=
+    const QCryptoECDSATestData *data =3D opaque;=0A=
+    QCryptoAkCipherOptions opt =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa =3D {=0A=
+            .curve_id =3D data->curve_id,=0A=
+        },=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) priv_key =3D NULL;=0A=
+    g_autoptr(QCryptoAkCipher) pub_key =3D NULL;=0A=
+    g_autofree uint8_t *signature =3D NULL;=0A=
+    int slen;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opt)) {=0A=
+        g_test_skip("ECDSA is not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    priv_key =3D qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PRI=
VATE,=0A=
+                                    data->priv_key, data->priv_key_len,=0A=
+                                    &error_abort);=0A=
+    g_assert(priv_key !=3D NULL);=0A=
+=0A=
+    /*=0A=
+     * Sign the digest.=0A=
+     * ECDSA signatures are randomized so only length is fixed.=0A=
+     */=0A=
+    slen =3D qcrypto_akcipher_max_signature_len(priv_key);=0A=
+    signature =3D g_new0(uint8_t, slen);=0A=
+    g_assert(qcrypto_akcipher_sign(priv_key, data->dgst, data->dlen,=0A=
+                                   signature, slen, &error_abort) =3D=3D s=
len);=0A=
+=0A=
+    /* The freshly produced signature must verify with the public key. */=
=0A=
+    pub_key =3D qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                   data->pub_key, data->pub_key_len,=0A=
+                                   &error_abort);=0A=
+    g_assert(pub_key !=3D NULL);=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, signature, slen,=0A=
+                                     data->dgst, data->dlen,=0A=
+                                     &error_abort) =3D=3D 0);=0A=
+}=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     size_t i;=0A=
@@ -985,6 +1210,17 @@ int main(int argc, char **argv)=0A=
                              &rsakey_test_data[i],=0A=
                              test_rsakey);=0A=
     }=0A=
+    for (i =3D 0; i < G_N_ELEMENTS(ecdsa_test_data); i++) {=0A=
+        g_autofree char *verify_path =3D=0A=
+            g_strdup_printf("%s-verify", ecdsa_test_data[i].path);=0A=
+        g_autofree char *sign_path =3D=0A=
+            g_strdup_printf("%s-sign", ecdsa_test_data[i].path);=0A=
+=0A=
+        g_test_add_data_func(verify_path, &ecdsa_test_data[i],=0A=
+                             test_ecdsa_verify);=0A=
+        g_test_add_data_func(sign_path, &ecdsa_test_data[i],=0A=
+                             test_ecdsa_sign);=0A=
+    }=0A=
 =0A=
     return g_test_run();=0A=
 }=0A=
-- =0A=
2.53.0=0A=

