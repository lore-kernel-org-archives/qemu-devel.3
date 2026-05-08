Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A10CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 08:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLGG0-00012v-JA; Fri, 08 May 2026 04:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLGFz-00012a-2W
 for qemu-devel@nongnu.org; Fri, 08 May 2026 04:08:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLGFx-0001MF-Gh
 for qemu-devel@nongnu.org; Fri, 08 May 2026 04:08:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso11455405e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778227700; x=1778832500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X/kZswwHU+ivgvmRcRQg6KuhXWBP80R3sgsXKw3CqSg=;
 b=wcJ6MCc6wvLQ5iUXh+G/QkBkhf+4evVU3j06/WwHOIj4q7+a4oq5RHZYAjgu1ZTJug
 cpDQ0/2CFpCFvGu7wxKEqYRljomVamX1K0dEYFaRoboQy0X7jmriq7OymexjAfkP3cU2
 m6OK6vHHhEFiY7ZMddmywXqpZyH0LFjz3/SW9KNRtwlqM2sYHG+vKMuAdsmBm7pdUXNH
 BNwWYadb2Tg6PwtQulo8fGizT9movBATAyXNIIlUzG3S8XO3sr9eRwI5j8CzNNj63ckU
 gOCee1o7ekcE7HyyWpu2hdpRp9whKN2PEICbX8rSlYrCRrnubQzmsVL2pxv0iB04NkL3
 zfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778227700; x=1778832500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/kZswwHU+ivgvmRcRQg6KuhXWBP80R3sgsXKw3CqSg=;
 b=hHR54tCWWlcIjEOuwmdpYrJR6LJqEoqD0hY9/f666KBMOLX3CwPb9hEW5l1oP9WcAQ
 xdmhejZqvypDuzcrN/fP4DuVdYXZZnXGpS0C3dKtjpC+6Prd1bs+pIRHFyz3SW3f3PIp
 uD/UlhDJjIq4LOq6k4YbJZbeMNmntkI//2/mOME/zhgifPcjk8i4lBDOUZoqVGkufEz6
 AY6q0hFbsmn31nc3vAqwrK1Yy7rLA7bUzHh17bc4SoJ1XwPqqCMA4v9zGb7F6xpM6XTb
 AAtcTmaWOaNFOUwkR7RtZLHmJZeS1M7U+bX+6TmCaEIredusK8S3b73//FxOJLm5H9iK
 aphw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CbiKfEhW7TKE/eupfQAAI/52+lCcwQ4UJ3KM/c/+Vm4qK3mPR8HF+x4FwOtUPFLfEaU9EAabX2sJ8@nongnu.org
X-Gm-Message-State: AOJu0YyrxxkRsSi4RMIG/YWxGa2QKX3iqd53wGMmdH8ZpoVQzqPNr3TL
 4zrf7DhAXTNHSTNCZ4EJ9nuYGf92CfMd5IzqHnOr7xPg5R7j5y1d9fxvS3Mo/uMZNAM=
X-Gm-Gg: AeBDieu15brFArT0hInaBNsAbBOL733Up+Mjtc0VGZ+TBFlcp4O9H5U3SGXs/KNyqIG
 1+wwfmqs9LwD9ZWHenoO2sr5td3d9NCzFXt7/i45zbv//nCMa38jXZgZIdaCBkyGK7kp8tQ/U2c
 hEDcWz2yq+rK2lZ6xbyKmzox/Mjs4qnMEXmzrcuGvMYcpqNyvv9foYvLPQ5ftNFei3z5kSZvqcW
 soE0v3q6j5UXqN4MkBjck7iqAloqRto0+s5S59qbrevkch41cR96aE9h5JnoqDDJc5fbv90y6cz
 zQ38Z29V1ZbJdWRCo1fGwfp4Ztdx6PRxKcrYBxLbONA2rwM0WAPrB8PChgpcKnR2vamU5Qk73Ip
 zjnpaokKJOJ0O3c0X/jvZfyf3YXevL1n3ELbnQoM8smVW4dGfnbPkuu9IhvLGuJMudvNxdxtxD7
 eqFZ76eugwFwXyzX7KGYnWZxGeXcJHmIRXKRnnYMkQBlCM73xNlblXpoiwfUJfOgqa7qmeRiTpG
 tU=
X-Received: by 2002:a05:600c:4686:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-48e676b6882mr24451405e9.26.1778227699458; 
 Fri, 08 May 2026 01:08:19 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120f1f9sm2389498f8f.24.2026.05.08.01.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 01:08:18 -0700 (PDT)
Message-ID: <461395ae-f90f-4914-a6eb-0e22f4cb10b0@linaro.org>
Date: Fri, 8 May 2026 10:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/remote/machine.c: Mark x-remote machine as OK for
 AArch64 and AArch32
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507194728.2034696-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/5/26 21:47, Peter Maydell wrote:
> When we updated Arm and AArch64 board types to mark them for the
> target_machine_typename() filter, we forgot about the "x-remote"
> machine type, which meant that it disappeared from the set of board
> types exposed on the qemu-system-arm and qemu-system-aarch64
> binaries.  We didn't notice this, because although we have a
> functional test for it, it requires the KVM accelerator and we don't
> run the functional tests on an AArch64 host in CI.
> 
> Mark the machine as being OK to expose in qemu-system-arm and
> qemu-system-aarch64, in the same way we do for the "none" machine
> type. This fixes a check-functional failure on aarch64 host, where
> it would otherwise fail with:
>     qemu-system-aarch64: unsupported machine type: "x-remote"
> 
> Cc: qemu-stable@nongnu.org
> Fixes: eb796c55513d9d39 ("hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I couldn't figure out which git commit started enforcing the
> filtering of machine types based on the TARGET_FOO_MACHINE
> interface markings, so I picked the Fixes: commit hash for when
> we added them to the "none" machine, on the basis that that's
> the point at which we logically ought to have also done x-remote.

Preliminary filtering commits:

28502121be7 ("system/vl: Filter machine list available for a particular 
target binary")
2c6fab1c143 ("hw/core: Filter machine list available for a particular 
target binary")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

