Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86302C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKkY-0002Ow-Gf; Fri, 12 Apr 2024 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKkW-0002OD-GL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:31:40 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKkU-0003sY-SO
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:31:40 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d47a92cfefso13678521fa.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943097; x=1713547897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2UHKhcis8mr1GHky2pXIjsfAbajYvDaLBVxYdwbHyLw=;
 b=mmdOZFCbHYf96QMgxwIUQP3+DHNVtZkoqwgCKzJrVrhDpPj6UrSChFJ1YFsVHRSKvF
 bqTj7JTy05jaDBJAbpF/1uxHGI5IYRAZZ3nlcONf2dot7/v3/Xm5BZwA3FJ7gzfHgokN
 v0jUbolYDJL6W2CTjw1WDVkMBiyT2K5fTkPiYyQuPuFYEFZuqAc0j79CCIJipP8onE7s
 g4SK0ETpK2JuS6Lv/Z//O/tB604ga4P2UxqkndEgBGaAZh+W7Nl4BptBFolOCKs0Rw0k
 sfl7Au0o3aeeHvluTPUPEoyJIpcCEINUucWoc2E8jHpE81dNYsgrDQi2c04KE4W1X3Qf
 hSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943097; x=1713547897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UHKhcis8mr1GHky2pXIjsfAbajYvDaLBVxYdwbHyLw=;
 b=RR/ArfhHjekaOGwQoIJLTvzRIEuz1o+mvrmngGSqG0RG9q5iJho9fi1omXfB6mqO/u
 xbJ8NpkALM54ytJ+sFoVHpta120Q8cw367If2HfVfaUQqnSjoIRtXLKrErfcxRSQF3U3
 FzRWv+SQfzx3R96WIdBNnWWWKg4eGuoCgU/s02OSWsOzfGg/wt+nb/G5MqIJdlZ2CdQs
 wsKwg7WYGmBEdhvDVHmzv+L4eiG0JLtNlpGzCPrRybJTKdXt9I9qibwXQS4D/B3dExXL
 KfPMAQYh3gcUJMhLfzEP4ZN/VI3rwjm7HW3DmdMCkZWB51AIHlnxTsIcdWNJZ+lH2e5w
 F7NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcnWtJQHiIIBrZBOLX9kVc06X18ori6SSMopJKsp7clrEVZ6ZFBCk7S8yN1pHM3d0Ylfka7iKCyMIWpCgiRTzVd9/jY+Y=
X-Gm-Message-State: AOJu0YyUHy7aDb8qNx6gYOBPT/FwK3vUetgNWANi2XdGmc9bU+t4LIRV
 TMpbf2QR4xXrIunEAL7X5WOhiq52mN1cqoE+IqFSU43AbE/dlHH3ZvDfSZv8KkU=
X-Google-Smtp-Source: AGHT+IF0Hq2ZlIIsGrtseDce9kflj/uMIp3AAVORTKSKz7ZKdyOWvxLfkBZlf9mIGjAdYjlQH9KZyg==
X-Received: by 2002:a2e:7a1a:0:b0:2d8:34ad:7f4e with SMTP id
 v26-20020a2e7a1a000000b002d834ad7f4emr2023138ljc.4.1712943096747; 
 Fri, 12 Apr 2024 10:31:36 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 je7-20020a05600c1f8700b00416a43d60e6sm9471993wmb.39.2024.04.12.10.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:31:36 -0700 (PDT)
Message-ID: <ccf0dfcd-cc01-444c-a3e2-9543cb0f77d1@linaro.org>
Date: Fri, 12 Apr 2024 19:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] reset: Add RESET_TYPE_SNAPSHOT_LOAD
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412160809.1260625-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 12/4/24 18:08, Peter Maydell wrote:
> Some devices and machines need to handle the reset before a vmsave
> snapshot is loaded differently -- the main user is the handling of
> RNG seed information, which does not want to put a new RNG seed into
> a ROM blob when we are doing a snapshot load.
> 
> Currently this kind of reset handling is supported only for:
>   * TYPE_MACHINE reset methods, which take a ShutdownCause argument
>   * reset functions registered with qemu_register_reset_nosnapshotload
> 
> To allow a three-phase-reset device to also distinguish "snapshot
> load" reset from the normal kind, add a new ResetType
> RESET_TYPE_SNAPSHOT_LOAD. All our existing reset methods ignore
> the reset type, so we don't need to update any device code.
> 
> Add the enum type, and make qemu_devices_reset() use the
> right reset type for the ShutdownCause it is passed. This
> allows us to get rid of the device_reset_reason global we
> were using to implement qemu_register_reset_nosnapshotload().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/devel/reset.rst    | 17 ++++++++++++++---
>   include/hw/resettable.h |  1 +
>   hw/core/reset.c         | 15 ++++-----------
>   hw/core/resettable.c    |  4 ----
>   4 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


