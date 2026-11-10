Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F6606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QyPX6zcX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQozH-0004xt-9F; Tue, 10 Nov 2026 11:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQozF-0004xh-MF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:46:21 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQozB-0007tS-PA
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:46:19 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cdb628232d2so1342945a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794329175; x=1794933975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8bRyWwWxvGhrZONaUEFO8ago3UURNMvp9mABus39Zlw=;
 b=QyPX6zcX8BZ+/BnF5X3KcUyTFDirKo1bsKjU9SqfXuNGEFS9mBfA5+OrLzZmKoVcf1
 gyF+i+t/mY0Gl94k57ibBOvA+fMLXOT0slfDbJ2OjB7T8CIEfV+e+XVvLZKFR5gPTa3h
 2+WlCCOaibhP1vFvLuzPjmHVwS9UEuxKhI8Rf/iRf4SYC9Sz2/uyFZDq7QTz0Z8j+HD+
 CNhXR5GzIzLRCm/SBZ+rWy6UP1PMUSIs+MCLzwEAgfoEMB3fY/9W/EYAfY8x3ARhGrbp
 Ffx+fLMIHomdG65hGLqxnnYxLcdBgAO5dtOh816BU43O9BIJqtjMH/LqKagGTO7AckzD
 LDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794329175; x=1794933975;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8bRyWwWxvGhrZONaUEFO8ago3UURNMvp9mABus39Zlw=;
 b=i4pp/fDM7ns0ieGyjlwrEcbN3Go9XIWy6zZT3JWZd/0wcIX1Rc22VXt6qOksDCgVwD
 Wwl/pNcdUsQCoOXVKBfj5dIxZAxJxy/mvKZOsZf15Ypor+AwMTQSgTfeikTXMt02SwZ5
 HZXsUvzl1v1yFi80kInz8jtLec+sAc9vt/+emz1MCDSHSSuwO8ZbyzSVlZAPBGgW0yBR
 p/oWSLBGxBbmwbBnqO27rPaWRIeul59gaCyRpJOhDNv+6AV0m/DARwAbFNuPUo1bMOdK
 x63NJKgiuqBr93wJj8kXOtIQDBAZCOsyhulNwiTZdfg6dYYiRxjwJNNLmLPlePmC4oon
 YppQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEceFQTptgNCIJn187C9c/aeDzoekY2VAjcTslXwNfbDgKCJjQ5OjiV6lIh8v1S+4B08viJrSJCpTq6@nongnu.org
X-Gm-Message-State: APuU4Z+B6NUJNY8q44hei5fCh7aKMUi0U03FXc0g7pWR8/kDaMLeb/7B
 nx/XghrQTrFNiCkbQkrd62bu45kzyuvOdQ1dfdj/IbY1hJtP40YcvAsy3t4fmMwBdxw=
X-Gm-Gg: AYBFou0ilTW/dJPbShaESOw4AAft1YM+j5i4NIZYJbt2ONTALgmGhrol8H81gHuUVjk
 DQN4yo1X/gkDc4XBsl0bmOFezFKBZerW7svXPxogMimMwE8tgS+fwhA31E8phYxhdTtXTLgt4Wy
 nPIYHZbZsZAlPXr1qLXTMn+WjZB1mDxmqDIu/0OSvpc/62KC9ikypOA/XskMSRcGgIRWI7Wt56L
 q81VVXjU6YNronqFjy8VwHvIqKNh3ripxPYu1cA1WVLVtfQ4ge5kGHfX1oJsFGzWsLaBaNnQYGX
 jgJOoI8liotMw2OKDz/yPTHNZp8Uv2GEozqLyHO7ndSGrsTICN/xHPvBuOCrtMiYl9X6sfT1CMl
 Iz8YA2mqHnivOM1qof9Lq1vLSGl43vAavk27ZFVoAlXEcMOZQzjCzeRa5WHymeRLYKSGMTpK94G
 4xUEtmnDxRu4aexf603dSmioSg+mGXFUnEGTB++ijx0vz29Oc4gjMdYsoCa2L7qp6w/WSYzb5NK
 Igyc3a3s52LcMulxyS12xBJC+uVgjX31rI6ONqY6CVbYt5p5AiMt9+A4U5mhk3oqDgBV5FK3veS
 wZFmp0VCitqOU2oVFILUEHY2GYkl7pwzDqf7WBqlfve2VHbJLp1c1wK+w97B9Vci8rvuDiEs
X-Received: by 2002:a17:902:f606:b0:2e9:970c:2c2 with SMTP id
 d9443c01a7336-2edb9270796mr31507205ad.48.1794329174817; 
 Tue, 10 Nov 2026 08:46:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edbd6a375fsm9085015ad.62.2026.11.10.08.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 08:46:14 -0800 (PST)
Message-ID: <516e04d4-5028-4a8d-ae17-6e91715ce622@linaro.org>
Date: Tue, 10 Nov 2026 08:46:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 18:48, Brian Cain wrote:
> The following changes since commit 723622bedb0b423de7d1c61ebbe6e7a71934949c:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2026-11-09 11:58:07 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261109
> 
> for you to fetch changes up to a38ea91cad0fc31094cf0c8bfdc8943e024b3c88:
> 
>    hw/hexagon: fix FDT address and size cells (2026-11-09 18:45:32 -0800)
> 
> ----------------------------------------------------------------
> Hexagon: fix virt, mttcg, docs
> 
> Fixes for:
> * doc updates for 11.2
> * virt machine -bios, FDT
> * vmrte, guest BADVA
> * TLB locking

Applied, thanks.

r~

