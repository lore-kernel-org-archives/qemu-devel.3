Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A8ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jfJ-00017k-7Q; Fri, 03 Oct 2025 13:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jfB-0000z1-Qb
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:33:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jf4-0003Vl-Ps
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:33:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-27ee41e0798so36025155ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759512815; x=1760117615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsdNPd5OVZsXgLR8AwRZ04kzplAwXB7GHTFWAbkKGlg=;
 b=Kgn6tYxRiUSxXt+OSN+mKifYKsc8fRLQ/TnO2GKvWtOYcdyG/Hl40KRqP8vPjgRL0B
 EPY0zGJT0dZVCRlGHPri+MS54/uR4axsbs67hY41h83/CpPj9Xzh7Je8ttVoHMq2z4dw
 IfFKC33hL9q59Xje1bkFSJYj80SaihGRnAlJRsbu3ajMtfan22wncP1Bzc9YezGbXxG+
 o+YIuf5bfVSr3tKGXD/gRHCxwX91SAVgdeAL56DUPj2K0QsVmEaerkgNFoRdR26OwHnI
 wxDp1dhHp/ImzEd5RC6sUYUlMfMVbIWadCyN6FlOcdse4bQ6y0Gns8MJqpmlnPrd/pG9
 U1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759512815; x=1760117615;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vsdNPd5OVZsXgLR8AwRZ04kzplAwXB7GHTFWAbkKGlg=;
 b=URciq+Lm/zkKM79SDM2iD2eKL/VgnDlnoM/L7EGivgatG2Q8a+QILxGORa9ubFb+gV
 FIj6V46mOxbJtjN5Kl4bQcIQOwWMCNM91AQOh19/z/AeFbeerYcKBBMjVqiUKTQI51hY
 xt+79YcrTMPIcy0uUdSni8PxS5vuV9mBon+OEJK5TxaqwEiTtRsdcBS9Rbk99RerfWvP
 xg3BBQLu+iyYU2pX7MSDmwRmDzseVFOFje4ZosqmH+9f1xyoYpGtvq7FT0EKbI/odRMk
 Ogo1jopYRvEk+PhA2DIPyx1M5s0BpLD9864s2+4BHW8I0wcrTr2zPKBupZJU0UUHgB6W
 KoSA==
X-Gm-Message-State: AOJu0YxXoiiRBk0NVa8zAxhDjnVl+264Bli5Cj7aVBlcxykaY3LpqFfa
 uKsVKswtOhGnmbpBKONMJHVspA/e0BmI+voea6BQo6YEn6Wxj4AQ13BKbZ459U9tEM4ENwl2sW+
 31I6V1IA=
X-Gm-Gg: ASbGncuxtYpTOMpE5e/9qFuF15fT1RMOzdGBl0NjpXNp+pY/zHyVW6mSDheneUyk4pP
 hwYGLJuIJJ3AfZiQWSO0twFZrd8Flp2RPMVl+vuBD/xn8wHDoz0UAGTqufY2R/YY6LwKD6OGbP3
 1wg0yk+3Le7A07KePuXngYsz0ZDPEu+O1p145EsUefFZqKUTyA3hwyE5I+DUFIFf7oab2lioc1I
 7RcL3h7yaKVAsXpc5g4VKRQQQbizknA6YtCHrtk/fRb1HdFlb8RTwi1KDlxi0vs7WeFQZkQerqw
 0X7Vq0vBK+CD0bvjeUUPh0wmCR6hQHIaJC52rRkI3ni9TjtZASobO9np/mAxk+lCS5PlbuV3+eG
 c9kSk5klsWwgw57Te+BMAxQtXeEYn1ePd5yztNRHtew9YSlxnhgV1kSgkJ9rq6kc3
X-Google-Smtp-Source: AGHT+IEO3yTEneuGhWmmM+YmAnVmKJewcfMM7pO+Xa241wX/YY4hp4ZfX05rTU2bNyd94cXIDwx7mg==
X-Received: by 2002:a17:903:290:b0:282:eea8:764d with SMTP id
 d9443c01a7336-28e9a6568f5mr44996665ad.35.1759512814927; 
 Fri, 03 Oct 2025 10:33:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1108b8sm55712225ad.26.2025.10.03.10.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 10:33:34 -0700 (PDT)
Message-ID: <b78dda58-5ca2-47a7-9b5d-0f209a2fda8c@linaro.org>
Date: Fri, 3 Oct 2025 10:33:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] vfio queue
To: qemu-devel@nongnu.org
References: <20251003103328.1864910-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251003103328.1864910-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/3/25 03:33, Cédric Le Goater wrote:
> The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:
> 
>    Merge tag 'rust-ci-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20251003
> 
> for you to fetch changes up to f0b52aa08ab0868c18d881381a8fda4b59b37517:
> 
>    hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map (2025-10-02 10:41:23 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Remove workaround for kernel DMA unmap overflow
> * Remove invalid uses of ram_addr_t type


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

