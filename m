Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BC5CE7AFD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVsm-0007Lb-LU; Fri, 06 Sep 2024 06:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVsk-0007KR-AU
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:07:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVsi-0000vD-Po
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:07:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bbd16fca8so15816565e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725617275; x=1726222075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4hLhURe7hMu+xY3oYD9DJQCph9l0rVooUFMHoQ48oNU=;
 b=VA0U51KqMSNKppJBjinE8mL36R27K0GKd2zbhPfgZ9jZNwNZSGRD4BkHLDS7wRx1Db
 5li87Vty8NcwcOqLz+twnjc4D//QOO0I4hoedDpQFOOBKOEF94XngQ604kvMUDYBMDGE
 +vuBdMH0pcL/5vLPuF3+1CWS7RsTKqw8v9Dkq2ky+7d/I+tVRkM5SZW7FjQI8Cmnqker
 HIg8MoM0R/S0dawyuG6AANBheVZ0x9MTtJPvxB9GKmJoerS2c+QI4GKpnptu9+poRXsL
 7uoZlmgeuuhmYA5arlLvd9zNiz+zSOl8lOnwgA2wn7/5lM2epx6AAbgVw9k5uWveiFhP
 xOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617275; x=1726222075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4hLhURe7hMu+xY3oYD9DJQCph9l0rVooUFMHoQ48oNU=;
 b=McIcg4SrSC31ZHQj4BPLaXF1/pH0EoVjwdbkkFumSlFXQNHHimWfpAWyuZgTapvF/S
 Fgt5GDSJLYIpYGScLpF52o1u/uTL8/pH2brNJ0G+jkXO/NbUTBvHbnrWUqyD/mTVEQP0
 4i2bjQZJZQtg+JFvxpqEqkcQx+hGV/GI7RIgVFElMQDeceTSh1pC3VYIpFlLbTLC0keH
 coQMaUt//0MAeyIWXHMtAj0TrC0QOlNDWIfiHDBvQvyrIpOi6koMSQX2eBNNi3a0R9Fb
 9NK8kfZe0l0WJUcnc5rd96KqOblEMhKajhxqV59JV0ItmlmwZ0rMvF1fyDkRWDbbS5pY
 W7rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTq2snjL9wv4UQSjHZONlvtEEpNBFcCN5MbQ+f2OpbK4q/LJAoMXqK1crCYgHVXBPJJ7afW9MZzxFi@nongnu.org
X-Gm-Message-State: AOJu0Yy5diSex51i96O1FHhmI1HDjw89uxANYPwLRSKBeGxNZY9rHwke
 jpdMfkrmgvOLtMZ1QKRUI/U6w4Uy9jsqb0I0LNUB3Xgg5XiBpWpuZq3gxznn5Ho=
X-Google-Smtp-Source: AGHT+IF42dEGueS3D0PBWYprZlwdq8o0rlukCrTq+TIp7DZI9L6eVuSvH3lCH+WCCTsLRq3qHRyhGQ==
X-Received: by 2002:a05:600c:3516:b0:426:5269:983a with SMTP id
 5b1f17b1804b1-42c9f984be6mr14627895e9.8.1725617274777; 
 Fri, 06 Sep 2024 03:07:54 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05c6b1dsm15331325e9.1.2024.09.06.03.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 03:07:54 -0700 (PDT)
Message-ID: <d20ad8b3-3f6e-4458-bc5f-bef17385b4b3@linaro.org>
Date: Fri, 6 Sep 2024 12:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] ebpf: add formal error reporting to all APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240905181330.3657590-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905181330.3657590-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/9/24 20:13, Daniel P. Berrangé wrote:
> The eBPF code is currently reporting error messages through trace
> events. Trace events are fine for debugging, but they are not to be
> considered the primary error reporting mechanism, as their output
> is inaccessible to callers.
> 
> This adds an "Error **errp" parameter to all methods which have
> important error scenarios to report to the caller.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ebpf/ebpf_rss.c     | 59 ++++++++++++++++++++++++++++++++++++---------
>   ebpf/ebpf_rss.h     | 10 +++++---
>   hw/net/virtio-net.c |  7 +++---
>   3 files changed, 59 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


