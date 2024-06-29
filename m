Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179CFC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRsG-0000mu-M9; Sat, 29 Jun 2024 02:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRsF-0000lP-6g
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:47:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRs0-0006KN-Ls
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:47:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7182a634815so870428a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719643654; x=1720248454;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S+MjRKno85sIkJEQn9pPUmsZtOmoROXmN6hpyFbxuhg=;
 b=IWxs94ITdlba1UBufLnAZVvO45aKATAJMA71f9M/2kXaGUdY7/A4cOg4yfT16dqWie
 pSAdUtlyk54NgEOW4h3nAqRRd+YTkNo8KPKah/9C6kRn3PgzoQnDLcJtp2qY4b+s4Um/
 Ret9OqiAJxLDY2CxN0rlNN4NFmTTnWrGn4IOXdoFrMJqMMQh1HlCbn5TLQW15bKGPa4u
 xjRqyH9Jmglj84U5xDUV/404K2i+B0YZxBV/PEv0twthdNoUSVQFeZZMgt0hg7Z/FwRW
 iJVxpzzYyY83VhNYfm+Wo3jWf9TwMB4+LKV2PC+Ia3Hb0ZNr8LHZDeun4hy86O9rsK15
 LSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719643654; x=1720248454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S+MjRKno85sIkJEQn9pPUmsZtOmoROXmN6hpyFbxuhg=;
 b=ibx0Ye8FGgkFvrffYJF7bWy8g5usgjpBrcpLOdniNjzQdbTYETQoQQdtl1KggsrvIC
 XSZUv2lTgBlIppny/PIQyHk4qAlJCylqC/U6E1RLb58m2w682bzrISv2syDxfEBIa816
 W7LiI6N9t6SkPqlKz3PUzRtNo/IRkU6Rh8OFNM94JZSKxN9brKiOcZ8Xfyl2ANYC41LL
 kNimFlB0S4rpGLVlRo6RBlFboGP2b5eDadDI3MfugURr27BAWyAwyBDOUx8uwV72S/o5
 Bkrv4zfvT0wwodpGPpM4PqhqvnjRcmtesiXMebr7m0nX7wltvUqlnSvCcnTcd/Xx2tqI
 GaBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXhCw5507FK3TF+upiWBeogP0QWw+Hag0+2Cjw4KKSCNwS4lRCtVQHG/zmI+20xioSa2ZB0ZVU0+0UMm/J9M3BIrcqnpU=
X-Gm-Message-State: AOJu0YxqX/S+SS+gCiBkOmOsHdBr6gJAt78/GBqn6yvmLYQ1qbW6Zn20
 tneIwGON1o3WX3ui11KUtt0WFfMRovMeUlQ6XAE0wilLepmIf+4tm0+4eOufmKM=
X-Google-Smtp-Source: AGHT+IF5jjBWdZ55Xa7YFZE9u145VhgEDp0vRT7X9ehmenPanU9bcuRQjIfHahwWRgXL8ytlRAD2aw==
X-Received: by 2002:a05:6a20:6a09:b0:1b5:d063:339e with SMTP id
 adf61e73a8af0-1bef60fad03mr452632637.23.1719643654061; 
 Fri, 28 Jun 2024 23:47:34 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d23edsm25881385ad.58.2024.06.28.23.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 23:47:33 -0700 (PDT)
Message-ID: <31395fd2-74ab-42c8-b70f-9af9b879cabd@daynix.com>
Date: Sat, 29 Jun 2024 15:47:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/macio.c: switch from using qemu_allocate_irq()
 to qdev input GPIOs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org
References: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240628160334.653168-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/06/29 1:03, Mark Cave-Ayland wrote:
> This prevents the IRQs from being leaked when the macio IDE device is used.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

