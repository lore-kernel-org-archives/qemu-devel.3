Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D51C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLrL-0008Sp-6U; Tue, 06 Aug 2024 11:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbLr9-0008IY-RD
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:12:13 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbLr5-0003k3-Jv
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:12:10 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-530ae4ef29dso1521316e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722957118; x=1723561918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D2yQSdkDxiExiLkPo1xv3ND1aTKeiYFkvTYihxJmTlA=;
 b=q2N7IF9vA3fGKkQ6NX2sf/b+ixh0mnPW87RJ8znzvlN9Fvpek6EGhybxNRjLj7J2kN
 TPoQQTQsM1xV0K/vCuhMdEhDuBsev8bxOF2mtUkDjVSyM0g1kneQKqQowWvDZ6Kd9dzi
 jgE8peh3nnPeOcfYvXP0R0Ac/Ye5TREpTetslBjl+m+xaSBqfTPYc5oQnEm4L4omVA9t
 MmWIvBQw3cPKDVcW9qHaRUYDiw/ERQH3OXozAY3uIH77ByB2PXFfpDiWAun9HgX7ZQVP
 0raIMSsLKcrCmpzresKyZ9gIJys6FQcHcBDbeY1UpSK8Gq29rMaBvOC0fk2LC6BAsVar
 7y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722957118; x=1723561918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D2yQSdkDxiExiLkPo1xv3ND1aTKeiYFkvTYihxJmTlA=;
 b=sxUM5vDbU9YFmSqUXffwuGK5gaj6m5tCXC1QIpl116JlHoeNhI88FWtfsxgNeHLzmm
 VLluYag5JR9CdtQayIhlz3K3+o+3ydz4Ye3kBhX814Rdid/ueBgsEfhRmIMmI7izohwB
 7Eb0B7NUzzGPCkKkUdNB6BOp3ginZEhs7zS73EYbWBtpbVWFm3/tI2TM1UKWLakxwx/Q
 T5fsuAxyCgTdHw6dPD8xU+kxTntA0oCEXi5G4lyTfTg7miOpZ7veYHJ9oYdHvmVfrPdn
 mX0mAPKL6ggbDRfbtpil6LcxSEpiWauyabILY7KOj4T5ZdFyOpjsVhx/hdyTF7xudu2X
 5Q9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaOEdb35XLL34VCV9tO09BL5E5EZpPCLzsVPE8NtSrarZ68MLetd0VZCD1DqYt6SAwDuuEitaZCIb5aC2LEZEKi6TbrX8=
X-Gm-Message-State: AOJu0YwJ7mQwmnIlnQN1hdOc6Ca9P3Op8C7ZLDmV4cvNOO7CuNuTDcLi
 Egd4Spm5cGLVP5OMq5UarR4LGe8CdRmai7UegvcnguwdGk08CDjkJO8bmHNsUm3QE5deQ1JBOlz
 p
X-Google-Smtp-Source: AGHT+IFGHZcMKrCg9Dx4Zjhc4uWluWkSVM2LcRm3ucDO0QNHTbk7j8RusjjV1db+c9gHIGCmYqTBpg==
X-Received: by 2002:a05:6512:1110:b0:52f:cd03:a823 with SMTP id
 2adb3069b0e04-530bb3b46cfmr14007423e87.45.1722957118134; 
 Tue, 06 Aug 2024 08:11:58 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3d14sm553880466b.22.2024.08.06.08.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 08:11:57 -0700 (PDT)
Message-ID: <208ede45-0866-4dce-b6ef-e8390c1c56c1@linaro.org>
Date: Tue, 6 Aug 2024 17:11:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ebpf: add formal error reporting to all APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240806145653.1632478-1-berrange@redhat.com>
 <20240806145653.1632478-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806145653.1632478-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 6/8/24 16:56, Daniel P. Berrangé wrote:
> The eBPF code is currently reporting error messages through trace
> events. Trace events are fine for debugging, but they are not to be
> considered the primary error reporting mechanism, as their output
> is inaccessible to callers.
> 
> This adds an "Error **errp" parameter to all methods which have
> important error scenarios to report to the caller.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ebpf/ebpf_rss.c     | 59 ++++++++++++++++++++++++++++++++++++---------
>   ebpf/ebpf_rss.h     | 10 +++++---
>   hw/net/virtio-net.c |  7 +++---
>   3 files changed, 59 insertions(+), 17 deletions(-)
> 
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index aa7170d997..59854c8b51 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -47,13 +47,14 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
>       return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
>   }
>   
> -static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
>   {
>       ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
>                                      PROT_READ | PROT_WRITE, MAP_SHARED,
>                                      ctx->map_configuration, 0);
>       if (ctx->mmap_configuration == MAP_FAILED) {
>           trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
> +        error_setg(errp, "Unable to map eBPF configuration array");
>           return false;
>       }
>       ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
> @@ -61,6 +62,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>                                      ctx->map_toeplitz_key, 0);
>       if (ctx->mmap_toeplitz_key == MAP_FAILED) {
>           trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
> +        error_setg(errp, "Unable to map eBPF toeplitz array");
>           goto toeplitz_fail;
>       }
>       ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
> @@ -68,6 +70,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>                                      ctx->map_indirections_table, 0);
>       if (ctx->mmap_indirections_table == MAP_FAILED) {
>           trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
> +        error_setg(errp, "Unable to map eBPF indirection array");

Aren't these trace_ebpf_error() calls redundant now?

>           goto indirection_fail;
>       }


