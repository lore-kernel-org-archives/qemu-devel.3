Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89DEC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7vs-0001wb-NS; Tue, 23 Jul 2024 01:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW7vp-0001tF-59
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:19:27 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW7vn-0004hO-94
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:19:24 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5883e6192so571184eaf.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 22:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721711961; x=1722316761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGdCFSvKxj6MmhvGkGyvyITFOhEvDYx2Hhuhm4HTN3Q=;
 b=wtqVuPCG9I5tyxq27BltjJqEzs0K0hvIo98PklaZrhawiU9hwqLm7BIi8IcEQgIYpa
 sf9i++oUkWGx+PRZF+as34v796Rd5wf8wxQ1CJn1ROoA2h2nCTsIFAZeKtMmVXicBOGy
 QSYupvLXOsvWMMfTKJd8CFSrjGufkBR3BsRFa6Nzm0UGR3TJqEdBPXcebYJIHGIZSxkt
 LaOM4WcFz3yQPVnzqmLwJMgbJ/Gc7y3RAOWY4M+CAZ/YcWqYq64sHJWtGojvieBawMJC
 Fa6K1Txgk+Lfe4zOFOfKMfNHATQ0vHpf09sHcDV2rd+V8VOGN84Sl/k9ecrBzQ9BncgV
 yhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721711961; x=1722316761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGdCFSvKxj6MmhvGkGyvyITFOhEvDYx2Hhuhm4HTN3Q=;
 b=Dl2jI7xHfOeT8lQHZCkYYQDCeiKGnb+S2mm+kKDazO2m0wfE4Vt2LPjAOxjOwuWut7
 1g43hijlT/88BAmt/VDTYQ6ZT6sgvDAVEJjSKetm96ldGjDepo+Ihbo0FA/H/C88pIku
 N18qx7rBRMfqXDR/Oe4YgnFFTwRK56p8Qs2a/tc+8pl+CivBX5jzxldlx5n3V/aal2hn
 oQqm2vkZqhkEa6c/jn82bwpLmhKnimG0e/9kgCxGYF4MpJPK7CgQPGXfeoJQTpcioRZ4
 bGrpTk/Xzk7bgl3+bG9mraaJBnJGIo38LV68eV8dAdurTxH+7gVGs5ziX5m1J2o8Tnd1
 UzGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0GfeKShVGqSfgtanNZZFuAF3oPoe/WjA4kHYmvBRslaLRbbrUMPJmBDfsOWHOIBRQuTCt27e0yYZS1fk6Ww/uV96WSaA=
X-Gm-Message-State: AOJu0YzxpNDe95UeXP6pYrCXnmHzp3IoLmwJzkLllyu/6xHV/jRgcCIq
 nFEYGPAcyKeu/gryCPjQ2FB0uagWEovQrha0H7RkwJloFSHLrzr6I65RdGhCISM=
X-Google-Smtp-Source: AGHT+IGdHu0hBJKDdQbIKQ0Rh3kpIDjYr3qFQIZ8bEwqefRsN5wrbG6lDfQKaMtKZ0I7i6uCc++SZA==
X-Received: by 2002:a05:6871:70f:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-2646932d9c3mr1807296fac.42.1721711961370; 
 Mon, 22 Jul 2024 22:19:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5a149csm6194197b3a.169.2024.07.22.22.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 22:19:20 -0700 (PDT)
Message-ID: <5ff4f4cf-6e31-434a-a3da-6f121166ab87@linaro.org>
Date: Tue, 23 Jul 2024 15:19:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] hw/nvme patches
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Keith Busch <kbusch@kernel.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
References: <20240722164026.61128-6-its@irrelevant.dk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722164026.61128-6-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 7/23/24 02:40, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' ofhttps://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request
> 
> for you to fetch changes up to 4ea3de93a353b4462d96edd94be08d3be9484947:
> 
>    hw/nvme: remove useless type cast (2024-07-22 14:43:17 +0200)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


