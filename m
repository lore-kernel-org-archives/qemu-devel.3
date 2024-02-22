Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE130C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9DJ-0005yk-58; Thu, 22 Feb 2024 08:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rd9DH-0005ws-4c
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:34:11 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rd9DF-0004cz-9u
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7JKOwaqw3aZq02n6ZogT1KrOs0SHmjpxsjy+su5c4ug=; b=BlKxOa48FULJEqHaG55BxzFlWR
 CeAyz88zF/M02bb6ffLVfsPh2elkW25CfyVSHu0YZhZsScP91I0zblleNf9GayRgNphxBMLyl0jC2
 cKbfE2jMCWPw9qOs3YZiODJGBX9CfbOf0aQQw/rwYKtzQcadgGJFbvgcRLG91PCKuj9rWSFdQf1sb
 2hcjr7KtliaJs/BuRUdXiKJBxX1eNY9PAZgkh/ohajZ0/Ix/GlH34Y4g/JBrwvtMSBDHYCesuE41t
 e/u5OPx2iWqrgWwhV5xbqeuUGy10JgioPy7u49LvU/I/NMNA5Mm4bb0tHlYMSaJyZO3B5/gJszADo
 nvCBOfKeVUlITzRjMbom5kixXPUsTQdL/H6Y05ChqFXUqDaYo6OuA0GXTtcg5oMGYJQmwPr3h+VOn
 zxl8Nq6IvdKezenDi/2pTZv0vyb5hH0RDgxqX38cC4VNKaigkY9M+YIZFb9xGgDtPT6dPjRovB0eb
 KpaUIwqw2l6QZCUOUk+7ctSk/YaRykcA3SGNg2bt5hadpp6xqpsBcKTOdEF8zW1p9JyR3Il9IG7Yp
 BUF5cbesrzYxsfECJiPKkYTWhBhrWIBdmY5Jo41z+KxD4zlD4I913gX6LOjzE+mhkP0djKjlnaz08
 +tpXOjcy+oXKCECx/pUZqQGZ90C43XE3S3E54Z17g=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rd9CR-000CVe-CJ; Thu, 22 Feb 2024 13:33:23 +0000
Message-ID: <5388387b-f7aa-4fa2-a65b-d3a3b52e23d9@ilande.co.uk>
Date: Thu, 22 Feb 2024 13:33:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Daniel Palmer <daniel@0x0f.com>,
 laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20240115101643.2165387-1-daniel@0x0f.com>
 <30980866-7fe8-4900-a75b-01fe735e14e1@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <30980866-7fe8-4900-a75b-01fe735e14e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/m68k: Fix exception frame format for 68010
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/02/2024 09:57, Thomas Huth wrote:
> On 15/01/2024 11.16, Daniel Palmer wrote:
>>  From the 68010 a word with the frame format and exception vector
>> are placed on the stack before the PC and SR.
>>
>> M68K_FEATURE_QUAD_MULDIV is currently checked to workout if to do
>> this or not for the configured CPU but that flag isn't set for
>> 68010 so currently the exception stack when 68010 is configured
>> is incorrect.
>>
>> It seems like checking M68K_FEATURE_MOVEFROMSR_PRIV would do but
>> adding a new flag that shows exactly what is going on here is
>> maybe clearer.
>>
>> Add a new flag for the behaviour, M68K_FEATURE_EXCEPTION_FORMAT_VEC,
>> and set it for 68010 and above, and then use it to control if the
>> format and vector word are pushed/pop during exception entry/exit.
>>
>> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
>> ---
>>   target/m68k/cpu.c       | 4 +++-
>>   target/m68k/cpu.h       | 2 ++
>>   target/m68k/op_helper.c | 4 ++--
>>   3 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
>> index 1421e77c2c07..20718944b4c8 100644
>> --- a/target/m68k/cpu.c
>> +++ b/target/m68k/cpu.c
>> @@ -137,7 +137,8 @@ static void m68000_cpu_initfn(Object *obj)
>>   }
>>   /*
>> - * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
>> + * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD,
>> + *      format+vector in exception frame.
>>    */
>>   static void m68010_cpu_initfn(Object *obj)
>>   {
>> @@ -150,6 +151,7 @@ static void m68010_cpu_initfn(Object *obj)
>>       m68k_set_feature(env, M68K_FEATURE_BKPT);
>>       m68k_set_feature(env, M68K_FEATURE_MOVEC);
>>       m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
>> +    m68k_set_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC);
>>   }
>>   /*
>> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
>> index d13427b0fe61..0fc591e618f6 100644
>> --- a/target/m68k/cpu.h
>> +++ b/target/m68k/cpu.h
>> @@ -549,6 +549,8 @@ enum m68k_features {
>>       M68K_FEATURE_TRAPCC,
>>       /* MOVE from SR privileged (from 68010) */
>>       M68K_FEATURE_MOVEFROMSR_PRIV,
>> +    /* Exception frame with format+vector (from 68010) */
>> +    M68K_FEATURE_EXCEPTION_FORMAT_VEC,
>>   };
>>   static inline bool m68k_feature(CPUM68KState *env, int feature)
>> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
>> index 1ce850bbc594..b09771672dec 100644
>> --- a/target/m68k/op_helper.c
>> +++ b/target/m68k/op_helper.c
>> @@ -52,7 +52,7 @@ throwaway:
>>       sp += 2;
>>       env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>>       sp += 4;
>> -    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
>> +    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>>           /*  all except 68000 */
>>           fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>>           sp += 2;
>> @@ -256,7 +256,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
>>                                     uint16_t format, uint16_t sr,
>>                                     uint32_t addr, uint32_t retaddr)
>>   {
>> -    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
>> +    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
>>           /*  all except 68000 */
>>           CPUState *cs = env_cpu(env);
>>           switch (format) {
> 
> LGTM,
> Reviewed-by: Thomas Huth <thuth@redhat.com>

This is also:
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2164

> Laurent, if you're currently too busy with other stuff, I could also add this to my 
> next pull request?
> 
>   Thomas


ATB,

Mark.


