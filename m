Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ABBC48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQSl-0000PQ-KE; Sat, 17 Feb 2024 14:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQSk-0000NC-3h
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:35:02 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQSh-0005XB-At
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:35:01 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-36426a010fdso11422805ab.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708198498; x=1708803298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smTnTvwdcZ4IBQM4tyaBNlSpJCcXDQsLAicupidlo50=;
 b=cRVTjMf5iqGI+ipincaZRCAyEtJU0qEm6rBhXq+NRDPLCOisowQsK/JcDyCa3QJXmM
 Dkiz/8/eL/CWusN6NO6IznUb+PoAovj4Nd6FmzYuwW6InL2dVypnYukjvN2Lx8KDebRq
 8gHQHrx8R2wvN81OI4+l4CE2uZ4+nnts/yK1ImQoh0TQoaQ18Y81F+KlIxA3yJARXHNf
 Q6shFPYOpEy8vuZd4PxRBCi02bn7MNqo/veCqvyVO+1thWLU69bTI62nenIH/W721Qll
 cJ3kulmKn+1jhooGsJPduAZU9zqxLrYry3BDwu5ADLE2/BM2YX+PJvFZPeQicI7hs8Ht
 H9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708198498; x=1708803298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=smTnTvwdcZ4IBQM4tyaBNlSpJCcXDQsLAicupidlo50=;
 b=wNNPnQP63+qcA6dNiOunuFz3wOtlo2aOJjJqLOTelWByyYiVjqBFVW9Jn/V8cr5m+F
 X3fZm91J3yP1QfiiGMwNiTbuNuH+d6uLdWNW0l/J5GKfTid47TbW3bfJv8QAo4IhxQo6
 I90+gp5qZmH3N8QkT5RDMDSH5tQVJlzsvr6dmrtmMAHZOMZhPb8V8H5anvjZUs2XpRKO
 Dbmls0UZ3dxPjF/gSgU4kPAT/QxVgsj9R7cpSX6ZWFc8LS3uJJ9bp6He7lmIVm3NB6Tu
 NnuDZqXqh/W+mh/xE6f2IHUi51I+EaNO07jZ/Z1NiEACNXa/xMNrB9W0SWSyZeuGzi2G
 /EQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfRD/FYjtVJuxGyaLdvVZHUwvp19IU7TPfIPlNTVvIdyASOAPu3WTAP3+3dnePbMLbar+MMCeJ6vKl6cjyOpHgL1D8gM=
X-Gm-Message-State: AOJu0YzqMrODdvKqZH5rMF0Nyu02V7yNp4M7rg4C9KG5KPRdNcuclyH0
 lSIwqWWYwt0nSLAVtPYvNF5FC7n+iI9JHHaQ+QhK9JRwXTSTuzOZ8blCSV+D4JY=
X-Google-Smtp-Source: AGHT+IHDP1p1MH6nfHZ/uugrvlWCHHowaKZ8GZ8UhTXhlhbrwGiYZrD1V1wMq+9HK0a+FctpPJmCHQ==
X-Received: by 2002:a05:6e02:13e2:b0:363:c63a:7975 with SMTP id
 w2-20020a056e0213e200b00363c63a7975mr8212005ilj.24.1708198498161; 
 Sat, 17 Feb 2024 11:34:58 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c5-20020a63d505000000b005cf5bf78b74sm1942520pgg.17.2024.02.17.11.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 11:34:57 -0800 (PST)
Message-ID: <72c7503b-0f43-44b8-aa82-fbafed2aac0c@linaro.org>
Date: Sat, 17 Feb 2024 09:34:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Clear vstart_qe_zero flag
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20231214111851.142532-1-ivan.klokov@syntacore.com>
 <3d76be6d-e3a2-4730-a54f-2893ab4ed72e@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3d76be6d-e3a2-4730-a54f-2893ab4ed72e@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/17/24 00:53, Daniel Henrique Barboza wrote:
> This patch is replacing mark_vs_dirty() with finalize(), that does call mark_vs_dirty() and
> set start_eq_zero = true, but it's missing the start_eq_zero update for store functions
> because of these ifs.
> 
> We could just remove these ifs and finalize() all the time. To keep the existing logic
> (i.e. not set vs_dirty for writes) I would do, in this same patch:
> 
> 
>>       if (!is_store) {
>>           mark_vs_dirty(s);
>>       }
>> +     s->start_eq_zero = true;
> 
> 
> This would make these load/stores functions different from the rest, without a finalize()
> call, but given that they're already difference sine vs_dirty() is conditional I guess
> it's fine.
> 
> 
> What do you think?

I think it's required to have stores set dirty unconditionally, before the operation.

Consider a store that traps on the 2nd element, leaving vstart = 2, and exiting to the 
main loop via exception.  The exception enters the kernel page fault handler.  The kernel 
may need to fault in the page for the process, and in the meantime task switch.

If vs dirty is not already set, the kernel won't know to save vector state on task switch.


r~

