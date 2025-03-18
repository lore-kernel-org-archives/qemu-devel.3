Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB075C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubvq-0002Ze-4u; Tue, 18 Mar 2025 14:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubvm-0002YQ-C4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:44:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubvi-0000VB-O2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:44:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso25020305e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742323485; x=1742928285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/74e6taWSnZdXHpVWs74ehYusOf6mHllaULzT1w5Bx8=;
 b=kPc+c+8hGMEdWmSHZpt6gzqFZp0kLOkeLcwoHLSZHKw8QGHXYGxweomway/nH03hER
 qBBWC59CsNngLftQ15NppL+0fpyirvdR9Bg0a1vmmWntcbrXsX/icSlsPaz045GpwUKl
 E3MAK2084dopl4w4+mNThH4tl/q2U/d/XyvjdOgZJi+odQw6FFFkd+GpCRBhyp8oWKMX
 TSSBj6ORjcDjP8SdEnXh3bgD7hH7+nwQR3Zp52D7XFj+CSdh8boUPwohnZ/UTnniHh9K
 UsEyFtdyMVT5KDkMeTjJl/IkPtAosirjFNaMUVturOiASocs1S+y1S3c0VULgVE80cUH
 ix9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742323485; x=1742928285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/74e6taWSnZdXHpVWs74ehYusOf6mHllaULzT1w5Bx8=;
 b=nf6xlQlm/rC/XF1bSakOJV/89tXrsnI8c1UvpAJkDIvS0wUyZG9XmHlG3NuX5Xyl4Q
 TvGbJEjl0K6CsRoBJNOgVtkHjw9y2/fSSsbofU9mNFiMrNILEmqJGlq+P3wnqWUdDQD2
 OJLW4/9luxHoSBTUtjdOjY/zpvT+0hGWPoOjb4Lj7sLbLGHI7XtfmTrXNgwbtGQ+ikEK
 zGz5EZwStYgS8S3P1fkwf5sYINMiEUH4Sdv8JtkiOX3z9xboreAjJLwln4HZ4OuwZyMP
 kQbqzF6eNljbM3/MqoO35jEMlK3XqDLwjFDW988kXwsTWQO4sJ3AVnNRuefPRbnGOKT9
 lmiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzRVaxLEZdnWs1OTTvV+ONip57SVgLBT7/E1b4oNEM31+vbYxR++9OfgrlBX52M7rzKwNS5OHBGOpc@nongnu.org
X-Gm-Message-State: AOJu0Yy5WzwcVn5e8ujpz0EiKD0ogr6D5jmJRrF2LB9qkX2lQXmavVcQ
 4w5PalLU9/sh79essu+3juwDyVRtnrGFbF7mHb9hyA4diauI7DfsdIPtBcHHwGo=
X-Gm-Gg: ASbGncuNQSMblzWc9giERqTmLQ6XOBPHmy3NxFi1BWK6wgcfpCT0FoQzpqbVzur29j5
 I7SZ6wf7Ggv8o+Umq64nOXCXIhpRJUJy0DfNVleoY/Z7F+YnJr/rcdIFr1MT7DRyOdkcupFqQNf
 2t+GCDKff4pW5JGA/yhQdYaHipcxIveizmVZZ+1rhRZUxXFe4rC/rYVKUaXdXzd0S8RZkTkn/83
 93uclghbz/hKstR5yQOZx8yrKdKcIkq5t1QSu7Lnv0wJFWUxb9JSXeztsgGbNSdsY+WmNk8kjXr
 A9RN6y6/9ReZW1brH367VhuUhTP8tzZRF+riMkW9YNcAsCJC9K+tTpj3LHeuuMqlD1Dc8jrX858
 lF/1IdLbK4rBZ1j+oOvGNED8=
X-Google-Smtp-Source: AGHT+IFkVGOmrvcSxc0T/uu8x/A0usu2Brk5uUuQYT3z4kvfwm+YufQaBC7XAgOvjeShp7rhcc8jAQ==
X-Received: by 2002:a5d:598d:0:b0:391:1139:2653 with SMTP id
 ffacd0b85a97d-3996b4a1e1dmr2951613f8f.52.1742323484762; 
 Tue, 18 Mar 2025 11:44:44 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318aa1sm19381585f8f.64.2025.03.18.11.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:44:44 -0700 (PDT)
Message-ID: <45ded580-5593-469e-bffd-01fab1962b5a@linaro.org>
Date: Tue, 18 Mar 2025 19:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
 <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/3/25 18:50, Peter Maydell wrote:
> On Tue, 18 Mar 2025 at 17:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 18/3/25 05:51, Pierrick Bouvier wrote:
>>> Directly condition associated calls in target/arm/helper.c for now.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/cpu.h    | 8 --------
>>>    target/arm/helper.c | 6 ++++++
>>>    2 files changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 51b6428cfec..9205cbdec43 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>>>     */
>>>    void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
>>>
>>> -#ifdef TARGET_AARCH64
>>>    int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>>>    int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>>>    void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>>> @@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
>>>    #endif
>>>    }
>>>
>>> -#else
>>> -static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
>>> -static inline void aarch64_sve_change_el(CPUARMState *env, int o,
>>> -                                         int n, bool a)
>>> -{ }
>>> -#endif
>>> -
>>>    void aarch64_sync_32_to_64(CPUARMState *env);
>>>    void aarch64_sync_64_to_32(CPUARMState *env);
>>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index b46b2bffcf3..774e1ee0245 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -6562,7 +6562,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>>         */
>>>        new_len = sve_vqm1_for_el(env, cur_el);
>>>        if (new_len < old_len) {
>>> +#ifdef TARGET_AARCH64
>>
>> What about using runtime check instead?
>>
>>    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && new_len < old_len) {
>>
> 
> That would be a dead check: it is not possible to get here
> unless ARM_FEATURE_AARCH64 is set.

So checks in callees such:

-- >8 --
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd1..8377eb0e710 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11547,5 +11547,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, 
unsigned vq)
      uint64_t pmask;
+    ARMCPU *cpu = env_archcpu(env);

+    assert(cpu_isar_feature(aa64_sve, cpu));
      assert(vq >= 1 && vq <= ARM_MAX_VQ);
-    assert(vq <= env_archcpu(env)->sve_max_vq);
+    assert(vq <= cpu->sve_max_vq);

---

