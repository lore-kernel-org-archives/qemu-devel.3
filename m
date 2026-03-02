Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE10D58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEy-0000Wg-In; Mon, 02 Mar 2026 04:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEt-0000Rj-2O; Mon, 02 Mar 2026 04:06:56 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEr-0005WZ-4v; Mon, 02 Mar 2026 04:06:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQKZW0b1lkXdW0HAXYT7wK0rC5GxZpGqY0rCifSr3o+E4xF0A7wrx6S/dI3pyqeyIqqWEQtL1OQ+M2A051jv1699jbEf4fysptpRPv6ZOnorBYhBNfDM9acCD1sq7cTqHaevzNzo/k3oh9gGTDlDev5XlGrbHAfVs3liEM0OT0VbrgZMJjohcWXMJ1gWOOy81lh6WYAhLrwxlv+AvvdBG26VpEAbws4kuy0cMMKvCaB5x0oeelvHIQDOgGc5GJt+DDtl3P2C2By/gSMEowV8PqdeIEWtP5X2PS4CprB8/RTkoWk9rEe6i5Ieeg8WrHGHktVZEEkZbqLcU3W3uUfFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCV3Z26BKk/0GXuFaHsZew9xhFBrlIfzE5nznCSqtPo=;
 b=D3fpHswMirzL1XNL05lEuSwEM2PNhFUGv2Kxk/anv3hbTd3Ta/2wWjNNjFQLpiZy7ukXLpVDEHl/e4gYrWHfDz0duxvI1DnZrvfWir6Py4bSk39nv9cBylftoKGwNq6fnpvb2TQh/WRnEvIdztjeaJA8WvW8WLEFH/HWWZpHXtEAauUCh/b12UXppySlcIHJ24zmEd96flP+0w/QRIHElzxdXNfm1uoNyFLbyHustII+r2x93k+9zR9XTOZ58MEFJQruDlC4eh1935xeikwgt1pLNm+QdaYlKoFgcr0gIYB1l8kiD9qqkJkYn+UtL7UrkzLDhdTp089U7txkCiQsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCV3Z26BKk/0GXuFaHsZew9xhFBrlIfzE5nznCSqtPo=;
 b=a8NdWt7sLg5lRjaLr2IaZFlrWZAcHx1i3oIop70h2s80Zmawq5yFRE0Ab0ABEIo4DeXWTVQNOJKF2hgzpdv4gF826s0yoGqPidxJiL1YP7uE2fSiTgnSxRyAkxnbqtxtvp4dTStA/KFko6OJgslEi98GRbxFmOa11nfqKtR5zE4QAPgEMrupWIHXAjl4lE86Q77h5uIuz3ktTLBto11Nxw/zFYp6laXZnMeVza1IbbLCkjxajgpXWuqJbxpB20xKpzeEWsIWEuJiuXZlFVSnW0kcn5r25Px1IbzctRwwsxujrxjSzizm9xHhQFaleRYuzFk+Q78CheHyyZ3PdB7xWg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 10/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 10/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPhjKwtS7r3MkC6WkN95Xe9rQ==
Date: Mon, 2 Mar 2026 09:06:39 +0000
Message-ID: <20260302090624.987922-11-jamin_lin@aspeedtech.com>
References: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: 3fbfe0d3-c0f7-42e0-8787-08de783b03f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: NK+o63n2y6KtWBbU2uzC4a5dBVUe3xhPMyG5EcR7RxPncua1/ALwR1fMbym1li53t8zZn8Gj5ptGtrXWI5If2w8Y5rseyznbNyzA+QXHCa2WnZhkWFmhll1pcsKQM8iV7Ro8nMQykOtsUr/AzqKfTwtNV4eqDDVqJqbPHL9tE2HTDT7JzCP0bzx4JRHP8SKG3uZXJswytAyVdwV/2R1v9j4WeLi5svpfacH0w+cCqTXtXlphrvg7DHhm8zv7sfcVMNA/hxlc+nNUhedkWK5W9tMpTZBb3CqBbwp/R4I1toL1lLlQgg9+ZhG92XNgrBXcysKTe4H/p6LDgNy5AG3eNVLkyiIYQH8F7nkPXgIm3niF5h8g4q5SR3qwOC0FdAvtWc37W9J9zRlD2NnDr6flzerGtHrgZinqkRjlmIdaSIe4o4vT3HO4x8tH78WVY02XefkTnBSgPERxM65MbxC8/TuS+bOqCG2aBCQIVhkjn8BYDC44UiSfI3CIpNtr5QDeqqIW/6gGni2Ukh2LhoXKacyv71suCe3Fl5MQIg2u4zM+TNoToZy6ceQu1z4ApwCG8gSDZQNmzn2WXnjJ0qCXWAVgJ2fov7bjAHklWBk76TvvLQMo2VPsiIZNMDP81e/9ba2pLkW5NCM8Z7fEW3WzpFlxa3gcgmrdvgWvlXjjLA+ck9kVhbWcVAsLhxOZwsfJDR5WozqkgKuJ40qsysIEqXpgfgp5liuBQ73bJ8wPqk/mAhp5kV4drCjTgVjcmbpn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m1e8jcsgCK0kQKGPX2CPmG/BdLNfmtigQsVlkvKuUmuTu5L4keyLQhDYmH?=
 =?iso-8859-1?Q?xMtMFF/t5Uk+9H7tjtXZWS6tFVkp6UnKXN7fWHC824L7ncwAVKxhK376wU?=
 =?iso-8859-1?Q?QQNcGnfIrAY3iw+lRSuk2IRaxumqcI8n+W1Lu2/tp5Y/5+HXBSIAyOjQje?=
 =?iso-8859-1?Q?bUjsP6FxyKHhV868bdzNhooBR4TVixBEdQt9VrRgB3RrQnl4qv28jl0nBW?=
 =?iso-8859-1?Q?DN3whd2UqsEeC3WdgwCkqFS/2LFhu/Q3GK6jqNQltZ7YBVUhEgRbF6Td6o?=
 =?iso-8859-1?Q?NN0n7uejz/SuhGqs3Lc/q6gzX6dH1clx9eSWzb6yHCztV9MKdYQQkmj8wL?=
 =?iso-8859-1?Q?T++9j6Dd5Gt71vvdjksRC7UWjUnU2yC3m1hwJ0vj1bmRgGRoLNZa19AwAs?=
 =?iso-8859-1?Q?OezqTtMyiUm2DTD/y5s3hmTHqtP29HSsbBbbiZUiVrzUG6KshBC0V9GfOp?=
 =?iso-8859-1?Q?ZpVSIZMYuDIcRVmOgqFkjIYOM6aDUXsgmHe8KyhAruixTYKogYJx4P5HaZ?=
 =?iso-8859-1?Q?lJYVnMATdhJp+s/3ZsIKiNXe1oy71qUeN6RLTbX7SEo/FOq074tXNswqmO?=
 =?iso-8859-1?Q?TcwBopIl/XNSt53KhtXs4ZAfGZy9YtjV9Q0yc23P4Yl5KQartP2bql1PgZ?=
 =?iso-8859-1?Q?w/DCG/BG8HJnk8d+24fbQA7jbDxlL6Yp3cjYa78ULTTI7WUbR4Vc1LEHQ9?=
 =?iso-8859-1?Q?NNGmiP8WJnSCUIPzzzXMR9NBFfibY4XSNkvbmidW9NrQdadP/RnCVlQw++?=
 =?iso-8859-1?Q?8AbBIYgsqO+Eief8wNDPzgNnMgQuCLlK7JKb36/v0Z0zjVVCmyD4HGDvUo?=
 =?iso-8859-1?Q?DwuE0a+gr5+Mudf8j3Inw5DjoZQHmgMih8sctgwHtzfwTlacYZeQusghkm?=
 =?iso-8859-1?Q?zclT5g79kPGWFZfQZCpNJOrKyOgF8mKSEA8uI+k67ONwKkIqNAj1XjW4qj?=
 =?iso-8859-1?Q?LaQfuYzP/JDCsbDKtxzgEtQnKHr/MQpV0fcB8vgbZ7Zd2kvzX7u3qe3F9E?=
 =?iso-8859-1?Q?FN7FQ4FTCXHeV0ZEKLX7WiRQdlxzQT3Ofj1rycmWc84lpLV+WfJ7V68W7C?=
 =?iso-8859-1?Q?pOirENCpRtlaxnjau/7lF9GF8Fc0GrKaoZQmDSVnI06k0FlZ8fu59qmrl4?=
 =?iso-8859-1?Q?KA1T/NBtVzsdkxC2JmGCOEERMIKbc2h30QMQYQiEGuKujME5TBM9d6RPFS?=
 =?iso-8859-1?Q?R0ojPmClPjzpT3TFh3HxDPrurY+I7VL5/OzxYv0880YVPC3ei2i1h+49G0?=
 =?iso-8859-1?Q?3tvfVzqhZcRa9lObhueAScaMuENGIXMA32td613hURrUBwt7pJAsD9IjEz?=
 =?iso-8859-1?Q?55mgsPTeFbabjhvKGKpNo/4AyuknRKswB8KXym2I5QEFl5q3TWewB7RUdn?=
 =?iso-8859-1?Q?B1+FJ4cUvjLG9bsI+O9R5+Qi7MF03QM4C26cIxxzFeZ6YzqMRQqMRX6C7c?=
 =?iso-8859-1?Q?PrrPrc/elhnpAPtS6PFXkXS6tG3ihW+PDFIl2NdZk/XLMlRurJfJdC+Gmx?=
 =?iso-8859-1?Q?rfx0cOA+miiG8QbiTlbBpv8ngR14skuIwy5LWfIWmUgFz1thT3zTqF+/bC?=
 =?iso-8859-1?Q?bI4L42iN6LvuHqWDeTpj/6syryqeSFKQvCuvkoT+pgvzJ5neeEvQzoFf5b?=
 =?iso-8859-1?Q?manVXOxozFyjtkZE42BQy0j1GvSMjrUDcn4fTKDLocwk63xbIFZPGLNtHO?=
 =?iso-8859-1?Q?j6Pd3Regmg1ozJQ4JzkEj0kWSiqG45FhBZOGb/V6VMoiJFEHV54towX0vj?=
 =?iso-8859-1?Q?THF34AmwsIP3WqYO67FW8hpf+LVhXvyKKGmC76xuuz3rIsfwaBmVTlCbjP?=
 =?iso-8859-1?Q?Efqmb+4H0w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbfe0d3-c0f7-42e0-8787-08de783b03f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:39.0935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIgquQuELwCl4idn9TzYM3LH0gt5LY+LQ7s7+ykBZhVQ15sIEzLxQWAPXscfEwN4oTNINEQba+lJ/R5XhkHrmbaaMxh/jv0XG94pYn/KS9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py           | 18 +++++++++---------=0A=
 1 file changed, 9 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 51ee8bc787..f68f40a1bf 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -61,9 +61,9 @@ def load_ast2700fc_coprocessor(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
-            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+    ASSET_SDK_V1101_AST2700 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
+            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7=
487')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -148,23 +148,23 @@ def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
+    def test_aarch64_ast2700fc_sdk_v11_01(self):=0A=
         self.set_machine('ast2700fc')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700)=0A=
+        self.start_ast2700fc_test('ast2700-default-image')=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=0A=
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700)=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-default-image')=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
-- =0A=
2.43.0=0A=

