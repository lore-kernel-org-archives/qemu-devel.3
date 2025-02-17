Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012DC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk7C6-00024s-PH; Mon, 17 Feb 2025 14:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk7C4-00023d-VD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:54:16 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk7C2-0002rv-Ry
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:54:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d39a5627so67978145ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739822052; x=1740426852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ejduIgMoUq0aO0oQe3rVWMcEkhLh/z0lgcrC/gynME=;
 b=VlZ9p/01z5s6No9kNf8pI8vwVzLfU48L6F5fxF950lfJOb7+PdxFJmldviTDizFXEm
 Mja658d6SIz/DZZX39hhLJQy7uChFPZkKy8CVuTzU889wi4uWc28fJnTvusr6Gb3Iw2C
 D2xmW/5rysVOgzP0DacSMSoxDatjgU2b6MHDdc88bVzBW+gWs5gPsRQpP1ricCfUrSp1
 C35klpOYpQbm+KrmVu1vIy9reNByVjTslFnSRXg1ptoupL09993gX93v4SEH5quOL8bv
 i0PT/AWmJTFJG6DLArG11sqZRK2oHZMpn6JReMaL0c1lUxT9bIdmAzEkWx4Z9K260P2S
 mu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739822052; x=1740426852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ejduIgMoUq0aO0oQe3rVWMcEkhLh/z0lgcrC/gynME=;
 b=ATntC6Ysdcb8RTQ4fsGMZjnwDy1X+WpCVIARtb5sIClagerSMAZocQ9GtP6TH99ldX
 v36gwGJ+i0xfpvumdIi7wQlNTYfatl+q53ZUgvr2H+x4TSNTiWDGtzxPy1GY90On8gSR
 /n0VNR9RpInFBvIV/Cw7zgiLveBxCT0sV4pWTpvaYelKgDb4KJXmzMcvWjbBrrSpKgoX
 H1IMWHbwT4LQbsBOw9YOKut7CV+NNGZIP+i7r+uetjSZbDaCijP+U1ZJRlbdZ9MpuYmR
 dCYTlSyViQqBxJZKsWHihpTbtx84KdkO6fDSfm/ueURk709Fg6nZMrfd3xkQvQ0jg9Aj
 euAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPhjA48USKaFOsHWulSnGf8hDi6BOOvPLYrZ00sle2kg+H7QzeNRkoiSdT9XPwy8f5Wr98oz3pOxrt@nongnu.org
X-Gm-Message-State: AOJu0YykrHafIlkJtQfKK+l2vUEUDKbxPYncQCXpuuVIH6hsDkNX7ndE
 K1rBofBcP7hPANCjenQ5dUPsP6KzigHaCibnCe96SGwU6y3VyWGv7bpgkC5h6KRqCC4Ochfh2zq
 j
X-Gm-Gg: ASbGncuK/o/lQ4GbZ5kqzCOXVSPxZlH+Xa/CTmN28SgfCZssSUt3VKm2edMhyt78M9D
 mWXBvZsOpKIzVS0kiMSZHJuY0/OfQd/ygMupK3ndRnOWfHN2p1fsMmAxLyE81Bd97vUtaxR7h1G
 cHGGwvgWzAgok8fovQnf1ukLVpV6Cvzg0n+wJn/YR9tmkhjYnrcoljAB3hktLktgXMIvUC4gGVB
 unCWEuhK02/Xo5WWIRoAaSW/TjGkGwFb2cvFokza11E+G3KU1y4t1C9B66gg0oWx062GdGyHbZg
 xc0RMKWYJ5ACR8Od+bgbq805ly4z3bo7AkMa4ki45embcykYXEIBg0w=
X-Google-Smtp-Source: AGHT+IGmlLs5fjJnEAJ+flbIRMCATvgFocH1RSk2wuZAVzB2Yoso+gSx7WuZeeHliPQ6E5cREpp6pA==
X-Received: by 2002:a17:902:cccc:b0:215:352c:af73 with SMTP id
 d9443c01a7336-22104025612mr155205675ad.18.1739822052563; 
 Mon, 17 Feb 2025 11:54:12 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d6a1sm73748655ad.179.2025.02.17.11.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:54:12 -0800 (PST)
Message-ID: <3450c66a-d232-43d8-a304-fc8ddd57cab7@linaro.org>
Date: Mon, 17 Feb 2025 11:54:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 066/162] tcg: Merge INDEX_op_ctpop_{i32,i64}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-67-richard.henderson@linaro.org>
 <098ef8b4-6808-482f-b13e-2f8faef56bd3@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <098ef8b4-6808-482f-b13e-2f8faef56bd3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/17/25 00:01, Philippe Mathieu-Daudé wrote:
> On 17/2/25 00:08, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h    |  3 +--
>>   tcg/optimize.c           |  9 +++------
>>   tcg/tcg-op.c             | 21 ++++++++++-----------
>>   tcg/tcg.c                |  6 ++----
>>   tcg/tci.c                |  6 ++----
>>   docs/devel/tcg-ops.rst   |  6 +++---
>>   tcg/tci/tcg-target.c.inc |  2 +-
>>   7 files changed, 22 insertions(+), 31 deletions(-)
> 
> 
>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>> index db0e79059b..0eeec47b83 100644
>> --- a/tcg/tcg-op.c
>> +++ b/tcg/tcg-op.c
>> @@ -765,8 +765,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>>           tcg_temp_free_i64(t2);
>>           return;
>>       }
>> -    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0) ||
>> -        tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
>> +    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
>>           t = tcg_temp_ebb_new_i32();
>>           tcg_gen_subi_i32(t, arg1, 1);
>>           tcg_gen_andc_i32(t, t, arg1);
>> @@ -791,7 +790,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
>>   {
>>       if (arg2 == 32
>>           && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
>> -        && tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
>> +        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
> 
> s/TCG_TYPE_REG/TCG_TYPE_I32/ ?

This more or less matches the change above in ctz_i32.
What we want here is to know if tcg_gen_ctz_i32 will expand properly.

Some 64-bit hosts only support 64-bit ctpop, but tcg_gen_ctpop_i32 will happily 
zero-extend for that case.


r~

