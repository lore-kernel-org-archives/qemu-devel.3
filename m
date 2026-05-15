Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E17CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 06:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNm63-0001o8-L2; Fri, 15 May 2026 02:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNm61-0001nk-Hx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 02:32:29 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNm5z-0002KX-El
 for qemu-devel@nongnu.org; Fri, 15 May 2026 02:32:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d75312379so359263f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778826746; x=1779431546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mpudP/JImdBa6FQoMilQuuxzeGiIyiSp+wJwlbu2qgw=;
 b=zMe6WDHA1Ak29iaE3k1zEA0hgBxABtmTygwWtRR8SgCMPZ4qz3GxRYHHYxriac78Y3
 1TFEgdVWBVJPQVg7umidEIQQuRBh2fGe6uE0TSTNfHXOjFaIuHfm1S4GfPuxOI+oTr2k
 x8xr7pLPNTmOSbS3LJK6w9kd/BbgZO/piNRoO/a0jEXcQXQMF+U3+FD51RQnTZGOacxZ
 EfZul4ySNz/bYMF6ZwKxkewxvG+iFa6XxGPRMvS4Q7hefAOoHVBXSwrHHwuTT2xO9c3c
 /8sQ9RdU0Xx8fi5QwLSLDWMRrxNfhXni4G1P8XxT2UjwD1/6Bw1lnh5vN8mYEhGq1Q3V
 rjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778826746; x=1779431546;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mpudP/JImdBa6FQoMilQuuxzeGiIyiSp+wJwlbu2qgw=;
 b=Q29Y0mM3el/Gq3JBlQqFjbfSRmKLwyqio1YzS1aJLZYoy/WPUHAea+3Om02/aELGNy
 PRyJtecuvyEfb//VDttmCt5KQS8/QLZN4l4bRQT5aJ+zVNp30upQHpUz8YWX4T5yYTyT
 TspbxG8RdRxVWUVJmcBEB3jhU5wbzIwpjd4Bb3ZRp+2xQYS3sEgF4qF/+l8qlqn2d3li
 WoPBL/9onXGYOIH5QiVJpC/8MBgUFuBLFqYgskR8MkOthUYuv9Li88Nx8FGrxv+QQMjb
 9BmK9DbXWAWO2mwquYPfcdU9ddka1tgbZFMj+jz+SouxsyXDJVzcC+TAXGLgCFwBbbeg
 /vzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93Yz/nDsRc24XTwCI6JU9NfFyJRGOHtpWXGDCV3FDz0hQnmhcZ7pxNmHDYPHZIHRvcj0pK26y0pKJd@nongnu.org
X-Gm-Message-State: AOJu0YwwNkCzaeysjjyQI6KtE8aP+mei5NIeEQWZ2h6D0AGfmWgAjA/Q
 kBI4RiBj90SHmKKi5CpIrPUf1OLmMinHKA73WZCDx0ytH0K/wgds1Xugjuo+t1JU84A=
X-Gm-Gg: Acq92OEYWigxmo7Ule2i+7MM8yM3XzeoAJSpe9jUJuyLx0E9vHe3mxJzpoGpgHEJgTO
 dP5KfI97cqQCeYhvZPWfDAURthX78v8ctAXqo0CzIzYwre1w0NLRxVKw13bdC9tPPAPYy0l3YOR
 97Vb895xPRTmZfnz3mTeg0b80U6iWDgb1e1AGM2xFkUt6ZQ1t/CXakODq2kP7GtceU8HM026jFk
 tvhDFs+abBaJ2WEhxLb63N5BtJp4Q+baJxxrpCCeNaSjgpDVwKuFtl22QzljOtpiAueOXRUTpxF
 ALpyDkI77NXBr7gCGopA0kbfwAAmYfC1pH+EXy7j8MAqpbFPmZFDv5hmbBFVIaho0dGXXbywny+
 mq6di+7WjGuFstLbljik53RdBFfYiETDfF5QDlm6Obgbi6vPCFIrTMlBkMsCeet3qOZfFd1u2Cu
 qS6XZC4pCSDs2w4LyDc9516O1Z2G0cLpvhwtY/DUWvkvxNEc7nJRw3cUqbLm/BjRCWHg==
X-Received: by 2002:a5d:5f86:0:b0:451:b3ca:674f with SMTP id
 ffacd0b85a97d-45e5b739fcdmr3644028f8f.1.1778826745467; 
 Thu, 14 May 2026 23:32:25 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1aeafsm11742027f8f.23.2026.05.14.23.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 23:32:24 -0700 (PDT)
Message-ID: <1b400d4a-ec2b-4452-998c-d4b42ac41e39@linaro.org>
Date: Fri, 15 May 2026 08:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] target-info: introduce TargetInfo in QOM
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
 <20260514172303.1484273-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514172303.1484273-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 14/5/26 19:23, Pierrick Bouvier wrote:
> For the single-binary, we want to be able to retrieve at runtime the
> current target among the different ones available.
> A consequence is that we can't rely on existing target_info() definition
> since it will create a conflict once more than one target is available.
> 
> To solve this, we add TargetInfo in QOM, with this hierarchy.
> We define one class "target-info-X" per target, that inherits from
> abstract class "target-info". Using concrete vs abstract class ensure we
> can easily filter "target-info-X" from all QOM types.
> Associated TargetInfo is directly set through class initialization,
> without relying on any instance.
> 
> For user mode, we simply define target_info() like it was done
> previously. In this patch, we keep the same definition for system-mode
> also, and it will be replaced in next commits.
> 
> We will introduce detection of target from QOM, so we need to make sure
> those types are registered early.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c |  6 ++--
>   configs/targets/arm-softmmu.c     |  6 ++--
>   include/qemu/module.h             |  1 +
>   include/qemu/target-info-init.h   | 58 +++++++++++++++++++++++++++++++
>   include/qemu/target-info-qom.h    | 28 +++++++++++++++
>   system/vl.c                       |  2 ++
>   target-info-qom.c                 | 24 +++++++++++++
>   target-info-stub.c                |  6 ++--
>   tests/qtest/fuzz/fuzz.c           |  1 +
>   9 files changed, 120 insertions(+), 12 deletions(-)
>   create mode 100644 include/qemu/target-info-init.h
>   create mode 100644 include/qemu/target-info-qom.h


> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index d2355989616..de230d20e0f 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -172,6 +172,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>   
>       /* Initialize qgraph and modules */
>       qos_graph_init();
> +    module_call_init(MODULE_INIT_TARGET_INFO);
>       module_call_init(MODULE_INIT_FUZZ_TARGET);
>       module_call_init(MODULE_INIT_QOM);
>       module_call_init(MODULE_INIT_LIBQOS);

LGTM.


