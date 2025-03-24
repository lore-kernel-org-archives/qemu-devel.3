Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF30BC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn0h-0000ux-EP; Mon, 24 Mar 2025 14:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0e-0000tr-62
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:58:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0a-0001MY-5q
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:58:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so4058269f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842726; x=1743447526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpLxLOfIgkSLgm5ySIPU3BNmm1oN+7/70Slcc1e/Pik=;
 b=oxEUQ6V0qPmpWWrSD+4Qpb7yq7cQYazzVc4VRaj5RGZ/fczXIA+5UoG/Jdw+0EoNXF
 5beeZMqVLG1g4rLaHqTG8ppJi0fAPAVDvWoriQkv5+LcEcwfRsK/J7k/esVAM1EKlv0Y
 PoVPySjXi/81im2PipfjiHfphDTKubMy/w/rZ5JHrrzX0e3ud/Kk9wKCTLjbj7WqSK64
 gVYkhTd3/I894seYonUz/sUp8m+1GxW6Zdy3VzVQlpqe/zwdsPQ6PPL4TUcHH4pvG+1L
 2eS/jNW4F4odcvQN1yes1vwtVgZfVZE8Yt2OxyoTZisHt6675tpT0inbohwF5zben5zb
 eD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842726; x=1743447526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpLxLOfIgkSLgm5ySIPU3BNmm1oN+7/70Slcc1e/Pik=;
 b=D0Hj+8pYRfhBxvdxDcW75BfldFvh6G/UexMFOUyKD7e4f04qElDGG8O1UDiSTDjWlS
 P4Cc3GBW2BWz9lWZ1uPZLt8XwO6jgWWLpnwxVvQ2di94p7G7PaMN0KscEuH+TWK5z5H6
 u6+ibDx9ljV1DURAbh6J3NE3ZsDXEwqUMoJoAIZ4+FOTKkrMlvaIRZsBSWDacs5DcswM
 wr/RlNF9vi+svfMtFhNgVEItbTJH14hf5buVxbb+G48tfDZ4px5IOgNlv0+kyMWWFejb
 TGmv/9bKXMapFEzjVDWsQFBSKy6SsS7ZG07XLOp84wApk+szsPfzQWCXwb9DYbN4FmiD
 X/Eg==
X-Gm-Message-State: AOJu0YzfXfKFvuqu2rGOhWBEzRIqfQf07p0YahikqAqawzHANdBZxnId
 8jBt93uoTKJcmWaKtTLiQanm/oNBBQ6htaCR7r8WYmQB9uL0dy6SXd6TyGchDbHVQr3o6dyYGyf
 2
X-Gm-Gg: ASbGncs8cN4LsPm5RQxnWj+AeRDicwN9zCKi9/XI4iDJhiANqfLWhbgNkRqT20wWj8y
 NyPC23l54oGsKldLQegqYQ2gjX70bKg5kkYYVq76kXU6XFEw6lwgpm3EDW4o+LAAZ99PyZPNrlJ
 RQko0c1woLZDdRxYQHiO8NbiPLvJZ1JGbOuldDnfceZPkJamLWB4zKUwcTmnjrgjywB9XVps7VC
 2Bi71bKMG5jxWU531nnDHgrsh0F+zUmLLYY8wcPZHBWU4a7FymfEqG+Hv9I17h0gd1NzvVhlN25
 LPgmtD06SuPTLH1j8kIGl2RSC3JJ5dlWQSNCKSouniknfV3hf0fD+GRzaREgjn+CfU6nYSZqFap
 Q5Y8JaXvNw2JPm2MvLzmcWNM8
X-Google-Smtp-Source: AGHT+IH8Jp2YhVh2I5RBKIZ+nBMKefdxFBhVJEKtI+9XqNw5qq9AgDGx+nqzbkPYycCs7qgzP3JQIg==
X-Received: by 2002:a05:6000:4187:b0:38f:4fa6:68df with SMTP id
 ffacd0b85a97d-3997f940e06mr8229005f8f.51.1742842725682; 
 Mon, 24 Mar 2025 11:58:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5b8dsm11845800f8f.59.2025.03.24.11.58.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:58:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 1/7] cpus: Introduce CPUClass::list_cpus() callback
Date: Mon, 24 Mar 2025 19:58:31 +0100
Message-ID: <20250324185837.46506-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some targets define cpu_list to a method listing their
CPUs on stdout. In order to make list_cpus() generic,
introduce the CPUClass::list_cpus() callback.
When no callback is registered, list_cpus() defaults
to the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 ++
 cpu-target.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..ccfcd3eb3a6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -102,6 +102,7 @@ struct SysemuCPUOps;
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
  *                 instantiatable CPU type.
+ * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @mmu_index: Callback for choosing softmmu mmu index;
@@ -150,6 +151,7 @@ struct CPUClass {
     /*< public >*/
 
     ObjectClass *(*class_by_name)(const char *cpu_model);
+    void (*list_cpus)(void);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     int (*mmu_index)(CPUState *cpu, bool ifetch);
diff --git a/cpu-target.c b/cpu-target.c
index cae77374b38..5947ca31a0a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -98,7 +98,13 @@ static void cpu_list(void)
 
 void list_cpus(void)
 {
-    cpu_list();
+    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+
+    if (cc->list_cpus) {
+        cc->list_cpus();
+    } else {
+        cpu_list();
+    }
 }
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
-- 
2.47.1


