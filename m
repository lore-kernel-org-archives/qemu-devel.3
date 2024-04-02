Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B841CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrY9d-0004HA-1s; Tue, 02 Apr 2024 03:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rrY9a-0004Fw-BS; Tue, 02 Apr 2024 03:01:54 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rrY9X-0006hi-83; Tue, 02 Apr 2024 03:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712041306; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=BHwh/deAZvnxN56/l+z1N1vpB38fM1rZx3fZq6hMk14=;
 b=VEzZ25e68jZ1ihKfpipdHkUBV0KvP3xqS4fVuDYhgDNj/ztOgMfxb+a+DQ2rClbEQAdYiBKtg3z5eWgRD1pfc4huyXdGhRjES8ziXTtG0knyFu3z0pcEOSdKHpzQ7U9snLZiiKuP+IcS/IjZUpy5kYYckb9mW1CaX49kE/+ESMg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W3nUxi1_1712041304; 
Received: from 30.21.185.194(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W3nUxi1_1712041304) by smtp.aliyun-inc.com;
 Tue, 02 Apr 2024 15:01:45 +0800
Content-Type: multipart/alternative;
 boundary="------------nXL00O2eTBSflkMHoorP9OG2"
Message-ID: <7ca1c941-8980-4ff7-b2aa-1aacfbba569a@linux.alibaba.com>
Date: Tue, 2 Apr 2024 15:01:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Fix the element agnostic function problem
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
From: Huang Tao <eric.huang@linux.alibaba.com>
In-Reply-To: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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
--------------nXL00O2eTBSflkMHoorP9OG2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is a ping to the patch below.

https://patchew.org/QEMU/20240325021654.6594-1-eric.huang@linux.alibaba.com/ 


On 2024/3/25 10:16, Huang Tao wrote:
> In RVV and vcrypto instructions, the masked and tail elements are set to 1s
> using vext_set_elems_1s function if the vma/vta bit is set. It is the element
> agnostic policy.
>
> However, this function can't deal the big endian situation. This patch fixes
> the problem by adding handling of such case.
>
> Signed-off-by: Huang Tao<eric.huang@linux.alibaba.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Reviewed-by: LIU Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
> Changes in v3:
> - use "if (HOST_BIG_ENDIAN)" instead of "#if HOST_BIG_ENDIAN"
>
> Changes in v2:
> - Keep the api of vext_set_elems_1s
> - Reduce the number of patches.
> ---
>   target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
> index 12f5964fbb..36635a1138 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
>       if (tot - cnt == 0) {
>           return ;
>       }
> +
> +    if (HOST_BIG_ENDIAN) {
> +        /*
> +         * Deal the situation when the elements are insdie
> +         * only one uint64 block including setting the
> +         * masked-off element.
> +         */
> +        if (((tot - 1) ^ cnt) < 8) {
> +            memset(base + H1(tot - 1), -1, tot - cnt);
> +            return;
> +        }
> +        /*
> +         * Otherwise, at least cross two uint64_t blocks.
> +         * Set first unaligned block.
> +         */
> +        if (cnt % 8 != 0) {
> +            uint32_t j = ROUND_UP(cnt, 8);
> +            memset(base + H1(j - 1), -1, j - cnt);
> +            cnt = j;
> +        }
> +        /* Set other 64bit aligend blocks */
> +    }
>       memset(base + cnt, -1, tot - cnt);
>   }
>   
--------------nXL00O2eTBSflkMHoorP9OG2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span
style="caret-color: rgb(33, 37, 41); color: rgb(33, 37, 41); font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, monospace; font-size: 14px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration: none; display: inline !important; float: none;">This is a ping to the patch below.</span></p>
    <p><span
style="caret-color: rgb(33, 37, 41); color: rgb(33, 37, 41); font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, monospace; font-size: 14px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: pre; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration: none; display: inline !important; float: none;"><a class="moz-txt-link-freetext" href="https://patchew.org/QEMU/20240325021654.6594-1-eric.huang@linux.alibaba.com/">https://patchew.org/QEMU/20240325021654.6594-1-eric.huang@linux.alibaba.com/</a>
</span></p>
    <div class="moz-cite-prefix">On 2024/3/25 10:16, Huang Tao wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240325021654.6594-1-eric.huang@linux.alibaba.com">
      <pre class="moz-quote-pre" wrap="">In RVV and vcrypto instructions, the masked and tail elements are set to 1s
using vext_set_elems_1s function if the vma/vta bit is set. It is the element
agnostic policy.

However, this function can't deal the big endian situation. This patch fixes
the problem by adding handling of such case.

Signed-off-by: Huang Tao <a class="moz-txt-link-rfc2396E" href="mailto:eric.huang@linux.alibaba.com">&lt;eric.huang@linux.alibaba.com&gt;</a>
Suggested-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
Reviewed-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
---
Changes in v3:
- use "if (HOST_BIG_ENDIAN)" instead of "#if HOST_BIG_ENDIAN"

Changes in v2:
- Keep the api of vext_set_elems_1s
- Reduce the number of patches.
---
 target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 12f5964fbb..36635a1138 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
     if (tot - cnt == 0) {
         return ;
     }
+
+    if (HOST_BIG_ENDIAN) {
+        /*
+         * Deal the situation when the elements are insdie
+         * only one uint64 block including setting the
+         * masked-off element.
+         */
+        if (((tot - 1) ^ cnt) &lt; 8) {
+            memset(base + H1(tot - 1), -1, tot - cnt);
+            return;
+        }
+        /*
+         * Otherwise, at least cross two uint64_t blocks.
+         * Set first unaligned block.
+         */
+        if (cnt % 8 != 0) {
+            uint32_t j = ROUND_UP(cnt, 8);
+            memset(base + H1(j - 1), -1, j - cnt);
+            cnt = j;
+        }
+        /* Set other 64bit aligend blocks */
+    }
     memset(base + cnt, -1, tot - cnt);
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------nXL00O2eTBSflkMHoorP9OG2--

