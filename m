Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139EC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdxT-00059a-2w; Tue, 16 Jul 2024 04:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTdxO-00058M-Tm
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:54:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTdxE-0007nh-BI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:54:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so35941085e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721120074; x=1721724874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePQosVdHXI/CSps8s7Gi0EgFdKrW6ePfrGnNmyknnJo=;
 b=qduy/uyMo7eWi1Tziv74psC0orgQYVvLR7ZBn81UDEZmHkmDp3pDdBqfSouxVQ8z9v
 hpIodRsHiFEw4kRtyLRM6Hf/i+T7aqC1YRpCaBcRQm5DglHZmVmYhSGmWVVepyBieU87
 z+9mDVuYR6YJOIezo8iXc17AQ4Us9SRnDH4J7BRtuZaRq6x6OnwNtCniMG3SDku+AjjK
 PFgPPHbSM4CPewVfMR2GpC8PEHCG8k7108bPunvEx/9huVPdpNRHgZYdldEM7g8ZmRXC
 Z1vnHlvOtuLYYSC1EM7MCse0oNIykZY/pKmChMu+4lkRMK0SG/bIi35E2DM6iXOhVoVs
 Wh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721120074; x=1721724874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePQosVdHXI/CSps8s7Gi0EgFdKrW6ePfrGnNmyknnJo=;
 b=o0azB7/AbxqxmJRpwbdJ6nqoovn3tw23F/6X6l9KKGicqRHlx41UKsc9lSmV03JCoJ
 DL4sv/PyIp49gz7/uHxP+3ryoUkWW1qNTpCKUsSogtJ53ie8TNQVD2u1Zbnf7x1INHGQ
 lwxrizumPtEE8oKylFHdMI8wQErDSVyzbtSRQmlhibJLdUJoWo6iGpiK+NDBe++iZ7hi
 a7gtbm+VAeLRj+3KitsuHikghK66WcOt6ZTSjvuJ3RFfH4QVEWKP1F8OttGZTYoURKm+
 azN7jh7K8lSVirBIfUzSrGpqC68wzs8sjjuT5EhO0SzhTexoGj5eMCl6UWyGElucWSCJ
 8CHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfidUHY07sp1rR4sFpg6/EK9L0oB8Rvlu3Ls+PJUgAf7owJfLY5JdSgYgKpNlJF3NGW9pGbsR45X3ARMOeH/5slzddrq0=
X-Gm-Message-State: AOJu0YwlNluk3FUqxSugVVzQ72lb0N8RtNOcLgCMw7zJ0GDS2PqpD4nr
 aKRCo0IbJZeqBFFbWzjZ3naddGmnBgIaKOMIh90YtGC9zKw7P5vj9IE4QPLEJfMtzIpHVzbO+IW
 JPNg=
X-Google-Smtp-Source: AGHT+IEd+OrkySYRqTvbFPtUQtjZqzOh41L/uCt9nPj51I1IscqYX70612GZ4E7aS6abr6rW+xV2yA==
X-Received: by 2002:a05:6000:d84:b0:367:8847:5bf4 with SMTP id
 ffacd0b85a97d-368260c4e16mr968456f8f.10.1721120074569; 
 Tue, 16 Jul 2024 01:54:34 -0700 (PDT)
Received: from [192.168.86.175] (233.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e83273sm115614745e9.17.2024.07.16.01.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:54:34 -0700 (PDT)
Message-ID: <618d4219-6791-4afa-9101-8e83f6758027@linaro.org>
Date: Tue, 16 Jul 2024 10:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAMBlock: use return value of ram_block_discard_require()
 as errno
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20240716064213.290696-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240716064213.290696-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16/7/24 08:42, Zhenzhong Duan wrote:
> When ram_block_discard_require() fails, errno is passed to error_setg_errno().
> It's a stale value or 0 which is unrelated to ram_block_discard_require().
> 
> As ram_block_discard_require() already returns -EBUSY in failure case,
> use it as errno for error_setg_errno().
> 
> Fixes: 852f0048f3ea ("make guest_memfd require uncoordinated discard")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   system/physmem.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks.

