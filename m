Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B75C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjJm-0007Vl-Lo; Mon, 23 Jun 2025 11:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjJl-0007Va-7B
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:42:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjJj-0006D9-NP
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:42:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7481600130eso5419826b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750693362; x=1751298162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcOWGgFl73CgoOLlUSurzwZ3APF8pBXC2BO0px7jnsg=;
 b=Xi5Pj83cjpZOCsqL+YoVx9SXXcgVZmZED4rAcsLqKHE/ShUtGAGdjQ/aEQqKORrR/g
 926H79ryYAJr7x89Zw1R00ds9Z2aBjn8s0tgTOxeC1HiNTS9wYaIMJEt510SW9qabIdd
 Lq7nAF+fLmOPRgIiKRKLd6b5SwgHd/MseqfgO60vOtExoUkYHapDX1BaDnSM4OZOb3hr
 3Rm1MyI3DlXVUnvHfmj/HVjsutkiSZvwB4cKQsU9lEOvLlWuw/YpwowJAK1Qv3a0Oaz/
 r50pmIVia5kHkpvQ8OS6Wr99/iy8iZvsZkiJ+/CNgigUcIl244Nim8IcU/VwKFPRKmxe
 SKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750693362; x=1751298162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcOWGgFl73CgoOLlUSurzwZ3APF8pBXC2BO0px7jnsg=;
 b=JA9yfjwR6XQDIB1h8cEUyz3fkQeRF0BkIPMXWOClrZNwQk7tv3c6gVsqspycYQB+HH
 KGDcLKh3pHCB/OSU3bWoXv08tF3vC36KqdM8ommXYAkQNi7hTr4y9CGC7S5Hkh8lY710
 O5Qms8XbjshzEOnfziNgNtOJvZCOdPkFyIcyQgx2hZsjoqEqS+k1Nfu7Bd4PZZSYu/SY
 fXkZnZ9KR5JHb+2sAZiybDE8iEDs28+g7OdvNoRSjs1NrOLcyvXsTtXsUOaLUKtcsQe0
 H+v95waqpbMcBOTdTLIHHN/aFPf7jy4vhvFg+Wc+ivgmOef5PMg+9BWEpNRM4FkbDatI
 ssEg==
X-Gm-Message-State: AOJu0YwAhzSB64gklALRK4IDrld/onEY5BhC6yauhhiQejZKu5K3kBik
 cn4wSsookaIy2H1xaq5bhBHDfOTo8lY4lokYUg/lLteK0GzAEPVAv/1jTFifxzG+yO0=
X-Gm-Gg: ASbGncssNAJgdkXFvPEIVTx53GTtQZRHqt/lqHGZo4rhDKU8J/DeG6ItAGJrYTyn3vp
 W9E7FC+1i3+fN4DMvZ59xkUuiK2cyiYv6CY8knxQ30fO/7HdG5GvfI3hAHrTR1heBFdoV8ID6YF
 YemqjC54xJhjwPKaS3T2Kyl0LPLRsSqA8/VzlKQDcYRQIyVdBfEJR4OwoXcYUIcOlCUlnWz8D98
 +Npqp4yq2nZKyxeEUImUf/goznjeKTsQnwZcT+HPC61POQqnVzj5nNMjiOOsFgLyUjjNIkqFkOn
 9jv4KeOKLlUzf6Gvp2ZC8URF+/Up+ynBGPT6VUfpLj5BD065c9BxcPVGVTFE1wnFmf7lBFkBVvR
 cs89JJj1GArxCbfxGqtMkIh0UvFeIGieTB4VLAIU=
X-Google-Smtp-Source: AGHT+IGX0uAVjkhTKFaH+g8HyIjr0LWvD6tRUaI3zhX7HJkfhVrTzQZ4QoNpqWQVHihxZ8D632Doqg==
X-Received: by 2002:a05:6a20:244a:b0:21a:de8e:5cbb with SMTP id
 adf61e73a8af0-22026f15aebmr20851665637.25.1750693362164; 
 Mon, 23 Jun 2025 08:42:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f126b6fesm8256215a12.71.2025.06.23.08.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 08:42:41 -0700 (PDT)
Message-ID: <8eb7082e-d125-446b-a14c-eaa9642178df@linaro.org>
Date: Mon, 23 Jun 2025 08:42:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 023/101] target/arm: Implement SME2 MOVA to/from tile, 
 multiple registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-24-richard.henderson@linaro.org>
 <CAFEAcA_+nS5jJxaOdoLD=mQSUatL01+NckO-dTZqrti3JqzYiA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_+nS5jJxaOdoLD=mQSUatL01+NckO-dTZqrti3JqzYiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/23/25 07:20, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 00:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> 
> 
>> +static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
>> +{
>> +    static gen_helper_gvec_2 * const cz_fns[] = {
>> +        gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
>> +        gen_helper_sme2_mova_cz_s, gen_helper_sme2_mova_cz_d,
>> +    };
>> +    static gen_helper_gvec_2 * const zc_fns[] = {
>> +        gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
>> +        gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
>> +    };
>> +    TCGv_ptr t_za;
>> +    int svl;
>> +
>> +    if (!sme_smza_enabled_check(s)) {
>> +        return true;
>> +    }
>> +
>> +    svl = streaming_vec_reg_size(s);
>> +    if (svl == 16 && n == 4 && a->esz == MO_64) {
> 
> "svl < 32" would be a closer match to the pseudocode.
> 
> Exceedingly nitpicky nit: the pseudocode seems to require
> that if the SVL is < 256 bits because the implementation
> doesn't support any larger SVL then this UNDEF should take
> precedence over the SVE/ZA-enabled check, but if the SVL
> is < 256 bits because software has set it that way then
> that UNDEF check happens after the SVE/ZA-enabled check.
> (The former happens in the decode-pseudocode, the latter
> in the operation-pseudocode.)

Gotcha.  Will fix.

Not all insns seem to have this split. For instance, FEAT_F64MM ZIP[12] w/ Q operands only 
has the second operation test.


r~

