Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73989C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Uv9-00076x-5z; Mon, 13 May 2024 08:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Uv6-00074X-0P; Mon, 13 May 2024 08:36:44 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Uv0-00055X-CG; Mon, 13 May 2024 08:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715603786; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=2QQ2fNmmv6JvHJczTVLxsBOIzDXJdhvrb4eu1nq9fEw=;
 b=v+DVntBnshueOJYfP1OluTlh2mGopi8D/pbV+8SdPBYaQUOn7BJXadaU1mR6dir8h1JnLiwevkr7Ev4xwJMX4gNl5m7TTdfXAvET6f3psdnbGM1QmfmseCrpYXmreVz+E87TXP1ScW3RtSdctwFL4gb8zReHtZQR3leXJMAF9Zc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W6QUXRp_1715603783; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6QUXRp_1715603783) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 20:36:24 +0800
Content-Type: multipart/alternative;
 boundary="------------kvDv8Xha1E9KcNpvyJ4BjWZp"
Message-ID: <58fe0789-4f1b-4c13-bab9-977c18787095@linux.alibaba.com>
Date: Mon, 13 May 2024 20:35:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-4-me@deliversmonkey.space>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240511101053.1875596-4-me@deliversmonkey.space>
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------kvDv8Xha1E9KcNpvyJ4BjWZp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/5/11 18:10, Alexey Baturo wrote:
> From: Alexey Baturo<baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo<baturo.alexey@gmail.com>
>
> Reviewed-by: Alistair Francis<alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h        |  5 ++++
>   target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 63 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 52b6ba73c8..9cac723b19 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -698,8 +698,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>   
>   bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm);
> +
>   RISCVException riscv_csrr(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value);
> +
>   RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                              target_ulong *ret_value,
>                              target_ulong new_value, target_ulong write_mask);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bf58350669..e4a127ca84 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -142,6 +142,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       *pflags = flags;
>   }
>   
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)

I think we should process XLEN here.

Pack *XL32 into PMM_FIELD_DISABLED

Zhiwei
> +{
> +    int pmm = 0;
> +#ifndef CONFIG_USER_ONLY
> +    int priv_mode = cpu_address_mode(env);
> +    /* Get current PMM field */
> +    switch (priv_mode) {
> +    case PRV_M:
> +        pmm = riscv_cpu_cfg(env)->ext_smmpm ?
> +                  get_field(env->mseccfg, MSECCFG_PMM) : PMM_FIELD_DISABLED;
> +        break;
> +    case PRV_S:
> +        pmm = riscv_cpu_cfg(env)->ext_smnpm ?
> +                  get_field(env->menvcfg, MENVCFG_PMM) : PMM_FIELD_DISABLED;
> +        break;
> +    case PRV_U:
> +        pmm = riscv_cpu_cfg(env)->ext_ssnpm ?
> +                  get_field(env->senvcfg, SENVCFG_PMM) : PMM_FIELD_DISABLED;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +    return pmm;
> +}
> +
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +{
> +    bool virt_mem_en = false;
> +#ifndef CONFIG_USER_ONLY
> +    int satp_mode = 0;
> +    int priv_mode = cpu_address_mode(env);
> +    /* Get current PMM field */
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        satp_mode = get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode = get_field(env->satp, SATP64_MODE);
> +    }
> +    virt_mem_en = ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
> +#endif
> +    return virt_mem_en;
> +}
> +
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm)
> +{
> +    switch (pmm) {
> +    case PMM_FIELD_DISABLED:
> +        return 0;
> +    case PMM_FIELD_PMLEN7:
> +        return 7;
> +    case PMM_FIELD_PMLEN16:
> +        return 16;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   
>   /*
--------------kvDv8Xha1E9KcNpvyJ4BjWZp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024/5/11 18:10, Alexey Baturo
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240511101053.1875596-4-me@deliversmonkey.space">
      <pre class="moz-quote-pre" wrap="">From: Alexey Baturo <a class="moz-txt-link-rfc2396E" href="mailto:baturo.alexey@gmail.com">&lt;baturo.alexey@gmail.com&gt;</a>

Signed-off-by: Alexey Baturo <a class="moz-txt-link-rfc2396E" href="mailto:baturo.alexey@gmail.com">&lt;baturo.alexey@gmail.com&gt;</a>

Reviewed-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
---
 target/riscv/cpu.h        |  5 ++++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 52b6ba73c8..9cac723b19 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -698,8 +698,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+int riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bf58350669..e4a127ca84 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -142,6 +142,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)</pre>
    </blockquote>
    <p>I think we should process XLEN here.</p>
    <p>Pack *XL32 into <span style="white-space: pre-wrap">PMM_FIELD_DISABLED</span></p>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:20240511101053.1875596-4-me@deliversmonkey.space">
      <pre class="moz-quote-pre" wrap="">
+{
+    int pmm = 0;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        pmm = riscv_cpu_cfg(env)-&gt;ext_smmpm ?
+                  get_field(env-&gt;mseccfg, MSECCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_S:
+        pmm = riscv_cpu_cfg(env)-&gt;ext_smnpm ?
+                  get_field(env-&gt;menvcfg, MENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_U:
+        pmm = riscv_cpu_cfg(env)-&gt;ext_ssnpm ?
+                  get_field(env-&gt;senvcfg, SENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+    return pmm;
+}
+
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+{
+    bool virt_mem_en = false;
+#ifndef CONFIG_USER_ONLY
+    int satp_mode = 0;
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        satp_mode = get_field(env-&gt;satp, SATP32_MODE);
+    } else {
+        satp_mode = get_field(env-&gt;satp, SATP64_MODE);
+    }
+    virt_mem_en = ((satp_mode != VM_1_10_MBARE) &amp;&amp; (priv_mode != PRV_M));
+#endif
+    return virt_mem_en;
+}
+
+int riscv_pm_get_pmlen(RISCVPmPmm pmm)
+{
+    switch (pmm) {
+    case PMM_FIELD_DISABLED:
+        return 0;
+    case PMM_FIELD_PMLEN7:
+        return 7;
+    case PMM_FIELD_PMLEN16:
+        return 16;
+    default:
+        g_assert_not_reached();
+    }
+    return -1;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /*
</pre>
    </blockquote>
  </body>
</html>

--------------kvDv8Xha1E9KcNpvyJ4BjWZp--

