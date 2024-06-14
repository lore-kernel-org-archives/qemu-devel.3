Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A173C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 18:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIBTb-0005PG-E2; Fri, 14 Jun 2024 14:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sIBTZ-0005Ou-7y
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 14:16:37 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sIBTW-0006KU-RB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 14:16:36 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f971cb3c9cso1297052a34.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1718388993; x=1718993793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g+Mhqbia3eQmAClwnX55SVi1EbUauFA6Ps8P3T2JbI8=;
 b=BYc0I0TrGGbfuLJHyVPiQMfNtlPxby+4VEyMvv7BzqLrH3AMf75LGXWdbQFGtS8JgP
 R/TE8J/u30b46+orzo7cd+JP3NCHjnaFzJChrCmc4dZvejFXyM/jeMpVgWPWT63ILA0W
 EeLw2wqKch5kpAC3WIMBp1BQYD9zPlZMhfT+Pl3xtdgQCUf5trtIrs3cntv2mb3Pvn6T
 m2nmWiMhEyR9y0NwglIiL7K1Yl9BhID84I8KF+pOduR0DAgAg0a85cSJqhjyr3rekUUs
 2/oZZU/1CZsf8qWmic70vxWoWLH8Z8kGXVz52H2MRC7gssDBYpsi1bs9YtOuuyiILMf4
 4DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718388993; x=1718993793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+Mhqbia3eQmAClwnX55SVi1EbUauFA6Ps8P3T2JbI8=;
 b=dNh7xp0JXKIF/wzzpjAgHh3LFT/Y4DqePQ2/5eQ+Ozvw7bK6pxpETe9nR7gw5nT08B
 Ll3wdx9XVWCI5xd2UlPcle4b+x2+qqMufDmYkzAC0qtd3x6InjajGfP9vrjU+IgKf953
 M9/GfxNTuwGDCJMUQ9kWREfNp3b4/nKVOsVlsuluxboA8zcxJFdyK63OBfwOabshr03L
 BClbY0wgHijyxB35AlcMLtFj7iFR6DVWBOoIon6P6M2UlBWoTuUOvypI/+EKUI750PG+
 u4g7UMSAkw0ezm9RyYpjrNe/8YrdPx4/ePv8qag2X4mLPUPFbChCXYTv0wpTeoSdMSLe
 L5MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd3qRqoKDp0Kz27bjV58PMaRXNmlCCJb2YPv2uiTVcCsDDmtVmI60JPZZCZ0Ar08lRt7MMMmBZelMF0lm0B2jFOvU6jFA=
X-Gm-Message-State: AOJu0YxpaIdgZoz66Iw+4hG2dhvqnu94G/9sFs1mQ0ay8uDBXSiU56yr
 tntMWZqtgI1m3jsJs647FxoOQ61y3OwVaFUH83/uLqq6tPhB9yJjPhjItQPYJg==
X-Google-Smtp-Source: AGHT+IHmAXtY9XY4smz6nHoJygph6p6OwVt02KcnbTJBIV+KFje7fSpmEEY4ijKqZnazeuTPmuIVbA==
X-Received: by 2002:a9d:5605:0:b0:6f9:a1fd:85c8 with SMTP id
 46e09a7af769-6fb9364b2afmr3739233a34.2.1718388992711; 
 Fri, 14 Jun 2024 11:16:32 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44212efe609sm14757601cf.52.2024.06.14.11.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 11:16:32 -0700 (PDT)
Message-ID: <58b3ac8a-b4cc-4211-8b40-528ff8f186d3@cs.unc.edu>
Date: Fri, 14 Jun 2024 14:16:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
 <101886bb-12f2-43f9-8a7b-d2bf8e8f596c@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <101886bb-12f2-43f9-8a7b-d2bf8e8f596c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=porter@cs.unc.edu; helo=mail-ot1-x335.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

Thank you for all of the helpful comments!  v4 will be much cleaner as a 
result.

A few follow-ups inline.

On 6/7/24 12:57 PM, Richard Henderson wrote:
> On 6/6/24 07:02, Don Porter wrote:
>> +
>> +    /**
>> +     * @mon_init_page_table_iterator: Callback to configure a page 
>> table
>> +     * iterator for use by a monitor function.
>> +     * Returns true on success, false if not supported (e.g., no 
>> paging disabled
>> +     * or not implemented on this CPU).
>> +     */
>> +    bool (*mon_init_page_table_iterator)(Monitor *mon,
>> +                                         struct mem_print_state 
>> *state);
>
> I don't understand the purpose of this one as a target-specific hook.

The iterator needs some architecture-specific initialization, such as 
getting the virtual
and physical address width.

>
>> +    /**
>> +     * @flush_page_table_iterator_state: Prints the last entry,
>> +     * if one is present.  Useful for iterators that aggregate 
>> information
>> +     * across page table entries.
>> +     */
>> +    bool (*mon_flush_page_print_state)(CPUState *cs,
>> +                                       struct mem_print_state *state);
>
> Is this specific to "info pg" or not?
> It appears to be, but the description suggests it is not.

It is.

Thank you,

Don




