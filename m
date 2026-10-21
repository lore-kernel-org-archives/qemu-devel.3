Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA0606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GVYuMIGr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJTmJ-0008VV-2G; Wed, 21 Oct 2026 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJTmH-0008Uv-75
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:42:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJTmF-0003om-AT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:42:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso4448525e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792579353; x=1793184153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bhz1qewhkOIO80xrSb3nuYMVUngy+CLYwQxSjFjjLdk=;
 b=GVYuMIGrgbwme2HR3kScx5p1cAe0izpkwVFlSlFjyHZUnK59ko9PbPGi9aDalWKs0v
 R8IJ5EaYbiQwl3KYMDbHERMDhgI6d+BMqhaZnTzP5pILm6w22XeBriY9YJG2pJJ4qfHT
 gLCvww0d5kSptSMn79/+wCdJ9/VjRaU4k17GOust6XaZ0YpTwEPYO2EZMLaOjAQlNexu
 gVyOCs4IkOzQo3z5aVAX8mzhbIS+3gDwj/x9EDwkQub0muQQAqaaTa1PyKNR7H+alXV5
 JQ4DbCa9vftfD85iukoyBNnoUtCuVOD371MgXuNfqokMc4Ba1Yj1tQE972DCHhGlQisy
 5xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792579353; x=1793184153;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bhz1qewhkOIO80xrSb3nuYMVUngy+CLYwQxSjFjjLdk=;
 b=gC423MTLS1281s/TcoPQf2vDgyhbeOTG478xdEJxRB4I1/+vFJZjGU9lMNkEGkc+/x
 WNHsizCg4M10P9rvfuvrQ4dBf7KCsWNOaV9uUg9CVwCDVUe3cIvzrEA1hWNmASQTYc4S
 DJfJ55/23PI4lvN43FXw2VEZEpoJ1D4gnbHGrxwR8RdX00mm2Icfs0IGCM2neiXdzT5r
 RJ5napnCWRrZjy7heXN/tdrxn5xc+3Don/6UVCMOp/scAtbKvOezaso7IKRT07mHKwyM
 hyalUSlj/zBulPT1aLDTeQqB+V/PmFyThZrH8eLwSB5Ije6mUH2Sdo5qlEgTRl5V4xwG
 foyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDooVAZ0OEcj0hZ7v48tdU1SVuKIB8VNnlumzm3QSCSlPO2W/zDkkVAEWIiZ/AIn+qSxUTYm5LjRqm@nongnu.org
X-Gm-Message-State: AFq9FYL7a3AEla6wz+aMHqHzeOAV6slaBjdFopyCJLjgf5T98Ha/rUgv
 CikRhk2KqYQGaMObl8iomV0bzlxc0Yuiqqz9c4H0WMoc3OnxsTR1MRpASRBfO1bA+wg=
X-Gm-Gg: AYBFou25nsae3qyDm9Ylc/lCbJap6sBBHmCm0s1M1+qu9cFhQIWiqRlf3Gb5iufecRc
 9yCDdEQl8XGMv8qgP/vbzHgib84yxj7HQGYdD1Nbw83rnb8U4+vG7rZaUV6lDKiYuS1zi0T4AMl
 QVqDFZ34mG4vO6pawz0dW8H8RITMS8g2pT3SDJflwu8mHEV7dC49Vy7kAw8IWYNdn3Lbg7qDYz/
 1nzNQVN+x0aEr7bpu+Ne1A7g6seIIPIbYepX9fIZA2Hh1Ik1ZlM2lzDq6tQZDFaVUXK+WP9wOjy
 Yc9ZqHNXrAEYIML7+iktYPw7II2uXcyUjs0sNZL4Y4h/16BjAd8uC05PhSDnlRUxQJMfojba/51
 nMRsC8hA2opbVyQsx6hgaws8pJaeNyFQOYVn7riU/zg6Ii8PdcddgQvMuIU+VKFIEFFCBL3Uevw
 xgLtGwOWOM5xfdWMkd5EAJsBCMPVpZDMFvszdUwygq3mt2FKkLjPmAjfUid5a4Zt+oLZZZGHWG4
 iKo7YN++pUAkwieEp/51T0EQBK2BvYh+1OHhp7X7Oe2xEx18B5bN+V7tsxWW0SMmYqV+NXXF+ng
 hyDh1jkzyHwqMJRr2N0/uBk3bvs=
X-Received: by 2002:a05:600c:19ce:b0:4a0:c02:938c with SMTP id
 5b1f17b1804b1-4a1fdb1c4e8mr32186065e9.25.1792579353080; 
 Wed, 21 Oct 2026 03:42:33 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2e8daffsm161747355e9.4.2026.10.21.03.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 03:42:32 -0700 (PDT)
Message-ID: <9c44d872-586c-41d3-906e-1a35aefa0bf5@linaro.org>
Date: Wed, 21 Oct 2026 12:42:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] target/i386/tcg: fix EIP truncation for wrapping
 near branches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: paul@galbraiths.ca, pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260926235620.851099-1-richard.henderson@linaro.org>
 <20260926235620.851099-3-richard.henderson@linaro.org>
 <6080974b-f174-4e95-8846-26ed13202dcd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6080974b-f174-4e95-8846-26ed13202dcd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 10:50, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 27/9/26 01:56, Richard Henderson wrote:
>> A 16-bit near branch that wraps through 0xFFFF must truncate EIP.
>> TCG skipped this when the target was on the same page, which can
>> happen when the CS base is not page aligned.
>>
>> There was an existing test for this further up that attempted to
>> test this, but was restricted to a 16-bit branch in 32-bit mode,
>> which can be subsumed.
>>
>> The previous test for pc being on the same page, rather than eip, is
>> only relevant to using goto_tb not to eip wrapping.  There is another
>> test for pc on the same page further down, via translator_use_goto_tb.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL")
>> Reported-by: Paul Galbraith <paul@galbraiths.ca>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/i386/tcg/translate.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>> index a38cc2c15d0..18706ec8a74 100644
>> --- a/target/i386/tcg/translate.c
>> +++ b/target/i386/tcg/translate.c
>> @@ -2015,9 +2015,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp 
>> ot, int diff, int tb_num)
>>       if (!CODE64(s)) {
>>           if (ot == MO_16) {
>>               mask = 0xffff;
>> -            if (tb_cflags(s->base.tb) & CF_PCREL && CODE32(s)) {
>> -                use_goto_tb = false;
>> -            }
>>           } else {
>>               mask = 0xffffffff;
>>           }
>> @@ -2025,15 +2022,20 @@ static void gen_jmp_rel(DisasContext *s, MemOp 
>> ot, int diff, int tb_num)
>>       new_eip &= mask;
>>       if (tb_cflags(s->base.tb) & CF_PCREL) {
>> +        assert(s->pc_save_valid);
>>           tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
>> -        /*
>> -         * If we can prove the branch does not leave the page and we 
>> have
>> -         * no extra masking to apply (data16 branch in code32, see 
>> above),
>> -         * then we have also proven that the addition does not wrap.
>> -         */
>> -        if (!use_goto_tb || !translator_is_same_page(&s->base, 
>> new_pc)) {
>> -            tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
>> -            use_goto_tb = false;
>> +
>> +        if (mask != -1) {
>> +            /*
>> +             * If eip "page" doesn't change, then the addition cannot
>> +             * leave [0, mask] on any rerun of this TB, which only
>> +             * ever shifts EIP by whole pages.
>> +             */
>> +            target_ulong old_eip = s->pc_save - s->cs_base;
>> +            if ((old_eip ^ new_eip) & TARGET_PAGE_MASK) {
> 
> Is it OK to skip the previous ot == MO_16 and CODE32() checks?

Yes.

> The next patch only tests 16-bit, not 32-bit protected. Can we
> complement with a 32-bit test? Since this is a qemu-stable@ fix,
> can you better explain the "subsuming" and why we don't need this
> safer check:
> 
>                 if ((CODE32(s) && ot == MO_16)

Because this was trying to do exactly what...


>                     || ((old_eip ^ new_eip) & TARGET_PAGE_MASK)) {

... this does, but more accurately.


r~

