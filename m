Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9989C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKp9-00019B-58; Wed, 26 Feb 2025 12:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKp7-000190-Ir
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:53 -0500
Received: from mail-vi1eur05on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:2613::71e]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKp5-0005r6-Ly
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijiZRGtqShKOuW60rsttTnzY0aoRspcpA2JiUPjBdtiR8wYaOQk+sD2XCOdh1nv7CftMR9vUx/HGvK2aYvaYp1K5ip0VwlSBufkb5fJS4/9yDm2CnD3wPJCQovb73tDD7tF16zXid1HMbIvJH/Ci/+D5CR3FlW2PiMVNuTZzbYfclAEzC6KV5Z4CPLMVkPlTi1VnVwcfMVKyBBRfwhqxf5Sa2JFB8WbOOSKD9I/x4QtzScR73N7RmryPf1Qt2BNt7cf0Rwjm7b4AOfcUHj//Pf5wEuNLsHMHO/7Eal7RkP1wOJmtCTv+Ul7lHk7ujMD4nGqIlAljMzfx6OEmy33taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h+HLz8wLJ75mUnulh9yDjdvRrCuCzXbJlCtqWuCWkE=;
 b=R010A2fpaH/tcYnHvaNyrn6MNMH7f47Z3j8ItayUtmnzQTaKXfaGAqevR0YXeYS+YCJpckIcYUrzPIMVVaFLKQPT6nqyij3XiEPSq5Wy1VdVo2nZC7G/64hw1huy1J2PveoQF7YPE0wRpOLAov5MovSe7BIxTdV+G2uLKHccmog1zf7UJVVl0oV4VTtbxcwp5hlrlXBR+D25FdxhwY2wKHTFYrBhuymA2JCSeCB3l6GW8l4IQud2LbtFJqmjZSfwUuCNrBKqS1Q6MpD0GwbxKHIEaNudW42ro38rwAPhPkHWZhrfvPsy3gPEQOREBBIGj/eP1Okzunn3y127L7vyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h+HLz8wLJ75mUnulh9yDjdvRrCuCzXbJlCtqWuCWkE=;
 b=P4xh7ayDdfEPA4HK6F04nC0nI53qrYyqzRDxZwX5dJ8RXoT513gOQyzWWjoqli87YUA5RAMGx8Eiwa0ksbMFewhnsTDhqSKZiGYbYqnLNk8wm2BchyK8W3IKiJMpKXcg2gUCaOK7NGnuNKl8kazsPKn/m1h2Q0B0ByThr0LpOb0YJzk3GJm3DpRdD/266MTNjT5/yXcsZAJ0/YMm9qoq/3InVvRZWgh3cdL3/fn89EpQP1hx630AcMnd3Cu06FsF/dRT9NKHSXfNl5xPB07eYdiNkeuyCIbtWAJ9Qck8QOPEmhNXyhsfdJ/Hwg91BJY4n/rmbvVuYjrc9l4MRlKt+w==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB7419.eurprd09.prod.outlook.com (2603:10a6:800:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 17:03:06 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:03:06 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Subject: [PATCH v5 3/3] target/mips: Enable MSA ASE using a CLI flag
Thread-Topic: [PATCH v5 3/3] target/mips: Enable MSA ASE using a CLI flag
Thread-Index: AQHbiHBNzxuHyrc9PkKO/dg/LHJ9ew==
Date: Wed, 26 Feb 2025 17:03:05 +0000
Message-ID: <20250226170246.1971355-5-aleksandar.rakic@htecgroup.com>
References: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB7419:EE_
x-ms-office365-filtering-correlation-id: d917e12e-2e6f-4a24-b785-08dd56877042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cUUd4a+kNyK1v7fR3F2cbfLyIFqZT/s85Ogd4E6oSxZGwlAAyfUFg2oGjm?=
 =?iso-8859-1?Q?ZJHPzk+c9H5J8NaM7OUFpn9Iaz3azKc3yXWuGEuOliblZulJAna+vUeoAx?=
 =?iso-8859-1?Q?nDdO9YhPKcFSEVwpbNP4qEzGJFIh4GEygjEpcGFdQQC9odSqbQp5sudhrh?=
 =?iso-8859-1?Q?MUVgNABxzAU9TedxLkjWYRTnh/mQKlMCJ1m0DAmM91468Wef6OJIhLqsqX?=
 =?iso-8859-1?Q?8SL/gufrERMnTsJuRbkdwh5RWLGC86Dqz695b0okKZRGpFNulYtR3ADApz?=
 =?iso-8859-1?Q?cMPWYx+q2XqDK0CcE2qAj5sYTf97swHclIO9P35Hf31wNbvPSa8/JpOAUj?=
 =?iso-8859-1?Q?pbLxfyl8RUBonSUePSnyY9t3HdSyoV++WZct0b6gOlJ0Fqj3Dd2SoYDp+c?=
 =?iso-8859-1?Q?JSUb8Ic01+raljMlr6/BKV9OlE9BmOarpLOOhXRD/nAv1DyEGXwh5dcQ4F?=
 =?iso-8859-1?Q?eB7paC/5vDPLXSacsEwjCXSfWtifvCaF8V2UhtRksrI/m4mUtFNSlHvAac?=
 =?iso-8859-1?Q?vuzxVD3M/zcDHV7ccDXD3DY4+ScpT54svKNUu31IKWEZ4DTZCWab5oHkmz?=
 =?iso-8859-1?Q?N6wIPtBtv0pfGwprv5hU8RGuBkMcx9ScLS8+wVyx8QOT3tf+iVZvvAtC8o?=
 =?iso-8859-1?Q?qfXX5de6CyKAwyVXejNhd+e0hbZpw/nbzrsk9wozo03zj+XEfkkZgdfAKh?=
 =?iso-8859-1?Q?KvFZEONVAK+IjbJQIh4BMw0UzPzFpEtjeuFfp1CsttB+1eHuQBjrgMP+AG?=
 =?iso-8859-1?Q?FrnPnzZjG+tlx7ShfIqce0NaX4VdXUTWAv9KtUAnNBfHIF8avfMy6Q1X3b?=
 =?iso-8859-1?Q?LfoPVL+do7Z9/Ssof4sd4Ww+gPV1l27qOI9FK1zz/o278e4ZX6fQe1sAbM?=
 =?iso-8859-1?Q?mLt2aBQtzSabCB6JrTJAeMHUfaaKJkuQju0EkqOliYlOErhuai6z4LaQyp?=
 =?iso-8859-1?Q?DUt8egxB/Gy9Yda2sNKR3ttLMGQdCMgs4qOkKr8UCmeWAq93Tbpu05rlIR?=
 =?iso-8859-1?Q?ZEpyzGdpqn20pIwJNYp1LnriaIiXNiaMOxp5hVsc3xWLFWgocZYz5N9kA3?=
 =?iso-8859-1?Q?ST6eJfXC1aOxN9cS9eZ36e+p0JObb57Wn/lFCnnKHF3vepkdiu1aFcEcXu?=
 =?iso-8859-1?Q?NP266OLA7t35YNPOKdE+FM0oyR766iOw//KdShboY7uMR9dcA/Y7styLMn?=
 =?iso-8859-1?Q?sgJk8wmi9R7fVOLtiPJ6OvBRAlsa+kSdxVboCXS2ZUTq5ShjIlasa3ekGs?=
 =?iso-8859-1?Q?HDQKUrve6j/0oiBXMHPPKcDIIwxBv0Uu6+bEejnmb4vKMsUUw2hp5R52uR?=
 =?iso-8859-1?Q?YCUqFkCL6NZGhGR6fKpB5PsejUWH/ugavUPNmn4Ig0v5xXhsI5t9CpPD9P?=
 =?iso-8859-1?Q?kPPVWMiWrCCZzLpixr30kFwErXGS9Kc1VbIHq+EoGjleUWgliXkzBgBtgW?=
 =?iso-8859-1?Q?4/8GMqlvqXgMKmlsIc75KxQX1GvtCAEveY18ywxOYw4ZaDhgS1GVvjP8pz?=
 =?iso-8859-1?Q?0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SgUp5jtHXDfZmjzkjk3i9XHDAHGtCUn6TdKzGYM/wc0+7zUnILFMw2u8nD?=
 =?iso-8859-1?Q?bRiEt8ReAEYfXYAifN0hpySo39XsZfAVSB1WMPfjjFv+JZsdVYEVIe2+Fj?=
 =?iso-8859-1?Q?kDsmAehyJpDXhIERTJeSlUDddYScQijnJnBTyEEeSwKv24V60gZWsvtSA7?=
 =?iso-8859-1?Q?dE7wD4S7RE91NRtRP8kW56rKOUwzEieJXHGyp0v77wBVjKBD+iNO/ggEbn?=
 =?iso-8859-1?Q?nNrforF3lU74HbXc6hzg/zPIv7rat0msF5epcKuNJ9YR/xcLKklnjdNaSd?=
 =?iso-8859-1?Q?dqU5BPr0i72FIng+jcgsQOseeGp+x6HwjE4FlVTk/7/gibTFVBBe699/fa?=
 =?iso-8859-1?Q?xRbNUEo6Ntj4RVG57YTh+Oz1/9d25d8lBXzxd5cdI/UR/xn7ioENuOvU1h?=
 =?iso-8859-1?Q?DMBZDxAZHA1I0KYn/gwIPvtAWQEWU3aj+PPikhMv7V4rpO6sc8VLmUbvxr?=
 =?iso-8859-1?Q?lTmFrUFKBIJE6RtXzJOWFNuRHRbPH3nGT+79D5pONxaZkPvaoeUNWjl26j?=
 =?iso-8859-1?Q?kTq1wDiTSrazYPxeSJeHHjVaoGDf3XHHHt76lBSxncm52Qd8P78cXGQdVz?=
 =?iso-8859-1?Q?mclFmgPM+PN+VC1SHYtj4L8s7g8szQ9Fs19WiBj+yF62UQmE+pFcjraIJH?=
 =?iso-8859-1?Q?V1xEU/+Is0mNX66kd4upPkmGdGWVazdj992BeB5v4OsUtgdGVD8amLzKNg?=
 =?iso-8859-1?Q?+iQvGSdQXz+D9bRTC3pVR5bk53V7bwqxeHetn03d1vcgnPR9KPG7PDSNl1?=
 =?iso-8859-1?Q?VwnbwoDQSS2brbSJm63h1iEfvPOE0vZt14NCBokFHfdZTi62qlCUrv6iSZ?=
 =?iso-8859-1?Q?J3R8sODkZCCeGdSnfDhwEdGnwKPgz0uDAAnTP+CEmi9Z1vePl2dN/TAgRU?=
 =?iso-8859-1?Q?HG6jwAGSGF9PISc4OlyWmmhaOPVEP0lyZwgFUh4NmPAEyzOCu11IyVgYEO?=
 =?iso-8859-1?Q?95t6xAZGqu0kyvgvMd6FbjHBXcQbei4xfzgLD2vwjqCKJVYBLrXCsqE9Eh?=
 =?iso-8859-1?Q?lFihokWTRH8Ou/O06MNuufj6qW2gEKzJ5nOU8Mm3WyeZyELcRtLivWxOzU?=
 =?iso-8859-1?Q?p2tPcfaGk+IwrPuI6+pjUUy6gpwXxMo7kYe7dbsk/t+ulsRPV57PxSX1bh?=
 =?iso-8859-1?Q?vMFYqRLfu2zwV90zNKR4yLmwS+7kVJ0FrNnHaJ1v7LvJbbNh5ujq3iD1ET?=
 =?iso-8859-1?Q?JqKjVHkbuTdUkDg4a+GZA8njfgbiS3H6lWG+FaFIM4shahpmERoQ9TVUki?=
 =?iso-8859-1?Q?R2rMhapcFzisCmOwjldgUbviXykEewOZcibQS0NkUS4RW87K1tqehY1Nbk?=
 =?iso-8859-1?Q?0uBVC1kYnJ9vb6eS1sjgWMfeY3GLLOnIwoVqs5nsrepNZ7Wh84a2QrdWbM?=
 =?iso-8859-1?Q?RRdRnobRqE/bxnbz8Kh/YoIJ8o3FH7SjYYGCpdJI4c6A1mZUU/OAAhDfDM?=
 =?iso-8859-1?Q?TYcBJck0GAiviONCSjgfv84lFVcSEGmPVbS92uR0SSrpEpOX/zqwLOqKKx?=
 =?iso-8859-1?Q?vP/fuEbScyvScQwpEenUjBV9RLmWL8/k4h+Pk/2iuSawo5D33PMcLHK8tb?=
 =?iso-8859-1?Q?S+iyf9ylEyZrKI4axoO9JbZ3KAlWaC6ZZY/ygmz7/WK+ofXxNalPE/+L2y?=
 =?iso-8859-1?Q?W3HnAml5j5GkVPwyTqaFiyVSdmrlop+tu24EDm4CjQ6M4fbGFtumm0QKbJ?=
 =?iso-8859-1?Q?0uj7/75/1FrzaX9EE0M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d917e12e-2e6f-4a24-b785-08dd56877042
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:03:06.0144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0bEzg364muOG/C6gcqDmC06uFsEZ7SuR3+Lu08e78kwRqeFeQkBS01JEwXASsQrDrTieMkhlbaAt1a9SZtcs3dNGEy/7mnsYgrvMa+dW/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7419
Received-SPF: pass client-ip=2a01:111:f403:2613::71e;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Enable MSA ASE using a CLI flag -cpu <cpu>,msa=3Don.

Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 target/mips/cpu.c      | 16 ++++++++++++++++
 target/mips/cpu.h      |  1 +
 target/mips/internal.h |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c..8e12d303de 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -494,8 +494,24 @@ static void mips_cpu_realizefn(DeviceState *dev, Error=
 **errp)
     mcc->parent_realize(dev, errp);
 }
=20
+static bool mips_get_msa_on(Object *obj, Error **errp)
+{
+    MIPSCPU *cpu =3D MIPS_CPU(obj);
+    CPUMIPSState *env =3D &cpu->env;
+    return env->msa_on;
+}
+
+static void mips_set_msa_on(Object *obj, bool value, Error **errp)
+{
+    MIPSCPU *cpu =3D MIPS_CPU(obj);
+    CPUMIPSState *env =3D &cpu->env;
+    env->msa_on =3D value;
+}
+
 static void mips_cpu_initfn(Object *obj)
 {
+    object_property_add_bool(obj, "msa", mips_get_msa_on, mips_set_msa_on)=
;
+    object_property_set_bool(obj, "msa", false, NULL);
     MIPSCPU *cpu =3D MIPS_CPU(obj);
     CPUMIPSState *env =3D &cpu->env;
     MIPSCPUClass *mcc =3D MIPS_CPU_GET_CLASS(obj);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b..3e636535c6 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1191,6 +1191,7 @@ typedef struct CPUArchState {
     QEMUTimer *timer; /* Internal timer */
     Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
+    bool msa_on; /* Enable MSA using a CLI flag -cpu ...,msa=3Don/off */
 } CPUMIPSState;
=20
 /**
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c786cff8..bbe2acffe2 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -399,7 +399,7 @@ static inline void compute_hflags(CPUMIPSState *env)
         }
     }
     if (ase_msa_available(env)) {
-        if (env->CP0_Config5 & (1 << CP0C5_MSAEn)) {
+        if ((env->CP0_Config5 & (1 << CP0C5_MSAEn)) || (env->msa_on)) {
             env->hflags |=3D MIPS_HFLAG_MSA;
         }
     }
--=20
2.34.1

