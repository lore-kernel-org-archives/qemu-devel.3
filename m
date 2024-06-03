Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9020C27C52
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5ml-0001if-9j; Mon, 03 Jun 2024 07:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5mb-0001FE-8F
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:23:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5mX-0007w2-N3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:23:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4213b94b8b5so7881215e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717413793; x=1718018593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEkNG/85quEOAL2/nPTRwcDq1lHJhRKOY4Qqh7nZDPM=;
 b=AKN7cxXCSYv/v3xau2vR4SpgWUV9RnOfgMfEuhlt+VQmiCprQnSozuw477sID52JWH
 jjbNoQ0c6P0XO1IdOze3abH/y+W6C7O9QEskd04ijutRAHlUBTSp5wZvJU/O5wecxwXl
 fixe2K3xxg2hGJcMLq5Lj19TfqTT5ngR97R/Q8dRcbRBledYxFWgQbjAnoFfauvqsGPK
 xu5Y4hedreYNif3lv5hCk5JkMoSjU4L1z3BY3FXut8l1jTpOYWA/xVoEN21a7Y2FbLR+
 ECzrGIJ5fEf0e56darGOxcvP7xqvjUDFC7L642ABsSzDhzuDBXNO3Wo0yGvyKgOnACYn
 tuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413793; x=1718018593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rEkNG/85quEOAL2/nPTRwcDq1lHJhRKOY4Qqh7nZDPM=;
 b=Gur0BTvMAwVnfswrzHTgMQYMkGU7gi3Ee07tWtpYh+aAeEmsc7tRQw0Bq/NFUsNrRV
 cLOCds8UdQQvvOJNCK2Mohpv55eo7az3hdsEScWqJIZg1EY7GHGIijRhQ5LDj5VTLsas
 5MBuZDS9rfPZh5ug5Y7kKOQpFyG7SiNPuTV3VbNzhJKGMmnFVi2cPSHFOFrChj+QXeAo
 jCD/ANRgqAPYSjqZSfJmWnlp+32iHI+HjPU7/VCrJLuUB/iV7srJrXxMDQjOcz+MwPEe
 6ujGSGUG4BGleK6AYfvkhJ/e56c8dh6AL1efC8oHzjmwtLyR465rj+0IMr6X6BHZHNT9
 x0Jg==
X-Gm-Message-State: AOJu0YwXhPx0Ss4d3PyUPjKDrWcqcCjm0SImvGAO0bxp5zp+TTo/xWQB
 D+COuuLO0GyfPIXa/lZH+PYosixEjVc7CFR0jlJErFrEYXGDRPVmxBJo8XigMeaLpSI1azCTA7+
 D
X-Google-Smtp-Source: AGHT+IFRT+RwyeQ6FhJ4aFsZWlq00ApHopGB4ExOz0VgPzNxW1VSLPGb0AAB5dautmkauLJ3QngaBw==
X-Received: by 2002:a05:600c:1554:b0:421:35d5:39bb with SMTP id
 5b1f17b1804b1-42135d53c88mr40202595e9.40.1717413793373; 
 Mon, 03 Jun 2024 04:23:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d469sm113930745e9.9.2024.06.03.04.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:23:12 -0700 (PDT)
Message-ID: <02ffad89-1f0a-4e75-9d4e-9e38b799bbf7@linaro.org>
Date: Mon, 3 Jun 2024 13:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Remove deprecated 'blacklist' argument / config key
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20240530070413.19181-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530070413.19181-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/5/24 09:04, Philippe Mathieu-Daudé wrote:
> The 'blacklist' argument / config key are deprecated since commi

Typo "commit".

> 582a098e6c ("qga: Replace 'blacklist' command line and config file
> options by 'block-rpcs'"), time to remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       | 18 ------------------
>   docs/about/removed-features.rst | 18 ++++++++++++++++++
>   qga/main.c                      |  6 ------
>   3 files changed, 18 insertions(+), 24 deletions(-)


