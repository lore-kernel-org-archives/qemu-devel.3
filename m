Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D3BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 07:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFnb-0006m1-UH; Mon, 15 Jul 2024 03:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sTFnZ-0006hx-4Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 03:07:02 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sTFnS-0007po-Sk
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 03:07:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso3145484b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721027212; x=1721632012; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a8NxC1RPj4/Hvmst0dhz29gq52jpQTH6w94ibqvyQ4=;
 b=WmJ93eHRQ7/HV8sRfMqW1+tpRnOHe04jvP+9p9pSV4lHfScaftEX260X1vORoE5sp5
 znFpqtHM6Azs8FEmTCr0a1Vf+QEXeU/84ChsvQ6y7i8NYil5AaJgKLHg+c2l+qzRSR2I
 dM/ejfwtVHeko4kLASkLodALmnXWhc02jPE8BhR33T/XFItXhJ6sm4w6L+e5lxX6K4i9
 KXlnlz8wCSEcohpiDYCYE8LtZZjgqJDMFk4OmILNnKbVRvUFHyRMFaw0okUf8N6jfDkU
 CGxCjbyXyor1iyPEGxVn9cvI18fXDAqrevIwvF/htF2Kwa9xXmXqBFD6nVysi3H4fF4u
 x9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721027212; x=1721632012;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3a8NxC1RPj4/Hvmst0dhz29gq52jpQTH6w94ibqvyQ4=;
 b=mhJPJnsaj7c12EkEL/JTrVhS2aUHSCdgkP70/FBSHm+YhddXWjGwyEATa4Ctp1eSJH
 FHwJ2AQgg+6ML9p/ZiRnT7owkA3/2TO+s99uYen0Sr0hWON6Pam5mPyCnDVBnCqGtT39
 zqu1+5Sgj2l9icranBxIgHmH+r8qmlUzrMeE1hIAWd9SIa8jxmz3KV1qHQwmwvp7IScq
 uWa0h5G5EnGeE7IHDrM+KPuCspUaDpij+RKi5sczTHOur/Y/nQOr7gro7IJxTTwYLqSn
 Q3DUnI43b4FeFzJc4rNMaKidmRmGTCV/q0I4du6OR2THdzW/v28gK1YOTW7FXjS5L5m+
 ig3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtH7bv2tWhkNIsXWQaTCeymaFggqtUMunIeHKTjKy9tFgs/ZMSNNufQQZvPqopsWJmIcqCp12kRgLM7Na/yG1ExHnELeQ=
X-Gm-Message-State: AOJu0YytKIUrZuE+PRgh0ofCgC6KGNqE1nVN5HgSqNq0AyED1u4D3+WE
 a9gvtx5bnVAEUBTb278/mKF+t+yn5YuJyChJ5tz/dfYOy8uEOGXJB3x6dOyP2k0=
X-Google-Smtp-Source: AGHT+IGb4cK/tKJus7NsI5GOsdw6iCfgyzrxb0w886qPyf+1cjvLwD9cyYSVcWDcMfseVgSn1HuNCA==
X-Received: by 2002:a05:6a21:2d0b:b0:1c2:9288:b93a with SMTP id
 adf61e73a8af0-1c298243862mr26793273637.37.1721027212027; 
 Mon, 15 Jul 2024 00:06:52 -0700 (PDT)
Received: from [100.64.0.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc27264sm33575435ad.165.2024.07.15.00.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 00:06:51 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------o5XUj0HN2PwvfsfpASeNMDZx"
Message-ID: <5a83ce12-9a9c-4c9d-9fee-e37fb6afd19d@sifive.com>
Date: Mon, 15 Jul 2024 15:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] target/riscv: Simplify probing in vext_ldff
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-14-richard.henderson@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20240710032814.104643-14-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
--------------o5XUj0HN2PwvfsfpASeNMDZx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/10 11:28 AM, Richard Henderson wrote:
> The current pairing of tlb_vaddr_to_host with extra is either
> inefficient (user-only, with page_check_range) or incorrect
> (system, with probe_pages).
>
> For proper non-fault behaviour, use probe_access_flags with
> its nonfault parameter set to true.
>
> Signed-off-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   target/riscv/vector_helper.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1b4d5a8e37..4d72eb74d3 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -474,7 +474,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>             vext_ldst_elem_fn *ldst_elem,
>             uint32_t log2_esz, uintptr_t ra)
>   {
> -    void *host;
>       uint32_t i, k, vl = 0;
>       uint32_t nf = vext_nf(desc);
>       uint32_t vm = vext_vm(desc);
> @@ -493,27 +492,31 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>           }
>           addr = adjust_addr(env, base + i * (nf << log2_esz));
>           if (i == 0) {
> +            /* Allow fault on first element. */
>               probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
>           } else {
> -            /* if it triggers an exception, no need to check watchpoint */
>               remain = nf << log2_esz;
>               while (remain > 0) {
> +                void *host;
> +                int flags;
> +
>                   offset = -(addr | TARGET_PAGE_MASK);
> -                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_index);
> -                if (host) {
> -#ifdef CONFIG_USER_ONLY
> -                    if (!page_check_range(addr, offset, PAGE_READ)) {
> -                        vl = i;
> -                        goto ProbeSuccess;
> -                    }
> -#else
> -                    probe_pages(env, addr, offset, ra, MMU_DATA_LOAD);
> -#endif
> -                } else {
> +
> +                /* Probe nonfault on subsequent elements. */
> +                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
> +                                           mmu_index, true, &host, 0);
> +                if (flags) {
According to the section 7.7. Unit-stride Fault-Only-First Loads in the 
v spec (v1.0)

      When the fault-only-first instruction would trigger a debug 
data-watchpoint trap on an element after the first,
      implementations should not reduce vl but instead should trigger 
the debug trap as otherwise the event might be lost.

I think that we need to filter out the watchpoint bit in the flag here 
liked below.
+ if (flags & ~TLB_WATCHPOINT) {


> +                    /*
> +                     * Stop any flag bit set:
> +                     *   invalid (unmapped)
> +                     *   mmio (transaction failed)
> +                     *   watchpoint (debug)
> +                     * In all cases, handle as the first load next time.
> +                     */
>                       vl = i;
> -                    goto ProbeSuccess;
> +                    break;
This break will just break the while loop, so the outside for loop will 
continue checking the following elements that we may get unexpected vl.


>                   }
> -                if (remain <=  offset) {
> +                if (remain <= offset) {
>                       break;
>                   }
>                   remain -= offset;
> @@ -521,7 +524,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>               }
>           }
>       }
> -ProbeSuccess:
>       /* load bytes from guest memory */
>       if (vl != 0) {
>           env->vl = vl;


Thanks for this series patch set, I’m trying to rebase the RVV 
optimization RFC patch set to this series then optimize the vext_ldff part.
And I think that there is a potential issue in the original 
implementation that maybe we can fix in this patch.

We need to assign the correct element load size to the 
probe_access_internal function called by tlb_vaddr_to_host in original 
implementation or is called directly in this patch.
The size parameter will be used by the pmp_hart_has_privs function to do 
the physical memory protection (PMP) checking.
If we set the size parameter to the remain page size, we may get 
unexpected trap caused by the PMP rules that covered the regions of 
masked-off elements.

Maybe we can replace the while loop liked below.


vext_ldff(void *vd, void *v0, target_ulong base,
           ...
{
     ...
     uint32_t size = nf << log2_esz;

     VSTART_CHECK_EARLY_EXIT(env);

     /* probe every access */
     for (i = env->vstart; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         addr = adjust_addr(env, base + i * size);
         if (i == 0) {
             probe_pages(env, addr, size, ra, MMU_DATA_LOAD);
         } else {
             /* if it triggers an exception, no need to check watchpoint */
             void *host;
             int flags;

             /* Probe nonfault on subsequent elements. */
             flags = probe_access_flags(env, addr, size, MMU_DATA_LOAD,
                     mmu_index, true, &host, 0);
             if (flags & ~TLB_WATCHPOINT) {
                 /*
                  * Stop any flag bit set:
                  *   invalid (unmapped)
                  *   mmio (transaction failed)
                  * In all cases, handle as the first load next time.
                  */
                 vl = i;
                 break;
             }
         }
     }

     /* load bytes from guest memory */
     if (vl != 0) {
         env->vl = vl;
     }
     ...
}


--------------o5XUj0HN2PwvfsfpASeNMDZx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+DQo8aHRtbD4NCiAgPGhlYWQ+DQogICAgPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPg0K
ICA8L2hlYWQ+DQogIDxib2R5Pg0KICAgIE9uIDIwMjQvNy8xMCAxMToyOCBBTSwgUmljaGFy
ZCBIZW5kZXJzb24gd3JvdGU6DQogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSINCiAgICAg
IGNpdGU9Im1pZDoyMDI0MDcxMDAzMjgxNC4xMDQ2NDMtMTQtcmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZyI+DQogICAgICA8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJlIiB3cmFwPSIi
PlRoZSBjdXJyZW50IHBhaXJpbmcgb2YgdGxiX3ZhZGRyX3RvX2hvc3Qgd2l0aCBleHRyYSBp
cyBlaXRoZXINCmluZWZmaWNpZW50ICh1c2VyLW9ubHksIHdpdGggcGFnZV9jaGVja19yYW5n
ZSkgb3IgaW5jb3JyZWN0DQooc3lzdGVtLCB3aXRoIHByb2JlX3BhZ2VzKS4NCg0KRm9yIHBy
b3BlciBub24tZmF1bHQgYmVoYXZpb3VyLCB1c2UgcHJvYmVfYWNjZXNzX2ZsYWdzIHdpdGgN
Cml0cyBub25mYXVsdCBwYXJhbWV0ZXIgc2V0IHRvIHRydWUuDQoNClNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgSGVuZGVyc29uIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstcmZjMjM5NkUiIGhy
ZWY9Im1haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIj4mbHQ7cmljaGFyZC5o
ZW5kZXJzb25AbGluYXJvLm9yZyZndDs8L2E+DQotLS0NCiB0YXJnZXQvcmlzY3YvdmVjdG9y
X2hlbHBlci5jIHwgMzQgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL3RhcmdldC9yaXNjdi92ZWN0b3JfaGVscGVyLmMgYi90YXJnZXQvcmlzY3Yv
dmVjdG9yX2hlbHBlci5jDQppbmRleCAxYjRkNWE4ZTM3Li40ZDcyZWI3NGQzIDEwMDY0NA0K
LS0tIGEvdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9oZWxwZXIuYw0KKysrIGIvdGFyZ2V0L3Jpc2N2
L3ZlY3Rvcl9oZWxwZXIuYw0KQEAgLTQ3NCw3ICs0NzQsNiBAQCB2ZXh0X2xkZmYodm9pZCAq
dmQsIHZvaWQgKnYwLCB0YXJnZXRfdWxvbmcgYmFzZSwNCiAgICAgICAgICAgdmV4dF9sZHN0
X2VsZW1fZm4gKmxkc3RfZWxlbSwNCiAgICAgICAgICAgdWludDMyX3QgbG9nMl9lc3osIHVp
bnRwdHJfdCByYSkNCiB7DQotICAgIHZvaWQgKmhvc3Q7DQogICAgIHVpbnQzMl90IGksIGss
IHZsID0gMDsNCiAgICAgdWludDMyX3QgbmYgPSB2ZXh0X25mKGRlc2MpOw0KICAgICB1aW50
MzJfdCB2bSA9IHZleHRfdm0oZGVzYyk7DQpAQCAtNDkzLDI3ICs0OTIsMzEgQEAgdmV4dF9s
ZGZmKHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0X3Vsb25nIGJhc2UsDQogICAgICAgICB9
DQogICAgICAgICBhZGRyID0gYWRqdXN0X2FkZHIoZW52LCBiYXNlICsgaSAqIChuZiAmbHQ7
Jmx0OyBsb2cyX2VzeikpOw0KICAgICAgICAgaWYgKGkgPT0gMCkgew0KKyAgICAgICAgICAg
IC8qIEFsbG93IGZhdWx0IG9uIGZpcnN0IGVsZW1lbnQuICovDQogICAgICAgICAgICAgcHJv
YmVfcGFnZXMoZW52LCBhZGRyLCBuZiAmbHQ7Jmx0OyBsb2cyX2VzeiwgcmEsIE1NVV9EQVRB
X0xPQUQpOw0KICAgICAgICAgfSBlbHNlIHsNCi0gICAgICAgICAgICAvKiBpZiBpdCB0cmln
Z2VycyBhbiBleGNlcHRpb24sIG5vIG5lZWQgdG8gY2hlY2sgd2F0Y2hwb2ludCAqLw0KICAg
ICAgICAgICAgIHJlbWFpbiA9IG5mICZsdDsmbHQ7IGxvZzJfZXN6Ow0KICAgICAgICAgICAg
IHdoaWxlIChyZW1haW4gJmd0OyAwKSB7DQorICAgICAgICAgICAgICAgIHZvaWQgKmhvc3Q7
DQorICAgICAgICAgICAgICAgIGludCBmbGFnczsNCisNCiAgICAgICAgICAgICAgICAgb2Zm
c2V0ID0gLShhZGRyIHwgVEFSR0VUX1BBR0VfTUFTSyk7DQotICAgICAgICAgICAgICAgIGhv
c3QgPSB0bGJfdmFkZHJfdG9faG9zdChlbnYsIGFkZHIsIE1NVV9EQVRBX0xPQUQsIG1tdV9p
bmRleCk7DQotICAgICAgICAgICAgICAgIGlmIChob3N0KSB7DQotI2lmZGVmIENPTkZJR19V
U0VSX09OTFkNCi0gICAgICAgICAgICAgICAgICAgIGlmICghcGFnZV9jaGVja19yYW5nZShh
ZGRyLCBvZmZzZXQsIFBBR0VfUkVBRCkpIHsNCi0gICAgICAgICAgICAgICAgICAgICAgICB2
bCA9IGk7DQotICAgICAgICAgICAgICAgICAgICAgICAgZ290byBQcm9iZVN1Y2Nlc3M7DQot
ICAgICAgICAgICAgICAgICAgICB9DQotI2Vsc2UNCi0gICAgICAgICAgICAgICAgICAgIHBy
b2JlX3BhZ2VzKGVudiwgYWRkciwgb2Zmc2V0LCByYSwgTU1VX0RBVEFfTE9BRCk7DQotI2Vu
ZGlmDQotICAgICAgICAgICAgICAgIH0gZWxzZSB7DQorDQorICAgICAgICAgICAgICAgIC8q
IFByb2JlIG5vbmZhdWx0IG9uIHN1YnNlcXVlbnQgZWxlbWVudHMuICovDQorICAgICAgICAg
ICAgICAgIGZsYWdzID0gcHJvYmVfYWNjZXNzX2ZsYWdzKGVudiwgYWRkciwgb2Zmc2V0LCBN
TVVfREFUQV9MT0FELA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtbXVfaW5kZXgsIHRydWUsICZhbXA7aG9zdCwgMCk7DQorICAgICAgICAgICAgICAg
IGlmIChmbGFncykgezwvcHJlPg0KICAgIDwvYmxvY2txdW90ZT4NCiAgICBBY2NvcmRpbmcg
dG8gdGhlIHNlY3Rpb24gNy43LiBVbml0LXN0cmlkZSBGYXVsdC1Pbmx5LUZpcnN0IExvYWRz
IGluDQogICAgdGhlIHYgc3BlYyAodjEuMCk8YnI+DQogICAgPGJyPg0KICAgIMKgwqAgwqAg
V2hlbiB0aGUgZmF1bHQtb25seS0AZmlyc3QgaW5zdHJ1Y3Rpb24gd291bGQgdHJpZ2dlciBh
IGRlYnVnDQogICAgZGF0YS13YXRjaHBvaW50IHRyYXAgb24gYW4gZWxlbWVudCBhZnRlciB0
aGUgAGZpcnN0LDxicj4NCiAgICDCoMKgwqDCoCBpbXBsZW1lbnRhdGlvbnMgc2hvdWxkIG5v
dCByZWR1Y2UgdmwgYnV0IGluc3RlYWQgc2hvdWxkIHRyaWdnZXINCiAgICB0aGUgZGVidWcg
dHJhcCBhcyBvdGhlcndpc2UgdGhlIGV2ZW50IG1pZ2h0IGJlIGxvc3QuPGJyPg0KICAgIDxi
cj4NCiAgICBJIHRoaW5rIHRoYXQgd2UgbmVlZCB0byBmaWx0ZXIgb3V0IHRoZSB3YXRjaHBv
aW50IGJpdCBpbiB0aGUgZmxhZw0KICAgIGhlcmUgbGlrZWQgYmVsb3cuPGJyPg0KICAgIDxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTogcHJlLXdyYXAiPisgICAgICAgICAgICAgICAgaWYg
KGZsYWdzICZhbXA7IH5UTEJfV0FUQ0hQT0lOVCkgezwvc3Bhbj4NCiAgICA8cD48YnI+DQog
ICAgPC9wPg0KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiDQogICAgICBjaXRlPSJtaWQ6
MjAyNDA3MTAwMzI4MTQuMTA0NjQzLTE0LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmci
Pg0KICAgICAgPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj4NCisgICAgICAg
ICAgICAgICAgICAgIC8qDQorICAgICAgICAgICAgICAgICAgICAgKiBTdG9wIGFueSBmbGFn
IGJpdCBzZXQ6DQorICAgICAgICAgICAgICAgICAgICAgKiAgIGludmFsaWQgKHVubWFwcGVk
KQ0KKyAgICAgICAgICAgICAgICAgICAgICogICBtbWlvICh0cmFuc2FjdGlvbiBmYWlsZWQp
DQorICAgICAgICAgICAgICAgICAgICAgKiAgIHdhdGNocG9pbnQgKGRlYnVnKQ0KKyAgICAg
ICAgICAgICAgICAgICAgICogSW4gYWxsIGNhc2VzLCBoYW5kbGUgYXMgdGhlIGZpcnN0IGxv
YWQgbmV4dCB0aW1lLg0KKyAgICAgICAgICAgICAgICAgICAgICovDQogICAgICAgICAgICAg
ICAgICAgICB2bCA9IGk7DQotICAgICAgICAgICAgICAgICAgICBnb3RvIFByb2JlU3VjY2Vz
czsNCisgICAgICAgICAgICAgICAgICAgIGJyZWFrOzwvcHJlPg0KICAgIDwvYmxvY2txdW90
ZT4NCiAgICBUaGlzIGJyZWFrIHdpbGwganVzdCBicmVhayB0aGUgd2hpbGUgbG9vcCwgc28g
dGhlIG91dHNpZGUgZm9yIGxvb3ANCiAgICB3aWxsIGNvbnRpbnVlIGNoZWNraW5nIHRoZSBm
b2xsb3dpbmcgZWxlbWVudHMgdGhhdCB3ZSBtYXkgZ2V0DQogICAgdW5leHBlY3RlZCB2bC4N
CiAgICA8cD48YnI+DQogICAgPC9wPg0KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiDQog
ICAgICBjaXRlPSJtaWQ6MjAyNDA3MTAwMzI4MTQuMTA0NjQzLTE0LXJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmciPg0KICAgICAgPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3Jh
cD0iIj4NCiAgICAgICAgICAgICAgICAgfQ0KLSAgICAgICAgICAgICAgICBpZiAocmVtYWlu
ICZsdDs9ICBvZmZzZXQpIHsNCisgICAgICAgICAgICAgICAgaWYgKHJlbWFpbiAmbHQ7PSBv
ZmZzZXQpIHsNCiAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICAgICAgICAg
ICB9DQogICAgICAgICAgICAgICAgIHJlbWFpbiAtPSBvZmZzZXQ7DQpAQCAtNTIxLDcgKzUy
NCw2IEBAIHZleHRfbGRmZih2b2lkICp2ZCwgdm9pZCAqdjAsIHRhcmdldF91bG9uZyBiYXNl
LA0KICAgICAgICAgICAgIH0NCiAgICAgICAgIH0NCiAgICAgfQ0KLVByb2JlU3VjY2VzczoN
CiAgICAgLyogbG9hZCBieXRlcyBmcm9tIGd1ZXN0IG1lbW9yeSAqLw0KICAgICBpZiAodmwg
IT0gMCkgew0KICAgICAgICAgZW52LSZndDt2bCA9IHZsOzwvcHJlPg0KICAgIDwvYmxvY2tx
dW90ZT4NCiAgICA8cD48YnI+DQogICAgPC9wPg0KICAgIFRoYW5rcyBmb3IgdGhpcyBzZXJp
ZXMgcGF0Y2ggc2V0LCBJ4oCZbSB0cnlpbmcgdG8gcmViYXNlIHRoZSBSVlYNCiAgICBvcHRp
bWl6YXRpb24gUkZDIHBhdGNoIHNldCB0byB0aGlzIHNlcmllcyB0aGVuIG9wdGltaXplIHRo
ZQ0KICAgIHZleHRfbGRmZiBwYXJ0Ljxicj4NCiAgICBBbmQgSSB0aGluayB0aGF0IHRoZXJl
IGlzIGEgcG90ZW50aWFsIGlzc3VlIGluIHRoZSBvcmlnaW5hbA0KICAgIGltcGxlbWVudGF0
aW9uIHRoYXQgbWF5YmUgd2UgY2FuIGZpeCBpbiB0aGlzIHBhdGNoLjxicj4NCiAgICA8YnI+
DQogICAgV2UgbmVlZCB0byBhc3NpZ24gdGhlIGNvcnJlY3QgZWxlbWVudCBsb2FkIHNpemUg
dG8gdGhlDQogICAgcHJvYmVfYWNjZXNzX2ludGVybmFsIGZ1bmN0aW9uIGNhbGxlZCBieSB0
bGJfdmFkZHJfdG9faG9zdCBpbg0KICAgIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIG9yIGlz
IGNhbGxlZCBkaXJlY3RseSBpbiB0aGlzIHBhdGNoLiA8YnI+DQogICAgVGhlIHNpemUgcGFy
YW1ldGVyIHdpbGwgYmUgdXNlZCBieSB0aGUgcG1wX2hhcnRfaGFzX3ByaXZzIGZ1bmN0aW9u
DQogICAgdG8gZG8gdGhlIHBoeXNpY2FsIG1lbW9yeSBwcm90ZWN0aW9uIChQTVApIGNoZWNr
aW5nLjxzcGFuDQogICAgICBzdHlsZT0iZm9udC1zaXplOiAxMS4wMDAwMDBwdDsgZm9udC1m
YW1pbHk6ICdDTVIxMCciPiA8YnI+DQogICAgICBJZiB3ZSBzZXQgdGhlIHNpemUgcGFyYW1l
dGVyIHRvIHRoZSByZW1haW4gcGFnZSBzaXplLCB3ZSBtYXkgZ2V0DQogICAgICB1bmV4cGVj
dGVkIHRyYXAgY2F1c2VkIGJ5IHRoZSBQTVAgcnVsZXMgdGhhdCBjb3ZlcmVkIHRoZSByZWdp
b25zDQogICAgICBvZiBtYXNrZWQtb2ZmIGVsZW1lbnRzLjwvc3Bhbj4NCiAgICA8cD48c3Bh
biBzdHlsZT0iZm9udC1zaXplOiAxMS4wMDAwMDBwdDsgZm9udC1mYW1pbHk6ICdDTVIxMCci
Pk1heWJlDQogICAgICAgIHdlIGNhbiByZXBsYWNlIHRoZSB3aGlsZSBsb29wIGxpa2VkIGJl
bG93Ljwvc3Bhbj48YnI+DQogICAgICA8c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMS4wMDAw
MDBwdDsgZm9udC1mYW1pbHk6ICdDTVIxMCciPjwvc3Bhbj48L3A+DQogICAgPHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZTogMTEuMDAwMDAwcHQ7IGZvbnQtZmFtaWx5OiAnQ01SMTAnIj48YnI+
DQogICAgPC9zcGFuPjxmb250IGZhY2U9Im1vbm9zcGFjZSI+dmV4dF9sZGZmKHZvaWQgKnZk
LCB2b2lkICp2MCwNCiAgICAgIHRhcmdldF91bG9uZyBiYXNlLMKgwqDCoMKgwqDCoMKgwqDC
oCDCoDxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoCAuLi48YnI+DQogICAgICB7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoDxicj4NCiAgICAgIMKgwqDCoCAuLi48YnI+
DQogICAgICDCoMKgwqAgdWludDMyX3Qgc2l6ZSA9IG5mICZsdDsmbHQ7IGxvZzJfZXN6Ozxi
cj4NCiAgICAgIDxicj4NCiAgICAgIMKgwqDCoCBWU1RBUlRfQ0hFQ0tfRUFSTFlfRVhJVChl
bnYpOzxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8
YnI+DQogICAgICDCoMKgwqAgLyogcHJvYmUgZXZlcnkgYWNjZXNzICovwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDCoMKgwqAgZm9yIChpID0gZW52
LSZndDt2c3RhcnQ7IGkgJmx0OyBlbnYtJmd0O3ZsOyBpKyspIHs8YnI+DQogICAgICDCoMKg
wqDCoMKgwqDCoCBpZiAoIXZtICZhbXA7JmFtcDsgIXZleHRfZWxlbV9tYXNrKHYwLCBpKSkg
ezxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDCoMKg
wqDCoMKgwqDCoCB9PGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqAgYWRkciA9IGFkanVzdF9h
ZGRyKGVudiwgYmFzZSArIGkgKiBzaXplKTs8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoCBp
ZiAoaSA9PSAwKQ0KICAgICAge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHByb2JlX3BhZ2VzKGVudiwgYWRkciwgc2l6ZSwgcmEsIE1NVV9EQVRBX0xPQUQp
Ozxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgIH0gZWxzZQ0KICAgICAge8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoDxicj4NCiAgICAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogaWYgaXQgdHJpZ2dlcnMgYW4gZXhjZXB0aW9uLCBu
byBuZWVkIHRvIGNoZWNrDQogICAgICB3YXRjaHBvaW50ICovPGJyPg0KICAgICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2b2lkICpob3N0Ozxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW50IGZsYWdzOzxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIFByb2JlIG5vbmZhdWx0IG9uIHN1YnNlcXVlbnQgZWxlbWVudHMuICovPGJyPg0KICAg
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFncyA9IHByb2JlX2FjY2Vzc19mbGFncyhl
bnYsIGFkZHIsIHNpemUsDQogICAgICBNTVVfREFUQV9MT0FELDxicj4NCiAgICAgIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1tdV9pbmRleCwgdHJ1ZSwgJmFt
cDtob3N0LCAwKTs8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChmbGFn
cyAmYW1wOyB+VExCX1dBVENIUE9JTlQpIHs8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAg
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFN0b3AgYW55IGZsYWcgYml0
IHNldDrCoMKgwqDCoCDCoDxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICrCoMKgIGludmFsaWQgKHVubWFwcGVkKcKgwqAgwqA8YnI+DQogICAgICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqwqDCoCBtbWlvICh0cmFuc2FjdGlvbiBm
YWlsZWQpPGJyPg0KICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJ
biBhbGwgY2FzZXMsIGhhbmRsZSBhcyB0aGUgZmlyc3QgbG9hZCBuZXh0DQogICAgICB0aW1l
Ljxicj4NCiAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgwqA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmwgPSBp
OyA8YnI+DQogICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7PGJy
Pg0KICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KICAgICAgwqDCoMKgwqDC
oMKgwqAgfTxicj4NCiAgICAgIMKgwqDCoCB9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgPGJyPg0KICAgICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDCoMKgwqAgLyogbG9hZCBieXRlcyBmcm9t
IGd1ZXN0IG1lbW9yeQ0KICAgICAgKi/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDCoMKg
wqAgaWYgKHZsICE9IDApIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgPGJyPg0KICAgICAg
wqDCoMKgwqDCoMKgwqAgZW52LSZndDt2bCA9DQogICAgICB2bDvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqA8YnI+DQogICAgICDC
oMKgwqAgfTxicj4NCiAgICAgIMKgwqDCoCAuLi48YnI+DQogICAgICB9PC9mb250Pjxicj4N
CiAgICA8cHJlPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij48L3NwYW4+PC9wcmU+
DQogICAgPGJyPg0KICA8L2JvZHk+DQo8L2h0bWw+DQo=

--------------o5XUj0HN2PwvfsfpASeNMDZx--

