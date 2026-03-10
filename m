Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FBDEB1061
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyPE-0005nj-Ij; Tue, 10 Mar 2026 10:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzyOm-0005jq-Sw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:49:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzyOh-00079i-9B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:49:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48534237460so30087975e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773154161; x=1773758961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aHCYeBgYPsG+p3Gb6u12/ky3ZMCMBcINLbOd5cfNEM4=;
 b=GjFLQPbu9tXOmGrKaaa6JKwzeVVTr6mn1J1rKAXIC/+NoeMQipx0A04Py2DncqdqrN
 A6cHatnSrQaG3t9vX/dHKbBeCY8TkBudJb4vNPe+PQ5jwW2Sz49ubkqFWed63EBZS0+v
 vRYlCt/iDgI/RFqLq+sBioRmtayKZylmXUgNNNYdKv6w8lgAoygbXZ3V/lBa2XmvEX3U
 wk0024a2Ch5Qitr/54oj6m1Gnj+GRItwE5KkdRO/QoWE87raapI+NQz6u0JYoRsTyvSR
 JU95tEtkoZKiupiXiET0kE5J2tC3q17YeE+MvNT7xRi2jvdTMJ5Kw55xAnYE0T3Kc9FK
 K+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154161; x=1773758961;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHCYeBgYPsG+p3Gb6u12/ky3ZMCMBcINLbOd5cfNEM4=;
 b=pcpZCQzZ52yQeBGCkwEKM1xiu+KWvgQSKx6EYeDKqilTPIzeViq5Q7HDOVRwWpWKWD
 klxl9XoJAKaCx2jT3FGdPXPhKlIqhdLOZPyFZ6NI9FvA1b7fDyzuXXNVgan6Kw4kYs2n
 /0Jib+4M0P3felK/YOVzo72TOTJ8Z5oso7HwhiuoyxoOCHJ3lCS3RMxIoP/SBa0WYUhb
 MB5tZC4IPT3n5KfGf78ts6q6aBUuJKBL2XHKqr03X3MBeaoxIeiQZ7IEjT20jpKCw426
 Zx52Q8aw1M8dWTVheWpey6SgPzfuuxTMfj/hu8MmgrX5Exk4X6ECmuX6YaWhU58lYi+z
 6SUg==
X-Gm-Message-State: AOJu0Yy7hG0RGXLKoU+QxF4A8/cZ+Fqmxgn0dey1hg3U0gwhnbF5tO7P
 LAUBOKXn711ZkyIAGZ9AhdaWL51DVIv23gLzWXrE+VgVBenVpeBmDzX0OhC3I9fDNHlRPZ/cSDO
 rtpOXCvU=
X-Gm-Gg: ATEYQzzwHZCCeAzEPSqfJuVCxlYWBbqt8HkiL8OcXPZmAJyOmhEBqt1NXq+jF08EkNF
 O9lzp6g8rvxRocdJpZe3dzMWorCmsJQ3OBjyBCIZSypwi03mB28TwOV6mZJUzDMQWm+UmDP7uJR
 1X+1AWjsLbYmKnFyTg4ku1wXYEp1pCaCe1G6WxiXZIfnjp2JxfI6uVJkAyvT4oZR0gfj4rdIu6f
 tx9B+HyV8QkHo9rbTF7B3HY9MXjEYGqOi13HJtFN/GtVmL2ksQ9dkCjBqo6FbsJbjK6lkoA94y4
 p2BcL8E14f4CFgU7MNjGq7/NeTXgn4hZy3OeCus/RYP3uUaBzjehqSr9GUAoHZmruNgpv1rh3mR
 OfJudDhRnzbF/gmNV7gNTpXjzxDNdWCDk2sLlOYCjwxVqjA051/VDW/yBsNsKP8obxJWNnxudZW
 BXqlUR1RqAbi9uCURcmXCQ4hGIgWi15tXLXA2gwKudCL4QK9l23wv4G+VAYiHxcBeX4A==
X-Received: by 2002:a05:600c:a111:b0:485:3b00:f92e with SMTP id
 5b1f17b1804b1-4853b00fb11mr107326825e9.2.1773154160893; 
 Tue, 10 Mar 2026 07:49:20 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a498afbsm136391345e9.0.2026.03.10.07.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 07:49:20 -0700 (PDT)
Message-ID: <392c007e-333b-4d09-a22c-f50f119eff0b@linaro.org>
Date: Tue, 10 Mar 2026 15:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Accelerators and TCG patches for 2026-03-10
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/3/26 11:44, Philippe Mathieu-Daudé wrote:
> The following changes since commit 31ee190665dd50054c39cef5ad740680aabda382:
> 
>    Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into staging (2026-03-09 17:19:26 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/accel-tcg-20260310
> 
> for you to fetch changes up to c574ff9245c7e9d10433efd60df2319ff4d69084:
> 
>    accel/qtest: Build once as common object (2026-03-10 11:36:21 +0100)
> 
> ----------------------------------------------------------------
> Accelerators and TCG patches queue
> 
> - Improve TCG extract and deposit
> - Build accelerator stub files once
> ----------------------------------------------------------------

v10.2
https://gitlab.com/qemu-project/qemu/-/jobs/12474666739
Total source files: 3817
Total build units: 6367

before this PR:
https://gitlab.com/qemu-project/qemu/-/jobs/13427222233
Total source files: 3866
Total build units: 5927

after this PR:
https://gitlab.com/qemu-project/qemu/-/jobs/13429265420
Total source files: 3869
Total build units: 5719

v10.2 -> v11.0 delta so far: 6367 - 5719 = 648

