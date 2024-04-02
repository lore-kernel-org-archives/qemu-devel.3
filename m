Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BA7CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrboG-0008NY-Sh; Tue, 02 Apr 2024 06:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbn5-0007xF-Ia
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:54:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbn3-00053M-9z
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:54:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3416a975840so3875151f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712055271; x=1712660071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TtquBNa20iIbJ1ooqXOGTdWsB56NN8KCENoj+bkWuh8=;
 b=hYnhuGurBM72kB3puc1qObgknAIWVWy4GV6NiZm9y83fsarJVvCFz+sW3OPEh1tnP2
 Gao4AOznfE2kSoIwlxPG5X3eIOeMnc+Nr5HN8TVbxNFVNyZoPoT5PnJudMcvS+quCNWv
 al+beUeg1d8pwJCDDIbaa7ldn7bWfIqB+9XgD6OVAgBfqCDqU9+6UBVIKahznT4s6/Np
 noZwZ4bv7PcSGTxm4sgaYncCNH59hlbWr29GA4WurFhNV99dm/TkNWwa6vfeOuPBk2wc
 tlwQDATiOjACYnZXI//fd3/oVqoZvywG3IrRWemGb6IfKnn8S5WyFWyIuFqhSBsy1wxp
 oqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712055271; x=1712660071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TtquBNa20iIbJ1ooqXOGTdWsB56NN8KCENoj+bkWuh8=;
 b=s7PTZPF6s2w9mU5yTbbNg+t59F0DfJcBT4bR5jWaDv+8foiqjCNUMf22vbzbkIgQnh
 0kXYGoVb89f0I6GDB2fJ/ElaWMNxtheFT9596deaFGbwK+xl0r54ULappbWiCh0ObSpT
 1JFdBfzVcXnTBKH7+WFotBkY0YrLfmqRGCHobpz2Vc9oLM+6OUE6YEeTLu3e5Kkjh5YG
 EfzUseFohrRVR+d6nWA21Sc4BeLx0JJxUTD8Fb6FYtnXpaN1LMqleGVHFqIwe28M+oVe
 LwluWxwy9D1Tyo6BR+yy2cjQIQiiuy2xQbSZl+ljAJo6tuBn0aimgCN/1kFmMsfZPIgi
 EwQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5cb93wMubabfPN86tjN2CVS/J3vpBTdYILoKwqOT93vqrZ7xMEgqexPB2gRhKDDxynw3oEL4F+JpcrG7S6VKL5HujHzc=
X-Gm-Message-State: AOJu0Yz6bTDur2CYFj5gcfJBFw5guI9UfmQQBjwNYzaRvMcGzslhRzM4
 1f1y3TLFLbSQhPtEdts8d/5Tw++EkTt9y5dl5QWaLQLTaq1t9FT/PtjeN/SR+eY=
X-Google-Smtp-Source: AGHT+IGCrK/tKhi2oZZlzi/i6WfvRNNX7TZot2JT1f+vcNLEnWw12QM3zO7bAx6b14UhbQZj4W1ekg==
X-Received: by 2002:a5d:4f8b:0:b0:341:d4db:abf5 with SMTP id
 d11-20020a5d4f8b000000b00341d4dbabf5mr7829457wru.60.1712055270877; 
 Tue, 02 Apr 2024 03:54:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 g1-20020adfa481000000b00341e7e52802sm13934950wrb.92.2024.04.02.03.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 03:54:30 -0700 (PDT)
Message-ID: <dd1db83a-2059-41e3-8669-6c6bb56f9eea@linaro.org>
Date: Tue, 2 Apr 2024 12:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen_evtchn: Initialize flush_kvm_routes
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Oleg Sviridov <oleg.sviridov@red-soft.ru>
References: <20240329113939.257033-1-artem.chernyshev@red-soft.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329113939.257033-1-artem.chernyshev@red-soft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 29/3/24 12:39, Artem Chernyshev wrote:
> In xen_evtchn_soft_reset() variable flush_kvm_routes can
> be used before being initialized.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
>   hw/i386/kvm/xen_evtchn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks!


