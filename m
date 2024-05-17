Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A136C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 15:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7z6n-0004zX-Vy; Fri, 17 May 2024 11:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6i-0004v0-9E
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:52 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6e-0005PC-Fx
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:52 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-571be483ccaso5021859a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715958165; x=1716562965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJ3hD+YdmDQmGtwZeHY/6goxziw8ZaiYrGA/9n+kedo=;
 b=kTIWomTFSVDAeqZv5BrLtF6wQFXQ1CVagceMxk1Uy1Dlqj3JAD7Em+RVlH1STxmQF9
 WKGjTUBcTRK1xzdjJUu463kV7ANZ7mGa0VBs65DT18MtrvjBN9ZKg3Sp9YyDApniFfpt
 f/1dgQAK6w5D+39KHMxYv6p3o1UbuEj2kiSny6BfLNFa2qHT7daAhvFERm4ax054R8yo
 Q5gkbelNBvlb9s54JmYLfyodthRGm59jaRMrnXa7kEir4a9ixw6B3gd6XZoyWAUBb5T1
 mLy/POKtSN6uHJG1NTj9uPMLVQ+zV8D0X56LUSiFQF2DWGyjjyKvrldy6kYijpseRqaE
 CMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958165; x=1716562965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJ3hD+YdmDQmGtwZeHY/6goxziw8ZaiYrGA/9n+kedo=;
 b=l2j6xNcs+MpYBbeWRt2iOKKEGeI42p/3vSvfjLxZrOvNL4XP19LZmmFg5AC4x6oU9c
 rKVhI8xTqUSPX7TENcUv/YgZWiJv2xVhR14oJnk3NuVrBNmqisdtpB2mUNoTfFRVIbWA
 DWyN5ZvCK3c6VjmodDI+f9T2Jd9LMu+0gmGNhJPu9D7BqbYA7VgLGGreyCyyHD4b5vlN
 L45RSS49b36wNNKyBrC6ilOqiwzY9iqmVpyP2dAXBTuQRlOhqlnzab/rpvhhTfjpM8RJ
 Mgh/5EEUh5ru6Q/wBRjvEwkq5ib6o8GNH5qlfLKcCK8fJidGsdx2BvO/BHWrsDWE166n
 Z2xA==
X-Gm-Message-State: AOJu0Yx59CP4YQFaBO+43h0OJs/kcKk8w34kYjeg/lg9bsnl5Zm0Lq8i
 muvPh6Hf8Ng0tTOI/rdFUn91+qhA4ayMKQQQUgKCRUHD4HiUp0tP0CspFyaWcWO2j25D6J5hIFj
 a
X-Google-Smtp-Source: AGHT+IHX69wbOE6sZ0wxuSw7YKHeWMhcHSmNaX2sVXyaHILec8XEA5+NZ8/vy1YS1wo9olRASNMXEw==
X-Received: by 2002:a50:aa94:0:b0:572:a731:dd14 with SMTP id
 4fb4d7f45d1cf-5734d6edacemr16342354a12.28.1715958165443; 
 Fri, 17 May 2024 08:02:45 -0700 (PDT)
Received: from localhost.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb6casm11959706a12.29.2024.05.17.08.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 May 2024 08:02:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/5] hw/core: allow parameter=1 for SMP topology on any machine
Date: Fri, 17 May 2024 17:02:25 +0200
Message-ID: <20240517150227.32205-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240517150227.32205-1-philmd@linaro.org>
References: <20240517150227.32205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This effectively reverts

  commit 54c4ea8f3ae614054079395842128a856a73dbf9
  Author: Zhao Liu <zhao1.liu@intel.com>
  Date:   Sat Mar 9 00:01:37 2024 +0800

    hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP configurations

but is not done as a 'git revert' since the part of the changes to the
file hw/core/machine-smp.c which add 'has_XXX' checks remain desirable.
Furthermore, we have to tweak the subsequently added unit test to
account for differing warning message.

The rationale for the original deprecation was:

  "Currently, it was allowed for users to specify the unsupported
   topology parameter as "1". For example, x86 PC machine doesn't
   support drawer/book/cluster topology levels, but user could specify
   "-smp drawers=1,books=1,clusters=1".

   This is meaningless and confusing, so that the support for this kind
   of configurations is marked deprecated since 9.0."

There are varying POVs on the topic of 'unsupported' topology levels.

It is common to say that on a system without hyperthreading, that there
is always 1 thread. Likewise when new CPUs introduced a concept of
multiple "dies', it was reasonable to say that all historical CPUs
before that implicitly had 1 'die'. Likewise for the more recently
introduced 'modules' and 'clusters' parameter'. From this POV, it is
valid to set 'parameter=1' on the -smp command line for any machine,
only a value > 1 is strictly an error condition.

It doesn't cause any functional difficulty for QEMU, because internally
the QEMU code is itself assuming that all "unsupported" parameters
implicitly have a value of '1'.

At the libvirt level, we've allowed applications to set 'parameter=1'
when configuring a guest, and pass that through to QEMU.

Deprecating this creates extra difficulty for because there's no info
exposed from QEMU about which machine types "support" which parameters.
Thus, libvirt can't know whether it is valid to pass 'parameter=1' for
a given machine type, or whether it will trigger deprecation messages.

Since there's no apparent functional benefit to deleting this deprecated
behaviour from QEMU, and it creates problems for consumers of QEMU,
remove this deprecation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Message-ID: <20240513123358.612355-2-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine-smp.c       | 84 ++++++++++++-------------------------
 tests/unit/test-smp-parse.c |  8 ++--
 2 files changed, 31 insertions(+), 61 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 2b93fa99c9..5d8d7edcbd 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -118,76 +118,46 @@ void machine_parse_smp_config(MachineState *ms,
     }
 
     /*
-     * If not supported by the machine, a topology parameter must be
-     * omitted.
+     * If not supported by the machine, a topology parameter must
+     * not be set to a value greater than 1.
      */
-    if (!mc->smp_props.modules_supported && config->has_modules) {
-        if (config->modules > 1) {
-            error_setg(errp, "modules not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here modules only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported modules parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.modules_supported &&
+        config->has_modules && config->modules > 1) {
+        error_setg(errp,
+                   "modules > 1 not supported by this machine's CPU topology");
+        return;
     }
     modules = modules > 0 ? modules : 1;
 
-    if (!mc->smp_props.clusters_supported && config->has_clusters) {
-        if (config->clusters > 1) {
-            error_setg(errp, "clusters not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here clusters only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported clusters parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.clusters_supported &&
+        config->has_clusters && config->clusters > 1) {
+        error_setg(errp,
+                   "clusters > 1 not supported by this machine's CPU topology");
+        return;
     }
     clusters = clusters > 0 ? clusters : 1;
 
-    if (!mc->smp_props.dies_supported && config->has_dies) {
-        if (config->dies > 1) {
-            error_setg(errp, "dies not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here dies only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported dies parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.dies_supported &&
+        config->has_dies && config->dies > 1) {
+        error_setg(errp,
+                   "dies > 1 not supported by this machine's CPU topology");
+        return;
     }
     dies = dies > 0 ? dies : 1;
 
-    if (!mc->smp_props.books_supported && config->has_books) {
-        if (config->books > 1) {
-            error_setg(errp, "books not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here books only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported books parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.books_supported &&
+        config->has_books && config->books > 1) {
+        error_setg(errp,
+                   "books > 1 not supported by this machine's CPU topology");
+        return;
     }
     books = books > 0 ? books : 1;
 
-    if (!mc->smp_props.drawers_supported && config->has_drawers) {
-        if (config->drawers > 1) {
-            error_setg(errp, "drawers not supported by this "
-                       "machine's CPU topology");
-            return;
-        } else {
-            /* Here drawers only equals 1 since we've checked zero case. */
-            warn_report("Deprecated CPU topology (considered invalid): "
-                        "Unsupported drawers parameter mustn't be "
-                        "specified as 1");
-        }
+    if (!mc->smp_props.drawers_supported &&
+        config->has_drawers && config->drawers > 1) {
+        error_setg(errp,
+                   "drawers > 1 not supported by this machine's CPU topology");
+        return;
     }
     drawers = drawers > 0 ? drawers : 1;
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 8994337e12..56165e6644 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -337,21 +337,21 @@ static const struct SMPTestData data_generic_invalid[] = {
     {
         /* config: -smp 2,dies=2 */
         .config = SMP_CONFIG_WITH_DIES(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
-        .expect_error = "dies not supported by this machine's CPU topology",
+        .expect_error = "dies > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,clusters=2 */
         .config = SMP_CONFIG_WITH_CLUSTERS(T, 2, F, 0, T, 2, F, 0, F, 0, F, 0),
-        .expect_error = "clusters not supported by this machine's CPU topology",
+        .expect_error = "clusters > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,books=2 */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, F, 0, T, 2, F,
                                                 0, F, 0, F, 0, F, 0),
-        .expect_error = "books not supported by this machine's CPU topology",
+        .expect_error = "books > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 2,drawers=2 */
         .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 2, T, 2, F, 0, F,
                                                 0, F, 0, F, 0, F, 0),
-        .expect_error = "drawers not supported by this machine's CPU topology",
+        .expect_error = "drawers > 1 not supported by this machine's CPU topology",
     }, {
         /* config: -smp 8,sockets=2,cores=4,threads=2,maxcpus=8 */
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 8),
-- 
2.41.0


