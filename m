Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFAAF3C269
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbRx-0002wu-Tq; Mon, 09 Mar 2026 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbRq-0002wQ-Rq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:19:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbRo-0001dC-17
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:19:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so26022285e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773065941; x=1773670741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kirClGvfV12VxpNmvOOYbXSW1hJFhFiuqd4/3ecDu0M=;
 b=vijP+vdygWg7Up0jfuuHmAJMPUfvbeQFKh3V3FbNTqTvYfIDX8Lp++lwsCRL9qM2I9
 yvo7AQhie4alD1L6N7Yh8qAHXuZ9m00za+ggcFiZCT+w0bXNw4SEZvNMv9QYe8qVbLMf
 iRg7A6WLFS2WjIuffe1jdflziKNF2xdeB/SEpyOzPCxYaXi8OowXofrDN0c2nQ6YT1up
 vh/lrRIMPnIXJh9a3PNC8WGvr4OSZXTbk1MR9XOtw8aQfz06dLPOqpj6QtR49QUOl3Un
 OVApqgFRP1v7TCOz03E37bYKDfLY5YxrYxs9g0cSKAWPyt8Q0ZiwLceB3GZlaUsJY2sx
 XjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773065941; x=1773670741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kirClGvfV12VxpNmvOOYbXSW1hJFhFiuqd4/3ecDu0M=;
 b=xGo180Fw16g7EHBeXb7EDTGC7IW7/w2ctaprtKS3xJCw13f5U9ScFGEgv4tYcUuRYK
 Wo7y6R3s72lrAPRjN4DVfqTRIoggktayf2pCMA48c+doamiSavYTP4UEJ6Y6ycyZXOq/
 O11RzJ4Muzv2Wzvws3+zZ4WlybkbC4wPgqqV9u0Y6g1c31y3Hmz3kY1+XLK4rjxDsC9b
 w0ULCjGStQMU6UuNFYcYRNI35z6yB3gEdPHRUMqjd2qPGtVxu3UlRnabsxMwZuCe3sWO
 RmbkB4LtM2y+WviUvtf30fB/qsd5HFZgy8+eXXW0Ukfwgws7GGUOIWqeX2K6Z9Kc+8X9
 wRSQ==
X-Gm-Message-State: AOJu0YytVXb2PtBcEc2ZWFN8vDs6n3HObEGlJqrGkE84DcIbpHW356sN
 MOmNqqoCpU/vFuEK4bt7arNHTqJE2NLwXfoWQAAdT+XEJzXYAf6lQmftFOu+ExARMj8=
X-Gm-Gg: ATEYQzzzwiJbBNuAU5y/l8cJQYEIwprojR0CemsnyPTPb/utbG1LCxXRmDvd2qzrsg/
 OkSmYPE81lbbL/LLOtZeaewXKPoKL6pafFoKEZvx8myrAEKOPBtuenZWCZ6jpRUjDQlMov8C9BO
 sXKZWVpAcC6vOeIlCkWBPW9caCgyPBHYkkWTeAtiuVwaYjPeL4DgwycignFTuhndN2CZjaI8Q7Z
 vCSnXyei1LZZ6ghXrD8t4fKTksCj+jehgPUY7O9JRGd/yOZltmn/odv6ONz8pOd+Mx0+JreV5ri
 tDanPyIuoWwiiNYPuUK86SweYKRjL/Jj16f3+rcP1eIUtjb26R4DcGPCuBKQ6GWUOVUoQ2E9xBr
 bi254oArdqgThxzW+PfELDBgnqgb3rptp1afA1zhFuNSGdrXttinrC879cpr2ZqJcMx9OD9CIyw
 GuOilt9QNPoANU0l9fAPfuEZzQ6Fh51qa3Ot+sqCABbadVgL6iNgya8EJ/4bLmm6zRTsbnPRE=
X-Received: by 2002:a05:600c:3b89:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-4853f1cda4cmr30560335e9.9.1773065941337; 
 Mon, 09 Mar 2026 07:19:01 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48529a2fa39sm70584255e9.8.2026.03.09.07.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:18:59 -0700 (PDT)
Message-ID: <bc6a9fed-cfb8-4c16-aa96-90988f065121@linaro.org>
Date: Mon, 9 Mar 2026 15:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-snd: remove redundant fields
Content-Language: en-US
To: Roman Kiryanov <rkir@google.com>, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com
References: <20260305042523.335493-1-rkir@google.com>
 <20260305042523.335493-2-rkir@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305042523.335493-2-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/3/26 05:25, Roman Kiryanov wrote:
> VirtIOSoundPCM does not need a pointer to
> VirtIOSound because each VirtIOSoundPCMStream
> already carries a pointer to it.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   hw/audio/virtio-snd.c         | 6 ++----
>   include/hw/audio/virtio-snd.h | 2 --
>   2 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

