Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35609C43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNX-00039G-BE; Tue, 14 Jul 2026 23:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNH-00035o-4B; Tue, 14 Jul 2026 23:33:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNE-0000oW-Lz; Tue, 14 Jul 2026 23:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chGzUnbnM5SSKGd/84EP2EwxwsLXxtIBV7vGKCjgahc+lAMVZHFlDO+6Qu95TbcsVfCNwCEOea4SHidDDemeGQhta3/uFTu317I1NoTYyYG1orKUrkHtAfDM2o8RHvXMz3vyTM2imaKOjGPLM3nsArXgtEZTzUasXCH19Wlh9SxvGpHB9ltuhKN8jLtQwQy2EfrmIhsPIZqXp2oS4M1780//XCmp9p5cUx89+3MSLsafbUXWYTgVntwkVId8CEckOuKrqdRLV4L4u1VrrgGQweNfsylN5L/vViHfb06kWNeHonQCkbyviju96gppE8F4niPbXPJuNFXj8ScT0OB+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5roSOjIvXkZzxUg80HnEUwbsRLnFkDsyeHT0J+U5BY=;
 b=GC1XC7a9EZQPLfavAiO8Qmvzl6vhPgDDB7hFm5Dl+KvDGoUU2JUHKyLRxeaKeYaecfGJ9Ar5G83ccg5AiHmIVRTpCzgG4OHy/gDhTveA00yQsuL9YT05468LOzmmMxbLkhaUQ0XKYmYza0E0N7FYvMT1X06K1qNwV1L4kpmZCnGAUZ767Dc7W+gZIpoe9rNUVBD35ip37h9TRylKFLvrfxQnH4Dmu5tAtXG8ESKD12DcUSRd8cxBKuGghRu8cz3xBqUr940F75qVF0cpGv21hn8Zg4oVo6pCs1a75NVZpJkOq44XHuIlh3rd7I5QR/F0SMPXAPtbHlQ26aSJtJ7Iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5roSOjIvXkZzxUg80HnEUwbsRLnFkDsyeHT0J+U5BY=;
 b=JM7KtcJ6Hewq51nHIXwv2A89X019wInT9qt/IIS/Lu0SDDIVqtgSE8DWizifuso002LSUsOiiN7OCjsxD1xHz9LKUDhSjlPIxCQJ8Ume2BYMcPAoLfYc3wZVLviCNNmYpEmAxbfse5QyCMWeJ50qcfbegQ2U/vis7kRZwbes2dT5M8cn0FRtJiRBMJGf7+Ujv958QrCi2vKLDScuCLI2a0G+surnouGg6378O4YUC6jlGpaVlir5hh2zL9GlnNvVuFDyMWM4ZMCRGgv/PmupCpji7Uc+Xd1zq8gfqYghTspF802hTiV7W0/ajt7uNxGoNiOUZq9uXJUJ4zDHrqWxhg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:18 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:18 +0000
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
Subject: [PATCH v2 03/17] hw/misc/aspeed_hace: Support scatter-gather mode for
 the crypto command
Thread-Topic: [PATCH v2 03/17] hw/misc/aspeed_hace: Support scatter-gather
 mode for the crypto command
Thread-Index: AQHdFAqtgjMZaWWo4kmP72LwW7wHfg==
Date: Wed, 15 Jul 2026 03:33:17 +0000
Message-ID: <20260715033311.1648424-4-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: 16edb5ff-a976-4ee3-d6c5-08dee221d00a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: q5dBwvddsOsmBjHDtZ+ediiDsaCCV6YB44i/D0Io7VMsQMHgMOGk4FQt5j9EAL4dmaC87erSCSJv4UJPr4CUjVIJdnPUNd4kMODQkvMtVDyLS3a4OtFa1dZokt3FAYqCqCefRpQs+6fs7aYeyIgKCPMoJxGl3NXwLHyTebmqWVtI7wcc2LmnpLC/+b4ZpLQ9sQvpmgp6amT68hum6tAkI16tuUtZELGcwY1ndv96xkFQUg5FAbfMGESdrgvFPlgs7Y7Y+crYT/RXOO73+9cVWYhSlqyHcN/eaXZE4U2T6rBNZbK6uIE41gis9YRn1WBiAaV4YDlpEc9B7c7pFKSv37v8GWq6RTHIn3oNbZjdSH2VF38KHJ+Y0lJfUmboTHhklOO94kBv2dAPI8vlryXbsePNbokiF5G7oJtCxCuUsD+E8fhHqr9MtZSpr8LyNotHno6dRBZqAviHQiFQDxmQrgwVhWurodI5ZXzl/GsDbvKAq9dKHpKHOeqy3PQKxgdJ3Iy6amzO8nJN41Mt0WrBmt4ser2XI1Vf3yC+qS1MpzzBXn9FE8Xi989Rao5/FwaXVsZmdp0r1BZep25B5UtdrdsUDkzPmDaOykwN/PvUIjUKRl+E2MGitR3u8SOxlRSX7B8BNDsOUu9GDA1pxzfNGMwaNRFvy+SH3TMFpd+V0XxWZkQ+h4fxYSH6W/EdAD4CWOW3WpTIsGiaFq4VIJs0I/0V8ZKQTNXMVvOF9PgSnVAbd5vpwrKj8hzxpaS61Yyj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qc00RKqFuhJwtqW2qJxp6MWeDmqgChmRWS/kS/1MQPxUvkazzfwJ7cx/Gt?=
 =?iso-8859-1?Q?r9oYvSU63ohMxSvzzrjcizakjB5eqDMpon1iG0AyT7i3VFznIgsIJubTir?=
 =?iso-8859-1?Q?KyQJ+0gTlJPom5PSH3zCPg2rtfZWJM2v0i/tylheKFszKzneiwQ2QNfDan?=
 =?iso-8859-1?Q?6Y/yHGJn2yo4l7NSuYKi6d2PkO8NXRS2aaONn0cUaxD9YYC2UPzl4wmSEs?=
 =?iso-8859-1?Q?xLi1FQb/lFsFutC4gYasrGO6//E85/XKwOixTfIcq4YZ58QH3HtXspc2Kr?=
 =?iso-8859-1?Q?ClKQAj5YtPyz/YYI/CbUihNJLfr1wviyRyZqFxj2N/2kxcUCstuO8qHQHF?=
 =?iso-8859-1?Q?BudY3M0Fx+6Rp2vk9OhaaFOvXVLLT56c2cnLN6xepjVtu8W1ByEblfBrn+?=
 =?iso-8859-1?Q?WuhQhx9vJLuQebDn2nKDovBzesc6aJyO/He1pGlZmospY4A1kr262CWs1t?=
 =?iso-8859-1?Q?bQCr18v7Qs8eiXUGwri7LMNr1582QkwnzdL8/S4YnItoNbhqmbTP5qHWIG?=
 =?iso-8859-1?Q?+Oglx7emebF+P/huTihM0JWo3uvsLJ5/mJT4gkw/PexCQbTlIogP/ldOyw?=
 =?iso-8859-1?Q?jB4HClCge2XOBiho96KNeQ/JChAemF83W7o2ThTYnte3U9I3dfFit7KPLe?=
 =?iso-8859-1?Q?3CsFLQP46uRQtIuADjACBGB10Q/uQ21MeM3ght3HwjaPj86oTVCVB03G3Q?=
 =?iso-8859-1?Q?Nw3fuI9TflGsM0aQvFKhSGl2BxETa5ILbHMa/1PPmOErCL3DBxoUFqp7qj?=
 =?iso-8859-1?Q?aOgeyAECzt6F4GLc7Db3TFCnJxs4STKmG8CLPdRHeMdfjoAaGUKkTvqKq0?=
 =?iso-8859-1?Q?hklzf7F/QprcJYUI5emCLvpNwu2CKbS1/ZX8dP2pDdcjXFAhcFXqR45SDn?=
 =?iso-8859-1?Q?Xo+dIHteelhHgfEuqRYDnfR/aNJN6dnxQMEwYma/h1Mdj1w0qvLCLfFeaV?=
 =?iso-8859-1?Q?tEdMa5S5tfNtRB9ADVMUtFSpZALTS6Xj5jZ+nP9jPZEs8acbraCoGdtLil?=
 =?iso-8859-1?Q?RBl+VbzwoUJ8MFeFHX9ak7prZz/OM6Lrs+KRsEyDHzgnxlIXTh50tMEvJC?=
 =?iso-8859-1?Q?jaWM7xHjA4TT25D9AtB2e3jli4QTqfJosba7/ghdEKYCVMM7Bv/8CpIN6N?=
 =?iso-8859-1?Q?lSTyvtDuH1T3SwFvUMZEwEvWj7UaKyXX2n86nAvz94eRcGEWfCci+WKHmJ?=
 =?iso-8859-1?Q?vh2udoYkQGi+j93OifUaw924u7alx2iQPvhBw+hV4Baqcxq8VWvRzrNhWx?=
 =?iso-8859-1?Q?ZT02JPdComYquH++eL/RF/+PicLVVZV7NDfwsSKlAUCOQS3S7gHJEmXLLx?=
 =?iso-8859-1?Q?vl4WxygkQPpJwhPMDkSF09zoPte7Bu75FuVKgSbYTws7/g+CRbY54hHGQ8?=
 =?iso-8859-1?Q?cG2lWp+382YHDKhXFqEDr/vPBWzz81UVm7l84YabuakFoAP7w3v6rze9yY?=
 =?iso-8859-1?Q?6KeQfGgo1NJGENZtftGEi0vJUPetIpuOF37Ez/9cyc1YVGWtGmU0u1svLS?=
 =?iso-8859-1?Q?kLjXJAH0gAas4fGTug/qjP+e6wipfutNYCBmcoTa472alGBYkdCiunQYHu?=
 =?iso-8859-1?Q?M9+CCww9t+qqpUCRRymvzgJwZEGB2z3ztz4NZxrHaVXhisgSrdFPcqZclQ?=
 =?iso-8859-1?Q?DgOlbvcLnerNtJXAFZrPs/YjSoDkR8i3oR16mOkvFAB937Ex8Dn+UD5gu4?=
 =?iso-8859-1?Q?Ono0vVGY2F5j2BJxdGkmwtgdgA15971vDCERkwZJBOw7dEVCacrK2tcT50?=
 =?iso-8859-1?Q?jp6lvqbPDlUY4RxGMCdW4YuNek+Msvla7TdT/oDcLZP/ODsJLsTamqZDZv?=
 =?iso-8859-1?Q?HIGbIgMZtw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gKlPFmKjKvsgM8w/eqZkaYTV3EFUD2BeliKmQfvXV7zunUNv12Uf3F+oUPg3aotpLMPt0JcPXXQcQ0nE+yYJieFHR+zGu9rRTCAAuW8DIcAdpeJppVe4FZ6ndHrg1Xh0/AYywueBBUBmZZD9fmqlNHAnfP/EK/+/3PRRCUM1SrgJupyYeYm9/jpKgpGXzzBO4leJ7ad07k4DBuMJyHkN4HQPgbQ4J42wA6+GrUp8onbKGVFW7SezQoGL4o6wGB0Wg8CnBUfCpWsySvjrO5LrnNMHDuyFPftgGDGiw+RouAADBiDnCJzarOF3BtL5LIMOoEkMv1SmmWgEY8v2l1RiTg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16edb5ff-a976-4ee3-d6c5-08dee221d00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:17.7527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qg07DveIC/iBOQpEh7+yD+fQ/UReZbL7yqYV4DIGqegRTpSK5lh64Cq0TyO961e6dFBD6IFUj8fsPkt1JjOoZNxIBBJoUZD4+4hwiRTtwwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
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

The AST2600 and later crypto engines drive the source and destination=0A=
through scatter-gather lists (HACE10[18]/[19]) rather than the single=0A=
contiguous buffers used by the AST2500 direct access mode. Each SG list=0A=
entry is a length word (SG_LIST_LEN_LAST marks the final entry) followed=0A=
by a DRAM address, matching the hash engine layout.=0A=
=0A=
Add a crypt_prepare_sg() helper that gathers the source into / scatters=0A=
the destination out of the bounce buffer by walking the SG list, and=0A=
select it or the existing crypt_prepare_direct() from do_crypt_operation=0A=
based on HACE10[18], mirroring the hash engine's direct/scatter-gather=0A=
dispatch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 +++++++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 64 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index de4399f322..3d3f1fc8dd 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -610,13 +610,58 @@ static bool crypt_prepare_direct(AspeedHACEState *s, =
uint64_t addr,=0A=
 }=0A=
 =0A=
 /*=0A=
- * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
- * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
- * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
- * written back to the context buffer so the driver can continue the chain=
.=0A=
+ * Scatter-gather mode: the source/destination register points at an SG li=
st=0A=
+ * whose entries are a length word (SG_LIST_LEN_LAST flags the final entry=
)=0A=
+ * followed by a DRAM address, matching the hash engine layout. Gather @le=
n=0A=
+ * bytes into @buf, or scatter @buf back out when @to_dram is true.=0A=
+ * Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_sg(AspeedHACEState *s, uint64_t addr,=0A=
+                             uint8_t *buf, uint32_t len, bool to_dram)=0A=
+{=0A=
+    uint32_t copied =3D 0;=0A=
+    uint32_t sg_addr;=0A=
+    uint32_t sg_len;=0A=
+    uint32_t entry;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_HACE_MAX_SG && copied < len; i++) {=0A=
+        entry =3D address_space_ldl_le(&s->dram_as, addr,=0A=
+                                     MEMTXATTRS_UNSPECIFIED, NULL);=0A=
+        sg_addr =3D address_space_ldl_le(&s->dram_as, addr + SG_LIST_LEN_S=
IZE,=0A=
+                                       MEMTXATTRS_UNSPECIFIED, NULL);=0A=
+        sg_len =3D entry & SG_LIST_LEN_MASK;=0A=
+=0A=
+        sg_addr &=3D SG_LIST_ADDR_MASK;=0A=
+        addr +=3D SG_LIST_ENTRY_SIZE;=0A=
+=0A=
+        if (sg_len > len - copied) {=0A=
+            sg_len =3D len - copied;=0A=
+        }=0A=
+        if (address_space_rw(&s->dram_as, sg_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                             buf + copied, sg_len, to_dram)) {=0A=
+            return false;=0A=
+        }=0A=
+        copied +=3D sg_len;=0A=
+=0A=
+        if (entry & SG_LIST_LEN_LAST) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return copied =3D=3D len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
+ * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
+ * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come fr=
om=0A=
+ * the context buffer (HACE08). For CBC the resulting chaining IV is writt=
en=0A=
+ * back to the context buffer so the driver can continue the chain.=0A=
  */=0A=
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
 {=0A=
+    bool sg_mode =3D cmd & CRYPT_CMD_SRC_SG_CTRL;=0A=
     uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
     bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
     g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
@@ -633,6 +678,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
     size_t keylen;=0A=
+    bool status;=0A=
 =0A=
     if (len =3D=3D 0) {=0A=
         return;=0A=
@@ -686,8 +732,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
     src_buf =3D g_malloc0(len);=0A=
     dst_buf =3D g_malloc0(len);=0A=
 =0A=
+    /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
     src_addr =3D s->regs[R_CRYPT_SRC];=0A=
-    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+    if (sg_mode) {=0A=
+        status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);=0A=
+    } else {=0A=
+        status =3D crypt_prepare_direct(s, src_addr, src_buf, len, false);=
=0A=
+    }=0A=
+    if (!status) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
                       __func__, src_addr);=0A=
@@ -716,8 +768,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         }=0A=
     }=0A=
 =0A=
+    /* Scatter the result back out, per the selected mode. */=0A=
     dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
-    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+    if (sg_mode) {=0A=
+        status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
+    } else {=0A=
+        status =3D crypt_prepare_direct(s, dst_addr, dst_buf, len, true);=
=0A=
+    }=0A=
+    if (!status) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, dst_addr);=0A=
-- =0A=
2.43.0=0A=

