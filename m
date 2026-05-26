Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4E4CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoNM-0005ru-FT; Tue, 26 May 2026 05:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoNK-0005r5-GO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:47:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoNI-0004Fd-DW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:47:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-49068493267so12968215e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779788818; x=1780393618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zKVG0KIYxnF/3RfPEfzH6BbW6IenKOyDdn+K2omGkBk=;
 b=qRNjK0UoTAKsEALRa7QeFZRtLq8zeQDClgeofI2DbWk9eTCpDQYG0aLmkPVQIrwuFw
 A+LXQHtsDT4/P8j+WGAAetGjzDgTApzOb7qdNBRYVqAoUZ7Hdm71280wF2FyPp7vIrPK
 eFSjm9C4wrx8cOGL3aiZlbafG5WvgboARsgp9Ba7oQxPTF1Wo31o5yc3+Wff1vruLXE+
 uN5aHYK5VZuAFVXm0QSPGemJYZHdsDu2aFxwh6/7ej1WjB49dJRv0p6JBFVdEY3nHJnW
 9OQgSjvaZ6GVaQXA/SUB7dEFFXe1Lnlj+ESyzuYLgaEbpnZVzocrgh7ocQbeUrvhHfE9
 RwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779788818; x=1780393618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zKVG0KIYxnF/3RfPEfzH6BbW6IenKOyDdn+K2omGkBk=;
 b=BiTGj4pTFb8DRwlHu7Zx6gNi/M8bDqxTaEDdL63Dp9dMdqedyeV7dmi0e+WaqMCgZl
 BoxlQNkvmI19SCHrt3lEVFPEBGWzq1LW7hLsc/FfnzpdClN1DR62l8/+50mojrux61Ut
 PFG25cDEZHGbpQj2OVMV91ZOLYW3tc/EAy3RawYvbITFtNn8RarlP1rHJCn7Gf0KwGcv
 iMLjnPuifYkpjxXcz+I+8Sybbmp3UAFPV9ECBYaFcsUwVofX4Lf2+9wxBKCG++1j7t26
 u5h81M7SdCYlUyphqMa35/1zhfOfnSrHCGpWJV89aiUwxHXopVkYdKIpFLEkpZkgp9JP
 4cBQ==
X-Gm-Message-State: AOJu0YyzLXw9ynfTzKYc0ptUdl3EKx6f63JxGGLlZuHXkGXF2amO4mDD
 4XjVak8E9puC9IyDzi+SyQFgd1V8Rt1SAm5TAyhyZ3RXeduDkMbLdBf17jGafDHTIGE=
X-Gm-Gg: Acq92OHV/2fqSMQraL4CZYOGA3FvtXKatR+XT47ROY0nSoj3ql4ao93f9KPnyP5TlIi
 S0tW/l4c+DxiR3+Pvpi8CXMd1IkRHGGMZm1sMDoWy3izVcPXwFrgygueqp3HWBSMK/4XI5Cfphd
 l+3xUNeHbfBhjpiYn5EUgyzXg6xTONz+h70VO6TivozjVdvlhx0sBDfOS1N/VKqcB5lsTFX4iTt
 xndOzYy1wIfIBbEyWxN5JuKgbM67Kqt8TUKAsKQHFT7FQ9ryJ+2rDt7fQj5kKhTt5pz/29VUr/Z
 XLENkXuGmmFw3ma9n7fwdtgmldfixVg/M9/kjyfLeK6Qjrn58QAhE8h+fLTT0zSqjRxjHjr9OaT
 slPatlXDHmdkiKjjq0KlISkUf38EIu28ekPb7kLL8hrbl0JJFbY/gsg3BVsXE4s2y0fK0NBoyFE
 IHC+IcW70jssvcZoFI6xOSb4Mw6LvX98SYOYxOxEPCvsPVvHpglfLEkYbwlefX59J0EQ==
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id
 5b1f17b1804b1-490426cefe0mr215062065e9.18.1779788818460; 
 Tue, 26 May 2026 02:46:58 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d6ebf0sm35183885f8f.34.2026.05.26.02.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:46:57 -0700 (PDT)
Message-ID: <de0d459c-56eb-4f5f-937d-53f4875d770e@linaro.org>
Date: Tue, 26 May 2026 11:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] target-info: Add target_riscv64()
Content-Language: en-US
To: Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
 <ag6_aQE7WW-BWFnB@ChaodeMacBook-Pro.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ag6_aQE7WW-BWFnB@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 21/5/26 10:19, Chao Liu wrote:
> On Wed, May 20, 2026 at 03:12:58PM +0800, Anton Johansson via wrote:
>> Adds a helper function to tell if the binary is targeting riscv64 or
>> not.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   include/qemu/target-info.h | 7 +++++++
>>   target-info.c              | 5 +++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 23c997de54..6c5b714288 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -99,4 +99,11 @@ bool target_ppc64(void);
>>    */
>>   bool target_s390x(void);
>>   
>> +/**
> There’s one extra * character here; otherwise LGTM.

This is the Javadoc tag which is also used by C tools such doxygen:
https://www.doxygen.nl/manual/docblocks.html#cppblock

We use sphinx with a kerneldoc.py plugin which understands it:
https://www.kernel.org/doc/Documentation/doc-guide/kernel-doc.rst

i.e. https://www.qemu.org/docs/master/devel/index-api.html

> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> Thanks,
> Chao
>> + * target_riscv64:
>> + *
>> + * Returns whether the target architecture is riscv64
>> + */
>> +bool target_riscv64(void);
>> +
>>   #endif
>> diff --git a/target-info.c b/target-info.c
>> index 28c458fc7a..04c69c41f8 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -93,3 +93,8 @@ bool target_s390x(void)
>>   {
>>       return target_arch() == SYS_EMU_TARGET_S390X;
>>   }
>> +
>> +bool target_riscv64(void)
>> +{
>> +    return target_arch() == SYS_EMU_TARGET_RISCV64;
>> +}
>>
>> -- 
>> 2.52.0
>>
>>


