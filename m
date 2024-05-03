Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C22C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oQu-0004KW-1J; Fri, 03 May 2024 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oQs-0004KG-HH
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:38:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oQq-0005bi-Sx
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:38:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa83so60497435e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714725495; x=1715330295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hT2P/0HJ2FFqSUjfUzdzN0s+28UJm8rIT7lJbvAcW8M=;
 b=zU2TucT4/7BkztrKzXe+i/nlBr9Hd90iMQjbvcnXabYWzY74F+6Mc0c04+pR3HIz8G
 396Lic4DvZpGV6NT9/n/I8tKyJPR+qbjiGeAKjmXmPknq/XKqqNPZexmJoi5KWOKqoAS
 xBPDX6SN9PN64PxFLPqU5BrfO9Clh1SS02SsVlO5MyRNdJC1fXofL+Q9+a/gnq8t0gfm
 FDw9AX22vSE4SPk7mZPtA26Khgvhjjfsw/807NlJBiClvMsxaxoz5/Fvjexl+jIZ+fbi
 6VP6ZBLD6rg04HwvZJiAfJWfTQgdLDLkS6H8LGmuXa58PKis+PA9+Zt4rBN3WY8gRQwK
 HaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714725495; x=1715330295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hT2P/0HJ2FFqSUjfUzdzN0s+28UJm8rIT7lJbvAcW8M=;
 b=YAFZGPboOG6tpauTDl0vHFcnP3VjcsqSnaxF0wRR+08LpEZsCXWtt+p3Z32hipQCT5
 KJkgzkBDMUjynOSuMuEUqCz9/SXNHk3S2fBk00Ev+nNrMvB8+pyVk7NoRIzmgmfO6ry/
 8ddo8p+807LEFDGol5PTIbAgA3wyGg1NwjpztTLFj+4NLH5DJTArArL9FrDiscN+brT4
 ya2GNqKpHuR6YyARn9Ao2JRbVI4h3vlJd7z2KM2SvJYSI1pEuC9QaHQfMr13xtLQvLIO
 0G4/uAthuKqltI70nPDdWMd4vi2D/d+V8YfTgog2nX0KgEsUC8cmhfYVdTpMJdq08j6S
 W4tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWERMosyp7h9Zd/OJdtRFdQqi75nieT/g72Q1h3obaY4iS2NDyNoM4HixqM+7IoSAbTF/VOimrjJk3zmyVPWkBnQpw3jbA=
X-Gm-Message-State: AOJu0YwBEx7nOcu+FC5MVoKKlqpzPcZPZ3xjf3nxQjOenmN+mHNTeiP+
 0FZ5mUxfciXIT5rcZgOHyAAE0GkIkBNDDeHXrZxjm1bvidqsucl4WemKQTutmdNkcnbNAgZ6Sfw
 o
X-Google-Smtp-Source: AGHT+IG8GIaqsRrXpu7I8OAlJLiibtj2r7K/0vYlmVemwf+FctpCl7DY3sUusMpgkE8QIMISrOQQzA==
X-Received: by 2002:a05:600c:1f91:b0:418:be2e:df9e with SMTP id
 je17-20020a05600c1f9100b00418be2edf9emr1503522wmb.41.1714725494978; 
 Fri, 03 May 2024 01:38:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b0041bb11ff5a7sm8597972wmq.8.2024.05.03.01.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:38:14 -0700 (PDT)
Message-ID: <a9d2f2bd-0db1-4fa8-be21-c9b71f499c18@linaro.org>
Date: Fri, 3 May 2024 10:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] monitor: remove MonitorDef from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-10-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> MonitorDef is defined by hmp-target.h, and all users except one already
> include it; the reason why the stubs do not include it, is because
> hmp-target.h currently can only be used in files that are compiled
> per target.  However, that is easily fixed.  Because the benefit of
> having MonitorDef in typedefs.h is very small, do it and remove the
> type from typedefs.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/monitor/hmp-target.h | 11 +++++++----
>   include/qemu/typedefs.h      |  1 -
>   stubs/target-monitor-defs.c  |  3 +--
>   3 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


