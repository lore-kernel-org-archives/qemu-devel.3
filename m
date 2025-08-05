Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134A6C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIba-0003o7-Lv; Tue, 05 Aug 2025 10:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujIac-0002tA-K6
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:24:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujIaa-0002vq-Rg
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:24:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so4451092f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403860; x=1755008660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rHDHY5Frpa30yUJI9j+J2Wrb3XE2xgQFNG92SzrESsc=;
 b=E6Qw4BBacanNcs3GenzhzLjHF429iDDpTz9Mc3vsVKqM4OJ7TtcW5w7M+UedtUSYQr
 AQtVK9d5pVRRMSIvsaulDgF1O7DWLXPXBJ+DRnrk4wXgqmBxcwehX+xsduJu6DeEqLMu
 2jp1jQnD+u0hfZ5Tkxth2w7QnRD/AsI+MVPq0RfqExc9Ms8fjwtFl4c9cidMkVbrT2V9
 ZsBxLYp8BEAt0hjPT/HZcugpZuzllNsebEwh7abkls2S/sXCTnqt4EdV5DyunevAPyfG
 ik0LI72mIei/LExNZElBMPQ174bp52dZ976o6ALUtOm/C5HpWcgW9EfKnTd75IwCPHI7
 rSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403860; x=1755008660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHDHY5Frpa30yUJI9j+J2Wrb3XE2xgQFNG92SzrESsc=;
 b=SQ4NaQet0nHB90Ap8JK193bUa0jWu3w0kkoEieZNXuRXak9fvtC+2u0lee+yZQ7cYy
 PpR3ziHjVudcJxUqs/BqS67jLqNlMfq0mA/qZoa9lKF5USDZMCMqFccY7L7eyUJjnRNg
 Kzzqkslnj2alVTdL3OwGTroZiDXTNpaVohTGLCB6ALHOhxM+S34o5pJuza8Lj868lkU3
 GtfoSuwtWaErZ3o2nQrRx3PWcbEcl54PWVRImIcCfGox64SRdaxrP26lM2N/jfCZ/r1S
 icWz4CeeCpNiGbESx5KMxx0rclNVT6RAKZSbfsEuE+76M/HdEcrdodVzTocR1HlMNRgz
 cOlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx4596rPjb6W8stLfZARfpRLXeWtF5CL9aPcd151d2YslyUEDf72+QitMiICeGe3it49jNKIU/bJRs@nongnu.org
X-Gm-Message-State: AOJu0Ywvt1LuEabEJZ1SmNmBzF7YdZmSdvXWKi+rRDRw1p3wW5aet3iK
 gc2GCc7RcXj1hm+VaDSbPFuv558w3gmVGx12+mt52/ofcP8UbiZ3caSGrc274ulo6bk=
X-Gm-Gg: ASbGncvB6LZFOfDpiC89TIg/ZD8HCkbHl4qAI4DPnbgq/iJv/1PHmAnHd0hVaALNFOP
 0/YfSf8jL5q9efb0YkrBvKeRajU7k6koVUa5P34yWdanBPksVBrB5ZFdoZay6VHds2NIxKM7/ca
 Jf+OmzjfAurJfWRIuUtoA3i5pKlRWvCoEZy+eNHNX0aayRreFZRS4rhUw1PRvhD+B1HKj9FZRXl
 xnImI5xDVsej9+jXOUzvcqVL2z/s1qlh+60KovEqwKROrATwesoeOGXNQVCu/VZqieDsBe5OhVm
 wPKcCJVwVCZ6m1prHRpjyLoxsSMFYDyKN99+6EFclb1tMXj00uXJYCX7t0ihbRKcKK36CW+R5D+
 qcbaqglhvwA0kelDumS1Bc7uEpjIrfveco3Wo4qsCZZiu7W/OWc2b2UF/cXHCjonX0w==
X-Google-Smtp-Source: AGHT+IHMmeGETnxyXq8niRPUyRecTjy+nmBMTCoWdC8VHWkft37PVuzGf/HDQaoyRvvUuhzDJ7u8JQ==
X-Received: by 2002:a05:6000:200e:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3b8d94c4dcamr9133681f8f.41.1754403859839; 
 Tue, 05 Aug 2025 07:24:19 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47ca5fsm19079972f8f.63.2025.08.05.07.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 07:24:19 -0700 (PDT)
Message-ID: <25f098d4-c3c0-42d7-a12f-3a28d5efdeb5@linaro.org>
Date: Tue, 5 Aug 2025 16:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Document 'use-legacy-x86-rom' property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>
References: <20250805065543.120091-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250805065543.120091-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 5/8/25 08:55, Cédric Le Goater wrote:
> Commit 350785d41d8b ("ramfb: Add property to control if load the
> romfile") introduced the `use-legacy-x86-rom` property for the
> `vfio-pci-nohotplug` device. Add documentation for the property.
> 
> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


