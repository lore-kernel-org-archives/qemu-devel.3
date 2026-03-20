Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA42A1099B41
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3he0-0007rq-Lm; Fri, 20 Mar 2026 17:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hdu-0007r9-5U
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:44:30 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hdr-00008D-5Z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:44:29 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c742d4df00cso979479a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043065; x=1774647865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i+AoMNJevjRBXzavEpzEK0PDcu+onDHoJjYgD9S1gz0=;
 b=LsVkaF9Qad041NGqjAdK5chTwPZFNrHtZRt+vReS71nfx1IrD3hi/qXDQbQh3NaWWS
 IM4h0yFVnvOUJ5zOSKFUBmtcV/9ewhjbo3YJl5R8yKRkT03iSb9mQ2UXNOhPHHMtlRvd
 vgAWmdz6JdIFguztb5MQi9IJoWRht31F9cTC/Rgqd48X1MKHAZdBJHW6oLDjNEy0ouCg
 5b8B7Ql5BH8Ys/JYxe0TqCLWlGR2ZisaCLxO6kXjMMFPydBR9g15RAJJV4ZRkkwdzdVR
 xGl7sDR+HQqnm576f6dFxzTo10qTbXPy79/BD7u7yxvC3+BUCPljM+ZM3GH42bq7n1Fh
 Lu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043065; x=1774647865;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i+AoMNJevjRBXzavEpzEK0PDcu+onDHoJjYgD9S1gz0=;
 b=mwwgRSR4wm51Nd9ppFmp0MNpfsNXhObaqNiq8s0W2ggfkf+oByd3+s6AvnuK9cAgxx
 TtmK6YSg+8LTU90lio/2wKLIFOZI6CmXi7nJ2ZwoQGtea9/iv/SXdEjF3BxO2w/HZQ2J
 wE0QVyCxjZjOo6nlSlew9nTwUNx2L0fW7SOfTvPJFAFhWqDJN7Jr6C1TzM/YRL3T5/HR
 yePpc4bJQELUWR+nivnJ0BOhAoPyR9vopR5xWVDhHdDUt9ic8wtuJsCB3lelh9F3Sw6m
 XkJU7cyqCsyaXR0rtIvN+tvPFzQ7jxf6IokS4s4Gfc+AMqjr7xY5NkWCtCFlC4DD2IHd
 5GNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXiYZ8mnCwD5ZnHFwbH+zJayrM+GafP5OkRMaJOwM2kD4D3doVxp+wGBL921AFZNt7YhK600kS2/j6@nongnu.org
X-Gm-Message-State: AOJu0YzD3MYiCEkuD31eMeWJb7wUU1bVA9oOJnUH5uEVsf2IYe4zhE8r
 5fkCENidioTyxJcTuANI9kK71Mt8iqL+hNtiuhOHbL91S3tFbXunutv8DiBsWOeSjR0=
X-Gm-Gg: ATEYQzwczMV/0KSiJkcTQWpKD3wLGBTdzEbGE5MhatwvnyX85DsKkL7a1ohye6jx3H5
 E0/nnpbh0MNWuewaMvoyaOTbWHla5fRIrCUb9iwWh3IEKjzYaDSVWTgoSdhmWuPU/A4LwHcaECi
 uKKWsFkcHdI/vbEqHM6hogDWkywGI5NE9YPvH7VbRwpbZTy8+E6eyLtKh806CJTb5I/ayejn4nM
 kELeI0Z2yzNHSZYoJCXhOQf2BgiycURLD+hJil4ESWdFpxEk5yVcuD56xO3ANzP3zTveuSEFc6J
 +DwfDWYsbMMEK2Rz7nIY7u6ynBcEzH8icoptnSUCLhskLumGvE+MFkOfR1a6VAnIy+fkhP1rRfx
 yFl/Dmbi7BU/qiBazbYf9zZBq9hoOyjMRiLfi5EvJKeawPzGPg9/rYtXpeeiScaVL4KB/++BLQK
 ug+1xJ1TFR2DXX5vboKyTnWZjMbQbxhvZ5nZRUjivc9BvYEZ/zm/SNehJdksRE/OBeQ57N
X-Received: by 2002:a17:90b:510f:b0:35b:8d89:719d with SMTP id
 98e67ed59e1d1-35bd2749cb6mr3074326a91.6.1774043065295; 
 Fri, 20 Mar 2026 14:44:25 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd3442d8csm1446534a91.3.2026.03.20.14.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:44:24 -0700 (PDT)
Message-ID: <076e310f-37e5-45db-98be-66a6dc585a66@linaro.org>
Date: Fri, 20 Mar 2026 14:44:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 2/6] monitor: Remove MonitorDef::type field
 and MD_TLONG / MD_I32
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320091019.59902-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
> None of the few targets still using MonitorDef use MD_TLONG,
> they either use MD_I32 or the %get_value handler. Remove the
> MonitorDef::type and its definitions altogether: simply check
> for the %get_value handler, if NULL then consider 32-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp-target.h |  4 ----
>   monitor/hmp-target.c         | 12 +-----------
>   target/i386/monitor.c        |  2 +-
>   target/m68k/monitor.c        | 24 ++++++++++++------------
>   target/sparc/monitor.c       | 14 +++++++-------
>   5 files changed, 21 insertions(+), 35 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

