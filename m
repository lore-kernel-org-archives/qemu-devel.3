Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD0BECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmW8-0006YP-R8; Mon, 09 Sep 2024 18:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmW7-0006XZ-8B
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:05:51 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmW4-0007iq-Nu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:05:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5365c512b00so67365e87.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919547; x=1726524347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eYYw1SbpxcK5GgVg9c7mX6JRkhGbhLvOOw7yFxvItw4=;
 b=JYIbATN5YAw5c9ZIr9gjvj67FFfXkfmdP12Ow9jdpIQnBoceMEToZgXbZM01GGA4yp
 F9FEzqOjImhQPIgaZ7uuzGnE6NIHPt0gGt3kb69s7Qr9MzWTTUoavZ6IBjRcekz9mp6O
 JQARMxNtZF23XbyVyFphF7nUW8KqWwAkbz3HJl89uarJoUdqR2UvVYegAb5c7A1EQX5v
 RGGi8V8Yzu8QXzwzNLZfO7xijUoW0OlF6sm6aheUhnBJui8qe+w19Nf1+p62ZJ/GvChG
 ssdmakx5n3IArfDxB9p3KWgBZy9BhEEVJW4oU4rUjwZyJgHUbBnIgp38htteeOQWg45u
 zliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919547; x=1726524347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYYw1SbpxcK5GgVg9c7mX6JRkhGbhLvOOw7yFxvItw4=;
 b=U4ggMaX/DmC9ZMk0YOoFAKlXYJUG7LlQPMynZE/UDCy4dnv2RJ2dJfHyPoJ/FWGuDe
 9GQL2TxTDiRddSQK/sYXv71si63KGDTZMbBGiFzDBXdtEt3E7Eo5hODGpY2lT4DTUVOR
 R4BFjqpoSa6jsGJ85Z3/40kqbj2palbYMM94EQ7p5lQUr/TQhweERNRyHny+c8tQTfG3
 I2k6dWYzPXadVIH8lGqi+JPfwOER/M+Q7qibm/GPUON5XG+HhXXsyo+1ETanLy29YIgo
 lAHnO/rT7rvh61pvY2BSoVQ8gRW4LAgs3tKXyoF/kfURzO6ntUO+WHz/COcgArLQt/rV
 EmJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm/9NX4/+Se8SKcM1vapkzZuHRnOZkhx7lDjAiPy9BJIldEDO4Jc0wZzID831PM5Uc/FDAwjkUpR2m@nongnu.org
X-Gm-Message-State: AOJu0YwB3J6ZzuDX+zyjTbOK/Jp2pkCGIw9PaZWWDETfnmwt5w/oYS3u
 7I5VHm7/iC7nypQ7N1lLY1m9yw8jkxYJP0efMLXKjA1olY9h/nAG+FJfRsI36n4=
X-Google-Smtp-Source: AGHT+IFGiWffs4q6ijRuCDSI1r3AkPyrnXAnvrjbItSM52M4RpW4JGr0PzxYPNlNuRdA84rlOq8AYw==
X-Received: by 2002:a05:6512:3b86:b0:52c:e012:efad with SMTP id
 2adb3069b0e04-536587a350fmr9294450e87.12.1725919546764; 
 Mon, 09 Sep 2024 15:05:46 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76ec1sm3469092a12.70.2024.09.09.15.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:05:46 -0700 (PDT)
Message-ID: <1a8f16b6-d2c7-44ce-bced-8893f487a581@linaro.org>
Date: Tue, 10 Sep 2024 00:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/26] target/m68k: Remove env argument to
 gen_lea_indexed
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Use the env pointer in DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


