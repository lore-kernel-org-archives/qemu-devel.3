Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF9E83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY97-0002br-Ef; Wed, 04 Feb 2026 03:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY95-0002ab-HD; Wed, 04 Feb 2026 03:21:55 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY93-0003UH-A0; Wed, 04 Feb 2026 03:21:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4JradBaGNL5ER/AqpBFa2mlpnGkdMuAsdu9Jq06xjxJiwYmePD9wASOvc++ClNFf9Wxfji/g89aRDtcPIGnvzxiAu64HhDDkl9A4SsbGcmN//k+UYcSF+lOlZMsVrB6R7/DsMJxi8XvjXCZI+QmTOdgfbSjqjiT/YVGSPnhHT/L/yIWUxd3YKf0xlbCaQxPHF7382IYtyE6GKA3vnN8QPCfdf674wlJ+3hzIcXxlt+GPZ+3DeWeY2bdIVEYaPy9PaU4EWJ01sVn70OVLcidhcECSSDfLzSWbokKnXLAtZ9y1NZQ3XKZCOfvd+5XfvZ9H9KhlA71RPE/qB5TrNqSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps8oZPjTYQ2Nk4xegqe7IJ8sm+7B3EvcYQLSrPHUwx0=;
 b=Yp4boglTK26IwRYuvgcApsl9bFdyTKGB96pXO/8gJmrcSG33C2YRaRlOyLEjLh5DA1RPnv7ffQoe3P0jpyOchut1j5xubQNeXNocRZEVvsNLdW39ntKvWniSc/8Bs2Hb/LSGEuvjKVL9p46FAipphZikHBU1yFGkeliPuE6/L3MMd8qxp56w8sRQFVyoxuwlTLeyyCU5eXChP23Vl8jlZVSrL3ZCFonWJpFMZdhitXXh6gZrFqkI/HKkm/S1YRWXjzPSVfmjMcWkGpxOizt/G/2ivpl95Q6/idYgfy4CgFy6OtgxaBSZXH0lFQSDsk3EuDxS6PubpLcLxZ5aaIlaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps8oZPjTYQ2Nk4xegqe7IJ8sm+7B3EvcYQLSrPHUwx0=;
 b=OQMApNejKRXkJIanfOJMECy4LHU6CtBzunY4Xx9sYWEs5VSseXXj5kPdFyWa6bgAYRmMXQRPxMANipdtCE/b0YFSMmvENZc3uQ2+v9/rEmq/MhImNVuMu3QjWTQ948KiB/GNzbSoiEq02mRzyTxi+OOUJEgpjdga7Hh3Ht4dXl0Sg+D2nHZigeqJTf5dU1WZRIsI1qIxTISiwlhdPUYmuhMafTWgs2NhUN/6Mjaf6Raxqrl6PIA4IXDRtQRUXxQpxb6/IILmgc8SIvWiGMQNmrvyGynFqd9W3G5AgE8aqyFdbLNuGZzjFygI/T5mYMuvz1iatLY2k0F2X/zc7oeRtw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:43 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:43 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 20/22] tests/functional/aarch64: Parameterize I2C bus ID in
 AST2700 test
Thread-Topic: [PATCH v7 20/22] tests/functional/aarch64: Parameterize I2C bus
 ID in AST2700 test
Thread-Index: AQHcla9LcFQXrkZmSkyzF8U7Bo1GiA==
Date: Wed, 4 Feb 2026 08:21:43 +0000
Message-ID: <20260204082113.3955407-21-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: f427e400-0dd3-4233-edc0-08de63c66e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?txVrvZQ4pVZBmI5utwSGXnunDft0sUPQHpRHmQ3d41NobymOeKSoiG0+jo?=
 =?iso-8859-1?Q?YRR5M227x+vddfCzyN/onyy69U8lGJ/5cueP+gnaLbMPvo99FzCclybb4S?=
 =?iso-8859-1?Q?YpMeE2GJvEp6GGZb9tJlyFUvUrJkaLkz/15TcTpOWKP4IOOkSwAfFrHXob?=
 =?iso-8859-1?Q?4hlXj9HIb2TBjJ8aABJZRU0R3fPGVypsNNnziwZO80gqZhJ6Rga0SZxIxt?=
 =?iso-8859-1?Q?NWmr5XlIqft3NVvyZmRJgmaMHS5hpnSNg+yZgnrIm6NzIhEa/SpTSOb2TQ?=
 =?iso-8859-1?Q?D3aEDX+43NhyicA6C9tppcIB07GWwb0uQA88WvfoZKqvsUThUmgS1FIueS?=
 =?iso-8859-1?Q?T2+3rVOajo9XVjUp1IWKfh7MJCTmy1VzCBY6gkoiTxp8ywsKl4o5rItod4?=
 =?iso-8859-1?Q?j+ne72b18tf5bibi2+D4QJW+2vbpA8KDkvDAI603l89ACy2LZRaAHSo8mr?=
 =?iso-8859-1?Q?Qam6GdqAorfff1QBuFx+HyToFInQl7TN6SsFJolLNFQXx1fMf+dkzF1/2N?=
 =?iso-8859-1?Q?UqWTu9ktoGWb0dWpL0Rv7An8HBAY/VwQnglITrlkVdB3Vodqwtb8BFYonS?=
 =?iso-8859-1?Q?m19YTrjkItiRs8E91EnWBuFEvRnfaIYC562XkxTLFSGS9jJrR8OBiiPYPl?=
 =?iso-8859-1?Q?SSPvcPHGMsSUdtpXCsMvJO3NkJu15MYoOoxae3XyG9bM81idTIJmquCpAw?=
 =?iso-8859-1?Q?vkkEG9QD9/1Vccdv8TjQlnO5h0CnrYvPYeOUkfnuTAEkOSlOdE44JmcO/B?=
 =?iso-8859-1?Q?It7KpuPXydeIoW2Sm7U3nGYsh3MXcgp3H/ySJsK0SEJEAdAuGFZtKmVv17?=
 =?iso-8859-1?Q?pzCDOhmm2hrluok4+w6sVRzzVRJWsdJxiS7DCyfZbtU1PLoUwRCXR42jW3?=
 =?iso-8859-1?Q?00P990uurvfBF3CUE4gVRGojDk+PfO/fBt+yonXA8i+EcPJo8Q145/iSpN?=
 =?iso-8859-1?Q?Vf+tNuGFvOHs536SW0fYIBPu6wNNc/WR8m941ARyFNUs9bELYNjdoDTSPd?=
 =?iso-8859-1?Q?gUeXtAcUNUlds+0G69dcjtyHHVj/X7v+gMYbsKssaYJ/vvTI9+h3BndOzF?=
 =?iso-8859-1?Q?Ot/f42gpYh2hoZXIalTnZeRL8OSHZVXC5SjaGeLWdtYotAiKAICMInvQXS?=
 =?iso-8859-1?Q?sgjNjQcnXTTrKP1ZVhskz0h4tosiWEx/+4qVIIcTiVPo6mM9reyF9X68B/?=
 =?iso-8859-1?Q?8FEWv+6u6EBzeN5r59c6aZqVoTCQ86TjRpI2ZB/CAVcW7BaN+xlBQrCw8M?=
 =?iso-8859-1?Q?2Lz5G6Ekhd8fSINWFc+4NploV08Q12NMVBMxiqo67iZwBsyIaoKhnZmUC3?=
 =?iso-8859-1?Q?LP3SxehmjjeJxumMXgWmpKmPi/VksTIgz794HFhtNxBHVhVMiDFlO5E597?=
 =?iso-8859-1?Q?0yqVvIZ6XiseyCgH9YSPCk3b0EZgiiii8cpQCz8FKcD5VCqyOrq4ZEQO+6?=
 =?iso-8859-1?Q?+DE8fM/Umom5+guU3g9yEFVDX8Q7zIDLDAWC7eJtfp3OOM3RLP3qr+qKFT?=
 =?iso-8859-1?Q?OC3xCUo0XNqbN0N5X6FSEMlLpwe/2lzqo7iGU7boaqZHdgwUD8bYA6uSxK?=
 =?iso-8859-1?Q?qDjBR96N7HUak4CeSXITj0C0HJB9yYj7x5X09b/GQmsPii9gXYaZexyAlK?=
 =?iso-8859-1?Q?vcGOLa7PalcjC2EKRpSsrgk40HlTrI3PSB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jMK2Jr9fVLt7jr7VtMd0EJ/7ZOaXAgnT43KSAt4mNKZc3RmWo+AAglxhTf?=
 =?iso-8859-1?Q?RpoDtNonp01H1zzYbhg/V832K6S3UM7ZvkFQY9IkMePxvtRWYw8wqmxZgJ?=
 =?iso-8859-1?Q?CunzR7cJNOxerLACar8RMybloHY0o5gya7nMvBL0FM0XthUj3Ks6gGkxnf?=
 =?iso-8859-1?Q?MYaebN8liGjlSJv3A9hT0HOpKNEqIfxKKpBB9QyUhxb0qpQ2w1VrLPI+ov?=
 =?iso-8859-1?Q?8TyGTgkL0+O1PJwnw6AeBnReEgHTmq3DI4bR0vBkg071gVpyDGHbqAEw1G?=
 =?iso-8859-1?Q?Zw6eYFgVFpGlHxyohtUtesEeF18+9bCj4/ymLYG0qZpb56pwVVgnS68lvA?=
 =?iso-8859-1?Q?YFhxYDSqTfWGMkhE48v2KZE2iZuT14+xLaK/ZDqXVs/zaPtQYd0nDH9Rmj?=
 =?iso-8859-1?Q?JB3oqM4RjRpycgYkX3FwyncoPKVAEUif7+DNGmMgxM+65XX/mZnAa4R8um?=
 =?iso-8859-1?Q?K+RflKsMF9ahrBWf5ShpiuH3inPxyU2VB3eeGIu1u6LlO0PN+M9wlB8CTo?=
 =?iso-8859-1?Q?wT+L6xZMAtHv7wpOnoD4IsKlBPF4Y2gF9PZuZPzs8zGagx67ZYvY1LmRft?=
 =?iso-8859-1?Q?l9OT9UMC+rkYPs7EsT9V8vKhxgoN4VrN0vr5EH/O9kkOoHRt2HIZzhFnxY?=
 =?iso-8859-1?Q?a1Qld8HlT4UHyDnIonqWf08BqxQa9cdeI6hhNeNraoV/r/ouNWPzj+jjqP?=
 =?iso-8859-1?Q?gc5qbiauGwmgwurrt04yOkOPuaqKK8SoxjrJh3RZsyqC2J7Hm8bLPRfVQ8?=
 =?iso-8859-1?Q?Bv63MxiLz869pp3sCtybpAnDngLt2YGB6zZquro83HWeRr/aEbyNupbgX/?=
 =?iso-8859-1?Q?ANv6hXTE2NRMBtYxHN5zVIA86dEer6O6ocJXNrYTteUU/Ac7nZqSpGldo2?=
 =?iso-8859-1?Q?1gc9B0xIOAxssZ8RNf44Of/E7ds/Ko00RdfXpCjoNz6Jk6HzSYYcDn2CvM?=
 =?iso-8859-1?Q?hB9KxfH0LPH1D7gE94qutU149MiOZfwIC2xNNKn363rRGEeLeqUXaEei7F?=
 =?iso-8859-1?Q?fu2dxS87BRIwbG9vXSHNq2/5BUVfxd5VWK3nBcAh0a5Uyj8LpgR4BrYF43?=
 =?iso-8859-1?Q?qyKSOT8mpJQkDPfnrF0SepWGjCvTd6nGnCgIO62tFiyve7t5cSO34V3jbL?=
 =?iso-8859-1?Q?CK+fomGhs1/2NgGq5rSWAOnCE5VP4eRjW+O1dUFkHSowLuP2li4AA0e85l?=
 =?iso-8859-1?Q?Kt7wjY+8ZeKywc11DE24juZb9u1BBjjuZLC9NbYnqJNxg95DSjQg6VnBsq?=
 =?iso-8859-1?Q?4IFLWRpd9BC4foFRE86DkGywxhzOkuMmBN+y43j9A7xExGm8tAXCyX4i8C?=
 =?iso-8859-1?Q?z64lkMwKLxz4co8lUfAJ9zHhJWs8yIPUdIgbAX7vAEgbv1kOU1E+8CquBp?=
 =?iso-8859-1?Q?QPO+YmbUN8h9lygmfK1CC90QznsmAUnnA1175CG/mHEndo1VYk5Zk2l8Ee?=
 =?iso-8859-1?Q?S0afOAEXOKU3D5MNIdCid6YX/xxUtYK67w9XScQKF+TowxnEl90yih5R8q?=
 =?iso-8859-1?Q?xbcR2ta9Zv3TUcbs6x7a4A8pM/JMtMa2vWD6/z0UU03SrSaiDEHIEJS54S?=
 =?iso-8859-1?Q?a4FOad6yukZ56sjvej3PFL0Huy8vTzo/sliDmFZGlBD5YJPXNe28zy0+el?=
 =?iso-8859-1?Q?ufrVdJzFXnni6azCtemZjWcKYukzy1SnqfXK1HfGKVr7DWBxrnAEldPydc?=
 =?iso-8859-1?Q?E5h5daSHl4MCR2rlqlM9H5FS4+YpUOxFBqQssys/oULz65IvY5ehsuiwNe?=
 =?iso-8859-1?Q?HxWUnjcPn3x1ng0RyJCs31pBaS5ADUnrVZu1mImOY4ucJ4UdCUl2Zjc/Vk?=
 =?iso-8859-1?Q?52Y9Sfglcg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f427e400-0dd3-4233-edc0-08de63c66e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:43.4547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAKx0/FhG1YDKmLl0IPeD1+efr0sWwNPf7hxIZnXEhLMDr9ZXRlFCBgzdJLZIrghPedB8cwke6zYtlBCm4alQhByQ3Re2UK+Q+83mt87AZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

The current Aspeed AST2700 functional test case strictly uses I2C bus=0A=
1 for its sensor tests. This hard-coded approach prevents the test=0A=
logic from being reused for other machine types or configurations=0A=
where I2C bus 1 might be disabled or where a different bus needs to=0A=
be verified (e.g., I2C expanders).=0A=
=0A=
This refactoring allows the same I2C verification logic to be shared=0A=
across different test scenarios by simply passing the target bus=0A=
number.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 39 +++++++++++--------=0A=
 1 file changed, 23 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 828ea1ca53..d7eeab9c23 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -15,11 +15,17 @@=0A=
 =0A=
 class AST2x00MachineSDK(QemuSystemTest):=0A=
 =0A=
-    def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
         self.require_netdev('user')=0A=
         self.vm.set_console()=0A=
-        self.vm.add_args('-device',=0A=
-                         'tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,id=
=3Dtmp-test')=0A=
+        self.vm.add_args(=0A=
+            '-device',=0A=
+            f'tmp105,'=0A=
+            f'bus=3Daspeed.i2c.bus.{bus_str},'=0A=
+            f'address=3D0x4d,'=0A=
+            f'id=3Dtmp-test-{bus_str}'=0A=
+        )=0A=
         self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
                          '-net', 'nic', '-net', 'user', '-snapshot')=0A=
 =0A=
@@ -75,16 +81,17 @@ def verify_openbmc_boot_and_login(self, name):=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
             'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
-    def do_ast2700_i2c_test(self):=0A=
+    def do_ast2700_i2c_test(self, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device '=
,=0A=
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')=0A=
+            f'echo lm75 0x4d > /sys/class/i2c-dev/i2c-{bus_str}/device/new=
_device ',=0A=
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0=
x4d')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0=
')=0A=
-        self.vm.cmd('qom-set', path=3D'/machine/peripheral/tmp-test',=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput', '0')=0A=
+        self.vm.cmd('qom-set', path=3Df'/machine/peripheral/tmp-test-{bus_=
str}',=0A=
                     property=3D'temperature', value=3D18000)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '1=
8000')=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput', '18000')=0A=
 =0A=
     def do_ast2700_pcie_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -99,7 +106,7 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
-    def start_ast2700_test(self, name):=0A=
+    def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
             {=0A=
@@ -128,12 +135,12 @@ def start_ast2700_test(self, name):=0A=
 =0A=
         self.vm.add_args('-smp', str(num_cpu))=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
-            self.scratch_file(name, 'image-bmc'))=0A=
+            self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def start_ast2700_test_vbootrom(self, name):=0A=
+    def start_ast2700_test_vbootrom(self, name, bus_id):=0A=
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
-                self.scratch_file(name, 'image-bmc'))=0A=
+                self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
@@ -142,9 +149,9 @@ def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-a1')=0A=
+        self.start_ast2700_test('ast2700-a1', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
-        self.do_ast2700_i2c_test()=0A=
+        self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
@@ -154,7 +161,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self=
):=0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-a1')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-a1', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-- =0A=
2.43.0=0A=

