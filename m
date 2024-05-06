Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99BBC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3v3Q-0003At-IS; Mon, 06 May 2024 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v3L-0002oI-Aj
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:54:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v3J-00077E-O0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:54:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ebso12201765e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989272; x=1715594072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0OcltWuGCNsBV8ToL0ISlYCII+KDrnOLMgxIJIBcpP0=;
 b=Bk0LzVgZbadkrkdEX9uHlV+apZFPp1eeTN5QWxwM77dC2/dg+AOcc3Ibum21irMwDc
 23rNvgt9Xcyj5b/7uIVwvej9NjLrQZ5wbF91ioCjTW9g+r/aatnOXLyCzCfevx36iGkL
 moUsa8y9dwX/QSmj8xiFUOpNmn14XzMPvUEKHfbM9OePFb4zCbIjlekTqsR2Q1j9ylYB
 bOOEsl/GX5UE05LVmbGue1vDQstvRcoeNiMvUUmVBzSAfXXuPRLr6WHSHXI+uZUOHwfe
 xwgCm6J5acnNiW7glV/vPYPJWHn2G9nnN+ri585imUJXiuA56E2xCGtXKyyQYxRq16eZ
 qhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989272; x=1715594072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OcltWuGCNsBV8ToL0ISlYCII+KDrnOLMgxIJIBcpP0=;
 b=gnkMjByb4uoSPPxNOAgi/uAP3oWh5X1Vq4WoHS9kvIh1fsrMsb7/TrbRGbj8qoJYyi
 JdNPr5D3y5VwC/wmvdJlvc7kH+CtGAOwixJncoyFib5QrDJoQnqGlIuR+CL/PrX2mx56
 ViPgjlHSZxBJik27d3JbnT8fc/AnMyDlliarnBycD2zgnqsotpI6hPzddqc3Obq02cda
 JI708xgdS7eUngj/vlSPkdsPJ3m54wwPsdZJ8EqiAcOoT6hZ3Ch7A/Wb+Ls5/MbZSmha
 M4+0cRZVGvluRy/MqFjjwA6FXJ7zjleGQQoHJwuE0zLeuWCT1v/XwENKSUqq5NGtDddn
 KCCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQpzTTZogqM0xU23zrAS92WnAHKHh7gWRFyplGb5fLVMoMBdOltaJQ90dZe3XjoI+l5XduvlIcUv1o/wmqgSg4RQ9dTDU=
X-Gm-Message-State: AOJu0Yz3IM+J+lLWby5Xh54EJvngPcvElOjfcUEyUKmtL8pawXVQONZa
 HNBCrhutKcdzRQaa4Qs4OA6NE4ot995kDtzbnAUdh7a07z3Aqvg+hpLMNFM/MilJWq4xppIpnjy
 B
X-Google-Smtp-Source: AGHT+IFylmkAkvUEoW5CaLT55WPTEepSZxq4J7hnQLGB3yYct+OA5rehhF3zB38+LrV0wF4/FHmvcw==
X-Received: by 2002:a05:600c:1546:b0:41b:4c6a:fa24 with SMTP id
 f6-20020a05600c154600b0041b4c6afa24mr7329339wmg.40.1714989272270; 
 Mon, 06 May 2024 02:54:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a05600c474f00b0041ea90d11edsm5565124wmo.31.2024.05.06.02.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:54:31 -0700 (PDT)
Message-ID: <28f9b937-454f-4a99-a362-5e50756e0e1b@linaro.org>
Date: Mon, 6 May 2024 11:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/17] xen: mapcache: Refactor xen_remap_bucket for
 multi-instance
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-6-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-6-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add MapCache argument to xen_remap_bucket in preparation
> to support multiple map caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


