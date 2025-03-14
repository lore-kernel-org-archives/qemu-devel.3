Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A903C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2De-0003hA-As; Fri, 14 Mar 2025 06:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt2Db-0003gR-R8
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:24:43 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt2DY-0004dZ-05
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:24:42 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so4069027a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741947877; x=1742552677;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JhWtI+vBoY/7LB6Vltp+kD2yeeTqmN+P9ReQa6Jox78=;
 b=CHTrKwRx6PivjjcTdzv8AXafylg8YOA4SkUsDlQ0nFUsT9GK53y497WPT5iajI0F0D
 AhAtM5fioY7y8f0PkTSDj32ytj0osOcyRoJ4hPpqyRgcqUv/0Ab1IjbMV1LiRtY7Hn47
 JHOHfpDSb/rC/k1GDSp5QSenol/VRgdl3JP6/DbS20tTnPsBt2nYKnUbz39uCaOOa5/x
 TqEJdIFhOU0q1yL49gRTIGevkgpkzHky+EQ8amcKhcliLIUJ07v5zNoyFdKoYi/EiQlb
 7vIyWBkcBPTxW0TlmS1RkUXsca/LrhgSFyr9RG8lAp7eocxeVMDlTR3xIpWY0H5Gl8uH
 buXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947877; x=1742552677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhWtI+vBoY/7LB6Vltp+kD2yeeTqmN+P9ReQa6Jox78=;
 b=QJTIJdFFU3Qn/oT7joUwU8ZJJ/9GBI4uQ5Zk6jKN/s+FV4GmErsiEUxZhJTLza6CAI
 q5nETQkVh5Nq+mBdAG6xSJfIE+rb3s00JaCEgs3wNgHnBmGOfRLza29EgyGnNaxw5GLj
 ILdh6ycdiiFlz2GBG3zRONZPzueP1s+rxgSLgotefpaiU4uVfk1xgzRUa/ihMwIBa5ow
 vGZWfK0TsWYio6nMiKaz3WV9ASU9O9tx58H9gv4LeRKS17BD8BM1cvukjE+eZ4Aw7ivd
 18ZqJwRB5I3CJz/mwwq5qP6n+OWuwl6P3teKIfp6CAQJyA+bPVaqQBFaLMvSlhbhsvsq
 /buQ==
X-Gm-Message-State: AOJu0Yz2AQrx1oxD6b6G+fRlEeEfV4895ck7Dv1IeudNuS52jAQdG6Do
 VDcOw/fZrP4+KgchNhy+8bEza5r2fftH97FZr3a8V1eJzEdqZqO5cuGZDGeG6x1WszSw9S0g+W3
 /eek=
X-Gm-Gg: ASbGncuhOlMgK0r0Kxv+5dvLPILLA228cWVGEMD8RZTgGD+SJtPn2rwFyY5P1sOltVN
 gxD3xx95/za/t7Zmnp/au2pTqgFaXoxUX9hgvmMa56b0/H40dnPBRORzly26Ws3JN/0p0tTmtrB
 J9ArmT9cYjF8I0jxS9R1ZxJUoiXXuPOxVkmTJtHerSsG3pN1iSNvD3W/ie/ERkCaB+v92kOGHrW
 eMO6a7wuyPPnh+bxpAjc506yEkmBgSX9jG0MdiPS9X0tEKtc7aOPiZC7NjcHcxWxl1U3s0Jl1WL
 +CGRm5cxn6XRZr4XwpS01cA8UmFKY6UM8C++IFTrzZBycE3apBotc8bEcw==
X-Google-Smtp-Source: AGHT+IHl31MTxn7V+xXpLNBzH1hzMS4ONJxCk8KaYlD7KvCCcZXt8fVCOQunlGjxJ9eGKHJSN590fw==
X-Received: by 2002:a17:90b:568c:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-30151d65696mr2198135a91.34.1741947877099; 
 Fri, 14 Mar 2025 03:24:37 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30153afeba1sm704124a91.26.2025.03.14.03.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 03:24:36 -0700 (PDT)
Message-ID: <52ffbdcb-abdc-459e-8d49-a0c9e1a5de92@daynix.com>
Date: Fri, 14 Mar 2025 19:24:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Define raw write for PMU CLR registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
References: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
 <CAFEAcA9yKETtDhJroC7RD5itUjsYAkj0fVXHJaUxoU_bce7Gvw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9yKETtDhJroC7RD5itUjsYAkj0fVXHJaUxoU_bce7Gvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 2025/03/14 19:22, Peter Maydell wrote:
> On Fri, 14 Mar 2025 at 08:13, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
>> default write function, which clears written bits instead of writes the
>> raw value.
>>
>> PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
>> had ARM_CP_NO_RAW. target/arm/cpregs.h suggests this flag usage is
>> inappropriate:
>>> Flag: Register has no underlying state and does not support raw access
>>> for state saving/loading; it will not be used for either migration or
>>> KVM state synchronization. Typically this is for "registers" which are
>>> actually used as instructions for cache maintenance and so on.
>>
>> PMINTENCLR and PMINTENCLR_EL1 have underlying states and can support
>> raw access for state saving/loading. Flagging a register with
>> ARM_CP_NO_RAW has a side effect that hides it from GDB.
> 
> No, the CLR registers don't have their own underlying state:
> all the state is handled by the SET registers, and it just
> happens that you can read it via the CLR registers.
> 
>> Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
>> PMINTENCLR and PMINTENCLR_EL1.
> 
> I think the correct fix is to mark all the CLR registers as NO_RAW.

My understanding is that ARM_CP_ALIAS is ignored for KVM to avoid making 
an assumption what aliases KVM implement at cost of migrating one state 
multiple times. The CLR registers should also remain as possible 
sources/targets of raw values.

Regards,
Akihiko Odaki

> 
> thanks
> -- PMM


