Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AC7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 19:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9VcT-000222-T8; Tue, 21 May 2024 15:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9VcS-00021K-97
 for qemu-devel@nongnu.org; Tue, 21 May 2024 15:57:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9Vc8-0003Ru-H2
 for qemu-devel@nongnu.org; Tue, 21 May 2024 15:57:55 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so105989325ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716321450; x=1716926250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kmBC9KKSA3tmvbAayk6U7TdpZdm89WhLH4BbGjvFBCc=;
 b=Vd7TBTFDJCcc7R7PCw8tYnXyma6p4S76kDDKl4ey8/BcGuk0juBL3m+b05VkbqgCrQ
 zl2UFPdujxps2CS8Q4W9IbyHpQH15lD1AZIkClWeHZ2+1CFqGZmJrJU3EdEirjuYJWgU
 cfERZyuuQ7vLe1+O7RqDGvZmGsilO1xI+4TFeAx7/vttjqR1xV7kiOsP8LFmjn+fj0qu
 yZS6sYfw6FnFLgsYkEXshUBiZ66AwS/EWDhGHk2SB3mVIOLQ4mH0CS7xRPZ2j5RE8ZYv
 LDeTOsQgKLfmm7rwPuKHflbpaDCkMnJUJnyfGbYECJMyzJjtN/zjPgGS+oqam3/EbHSd
 SzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716321450; x=1716926250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmBC9KKSA3tmvbAayk6U7TdpZdm89WhLH4BbGjvFBCc=;
 b=LVH7TZap6jOehS8ZDREng7eXkX1fe1pWLZVUglADqCDoJlccaGrAEiH4Q0MZ3D7+VW
 PfdEixGBacy/OQ8aA2R50wD4AnYggKGExXhgFLg1Jy0ACTirmelVRD1pD08ImYyCwpUi
 fKwe1nCo3uonL+iRmxObvDvcUqFi9WBcXsjcT8xNB4Mx9nQclBD76DEWVVzm6LQI5cyx
 Hus5FmhnZ/WIViakoNI6SvHh5YhDY4tHgLm/p7+T3yGrz/26dx8/r6bW9V3C1p0paBiu
 vtqKuLmtjupJ1j5N1DZo3MT0D859kSSNWzGQ8GqA/omGZVg7s10tX5Cdvr+42hyQRhAN
 g/3w==
X-Gm-Message-State: AOJu0YxoVEjtAs6vNbmfS1HKW0yjrlp7AzqpDW1UxsKSHUTF9UPNO2QV
 2IyMDoFNgGkagkoSjx4TnxMrZ26vR4C3FSJnJZMLPGd26AY6Yc1ci88JyFOwmbU=
X-Google-Smtp-Source: AGHT+IEADUSb53m7CPWJj+a5AgIeHLZWk26/8FfKgAABYkSCyYlwDLWXcZy5gmjbxSYVz3uy30rEWA==
X-Received: by 2002:a17:902:ec8e:b0:1f3:1241:d4d2 with SMTP id
 d9443c01a7336-1f31241d7f2mr22981405ad.61.1716321449717; 
 Tue, 21 May 2024 12:57:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bad5f30sm225744585ad.64.2024.05.21.12.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 12:57:29 -0700 (PDT)
Message-ID: <9fd510eb-979d-4497-9de8-181263c4fe75@linaro.org>
Date: Tue, 21 May 2024 12:57:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/57] target/arm: Inline scalar SUQADD and USQADD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-33-richard.henderson@linaro.org>
 <CAFEAcA-e6+z+07SvdqSf2AqPG=JvH4Zk2Fx_=zTtRZaFDOT-zg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-e6+z+07SvdqSf2AqPG=JvH4Zk2Fx_=zTtRZaFDOT-zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 5/21/24 09:46, Peter Maydell wrote:
> On Mon, 6 May 2024 at 02:08, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This eliminates the last uses of these neon helpers.
>> Incorporate the MO_64 expanders as an option to the vector expander.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> +/*
>> + * Set @res to the correctly saturated result.
>> + * Set @qc non-zero if saturation occured.
>> + */
>> +void gen_suqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
>> +                    TCGv_i64 a, TCGv_i64 b, MemOp esz)
>> +{
>> +    TCGv_i64 max = tcg_constant_i64((1ull << ((8 << esz) - 1)) - 1);
>> +    TCGv_i64 t = tcg_temp_new_i64();
>> +
>> +    tcg_gen_add_i64(t, a, b);
>> +    tcg_gen_smin_i64(res, t, max);
>> +    tcg_gen_xor_i64(t, t, res);
>> +    tcg_gen_or_i64(qc, qc, t);
>> +}
> 
> Can you explain how this one should work? SUQADD is
> "a is an signed value, b is an unsigned value, add them and
> do a signed saturation of the result". If we take, say,
> 16 bit elements a = 0xc000 and b = 0x5000, then a is negative
> (-16384) and b positive (20480), so the result we want is
> 0x1000 (4096) and no QC bit set.

This uses a 64-bit intermediate -- there is no intermediate truncation.

Because both a and b are properly sign/zero-extended on input, the only saturation case is 
result > max, thus smin produces the correct result.  The xor will produce a non-zero 
value if and only if the smin result != t.


r~


