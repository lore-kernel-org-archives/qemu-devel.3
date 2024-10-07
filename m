Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3667CC35FE0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuGm-0003dK-4z; Mon, 07 Oct 2024 16:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxuGk-0003co-0L
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:23:50 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxuGi-0002zd-9n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:23:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so3924446a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728332626; x=1728937426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=grdsN+RxeYJ/hjLL1moN/W57aTGb8bqycnDwu6targY=;
 b=krjOGxKbyXU94T0HqkeztwheFesUPpHzSJ8/n3/ZYUtY0IWFtCIj4BOwLUd9qkeDi/
 n08TmbrNpNnAq6nWTEFgVlN0g1QkrvQp1cpeXhuE+IYYlAETE2h2ZYHut1xVbowjfVBB
 5cYlsvnIxfRKT6rsfJfqRMnpxHRXSIwwthIw0tmKJ6J5WL6vj/uKbbg83urLH8LzwUPv
 exeAgryVx1ycFeLF1aGk0TFxIDg8jidypiGWNxThtGBlajOIm58Q6dOsjxXgBRd3Yyh+
 cUecz9rWPaOyzCvUTZRRTBqKwvrsLvXU+RCpAmiRivRx25KJrof1epTiG3CtROSRFvqB
 5YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728332626; x=1728937426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=grdsN+RxeYJ/hjLL1moN/W57aTGb8bqycnDwu6targY=;
 b=VKb3koRonxJQnhL52eW0JMvdhrQDAGSf20G8KAp5OJQqLv3TCxsKn2u1whq31emLqy
 9vi8HxM8QuCeFc/kxXQWGfuz8Pk4tEi0b6OZTuo2ajzdR8e4yigJhXKWy1hH+Z6vKrTD
 KkeNSfrbWrhxVK1kwijvHmf9fXwF0LmMiM4RFQk7vqF0loFX7D+032v0A/NjI6qh6NJd
 wCpRZNKoHFqr2zvb5RSyoqDl9scqgvZbvnB9YGeBT4SktVDNgSoLi1sR3lvfcj83/CIj
 vnNsIUUk1UlfLGW1HtUd9j338HVieo/vu84CZuVjx1G2i+pQz9adK/rvyE1V4iYwH4xm
 PLeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uCNLMXKuTTVvp32s5ifzJsJUtHuyITOeQmwF8FuABvyAMURyjDSlvNVnDaJTNLrtk0ct3AaaxdIJ@nongnu.org
X-Gm-Message-State: AOJu0Yz1JR2tN6RwrfZtK/7XCdkKYLW6TWc2BEAw4NPNHIu13kk1EZin
 zjmlybAZlN6xtvCE1LHNkwCcZW5aDy1u9jlGYEGd+tbyVHj5FJPTEoChcgIrrHA=
X-Google-Smtp-Source: AGHT+IF4OU96bzh8k0Mwow+9y3uc3DQkTqKgqw3cRXH35TyNTk4C+gsRChvU+yglBr928vhzjwDY9A==
X-Received: by 2002:a17:90a:7442:b0:2e0:a9e8:bb95 with SMTP id
 98e67ed59e1d1-2e27dd3c32amr1272919a91.3.1728332621015; 
 Mon, 07 Oct 2024 13:23:41 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85c8ca4sm7671287a91.13.2024.10.07.13.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 13:23:40 -0700 (PDT)
Message-ID: <4b180079-d800-45b9-a455-5fdebd71179d@linaro.org>
Date: Mon, 7 Oct 2024 17:23:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] ppc/spapr: remove deprecated machine pseries-2.1
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-2-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241007153838.1085522-2-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Harsh,

On 7/10/24 12:38, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing pseries-2.1 specific code with this patch for now.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2c10a70a48..e9518ff8b3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5381,17 +5381,6 @@ static void spapr_machine_2_2_class_options(MachineClass *mc)
>   }
>   DEFINE_SPAPR_MACHINE(2, 2);
>   
> -/*
> - * pseries-2.1
> - */
> -
> -static void spapr_machine_2_1_class_options(MachineClass *mc)
> -{
> -    spapr_machine_2_2_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len);

Why not remove hw_compat_2_1[] and hw_compat_2_1_len in the same patch?

> -}
> -DEFINE_SPAPR_MACHINE(2, 1);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);


