Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8914C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJW0-0007Zl-Kr; Fri, 12 Jul 2024 12:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSJVy-0007XA-J9
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:52:58 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSJVw-0002Dz-48
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:52:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b13791a5eso1929728b3a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720803174; x=1721407974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrBDqgW7Pt/IhhHXkQWCegb5Nl9+Ldnc6JPZTauYPQY=;
 b=BxBQZymtVYpG5ckPRRSUSu+vA6b/ihM4PcCQqurRGGWelxbTZL8zV37vV7JMugA0n5
 fTinuyz1m0Ao2qkU48Q1zm0UNBOS1ADEVi6IPO5+DbAAaGFtqUN9OfgN6XTm71LCT21l
 gu99RweaBbTeyqmS+FrgET2/stNXEX24BeLVOZUrOFwhwdRHQS5GxsdQ7Qr4f5n39FT1
 ZsX3oBANJJdoYhoVnu7Pl+hXHMkqQSPoSzpsNBFsxATFp4ewn/O071BnAqsY3tIS3A6y
 7ZMmVTz74No7CGPyCD8oUIQrvHSlYgSGF2nr9H9RTLCnHpyAEZmjquWhdScdQ0aCc3Oi
 Rb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720803174; x=1721407974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrBDqgW7Pt/IhhHXkQWCegb5Nl9+Ldnc6JPZTauYPQY=;
 b=Qis0DH1ZzeeQVJkqaj8vcnZwtNmtugEj2Rm2l6JTCsGOMi1uBTGAE+df6eSjj/f1//
 dbjEoVQvE4ZAOvIozcFryQF/lKTQgjUf0vblPRlGuhnGj2Nx8HWQnBmWmqvf1Tz+DeON
 qqyrdd6Qc6BenUFiLRHFU53qs+D0zasH4on5ZCdubnyuB7FTLkpFYCq1I2bUq1R+OiuN
 nqjO363wvBVDhC7ycJ2ZdO2HyIcbs9GcIVyRsEWGrDhLt7O9U2G7AN4TLEjTGOj88t2j
 H2btlRHnhf6O0YFgr5WSBfO7IQiPyflVoCIcyDbQkQClNzj7NH/gA2BSA0tH9Cl2dlFk
 FSeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK1N0HsRrD1c3nkl0f11r6iEk0sPQuUMltA00ZVsnSfwukTte++DWJ4GrbiAjxa/8j3D+Gc29xU8CyNxRiBCNMzHzqnKE=
X-Gm-Message-State: AOJu0Yzeu+kZw3HgDJmsYv5ka5LJY6tPIbkoZp0DkOrAlegMUtwUCV8p
 fRlwnMZlqjObsOTvW/oCXsP19SQaOJ4Tm/hsbdpLyQUAXUAUA0ZjMLMj5ArVCx4=
X-Google-Smtp-Source: AGHT+IFktE7IMSePbMQNqHudd3IiQ3yCJ7xzddZ37g09jkVmegY1f9vMHoGRJivieLWF/bt/ktZHnw==
X-Received: by 2002:a05:6a20:841a:b0:1c2:8a0e:6f84 with SMTP id
 adf61e73a8af0-1c2984d8e25mr14582974637.51.1720803173599; 
 Fri, 12 Jul 2024 09:52:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd2d089asm1796243a91.2.2024.07.12.09.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 09:52:53 -0700 (PDT)
Message-ID: <7c6cff38-5602-4536-92a3-0075f6a1bff3@linaro.org>
Date: Fri, 12 Jul 2024 09:52:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] hw/nvme patches
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <k.jensen@samsung.com>
References: <20240711180436.8532-9-its@irrelevant.dk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/11/24 11:04, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:
> 
>    Merge tag 'pull-aspeed-20240709' ofhttps://github.com/legoater/qemu  into staging (2024-07-09 07:13:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git  tags/nvme-next-pull-request
> 
> for you to fetch changes up to 15ef124c93a4d4ba6b98b55492e3a1b3297248b0:
> 
>    hw/nvme: Expand VI/VQ resource to uint32 (2024-07-11 17:05:37 +0200)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

