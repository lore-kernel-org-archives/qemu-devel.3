Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91F1C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNo5-0005So-Hf; Thu, 03 Jul 2025 13:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNnx-0005S8-TJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNnv-0007mI-S4
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so43613f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563976; x=1752168776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyDIfVgkjNXaUsE4JArqlEQoqhWF6dxOZmRK2K42QUQ=;
 b=Jt+vv/9/Hofsij/l1QN3GIO0LWzL3tBJj4euuDYyPxidL4nye6h0SB9jl3agGEkieK
 mpIwci3s5cNT7XcP44N13Zr7hUVVltQ6ZIvbnaeCl+Apt/d0Gox+hixtSlSe94gNrTOQ
 vvR7Nvuzslt04Fi2ntSXpdqQC/o8lwBIoh6YfQqWBlbsiJDpNqkZJOk6qk4Ingz1+kKw
 ZQNhA/b9KgtpSoFvHUBjN5SMuopRgV9JB7bSIjrZpdvHfwpxwG63jdv5WoBFDGVct8zC
 CckDjRke3Ny8+4uBYTNhDFhKoS14TJFBqYRvJXgTCKjHE8LihETCMTK82dHUbxHnqDrf
 kgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563976; x=1752168776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyDIfVgkjNXaUsE4JArqlEQoqhWF6dxOZmRK2K42QUQ=;
 b=GntU8HzgKC7naddn5zHBwV0sp+E8XQ8P0iX4MdjbBMYJPsVuhSDPrb5ntPBBFBST3L
 aPcOqyQ/JmJ4bkYItGPJSonGTUt8/srwSjXyrQ6IKejAIfwPw/RBY6Ud+uDaP/LqLE6T
 lGFIq27CFrDt/lIu7uaAPU1brFbtQBnkCYGM5HXGeMLqn4QcQ6/aJUtODChNaK7rjJ1m
 uJ9bL1BSKgkJwvocjbC1hGwRCstb0Km13Ciwlmf5CxZ217nYbjyZX5ppPNmYDU7rwP2M
 TYiV5IPkyeKsOdrYELTKOgThVK3dITHw9C7blWeQklXiYeZKod7W2tgtAH1cSv6sOMSR
 pnBQ==
X-Gm-Message-State: AOJu0YzMMwsL1h2bDFrHQ65YQX+WTTx1NuzXfEvIBIc8b2k5RJDDSOJ6
 L3oC5lIH9zeb2fOUwhtP0kr9R6cS6J6aBgZZC+vS2cZWIUfK/58ofiIzbDhtysY6gxllNaR51Pj
 6nDay88k=
X-Gm-Gg: ASbGncuzsnrVNUS7Ozaqh7aKuiB4JX6Fj+LYJXSK0HXbWR2iY+a9JyNRxGRTromEoc2
 Z5BPh3RagR5aLYQ0sDoGfftcELKak2coma+Ft3ia99Vea8nZmZDjoi2tTcVC34+sowA2FW6SjmR
 eEj8YhkkJq0iyUZsyr5BVv5yh6+p6ZEITPYBQDDEF2SS/Mf4w89Pgj38CQJJcMLMd32c5NWR6Us
 81fVJjLyaDXizxy7zyw3WNF7Bvi5ILJFoy2pyVepqgAUg+qSflKnJ8vLxfMerKZ/cxJRu6ZV4UR
 YR0PsszKNe+0ToO334lxJTYNAmS6f7RqXbi8DqZtHcJ3JdKK271HvyE7+BSRObloihZlcHhFE9t
 M65DDdYaq0Jgik2aWhJ7GdTQCwFuL2K0tMusk
X-Google-Smtp-Source: AGHT+IGvqtx8XoCWZPw9qLTBcUURJ8nlsly8B2AV46B8e0vsOMNe4InR+5t9Ay8sX+jTL2yLsiJLHw==
X-Received: by 2002:a05:6000:3106:b0:3a5:8a68:b81d with SMTP id
 ffacd0b85a97d-3b32de6b426mr3567970f8f.43.1751563975815; 
 Thu, 03 Jul 2025 10:32:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c6c9sm309916f8f.89.2025.07.03.10.32.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:32:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v6 01/39] hw/core/machine: Display CPU model name in 'info
 cpus' command
Date: Thu,  3 Jul 2025 19:32:07 +0200
Message-ID: <20250703173248.44995-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Display the CPU model in 'info cpus'. Example before:

 $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
 QEMU 10.0.0 monitor - type 'help' for more information
 (qemu) info cpus
 * CPU #0: thread_id=42924
   CPU #1: thread_id=42924
   CPU #2: thread_id=42924
   CPU #3: thread_id=42924
 (qemu) q

and after:

 $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
 QEMU 10.0.50 monitor - type 'help' for more information
 (qemu) info cpus
 * CPU #0: thread_id=42916 (cortex-a72)
   CPU #1: thread_id=42916 (cortex-a72)
   CPU #2: thread_id=42916 (cortex-r5f)
   CPU #3: thread_id=42916 (cortex-r5f)
 (qemu)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/machine.json          | 3 +++
 hw/core/machine-hmp-cmds.c | 3 ++-
 hw/core/machine-qmp-cmds.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0650b8de71a..d5bbb5e367e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -80,6 +80,8 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @model: CPU model name (since 10.1)
+#
 # @props: properties associated with a virtual CPU, e.g. the socket id
 #
 # @target: the QEMU system emulation target, which determines which
@@ -91,6 +93,7 @@
   'base'          : { 'cpu-index'    : 'int',
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
+                      'model'        : 'str',
                       '*props'       : 'CpuInstanceProperties',
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c6325cdcaaa..65eeb5e9cc2 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -40,7 +40,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 " (%s)\n",
+                       cpu->value->thread_id, cpu->value->model);
     }
 
     qapi_free_CpuInfoFastList(cpu_list);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..ab4fd1ec08a 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         value->cpu_index = cpu->cpu_index;
         value->qom_path = object_get_canonical_path(OBJECT(cpu));
         value->thread_id = cpu->thread_id;
+        value->model = cpu_model_from_type(object_get_typename(OBJECT(cpu)));
 
         if (mc->cpu_index_to_instance_props) {
             CpuInstanceProperties *props;
-- 
2.49.0


