Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7ECC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHVn-0002r3-Jk; Thu, 03 Jul 2025 06:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVl-0002p9-5g; Thu, 03 Jul 2025 06:49:49 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVg-00077s-14; Thu, 03 Jul 2025 06:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzXDhn74/juFayYAcMwkqy4ZuDvnFjKaHIwVTD5dVW4fdVxcWExINqXjJxT04Hj/qm9fxUCjv7I+90FE8oo8ZtchDzVhTydDrLUsXw8Xgb1CWRkYGl2PnlI6BLfBVzF84WvwQ0Ql7cCGWO/KzOn9q13TuupGj5SUTJHlBLZm7gz4ZKx5ay/qKMZghAjbduZN//sS1DpW5D0as/ZiZH8XSNv4/1bDrNff4hdw4cc+THX4p/zxeZGHadNXHg4giE1wKHPVxW1De8HeCG67/as0azXz3wxpQbBrdbIz8XC9IqQugpUafJbb4orjRxQxWwetqiWVODs4+fgIa1P/CLqHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApR78qFgYI+bWgSptj1QK6xumy14qDSsrPVCZeLuV7U=;
 b=NWXSNIatqJCNcZL4kXX+1bpe1pqbOqr6iPxAjiUKC/6qxO00LORb75+UTRnouzergPPXvfUB4xvGqMmvTEcGXDwizzi4XDMXjZOeOTR1Vr/TZDZgovXDxsyEoOtreLOlicMpZJvO41kgHepUbe4nwbFKqMO7TkvPggc9Of2Pt3vX+IUT5mzteIvsedYO7qFWzmZqEFPS2rgcM9tJkFpvGDz1BI9zQ6MtPu9a6zvJMEQnC7Ec9hiNhjK6NIP3i9wziI0ZgExsaIbOV039ld0TzFSBVPDmBHptd0JuZLayZ8f/4dVhSi0HZrChuFBwcgjLf8X/ETrLOUBl73SBZ6FL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApR78qFgYI+bWgSptj1QK6xumy14qDSsrPVCZeLuV7U=;
 b=K0jJKWCXKi7995leDvc/o6NBh/90P/+j8bYAUAJxgV+kAlXRzW2gwi2CqhuuGaTCiDwFF4ycyg5MkTnCfpcie42K4NIIy+LcTVuUiOOOgRAcp5HkLLIQ8BVeW0sdFESVYDnf1h1Qym6p05nKMJ9cGBom5B4RoiMuJORxjkGHDqS0G39HZE7ghwde6QNxbalm8Do6gS4Scxrg9qlQM2pahZ9PEvZTM6/6hFltaedEHQbMzehjUrK3ZAvLkYfP0dxDuKTaL1AM7m8TKn0N9Vz1edz6iB+qJXMzOxGZnqArsVcz+SuTT4FxXE6/Wn8My6PQ3C0h/qBU1diRpxEQbK8fcQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI2PR09MB7288.eurprd09.prod.outlook.com (2603:10a6:800:223::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:49:31 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 01/11] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v5 01/11] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb7AgoQ8XqXEgGNkup2b3SH0IhcA==
Date: Thu, 3 Jul 2025 10:49:31 +0000
Message-ID: <20250703104925.112688-2-djordje.todorovic@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI2PR09MB7288:EE_
x-ms-office365-filtering-correlation-id: 68ead41c-9779-48ba-7039-08ddba1f4ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IO4+h/b/1urtwhf1Qy4aL/IMCAMrqr5y1NoZLsKY9J8t4N0No15gO007ON?=
 =?iso-8859-1?Q?P6zP1UjVH0JPJsmOnKdcBSUx7mY+ARdb/1JFsbEYNnHzDgg/+OfpVzf9vq?=
 =?iso-8859-1?Q?bLUqrrSJi5y0bLCkEpFdMRX8NUH7Gft1m1/oa2MBe9PChYgOcPS+a0GESi?=
 =?iso-8859-1?Q?VahgTxJWsDBRPdlejpvfIyA6EtgQ5H8uaLFxTlvdMZJvTKzYwpchGqJ4cR?=
 =?iso-8859-1?Q?KBgxIVFfERgHmxL01DP8oZttAAoYx5KYEosalxsMLN2R7QIPFIh4GOBmwj?=
 =?iso-8859-1?Q?3Ip4TroWAVbwWfXKofED9HxufydxCO/izioXfRLyssdfAE6NBrOvtQP9OP?=
 =?iso-8859-1?Q?nkHBgD/aXDLvIEJfzua5Gj3dkiiV/SrczrD4+CkDO1szjm1xxCSfDz6zD8?=
 =?iso-8859-1?Q?pEkP4Cw3XbxSE3sk/d6L51HOnv2/DNO07zg1JodSwthpmH4ofC0wq7OjNt?=
 =?iso-8859-1?Q?2ttaWlEvjZKDpFLH+6VUVM1nb46o0B/5GeUAAUnAjF2kGdiVrFtMx18iaB?=
 =?iso-8859-1?Q?+zO3SukPQS0O7RLXAou0v1HhDI3PGx09Mm73IyX7AQq0SzV4n/midQ785a?=
 =?iso-8859-1?Q?C1r6bijIqnQ4Qc8WnHh5JeVQaXQCYhMEyeDQ9CqaTKVYN4V81t1zf8vvNk?=
 =?iso-8859-1?Q?wD5Rf6MVXfqVlUbpk6+N1w9A3/hCXIWdBsmnPDcHEf44JxMttaovPErAnJ?=
 =?iso-8859-1?Q?5Nep53SBrncWJAnbihO6ehDbpZYZkQL0Fj/DdMr70hoMvjgpgFd3t6tdFw?=
 =?iso-8859-1?Q?2TN5ID3DYH5A8cq4AwAYzW3ImpkrtrCDuNb4uFYNx8iVVdWPUz86o4arY3?=
 =?iso-8859-1?Q?ZLDSuCmw06t5HV8f3gaw6S/BVrSO279FBnDB7ZDkm1B9CnsI0v8L9PzAvA?=
 =?iso-8859-1?Q?Z7e3mv8b667e37I7zHvEy78B8ZJmhLtL0ouBE5PuoZXCyEsaGwrB0/PIuu?=
 =?iso-8859-1?Q?+p8toGOGySnUqnQLjxH8Ldc1JRHnvcl1Mqo0K0FNdgOQF226iS6hP/XVFd?=
 =?iso-8859-1?Q?QkiJZhVLIYK2EQ1yFO4IjliP4to3k+JkUEgair7iSHtm18pQoeAcVO38RX?=
 =?iso-8859-1?Q?Q7hzz6arttw1Eb4QXAGL1iRuMKNNa7epqZ/r2dqQurhvmV2GWsyCOjxxQj?=
 =?iso-8859-1?Q?ePR4vtyGTSRmZw1s1JyPbar6++4ClWdERavypsIW0jsg/VMQMeiKOkJTyn?=
 =?iso-8859-1?Q?OiUnkMbYMfwncimgLD8Q0CR055DdQwmCIF2uHv6UNHyvIDN1xKqulMJueq?=
 =?iso-8859-1?Q?7594/QauCerIqd76zucQ6x18oLzHN8saMoyckFNn8p43x+mqdhgknt8wBP?=
 =?iso-8859-1?Q?vYXY419e2AYAzJCqmIAVUV3TnXIzKAjS1B3Nuzhs2WVkS16nAMRJEy8Hei?=
 =?iso-8859-1?Q?ZlIl9b4lZ6nJrwiDTwkHV6pOA/omyn7SeYgj2n+aV/bupoel6DotbWO/Vm?=
 =?iso-8859-1?Q?wO4ylaKXGsccL7ROCVYwmZiQWIylGABYRRIl0iKxmGVLxUSKdsqqxWgs9r?=
 =?iso-8859-1?Q?g5+jwo/fEYnbqtmL2cBCK2odcQO3gvjbZ192ZvxC+A3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g5OwTRphBu+O7VTovafCg4HTPmEKqmZmQdXLdeF6T9tHS07h8DifGzS+kD?=
 =?iso-8859-1?Q?0eGF09e48D1KHBE6FBvLa+JEUkkuv772tA76MgxxBYwqDjp+MLxt5AUXxQ?=
 =?iso-8859-1?Q?mU3xPi7PFt7Nf/B22i5U9QQdMwBvG6113GLIgGt2cyKUUse+gdxQcF/pXM?=
 =?iso-8859-1?Q?Fv2x6Lw0evzn0CxZYQzIwPpdQ1q9VHVwGDusSW+AOoDgXW6jA1zsJc0Qdj?=
 =?iso-8859-1?Q?YR2hu7q1yx/KLK2/whCrZ3PvjoGB+qHKLdfKva7DSqdDePxPKhNOH8npTf?=
 =?iso-8859-1?Q?EzmPwzEwz3YSvDlTkziqmbxmhXKK8Jqc+gxwVd2+w7zhyheTdpEqF9ljBA?=
 =?iso-8859-1?Q?Ny5M3Fw5nLFnDBMI4O6sOzRrbra7/xDBcjgyrkmYkEM8MzuphjPugCMMaU?=
 =?iso-8859-1?Q?blV611e022C027BvX2Kka/TwQ39oe2qqbodnZWOqnzkQp7M2IP2sLj+VZe?=
 =?iso-8859-1?Q?pqTLHuOPOBTLaE9Y+/9PgWuyHQmLQjfPwExXIWRKrCQ2GycFCbsHd0/162?=
 =?iso-8859-1?Q?9W4f1XWsfm8G5ngshNAUC3Os5+paNayrey9Ck3fFozf+fiuYfSMC5CnIv/?=
 =?iso-8859-1?Q?YRiorMhLwicqWXp1/iBghYpiZv5qVxfQeL/Or4q7L/ME/LlKdxA9iR6wVL?=
 =?iso-8859-1?Q?7CJMeXBvsITRuFigQNwQfUhr63FcdZf2swdHmBQSbxGEnMBG0dwCVgI2wx?=
 =?iso-8859-1?Q?Ais36uyfo0z25cB0LzX8cRIQ67wpxAVUH504/krxS2oVOwwt9R+DClf0lp?=
 =?iso-8859-1?Q?IB87cNH43ADYnHbnKqT1Jw8josRScHYvNMk10ykJe97gwQBRYIb4m9IqxY?=
 =?iso-8859-1?Q?YvVgMq4UCOxbKlTxRhFVtfviZXKUbrQpRnIhW2wTGACTHUZjJ8TzWVFc6F?=
 =?iso-8859-1?Q?upVj/xO11sTaR622WvffhYwaUU72ENO01Y8PLlNm7hQ0QwDjZ2S0ZaP3RP?=
 =?iso-8859-1?Q?VDYXDVINApyfJJms1dubUk+dygPbmc1rP1BCrinQxMDdCudPYYAb1ugFnM?=
 =?iso-8859-1?Q?516t1S4HqF2C4UX+qrnkHKvtfBZK5w+mW3+r2pyThw+suaPQD6WgiQc/lg?=
 =?iso-8859-1?Q?egecTNFMq7cEoM/KDu90P8hYMBL40TAosqhBNz8OpS46clOYvK8FiDMjFc?=
 =?iso-8859-1?Q?z0l21Dk/Q3d2mPy81dR280Y3Um7BZCCbqulq7oAw03EF2KWqoo1A8habow?=
 =?iso-8859-1?Q?JxP6dlBsdYJf+GqLW1vgzGQ2rA7lL+PEAYlx8BH+DOagZyI3D+B71nijDh?=
 =?iso-8859-1?Q?u3Bb3Kv+Sq/ZgAZzerDCjbTVF9/Tcfgz5K2dT+V7QyahyLKelTJwzwuw/R?=
 =?iso-8859-1?Q?CcNhaJMe+4WIoT/WRhebrY2gpePBRJ/nUI3JnWARu/LQSNc8b/p2mHWvzs?=
 =?iso-8859-1?Q?df1PHtPt0AyCDBuz2+dhvTShnWdws8BOsTQ7Z8n/fGnLps/Vk1YjqTAdnG?=
 =?iso-8859-1?Q?XCbE/k80cysjNQVUi6OwnocknagJPlbJvNq3mG4G48mbWpjyt5m0upgLWb?=
 =?iso-8859-1?Q?+UZ3/sHZ2yvrtgN/xR0/uCCCV6zEwFC087dUz1aOoLwXoSh1mxD7+NzRp4?=
 =?iso-8859-1?Q?mYMRSDxXDnPPcaWQYWylRRSksO+BpSDUP2bMdqv5rYfNFOezHmU/GqT1UO?=
 =?iso-8859-1?Q?Os8G5xXRqEonHDyiUtI4t88pXrkCHvSHnDKUYbkPA8GUVMix7c2+sxmvdD?=
 =?iso-8859-1?Q?MTN6Tgb5T/14hw+D6CU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ead41c-9779-48ba-7039-08ddba1f4ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:31.3803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMnLsQkX3JVHzIfFHn45tpPPZ6mCvr3Ox2FTIVVb6OqnGLXNknrJfeKoYIiJ2lkGIJm8PUG0UaDTZuzLiYJnUWPI7m3D3KgMWwtHXFDxiao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7288
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
 hw/intc/riscv_aplic.c  | 10 +++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b0139f03f5..22ac4133d5 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -292,7 +292,13 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid hartid:=
 %u",
+                          s->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -481,7 +487,13 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          swi->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -545,6 +557,11 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          hartid_base + i);
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..360a3dc117 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1076,6 +1078,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
ize,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL)
+                    continue;
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

