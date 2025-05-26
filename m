Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39722C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTXP-00036A-My; Mon, 26 May 2025 04:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uJTXN-00035r-2J
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:50:25 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uJTXI-0007RG-Om
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:50:24 -0400
X-ASG-Debug-ID: 1748249404-086e236c19149820001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id 91fihcvXfPo7Av6h (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 26 May 2025 16:50:04 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 26 May
 2025 16:50:04 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Mon, 26 May 2025
 16:50:04 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 26 May
 2025 16:35:54 +0800
Message-ID: <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
Date: Mon, 26 May 2025 16:35:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>
X-ASG-Orig-Subj: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved
 for Intel
CC: Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, "Tejus
 GK" <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <20250423114702.1529340-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 5/26/2025 4:50:02 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1748249404
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 8731
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.141939
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 4/23/25 7:46 PM, Zhao Liu wrote:
> 
> Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
> "assert" check blocks adding new cache model for non-AMD CPUs.
> 
> Therefore, check the vendor and encode this leaf as all-0 for Intel
> CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
> check for Zhaoxin as well.
> 
> Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
> information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
> For this case, there is no need to tweak for non-AMD CPUs, because
> vendor_cpuid_only has been turned on by default since PC machine v6.1.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/cpu.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1b64ceaaba46..8fdafa8aedaf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7248,11 +7248,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
>           break;
>       case 0x80000005:
> -        /* cache info (L1 cache) */
> -        if (cpu->cache_info_passthrough) {
> +        /*
> +         * cache info (L1 cache)
> +         *
> +         * For !vendor_cpuid_only case, non-AMD CPU would get the wrong
> +         * information, i.e., get AMD's cache model. It doesn't matter,
> +         * vendor_cpuid_only has been turned on by default since
> +         * PC machine v6.1.
> +         */
> +        if (cpu->vendor_cpuid_only &&
> +            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> +            *eax = *ebx = *ecx = *edx = 0;
> +            break;
> +        } else if (cpu->cache_info_passthrough) {
>               x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
>               break;
>           }
> +
>           *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
>                  (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>           *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |

I've reviewed the cache-related CPUID path and noticed an oddity: every AMD vCPU 
model still reports identical hard-coded values for the L1 ITLB and L1 DTLB 
fields in leaf 0x8000_0005. Your patch fixes this for Intel(and Zhaoxin), but 
all AMD models continue to receive the same constants in EAX/EBX.

Do you know the reason for this choice? Is the guest expected to ignore those L1 
TLB numbers? If so, I'll prepare a patch that adjusts only the Zhaoxin defaults 
in leaf 0x8000_0005 like below, matching real YongFeng behaviour in ecx and edx, 
but keep eax and ebx following AMD's behaviour.

## Notes
1. Changes tied to "-machine smp-cache xxx" (mainly 
x86_cpu_update_smp_cache_topo()) are not included here.
2. Do you think I need Zhaoxin-specific legacy_l1d/l1i/l2/l3_cache helpers? If 
yes, I'll add them with YongFeng sillicon topology data.

--- patch prototype start ---

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7b223642ba..8a17e5ffe9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2726,6 +2726,66 @@ static const CPUCaches xeon_srf_cache_info = {
      },
  };

+static const CPUCaches yongfeng_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .inclusive = false,
+        .self_init = true,
+        .no_invd_sharing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .inclusive = false,
+        .self_init = true,
+        .no_invd_sharing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 256 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 512,
+        .lines_per_tag = 1,
+        .inclusive = true,
+        .self_init = true,
+        .no_invd_sharing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
  /* The following VMX features are not supported by KVM and are left out in the
   * CPU definitions:
   *
@@ -5928,6 +5988,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                      { /* end of list */ }
                  }
              },
+            {
+                .version = 3,
+                .note = "wiith the correct model number and cache info",
+                .props = (PropValue[]) {
+                    { "model", "0x5b" },
+                    { /* end of list */ }
+                },
+                .cache_info = &yongfeng_cache_info
+            },
              { /* end of list */ }
          }
      },
@@ -7565,8 +7634,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, 
uint32_t count,
           * vendor_cpuid_only has been turned on by default since
           * PC machine v6.1.
           */
-        if (cpu->vendor_cpuid_only &&
-            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+        if (cpu->vendor_cpuid_only && IS_INTEL_CPU(env)) {
              *eax = *ebx = *ecx = *edx = 0;
              break;
          } else if (cpu->cache_info_passthrough) {
@@ -7578,8 +7646,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, 
uint32_t count,
                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
          *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
-        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
-        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
+
+        if (IS_AMD_CPU(env)) {
+            *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
+            *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
+            break;
+        }
+        /* Zhaoxin follows AMD behaviour on leaf 0x8000_0005 */
+        if (IS_ZHAOXIN_CPU(env)) {
+            *ecx = encode_cache_cpuid80000005(env->cache_info_zhaoxin.l1d_cache);
+            *edx = encode_cache_cpuid80000005(env->cache_info_zhaoxin.l1i_cache);
+            break;
+        }
+
+        /* Other vendors */
+        *eax = *ebx = *ecx = *edx = 0;
          break;
      case 0x80000006:
          /* cache info (L2 cache) */
@@ -8638,7 +8719,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
              return;
          }
          env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
-            *cache_info;
+            env->cache_info_zhaoxin = *cache_info;
      } else {
          /* Build legacy cache information */
          env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
@@ -8655,6 +8736,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
          env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
          env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
          env->cache_info_amd.l3_cache = &legacy_l3_cache;
+
+        env->cache_info_zhaoxin.l1d_cache = &legacy_l1d_cache;
+        env->cache_info_zhaoxin.l1i_cache = &legacy_l1i_cache;
+        env->cache_info_zhaoxin.l2_cache = &legacy_l2_cache;
+        env->cache_info_zhaoxin.l3_cache = &legacy_l3_cache;
      }

  #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d98c9ba282..46bfd6f6b0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2062,6 +2062,7 @@ typedef struct CPUArchState {
       * with old QEMU versions.
       */
      CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
+    CPUCaches cache_info_zhaoxin;

      /* MTRRs */
      uint64_t mtrr_fixed[11];





