Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA5CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdMw-00027P-6D; Sun, 18 Oct 2026 22:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIdMt-00026w-2m; Sun, 18 Oct 2026 22:44:55 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIdMq-0003GX-Uh; Sun, 18 Oct 2026 22:44:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw17QJH6ZuejA9bZdLNuZnZb5QkQSXsIeMA0NrOGzFc+i5a+9OrVwKpRkl/Il2DfM/hjtwBjpu213H56o5mPLCSaxUUsLWCMt7t9KlQGTZ0tNKFuAumUHtxQrGNrabm6N30Uggz5KhUScyDimbLctIl7x7PTsrg91fgAJ69NUCaKXfkSih4Tohy4/KwpLlgONDaHYOGVVavZ86Jre2lv4/vpsqDk98SYVKk32nFUDdOb483sIbU5xZRqSDTST+tp73x06BQA/G0Dq83Z6QAt9t5BfGxKH0GV0IDDme6f0eqNcr3J+ftAEeHl2NcJIVlldCtErHCKYAPYFSpfxTHfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRCrllrkjOyeD/Z66gsePrTyiYikjBSdW7vCVUe2++A=;
 b=WGryDToxKAZiKWo6RNHYVLaPlHbNp/xoJzFBfcF+JTpy7e9hDGRpyQ8y7JgM256CdMMaawQR9YJh5sP6HQnUVsKvub/WNad5GCMFdBHhyRjpx1Mt9WCcL+olCCQvz8SzO30NOFmr1ELQFPF18LUPJ8wA5+C7exD5nWHrRHEPw38YDoWmdl2qiz7smnmxYxHs7sm40ewnQYzLWBFX+W+0S2xxzT1vwd5Z0XiyApLvf8TN0KBJ3IlKR9nnbwqrdCD4u1ZXlB3pfnap8INfqe2nQWTqXoqbsjOJl8HuNGzUjhkJIwwZAHh1W36UiX6Tq0wK4GdIrGETwCZ8GdM5Ge2svA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRCrllrkjOyeD/Z66gsePrTyiYikjBSdW7vCVUe2++A=;
 b=KZLJ7kkskFPKZu50BiN5MwDoJd2YewWEd3MdCMFe0Xpb9SB+H1pm2blBlzTT3HgIa+MlMByxKT0kzq+0zGzs8mkgeNe2ZEfkxASHmUU2CCKcKH0OPwvVNPxlK+/c6qm2mLxCE8rhhwJtzqL3FH2fRfbAhuLRmtyed5GCtrZEp5Y8BYD2d8+RRTKxiRL5YcZs3+O9Khk2g3FXooiGh1pSxSR+3TmBe+50lCCp0GETmto+nk0++bcCYnOt4narE+ohiA//AxBYG7uKs0KKrJTK0tek4Johqnx/6zr7D3Ahv5jPr7Q5aQPpEXN5lNG+K+dRkL3PtRurClm4ligosu3LqQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB9279.apcprd06.prod.outlook.com (2603:1096:d10:71::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:44:43 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:44:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcelomanzo@gmail.com" <marcelomanzo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
Thread-Topic: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting
 during class initialization
Thread-Index: AQHdX3PLSL9rksVckUu01uZZcMa9vw==
Date: Mon, 19 Oct 2026 02:44:42 +0000
Message-ID: <20261019024441.3554329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB9279:EE_
x-ms-office365-filtering-correlation-id: 786d2231-1eb3-490a-1e68-08df2d8aedb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|56012099006|261009223027099003|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info: gRRiZn8Uy5mZyXbADjWlnCsHenOFrRz9mj37jKyveSYvmznyM5txQX/HJbmDFDWXScPF73DVPqQgXe+Ww4CAlU8c+JqrBbxucKujT6GUi3ZelE9VmF6y0EubpOlsWCRyPPSAtEliigg3vluEIn6OxX2qtChPX9HwM+5si9ewtN2A6unuMUR688q+wygBm7WGPE1HqYh8yjY0wgxPpxpPEPeoAnFU7R2lFYKlDx4DhV61PyCD4KZJDJO3rsaN68MFy8RHeMulpTughZwQQ/V3C19ZkZUajDDyxhqe/XMqaLjkHQfoKgK6WoieHHiOB+6cgqM7uHb66lfH4NSTa91dpSiWKhszo5iATF/78b8ZXMvYEp/lnicmJjxbnyC6Z0L/5hFLW3HmuQMI/VyktO/3SCRKcHnkuRDvgAYgboRhucW0SkCZwn/IEfmmpjE0fzZmQ5pUTJ6VUqrfAmRrTt5Toqp5ZQC6Q+WE3QbxOV5oengXDPvaxvWYxt2EEVXqbIemWxiWSIxossweXcJzd8M8a/+8dlcXa6PmCaVTZNNPFsU7NJzHFHDHEuM097LQXxTfaID7yZtFfH4CRKDzduYPHvNdZN3EgJpiJJ/u7OFNc56/5P0QNru6R5BFF0DvJG/I+YdEBvcs0gEmdeWnKlHJqvCcDLrUdcE0sKlRej0kRMZ+tF4MLBqRQ4cAqq0EycoxhsKQqORk+QADonRTC3Juv26pOgGbGFusPNTLVpoYcWU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bm6iLq/C3yIeqJSlmdQGRXVAOEN6IPpRYf9OMFv5lgpA9gMfcBQBBA7nD8?=
 =?iso-8859-1?Q?3qSdd+yg3OofFBTVNkkDVjnUGUahzXD3GrT+OR36YQmYszj5TCSTDJLejY?=
 =?iso-8859-1?Q?Mm+ZOi8VHDLrcXhx7B786h1SCbRdjg/zPeEAdPiS1tZhb/7R0un1zYhWRp?=
 =?iso-8859-1?Q?PyJWeteQhMmoqZ0LJJ3Q2KdQ1gso11lq6/WU/9xVYMBsNPapiPd7OIRunw?=
 =?iso-8859-1?Q?iDuJ90owwVH+zZ3T0CdEM27N0MW4aVcrrMCKUWN7IyIjofppFIxHEprVWV?=
 =?iso-8859-1?Q?JUpVppKJAn2Knhq30DXOphpOtTQyhu3t9u9QqdAP7TjGpairdcQYa74o9q?=
 =?iso-8859-1?Q?iUwErJDD3X981wL22tHAsT81rwFFEtHc6uBcyIRUziukl5TULsi1VFbuAh?=
 =?iso-8859-1?Q?JviWNYWfND86LJtYbVWEWflgxSjIKgU/3M2gEjMqz3I+jN352KQNxAhJi6?=
 =?iso-8859-1?Q?HZhIM6ZNKqXB6Oi0+VNe0pOwnYMLY71dCvgMX0WTDYq58PhXr3nXK2iIkw?=
 =?iso-8859-1?Q?33iOXuMBx8SaORtpyYRo59wqL0YvBR8yovj3oRWuurCzfNl/1SMMnfYCQ1?=
 =?iso-8859-1?Q?nbAXrBQ73PrkjQJjmpz0fsa5hTUQYX1xlRE4PTmt0mwZD+9LsposfIKGid?=
 =?iso-8859-1?Q?OxUTS6/123nYkWbm9sokyKBoi/NlfpL0H7Gu/H9ZlSa3Pyq1TB+WxBfC4k?=
 =?iso-8859-1?Q?HtwVp8wgHbgkzo6oNufZv/wWiX9CTSGgMyyrS4+/23Fa22McGzFI1hQgAS?=
 =?iso-8859-1?Q?k+d2gL3/vBSjJX/KAaevgWYRWBNPNF/rIksazWFfUGuKgYVGm0ThDaJQE2?=
 =?iso-8859-1?Q?4Nc+PfsCy+zSGRE7T577e3XQN1+yk2aCJfqISszMgmY5YYfJSRR1/eIJQh?=
 =?iso-8859-1?Q?pvlIb4Lyy1b5s7R1jBRwu6r7lEGW+8x3ZNlEQOvj+bI9c5icRXPZUIfQzl?=
 =?iso-8859-1?Q?2eX95CKWvJAx5RTxRqyKbXyk7rfnWYjVL41rTsRXhgRx8Wrt53B+ncGo4W?=
 =?iso-8859-1?Q?XCl5j8meCOtReYXlC3+UwHXqDNc56s3THTjOqcOKoQi793IgsB2Ei4blbT?=
 =?iso-8859-1?Q?9MREfZVNWSyJ3lO2pxWE8B1/TgMUFdOekASodnp1zl/za7ozB5o60TOOz3?=
 =?iso-8859-1?Q?+kbt4GGIQfPTiUGPw+tDdHJVBnseSSTtubm0ZYcpXcjgXPfMrkOWGu7y/m?=
 =?iso-8859-1?Q?Cx07VXH31/kwAY5UObDffCWt1/lI0edUPva4+tF8oeJZrI8+PWmP0U92Cd?=
 =?iso-8859-1?Q?vH2Xo0SebDvH6s+5xeSZYNiBpuTgVRHOWVFg4j9/KbDbK1J0I/IKp3Jou4?=
 =?iso-8859-1?Q?hO+L25aBQOX9WCjLZzl6K/pzksJTIl9vB22Wo4S3hLyz1b7t9IMOT9LkSV?=
 =?iso-8859-1?Q?qDfQSxO2Qj8VftQUY1VSApHqnLuZYxuzQk8Bt9CPCZR75oC1Ycp0HQGaKo?=
 =?iso-8859-1?Q?y4cKH9bR09N72qxi7HTfJLfPKfomjESxWFjtWmBbk9R6XOVm+YWvqDgGax?=
 =?iso-8859-1?Q?LOYVaiYCc9PCIKAuXOw4kaKbRjMWCjt0r5QrJh6nCbfcswao7HXs/U2dyS?=
 =?iso-8859-1?Q?X90OjmDGrjvOdkNmae5rmWX8apkPoO4JsFLP/x7TVBeY1R3gND/dPmD6hj?=
 =?iso-8859-1?Q?i1G09FSBS7elj1q6nbZbW/NT60zj0zEjlzOi6M1IQPzLNWzeZHMNlyD5rU?=
 =?iso-8859-1?Q?+65EerCoq6T9fYSscEHJ1+Pihgxiuf9YsmzyC0lwrMqSzQCAtgIOSuT1dY?=
 =?iso-8859-1?Q?26h8OZFniOZ4mMp81GHd7NXVLg4lRWrmY9XG4FmGonemqcYFcYr5oB76CN?=
 =?iso-8859-1?Q?Eo0DryXGVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SzOFkzd8zgSnCeZ+y95KOBs/lxFe0DCSFaADENny3fplUVTne4E5/+R8i9CXDtlsXPOUECQfIYwYHumOXNPNocqgEbj70BQ7reHdxqKxYnCPmWXMznQ0ou51lsg10s9CKZ/0Q6a5S6c6FACxTRFW7UISs1K79rkMW6aBJYd/FsG8ouQbx/jFXcOIDWN/y8hnCZ2e8KPkJGWkTwpLd7KTg1tugGZdhQvCa1TnYbqWHFSSmlYsV1LDuTYsB4ei+lToixXk5apwuWIBwCR1VZOZjSqchBgZEr85rl8132YqpeW/WC7bqJYKWWeSLMnoNVxR+lyMk+FLOR7NgaTDeeHCxQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d2231-1eb3-490a-1e68-08df2d8aedb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:44:42.6348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQPbi8wP2w/FQ1D5vu8vlqfgO5RLtQQILp+pLiPZFezzf3BN4PoRDqRzdbOgpzRVfUZKMkNcDE7fujEKcvbLQnROUhIq3sCS/aLm47DSTr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9279
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Setting msi_nonbroken in class_init() affects all machine types,=0A=
even when the ASPEED PCIe controller is not used.=0A=
=0A=
Move msi_nonbroken to realize() to ensure it is only set when=0A=
the ASPEED PCIe controller is realized.=0A=
=0A=
Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>=0A=
Fixes: f002aa35f3205d55bbe4a68670ba19a6dcf1d6a8 ("hw/pci-host/aspeed: Add A=
ST2600 PCIe config space and host bridge")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/pci-host/aspeed_pcie.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c=0A=
index b46eb74234..ceb010f213 100644=0A=
--- a/hw/pci-host/aspeed_pcie.c=0A=
+++ b/hw/pci-host/aspeed_pcie.c=0A=
@@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Er=
ror **errp)=0A=
     g_autofree char *dram_alias_name =3D NULL;=0A=
     g_autofree char *root_bus_name =3D NULL;=0A=
 =0A=
+    msi_nonbroken =3D true;=0A=
+=0A=
     /* PCI configuration space */=0A=
     pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);=0A=
     sysbus_init_mmio(sbd, &pex->mmio);=0A=
@@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klas=
s, const void *data)=0A=
 =0A=
     hc->root_bus_path =3D aspeed_pcie_rc_root_bus_path;=0A=
     device_class_set_props(dc, aspeed_pcie_rc_props);=0A=
-=0A=
-    msi_nonbroken =3D true;=0A=
 }=0A=
 =0A=
 /*=0A=
-- =0A=
2.43.0=0A=

