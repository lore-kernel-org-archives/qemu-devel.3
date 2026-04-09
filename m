Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAB1F364B6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAwbS-00060h-TS; Thu, 09 Apr 2026 17:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAwbP-00060J-VI
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:07:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAwbN-00064X-64
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:07:50 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so806749f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775768867; x=1776373667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mEDrAYWL+WIvBTZfhs7OCeci3sI70D3lFJQa5oMQunM=;
 b=q8RKrw+F/uSa1XGS/8Ji1KahusOKoevbgmDEIBq7NnH4GhR0Y2He+WxodSfpYoCRu3
 tQau+DDarabROdtsO1wi0HxmsMRBzHCEVn5yAQ39zQ3fuo3O0b0ccWf9cGhIGkTNda+G
 3odWKujT+36YoA/zTnGHD7+9czFuz1EkB9EuaTIlVtUmvWkLd9E9ad0rWss7KwHGQKix
 9XYa9Dh2aM3X9opbp3YKqtsfa3E1pj4MN6Mn2r2Pi6/mjepgfrCjHiF/c2RlUUeSQMdv
 iYIOFo7L4Q2K+3I0R0l0ZdNJz1gWA+Hf3dGLHC3UmHjtCUcyrXAWt+kfwa8uLR/UyQ57
 OAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775768867; x=1776373667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEDrAYWL+WIvBTZfhs7OCeci3sI70D3lFJQa5oMQunM=;
 b=q9GuET56S9xybOsWaMAubwPMJcrNWaJS2cHVHv4I4L4eZsLpNjXfCxfQnCO6Vp+PWt
 63hDKj8dXfls2KXQ64LWyWQW2+TxN+veseuc5fB6ilXwzL6tI4gLGsCkGY3oHnLAZKVo
 bmUxQhS8hrQpS1j7a4J7fcGrMEVDqmOkXm/LTVNr7ARPUFlNXc7Qlgv1cb+jUSDdddER
 33tOJ1d62MdX6xMh5vNuX4vdrWXRqASOYdJWm8bfG0Nse6CddJD1seX1BPTpbrkVUAq3
 iuqfCrl27BJColrCArsR29W3cSjLW3c1VdarwJ5Pt6tE59qJzDWESQcXcIub0XeAT6Jl
 FiDg==
X-Gm-Message-State: AOJu0YyAEOs962s/YwgOkA6vp32YTUb5jMdogMASYGdMeasoA/3QJZM4
 5wJifVD7ENIXmNdl653Ew2Gct6iMUi1Pg2ZMSu/8HVPie7LIRgw+SI6pBHiCeHk5nv0=
X-Gm-Gg: AeBDieupv9EavBsCD9H0Prscv/9t7cEQy8RTeNyaC1vWwRVygSl9jy57oDhH9yS8mIy
 4Sk8ChXXTPL8TAPeqU0z2jF0zt9rY7qqwxxXJxohsj8jYKH7HZbyeIKngxiZxU3Rk6m0DiMqUP4
 w3GQCzDXxoHwhJgjfUMk3WhklAxXFesYxVFpkbHBsCPR9ei7+XQkqIE0+tZ7A4mlq7pTr3P8Ffa
 AuDgoCnEw59RmZ3BBQuJFXS438dvQuuIZXUmMJXBE93aOb98bZV/mU3tCYO/MwE8cIKR2bCTGWx
 ZYcMvWxH202N4jJBL/dZefzl6ELI0Cqu/JAiDuzJeAy1Cr6YGYTuOVAnoyK3vEIi7BkGdJ2IKE4
 +0Weut3IfiMCz9hDDq4k1UApBtdTV+yTOuim3YREbXKLn+mheuU1cB3Vl4O+gPfC/z9UvApJYYb
 XA/ZcxTqhOREIdkBVM4WbZE9BUJ5Wq6Fv2otg8k1M4KGLQo3YHD5X33km3E7COk8184A==
X-Received: by 2002:a05:6000:4014:b0:43b:4981:1ba3 with SMTP id
 ffacd0b85a97d-43d6423d08emr822214f8f.2.1775768866558; 
 Thu, 09 Apr 2026 14:07:46 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec28asm1686886f8f.15.2026.04.09.14.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:07:46 -0700 (PDT)
Message-ID: <46b5a434-10de-4ff2-aaca-636fc7a85180@linaro.org>
Date: Thu, 9 Apr 2026 23:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
 <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
 <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
 <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 9/4/26 23:00, James Hilliard wrote:
> On Thu, Apr 9, 2026 at 2:17 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 9 Apr 2026 at 20:47, James Hilliard <james.hilliard1@gmail.com> wrote:
>>>
>>> On Thu, Apr 9, 2026 at 10:17 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Wed, 8 Apr 2026 at 19:43, James Hilliard <james.hilliard1@gmail.com> wrote:
>>>>>
>>>>> MIPS glibc startup expects the thread pointer to be live in both
>>>>> CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
>>>>> cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
>>>>> unchanged.
>>>>>
>>>>> A guest can therefore successfully execute set_thread_area() and still
>>>>> reach __pthread_initialize_minimal() with k0 == 0, faulting on the
>>>>> first TLS-relative store.
>>>>>
>>>>> Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
>>>>> MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
>>>>> updates follow the same path.
>>>>
>>>> Where does the kernel do this? Looking at the mips set_thread_area()
>>>> https://elixir.bootlin.com/linux/v6.19.11/source/arch/mips/kernel/syscall.c#L87
>>>> it looks like it sets CP0_UserLocal plus the tp_value field in the
>>>> thread_info struct; and I can't immediately see anywhere where it
>>>> would read either CP0_UserLocal or tp_value and put it into k0.
>>>
>>> So this seems to be something used by the vendor SDK for Octeon1
>>> but not Octeon2 and Octeon3 targets, kinda strange/annoying.
>>>
>>> I also found this:
>>> https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html
>>
>> Ah, nice find.
>>
>>> It's in the Octeon vendor kernel here looks like:
>>> https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.14/blob/5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c#L94-L96
>>
>> Mmm. We emulate the upstream kernel, not vendor forks, so
>> we wouldn't want to set k0 here I think.
> 
> Yeah, I was trying to see if there was some sort of way to trivially
> identify binaries that require this k0 support and autoenable a quirk
> but I didn't find anything, maybe it would make sense to have a
> separate runtime target for enabling this k0 quirk since it seems a
> lot of octeon binaries require it?

What about (untested):

-- >8 --
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 0a000ac8f35..c4aa08df4a3 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -36,7 +36,9 @@ static inline void cpu_clone_regs_parent(CPUMIPSState 
*env, unsigned flags)
  static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
  {
      env->active_tc.CP0_UserLocal = newtls;
-    env->active_tc.gpr[26] = newtls;
+    if (env->insn_flags & INSN_OCTEON) { /* Octeon1 */
+        env->active_tc.gpr[26] = newtls;
+    }
  }
---

