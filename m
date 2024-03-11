Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32015C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjKC-0005oF-ME; Mon, 11 Mar 2024 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjjKA-0005nZ-SG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:20:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjjK9-0002a4-1C
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:20:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd9568fc51so11946115ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710177627; x=1710782427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SH0MqLC0cHU38VY046EXrct59yvA2WSjP64lUzesW9M=;
 b=C/cmtKox+4r2UnKCpyQnfb7cvpjKpUvV/BVBrUeLPcBniuiy93UIS0ytp1egmzguhm
 vbKok8Nns6bsqiUYl6/C8AJxhpYHdod7BZFVwPT1kOQ4gJSG1fL184podfYUUceHYGX9
 pd1Jw8q5en0LSFjnTd68clrV8jGIUxj1Z4NG8tD/Ixa5oZoEUyv9xZQdmwrsNYMh4hei
 yUDNkk103wjxusHCCoKgU7+wnIoRUEp/hW2QNiAXuWqK4zo1DePT8J1D816MHkOJ5gwB
 Kq2uuE4oc15JeOCA8HpGbBfgIVad+Ye0bE3Qcem0Gwb7d2DbzKIhQRWITQ06rQ3v6yJ1
 BTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710177627; x=1710782427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SH0MqLC0cHU38VY046EXrct59yvA2WSjP64lUzesW9M=;
 b=MsO1lhi4/i0sXYbzPoT3qRXKdoZ+cO+CLLcDO2t4CKe+eIE97RCsitUooZd2JTP+oh
 nZJDFJ8UXkxdImZxH8+998rhIERShWrKaxVnB8FdfA0KmeLG9im8tKYoCybgUshjBEB8
 fETYfxTTZMUejI1ML4vurgnVQK6NWXfeVd0C3cQrwhbCXxZvpr5c2VsV4nFv+gNGSw6v
 P6CwyitReQfzO8QfCeNzNWv/8vLXw9rWvEpUd4MVz1JW+gfCdM40gTnwudrRzjtrN0Ps
 HywTKcxD90CBklOMnV0yi5sB+rj4yPaI2bhNJrxsxUp/gQuBW4PKD1iqAgXqSzrYP9IW
 Y3mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFiRbYbdo9btl50C8kUvWRJty/CK4IXmgws3ZTOcj0DL5dyhy4r4dnaREL9VHMUgZC7RWjsN/shFGeA/tvVp4+iMemN1A=
X-Gm-Message-State: AOJu0Yw43xaGy6i0ktH7tXnfhCWVwsHDvCA33aQwTb7vhpI/Aoqwpm5p
 ku/veDc/K5+pR+uIHT6NNTZ6svrQ214w4GUFa0EbAbBQZcNXjzlxymbI3vVQOMo=
X-Google-Smtp-Source: AGHT+IFq10BIr8tjqG/BCo6ia0emhdkAXQtG1W6pKXqcxVoVAWDTsXz0rmZ2ATTHC9tOqWL1lJlLuw==
X-Received: by 2002:a17:902:dac9:b0:1d9:d341:b150 with SMTP id
 q9-20020a170902dac900b001d9d341b150mr7776582plx.40.1710177627372; 
 Mon, 11 Mar 2024 10:20:27 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lo7-20020a170903434700b001dc01efaec2sm5009131plb.168.2024.03.11.10.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 10:20:26 -0700 (PDT)
Message-ID: <687c5fe9-e539-4cc5-b0fc-aaeab4ee56d3@linaro.org>
Date: Mon, 11 Mar 2024 07:20:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] gdbstub: Save target's siginfo
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
 <20240309030901.1726211-4-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240309030901.1726211-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/8/24 17:08, Gustavo Romero wrote:
> Save target's siginfo into gdbserver_state so it can be used later, for
> example, in any stub that requires the target's si_signo and si_code.
> 
> This change affects only linux-user mode.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   bsd-user/main.c        |  2 +-
>   bsd-user/signal.c      |  5 ++++-
>   gdbstub/user.c         | 23 +++++++++++++++++++----
>   include/gdbstub/user.h |  6 +++++-
>   linux-user/main.c      |  2 +-
>   linux-user/signal.c    |  5 ++++-
>   6 files changed, 34 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

