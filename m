Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BADC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u78J7-0007Mk-SY; Tue, 22 Apr 2025 03:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u78J6-0007MY-0F
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:44:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u78Iz-0005yl-S5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:44:39 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so6040634f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745307872; x=1745912672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K04r0aAzJy61hzj4PuKUHeFKZvtRz9YSQBWWnNX3bbI=;
 b=UGdJlp1mZaMB9lmRptd+0cYK9kB07pfMYUOMFOV/aD4gwwkzoWfOHMR5z5LaIdb4p0
 ysjWIj4bUHsBQbiMRmLZ+ZDmgmqSX8R3ZKYcHz1QOY93wETNxNUW+ZWbxFcOTPkvov5l
 sDjXTEjBxbZiEcpvhJUYJh1ext6GNFd/EoAcpHwEnxRdeuh/dpmhCthhDVSu2DpfwF6X
 GkkvgGbXRmUaJdRhFWCWyO0904vPatYSt4OXQKEZzkc57eDQkKag99AIdwyTeupqoABA
 LfAXAwYYNTqsOSy98YGrUIYewX+4s8Bg+4NCyX9f8rOOxO8iPMMeL63g3mQwJCUzlJbO
 DjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745307872; x=1745912672;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K04r0aAzJy61hzj4PuKUHeFKZvtRz9YSQBWWnNX3bbI=;
 b=FwLmoTPSS60spvBRBU0z2kdc5gnkaIesnU1p7nAMMFDpA7DeS6uE6GYPHkxGS6xJvl
 +6Qfv2zXyYqJbjKtY2zLPcci5PTX5b7vXvRhBtp4i8TO4XMao4GiScb/E5Mp0tnPkseN
 sUTTqRN/xW2Epxd9v0HmN4f5A/K5LMKE4t5YtuUxCcuYrstdgWZIlhjUqk4187reYNwd
 cdYC61BWRPFHZyufVAE5Ga06h5rJ6jRQW6WtZU8/KTYShAlZVVonx5Ebq9LJBFR53SQD
 QRqb3MGzd+nXzKTXwtJj+6T48cBDgdqfEq808QmEVqW67eZsR3S7UK3wKE+2Orok2vwp
 376g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRHZcvbWgwobmBFtCST7awVrbwi60DVimtAHvp1t3DVCbC52ih4QB2Dwv2dw11acp9wr7uwE7UAN2k@nongnu.org
X-Gm-Message-State: AOJu0YxL2a8Q6sOXisxHryfgZG8hr4Yv6+uRSm07gil/DdkiW3Sq0A4W
 qz9W8+mp8dQIfTgvPSJTn/W89b1Gsj3tI9vSfhA9h7M3ku0zzh/iggB3jeBjvqo=
X-Gm-Gg: ASbGnctFn4oMHyRgC9jw59C0nh6gcFcVT/HGzJOstg75PcCkfN5NjfM0pUdZVFIyPt+
 /xicS7Zmchf+UMx1044nDiJdWSiug8XTs6cpvaHX0TkvBppjwGPs+6o8cSVdoNgMaba7c+wwtzT
 wURsqbF9QXlrhNssssMbiimV+SVL6a3wkwDhL38TS7rNgSDbFAJ8mnvjnVkD6vWJMEGy6A38ZPZ
 tVxKWNlF9JWLVj3tAo7UIzORno9SGS1mbr5Kh5uM4WDee1q9zUL4+VzLytQVz09XW+ye48lOYVi
 twhDOlq2nvXIeDKP+jfl0n6seJoer4BkzrVs7wPvLMu7wSWzwHamCr77jiqsGgVPowGCXxamHyv
 OMhWlW0ov
X-Google-Smtp-Source: AGHT+IG6dWFsnZkUL0b2L/yE2Be8+rQuaHB7RW3WRlSYukYZqwMsksYh6nbXRGZSt78uPLEeaCHW/Q==
X-Received: by 2002:a05:6000:18a5:b0:38f:2766:759f with SMTP id
 ffacd0b85a97d-39efbad2c1cmr10504891f8f.41.1745307872196; 
 Tue, 22 Apr 2025 00:44:32 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d03csm14520478f8f.59.2025.04.22.00.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:44:31 -0700 (PDT)
Message-ID: <885016b7-cf36-42c2-ba0a-239cef23eea7@linaro.org>
Date: Tue, 22 Apr 2025 09:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/14] qemu: Convert target_name() to TargetInfo API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-3-philmd@linaro.org>
 <ea5efda4-01bf-430d-afb1-06c82b7bec3f@linaro.org>
Content-Language: en-US
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ea5efda4-01bf-430d-afb1-06c82b7bec3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 21/4/25 17:56, Richard Henderson wrote:
> On 4/18/25 10:28, Philippe Mathieu-Daudé wrote:
>>   include/hw/core/cpu.h           |  2 --
>>   include/qemu/target_info-impl.h | 23 +++++++++++++++++++++++
>>   include/qemu/target_info.h      | 19 +++++++++++++++++++
>>   cpu-target.c                    |  5 -----
>>   hw/core/machine-qmp-cmds.c      |  1 +
>>   plugins/loader.c                |  2 +-
>>   system/vl.c                     |  2 +-
>>   target_info-stub.c              | 19 +++++++++++++++++++
>>   target_info.c                   | 16 ++++++++++++++++
> 
> Can we not mix and match _ and - in file names?
> It's weird.

Eh style is a matter of taste :)

Since meson converts '/' -> '_', maybe use '-'?

If so, we mention our preference in docs/devel/style.rst.

