Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D37DC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmpj-00025M-Fr; Mon, 24 Mar 2025 14:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmp6-0001ZB-IV
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmp3-0008TQ-V0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so3868389f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842012; x=1743446812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oN8jfo5grq0MHdHsUE+0JullpCPbAdZoVNQ+DvNKQ/g=;
 b=SwL4HtrSyxfWHvwmA8T3TEsz40qVljp4hjXGYhkgxHiLMGN36eL789Sob1sX75CLor
 UzaocFxUcv/6m/xd16rNTtmfP1MQvyOnXw8gHPiiQYx41PODtDjZVUSq/91njz1PQqlT
 a8Nvv5a45iYjSJBEeLoCYhAEeb0ydsyu/PvCgqDMnAT+qHRSwmSATjcBSjqGyj6N7QwQ
 IvXq+7BndTTFp1w3JtFCzm5E3Fdkpc9bNeLdD9cW+jJ0GEm+/pJt4crDJ3w0qu2HKq4Q
 z3DRFWChE46tA5Sa4hKAsBJHhUPnGM/SYvo5Y6el4edJVdeUmeqtSp8tkmb0xVML+sWS
 ZYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842012; x=1743446812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oN8jfo5grq0MHdHsUE+0JullpCPbAdZoVNQ+DvNKQ/g=;
 b=QT+medD2YVFzOnyCuBMdy++kaFFbzNTTNAZ10ZD4TgkwnHG1b4QTfVrs+QLuXPecO0
 loSp08uo1RTxFSqzfYqeEYE8e6l7STO5GymqkrhkiubWddLgHNqrpMBx2TEIjRdyKMB7
 NfSti89CLG04PIXrA37Trr3AUHjtWLhkwqV+4ityVt7AaSlBxPAM+KREnmH3NNZpfj5i
 oDaZnWoiEezJCFjz+A5M7ZJUjO8vFuBEXcWqADtTNPPCSjyKRwu6Wsz5SUOrfH5uGTnv
 RcFGC+gc7uRV7CW9PPX+TdSdLigADxhh5oY/RWpDivU3Nrp1TKMXPonwVfJbrCAvEhM3
 DRCQ==
X-Gm-Message-State: AOJu0YzpVvz/vSBLMuL2TELL1+hluF4HU6DAjb6tv4YsLnq85tiuzhyj
 M0IcACux6aKHbG4uZ05hE6I73T4fYEXpupM96tBO6Wnt+MNvGw/7tSkJb2cj2V5KC5Hr8W1M+9C
 v
X-Gm-Gg: ASbGnctXuaCnwUZJE9expFvf0w7zJ3U1MIKUUfHDCFv/E0iBPRJphzP91E+FolJvBfv
 LBnt3g7zej6LfilkUD09ZnyRTDTN8AdHcnHboxhmvrgt0xuHIiEJadBjrHLxOoWKV8ZsnTLThhF
 fVdzyJNTzBV3em1Gvq79rw26MgO63qb+Ry1hyOz+xuwiT19L4gIpdJktdqd/OsZSjImQfUEBrcN
 0XI282BYNqBhpDLT1SIKFezdcKeSC1TK+EVh9i8zDDRXciWaWckIuy9xO44e44mqQz4FNfeK400
 BsVfNbXMb6w7WjT5buzuqiP3tjGAA9DiBL2mYuZWXr5lGHqg13tPRd2kfeACHbBEjWSrGgINi6P
 h7s04REkLDuAXDq8s+4vMyNqs
X-Google-Smtp-Source: AGHT+IE3cTcSx4ZN1CMTzffZ6A3Bt3px2Yoe5OBUs8ZAl0sMh866jiPJ6JNiNVMG9/ZAkMDSdoKPOg==
X-Received: by 2002:a5d:5f42:0:b0:391:2995:5ef2 with SMTP id
 ffacd0b85a97d-3997f937538mr11141784f8f.37.1742842012150; 
 Mon, 24 Mar 2025 11:46:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9955c0sm11515751f8f.3.2025.03.24.11.46.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 7/7] cpus: Remove #ifdef check on cpu_list
 definition
Date: Mon, 24 Mar 2025 19:46:11 +0100
Message-ID: <20250324184611.44031-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Since we removed all definitions of cpu_list, the #ifdef
check is always true. Remove it, inlining cpu_list().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 cpu-target.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5947ca31a0a..30598619581 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -71,7 +71,6 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-#ifndef cpu_list
 static void cpu_list_entry(gpointer data, gpointer user_data)
 {
     CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
@@ -85,17 +84,6 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
     }
 }
 
-static void cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-#endif
-
 void list_cpus(void)
 {
     CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
@@ -103,7 +91,12 @@ void list_cpus(void)
     if (cc->list_cpus) {
         cc->list_cpus();
     } else {
-        cpu_list();
+        GSList *list;
+
+        list = object_class_get_list_sorted(TYPE_CPU, false);
+        qemu_printf("Available CPUs:\n");
+        g_slist_foreach(list, cpu_list_entry, NULL);
+        g_slist_free(list);
     }
 }
 
-- 
2.47.1


