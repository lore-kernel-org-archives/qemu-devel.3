Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F79FCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 19:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAZCI-0008Sp-SQ; Sun, 19 Oct 2025 15:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAZCG-0008SR-Lq
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 15:36:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAZCF-0008Ek-0X
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 15:36:04 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-290d4d421f6so23344635ad.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760902561; x=1761507361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zM6+lsLBUdGbMiPHco8kQFAfVrSstdRshwS0Mcaq244=;
 b=qKkewrtY5ocLKku2+rC+rZWNJInd5nud1NixuHlmDGmSQOIOfJq8qrySt9FEpVPgOI
 t1p8enDCMRfoXoPio52nT/rYL201V0uwvje3YVmsnT/vWYn9nBXwYst0OkGFE87j+rGg
 c6+U7MguIitHYvqcf6CozJOlp7RUijiHiGz3utwGEZttrZNs20jy52krwaPMaGAzmpZj
 3InrixbKZ2yqF7rGMPvP6p0tnybsIrLocRzAO9FZYhoh/wtigajHYor73LNtSTq1UewF
 aXer93+zoGJnPOrxzOMaxVkASQn0JgTLkJxK6hFELaqZHRgDM26zdc1wTZvX1sdAS0Ya
 yR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760902561; x=1761507361;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zM6+lsLBUdGbMiPHco8kQFAfVrSstdRshwS0Mcaq244=;
 b=pqxIx3a8zzfEkmB4GO0orQ49xQNNCo4yAsLZO/pvoXE3yHtnCTq6NErooGa1zH6aKd
 i9BSnWRgyjWyoGmggLPsxze78wv7KoY5dPq10gFPhJ01yTibBcZeKYC0EKeZzYTddshW
 ZuIVDsymFwohNgYZUJWORxDV90TgL3J5/J+SgSE8GPOP22qqKXMjUF4ZtR/5p5Jv9OxX
 rLzDWu0pCBkMNbgyJ9Y+Q/BYUPh3gf3DKrVvqQKRQkT2tkY6C7Ao+jG34dXz1+/jwCfK
 MRfxhfpxf4Ae6qMtIlVaa0cC41z8G7gLhyRf9t5AZJ8px46/JPUQ8DctKMydwaDE2W9y
 2+/g==
X-Gm-Message-State: AOJu0YyXiNpIo1Tig4yOSpPSEUkLwWIJQmzQcb82tXXx59T6XiDIBaT9
 qAW+5NKP4L4tc736elJWV5QU6tzFDr2bPWDvi/8s7Ps/VO9Kx1pbjr9ahxEkDgm0nux7GjxvRM2
 +zNloh4w=
X-Gm-Gg: ASbGncs5ePhEH1mRhFNg+vAR/p/1+xzAx7DwMh9QQdsOv0rZC2MhNbGJot/yPA0WapZ
 Tx0cDhUEnEzwo3T8asaV5MLKkJBVAbb927XtiKG7Nb2r6cVFEa656zloZzud75tOcu7xyli3yQN
 KOAby/npCFi0OKcEx6tbygfrOGAvKxEwXeZPCU5L2HvCMpJBxglB5bji4Pe+bhQf++jU7HukR9W
 PTF4vC+0xMV6Wdt3Kg8EYdn3pjgUDNKsLKvXUyxAZ4tEJOfiMEkVifjMRVF/MqVu/Rf6VTOhnjw
 WF0JMSTMMvccu2MwQ1lPIXDC1resGxrC68A7sSHoD4i4U6FQ8Fcx6hCiUM3w1SE3Ik9w69J01Yw
 a6+Yc5+NWDQjEklesJVUumsgPPAGMbcGNvwq5RrPEQWPZQmBr+gTXbVF2wVyn9Q6AAVILBCdCt8
 VJnG1ElUMPisBZRtq9Bg6p5YBV
X-Google-Smtp-Source: AGHT+IHZwak8DT1tldwswSKQfJo0Lxc4Wp8jqeW6wHge+O/lteguGC/+wAjAv/YDRUewgLMeSWAB5w==
X-Received: by 2002:a17:903:3c24:b0:267:a942:788c with SMTP id
 d9443c01a7336-290c9c8c5e9mr126865665ad.1.1760902561417; 
 Sun, 19 Oct 2025 12:36:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d5c33sm59848825ad.73.2025.10.19.12.36.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 12:36:01 -0700 (PDT)
Message-ID: <7c1bdca0-9469-4241-9eba-d7e46995d399@linaro.org>
Date: Sun, 19 Oct 2025 12:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20251019182834.481541-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 10/19/25 11:28, Richard Henderson wrote:
> The following changes since commit 18f6f30b0089b470f3e737637a86dfb81ebd6eae:
> 
>    Merge tag 'pull-request-2025-10-16' ofhttps://gitlab.com/thuth/qemu into staging (2025-10-16 12:27:12 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20251019
> 
> for you to fetch changes up to 5c1ec5a1ee0958068a532ac1e06cc6cee0c75ba3:
> 
>    tcg/ppc: Remove support for 32-bit hosts (2025-10-19 11:24:34 -0700)
> 
> ----------------------------------------------------------------
> tcg: Remove support for 32-bit mips/ppc hosts


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

