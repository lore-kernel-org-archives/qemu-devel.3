Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C54EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREbd-0004jn-FX; Tue, 09 Jul 2024 13:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sREba-0004ih-QW
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:26:19 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sREbX-0003Jm-TF
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:26:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so27577225ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720545974; x=1721150774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1MrsYAq1qM8KidZUR2FHzp/ftNr2vcU51EyVfTZMdh0=;
 b=U1oQK29C+Y79/xpQmTEaiaQKelN1Nu4gYGSaLzF+54kpCRkHbfYQftXGFX+Toy33Hn
 xverdG8GOGvkkAiTDGgiy6QRLF0Abo6Y10DzK3nNrz26hLvcDa1SfZj77KuaQpqY20uf
 SwMOQqP5n8juZZ/cErodaPs6DHdDKv3W8Pz1OjefywqIeQbkR3IwKOo00hw+TDWDJKbc
 7zfxnn9FG7c2vzy+Wzws1BR2hfuluQxIwQQ8IRfMQegQtqBdwSUUl/iYy8GAM/b82TpI
 niL+qhj+H7z0B1PwhMyKmKOGUnreWJY2GMQRUg/nA8FaV0+Crmr83v2iHJCyA7lILIgv
 jsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720545974; x=1721150774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1MrsYAq1qM8KidZUR2FHzp/ftNr2vcU51EyVfTZMdh0=;
 b=XYXqILQbswWCIvg1HfNjmwVg7M1I4LgRfQWnMGUWHPy9GP/2k+vKXFfaxelOHWX6J5
 p23wz9WHtz2j7lzXslAM6XRyTbWGroWkFQOYRp+yXVMmfu/jSDLRuiFXvU/vBxuqMlYQ
 8ipexqTRbxPbL5JHgUwrB+VCTQkkmT3Sy7Z0c9J/n9XSXz5VQZmncCn+pY7IOSVSMvOX
 4LZ76OLMEFVpNsnz1jjoTswKgDWO+91YOKdO9pVBjec9uAchP4+FsTYd1t7KAGGN5VTA
 9xHVm321akHsyJRKz+hTI+eRQTzHyDgm0JlvCzhZRKmdpR1dJZG1mq3zJQdF4aX0Te1N
 zY7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy/xcur38mWJnAx7q1gXaBjuCgwUmdiOhLbXTaagFwzC/H+It4rWrudjMPDCrEU2va+0ug1wL8TWWvSArT3J2XQrGpaHc=
X-Gm-Message-State: AOJu0YzX9c/6PGreE2kEtZhm8uBzAl7I9uoNNvJlKy2YxWXQfPaUOuts
 I8AO6LEvS0fNYatlUeE4TTOdds7wjUrQHcGC+1cpWJh62nG2GHjoPelqLmSM/54=
X-Google-Smtp-Source: AGHT+IHmWhRSlKEs4DKlmbrmZdBqGxiNQu3MmX7iEWRlWjN9hKDKDkhBwHVj94d5uGfB3OYdwvsZUw==
X-Received: by 2002:a17:902:e80d:b0:1fb:93e6:94a3 with SMTP id
 d9443c01a7336-1fbb6d03da9mr25343525ad.18.1720545974395; 
 Tue, 09 Jul 2024 10:26:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ab79d0sm18653375ad.174.2024.07.09.10.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 10:26:13 -0700 (PDT)
Message-ID: <6af43b0e-d417-4980-9afd-219ad52e3a22@linaro.org>
Date: Tue, 9 Jul 2024 10:26:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240709115228.798904-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240709115228.798904-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/9/24 04:52, Cédric Le Goater wrote:
> The following changes since commit 44b7329de469c121555a1acf9b288f3ae71b8e61:
> 
>    Merge tag 'pull-qapi-2024-07-06' ofhttps://repo.or.cz/qemu/armbru  into staging (2024-07-07 13:23:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-aspeed-20240709
> 
> for you to fetch changes up to d847ea7cfc6321e2519f587d4077428d90557178:
> 
>    machine_aspeed.py: update to test network for AST2700 (2024-07-09 08:05:44 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * support AST2700 network

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

