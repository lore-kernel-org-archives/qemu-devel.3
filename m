Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E981C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Rpd-0008MQ-3A; Mon, 29 Apr 2024 10:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Rpa-0008Lr-20
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:18:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1RpX-0000Mj-1U
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:18:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a68a2b3747so3376877a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714400285; x=1715005085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmTl+yR5HMQdFTJ+B43Ty6U73yAJU+dIZuZUTxG7iv8=;
 b=KkdlNDxR/3kE5mMARYreWcUiPTYO9Mqa5ybukAjOdhlXQ2vNHRcnmunzYpApjkvU4z
 uPVDMH1FgLF/YoWvZEAba6gFxQnHaNrCGNihTP6dUt0fzu8PhSbYgIHQw7Yq1/ZymssK
 zij72WMK6flAU52VXAr52ZKIAISc/CtQ5NEMAyGKW/jyLIXIKqteqDEouN71oyzR29vW
 O736Rhyl/klgUiDLAYKoOf2trm+H0Upf2nGFadUwk3fXcVKBMemgqrxQdYTCmQfrrsaq
 Mh3iLFzYW6NWG+sCJD7AXE1VI3qVB619nSM9NSySccF4n70RfDyO1Z1JefDA81QjMh0c
 lWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714400285; x=1715005085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmTl+yR5HMQdFTJ+B43Ty6U73yAJU+dIZuZUTxG7iv8=;
 b=t56l/kh9IHopXR4pOXLTq4DnyxW1nriF1tzn+cQSKLOEkjEI6SfRGUBDVuXStURC/f
 p2EKFSd13435Nhbu3flNYKntNco3t/IxHEm0hInt5zpkVUnFWWYPQeEvWdhs+/Vi3CX8
 OienO8kz827iWg5RifEcJ5pEus0gqSZdrtdlPBZX4R1Xe6cgUs1coQzJIqPiyDudOKPf
 oRK6Z22LM7eaHH83yVKYveWR1UI5Wvck6QUP/5HZJs1UsXhyYY2kkT1bySp91EXeiNpo
 p4gdH/M/JM7AqQ/OrqALKZgBnbbaT3jrWRFtk3OPHDdpEdCjkrm4z/RgGfqwoIp63Pcn
 NazQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxj29V3HjL0tztit3muvVkGpQ/lr+7IrLfMSghRBY5lwjAILnJ/Ia0p6CgdWMi/ZJ5594E8IfxtApBB9cyqMfiNsWhfUo=
X-Gm-Message-State: AOJu0Yyd0p9iDZLIpt+7uovs9cor+pWPEWxEURh2PNPR3GbTEJuUuBUD
 MC1zRFFwxYGf7wPS5NzBO16Ly1xv82FNGa+1MzFM2hV6pyMe3hU6eAE3iIYwZV0=
X-Google-Smtp-Source: AGHT+IG4w8IyWZhv3tBcfGpkLP9EWlA1rALY0BgjZeEvEcDVj2ECs0QsjGFs6mmOm4rl3vSo0zmcjw==
X-Received: by 2002:a17:90a:4a90:b0:2ae:7f27:82cd with SMTP id
 f16-20020a17090a4a9000b002ae7f2782cdmr6010020pjh.7.1714400284840; 
 Mon, 29 Apr 2024 07:18:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a656712000000b005fd81ad7835sm12744488pgf.58.2024.04.29.07.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:18:04 -0700 (PDT)
Message-ID: <11fd6cbf-cd8b-4469-aefa-2bfddf5a3ca9@linaro.org>
Date: Mon, 29 Apr 2024 07:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] iotests: add backup-discard-source
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
 <20240429115157.2260885-7-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429115157.2260885-7-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/29/24 04:51, Vladimir Sementsov-Ogievskiy wrote:
> Add test for a new backup option: discard-source.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Message-Id: <20240313152822.626493-6-vsementsov@yandex-team.ru>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
>   .../tests/backup-discard-source.out           |   5 +
>   2 files changed, 157 insertions(+)
>   create mode 100755 tests/qemu-iotests/tests/backup-discard-source
>   create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

This fails check-python-minreqs

   https://gitlab.com/qemu-project/qemu/-/jobs/6739551782

It appears to be a pylint issue.


r~

