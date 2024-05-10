Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B95CC25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 16:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5T0g-0004j8-Kr; Fri, 10 May 2024 12:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5T0V-0004hu-Ab
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:22:03 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5T0S-0006Pl-Lr
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:22:03 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f72a29f13so2786255e87.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715358118; x=1715962918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0B1jE6cXf52WTxfVQ2BwJD7RPVVSMxgt0nei06WjdXw=;
 b=tjSMrv/N5EbXp4x63f0q/Lz00hxt4h0qXqyYaX4018WU4niKglA5bvXH9uhJcBWgnt
 iXUML8FkTanC+I970pu3QMq0KEA9qflMYy7vgizwc+xdU9aG6lWc+aK5uXSz081ZaG8R
 nMU3WW36eGbtmEc/vWGeJzguQ6IXcxBabTVcCEFjgpANKSwouzNY8vnqws6NSzJ4MYkV
 a8Yio6/FgcO3tYSxeshf1jKLrfyw0Mgn+D5DZozL4X+AjPh01nGEV9GBbN9tEiqfmPLq
 Q/WdJCSpEy7wUT02HmeAUjWnpqPbZ4wA3aVP3/r3cndHTE2plDOqBKkURQezA4o8x0Qj
 xoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715358118; x=1715962918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0B1jE6cXf52WTxfVQ2BwJD7RPVVSMxgt0nei06WjdXw=;
 b=qPUY+p4L7Jt7bm4SaAJq8FHhrLljd3NZlU45EPewvWLnBL1/BfCGFkb7GHAKgYJzb7
 07ZrmTo4kuoZVl+P26oLo6xIiW+anQX49gOHnqX4VJlC8jSbpZqIqoTrdVMfazUdWRqr
 Bh0dGHBYGShXSWhZJxZwKVQjhrwyZ10mt9wpVtd8ave6f0N6p7QTPwP/MnfCGaJFxwXU
 KUvo6nORmM4rCu7SWqtaUQwaWKXLOiMrb7QoViSoilFxYFTYjjHELdJkXNIQOCwhD1HF
 KNUfvz0s0awkhtYon5SkxCrFHXvPBbQH2TmcX6M782OeWElolvUS2VMYBU7+qoc2y5Ui
 GXbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1MyHevLcIsi0kS8CMv9fRdV9u8ngRuI/XpbAufU8218fFMsv81tOfZuaD5KHf75quagNbn299fS9gSrq2GkgI7ZDUL6k=
X-Gm-Message-State: AOJu0YwgQpGawog54BsVSN6d+jem95bqnVRUCBuJmXvET33+07xlVJN5
 DfshGkZlknm4WPIqwNiXGbkPq6dMdCk721pu3DPTO0rYl4DQW8Vxkwr/kdHLzCY=
X-Google-Smtp-Source: AGHT+IHLT8Gt3o2UP4eU5oxhJGXBbKXwmMWyIvOL75zcQRcsyhwcbwEh/9vDT9gLhyI16IJpxOWIOg==
X-Received: by 2002:ac2:5603:0:b0:51a:f2eb:b4c9 with SMTP id
 2adb3069b0e04-5220ff71dcamr2029525e87.1.1715358118083; 
 Fri, 10 May 2024 09:21:58 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7e18sm2002371a12.76.2024.05.10.09.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 09:21:57 -0700 (PDT)
Message-ID: <ad3d99ad-c6a9-48db-b247-ed956a6a3df5@linaro.org>
Date: Fri, 10 May 2024 18:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/41] target/sparc: Implement SUBXC, SUBXCcc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-39-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 14 ++++++++++++++
>   target/sparc/insns.decode |  2 ++
>   2 files changed, 16 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


