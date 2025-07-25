Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73046C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufP5H-0006Md-KU; Fri, 25 Jul 2025 16:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP2Q-0003e6-Pp
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:29:06 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP2O-0002dv-Rk
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:29:06 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-75bd436d970so1695713b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753475343; x=1754080143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2P0HRbkdKNAOgfqv+YMw5vlKODLIAvcqg9uh62GWBnM=;
 b=BmuXHLgNrLR36Amd4l+2UdMeztt2dz3beKozDNAQck4T4aCLjiLkwGpssIM2/86DAo
 NhyIjI0VP27dFwY2ApiF6C6nHnlc/HZBDr9Zj38JMCyPaUGYaRXOQ2iKViPezdswsoW3
 af+ADCD1hRp6Ml2u8pn1d7nhYnLhor8WAXjlQlV1MGZb9P3In3NgdupU2Wfo9Q+dsuRM
 gwjnY+iN8czc0roszLZKTu022RMuMoHj34DVujisKM5zLJyUZTR1Zqwyf5xLqaJUiy8m
 KsZQT01K+GVEMX4IR9zIKk0nlkA/XB/V5uNDdjRQe2IHTBdukovRNhsmkgBye++acZv0
 w33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753475343; x=1754080143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2P0HRbkdKNAOgfqv+YMw5vlKODLIAvcqg9uh62GWBnM=;
 b=w9r2/rkDTUGrnbPTHX3cxLb3iJyp7c3j86K26Yopl10GB1YexdaOQIuB7OYwUCnAL4
 goJzrsNlpHXkzMHte/HZb1RWZsjk2J/AshLKhUXdBRt+15OfSPtmls85nfFZ9gJnblrd
 W0SPGiVy0pkBsMqvdqz3+xIzCgLxrSpxrKo9HAdmGhIfSK3fYmOfaLLIv4i8JNWUH2HV
 JmOSBf9TVwELrOuQEG8E+YCp524ZTIwHXlu31cGsRzOOKW5td7zBJ4T4LguCXjEvouvv
 B8mG24/cBwmFSeBWcFvnu8sT3WUJWFLGtXTdAzJHVVp+WjEQsqJOYOLcxZO1vFObBS9P
 l+Vg==
X-Gm-Message-State: AOJu0YyD/D39EWCjuimBnEcCtbZuINH1JElbUWCZENAQebR718SmhjaV
 S4fZm7JzHcOgN7qTVPEPRyiRkBumDDDmOOMQ39mhA4BpR8lCDicBxEEKaNmkpuXSS927ftdsN3l
 JkTGE
X-Gm-Gg: ASbGnctMz8pU2geMJZ3M0gZfiTWSvs+7cSlZvvV8PLZvzFbT+WZRKyt85LDUGciqBfh
 exVX3YzN3gJQolUPruIlKamA2G4LxNIeJbHFmatSjvaeFMla4knGtWaCEJWt7bSC5jp+swg8bFr
 DlTkXDIAIv6Z9xLoL3446Nv/shvXWvKxZMtiXDd7y5E9g97sN0V1JOmGURcJnJrSfOnewQbt+Wt
 Ef3q2bPaGl4B7VkZZVp37Nt1dr84N/zuhG9UFLGxFAxrvYhx3zFYXlm6rRxCibecL8qUfLyk86u
 6LCUu63uulprYss7uXGdBXtAZTml/VJF13IlPWkJkkwtNEP+JVX08PqHhUMtDeQaz2s/vDkQFZX
 RDpDnEu+L3Ub4fwUV/kKSutzKNm1FYX1VQOWyO0rRHMthOr+WWsbK5y/XxBBgNVsxkdQl4KnIDo
 u5VQ==
X-Google-Smtp-Source: AGHT+IEQTu/Uu3faJNzvNxjVxEhUpI5B4UiROgrbV15Z0kwFFVTVrE1tWpCaGPcjeeWun7Po7CAyJg==
X-Received: by 2002:a05:6a00:84d:b0:749:14b5:921f with SMTP id
 d2e1a72fcca58-763347bca97mr5162747b3a.18.1753475343070; 
 Fri, 25 Jul 2025 13:29:03 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76408defab7sm393530b3a.55.2025.07.25.13.29.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:29:02 -0700 (PDT)
Message-ID: <58205963-fe36-41e2-a196-4a8a0fa96be1@linaro.org>
Date: Fri, 25 Jul 2025 10:29:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] migration/vfio: compile only once
To: qemu-devel@nongnu.org
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
 <20250725201729.17100-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725201729.17100-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/25/25 10:17, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/vfio-stub.c | 16 ++++++++++++++++
>   migration/vfio.c      | 14 --------------
>   migration/meson.build |  6 +++---
>   3 files changed, 19 insertions(+), 17 deletions(-)
>   create mode 100644 migration/vfio-stub.c
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


