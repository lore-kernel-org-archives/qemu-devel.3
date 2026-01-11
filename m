Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEAED25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3vi-00078U-59; Sun, 11 Jan 2026 17:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3vg-00077t-Bi
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:29:00 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3vd-0001xa-3a
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:29:00 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81f416c0473so852815b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 14:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768170535; x=1768775335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/awSejzI+mKY/90Tj1dnvn/vwm8cgXU81nOyZ2hyM8=;
 b=NKHZSSMIuGtZuu6KsuBlb3g54Xw+pW/2WQwB/eDzuhCCIApYjG2/OmRrLvpQ0dFzwq
 VrauJHeli0ihqg/kXMahFzVLPFFl8+Mmlj2lH8NjC4qrjC7fTlkQHSyarNfSf3R9tZfs
 NedCieGNWr+EeUUvLF3bzRAyQFIkmOWEAQqyf2hMeybQtThe0b09g4zQfUjtU9C2k6O1
 rLhxy0e/d5YLlpEyHtSnU4mJLvEE5MIhfOCy7N6nYEWdcWRqO4xsnNKDJRU85IJgr1D4
 owjbH5yzuliHBiI4nCKriRXwnBfDtiFtuX8wAl9fceZqa199I/6UOdrw3MmRqDwJp6cP
 fW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768170535; x=1768775335;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/awSejzI+mKY/90Tj1dnvn/vwm8cgXU81nOyZ2hyM8=;
 b=Mv1CiBoKBJ7gS+EBdAHtUrsRLE1lBspA5XkrIgMewHUxhJKLF3gpHH85WpOz6tkpep
 +phC9ZtC7LzV6J9gp+gixygvKrTMTFHUErDZ80JxSGX7CS3bpSVcPgPC2D22Yb9nGLbr
 pgLrYb7FrnOErZPDnUnMWfofDjINiILynBNw97ztdp3P4Z22l7ccXJ0hCqbVsaWMq9Et
 o71Z6/5nBnrjIILJIKeJPE/IZSyU0S2OR0AdqCdGNUXuV/9JWa8qFcPibNiK3YymnpxH
 JttlGcg/fFn7R16O+7DlCL9MpGufYpwU4ZAplVQzaGsX6gQHzdtgYYFPVvNd01UaeWtY
 ru9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmZrFaWlo2K3ajCU3IUyOVYsjnmoSmCFMjgD8pVuse9SoytWZgo7aYnimwoUadfsvIciQRSA5SVJ98@nongnu.org
X-Gm-Message-State: AOJu0YwTDMZmU7LSfbHiMp3i8/jq55FNOuc2rcq6cj0fpyqIzuf5en8V
 rvRTm5V+Ne4+euWF+bIfWcUVPP6LYRVJ0w9aOQ5MSxar0Ghd0X5HmS2l12dCHhukcNw=
X-Gm-Gg: AY/fxX6BHQMrInqNO/vDo6SO6Q3dEJwdGJo88iZ214OF6D5TSnwYYzs/4Q48YiF/MDN
 NKYjycYvMvuoHz2k0WH71Kp3cwBpVTca5Jd2aSWo2NrdMDBrceNDB56iTOdRieEW0m6UoP0mytg
 rd22lmJRfvMtQSSyq0gNVyzHj2jey/dIBPO+UdrMnAOqszLi2gkLBs0nZ9VAbLQprQeyUwmxXv4
 jx6FM5GTof0g8XO0DZNBpQLJB+CMNpR6zeH3RcRqZEsb+yDxpTW7KfHo1WFvwxCXBUWRCvpzYXe
 OgKOlqgI2J9N/vf8VugDDfDG03eJjH+/gxV/yR2vwnHistn6hxQlD/+teR/siKIVwR/Tx2BKMEC
 hxYUtpErmp7yTadxVC86Yh6zNCCQSfUwpjTFaAP4tvDeYg69XMsQ7XHsBLu8FCjqpGhc9e0huQY
 LgCHTLXl4R1VEBVYkkRPYAN4bCKw==
X-Google-Smtp-Source: AGHT+IEKOhWqA6dGvST45GjJJreyFdr0Tn4Q7y0OMe4PjejCbE3aXuy0Xg01Eal4IUAAMeYj39FSOg==
X-Received: by 2002:a05:6a21:7a48:b0:34e:a801:8166 with SMTP id
 adf61e73a8af0-3898f923739mr12407256637.32.1768170535489; 
 Sun, 11 Jan 2026 14:28:55 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28ebe4sm15782329a12.4.2026.01.11.14.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 14:28:55 -0800 (PST)
Message-ID: <d88ec1b0-e429-4f91-a831-94292b67386c@linaro.org>
Date: Mon, 12 Jan 2026 09:28:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/24] util: fix interleaving of error & trace output
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-18-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108170338.2693853-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/26 04:03, Daniel P. Berrangé wrote:
> The monitor_cur_hmp() function will acquire/release mutex locks, which
> will trigger trace probes, which can in turn trigger qemu_log() calls.
> vreport() calls monitor_cur() multiple times through its execution
> both directly and indirectly via error_vprintf().
> 
> The result is that the prefix information printed by vreport() gets
> interleaved with qemu_log() output, when run outside the context of
> an HMP command dispatcher. This can be seen with:
> 
>   $ qemu-system-x86_64 \
>       -msg timestamp=on,guest-name=on \
>       -display none \
>       -object tls-creds-x509,id=f,dir=fish \
>       -name fish \
>       -dtrace:qemu_mutex*
>     2025-09-10T16:30:42.514374Z qemu_mutex_unlock released mutex 0x560b0339b4c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.514400Z qemu_mutex_lock waiting on mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.514402Z qemu_mutex_locked taken mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.514404Z qemu_mutex_unlock released mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:30:42.516716Z qemu_mutex_lock waiting on mutex 0x560b03398560 (../monitor/monitor.c:91)
>     2025-09-10T16:30:42.516723Z qemu_mutex_locked taken mutex 0x560b03398560 (../monitor/monitor.c:91)
>     2025-09-10T16:30:42.516726Z qemu_mutex_unlock released mutex 0x560b03398560 (../monitor/monitor.c:96)
>     2025-09-10T16:30:42.516728Z qemu_mutex_lock waiting on mutex 0x560b03398560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842057Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842058Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842055Z 2025-09-10T16:31:04.842060Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842061Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842062Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842064Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842065Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842066Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     fish 2025-09-10T16:31:04.842068Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842069Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842070Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:04.842072Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842097Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842099Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     qemu-system-x86_64:2025-09-10T16:31:04.842100Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842102Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842103Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>      2025-09-10T16:31:04.842105Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842106Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842107Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
>     Unable to access credentials fish/ca-cert.pem: No such file ordirectory2025-09-10T16:31:04.842109Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842110Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:04.842111Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
> 
> To avoid this interleaving (as well as reduce the huge number of
> mutex lock/unlock calls) we need to ensure that monitor_cur_is_hmp()
> is only called once at the start of vreport(), and if no HMP is
> present, no further monitor APIs can be called.
> 
> This implies error_[v]printf() cannot be called from vreport().
> Instead we must introduce error_[v]printf_mon() which accept a
> pre-acquired Monitor object. In some cases, however, fprintf
> can be called directly as output will never be directed to the
> monitor.
> 
>   $ qemu-system-x86_64 \
>       -msg timestamp=on,guest-name=on \
>       -display none \
>       -object tls-creds-x509,id=f,dir=fish \
>       -name fish \
>       -dtrace:qemu_mutex*
>     2025-09-10T16:31:22.701691Z qemu_mutex_unlock released mutex 0x5626fd3b84c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.701728Z qemu_mutex_lock waiting on mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.701730Z qemu_mutex_locked taken mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.701732Z qemu_mutex_unlock released mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
>     2025-09-10T16:31:22.703989Z qemu_mutex_lock waiting on mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:22.703996Z qemu_mutex_locked taken mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
>     2025-09-10T16:31:22.703999Z qemu_mutex_unlock released mutex 0x5626fd3b5560 (../monitor/monitor.c:96)
>     2025-09-10T16:31:22.704000Z fish qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   util/error-report.c | 67 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 46 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

