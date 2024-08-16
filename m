Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA64EC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 09:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1setAA-00024V-Fo; Fri, 16 Aug 2024 05:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1setA8-000236-GE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 05:22:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1setA6-0003zx-0K
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 05:22:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-429d2d7be1eso9025285e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723800140; x=1724404940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZ3Mtgyw151CnnO4/vDgQzyZ9/eU3xvWXQcwwBJWqsI=;
 b=nE6oKSoBiktxiEpVnabD8LkAeF+XNiwEBHme7CYVgTF/Rn0xu0j3P/u3/ZA4eLQXAP
 9E6ywm+NdWMMdIf7mbnNhfGgr2Wty+eY1dZu3aQXbqagyrtfJHnsf99Ih7ctdGzSOVCf
 MiFO1V3xhUYdSFCq+KxOAygU1GNzpA3eBypGLaBKWz+lMxIoveMAMHpEddzbNMi9A/j/
 IqUZTgyrvszIADF1AbSsc2zUocTbCpKjwUAuGpMrUu7APvWh3BW60fTWYJV+xKqXH+eJ
 WgpdXiR2N7zO6PZTiWoMohCM8U1Io51z3/UhvSyvdTUD9UO+Nr5WASL3rKZfuosUc9PW
 et0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723800140; x=1724404940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZ3Mtgyw151CnnO4/vDgQzyZ9/eU3xvWXQcwwBJWqsI=;
 b=XYvT/UxBAMXXF6Hrcc59IASYOrNxw1Cu6AfBXhPXQ9NHpeKb0N7ZAwz5T5ThFL0WjF
 V5/y/+9x5/kmts7lidbO55lhoWOU7OLAGyFmlfhuu1a6sOfEZm8XfGwBt+nUJxIsUmgV
 okEfq2O38imLq1Gp/sq3F8W7b4e+tb+Uq1vrkrWpiVeFzVZktmcstr8aPrTSN55qqvot
 B3zUwDtCULwdOgVAKDFGo+DM85CXNtnPsOAMZcW0JtWUSDUrhDtCiAgdzkwUmcfLFlpg
 CDpMtWz1uJ0+HXUh6poLZZfEcIeMIVGIiUxQjxok9a1jI3aD+yiS1GHGYh/4jBxDX0yU
 eGsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVTx7k8yZ0edeQAArGRcabWbHWTlMqf6+eXp3XgQBNbifcKEUnCUoM9I1YgYflfj9iLT8u1sdKbS0nbw9k9PMpsfSG/pM=
X-Gm-Message-State: AOJu0Yyk8urtx9svmaQ+FCnYRRcMT5Fzek/aT2uDzvI+5uWN4HklXLzF
 FdRoAFE5+AGR4CYkqwvjEE0zrd0O2JYT5t9n0sVp1Bchjp7A1cpgQIxpQncTUto=
X-Google-Smtp-Source: AGHT+IFmRTJNNt5V2DDevvR/HeG9UOwMgaXRGOMz5qysmAutZAAG8pALAGitqiFo4Vwu5kSXIqjq2g==
X-Received: by 2002:a05:600c:3b95:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-429ed9e8bf7mr16121735e9.4.1723800140095; 
 Fri, 16 Aug 2024 02:22:20 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded36f55sm71122995e9.26.2024.08.16.02.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 02:22:19 -0700 (PDT)
Message-ID: <a53e7ca7-620f-47f1-a9b0-66fe184dc8f8@linaro.org>
Date: Fri, 16 Aug 2024 11:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: Split out gen_prepare_val_nz
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240801075845.573075-1-richard.henderson@linaro.org>
 <20240801075845.573075-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801075845.573075-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/8/24 09:58, Richard Henderson wrote:
> Split out the TCG_COND_TSTEQ logic from gen_prepare_eflags_z,
> and use it for CC_OP_BMILG* as well.  Prepare for requiring
> both zero and non-zero senses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


