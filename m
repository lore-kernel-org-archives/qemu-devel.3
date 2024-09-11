Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54809EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE1H-0006S0-Mv; Tue, 10 Sep 2024 23:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE1G-0006O3-Mj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:27:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE1F-00012r-5H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:27:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2068a7c9286so58678985ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025268; x=1726630068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Y1sM2YzEVqrWeoG5Qf045Td12nRbBK0heOEBeYOMtQ=;
 b=dZ/mmZmziHE57JIclJXj+ABLky5ieE1PVZhSXEMCAV0puX/4rS5yOYRYnNtbPu4+/q
 2BlqoU47O0kmnmaWjVQgaNZkosBhNXeMN84qKWyDqqyfNRWodcDYb7mcFm4ZbsGPRClL
 Wbd6jAOEkbRTqMRtarVvXphFRdyFcFm35+8movrEtultgjFosT50El2xLw22BsFIqXye
 /DOoxoHziBnbaqnLCVX9GjZkahGGw9/4TAqcyebmS1UMNIXHkqezoyzThn4HqKlAKJaq
 fxlbdbg0cp8MUXttz2XcLgR27T+KNyRqS5EHDjIpgWVW4xmUIFv+si0NfZnq6gG21Nf1
 awYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025268; x=1726630068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Y1sM2YzEVqrWeoG5Qf045Td12nRbBK0heOEBeYOMtQ=;
 b=W2JAsgS3vbDK3ptfsKaMGyTxEdCRT4KLdVTmOCOW1QnqdnNk4BiJytNzSExQk3whd2
 bdU+NBKoe5xGZOSCr57pVGP8B3+PJcJHOxeEmL6eWpB2U0zjHxrOP0eomvm0aJAhAQk1
 icwKd/TgIN/Z+d488ijX6ohS2S7m9Ro74pjQdxHHZdcvrSBVgIJ7kQEmjTYoz3q6Obrj
 652B/Wz7Mh+ZyRNafSMUUN/vTKhdaubsl5WRJECs1Sp36/eYfKMiw9gh2xsNMUQsS18W
 85UgXVbi3sQItSmdXsjHVuww7s9yaoxoLILY5rb6xODEFWJxfDC0fiuvdlwvxspg9+TQ
 H48A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmcxfz2q1hFPH8inKimnVUQ0dDPMU+zYXRhTUmj+Bb4ql2hM9xf15xEvLsRTD8e7uxFhlO/8pPI9kw@nongnu.org
X-Gm-Message-State: AOJu0Yxe7wfarn4GMHj9L6drzD3L8M7I5nw9dSRwhqSLBfqri2Snzbul
 O41M7zQX6M7g5on1ca1Hplb4ncox+daLYs7KrauDxhYe3uwZF1A87b39jSYxUAlileqPOxY/dVS
 O
X-Google-Smtp-Source: AGHT+IHQmfXG7LmvKJAO208hKSpjoTWTgne+bEOaBIH5ozHhlLjTPi7OPLoryTviIzI9oO5QsXGETw==
X-Received: by 2002:a17:903:2312:b0:201:f052:d3e with SMTP id
 d9443c01a7336-2074c5ff711mr37926615ad.24.1726025267775; 
 Tue, 10 Sep 2024 20:27:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e1d69fsm54837175ad.32.2024.09.10.20.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:27:47 -0700 (PDT)
Message-ID: <a4b5729a-ac10-4035-992a-926fa7124f8f@linaro.org>
Date: Tue, 10 Sep 2024 20:27:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/39] target/i386/kvm: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-23-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-23-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/i386/kvm/kvm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 2fa88ef1e37..308b0e1cb37 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5770,7 +5770,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
>           }
>       }
>   
> -    assert(false);
> +    g_assert_not_reached();
>   }
>   
>   static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
> @@ -5789,7 +5789,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
>           }
>       }
>   
> -    assert(false);
> +    g_assert_not_reached();
>   }
>   
>   static bool has_sgx_provisioning;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

