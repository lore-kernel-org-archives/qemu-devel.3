Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C1CF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtiT-0001z0-CA; Wed, 02 Oct 2024 03:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1svtiR-0001xt-3l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:24:07 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1svtiO-0006GW-FV
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:24:06 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db1f0e1641so1926014a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727853843; x=1728458643;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x+yNnlpwhiZpabLHZVwIMl3B7TF+vNXNQHUE0P2wfOQ=;
 b=Q0drN2Tg4QVwxwQs0W/luHpIE7lsU3NtmvoWVVjZaekzdfyLcJq+pp49fAXMl9UVUM
 wfUW6iposQ+wXX2uNwk3SpC1jLw6OrJTnSkuydNFsLN6ZZZcZSn/txHQdB4oIjdPGt5N
 K5QFWz41OwA0dxi1/c1F8X7F4qTyx9ILkTafF7iHe0nioBtryc+ppGrZ0EkZct5nfBla
 UjvARfhfal5SAJuRiDOcWu1MZQGgMRY56LF7ui8/YDKZNk7wOg8U6C4MtyzwCMTBeZZJ
 HFlbTwAv3QbRbOTDZ+XaKEsDvwnK/0b39ZxHJMvnwxqcqm6/+LzIv38k1te/hZYZeZOe
 rjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727853843; x=1728458643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x+yNnlpwhiZpabLHZVwIMl3B7TF+vNXNQHUE0P2wfOQ=;
 b=I2h4yxMFcjdEw452r9c1l8zMfIJctZdJFttpqfifZf0Qwo2P2gEwxHoFHAywKFDcbf
 3uOB+Pjjr/dkh+Owv8/O6BTAhgq45begZBVuU+WBubDKiB7vyabBe5T06pxMC0Sdu2ot
 OhregTjoZoU1iNRZ/s+3Kcj3BC8PpGlC28pYysCFjwR5xFAonjadQxpVOXzVyp6b+MxH
 a28qDlmkCNYf/at0JWr3pGRcD+O9MOUF68ZqptOurIcet39Z4SmFTKpLEBt0iZT+7Dv/
 Q2KERD6aC1c36Adpka2HMeeRGqPgCHS9SI7oErU8aiGRtOJYU9EnT/0iP0/a9e9k7Fob
 O6Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlrzVQFHPnhn94MQOb/SrgfHlqar6SZbL7rl+ty0h6ycwoLY4wpvqurkqNciWp5gfat9uwjPJZg8lj@nongnu.org
X-Gm-Message-State: AOJu0Yz3xLdAuvtgKdle6ZkaJdvxHOO/zUJR91z6VWv5R2ncpSM/Kda6
 cg5AkEDsTekkM8ZfFKpVY5u+W53HFvhrFV4LvGu7BcBs82Ydt4SvGcDApHWZ4Hk=
X-Google-Smtp-Source: AGHT+IHbvGejo+5oIyKA5gHt58vzRnAOGfT6qHRGDbfW1PE5rsFN2OvLzLREZyAAw6hRDq3F+yrQYA==
X-Received: by 2002:a05:6a21:2d8d:b0:1d2:e458:4063 with SMTP id
 adf61e73a8af0-1d5e2d9e263mr3185688637.33.1727853842686; 
 Wed, 02 Oct 2024 00:24:02 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2649a2c1sm9175411b3a.35.2024.10.02.00.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 00:24:02 -0700 (PDT)
Message-ID: <8a18ce67-8a38-4567-a903-38d5ef687b57@daynix.com>
Date: Wed, 2 Oct 2024 16:23:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] ui/cocoa: Adds non-app runloop on main thread
 mode
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-4-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> Various system frameworks on macOS and other Apple platforms
> require a main runloop to be processing events on the process’s
> main thread. The Cocoa UI’s requirement to run the process as a
> Cocoa application automatically enables this runloop, but it
> can be useful to have the runloop handling events even without
> the Cocoa UI active.
> 
> This change adds a non-app runloop mode to the cocoa_main
> function. This can be requested by other code, while the Cocoa UI
> additionally enables app mode. This arrangement ensures there is
> only one qemu_main function switcheroo, and the Cocoa UI’s app
> mode requirement and other subsystems’ runloop requests don’t
> conflict with each other.

gtk and sdl need to run in the main thread so stealing the main thread 
by setting qemu_main will break them. Please investigate the possibility 
of running CFRunLoop in another thread.

> 
> The main runloop is required for the AppleGFX PV graphics device,
> so the runloop request call has been added to its initialisation.

Please move this patch before any other patches that require it.

Regards,
Akihiko Odaki

