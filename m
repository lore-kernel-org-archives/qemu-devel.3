Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85CEC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0N7R-0005zj-7d; Fri, 26 Apr 2024 11:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0N78-0005xN-Pw
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:03:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0N76-0003Vu-E1
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:03:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso2961835a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714143826; x=1714748626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DPvFAWUn7+P9t1NudqBmjHJ5I7VSCG+4l5ujIe/40qo=;
 b=KiGaiGKSU/YWl0yP3p8+YVPuKkIpq6TGDcBLlbbdKQEoG8abG2sQVzj/mewjgEqEH+
 AgbdKr2zFuJccHMzNz490vxoCg6eesEAtX/PPzvkNzHE+I25Mo2EIDDPbVgyh5O+SmEU
 9GTiaV7xZIUfHa/VtL3fPfKPw60+bbM+PTpPams0U9utcG7xRexd8jfy3jfmFuIwv6Oc
 tRSMzocOSlm9erTiQBWJwy1Joo0E6zDgJHeiyiO+icsUGqo561s3/u/9x2LNA/ESJ9I4
 0Lm2E9lPO54PdNWVPtNsJpE6Q5DFgYShR9xxBRRuppoTR3hI8nuDiFDP8FU3Y7UnTgsb
 jr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714143826; x=1714748626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPvFAWUn7+P9t1NudqBmjHJ5I7VSCG+4l5ujIe/40qo=;
 b=E7LNC2wv8MQXthaxgO22pPzpCk6oZN+FISG5ObY3kTaR1VV6kmPUZEdaQ+RFA1xB0/
 vCRd+YtRJ42rqy6BDv/6d9to6V3PSEWGD5hxWeRtzpStOFX8A6XPM7DrgH4vd8giJ40j
 zN/QCEJbHJL9RuJHDdemsPf7tee+0rxzNNlfl1BB9DqN3zMK+E7GvMcoYf2olLdRkzla
 N3345KZB0JOABrhKRrkB+hwau9TQQsSIiK6wdgIk8AXR6W3evLISb3d3yOhYt2YYk12F
 fqnpB294sOypz9U/18UCNWHg46uf5Esr0KzYgVXyxb5ZnJMJi8jw8hHfUWeNhe5JVSaY
 u9Zg==
X-Gm-Message-State: AOJu0YyjQ3qEuPl5MosorNypUczgU7FQilqV9Lly2HlfUPwccuapXkvt
 KL8SkHKcRTMabXG+i4IAFCQkDS+Av+1lqasA+uP5Gwh2XDCpWXnW0pf+vQoAapRUG30iPDCOjs4
 OYoY=
X-Google-Smtp-Source: AGHT+IGJHYwjfzVT/0Q86SLS0H8FTypzwGeMJTljg/jMceYCae+feEQSabYTt/pDMPx8OGkn87MBiA==
X-Received: by 2002:a50:bb6f:0:b0:56d:b687:5a45 with SMTP id
 y102-20020a50bb6f000000b0056db6875a45mr2295070ede.1.1714143826203; 
 Fri, 26 Apr 2024 08:03:46 -0700 (PDT)
Received: from [192.168.69.100] (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 et10-20020a056402378a00b005725ffd7305sm223625edb.75.2024.04.26.08.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 08:03:45 -0700 (PDT)
Message-ID: <76d4e198-2a10-48c3-95af-30a5ce14838d@linaro.org>
Date: Fri, 26 Apr 2024 17:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] accel: Add new @dirty field on HVF/NVMM/WHPX
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Reinoud Zandijk <reinoud@netbsd.org>
References: <20240424174506.326-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424174506.326-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 24/4/24 19:45, Philippe Mathieu-Daudé wrote:
> We want CPUState to only contain fields used by common code.
> Start using a specific @dirty field for HVF/NVMM/WHPX
> (TCG then KVM will follow).
> 
> Philippe Mathieu-Daudé (3):
>    accel/whpx: Use accel-specific per-vcpu @dirty field
>    accel/nvmm: Use accel-specific per-vcpu @dirty field
>    accel/hvf: Use accel-specific per-vcpu @dirty field

Thanks, queued.


