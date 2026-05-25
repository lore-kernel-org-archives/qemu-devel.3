Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106DACD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu6-0001qa-Ks; Mon, 25 May 2026 01:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu3-0001iA-Hb; Mon, 25 May 2026 01:31:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu1-000382-K0; Mon, 25 May 2026 01:31:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6QgUP3ZSKQFfWl82tL7wgQJIU6YroAFuFYQrqR7VPdG9QIqEQJ6SyTo4wlxarB/o6zW2W4sacwk3bL+qDe3GkcGdtj1EpIsR9YRj4PFZIZSpfr3NyW6Lag2g762jJxXoqUkI7iUubI3b6i5Ei71mKNtMN5DE+aUlQNw8os/GQnxhBFpUMjdhtZM/1YrmsIOmfD8F6Ajx18tiqdxVPysJLwiVvthgDkO5rxxcD14JvWdOGK+yy0GHL44JZ568SJ4kWQnq0tSp+EH8IzNoRyLyNvDNi70ghGbGIUFBoQTZfIHQW2iOprli05CpPND/Wd01vlC2LV6/jKC/d5dIqaGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY2UlEUQBKs3DM2q4bS7LaGPr3qGTXlM9zbEQDMl+vM=;
 b=QUKemKaEqyHIDcD8Bmg6DPcHieo3BSD0+4EptomQCBzx8LwWhhWBdzL0SjdwYsYv5kIwpe69VxaUoOijDKEn6xXBN795mE+8BnGOz7HTae47oQyNsP87Ll3N+DHuQJA4Snw+0oh6bL804IvK3FmXB67wEx6V5ddQch/h6S5WFhIWj2DkZ/lPtcohh355EOwVuVjkPnikNCYg/gFWBPKVSB7OSj+juCpgFPsDmkDLXrjlCCs/EzLFzankKiJJ4dRznvsazZqZUqca4dUaoZ3ARGE6VMk9t85ahoxUAOEwrwcwntY9ezWEECjnsXkNlRLxCwodKfHqv7+gjW3bB2o40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY2UlEUQBKs3DM2q4bS7LaGPr3qGTXlM9zbEQDMl+vM=;
 b=pv07eI+1VfNx6YXLgVS36KE6e2hK9D7vpCAPlpBLiKO7b9XFUrd9dVbc4HUq4QmSc8hGGR/neDgneGVdAGpWnnVt8uv46UY/0wBVXNc9+ofERSoIitCd52e09Enb9alWma/0DRAyKUhFraqJUL+RgA+yGqsatuRiSvpkqRss5HI8INf5ePMjx+UN2P+ac8CD4glNFhKlwXJ/SC+uJKFPoSYfOpFiVbohqA/79nUFVmShjAtIrZRhbpPGaAFbPvxB0HfmRW516oJlmZSVBcP3Zq6YuwoZbEKBxwJQ55ePfQQkASmQajE4iUmS0OrxRxGHKxkY80mqIx2Z0g2Zy4QMbA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5997.apcprd06.prod.outlook.com (2603:1096:400:335::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:49 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 9/9] docs/system/arm/aspeed: Add AST1040 Bridge IC
 evaluation board
Thread-Topic: [PATCH v2 9/9] docs/system/arm/aspeed: Add AST1040 Bridge IC
 evaluation board
Thread-Index: AQHc7AelmF9C7seyvkq3A7WWb/a2jg==
Date: Mon, 25 May 2026 05:30:49 +0000
Message-ID: <20260525053036.3305181-10-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5997:EE_
x-ms-office365-filtering-correlation-id: 4e132cc5-fa91-4396-32df-08deba1ec795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: CbuySvTzn+vh0UD/7jgEc94j8R1ZF1ZQ8PfDZwtbrJQTbqH3WBGghIsqKUoAzb1ucovZdvzwS4UYfzmwa2I5gcLFPSHwzP+QODPPp2aIgEhpzHok62t0OJz5yQjfm7TiZBHNQe9ld7AYr7313pihQ87Y282jYP2qV56bzHYuBf69v1mV/l0q3LwBcL8T1fDi59Ut68W5UqZrUmhNDTvc+XINWh+pkRNYsxLgAappppcR3eqZzl+ZxpmUEmwTPjTGIwexqm0sAxphfLzvXNzBTimYABfJI0IIvHkSZcN/LQxNn5Q3QR6jXDo+KAjyTnxWdQVYW2tY78DUBiWTLTZm6KvW9zvnHvs2LcXGxNKQGMbFN5nrklhvlRt/YQd4wRC+G1YvO+Bpt3Yq84UMzo1ilqvgQbILgwAcKxxmmf8IjPYBgqRB9lTdFW3D/ULqI+5HxaXp2aP+aY77TsDY82ZjU5eysCS6U1R+nyhNKnEtBkcjqGVpKfqbfZDYr8gS0C0EucpXQZZ7iT3QpmggeYjsz8dLYBd2pvP2weQ6rjwdcL5dOnjmGtkql4r7yQ8JrSm0+diL+s4qyrt1POXkGpIFGovQJQkgtknTuTeAmboGfpLYy6GO6hg8IjMLSxcQ0LtuNlqGYP190x/xitNfQ9/YQtXdXyyQ8ZyDYH1BxJXuggZHFTCBx9vgueZrEnDVqEBAOM5nAFXluUbQTtH0b3n3UvKAAbI9Y4UAd6FSXwTHsE9lrnIgqDgCfasdgE+wbA0KAIk2awRvVPPvJOPbNnlaOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nGDrnlv7OU1fWfWKH8XtlE3A6MXqk+2BR4riKHxOto8UFj2pnP8P4QQhpf?=
 =?iso-8859-1?Q?03grJS+a2sKDGi+KMeSpcJ1Tj0irYNDvtTDGqrTMz2c22g1aJyoqRjuWeN?=
 =?iso-8859-1?Q?uuyWUljPjRUZQM3nn77x7gHfAcrXeqbUI26mnuseYvDPul04G96phHVeQp?=
 =?iso-8859-1?Q?KsJiy8o9eZy2QmLYrWjlQcREBLhGb14rU5XCphZlwnPucpGNgvZh1noxKm?=
 =?iso-8859-1?Q?I65wEh5EQDbgyHGMoAVae8AWChpFiNYUE861dolkf+V9uBbK2aOZXBdTcm?=
 =?iso-8859-1?Q?PxN8DGNk0hPtroKsu6BQZVu6K+V0tWB8T7d5Ey2OxfXgZp8Y+lWGUUlWyb?=
 =?iso-8859-1?Q?kULLakEB1B0PVJaNsIhdDLYTUAlRDoupmwWzan3J3WIrxNaIRAR02//stf?=
 =?iso-8859-1?Q?CP3j+ZhXwGSK7wT7mCbbMRBjVFx6ODOeLj/GdQgpTfv5H7THTJjN5AAzVm?=
 =?iso-8859-1?Q?HR8AX1e/A9OboW1K+Lu41fzm6nE7D+ixKio+/7OIYDz92T0uMVHA5qdVLJ?=
 =?iso-8859-1?Q?LediVqFkt8YYxh2LL5oTB5QRPpmObgXdzgs23JT3QjD7BrOfBMh7nk4Krc?=
 =?iso-8859-1?Q?A4W/XxnIKc3J8KkMoq8j2R0lQ8Uf1fCCGsQiq60O/nvvG9Boqi4Rxa3aZu?=
 =?iso-8859-1?Q?B0G4YKcG9tIcXRGE7tSPsDUQSS0ALP1B6BvT0wdG4KfmqPamLhYLDbWcsP?=
 =?iso-8859-1?Q?OxDXcRrDATvHC6RRjCfRbo34hMrQFNZ0oMjTh6MXi3Oz6sa9ttEHf1uIkm?=
 =?iso-8859-1?Q?0HfMD+0waIGGvoWxUyVd8QXcDnO6G+IDw7sdaFvejYcc4BRVypwmLNeOVO?=
 =?iso-8859-1?Q?hWXkJaU7c/92CrbfID6ZZ3sDqtEorceiNO0JbklY0qiYNwin1BG8hVThnr?=
 =?iso-8859-1?Q?Lsf8z7lUWYjIPH3c/9hlJqL7K4PUdZ/HWRpz0cdaM1E+XdT01tqksLD5Ig?=
 =?iso-8859-1?Q?bZHyk9eIhsre4b8vcd63+uV9l1VIxjCnLsenels8IWHlK8k6ZbU/0oX/OD?=
 =?iso-8859-1?Q?rA0KoWJBZPcOzxMUrPOTVBgAA3nz+H439Rk+xyWYnNz2qQo9TVrhP0O7Pm?=
 =?iso-8859-1?Q?CTrJKoux31TRf6yJiJ2PJWMA8CtZccCGb8pFP4DS3NNCCVAg3CytssXe/e?=
 =?iso-8859-1?Q?kTBkm/p+KEd3caSv/k3xVxXx6MhAUww1k8+IE0pmCqd+Ymt0RIYjUKkBW8?=
 =?iso-8859-1?Q?Pf42gqTy3EWtrl73jcY6rHf3LszR7Lp8sfDpjDE31g048nSUEYBOPjQH8F?=
 =?iso-8859-1?Q?xA6PWHEMovsCZJAXLe/tGekAG0Aqp5H//9c6IiU/28oErP0GnhxiCKErv8?=
 =?iso-8859-1?Q?/Fkdg8BMX4/3jcFbyzyzjDykUBZ9bY1iAbSZShN8fgN1pz1O0IbEN/dxbB?=
 =?iso-8859-1?Q?XqPBC/X0NujjdOwGPD5XXmFigDyJvN6sHmndfSI9YzFOc6omHQnrc0Xrow?=
 =?iso-8859-1?Q?uND0iuA57nhA0HXP+DFKrEfIa+XFfM4UlWWMxPZz+1mYWWCfwqur/moSI1?=
 =?iso-8859-1?Q?965IdGR6jnA+itfj8CfJ3MNNTgvMz5R3CtMHZf1j8DDBdPME0k42lAtbX8?=
 =?iso-8859-1?Q?VDoFCWixnL9qGKkCiCFkVWL4c98MT0gAdoX8AjhviCeefgKwPsIwS1GZMo?=
 =?iso-8859-1?Q?PBScChl1OfPeHb704U4Z/rjkYYiV27QIUsVcDaocPc86/IoOREOO1Otip6?=
 =?iso-8859-1?Q?iFL50/PRwWg/wgDfibRp/MDEOIufT9I+OXQgvHQQx3fMMUFGMH7WWbXpe5?=
 =?iso-8859-1?Q?GjrBlSb7OzDX3Z6bjQs0+HwRwzVgBx+55VLhMMpysQHj0z0HLoWMeCyzDg?=
 =?iso-8859-1?Q?R2FVyHGTXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nA1ZPFPiOzMN73Kx9OkeW7PXw8srl2z247Mx8eaIa8+wgMj1RWiYJb8H8m7gd3/0tCQubswqqldXNvum6T31V1AcvVM4QXJSfBcDmX3NAvvS/zf0vA9b6xqBEE2jf8cu8TQ75QrOcsrUddDv9Z6RZa/8s0hGjrQ1VJ8DSdwcu2OQrXRnLgb3aT+B2q3gG3t1msPtV5/IybeHWWTkdvK93p79a84/pUplhMLVdYOKPs9ZYyeLC33Wu37Il5VP7NOZclbVyraPyBn7NB+7xjLtjiax1VPH+XNN7kr2b4bKyvwWSYmF+7yfZ+6Q97lLPnHQ4kAGkR/M0UnuRCcmbNkmGw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e132cc5-fa91-4396-32df-08deba1ec795
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:49.2171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZuC+xS6fL/Yc/NgcHcrXKKB/15R1FE52mgxlnGrb87Llc9GUVXSXxnQT2g22Q7pm0bFGpwTtIUySr2YDUgSVhjeX0Pts9ikifAM/dfYUMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5997
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Update the Aspeed AST10x0 documentation to include the=0A=
AST1040 evaluation board and clarify the AST10x0 family=0A=
classification.=0A=
=0A=
The documentation now describes:=0A=
- AST1030 and AST1040 as Bridge IC devices=0A=
- AST1060 as a Platform Root of Trust processor=0A=
- AST1040 Cortex-M4F CPU frequency running at 400 MHz=0A=
=0A=
Also add the ast1040-evb machine entry to the supported=0A=
AST10x0 SoC based machine list.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 18 +++++++++++++-----=0A=
 1 file changed, 13 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index df2f539b02..7c8639c3da 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -440,18 +440,26 @@ Use ``tio`` or another terminal emulator to connect t=
o the consoles:=0A=
    $ tio /dev/pts/57=0A=
 =0A=
 =0A=
-Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast10=
30-evb``, ``ast1060-evb``)=0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A=
+Aspeed Bridge IC and Platform Root of Trust processor family boards (``ast=
1030-evb``, ``ast1040-evb``, ``ast1060-evb``)=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 =0A=
-The QEMU Aspeed machines model mini BMCs and Platform Root of Trust proces=
sors of various Aspeed=0A=
-evaluation boards. They are based on different releases of the Aspeed SoC =
: the AST1030 (MiniBMC)=0A=
-and AST1060 (Platform Root of Trust Processor), both integrating an Arm Co=
rtex M4F CPU (200MHz).=0A=
+The QEMU Aspeed machines model Bridge ICs and Platform Root of Trust proce=
ssors=0A=
+of various Aspeed evaluation boards. They are based on different members o=
f=0A=
+the Aspeed AST10x0 SoC family:=0A=
+=0A=
+- AST1030 : Bridge IC=0A=
+- AST1040 : Bridge IC=0A=
+- AST1060 : Platform Root of Trust processor=0A=
+=0A=
+The AST1030 and AST1060 integrate an Arm Cortex-M4F CPU running at 200 MHz=
.=0A=
+The AST1040 integrates an Arm Cortex-M4F CPU running at 400 MHz.=0A=
 =0A=
 The SoC comes with SRAM, SPI, I2C, etc.=0A=
 =0A=
 AST10x0 SoC based machines :=0A=
 =0A=
 - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)=0A=
+- ``ast1040-evb``          Aspeed AST1040 Evaluation board (Cortex-M4F)=0A=
 - ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)=0A=
 =0A=
 Supported devices=0A=
-- =0A=
2.43.0=0A=

