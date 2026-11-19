Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8F606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j6Y7DRLR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7Im-0007HV-Jy; Thu, 19 Nov 2026 13:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU7Ij-0007Gw-DC
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:56:05 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU7Ih-0008IM-T6
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:56:05 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8b4c8b51b58so97298b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795114562; x=1795719362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GYB1dTOmJBuh3HO8sbLhiXZWRlkdiO237Pd86QmoAGk=;
 b=j6Y7DRLRYxKHGFUuntRNGBu3C6oWAfzRV0djUpB0T5jDBz/r0M//SQ7FA0DM7iD3NW
 bxfNVAQlp40Rpb6uYnk+JY6lPRvRNlzCA8qa3+Jz3Hgr9dbslgQ6eErEbkfvtID8DN2x
 mKAspjbAIxjDg901SzFgGa87tQAkq7+t4yzSUK0D5PUxebSgAc5flBVXbvsUTk5Qz2P/
 xy0gzr8+gOPlKkeu+7xF3lmHgCgiDHrvwhD5Z0O5Mc663uwncAwkm0ZtxoE4P8eYBttT
 oWqzsgJKNjlXfPBq5W21KcIi5o/boB1uYa9/AZh71CqavvBQ4yd5lgNeD1w7+Jb4kF3d
 rGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795114562; x=1795719362;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GYB1dTOmJBuh3HO8sbLhiXZWRlkdiO237Pd86QmoAGk=;
 b=PUScQcoDwum1bHTpfe+8o3f8itLUMB/dGqIwNcog3P3i1DPO43qzWLEvLk6IW2mzKj
 dXQJLT8ksuiAzfaJwihpTYH4wSVF5H/nv9UP2aWUtCXwqXC3nmTElVItA9D5nKp9XPgl
 CwN/ypaRL5t/2C2IkN+QshVjxx5QtLcu7aOuy6QLLmgwke0K17sdfTSI9Nvm/o2OUUf3
 Tg/NVVf72PmKiyIdqcFfWTmXx1+/DWtlnqq7taFGBkyZaQ7KYCue+Ud6UfDlil3gpLUg
 hvFCV/rod+5m+mwWNiCMsiJ/Hv3G/MchmILSc01M6qWV0ndM0QKayiCu4BMow8kMifmV
 vcOw==
X-Forwarded-Encrypted: i=1;
 AL+hErGRiZur7XPIcfuC48n3o1iiT3OOZbI4cnzFry1AhrucJ0kv+mGKC0X0jTBuLvmaIKawzms9GapK3kgO@nongnu.org
X-Gm-Message-State: APuU4Z/NgXPcazOBC9hfgyd5cT5pIfHC6jN+dtL4m7EWIifJ4phEwdnF
 Gg2jqmpFOusDA8UojCTiqSZZeEIXAHinTloxLzixcgdntDtuwufZb7bFbQBC0MxTeT0=
X-Gm-Gg: AYBFou3FCzVm5q4eBKJ5vFjkjxO89n87f8kDjENHk+D5TnOvF9SqAOJaGcuO7oG3OGs
 fbX19foJo/PX3QUB8DR/QEIQbDmHKr/Xwek8UKnmiIAyiFqBepWqnmh1x1gbsjC2cHKYaJKFQtR
 3XeRjKjnpUJcZ7mVGcO2bjSb4x+BqAHAefXy8srS2CB2uq6kb7xq0KASSOScN8S1Afe2t4ETkC6
 mXu8bq3/XMzmNBHg1y8laejQ95FgNbJgTKrClr3jpChiSfj4b5e/TN7yvaR4hyYNbpzFqzqeUAd
 2/F1t5B8Hqm4nH25JOrjLTio1Odet+HKHRNs3tr/98EVJZqlOuD8ai+/fCB8LhdeBUk3WeqJZzO
 OdpvpyYAhs/gO41BWAvwVfmYNIU0wZ++ktr4RX2xhgPAm02O4BDa2OtpStscWRcDoA9LLm1Ez7V
 x85BwJIy8ngxvemmq9McF6DjflOB6jT3UECZnVhNRysJ1PCkcGiBwznN8EqWmID718+mJO2d6T/
 KQBgyV9odZnAVE0YP40Zj6KBuSp9YL7HrQhgPjXzDGAZPA/jDXQE4fI/xVVqrXs3UrxFvrYbHaF
 GBY5Nj2e4s6PU5x2FSO1ZFij6pb+JkqqcVXjrlmeG0DUzyrCVptXUgBqGGnMRhXt7svwdEs=
X-Received: by 2002:a05:6a00:f86:b0:89e:9084:b02c with SMTP id
 d2e1a72fcca58-8c87d02544fmr515635b3a.48.1795114561683; 
 Thu, 19 Nov 2026 10:56:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87285c15asm325734b3a.20.2026.11.19.10.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:56:01 -0800 (PST)
Message-ID: <b2516ddb-9e26-43ca-b06b-197b6e6feb7e@linaro.org>
Date: Thu, 19 Nov 2026 10:55:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: mark CPU properties as const
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
References: <20261119180859.1044425-1-jsnow@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119180859.1044425-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 11/19/26 10:08, John Snow wrote:
> Currently, these large property tables are loaded in the read-write
> `.data` segment; by marking them as const they can be loaded as part
> of `.rodata` instead, where these tables can be shared between multiple
> instances of QEMU as RssFile memory instead of RssAnon memory.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   target/i386/cpu-internal.h |  2 +-
>   target/i386/cpu-system.c   |  2 +-
>   target/i386/cpu.c          | 30 +++++++++++++++---------------
>   target/i386/kvm/tdx.c      |  2 +-
>   4 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


