Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B8C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCXj-0000De-RR; Tue, 23 Jul 2024 06:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWCXi-000094-PZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:14:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWCXg-0000ec-JL
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:14:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so1665549b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721729686; x=1722334486;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h/Jhl9q3azKsjjZoesAFf4VCmBVR9zWjLPQ4d9xRNnk=;
 b=vZcSjkwyYZrD2aOtFJC+AVa3m63dVsFnWD+fObSJhMFWMH4VwWwlyn4UslpZ+oNa5x
 2MwUhVP83PaNdo0iYvINsFV3r1NcI7n8VncXNW/O8HJjNAU7UtMwsbgN7jvDaVbXPZD6
 MpaPCqxqO7wbYT9SCyt/Bx+kuXL+SFODaq7mLGAC0AItoyuwG2EKN23tJ2ZJ7Oj5HDdZ
 aqENpCkRCovCElfljbyotTBZ4NWZHuLg91qk5o7g0pzGRHd1tjRY9pZQJq80M2EyNXd2
 gXWFljnghXGicUKBJRKG1G2TcoV3wa0HtMemiYe3AWiDR0gTBMX2HfxMbB0Tt0SgFu6E
 Gflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729686; x=1722334486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/Jhl9q3azKsjjZoesAFf4VCmBVR9zWjLPQ4d9xRNnk=;
 b=s1iFZw1wJeU2Ju6SK9kShz14bABMBGOLS4p0JyqswRnHygp1rPpW4rS/20Aiz9xkib
 gv+dk78IELbBkx2Em2N9EYkwIbyUnB+uVQ8i7k/XEK7nAyGvXu2zzcW6KXNQdBZovJMU
 Q/80nb8aCo918ZbmYGdE1pbi81QXVB4IMIuKpAs/5rm7PAf96bkmdcit0xdzS9kcI8Pg
 V+M3mQVTsezx3yqraM5+FipS+0itCfRHv+Y0V+yDb6E63zzjGZnaTQo2LY1+WqtoAcGr
 wBZl4aeVMOXk733f17sRB5W3HA4nxljI5UkURTXh7ANQFdl1rYqizFY1VEZe0dOYXJt/
 XGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAoaELASJLA1GnPbYzp5lfnSJH2x14kVCJhVGivUzTCJ6FLF+Orz0+SVZAGARiPaoVHDfJcrkwxjP3/DGu/XfxQd2GnkI=
X-Gm-Message-State: AOJu0YweVoG1hOslKkpeyMORlr9y6wQkI761OvVjzQsocuGvJgSQb9RS
 yQ1R73LWL4by17Pv4wAwyIMQW6XVoQxvBGB6DhxgSgDYnHH5KMQB4np2cqGx3EU=
X-Google-Smtp-Source: AGHT+IH/Qot6Zuf134F0i500oPjr91m9fDEVOI1/EDPUO6MrBzG3m6rwcGQ89nboVrmMI6K1gH0eIg==
X-Received: by 2002:aa7:90d2:0:b0:70d:15a1:f052 with SMTP id
 d2e1a72fcca58-70e80753666mr2347610b3a.1.1721729686399; 
 Tue, 23 Jul 2024 03:14:46 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5a149csm6637963b3a.169.2024.07.23.03.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 03:14:46 -0700 (PDT)
Message-ID: <d5f7e8f5-9085-4330-9408-f3ecab3d3883@daynix.com>
Date: Tue, 23 Jul 2024 19:14:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ui: fixes for dbus clipboard hanling
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240717171541.201525-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240717171541.201525-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/18 2:15, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> -display dbus clipboard is broken after a client reconnection. The two main
> issues are capabilities not renegotiated (and thus guest agent not fully
> functional), and qemu clipboard serial not correctly reset.
> 
> Marc-André Lureau (4):
>    ui: add more tracing for dbus
>    ui/vdagent: improve vdagent_fe_open() trace
>    ui/vdagent: notify clipboard peers of serial reset
>    ui/vdagent: send caps on fe_open
> 
>   audio/dbusaudio.c   |  2 +-
>   ui/clipboard.c      |  2 ++
>   ui/dbus-clipboard.c |  4 ++++
>   ui/vdagent.c        | 11 ++++++++---
>   audio/trace-events  |  2 +-
>   ui/trace-events     |  5 ++++-
>   6 files changed, 20 insertions(+), 6 deletions(-)
> 

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

