Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5710CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95Ty-0002H0-8p; Wed, 15 Oct 2025 13:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95Tt-0002Av-KA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:40:10 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95To-0000tM-EN
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:40:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4256866958bso3956436f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760549996; x=1761154796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KEgBKwZS6rpilocZAwpPRmX7jo6ggdQ2o9ATQFmH7Ho=;
 b=XlOIZxoaC3orx44/iT2k8ShgVnx5v8LOWfhNIVqOOIhUvY0acIhtMAyVqld1lFpbf+
 HhoofdD8IgWgnrKHzqn+ySLzlJL/XqcL3tGFB1Bf+E52LjuMq4pS4+aBYO3l3rECYlIr
 5o29Y+Xz0AFYaNjDlxzAflicghi5qqEyGblerhtlV4DeRM89wzFg1RIIQGQ85/ZGgtlW
 /vUYhtzdYqZQd77yQ0Kf2lwjjXe6r5Mz46DqDMh/U3uLuAPZk4QXf7EDgdQ6Y4sJ4zYB
 VNjE01vhIrECT/a7HBV2drleZSQXLpLGr+ZNGUEaOaSKCFVo1AvmZba+Hr04l0QQ9Mf6
 pHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760549996; x=1761154796;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KEgBKwZS6rpilocZAwpPRmX7jo6ggdQ2o9ATQFmH7Ho=;
 b=L071LkKyDJvGpuUMumof7b2TNUZVr9azyo2d8ecCjCL0tzugVklFEX20IpVPR+Q+/k
 vON3qQf3ocbMKtafK4IGcOOJKI8kzwz1FWsaq+3LtHxYfHMO0GPRrx2Mp7yV8efE7yed
 1KZuiN+zrHEhjqo4CLvPT/sEoryFjNXXxYKxjQfmdYbKMvZFqfXWrUbsloKybNd4K5b1
 fhbuYu6vQi0MU9xcYG2nROZlZq51yFVIJ9SDtZrhxjC1Kl+pn+kKmE2C4payf86JuLP2
 HuxoZi+0EannINcJ/LtlitTGb0LBu95P7Jh5GXGeEfb6/8CBV+3rGYzqRXFklmC5LPYh
 1dOQ==
X-Gm-Message-State: AOJu0Yw5VU37KSbhRlw0Gm4arcxm3/RbrKBan0CqG5vd1oc6voR+abie
 4YtcM0lEZmxMptgQ0GEioRnYuYFZiTt9cIefyIt74tJtFB/OD1Ouojqm6rWob9w8iNg=
X-Gm-Gg: ASbGncvnrHFfcxqOf1aALZA73julvGPFGDebUb0amkmy5n4iIUycIPCcs504GACtXTE
 /tTnz7LStyd822qeMtBCXAmaEjA7Si7H2XuDmgnT7iSErG6D+UFB606ZWuPle7bBeuobafK5kns
 AtiL42pktiYs7UIrLrP4EUlPo5t3+1DR81YtMEcwySwiO5GJWqir1JKe3RSwaF49f6dJaLsuHOx
 UZkMb4uYLQ1f7St95KKspdwUAbovusohz1L3ThcX5GkKTrgowwChvacK6iBKM3efJpZvCniD9sd
 K0Upx03UkhpK2QiJTlGLKQgytJkXcuuzKFADoeiAmaoo+NQb8MytCvfOd3/nXCQ6TA3Ehi6TqTy
 GqF0KNXbGahtgl2s79R+H47i3vPfe0+7yzk9fxXjGyyhKQdOcifMr3Ap0ktRdqomaJ4BwM1m9o+
 Vx8pH2Lt0/02Mi
X-Google-Smtp-Source: AGHT+IHgNHfZYOXdibo+VxGjrrlPjeMVl4Czt+h5ng6o2wja3L0TZjh62nB0DypumNatwsXmmDhcKQ==
X-Received: by 2002:a05:6000:40e0:b0:426:d56d:f35f with SMTP id
 ffacd0b85a97d-426d56df39fmr10002801f8f.59.1760549996434; 
 Wed, 15 Oct 2025 10:39:56 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb55ac08dsm302655285e9.13.2025.10.15.10.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:39:55 -0700 (PDT)
Message-ID: <e5301e34-3e78-4e66-b3de-499e7b60e183@linaro.org>
Date: Wed, 15 Oct 2025 19:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-5-philmd@linaro.org>
 <dmneby7i44m7vvkhfhxh7cdhfu4l43wilukrtnfcvqzwgrgp66@hzkohhyqg4cu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dmneby7i44m7vvkhfhxh7cdhfu4l43wilukrtnfcvqzwgrgp66@hzkohhyqg4cu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 8/10/25 12:22, Anton Johansson wrote:
> On 08/10/25, Philippe Mathieu-Daudé wrote:
>> Since commit 36a9529e60e ("target/microblaze: Simplify
>> compute_ldst_addr_type{a,b}"), helper_stackprot() takes
>> a TCGv_i32 argument.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/microblaze/helper.h    | 2 +-
>>   target/microblaze/op_helper.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
>> index ef4fad9b91e..01eba592b26 100644
>> --- a/target/microblaze/helper.h
>> +++ b/target/microblaze/helper.h
>> @@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
>>   DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
>>   
>>   DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
>> -DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
>> +DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, i32)
>>   DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
>>   DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
>>   
>> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
>> index b8365b3b1d2..df93c4229d6 100644
>> --- a/target/microblaze/op_helper.c
>> +++ b/target/microblaze/op_helper.c
>> @@ -365,13 +365,13 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
>>       return 0;
>>   }
>>   
>> -void helper_stackprot(CPUMBState *env, target_ulong addr)
>> +void helper_stackprot(CPUMBState *env, uint32_t addr)
>>   {
>>       if (addr < env->slr || addr > env->shr) {
>>           CPUState *cs = env_cpu(env);
>>   
>>           qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
>> -                      TARGET_FMT_lx " %x %x\n",
>> +                                   "0x%x 0x%x 0x%x\n",
>>                         addr, env->slr, env->shr);
>>   
>>           env->ear = addr;
>> -- 
>> 2.51.0
>>
> 
> Might as well update call sites to gen_helper_stackprot() as well.
> compute_ldst_addr_type[ab]() calls into gen_helper_stackprot() but
> returns TCGv.  That return value is passed to do_load() and
> do_store() as TCGv, but the bodies of these function clearly expect
> TCG_i32.

Right, but tcg_gen_qemu_ld_i32/tcg_gen_qemu_st_i32() take a TCGv...

I'll address as follow up patches I think.

> 
> Otherwise
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

