Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D822C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wY-0006ph-Et; Thu, 23 May 2024 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wR-0006fu-AY
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wM-0004rI-7p
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XD3VqbDmI0RM0DzS8AgwAsm/li+8/Nomap0jsqm0odc=;
 b=hjVAHDMJz2/buUoAP9jv71us2U4KVrKyP7JbQGK6nmIL/mdDz0HFhgyIs5OjrUUAJCoEAN
 htFTJERgF8cZ2FSjY3V0fZjJ+sOGi57CshawSOW/cCXG1xF4p5RYWyqFQIkT9FvLYy0fB/
 h5gddXtbWeCmUUVprnN8Q0vEMM1Fe88=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-V2n81WApMYKj7u7_jTcpTg-1; Thu, 23 May 2024 11:01:07 -0400
X-MC-Unique: V2n81WApMYKj7u7_jTcpTg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59bfd32b8fso124340166b.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476466; x=1717081266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XD3VqbDmI0RM0DzS8AgwAsm/li+8/Nomap0jsqm0odc=;
 b=JLf7SnZJg4O0Lu4wqe1ycS9lvuRmgOgIlXbkGDm/n5xlGnQwYXpAI21QNc7vUXfV2n
 3/0R6ohDeawgedI13vwj5xZAHyoIXIRg6cTIUf75DFpdfJUo8KfBQq6FUJPLchdUEebE
 +W/vvAmy3RPHiNZG6sHFgvjle5q1p9mjmYJZdQteKWD5E4Li06WxfLJDDi2K5mz4SnVW
 5WMLttbPuVO3Lvi2ughZyEpRilRYjiChyyUw9hXtuQLgmE4LuZucSYIJkV6n0hP4B6F7
 mijLn2Uok+I/3Vpf14ESZka8FzwThSKOEX+oQuWfVyUSan5i6WHCZQ5fUnUpsMzR9ZHR
 bUKA==
X-Gm-Message-State: AOJu0YyETtprfkBm15MDo7UkwxOID8M8dHW+KJh43AfGgUeBAb9ke4P2
 pY6GnDiXr7znm8qte7XSsFw4H31qR7FrPsLSZKyBFCUiUJdCGSri4OV4zLnzb9r8f3iMxERCcJA
 CRAhDFiMgMKzBzhBvqAJI0mXuylV90VBx7m0PjU+xjQfR+g8rsZM8VQ48oHAsKbvpfR++BGMs9W
 TWXnWkNQlteQy7qxDtEIXlDfz2N+iLXbkgv6kx
X-Received: by 2002:a17:906:a93:b0:a59:bfab:b25a with SMTP id
 a640c23a62f3a-a622818a40bmr316058066b.63.1716476465779; 
 Thu, 23 May 2024 08:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEavCL/AitV1xZKYiHmAGP55DDg8Y5YUOC4sM3UVZ9bymqGfPJcmRurekWXGt8XJEa4OP61zw==
X-Received: by 2002:a17:906:a93:b0:a59:bfab:b25a with SMTP id
 a640c23a62f3a-a622818a40bmr316056366b.63.1716476465453; 
 Thu, 23 May 2024 08:01:05 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b177desm1941584966b.207.2024.05.23.08.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>
Subject: [PULL 11/23] i386: Split topology types of CPUID[0x1F] from the
 definitions of CPUID[0xB]
Date: Thu, 23 May 2024 17:00:24 +0200
Message-ID: <20240523150036.1050011-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

CPUID[0xB] defines SMT, Core and Invalid types, and this leaf is shared
by Intel and AMD CPUs.

But for extended topology levels, Intel CPU (in CPUID[0x1F]) and AMD CPU
(in CPUID[0x80000026]) have the different definitions with different
enumeration values.

Though CPUID[0x80000026] hasn't been implemented in QEMU, to avoid
possible misunderstanding, split topology types of CPUID[0x1F] from the
definitions of CPUID[0xB] and introduce CPUID[0x1F]-specific topology
types.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-11-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 13 +++++++++----
 target/i386/cpu.c | 14 +++++++-------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9e7b9e918e9..8c83900202d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1016,10 +1016,15 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
 /* CPUID[0xB].ECX level types */
-#define CPUID_TOPOLOGY_LEVEL_INVALID  (0U << 8)
-#define CPUID_TOPOLOGY_LEVEL_SMT      (1U << 8)
-#define CPUID_TOPOLOGY_LEVEL_CORE     (2U << 8)
-#define CPUID_TOPOLOGY_LEVEL_DIE      (5U << 8)
+#define CPUID_B_ECX_TOPO_LEVEL_INVALID  0
+#define CPUID_B_ECX_TOPO_LEVEL_SMT      1
+#define CPUID_B_ECX_TOPO_LEVEL_CORE     2
+
+/* COUID[0x1F].ECX level types */
+#define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
+#define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
+#define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
 
 /* MSR Feature Bits */
 #define MSR_ARCH_CAP_RDCL_NO            (1U << 0)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8419055006c..d350eb8a736 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6418,17 +6418,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = threads_per_pkg;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
             break;
         default:
             *eax = 0;
             *ebx = 0;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
         }
 
         assert(!(*eax & ~0x1f));
@@ -6453,22 +6453,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
             *eax = apicid_die_offset(&topo_info);
             *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_CORE << 8;
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = threads_per_pkg;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_DIE << 8;
             break;
         default:
             *eax = 0;
             *ebx = 0;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_INVALID << 8;
         }
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
-- 
2.45.1


