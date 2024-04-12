Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4333CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKjO-00014U-Cu; Fri, 12 Apr 2024 13:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKjI-0000wI-KG
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:30:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKjG-0003ie-Ao
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:30:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so10138475ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943020; x=1713547820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vLEdd37VvutDh6DpI9c3F5p85A0tGE8nNWeO+GnMjHc=;
 b=aRFg/dts/tDdfdZywRr2csSKeb3uMT1mi9sp6ug4mQSRZQAwf0Fh5Uln/0asrwdOPm
 gqofZSv0+FdI2syfZnd37rizkDcsXJpjiYomCiMd7gqDDej7IXfYov2Zp8eVhXEhrVkN
 5PsOSpKiP0jljVBDSuJ/PYLnaqEYl//ehwrXcNgtgNE5Ym0sDdiA2tXyF5yqm5LfGPP/
 gvv1vKedTgincP7kWDb83miNsUvlsJ1QBi14pU2KBbrm5GB+YoU9gtsob11uhTZAytez
 dJiPxqc6XSZzi2nmeiePGqfnmiZyx9GpqkCeXkj/g/XNJ6U54shQ16Nq7xxtEhlGwDis
 JQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943020; x=1713547820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vLEdd37VvutDh6DpI9c3F5p85A0tGE8nNWeO+GnMjHc=;
 b=i6buLiJ89w86O5wgwwnhXY31VwV9y6Y71ikwpKVog1yD7cnKc5miKDT9CM/sMHSCg2
 KzRepOvqDQRGsdAsKy0K0UD601yEX9uBUmsMIR1a1wroVWbF7MzsygPvsC8WNJbmHmbU
 j41mRxJgRXeSUOTlpQqggiPPmHJ2Hy0fzvGJklO+K8Ttj68zBy++n3du/UAEFylSErkK
 Gzx0oxeEbn5oqF0G2/xcKA4u/6li1T9qw3SxzQMKA/U+r3iMBXxYiim/jM4PpUfP+ypf
 FeTVz3lbT5VmZkT9T7Amw+HU2S+Efj6W4PwhU02Nhs04YYwzVEMGSnk1u1sWVDYAeLLV
 yNvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+/4iZCSNR7BlziEDStpIXghk9wzcTp3iBu+kkHc3hq3WNQTFTuSmTmg21hRnMLxquEJYMnpskCOl6N+cIBG5jHXuvtec=
X-Gm-Message-State: AOJu0YwTgUKduz9oRbdvC69LB+JCztF6GihGMgFGXh0ZzwtwPRtTA4Gs
 bUCYMbJAnRH7zdPWbEm0TLQcIWoeOcxmQlU18/+qC4kCiH5PItTWYLufYEjUKb8=
X-Google-Smtp-Source: AGHT+IEWlCrlplhGJSSz+41wbVkPSPthbYJeLMgg9yywJMGgvLMXT0oQc5tLxOs5Tgcwq5QS0e79eg==
X-Received: by 2002:a17:902:e5c1:b0:1df:f681:3cd8 with SMTP id
 u1-20020a170902e5c100b001dff6813cd8mr3616698plf.12.1712943020487; 
 Fri, 12 Apr 2024 10:30:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kl3-20020a170903074300b001e2ad73b15bsm3238936plb.203.2024.04.12.10.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:30:20 -0700 (PDT)
Message-ID: <a70ebbc9-e414-4b45-b969-f66c41ac3b6e@linaro.org>
Date: Fri, 12 Apr 2024 10:30:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] reset: Add RESET_TYPE_SNAPSHOT_LOAD
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240412160809.1260625-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/12/24 09:08, Peter Maydell wrote:
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
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/devel/reset.rst    | 17 ++++++++++++++---
>   include/hw/resettable.h |  1 +
>   hw/core/reset.c         | 15 ++++-----------
>   hw/core/resettable.c    |  4 ----
>   4 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

