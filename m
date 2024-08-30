Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80867C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 00:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjpEs-0006cC-Sp; Thu, 29 Aug 2024 20:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sjpEq-0006an-LD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 20:11:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sjpEp-0007Et-0x
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 20:11:40 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d3d662631aso942890a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724976696; x=1725581496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5zr3TRZnHsPF5op+4s4Wj6d7I1okSHdvsVVMrVLV1g=;
 b=bn/2AtiuXjQe6xCPci3oRaPW2I0Vd2Gk8Ypwz9pfQEyP7lTo8Z+tUF448zs+kfeb8a
 kC3CHicuFu7H8qgWV0Hj+XSmVUik8MdTMhlB5NBuYkXsAlnTuXcGrk4fGsDVMxvqSKj8
 HmGIeBeik2VKjSOzC661vPF88yoiyM7391KDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724976696; x=1725581496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5zr3TRZnHsPF5op+4s4Wj6d7I1okSHdvsVVMrVLV1g=;
 b=sBR5D813iMkghDaeyyRgDTdxuogCHFxVhTf2LocNbyEeC5efBiUu3F+XjGkYQrdvzs
 uUrGpEqDme+h+Pa1mtuDoBP1XAYDJ8KDSQkb9jBX9ibl1GjFHq4iC2FDSZu13dzI38qf
 LspmmJuMOf8p1dmZOkWaqVCQkRq3Z7ZagdfTn/xFqVrPYHdQp/WuYE+kksN6k1l6oQKr
 pnZQUc41zr8439HcrWEbLeA6AX6mzmodWkaEyjEyeBvRQN1c5V1MsVvP3J7UiEr4qMn4
 wHdc8PoK4jlmyrnseOzCZvJYSjtneti/GbJRc2+kWHxcIAvfgikjlQjWAb+PN8qOcCaZ
 MSVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqDBBZgioctULRasZaoTpytTKVOqserbwjQJytHP3YopGZHXVdkHf0NTozDqfpU5TA4IZCeQtRKXot@nongnu.org
X-Gm-Message-State: AOJu0Yy2XtwkDxPD14gPa7k0+hk8lEka5V1TvVnyaQvenyjuObqnOzSC
 mvf2jeVw+UzkH8nWVn73La/iI6FlebX2zj41mPzis/4DNrN8eEpQzP0q6DhAaq5TiC/ZvEDs8QO
 ogQQ39g==
X-Google-Smtp-Source: AGHT+IHUV4UPEcfp5ARHUA72405T2hY6s1aXLHIfB+sxqI1Rq59ZCUHYRgWEAGBcnPl8nGQAQFSw2A==
X-Received: by 2002:a17:90b:524a:b0:2d3:90e1:41c7 with SMTP id
 98e67ed59e1d1-2d85638414emr4585367a91.31.1724976696356; 
 Thu, 29 Aug 2024 17:11:36 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.200.153])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d85b0fdf39sm2348395a91.4.2024.08.29.17.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 17:11:35 -0700 (PDT)
Message-ID: <573481e8-609d-4ac5-8a71-c8da27412041@schmorgal.com>
Date: Thu, 29 Aug 2024 17:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/net/can/xlnx-versal-canfd: Fix FIFO issues
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-8-doug@schmorgal.com>
 <202408291524.08632.pisa@fel.cvut.cz>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <202408291524.08632.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Pavel,

On 8/29/2024 6:24 AM, Pavel Pisa wrote:
> Generally, I agree that index should wrap up for cyclic FIFO
> implementation and change looks logical to me but I do not
> see and studied all consequences related to emulated HW.
> 
> If that is confirmed or corrected by somebody from AMD/XilinX,
> it would be better. I can find more time to do deeper analysis
> if no other looks into the whole code.

Thank you for your reviews! I agree. I don't know how the hardware is
actually implemented internally so it would be great if someone from AMD
could confirm that this change 100% matches the hardware. Unfortunately
Versal dev boards are very expensive so I can't test hardware myself.

What I can say is that before I implemented the index calculation fixes
in this patch, the Linux driver in the Xilinx kernel was seeing
incorrect messages. Now it works fine even with heavy bus load.

Doug

