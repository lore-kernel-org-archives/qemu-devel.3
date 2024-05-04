Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AFFC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 02:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s34iy-0005Ld-4d; Fri, 03 May 2024 22:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s34iw-0005KT-7Y
 for qemu-devel@nongnu.org; Fri, 03 May 2024 22:02:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s34iu-0005kq-Iy
 for qemu-devel@nongnu.org; Fri, 03 May 2024 22:02:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ed904c2280so404955ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 19:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714788119; x=1715392919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=srm7mw21kgd5V/T/ERxEo3Fo+k2Mpf/CtFfHueoXpU4=;
 b=Twz/9kEK1VSUy3XguVOxwR0xWQC7D63DO65mNp0Nd/w6A4pbH5GTIFjbt5TuB6Ha+C
 K8RuAnV5R3CsssLF9yuQzbZeh4dqyD2bd1YduSpiprISO6/tPgUawP0sNCXcxDxckTFS
 TQjz2G9uHzIaMjER080lSgDTehJy1RLBkSpq1JjUqSx+fcLDgmnbMgkSz8D5HDK238aa
 P/PWcEtnJV9+TrvnRdmHYoDtgM3XCPBOMiju/pRupsTecSABvgqpqI/JhIdBxKrZ4LwY
 GCCezcyFLberD13qGEReJR7aheEvyTWBKSuflU/am0f9T5PtCLxq7hX0a2pt06Yq1iy+
 KfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714788119; x=1715392919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=srm7mw21kgd5V/T/ERxEo3Fo+k2Mpf/CtFfHueoXpU4=;
 b=X8TJvYXXzLOvQ+DLl93gqoA6Khk9A5Skho2AsBvLX+PF8ojT5RLuIooWAtm5s54nEt
 2+itrmoc1nLGKhmb2wA83+VnIfxE27/8LtdHWYufCHBZwLN2ZiZcbF9dJ/jOiwxkpYq9
 1UdFMT8/AUwgYLoy8yiNSRo3FBuSub0JCOcLW94QddEGj0i6wTB95LgMo1flrq/mv2J1
 5Mw+BlELphJ8igp0+Dbntwek01g7Xhg1GcYJAR1g3wN+t/uV2mSM0lmzicj8hWp+9BlO
 XE/ZC5McdlCqqnx1L+6YdG4taH0BKPDp/Tt0403R7nMlfZsBgpln/YXgsgpCK8VV/RXg
 M8Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/XRMY1LW4zjIFZFScqCBoRepewaPgVfYkkmyZSMyWkFLK88aoMeI6b7TeecKcmqh1tVs/6YY2q3+WNrNhPTCZHkL4zw=
X-Gm-Message-State: AOJu0YyWAJywSxXD2g2Lqs11kvWmZHZTc4TGgRARvVAzu5mFhQDC3O8z
 pL0cAytBEQo/u7MG399EwfHu4sDEtyrfCzl/UhBJ4sIZ2VOmy8vXweiwBy2lDvc=
X-Google-Smtp-Source: AGHT+IEAl6v+acAYZ+EG2Nih5pr8q/HG6lb6q0lN4H2xMwbhXFmyaP2T8ABXsejUyexfCWJxNZY5Tw==
X-Received: by 2002:a17:902:c94e:b0:1ea:fb65:a0c9 with SMTP id
 i14-20020a170902c94e00b001eafb65a0c9mr5174821pla.20.1714788118533; 
 Fri, 03 May 2024 19:01:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170903244c00b001e511acfd0esm3939084pls.140.2024.05.03.19.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 19:01:57 -0700 (PDT)
Message-ID: <1262a9a2-40c9-4429-a4ec-404f3dec9386@linaro.org>
Date: Fri, 3 May 2024 19:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] Accel / SH4 / UI patches for 2024-05-03
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240503153613.38709-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/3/24 08:35, Philippe Mathieu-Daudé wrote:
> The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:
> 
>    Merge tag 'accel-20240426' ofhttps://github.com/philmd/qemu  into staging (2024-04-26 15:28:13 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/accel-sh4-ui-20240503
> 
> for you to fetch changes up to 2d27c91e2b72ac7a65504ac207c89262d92464eb:
> 
>    ui/cocoa.m: Drop old macOS-10.12-and-earlier compat ifdefs (2024-05-03 17:33:26 +0200)
> 
> ----------------------------------------------------------------
> - Fix NULL dereference in NVMM & WHPX init_vcpu()
> - Move user emulation headers "exec/user" to "user"
> - Fix SH-4 ADDV / SUBV opcodes
> - Drop Cocoa compatility on macOS <= 10.12
> - Update Anthony PERARD email

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


