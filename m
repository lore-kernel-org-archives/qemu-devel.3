Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EF606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Jrb8JJfi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVF-000424-LI; Tue, 24 Nov 2026 00:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUx-0003v0-O5; Tue, 24 Nov 2026 00:55:27 -0500
Received: from mail-japaneastazon11023108.outbound.protection.outlook.com
 ([52.101.127.108] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUv-0002KK-Aj; Tue, 24 Nov 2026 00:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLAhgimWHtuDuTCgm86lI/sEj+7qrYBWSVrhJJQxFmTPwpewiCQy7f6Gv4ZWTnzNM7MYgo3+OWFrivFwCCKOD4u/XhICk6J8J/KEpe07kZoxqpJaMQ5sHUCBr1brqGlu//QPSnqjMzdo8N2RCGsKjxwGirubVlLasMrMj5Ad/8/LiIXaKF8plkkAsY/uX51Wb4KNA0zxcRuHWA/p3UZc6GMedivi1NywP8/4Zp1D2xrriRCqf/YLdFFRTe4UKQAAmIXssp4ubznXFyMQhKWvknzQ4T9NAwOAZSxFwbiupBP7NX1blJHhI+hJmQylkR2+PU/Qojt9lw/6Sbv2irCE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYE+i5aujLwD82orOO+yoiusVxGmvcDVQw+XtQMQWw4=;
 b=AdEmvRYBzyciSp9ZlZboSKzifz3hMtWyWR4B20W4f6Mov3hxdz9jOw96UDlEf4WwpoCVtgz3nUhbw8MOPssBbxttdw9BaPmV8HxooCCfSO1pR5FywiVzMagYeP9BwQ11fb+2LHVVQ7ZCqLE1niFQVvog2wBek1e9Ov6W+XX7XVyn7ObmJ4xot3xSATSeMd7FXhGrigvKit4yuYnZLjmHQIJzW3ipQFtdrSUp4Km2wEy1O/JcjW9pZjW15Y2ryqJ0UfsTCawblj09EjzSJcs1yo6mEqnkCriHIoGb2dyAeOFeVPw2kCBpMonGtO1ma0o9sw4r0T6WrEfjvzhyPqoOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYE+i5aujLwD82orOO+yoiusVxGmvcDVQw+XtQMQWw4=;
 b=Jrb8JJfi4wUxc4580W9g60vI/8GiKTq94L3K+9We8kYnkV44U9MlzUerJ0E84DaI1181Rogn7G7Gc99lBuOKGHwNcnBB8WapF0YSc1Qu0R/1LZmujC0VvUDs3T+scpb8qZrVUaWXyXu9fgvbGcq5OV51vsy3v+LeZ/Wr58E3R44CSZqWMGbxneKrdb1L+TcpXOx40S94QqT/vVxW5U+ZCoNWwhwUj1dzSwbBFOXvL1Bb7bXwBVCSBjv9pWm3RCwF387bGePmxDn30awiFaf1UFdClN3VtuODUrZ0RUsWH8KVp+eWgUoO/9gmgNP8puqDheWhAjW93mB10431s5rw1Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9293.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:56 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 05/11] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
Thread-Topic: [PATCH v7 05/11] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM
 remap
Thread-Index: AQHde9fpCVPv2Z7R4k+THYueohbAEQ==
Date: Tue, 24 Nov 2026 05:51:56 +0000
Message-ID: <20261124055150.1328856-6-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9293:EE_
x-ms-publictraffictype: Email
client-request-id: 4f59b436-b0ed-46be-8289-02db3935375f
request-id: 82c83a6d-83e6-4ada-1ec3-08df49ef0c6c
x-ms-office365-filtering-correlation-id: 82c83a6d-83e6-4ada-1ec3-08df49ef0c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|6133799003|261009223027099003|260925021911599003|56012099006|261021121427099003|261026121527099003|261022075727099003|260925021311599003|261102123227099003|38070700021|260925022911599003|10067099003;
x-microsoft-antispam-message-info: kH4BLXKWznOLe8wu0sIkR0bFxRTsutwjOB/FclPyoQCDmy6NbpMG9anhJ4FVVwcNXpOJB3GXxI4SuUx1/XXnX5DWTuwPnbVJRxYwxcZAlw9kN9mEpVkmQSjqQtaldLjejTspslAeP2chVg7Rwyg7Bcj52El18vfjeEpppykvQZgXQczVfvSy48e2gEuDfXbrE7ZtmtSHSjG8FBKriflBbq2Q9TNVs3l0fxWjx693bUlD5iCirvQ5h3DpO1onlAZMuIEpffkzP4pmlHAnLMZpOpZFHsHSsgh+aEK6NND/8Um2XeKi/hQpp7CiryivRf3gU862MwbORXOjqVtfoCBmJN5AL9IeP1ei4mWteM5Yd+kH71foUH5cqq9JQABPQwYcxMLp/fu8CivkAt+LW+fNtutz7kRc/u8jYac/81ZUeEca7+K2OhH1yOsMppqmM+Xd6WiENtNTpEB2E6XMkMPqvxqzaN7kvqgZBkeGukU0SjZ15WFbu7lnUAI2AsJIoC195DWPtarFAEYxUV3ysP4ab8XZXCMHkstGVsDOz9pcNDyhBDQtdY5aeJKPzWV5dEGOaCumzLtwP6i2J1HMM2uooZBWZxwlvARjpDR8h7opmLoYOAVPf5gF0bY0BVoGYhXrKhwV5P7zQC23IBsmD6Az34zVbMc3iOivoS5bSueMUNA8thybkz0vDBzJL4eQQz4q3BwZRDxQ0NVRZlMOGPWupA+I+jQPMYsXUyW2vLdzAIA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(260925021911599003)(56012099006)(261021121427099003)(261026121527099003)(261022075727099003)(260925021311599003)(261102123227099003)(38070700021)(260925022911599003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CkNWZBii+PMEq8Ujzz7kh6xGf1D9/fdFFIJf5S6QPn0oKjaFzUvJGfKZxU?=
 =?iso-8859-1?Q?qI7z31CJqjxz8+zhITNr77FAhPCspHlfKrCxsQ0ZrDzF2Sc5qk87yhu+kF?=
 =?iso-8859-1?Q?x8X9ypOcJRT58/CUIWAEzF9tew7SQ98TNft+PqHrDaxaKcPx8iBvN6mpjz?=
 =?iso-8859-1?Q?I9TodkXKc1eE5WDlHuaGZL38HIGdV3mIM7DMBPiiLyFgaF3bsQ+Kp+9CQb?=
 =?iso-8859-1?Q?9AogDOBeXMyGQFuqtSPBT4B2WyGj+m6QJNYyWHC3BdfvPjN7ftNR34G6HU?=
 =?iso-8859-1?Q?drSkPB9tNUGS0HnbYrUsfNDpYuGLEOYLIk+MeaM7AVHeiCMQFsDJu7QhfC?=
 =?iso-8859-1?Q?0MlUzM0VNlELOYwUDWQBCkXjzWNO+UERThtAjdSEZ3wbpG7ZRdjTXS6tSm?=
 =?iso-8859-1?Q?ylWL5lxPk0z01SVhx6sPrZSDOrJYmcn7LMCDLOkc6znCl0lgMLGRYrDJbe?=
 =?iso-8859-1?Q?foqWZQ14IjY/CrH0hAWteICMqYShfuQ1OVwlPUKH13v0vaAqHfBbx++uiE?=
 =?iso-8859-1?Q?SxhLDPW+Ksrlp3bjtdSSZD9lwK/veDUczFS7Z2p+v/zySFHyBvDE0C17a2?=
 =?iso-8859-1?Q?v41spoeJJoWK1ZN+iWq1Os4oAbX/4+O6lfVWkDtKYy/i4QltA8XImIR0KD?=
 =?iso-8859-1?Q?Yx6o+8wOfvwplNR45ZEkNVRsd15yfCC75hIFClU/9lQitSvaCena1lPoYV?=
 =?iso-8859-1?Q?fyJ372LmSSmDjTTg+upoMCTkcY4etApdvt+57JhWIY5BdpQt3EObZ5ahub?=
 =?iso-8859-1?Q?+/owcxyVAXE3ojFjHtex/LzQzX+ckVzWdHboPKkd7PiRQou7AUAyPiNPX9?=
 =?iso-8859-1?Q?3aJjEKKS4rmKTkmZIyqmBjI6Ukizd0t7PGSg+Rk2uqR87Qlgv6DBSWeosA?=
 =?iso-8859-1?Q?JZtIZfBgygip0/G1bYEZsZe152d7UzlribIPEQSyzu0zErEd5glAvyIRDC?=
 =?iso-8859-1?Q?ZDnkmnOU5AEhc6q8HEFGwQYcnmPa0wcwZ5Zw1KPAkC0PAECLjJT/6KmBhN?=
 =?iso-8859-1?Q?gNSd4/2gMX/Cd14BwmNPasfPdqilb8xfT8ROOGv1vbIpZQePn4jIA0Lo6I?=
 =?iso-8859-1?Q?hywZUVx8cNy1xU3tdK3pKlioD7nZmWkowvPpw1HBASuzPoK7wvEtjKAFj0?=
 =?iso-8859-1?Q?8BX7PUZGfzVRuiZXexwfsB/+gbhNzqxZpaIHikH1CGClEP2CK+QZ6Z2vKK?=
 =?iso-8859-1?Q?kC0RvCJu6WDJWdWG9E9oYXUPWXLADJ/N3Q3gQc7vTEExaKBJRrysS3CBM+?=
 =?iso-8859-1?Q?3W+/N9rYfgV5aJ/Zy6YOGKlh9zpVQf5kKzTOPM/JHuKFd5Z5S80wWoXk31?=
 =?iso-8859-1?Q?C0YrriflQ/DY+Lm/YMgEhIh57nAEyiCICTvAN2zyGEqeY2qVk3/SIzrJUa?=
 =?iso-8859-1?Q?0DRhYsOaHfMw3cGbylZSqowWMTwtlfrIlzlX1YH0ab+3eToSjw0AOrWubU?=
 =?iso-8859-1?Q?Ve6bZR3XgGAUk+98yFqARVjoleWsjVQSar4Oaf7ocg8l5tXsxf1bQBNN8I?=
 =?iso-8859-1?Q?mi8sVYW0dItGAuyXATTGLmcXcOeShTzxKnc8YDb8VKTikwwWKvvYcNaH9l?=
 =?iso-8859-1?Q?dFweGnCcs8STW2U42uiqHkORWjWUt9r1JZ3+FOqXkq/Tg8eV0mmeiQy62F?=
 =?iso-8859-1?Q?GbJSc+9omeYHrntDSPf0Z91V/tpmQuzzoDcShBKWnMlmzE3amvEdtz84uo?=
 =?iso-8859-1?Q?RqBjipjafdb2/Dop6R0QWgiiFgInggzmlOsSwscL+RqgP7S7TlSpuywCcZ?=
 =?iso-8859-1?Q?0/orxWqkn7s3WZbRwf9azxEbTBm8sZftiKr2dRgfgVqyeA5eUkpbfSAu40?=
 =?iso-8859-1?Q?+37EjnbkGQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c83a6d-83e6-4ada-1ec3-08df49ef0c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:56.3961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4v301ra11MwwKunOwTb1q7S8Kc5eFwMmiGYaY5pXeN0+pqf33gr5cstG2qzTvOqEdflIcEdeA/gEH/qcOFaCUQd6D20F3alV16+0FFc6sH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9293
Received-SPF: pass client-ip=52.101.127.108;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds a MemoryRegion alias to support PSP access to=0A=
TSP SDRAM through shared memory remapping.=0A=
=0A=
The TSP coprocessor exposes one DRAM alias:=0A=
- remap maps PSP DRAM at 0x42E000000 to TSP SDRAM offset 0x0=0A=
=0A=
These mappings follow the default SCU register configuration used by=0A=
the ASPEED SDK firmware, which defines the memory window mapping=0A=
between PSP and TSP.=0A=
=0A=
The alias MemoryRegion belongs to the TSP coprocessor state itself=0A=
(Aspeed27x0CoprocessorState), mirroring the SSP remap; the SCU only=0A=
holds a pointer to it (tsp_remap) so its control registers can=0A=
reposition/resize the alias at runtime. The pointer is exposed as the=0A=
SCU's "tsp-remap" link property and is wired up by the board once the=0A=
TSP is realized, so the TSP does not need to reach into the shared SCU.=0A=
=0A=
The TSP cpu_index is only known once the TSP's armv7m core is=0A=
realized, so the board also sets it in the SCU at that point. Its=0A=
"not wired up" default of -1 is set in the SCU's instance_init().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  2 ++=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  7 +++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c  | 17 +++++++++++++++++=0A=
 hw/misc/aspeed_scu.c         |  4 ++++=0A=
 4 files changed, 30 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index d4a5fa43d0..4ad3bb2308 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -46,7 +46,9 @@ struct Aspeed2700SCUState {=0A=
     AspeedSCUState parent_obj;=0A=
 =0A=
     MemoryRegion *ssp_remap[2];=0A=
+    MemoryRegion *tsp_remap;=0A=
     int ssp_cpuid;=0A=
+    int tsp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 2ad1ad39f3..0da9608933 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -196,6 +196,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                             &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "dram",=0A=
+                             OBJECT(psp->dram_mr), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
@@ -206,6 +208,11 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspe=
edSoCState *psp,=0A=
         return false;=0A=
     }=0A=
 =0A=
+    /* The remap alias and cpu_index only exist once the TSP is realized. =
*/=0A=
+    object_property_set_link(OBJECT(&s->ca35.scu), "tsp-remap",=0A=
+                             OBJECT(&s->tsp.dram_remap[0]), &error_abort);=
=0A=
+    s->ca35.scu.tsp_cpuid =3D CPU(s->tsp.armv7m.cpu)->cpu_index;=0A=
+=0A=
     return true;=0A=
 }=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 7348834458..a67823fc47 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -181,6 +181,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->dram) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'dram' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -229,6 +235,15 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
                                 &a->scuio_alias);=0A=
 =0A=
+    /*=0A=
+     * DRAM remap alias used by PSP to access TSP SDRAM:=0A=
+     * - remap maps PSP DRAM at 0x42E000000 (size: 32MB) to TSP SDRAM=0A=
+     *   offset 0x0=0A=
+     */=0A=
+    memory_region_init_alias(&a->dram_remap[0], OBJECT(a), "tsp.dram.remap=
",=0A=
+                             a->dram, 0x2e000000, 32 * MiB);=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->dram_remap[0]);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -298,6 +313,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
                      AspeedSMCState *),=0A=
+    DEFINE_PROP_LINK("dram", Aspeed27x0CoprocessorState, dram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 1568b74964..f31545a126 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -952,6 +952,7 @@ static void aspeed_2700_scu_instance_init(Object *obj)=
=0A=
     Aspeed2700SCUState *a =3D ASPEED_2700_SCU(obj);=0A=
 =0A=
     a->ssp_cpuid =3D -1;=0A=
+    a->tsp_cpuid =3D -1;=0A=
 =0A=
     object_property_add_link(obj, "ssp-remap0", TYPE_MEMORY_REGION,=0A=
                              (Object **)&a->ssp_remap[0],=0A=
@@ -959,6 +960,9 @@ static void aspeed_2700_scu_instance_init(Object *obj)=
=0A=
     object_property_add_link(obj, "ssp-remap1", TYPE_MEMORY_REGION,=0A=
                              (Object **)&a->ssp_remap[1],=0A=
                              object_property_allow_set_link, 0);=0A=
+    object_property_add_link(obj, "tsp-remap", TYPE_MEMORY_REGION,=0A=
+                             (Object **)&a->tsp_remap,=0A=
+                             object_property_allow_set_link, 0);=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
-- =0A=
2.53.0=0A=

