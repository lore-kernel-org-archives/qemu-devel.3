Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C74C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrblk-0006f3-NT; Tue, 02 Apr 2024 06:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrblQ-0006YP-Aq
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:53:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrblO-0003Vl-JR
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:53:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4161d6b2582so1743545e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712055189; x=1712659989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4m8bzz7q3mJcqFrHAjo3WbDqJKoIcRhhjLii+tSZZ5c=;
 b=gbXI+oiaDMC04OFSkeYkYmRxFmVBCIfbng+8jqdEC8wleutL+l2ylhzI1in/W1zBnS
 //Ido8vaMd2uLHjFuxzNwgiLTO+IZqeVdBThhcj9EZEFxIBz0SwuZWuuowDqNnvyJZ6x
 fKn0TgwrWt6wmaysL8S/SPArKJlj6zJO2mzNFYK6XMx4eqdnC6+xgYThDfHjta3M/XfA
 UQ3U21Dlxe0oHvbcpT5hx/RKp5XaCZLWcwgn9XM8MU+CZFUZvWg4o+eJQ/DkDG5X7RrG
 vwFDfsbXncxyEvx5O/rqaup5B72dqo1GDkkYTmELwHWSVVa9ikOEx8EIMIH+n2FirqzA
 sqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712055189; x=1712659989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4m8bzz7q3mJcqFrHAjo3WbDqJKoIcRhhjLii+tSZZ5c=;
 b=UqUl93SlLk4bnU6tWAv7zMSuzDBHP3rKaJfqGw/sRAl9zP1xxgt6wfEPjhczh9H8qf
 GJCsy6SDhn5O7E5kONepWb5uBVPLjpvpE6Jxrvc0ap7822Dg8ZklMivVSoJRRteuNYMy
 CpKR5c0Jc+q4VPZxn6+x0r8uwMC4zHy1/63OCzUWa7xtZOrqTKZtcys74vQAZ48/MWMj
 VNGmOlgQnHL/+zGL0BU3Qv19BFS/Rv/s3gb66lMOjTB4+8ZRrf5024NH7Cp5Z5qxE+7z
 ATrOCQNPSvd0DthLde2GVtlnjc2Nx/9KIKZD1Y757I5kdEGOPhywlDr1DhNr772LhuNH
 MUbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrrorkN5/OEPVPRb92LPmao9bb2k0+VKewvRPMm+e06ACBFb296HOR8wsOXY2SkMVrMQxTLQ3dLf7JfAJsMFIDPV5Fi1s=
X-Gm-Message-State: AOJu0YzQw2MethQRxrV1Z8NG8uM0ee4TXguBvmgCVpaiNivSkZyd1aT/
 E/G0t2HiX8N9PKr2v1d/J/wahrEEZdT3gTyvV32Vx2Al1+f+IqSwQjChJMkX9fQye1JbX7NIjBi
 jdGQ=
X-Google-Smtp-Source: AGHT+IFfAJOysBM2bWqqrV2+HDpbyp9EJyaS23rXolMrUBEz6Kkmd/fU4uulM5s7hO2MYhIFIfZ2gA==
X-Received: by 2002:a05:600c:5111:b0:414:71b2:c915 with SMTP id
 o17-20020a05600c511100b0041471b2c915mr7825163wms.34.1712055188676; 
 Tue, 02 Apr 2024 03:53:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 ch9-20020a5d5d09000000b0033e7b433498sm13913420wrb.111.2024.04.02.03.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 03:53:08 -0700 (PDT)
Message-ID: <25f0de51-6010-4c5b-922e-6d7fe9427cf3@linaro.org>
Date: Tue, 2 Apr 2024 12:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unnecessary NULL check in bdrv_pad_request()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: f.ebner@proxmox.com, qemu-devel@nongnu.org
References: <20240327192750.204197-1-kwolf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327192750.204197-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 27/3/24 20:27, Kevin Wolf wrote:
> Coverity complains that the check introduced in commit 3f934817 suggests
> that qiov could be NULL and we dereference it before reaching the check.
> In fact, all of the callers pass a non-NULL pointer, so just remove the
> misleading check.
> 
> Resolves: Coverity CID 1542668
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Since I'm not seeing other block related patch for 9.0 and
I'm preparing a pull request, I'm queuing this one.

Regards,

Phil.


