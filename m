Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F2AE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKLl-0001Ut-S6; Thu, 19 Dec 2024 12:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKLj-0001UK-2Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:30:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKLh-0000kI-Jq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:30:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso7796845e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734629407; x=1735234207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QoOjPd106xBHV/Zl3SoCdTqCfymH/ZpxMQCrkbKscg=;
 b=pttz9b/AD++hjV8PSDOKHU169zSYQF/vwpUlyRBiDly1jczvhoiiZ3LxKj47f/xa4r
 0xU/82VkKXBSA4JQRCixPuh6Rgqe3PvAbFa0KfeQuQrKzINfxjWvIg5mNDmC2hRkRLky
 wHH5zAP4tP+gyYcYuXiG69D+CwKw0g43vaUxNJRbUngK+4wJUQV4ezaWqIpPFajGxHKa
 o30HY59F6MQNM2nf2X+BSzew8Hn8e+lZMlTnMr8rlhKdYrnaeWB3Dkk0O7+FiiD+jZts
 TYbBCDemVfGRPz6SuKSK8WskCpV8YCudmuERlrcOmP0ywXId8LsBxt9/nUq9aoucokeX
 S6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734629407; x=1735234207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5QoOjPd106xBHV/Zl3SoCdTqCfymH/ZpxMQCrkbKscg=;
 b=ATaCCAt35PRPCBOkXGIuod88mByLKYGy5uWVm+4/3LPkNDwnpyrHJNVWnqhcT5cgM/
 6vCsIzOexWjEgX91OAMB5BocRGTNcvR3OxU3HPBMjW4JCY0VUcudi0vW5Ql7BSMHvYcF
 0NLDPpJMJTDvvHhiqqgIm9rpfU3+6P4TZNy3/f2aApLL5Gfj4RAIUUd+vgn45PW4VwXT
 b7Y4IaImzhbLb90DjVfBJQgZ4IYf5hJZLxeXUmzDxeT7U7pVnleQaGopUnK9X+OZ7b+2
 PfPuIcR4uNWhT1C/dawHjJ+nBgyYGGeQl5MluRS6FRZauKLsvQRq84ASUR/zKkgJp3cd
 KkzA==
X-Gm-Message-State: AOJu0YwvHNr2+CAK5oPP1OkBj1ChimFQ/4NgvCCIngAYfNKkNInzc5IB
 U/YXpDwMxd0gFrODr+XyC1UJIZnQd93/Ahvo5kYz1Qy8Yqqwj8f1oPBQecbkpkYvMC5LhDFXTI1
 m
X-Gm-Gg: ASbGncvFLV+AaAFjqmhmVYxIx7y2wqyX8hdpiAEPqPo+2TW9+sZXYY4lhXr6EVjzXRO
 9cLDb5KiYkTZ7jxLp+tdyXUmTFA+tQ2jec+jzMtR29cGHp3bt4W6N/aZPdLWlvpiJ+Lq2mSzSyZ
 MmRw5ZFZto2KunP69GER8IQtFeOxxFumexsTNoBhLt6sfn9kLojYucemBampsbmmzacCKq5DLdB
 EMdg3A4hi6LPuwXVbML17L9aBgKLBd90GmCXd7ccQwpiOd1Ji7WIKigNnU4xuXy+sD0/ZI=
X-Google-Smtp-Source: AGHT+IG1/hpbiqPIMOWD1gfF8qL4Wgv1qc0QMKtcW3CJ//scx9SLxXAVranmpirqgTf3zIybdSqe1g==
X-Received: by 2002:a05:600c:46ca:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-43655426983mr68025035e9.21.1734629407635; 
 Thu, 19 Dec 2024 09:30:07 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219611sm23794385e9.23.2024.12.19.09.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:30:06 -0800 (PST)
Message-ID: <132ef614-39d2-4e53-bd52-bd0fdd6ff903@linaro.org>
Date: Thu, 19 Dec 2024 18:30:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Do not define CONFIG_DEVICES on user emulation
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241218151256.68625-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218151256.68625-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/12/24 16:12, Philippe Mathieu-Daudé wrote:
> CONFIG_DEVICES is not generated on user emulation, so
> do not define it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Patch queued, thanks.

