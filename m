Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EF0C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 17:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s41yY-0007z5-Jw; Mon, 06 May 2024 13:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41yW-0007xD-P1
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:18:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41yV-0007UC-1W
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:18:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f449ea8e37so1928721b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715015882; x=1715620682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIPkzld/eOL5wcpcjvPM4HJzbcLE4dOswzwOWWmdxwQ=;
 b=NNOs51RQmLnDnm6NqZAHI3dwuDSUoR+2zjpKg9SH/OJBQzLHKFb8+H7KqE4wWIOadD
 Ra6LvWko8cyrWN6lquBTga0rOpYymRcex5mfn0Q40iU2juWGv04N4IthUaPbFqKBBNs3
 HfYmAjRJMVsfs/XZ7/B/z2lmVTqw1RTHPql9DKwO8lVpkj/25IIE53eM+E6KvWcARj4m
 h5AMgUzmvB2S11BbSuKMFuYQ/MRqmirK+AsnwAhAftKqnzS5NAiusbefzK0XylRKYt0G
 PitAnhSzQs7Z3m71p3hk/OTz3amRp+lxaAXF6jnivK9zSYcMBDXEJvVJs+rURrGb7LaZ
 rtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715015882; x=1715620682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIPkzld/eOL5wcpcjvPM4HJzbcLE4dOswzwOWWmdxwQ=;
 b=a+gf5/aXmrwHb5unme5oir2UQI/ZfLi011/h5B59vfatt8sbKZ+SWq2DdPBKzllkAw
 C/66UXjiv/jLhJIk9KqbQPgAa6gv5NA4L15IF6T1i+6N/NnZvVo9rTXADpn1KaN6KAt2
 uu3QmZ67JCtD0vIYP0I2/FrXiRTeSZDQvvPdjIjP4bptqA7P0E45UHpnG8fHrcywQ3tk
 kXYtjUal2SuC1Ry1mbpt7xKkWvV5ONgDAsrh0xcvZgQLcZQwmH/2XlUNldzFCoCjwwS4
 /Wv96xxPKKkgwwJECRFCnlEApyiwJ6tvpzYTZh/Pxe1OfUUsBc3Ujg0WchbhR4R4MpUr
 nmiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWreI84wF9WCGAuEDPpVvWVVLr8GBYRHCApeETN3VMsCzEBKA8QrcEPi3Y3V70IfuPxMWqqx1yU9/bJLIpBLzKtaFlezJM=
X-Gm-Message-State: AOJu0YwdTtYoDO+NVLFqgTS/vuz3z28ADjliTbxrZ86p6RyH7eImuX4a
 aQNBMCqAJIuuWSZhgxtPov41Ex80uVVqnLjNF+n5YnFLGnfN4uqvXJbhXwRs5UI=
X-Google-Smtp-Source: AGHT+IFcMfrgkCBf+fyfopLRiz55aE1fcnNtN6q520r58XwZB9H06GVOVIqdvtt06Z9lw6I8/JHwJA==
X-Received: by 2002:a05:6a21:3a82:b0:1af:9633:b8a1 with SMTP id
 zv2-20020a056a213a8200b001af9633b8a1mr9726015pzb.47.1715015881585; 
 Mon, 06 May 2024 10:18:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a62b40c000000b006f460e04fe0sm4121278pfn.14.2024.05.06.10.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 10:18:01 -0700 (PDT)
Message-ID: <ff620a6a-a6c8-4573-acd4-61dbd79fa6d2@linaro.org>
Date: Mon, 6 May 2024 10:17:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/46] Mostly build system and other cleanups patches for
 2024-05-06
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240506075125.8238-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/6/24 00:50, Paolo Bonzini wrote:
> The following changes since commit 4977ce198d2390bff8c71ad5cb1a5f6aa24b56fb:
> 
>    Merge tag 'pull-tcg-20240501' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-01 15:15:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to deb686ef0e609ceaec0daa5dc88eb5b3dd9701b0:
> 
>    qga/commands-posix: fix typo in qmp_guest_set_user_password (2024-05-03 19:36:51 +0200)
> 
> ----------------------------------------------------------------
> * target/i386: Introduce SapphireRapids-v3 to add missing features
> * switch boards to "default y"
> * allow building emulators without any board
> * configs: list "implied" device groups in the default configs
> * remove unnecessary declarations from typedefs.h
> * target/i386: Give IRQs a chance when resetting HF_INHIBIT_IRQ_MASK

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


