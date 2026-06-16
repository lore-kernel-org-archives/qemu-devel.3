Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCCBCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZuA-0000nq-0H; Tue, 16 Jun 2026 15:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wZWPx-0001AS-Em
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:13:37 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wZWPv-00016G-L5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4pwKKBb7L814iNcsL40JlqdyyTGI3c9PHrVfQM68xyBt/qa9oTArtvOe3M/O6BeBr7V7zgzAB1hDZPFJ119H4mk3BlGeyPwQtIC+gQEr+wmBm8vM6n3UTarBTpIoHGtOVYStpqAmwuZoZIhKvbJ3RPwrZRyaqUUwovUYzMExnO2EsxmdcoeKaJULzEwYJhcra0fnBjzrBPJCLIaADWo9QF4SH1VlMrC2LJas8teI8HyIEhalasYQYIHvTHkFV4qEl0HIWvzTXKLz+xZZmNFktU3FcQOPsVw7RgJfrORbYe9BUttq0pNxIX1yalTzS6Y1KntgEeWZGjikuBvbq48oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt1kkJjEgvN93T6STDpRSbcG+6u4vI6iOnvYR02zj3Y=;
 b=HDdxE4TwiZlDYDPXB6dI9xd3mVSfLAhMYX9isDc82hzAMHh9f+n3g9xruDkTr7tU/aL/3zAF34HxvLmveiL5NJBfA4WX8OX1GnhuKCX1WAxVZE5Z778PgrHfnDPOMZohHFP3szfhKu90eKD4RSH/XllHViyxbRwza7D0hlhk1+uVmORUQ3uBk84AN7ruMPbkBj82mHRU0dHz5KXn8oIC+a5Bo4dIk1nXRme3JkauFv2oUNNHO3h0LPePqoY9Zg4QabgJReDz2+K/VbdnIJak2BAycW+ogwjv78VH7YxFjd40tRrLK5gPRXzK1wLvFN89bI6VADXrDGLGOsgx0xeYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt1kkJjEgvN93T6STDpRSbcG+6u4vI6iOnvYR02zj3Y=;
 b=h4KGs4Nc9EcAIBJRky+RbkAf2S/rYuREtTJTiIzO77BJj/9SSOBhhNnR4X4b0vC3R71DUOQv8CtFXn/ngDQYF/Km0kRqKy6QNrj9ScZqTaUqwqNCfYpgKkhLUSwPvM9t1Ab61HkY1nIAVC++640NVWivMsPQN2sj2WtY63jfIzhK9n1YgxA09shqlZK3QzrH29Nc+Z67CTMkRIUtCFxWQMZVbwRWn8yYQrWq/8jBvd4+s4ZG/XLkyofNs9Ho3mKRvBKoLsW3lJ32ImoAYbETLPCMlZ7pYk16BVG409+29jjABsR4ejUyPCDZ71aXrMuk4zO2RAveAcuGy79HLkLCHw==
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:328::6)
 by AM4P192MB3297.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:6ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:13:02 +0000
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64]) by GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64%6]) with mapi id 15.21.0113.014; Tue, 16 Jun 2026
 16:13:02 +0000
From: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>, Harry van Haaren | OPENCHIP
 <harry.vanhaaren@openchip.com>
Subject: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution print
 loss
Thread-Topic: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution
 print loss
Thread-Index: AQHc/asBdz5UenWH/EGtxKxaHNookQ==
Date: Tue, 16 Jun 2026 16:13:02 +0000
Message-ID: <20260616161242.267315-2-harry.vanhaaren@openchip.com>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
In-Reply-To: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P192MB3464:EE_|AM4P192MB3297:EE_
x-ms-office365-filtering-correlation-id: 74bf491f-f231-499f-dae8-08decbc22413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003|3023799007|6133799003|38070700021;
x-microsoft-antispam-message-info: wR/scFr9GSerlMxfsJHehrGTso4dpzfTFuLAE56cstfO9tPeE9FM+Z2uGjHcj8ZBaWamQVU7URTkw1OAZ1x0j7HYT1VTKaUu1t3HseZvdLLjl3Wk0VMWTrhTqR+z87HsiEp9y+t+SjE7NTAq6ltKW4uUK2jHN8D+ep6W5/Jd28+p6QlyLsHhAQxQOuHVdjzTiEkITQiyiJueJbtV2QDvLIrQphCmI4O3Xjs9REj/8x0Zw07UwLe8luNPaCCbph/6utBrluv2rqvE9je6xvGLdHNuYyrTYfrmCWw+zBYsnaR527s1frHTuDvCbUuMsWq1/1rEuqUWyXHq82QKzhRuG7L5Qt+HXDWL9sUm9QOLg2cgtfQwgkpLikqrDRIrIlYh6zupojCFU2KKpG1+S56lwR1BStmq6lZLDx+v1ggjvqSnK3DqKX9LAwUoGCEDeFNiz2QiG4Fum+ttt8yD1CAkJSU7T8srmlTofvuVbVZRhpywy26uWZQpdEz/bCzWbb+R8BcMzwogvYDaMDfkGmA1kVwK5A9DjN05wI4G1vRBnHJlUJGw6puQhZNzhhgUGxoiEY56293+/ps28Ay7wuNH9MVbol7+Rv1Fu+KuwSG5WmhDhBpcqX1CK8ykVxux07YC1FLe/+xBQgkTvoaq1enB4GWGSbAexcYjvnXVA2iSMFr10Li5dFnUSEzcBuAQVIOCB5fxXeju7UDoLIyfVjbWwCmoGbUOqSpyeHyn1/7wYMzHrNlLn5ohKwRDgf+Xrvpu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P192MB3464.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qbos+vQxehnVe0A7HqXsTL3Ij8xREWU7wG5NRMAItsVgI/XmdP7HVh4a69?=
 =?iso-8859-1?Q?21mR+0DyM7qCCV2QzdaLrINa3L1qGZab41kpYt4YVVIsB9RJo5kK4NsqKa?=
 =?iso-8859-1?Q?La8DHuTN7Laz5sVYCwwXZ+w3rkGae3zxKN0JzphuHPkwLRLPiG9aBqmRPH?=
 =?iso-8859-1?Q?tyviavEYhkEX75+FLkfdk+xvTteJfi8UlEv6P8M77u/kymtFnDMVKhIU/P?=
 =?iso-8859-1?Q?k0y8whXq8rlHStSXH2pc8IgobBB5pRjzt8ZvGBmW42QEbZeYxWCRZYroH+?=
 =?iso-8859-1?Q?/U2edQ8Qr05N2aNihf8kVO1FBHE0dmW1Ea+Lo6IREuSfvzroun2M1EcQYW?=
 =?iso-8859-1?Q?v31GHBN7KoGiJqg+oSBjxLbUIPjCTpakUxz59J6rf2jsrqzpMJPNYzbocy?=
 =?iso-8859-1?Q?76I3zwzBD/vCe6YBamubRe1Sn6hLIx+Q0i9TZtyvNbNUX7OLoef0+OvVt8?=
 =?iso-8859-1?Q?CVAlLRFmt437apxDOtYG2CaU+FGPgB7CBAMMhjA8bahd40FaQbWAcK4pWm?=
 =?iso-8859-1?Q?IWYIxRhe0PT+9UVnEskkIXhd/gvox3i6o6ekVEbFyIPb6A/0BmKb8kYd5+?=
 =?iso-8859-1?Q?b4dDNEE/Z0rSVGHNMGDucth1AHCWQubt5m9JRYiiSi8787ilsBfAuOMjxI?=
 =?iso-8859-1?Q?jrfDgFy8Mx78u1wdysExFXGOvB+1f1V9K8AM+ez7B7ay3gxHkXjWdz6kSZ?=
 =?iso-8859-1?Q?Z/HtkR+D3CmWpvxmFvsDi2HAN6Smw4eP0EwOZVbEIw3FSWDxBXhsdI9wCY?=
 =?iso-8859-1?Q?U+LyaxSwUz2O8wn3uCTE5U2T63MtIpPeJTJCziElwz+L0pzPKSfNxlGEaO?=
 =?iso-8859-1?Q?WZ89bFXXbDMGrB9bUj5HF8Jgbbja3a+UbnnwDxuxqeEktHBlp/9X3/4sdg?=
 =?iso-8859-1?Q?iiVod6cy+85PaIOMc10g/C7SxTJkgnMSExH9nfrVbFNTjdnIO3+74o0yl2?=
 =?iso-8859-1?Q?tcv9o0IdsK2F0y2lhN+khdr/KiXnPsljsREdB+KtugpMHgzXrZ/1RAgHZe?=
 =?iso-8859-1?Q?eQRg6U0KgNYOOtf071XNjRaTlhQANYbAOyHxyPCpe+Ai7nAQJdtgqQPfYx?=
 =?iso-8859-1?Q?nnFhtl29ZbdUwXnWRZ8FDgMdOoQ5rIgfNbDMepmkg9N+d8Ht+mNju6zHO6?=
 =?iso-8859-1?Q?Auqxsd2o2X3+UasxA4MzxLynA8gOosN4+iMpi7TOCp2djwfidt/CTL/XxC?=
 =?iso-8859-1?Q?tCLrKM0RFU4PRv1QpAUr9yPOh9CNhqNOgraU/Q2mL7oHAkfb4eOaMcxFdG?=
 =?iso-8859-1?Q?7ph5aDRq0fJiKPILGZCb+t7ucIMP+sp+FLndSGz8N1mSTYOYqUQXmaPG9a?=
 =?iso-8859-1?Q?qDOqd103iCId9TOAo1grmo2wbTt98IDNJpfR8InsPKhDVgiWd4bZfsXtKd?=
 =?iso-8859-1?Q?W3sqc+U9Bs94TOAmC/qZ5TQjj+Mm0RqF76kPxGB0JjMcijiopxoUw+jtaV?=
 =?iso-8859-1?Q?QtrbafDTMqCOFdGUvgTbqMsEs8iQljUT4qWuJGAraOTN75nwUAdRXpG9KQ?=
 =?iso-8859-1?Q?iNDsHv8/AbGaZNgAEhygeFXyU+BoIV0U5UskUc5PNqZrpBnxnDVjAGrxqj?=
 =?iso-8859-1?Q?ay+Gb1BwF43M5der6jG035hmCRFGZcVvJUfmpsymNRbcC76dShzBZF8HZl?=
 =?iso-8859-1?Q?PiKCw59diaw6ELP2j6lvhEzhS9zIckTiynUXNkQI6rDLM2kMTnMpZ5Vnmo?=
 =?iso-8859-1?Q?a3zr32c4hHEwSe/uqrnQW1Shg0IrKwt0B+g+L8EPmDRlwC00zLliZOTq31?=
 =?iso-8859-1?Q?usVEfqODND3mwRlesI99StGUFf8bCHoaYa+o50EuP72/QIkkUUq7YU5tqi?=
 =?iso-8859-1?Q?tll4aR9gPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bf491f-f231-499f-dae8-08decbc22413
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 16:13:02.2354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MB6c0oridJJVCpOXPNTaxClgu3rgR8PL68/R/9cdguEOO4GgBmlrT78m/Mc9U3CdKUzIh8a8X6oInKAbNrPrqaAW8WCE2aDUHXNORJqTvA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P192MB3297
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=harry.vanhaaren@openchip.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Executed instructions are cached in string format inside the
execlog plugin. These strings are flushed on exit of a TB, improving
performance. This causes executed instructions to be lost when an
'ecall' (riscv system call) occurs that causes the thread to terminate.

The fix in this patch registers an 'on_exit()' callback, and flushes
any content in the c->last_exec buffer, to ensure all instructions are
present in the final instruction log.

A mutex lock/unlock is added around the plugin exit, to ensure the
lines are not corrupted.

Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>

---

Please note that LLMs were used to investigate and fix this bug,
but all code in this patch has been reviewed by me, and I believe
it to be a good solution.
---
 contrib/plugins/execlog.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index e51af9f2df..f362b38268 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -388,7 +388,28 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned in=
t vcpu_index)
 }

 /**
- * On plugin exit, print last instruction in cache
+ * On vCPU exit, flush the last cached instruction for this vCPU.
+ *
+ * The one-instruction-delay pattern stores each instruction in last_exec =
and
+ * only prints it when the *next* callback fires. When a thread exits via
+ * syscall (e.g. ecall/exit), no subsequent callback fires for that vCPU a=
nd
+ * the final instruction is silently dropped. Flushing here guarantees it =
is
+ * written before the vCPU is torn down.
+ */
+static void vcpu_exit(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    CPU *c =3D qemu_plugin_scoreboard_find(cpus, vcpu_index);
+    if (c->last_exec && c->last_exec->len) {
+        g_mutex_lock(&execlog_output_mutex);
+        qemu_plugin_outs(c->last_exec->str);
+        qemu_plugin_outs("\n");
+        g_mutex_unlock(&execlog_output_mutex);
+        g_string_truncate(c->last_exec, 0);
+    }
+}
+
+/**
+ * On plugin exit, flush any remaining cached instructions and free state.
  */
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
@@ -396,8 +417,10 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     for (int i =3D 0; i < n; i++) {
         CPU *c =3D qemu_plugin_scoreboard_find(cpus, i);
         if (c->last_exec && c->last_exec->len) {
+            g_mutex_lock(&execlog_output_mutex);
             qemu_plugin_outs(c->last_exec->str);
             qemu_plugin_outs("\n");
+            g_mutex_unlock(&execlog_output_mutex);
         }
     }
     qemu_plugin_scoreboard_free(cpus);
@@ -467,6 +490,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_=
id_t id,

     /* Register init, translation block and exit callbacks */
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);

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

