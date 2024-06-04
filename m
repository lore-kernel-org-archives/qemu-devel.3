Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12094C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIrr-00079w-T0; Mon, 03 Jun 2024 21:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEIrq-00079g-1w
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:21:38 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEIro-0008PC-2h
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:21:37 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-794c3946468so33642085a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 18:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717464095; x=1718068895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQQBFIzIenDt2/y6ftE2HjpbeCgVm5xWytGgrzPYWVo=;
 b=I70rh61YQI9fG70Tuv2BkQbEi+VWcJmNBhwLwd4KhSswNrAeZmT6o37uFfXHm9WTOR
 PdyrNRXhXrLQOgfTI5ZQZvrjVJmyr76rwZvSzPjmEWF8oPc5IANF2mBzEGYY2EwodgQE
 ZokMzbWzetno5Q315hFjrGjTaQLyeg8M3Ueow13Vaufjsq3aaofr5PB/0aZhEf4US7iK
 NLo8rImR3NJjMBOxD7WXvRVIV+e8EJIZF1a9xyYRrtpo4y+uMKMOSnFfVAqxzfuu+KTu
 3zfo/+EeOa+8+bVHjAW9jOOE2zRc1pjhiB/a+Xbp5mepfLvQS9JHGtlXyoHFddIumvhg
 bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717464095; x=1718068895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GQQBFIzIenDt2/y6ftE2HjpbeCgVm5xWytGgrzPYWVo=;
 b=FuGhKpIIBBN+Lb3vo92D0Q4CQnVdxALm+fXYzVaV2r883PR8ggOs4QKobw80/2pryE
 V7DA2VRCHfLUsPnoIHR9b8jRm5wsqxIPLBZMVCcXBO1CLqdfxW2TvhiCxjLzWTCzKbjY
 6pbF2fugrDMlC6nH7pIjn1ouWaY70P84QFwm0UfXhNQTvfe6D8C96UFF/umIXVCIO7E2
 o647A6/MjllJIHv6IlJHElTLrog9S8MTnoQ3b5hYaLHYlyS77g3SbG7SiGhYlMVC8hyC
 Wno9UmHuJvVFAJ+q1ebWzmS971GwYCHUOFmKSvTjuOdHaDmZXoXHuEkQgaX7jTpPxw1m
 xmNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX86WilJ1ez10OsrHvZevw018WBWlEkCRVnkfqMpI2a4OCDatP2sjCncdlwgaLXWNrlHQhPBgja3cPc/QprBWCXXvnMZJc=
X-Gm-Message-State: AOJu0YzHCfK5wquATbdkvEOtj4uJVJWOEk8WEsmjgzkrxnGL+ngJtBe2
 Wr2pYpBfKRL2EqsJnpAB8YERAZWXoMLgBVpk4bTCzVUuFGdPvY1v5lBWL9KXLsk=
X-Google-Smtp-Source: AGHT+IHdHvsgCJ0xeO2NQI21SlbBr7ycLs+iMVtZCmY76nR+MBru9+NOOI+AaiuhXd1+GsS6Z8maOA==
X-Received: by 2002:a37:e30c:0:b0:794:8a7f:f89d with SMTP id
 af79cd13be357-794f5ec1ce6mr1110600385a.53.1717464094697; 
 Mon, 03 Jun 2024 18:21:34 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4401ec682d4sm1659791cf.71.2024.06.03.18.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 18:21:34 -0700 (PDT)
Message-ID: <84bd86f6-82e8-4851-9ebf-b83126645951@linaro.org>
Date: Mon, 3 Jun 2024 20:21:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/2] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
References: <cover.1717403572.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1717403572.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 03:37, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit 74abb45dac6979e7ff76172b7f0a24e869405184:
> 
>    Merge tag 'pull-target-arm-20240531' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-05-31 11:10:10 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git  tags/pull-ufs-20240603
> 
> for you to fetch changes up to 5c079578d2e46df626d13eeb629c7d761a5c4e44:
> 
>    hw/ufs: Add support MCQ of UFSHCI 4.0 (2024-06-03 16:20:42 +0900)
> 
> ----------------------------------------------------------------
> hw/ufs patches
> - Add support MCQ of UFSHCI 4.0

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


