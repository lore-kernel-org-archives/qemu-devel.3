Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E1C25B5C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2slv-0002is-CV; Fri, 03 May 2024 09:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2slt-0002iW-Cq
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:16:17 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2slr-0002P4-Ru
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:16:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f0aeee172dso2161935b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714742174; x=1715346974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUEJ+Ribw+pf8pUVEyjlKtGjVkNVSuMpH67I6hHGQTI=;
 b=dMB3MpLhfd5xRln+T/5npDCbp7vmqxk+1w+HiWq6rt9IeSXiN63EMrGTOQodqySPPE
 9/8YiPKEZsCLFhHX6vRVKX9ICEpPZuTXYdtkAcGTMWoBSSJZqiHnj4nNWKdb9f955oDH
 zViDmP6MKEcBL3wc0rsvJcN+fMjDJ24WmRfzPUWApGok+SCGoBeQ2blLzz5FCs8W3w7Q
 61lJhgra9eHK85HtXo2MEJahrlIy4N/MGYLm55euTkZ2u39nkHdWGi3GBAu6k/I+aAmf
 DBcXtPp/bHnn9BJVXQiy0EhenKF1EgVkGd5AquYgZMxaBDPbz4dWmlhBZx5P1+jKvHn9
 mjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714742174; x=1715346974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUEJ+Ribw+pf8pUVEyjlKtGjVkNVSuMpH67I6hHGQTI=;
 b=D8o7Iv9FrEmMznUANDnDkXHMR44Xyw1yR3UrcJ67HxTOn2Rd1EzujLmzAEt2UUnBDo
 2Jq+3MeX+8bPqVm85rdgfowUrWVfzetgqu1d69VKj/ZLG/Q6PQ00OhB+MM+q82xotNNk
 fW/78qcUpoSu0RfNFKJ1pIdDhz0Es41Ryj1qUhaeyEUC26BZ68lq+pyTBpSZMFHon4vp
 Kqu0SkDYWrqbQQQKdfiOdUFHIsb/imqfYvRT4JitBeY/7Ruu8w8HSgoXIKZ5zGKS8zLM
 TPYgJI3/KmpoTKZDNuonOAcEp+v2Xqkp1Z8k08gvyBqS/gtU+OfjPhSxDIQU9we7DGYO
 38Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqPVh58qfcLXEv/ybmExUg9IkPxySsiqpSZm4nLIiPXtva4fQchIc4Rm2SLLox/qZ9SkF3SK/hH50rB3eCbpuFwTkN4DQ=
X-Gm-Message-State: AOJu0YzYaZXWtX5UjP83xxHTdFAEpNdKkcBvvaYjH6WmMuYY5PQ4DVpX
 74qUIkRTNNaHuqcKcpdZwfUbI9ae9EnzNcnIJE54BWlTTIlawkUKzDBJnfk+8A0=
X-Google-Smtp-Source: AGHT+IFRnRUlknxewPEpnfO+w/OUgRZXQS6C110jpaq+tYf0VBZYVYIRgeLSqdE2jD8M4QitNZ7Ppg==
X-Received: by 2002:a05:6a00:3c86:b0:6f0:b67e:dcfb with SMTP id
 lm6-20020a056a003c8600b006f0b67edcfbmr7998578pfb.7.1714742174029; 
 Fri, 03 May 2024 06:16:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a056a000b8200b006f4547cbd1asm112705pfj.5.2024.05.03.06.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 06:16:13 -0700 (PDT)
Message-ID: <d7f1c5cb-56f5-4f70-a200-c7b2a9c7bcb2@linaro.org>
Date: Fri, 3 May 2024 06:16:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: do not include coroutine_int.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240503090349.193319-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240503090349.193319-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/3/24 02:03, Paolo Bonzini wrote:
> Migration code needs no private fields of the coroutine backend.
> Include the "regular" coroutine.h header.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   migration/migration.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

