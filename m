Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED7CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IOq-0000gV-1p; Fri, 10 Oct 2025 15:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IOo-0000g8-DA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:03:30 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IOe-0007Zt-Pf
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:03:30 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-33b5a3e8ae2so1707982a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122995; x=1760727795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4bjIaIgFhpJYjshyQ+5nwUZ0nRqGq0a2Abz5FkDk6c=;
 b=IupNUxBpfO4Vktbc+qPpbgyMfGo8cPQ9wXdQQf1wlFGNzEycRIdpv9D2sTroYAAgYp
 dbyGFLkf8Dp9fPzNX0Bj0rl3wjmjUQteoSoDh0C4KrA8D+7MgJSt2JrzUFrMqtxw7yNX
 76YL9eEvOYuFaGHBQy7GVbdVv0k9MRUFgIVHZ8uPei7DOHUf7iVG3vEDxR0eFR1arW2C
 MtbeAb7dQdehrQ8PR2EJ5wTlez17PlCP9oHt6roTaWdxlgNuju2EhCP/NLbQvxPN4r8s
 1OUym/szV4UtTwI8ttYVSP/NKtdMxdQyWhNsy64m/Ow+YO0QdAo9jSeJWB4XDutw176n
 eb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122995; x=1760727795;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4bjIaIgFhpJYjshyQ+5nwUZ0nRqGq0a2Abz5FkDk6c=;
 b=jTb9FZnMXjLZ4gmEqiD0tclO+rXDyJ6giokJfY3eJVO0PiacKNagkVOiWfZQky9KBi
 mqniSgW7yEWIjeXvbpgbj6/JJdIU6VMPj9loGiZotjZlQJ4acLfgRwgOS6J8JNX8t1pq
 Cv2Vq5LiIiIi6yZ6EaUU6oJnchSiSp6my3LLFXYZ3QaFrxvAvpOep090FfxP1I6rmQCL
 /DnKmFX8l9zaROed93eWeWD4xg6U1CtUk2PSA/grkpg+U/wHzxmWM85j/qzJMq+IOG4W
 UYIfdDUsXDm6F7JQ5gH8jsagB4GYJ9GW72uG69zaEgBuu9aMnK2RIdoTSmGK4zkdwz9Y
 UVGQ==
X-Gm-Message-State: AOJu0YyLY0g2T0JEU1PstUJK3Snq/5QDBzbpZJvviY382azIpPERAZ82
 IBFBfUqQPJP0ABeCOstRoNlRFQMX8jmyA5UiWeddQU8lvRkajofWKDvRuitbmLawTTwr2aL0OZ/
 UGioDkic=
X-Gm-Gg: ASbGnctAoY+zHMNKrq8Bp4LGTD7EfOAM5LmPQX/WvlGSSqh9HHO4Utl0pZuf3CT0GgI
 aRImQfjaNgi9QjZKE/pVvBbdNvJmnX7aMLK/L4hQnhUOH2bLassLdt1LFc+3zOA/C05P4xpLXle
 wgeyTeerFNroSRnV5xPKXkWSOpXS37eZlYre5W7dEixg9070ih6AMsFku49y+7U1z8VMXXyr50Z
 BnmcETNz37cK+rTwCmRhrVfqFAZDEVBj+bu3Z5/LZZN5WQzV68kbtyoJ0AgAIBFa/UZ0UMZ/Ro7
 BjXIlG3+mbOVoeSYXd+ERN3PvWjluid0qQnVI8ixdr2fNyA0D5arRZB8za5/wmgaEcUtPYcHw67
 gywPahOrDCngndBYcQkdG13y4sTJII3ID8ja52h2K+GaMyy0Q5dZLOuTGFgM=
X-Google-Smtp-Source: AGHT+IFw7U6hyzk0/JNoLA2LRSYbfgMvQw2147ATBxbxzOIC2kyrPonTDWHejP+9g0Jg84De27leew==
X-Received: by 2002:a17:90b:384d:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-33b51660472mr17364460a91.1.1760122994606; 
 Fri, 10 Oct 2025 12:03:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b6262df70sm3771221a91.1.2025.10.10.12.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 12:03:14 -0700 (PDT)
Message-ID: <5b5e10b1-cede-42da-91ae-72f2d5172116@linaro.org>
Date: Fri, 10 Oct 2025 12:03:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
To: qemu-devel@nongnu.org
References: <20251009141026.4042021-1-rjones@redhat.com>
 <20251009141026.4042021-2-rjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009141026.4042021-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 07:08, Richard W.M. Jones wrote:
> curl_easy_setopt takes a variable argument that depends on what
> CURLOPT you are setting.  Some require a long constant.  Passing a
> plain int constant is potentially wrong on some platforms.
> 
> With warnings enabled, multiple warnings like this were printed:
> 
> ../block/curl.c: In function ‘curl_init_state’:
> ../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
>        |             ^
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   block/curl.c               | 10 +++++-----
>   contrib/elf2dmp/download.c |  4 ++--
>   2 files changed, 7 insertions(+), 7 deletions(-)

Thanks.  I directly applied this to master during the last PR batch.


r~

