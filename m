Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA17CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 23:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Aeb-0005Pd-LD; Wed, 15 Oct 2025 19:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9AeZ-0005PF-Ln
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:11:32 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9AeM-0007ut-Hr
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:11:23 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso33310a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760569875; x=1761174675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRkehSbbYnCBR7rIOTtKX8peLBAoL3pK0n1P+W/u98Q=;
 b=NVA9MFFQ/tOncvjF1LATbny5KNrBrZODVxtg1osPjVD8xwLG1Jv/oTCXwgT8XpSMqm
 atBRB7BGGerG2u8nVhLEg39Pgq1+5i2Q77olWyHyA02C/tvEtse/2MzcFSs09ZjCjMXX
 R1iGmMDWnJ/fQ3W5rDJB7lK7sGP3ilXpPjqK3Jb2lGArvyB2JSRdL671VQ/RVFMy8fTc
 6mKgivBv/6URkVdJR/57LhX4GS3uHmXGkqF3T4aKLxNrvhDLZqVrf4zUZNgJThSn0pKn
 8GNf5UIbPasppOvJ8lLMDnBYHYI180CGDkNkyGPWsUqVq8apvBxwu3+vHjyPZ80GSAWt
 id4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569875; x=1761174675;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LRkehSbbYnCBR7rIOTtKX8peLBAoL3pK0n1P+W/u98Q=;
 b=alm5H7eQ/t8IntMbpVwFUaQbuk1gcAFMZd/6ayjt+vb3mijNiuYWaeWhEp3ADNVBDr
 im1PelwbvMCastLaXReoU1ElWWNtPCNkHspAgsX2GFKLuTpg1XLnzuhNu8eMXL2LCdnt
 8Fy++WQG/sBphyoRurokpqgt067jkyQTMOhETjtpEOxnFA6KDP66mgovkP0571toYknr
 z87VYWiU2vtG9+zUL0+d5wLvKYzM69vWPhyi1om/lrpUFZtXyG07iN4DC5TkaSgXGqkL
 W4c/UcmskwssbKJeNb0PSvSqu4CKtABvgrY57cgqj2Ex6ZCFjUpBeYuZcSCZ+0Faovx0
 oLsA==
X-Gm-Message-State: AOJu0YwIy8AVDJIePWMY+gOI7P5VRM7IQPYvjS5l2pCfqXFKYgAHHWwR
 J2yk+qVRgwrhsX8BhLPo8UnT37MN9dQxlXADPz1JSwZOJ2cdCiYdpn/mvqmh+6afkZvh78fTgc2
 g4t6Roe0=
X-Gm-Gg: ASbGnctVl6/0N6KP40/5vzGYJFsXYX+hXv1rdhfkpSgEj1Uv9Lgg4lMU1XgGxpCGavr
 uPtofsBB0leftVudtfB0UxkQy0cng3S1Q5Beq8DZvJYE1y/FkWARejx7oVP0pyfRUtRj39C5HWf
 KZui/akPSZ3h09H14a+EzAJ+irWYbTP66opbSSUaWNIyR+3+sig9ZuUk8fORvLfO4tPgkbBRJaV
 i+UemXY/bDK3Vgr/8pcWWOm7X99Sy1F7c28zZwam8ku3cZS2IKMvtJKuyI/1ZhqVEMD6kYyuBts
 6vOch71XbJDb1HSHr7R5zmk8E3i0v5VVZVkLK4/JtgaNctx/Pb5qynQr4qmLHXchtt0BKB+Cnp+
 hIswgoeY0TP9NyO7cizS0qsjKVGhf6VYkeXXQUuZNbUVM8pkRgWzXiL1n4Ue/PzjLSCJRXmuEnQ
 hhtHfphzeZfp6QHCFitQ==
X-Google-Smtp-Source: AGHT+IECAJw8OK2/TJDK99AqHojUqbzjt/nyVT6EoNCgKxxmwogOIGOMmudr8fStz2K0wHUg/eekbw==
X-Received: by 2002:a17:903:1b4d:b0:24c:cca1:7cfc with SMTP id
 d9443c01a7336-290272ff6bemr383181005ad.59.1760569875039; 
 Wed, 15 Oct 2025 16:11:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099afdc02sm7484585ad.110.2025.10.15.16.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 16:11:14 -0700 (PDT)
Message-ID: <4f74292a-bb61-4ffb-a7ff-eefb93d8f9a7@linaro.org>
Date: Wed, 15 Oct 2025 16:11:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] loongarch queue
To: qemu-devel@nongnu.org
References: <20251015035651.1462972-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015035651.1462972-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 10/14/25 20:56, Bibo Mao wrote:
> The following changes since commit 3bf5c57a11827d9fa706524d57ee3e5af68a429e:
> 
>    Merge tag 'pull-tcg-20251014' ofhttps://gitlab.com/rth7680/qemu into staging (2025-10-14 10:25:05 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20251015
> 
> for you to fetch changes up to a9c5e0ed9b63becde7a6188bf71f95e31a132b19:
> 
>    hw/loongarch/virt: Sort order by hardware device base address (2025-10-15 11:07:37 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20251015 queue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

