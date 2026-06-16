Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10961CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZu8-0000nS-By; Tue, 16 Jun 2026 15:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wZWUG-0003BH-Hz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:18:04 -0400
Received: from mail-francesouthazon11021115.outbound.protection.outlook.com
 ([40.107.130.115] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wZWUE-0002Li-1s
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:18:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7hsoZ/bD5xj3lj+SVYW5uO+6y+9Y27PO5gyLQZREOL8ieC6xgbu1A3vEtoiJvzOcYwQ9D7HlA4H7aJDf1p4zxn8xayUdfLJf75eRzCcdEsdxbu+/wka10IIbnn/HJaQeTfBOxiNgZN9lFZbOh2jobuZBBCk2f01K86iOgvbwwNq3jVfOpkot8sRj6zeGpOYuVp+IsmA9qWWnY9yxHrFP8dHr+sv2MBAaqWMnARBS/Su+OjDw8Y3lLcpQZJ6JhfLedIBl9OUGDk60u3f0sJwgjw2RH6Iau4CLDqMIUSGi+Qcmk/cYZqTSmyM5hMXj5UA3fuag2e5pe0uVAD+4FdEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1bsp/0fk723y6tLnw7LMEGIvWO251gjEWdvIhRCZAE=;
 b=dcZ0LMbOO+QzgcO05bObY8p2KVmdLq2WzuqMtPtcnhK4HxgsLeMQOt6JrilROHst7I8qazF40KmpbA3ChnVspRXw7gr+GT7POcUVenahZVxQ8OJNy6AHOcGvHfwPShJA7GfyE3PrEJ6gmIa9/YIduIDF+psyIYUtt7KIpg73DTq+h2Ot5reBp823UBv051bbRA6/cGYZ1VXTR1lDg90f5zFDpqs80/uI9/mpmul6MBaQThReOKZICGtAj3X7Wixhm6UsqkT1Wu++inIYc/gc5+C3sebYyuIqTFBV6/aurRtp8lsHeuD8vs7RcLrCBU+0lFwPWY4Ky5ZBcOECnZiNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1bsp/0fk723y6tLnw7LMEGIvWO251gjEWdvIhRCZAE=;
 b=uL+BExHix+3LAR41NiSetflwBfW1OfqYlRw391+VplmvB0CWkohpKXR+SxV+uZrwTXISJizhGlxfYS5IeVE+ap40jrkAGk0VU9dZvxbt2P9sRwytgKL54SeLlyLyB5vEPM+/tghQuiBVbypveyENHCORdoqJPjHPUWEiMXvl8e58h5VAjrmdmj96jFA69KnHDsoGYzZIZI37L8htuVdVduEbFld85OmZCYXrnasfvsCtC6dLb2Af82RE8to6hKYOU6VsfPpnNOezo7laLPcGMbhPrlxq0rxDDqWwULEEn8ZfxZ3RNh31f3P6hJ2hVlpalbir6AiYOMmiIc6QBxhOVg==
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:328::6)
 by AM4P192MB3297.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:6ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:12:55 +0000
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64]) by GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64%6]) with mapi id 15.21.0113.014; Tue, 16 Jun 2026
 16:12:55 +0000
From: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>, Harry van Haaren | OPENCHIP
 <harry.vanhaaren@openchip.com>
Subject: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
Thread-Topic: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
Thread-Index: AQHc/ar9YJqHiU/Xe0mIuMVmAWI+gQ==
Date: Tue, 16 Jun 2026 16:12:55 +0000
Message-ID: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P192MB3464:EE_|AM4P192MB3297:EE_
x-ms-office365-filtering-correlation-id: e8dc295b-f2cc-4eed-395f-08decbc22023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|18002099003|3023799007|6133799003|38070700021;
x-microsoft-antispam-message-info: xH9g8tmZl1uBnRJDOm7ZqgP3ovoWRZzsW1EUlAJCjXcwPfdjjVGRutzaKSWmZS/wIBUUP4Mm/fDtZwyRwg/hxv/bqObLmmCVv6rPAhcuxc/wCmCs2Pdiz/icXxTqAfqIW37OE4vmH8H15m9mlAgLVQZ2gYEQHM5SDrCizedsxVlvqGlObjrCC8xfRHCrlpCmi7nBzrbCN+zlN8Le3gnJgtol1Tj7R7wU+0/YjSKcg6tUmYz/ZjNWZww3esQG2aGTDnZwiAHtXZIoFtFhYoscqT5XjaS+O44x0UMHeLnlny3trFGUXJBTODRcAPbhFi9ohOBL2dpg7t6JarS1JpFIdZel12exAxraoxakIV7U8TK3tUMOJg8XVM0KO3t9W9FYnXDbpI1F4vAe99TZlWy0GBBd8oAJHmkpOHGCdvNSOf1oKbFzRNOT2WvQ8fQWi9KDXOJFfHKIl2v7EMAAgaZsOHB/ol6qmXh6OP7oHgtVpgIcD+NleyqHKn0avcR/yu80JjidbW6045whlnxZnF1LUxa9Is9ro48i6QK+USHub1M83Q7QE0hgVtUAztvKwBb5+ORcg+8BK8SE2v6D/76um3uPVIzatmcDRei6TJM9mo2pCDGFEf1JPcd1sYjga3wpdsto39b3DhvogMy3WlBvRYUBRiPEoW7ccnObgAzIvO36Ikg3CxjNC+xJDjRvzBV71603NwW/C4LcDtJPAd5hjAIj79xHFEMPajUZ6FZcNmhr20+XCagdvWqi/deu4Ilg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P192MB3464.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(3023799007)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HMaTioUXtCWg1F0vaPvGpEkfH2ALxP/Ie8NUTYGBdKN12TAFmdlKwNreT9?=
 =?iso-8859-1?Q?7u4pmIXJ4dk0b2PtMfRFoyKecqm7vaMerRF5Gqn2cm+9xfotrmY4A6/hOZ?=
 =?iso-8859-1?Q?ewcltXOLFPxC5nU+KxLYVQDxRPG+zT6I4WxXrSlg3Dc6tBR6eCkdQVCfeD?=
 =?iso-8859-1?Q?lDkJV2YD4fHKsw4WqxUQ3XPgopvLn9rMkpZZOEtgpVn+Jmcv2YFTC4YjCf?=
 =?iso-8859-1?Q?iCKnma8jhlMACwkRBF94cgGacimA3mGz7Hyi3pnQA9zypGZh5c3f5AUq6z?=
 =?iso-8859-1?Q?rWEwT1DKccxOZSjXCiAstIvqg/1q11XIuCQ3pnJXYJSN02KQcWivAz/Ynf?=
 =?iso-8859-1?Q?mD8ofLLCdWeAHDEZP5NcyVPTmMOPEWw26wfoTagdiEPgN/jrNzcrKHhJLE?=
 =?iso-8859-1?Q?rpsY7ohXdqpZBQ9obIU4qOqyq3LURe8j8EcOF8mzXlq8nGZg8ikJ6ALoo1?=
 =?iso-8859-1?Q?JWHVq58q3ZszSmlzO2temZAJXXSgtpNLM6WQAeyin0OiJlUFGoGKWzXTsu?=
 =?iso-8859-1?Q?yJ07q0VVTusQt83OwwjiaN9AtcTHhfV7ffJmalFaCKGGP6k1iG2e0U4QKb?=
 =?iso-8859-1?Q?Uv0qDiydt3b+rBPT+zIkxaJEW+LWjyEkYTKSEqwJRRB1LkLnFhLb/1+ouM?=
 =?iso-8859-1?Q?89mhdnuLMYcpsUcw8LnQr9SiHqFb9WTM2OWOQ+9yQse3apLykoS5od5UZY?=
 =?iso-8859-1?Q?QL+yb3b4FE1p42znmajy1laZ5CuBboE6AcLaLMwLvyCX8+yZHdIKm1Ack8?=
 =?iso-8859-1?Q?/eu1WquTq/SA6cdz/oOcPwiGHMy1zvGRYUhOnbQ6P7N32eiKqVwwVHQYbY?=
 =?iso-8859-1?Q?8CGhP+VuEA4zTsobskaHy9kktdB0NEHev9yb202sm0zBglCSXr/bceTKuL?=
 =?iso-8859-1?Q?bnFe9MH+1blU95IaULuiUTDIVIrMXIU8ojk5CHJguvMXw9JLEso3kbxM2W?=
 =?iso-8859-1?Q?drjcXpu8M0GhMBVCdvuBWzdnSpfrXjp1Kker/XL7l4XuxVhTHW0WdiFLkJ?=
 =?iso-8859-1?Q?yxyZdAAxl9qAS6maAFfDxQNk4A4Qe19eOCCod/JAf+78WX9Bi4bUwbtGAq?=
 =?iso-8859-1?Q?+3QQlKUX96tfcIwkStRXpmGbvqKsiZDngwAz5jkxezkgjVvIJWoozPoPhX?=
 =?iso-8859-1?Q?J+XTZgMrN1xsktSYcF1lPZPr2/D3lZpVQB8d3KPPAj0EnsLIAD4u3YJFKW?=
 =?iso-8859-1?Q?tWEWP2Ux/30Ywt7Z93YRIlSswUxsqgpElfc5sfkGUDfLQVjkvscGqS0Lop?=
 =?iso-8859-1?Q?visw6ZRp6vVD6s0s2kcI9SBW2+isLhKV2O/T3GlZCNaOYSMp/vK06SS8Xc?=
 =?iso-8859-1?Q?Nt1r+WXKHGIDQZbYwu/34CwVtgGksXWyVa3NBMa1QRD1na3KoswBPoyfFc?=
 =?iso-8859-1?Q?qsSbe/WUFx8LYj9TBEbJYItSjLqyCXvgM5HDC7UC+vHEUK2epMZ6GAEfvr?=
 =?iso-8859-1?Q?wpbB1bqGW1+kRxeqQP8qGUUeYxAH8Dp3knra1dsYcB6W1NMOzl9BK9endg?=
 =?iso-8859-1?Q?GuMRIRlzJt73QfZiZIGeT4xHe8U+7y2UWKtw4QEoWVweNGWXvYeBZ5KvfG?=
 =?iso-8859-1?Q?xYMexvTboptCEjPwUuD2CBCJZxlWW9opIdODYzxweK67wZ9Ducz/4YDYBx?=
 =?iso-8859-1?Q?cjsDwVgYgBdK3Lt9NKu27McEi6v/pUxmLlGcKciAAW3X/gexOV2c71IEbn?=
 =?iso-8859-1?Q?vwXvVa8KBXft4rCFdkciwNy8nzXnwSgqmYJnvlonPC3vAzUg3n8aLsSAtF?=
 =?iso-8859-1?Q?yP5Xn3Lj5j59XOLsphPlQpVSsimk+wBiUGuYzJ2HbrG9MK8bJPphLJIhB6?=
 =?iso-8859-1?Q?hqCZzeQ+BA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dc295b-f2cc-4eed-395f-08decbc22023
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 16:12:55.6364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idYqxQHPvsj5X6PFkZ6QPbNa1JfZWrf6R+ax+4RoMHo/1uQ4+8qo8duH9mAf89BsaWvyFtA1jEKJJrQKcvBw3Vg3PX+ez4+brHB871K/DSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P192MB3297
Received-SPF: pass client-ip=40.107.130.115;
 envelope-from=harry.vanhaaren@openchip.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Jun 2026 15:56:59 -0400
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

From: Harry van Haaren <harry.vanhaaren@openchip.com>

The existing code in execlog was never upgraded to the Scoreboard
API, resulting in a bespoke implementation of per-vCPU datastructure
handling. This had some race-conditions, and causes segfaults with
a simple multi-threaded program and two instances of execlog running.

The patch here refactors the custom GArray and GRWLock code away, and
uses the scoreboard APIs like the other plugins. This solves the
"printing while expanding" race-condition of two plugins with multiple
threads in the guest, and hence fixes a segfault.

Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>

---

Hi Qemu-Devel!

This is my first contribution to QEMU itself, but I have worked on
DPDK, OVS, and QEMU-RS a bit in the past. I have experience with
mailing lists for patches and some QEMU internals. I've read the
'submitting a patch' guide, and ran checkpatch... so basics should
be OK I hope!

Please note that LLMs were used to investigate and fix this bug,
but all code in this patch has been reviewed by me, and I believe
it to be a good solution.
---
 contrib/plugins/execlog.c | 65 +++++++++++++++------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d00d9c4ff3..e51af9f2df 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -31,33 +31,28 @@ typedef struct CPU {

 QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;

-static GArray *cpus;
-static GRWLock expand_array_lock;
+/*
+ * Per-vCPU state stored in a qemu_plugin_scoreboard. The scoreboard manag=
es
+ * per-vCPU storage automatically, eliminating the need for manual array
+ * growth, locks, or pointer-stability workarounds.
+ */
+static struct qemu_plugin_scoreboard *cpus;

 static GPtrArray *imatches;
 static GArray *amatches;
 static GPtrArray *rmatches;
 static bool disas_assist;
 static GMutex add_reg_name_lock;
+static GMutex execlog_output_mutex;
 static GPtrArray *all_reg_names;

-static CPU *get_cpu(int vcpu_index)
-{
-    CPU *c;
-    g_rw_lock_reader_lock(&expand_array_lock);
-    c =3D &g_array_index(cpus, CPU, vcpu_index);
-    g_rw_lock_reader_unlock(&expand_array_lock);
-
-    return c;
-}
-
 /**
  * Add memory read or write information to current instruction log
  */
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
                      uint64_t vaddr, void *udata)
 {
-    CPU *c =3D get_cpu(cpu_index);
+    CPU *c =3D qemu_plugin_scoreboard_find(cpus, cpu_index);
     GString *s =3D c->last_exec;

     /* Find vCPU in array */
@@ -117,7 +112,7 @@ static void insn_check_regs(CPU *cpu)
 /* Log last instruction while checking registers */
 static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
 {
-    CPU *cpu =3D get_cpu(cpu_index);
+    CPU *cpu =3D qemu_plugin_scoreboard_find(cpus, cpu_index);

     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
@@ -125,8 +120,10 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_=
index, void *udata)
             insn_check_regs(cpu);
         }

+        g_mutex_lock(&execlog_output_mutex);
         qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
+        g_mutex_unlock(&execlog_output_mutex);
     }

     /* Store new instruction in cache */
@@ -138,7 +135,7 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_i=
ndex, void *udata)
 /* Log last instruction while checking registers, ignore next */
 static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
 {
-    CPU *cpu =3D get_cpu(cpu_index);
+    CPU *cpu =3D qemu_plugin_scoreboard_find(cpus, cpu_index);

     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
@@ -146,8 +143,10 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu_=
index, void *udata)
             insn_check_regs(cpu);
         }

+        g_mutex_lock(&execlog_output_mutex);
         qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
+        g_mutex_unlock(&execlog_output_mutex);
     }

     /* reset */
@@ -157,12 +156,14 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu=
_index, void *udata)
 /* Log last instruction without checking regs, setup next */
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
-    CPU *cpu =3D get_cpu(cpu_index);
+    CPU *cpu =3D qemu_plugin_scoreboard_find(cpus, cpu_index);

     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
+        g_mutex_lock(&execlog_output_mutex);
         qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
+        g_mutex_unlock(&execlog_output_mutex);
     }

     /* Store new instruction in cache */
@@ -378,21 +379,10 @@ static GPtrArray *registers_init(int vcpu_index)
  *   - last_exec tracking data
  *   - list of tracked registers
  *   - initial value of registers
- *
- * As we could have multiple threads trying to do this we need to
- * serialise the expansion under a lock.
  */
 static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 {
-    CPU *c;
-
-    g_rw_lock_writer_lock(&expand_array_lock);
-    if (vcpu_index >=3D cpus->len) {
-        g_array_set_size(cpus, vcpu_index + 1);
-    }
-    g_rw_lock_writer_unlock(&expand_array_lock);
-
-    c =3D get_cpu(vcpu_index);
+    CPU *c =3D qemu_plugin_scoreboard_find(cpus, vcpu_index);
     c->last_exec =3D g_string_new(NULL);
     c->registers =3D registers_init(vcpu_index);
 }
@@ -402,16 +392,15 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned i=
nt vcpu_index)
  */
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    guint i;
-    g_rw_lock_reader_lock(&expand_array_lock);
-    for (i =3D 0; i < cpus->len; i++) {
-        CPU *c =3D get_cpu(i);
-        if (c->last_exec && c->last_exec->str) {
+    int n =3D qemu_plugin_num_vcpus();
+    for (int i =3D 0; i < n; i++) {
+        CPU *c =3D qemu_plugin_scoreboard_find(cpus, i);
+        if (c->last_exec && c->last_exec->len) {
             qemu_plugin_outs(c->last_exec->str);
             qemu_plugin_outs("\n");
         }
     }
-    g_rw_lock_reader_unlock(&expand_array_lock);
+    qemu_plugin_scoreboard_free(cpus);
 }

 /* Add a match to the array of matches */
@@ -452,12 +441,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin=
_id_t id,
                                            const qemu_info_t *info, int ar=
gc,
                                            char **argv)
 {
-    /*
-     * Initialize dynamic array to cache vCPU instruction. In user mode
-     * we don't know the size before emulation.
-     */
-    cpus =3D g_array_sized_new(true, true, sizeof(CPU),
-                             info->system_emulation ? info->system.max_vcp=
us : 1);
+    /* Initialize scoreboard to cache per-vCPU instruction state. */
+    cpus =3D qemu_plugin_scoreboard_new(sizeof(CPU));

     for (int i =3D 0; i < argc; i++) {
         char *opt =3D argv[i];
--
2.54.0



The content, data, and any attached documents to this email are addressed e=
xclusively to the addressee and are confidential and/or may be subject to a=
 non-disclosure agreement. Any use, forwarding, disclosure, and/or copying,=
 in whole or in part, without authorization is prohibited. If you have rece=
ived this email in error, we apologize and, please notify the sender or Ope=
nchip immediately, and delete it from your system.

El contenido, los datos y cualquier documento adjunto a este correo electr=
=F3nico est=E1n dirigidos exclusivamente al destinatario y son confidencial=
es y/o pueden estar sujetas a un acuerdo de no revelaci=F3n. Est=E1 prohibi=
do cualquier uso, reenv=EDo, divulgaci=F3n o copia, total o parcial, sin au=
torizaci=F3n. Si has recibido este correo por error, te pedimos disculpas y=
 agradecemos que lo notifiques de inmediato al remitente o a Openchip, y lo=
 elimines de tu sistema.

El contingut, les dades i qualsevol document adjunt a aquest correu electr=
=F2nic estan dirigits exclusivament al destinatari i s=F3n confidencials i/=
o poden estar subjectes a un acord de no revelaci=F3. Est=E0 prohibit quals=
evol =FAs, reenviament, divulgaci=F3 o c=F2pia, total o parcial, sense auto=
ritzaci=F3. Si has rebut aquest correu per error, et demanem disculpes i ag=
ra=EFm que ho notifiquis d'immediat al remitent o a Openchip, i l'eliminis =
del teu sistema

