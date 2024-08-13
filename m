Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F18AC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjfX-0008P7-Vi; Tue, 13 Aug 2024 01:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdjex-0007s0-GX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:01:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdjep-0006l9-0x
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:01:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70f5ef740b7so4565263b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723525277; x=1724130077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMLKLLCNJ0AUdvXFmkiQutbYqgOOkpGjoBioSTGxcus=;
 b=nRHACUhnh1nLmpM2BCBvYQazJvJ4HZ/pVJUO1ByGsGnZxYOwSW5HQeKcuLZUClgIg4
 mKB1sHoQ38gMck7mP79M2c/gl0Q19o5hF3hTlY0HZ2E7/aqMlgapBH+jCvI8RNua2NJV
 5UAV87WgS9xe2kCzZ0S1IgwJi2Y9mdAvW38okDw7+jcoIUsYTLUiwu9FclaxWHAiUJAq
 m/vN884HIoOrWV2zrZUisM8sc9KIWOEgkEv1v6QPsM1Nm1i5Aw3kkK+6+1fIlS+bHNBo
 0Tux3NLNji+siNWLLJRdyIUAHQXDT/OZZv6paDxO4eXyR0dSIOb+SBTj7ip4+Xef49VE
 UktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525277; x=1724130077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMLKLLCNJ0AUdvXFmkiQutbYqgOOkpGjoBioSTGxcus=;
 b=Knid189o4voEMTEaoP20ergw6AIHnbHGUF2K3VRkReQroKF/JbLXTSDWkEY/DT68uB
 RoPpuS0zaALpnsn4D9mvPH0BkPgt2UYcbNKUSPZMEfQkYcEilOutOuI23ru7d22hVQoM
 pewvaGggq/l4Ej1S9WcVLBZvH5zaUjvE9EEMQj0Yki4I7WWs4mVWOHL7QQLvPGiW9Bo6
 WUoHBLFEIGxxENbvbaT1ZcpgAxgnnPmJrXd8axgy3I9AeBfyZPoka6JmKErwBjyMsavf
 D0sVXDJSgJnrGTaUgqneC9q7g8tChUqoL074suoAmngEShi/JfdNgC5SFDrFUxbx4Jx4
 B/NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZeQ8h20ryp9n8fzm6XgkPKvLizzbcMUtKVDiMz/tpCYf/z/55sHINfKzQuPocCnZiczguYFzNa5zEfO9kVgZQULT2G4o=
X-Gm-Message-State: AOJu0Yypa7cc8BIaRb/GgUHKOUOtETVG/HioCEVU8Hr0j52B8NMqSvV4
 FUXQ2/9EOAGRhA8PaeXOnj9IxdUSCQ5MmvBmxjQpMisoasOK8yv0HZLjlqaF754=
X-Google-Smtp-Source: AGHT+IE/GOUu8CLQROoJjGBJFXisBm8HlsxfGp8KSZ02bsmO77515DnSh9zJksyHB9ZKpOlrsWM91A==
X-Received: by 2002:a05:6a00:1248:b0:705:b6d3:4f15 with SMTP id
 d2e1a72fcca58-7125523a066mr2387006b3a.25.1723525276951; 
 Mon, 12 Aug 2024 22:01:16 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a4362fsm4968314b3a.99.2024.08.12.22.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 22:01:16 -0700 (PDT)
Message-ID: <1472852d-c174-4a75-9ddc-0979647a7c5e@linaro.org>
Date: Tue, 13 Aug 2024 15:01:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240812155558.88189-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240812155558.88189-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/13/24 01:55, Stefan Hajnoczi wrote:
> The following changes since commit 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23:
> 
>    Merge tag 'pull-nbd-2024-08-08' ofhttps://repo.or.cz/qemu/ericb into staging (2024-08-09 08:40:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 547c4e50929ec6c091d9c16a7b280e829b12b463:
> 
>    block/blkio: use FUA flag on write zeroes only if supported (2024-08-12 11:41:29 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Fix for hosts with an older libblkio.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

