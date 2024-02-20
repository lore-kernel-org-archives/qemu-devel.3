Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C29FC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXNn-0003Vq-69; Tue, 20 Feb 2024 16:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcXNj-0003V5-En
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:10:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcXNX-0008M6-RM
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:10:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso60005135ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708463413; x=1709068213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hrYafVmPknXj6OBu45DwwkQ8cyY3M2/gxdad8UKpldU=;
 b=LtBoh11iNxKaPDbewQvuUOjiHgWRjAO0y6CKQP+FGfoiiAuiGGKWj4zOWD2lYA2/5H
 kXYWeFkSWpAiYshKSYtRl+CQUTVLuCIS12kiySFRHVT+FhqdB3o/Y9CLXJYlkiecG1z7
 4/BnNrz9SWyPSUMuarf/34p2sP2rsMANkrXvavmWl92Ywwdbbw9+ycCjbEgXkuiy/n+6
 6GFgNHCfNt2fg4HMUhsChyIpQxxpwQOWb3rOt5BG22vfQMHQMsAROh+z8z7kP5PXX/XN
 EpAe9lIxuF5teAvJX7TUjZQ41on4SHytno4lfXCxNet558n7rBYoIZFGQsve66wYT3W6
 tu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708463413; x=1709068213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrYafVmPknXj6OBu45DwwkQ8cyY3M2/gxdad8UKpldU=;
 b=A121032ipMzHBhHodafCzcoDMM263slpjkV6GgN+L+0hikv45H/Wl23wPZQ4v+sd5y
 x1g6TNEozZKceJ7Dy/50jja9kqL7LBIOjnHY0BbPmXr9YixISKAcbM7zUIyll2s1W4gh
 pbz0HY722DO+FD5FRDNF5k8S2B9Xjd7qylLSbV1gyNcbJZd/KBAwvDmdF2VZN3tDeUmc
 ob5QZ/aOoAmmRb8L2Xy4jyZGpyDO0+Ek0H/Lf07zt/guA2mCb60ExeqjupRvNKx8TvJj
 ZNOIoML0AAkLeVNGFfn2rLLWPLWjmFMVRvcQWyFtTJt3bShHEoHW5FBy83M0Vn8aDmf2
 gG7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSfNr7861yWLVaf29IMJZbQPmqTd6ta1J90/WVoskqV2bEaUCxl391XLiGAfhf/S3U8O6w66m7Rz45o/TySQd3lc3ZdNw=
X-Gm-Message-State: AOJu0YxKTA+ZLRuwbMm3trIr7bu19FxoYlZhANewa2K5z0K//RLp2/fB
 R8wcJJPln8u0cKvDXE8iVCIWEYGFwO55D/j02XDgnanuSSh9DlAamAgqj4/8q1g=
X-Google-Smtp-Source: AGHT+IHRyCetltwcDJCkO1OoMegCcPaLDBoyLyGML8zd3rnNQtDskxvwirMX1wxF7V+etVxkR4LR/g==
X-Received: by 2002:a17:903:41ce:b0:1db:dd57:d56 with SMTP id
 u14-20020a17090341ce00b001dbdd570d56mr14112090ple.23.1708463413162; 
 Tue, 20 Feb 2024 13:10:13 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a17090276c600b001da1ecb05f9sm6643377plt.240.2024.02.20.13.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 13:10:12 -0800 (PST)
Message-ID: <ad667881-f55c-468e-b6a1-8138147f71ef@ventanamicro.com>
Date: Tue, 20 Feb 2024 18:10:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] trans_rvv.c.inc: mark_vs_dirty() before stores
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
 <20240220192607.141880-2-dbarboza@ventanamicro.com>
 <32df58bf-cf71-4825-8b56-67108c81944d@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <32df58bf-cf71-4825-8b56-67108c81944d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2/20/24 17:17, Richard Henderson wrote:
> On 2/20/24 09:26, Daniel Henrique Barboza wrote:
>> While discussing a problem with how we're (not) setting vstart_eq_zero
>> Richard had the following to say w.r.t the conditional mark_vs_dirty()
>> calls on load/store functions [1]:
>>
>> "I think it's required to have stores set dirty unconditionally, before
>> the operation.
>>
>> Consider a store that traps on the 2nd element, leaving vstart = 2, and
>> exiting to the main loop via exception. The exception enters the kernel
>> page fault handler. The kernel may need to fault in the page for the
>> process, and in the meantime task switch.
>>
>> If vs dirty is not already set, the kernel won't know to save vector
>> state on task switch."
>>
>> Do a mark_vs_dirty() before store operations. Keep the mark_vs_dirty()
>> call at the end for loads - the function is a no-op if mstatus_vs is
>> already set to EXT_STATUS_DIRTY so there's no hurt in store functions
>> calling it twice.
>>
>> [1] https://lore.kernel.org/qemu-riscv/72c7503b-0f43-44b8-aa82-fbafed2aac0c@linaro.org/
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc | 29 +++++++++++++++----------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 9e101ab434..2065e9064e 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -636,12 +636,13 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>       tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>>       tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>> -    fn(dest, mask, base, tcg_env, desc);
>> -
>> -    if (!is_store) {
>> +    if (is_store) {
>>           mark_vs_dirty(s);
>>       }
>> +    fn(dest, mask, base, tcg_env, desc);
>> +
>> +    mark_vs_dirty(s);
> 
> You misunderstood here, I think.
> Both loads and stores need to set dirty early, before any exit via exception path.
> 
> I see that I did say only stores in the quoted mail, but I believe that was merely in reference to stores not setting dirty *at all* beforehand.

hmmm it made sense when I read your reply to set just for stores because I thought
that loads wouldn't trigger page context switches in the kernel. TBH I got too
caught up by the existing "if (!is_store)" in the code, trying to figure it out
why it was there.

In another read in the spec there's nothing that indicates that stores needs
additional handling, which means that we can treat both equally in this regard.


I'll change it for v4. Thanks,


Daniel


> 
> 
> r~

