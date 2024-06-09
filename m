Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E8DC27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 20:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGOtu-0001qR-Eb; Sun, 09 Jun 2024 16:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sGOts-0001pX-Ep
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 16:12:24 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sGOtq-0002IC-Kp
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 16:12:24 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-375858224adso9430265ab.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717963941; x=1718568741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZH2bbJQZx62FH+yi6CbFN3goot65ukkR8CGW+LAHUBA=;
 b=abj0emHZQ9MMv937OdPdeidsaw4TU2ejCEn73ZnyuZpBS7gEXlnuPt8QJeK3PRgXJE
 cKMlisIOhDzIy2l/6da6Zw3yOoMBRCOJQVGcaXVPCNiyQjSaE4Kwp5jeQyk4If5C+bPj
 3sHHL7utFlJsrJhEMhWdVz071Dv3mwcenYsXMcHBEcdI3qvnvpu7MIfy4efSDRcL6kc2
 ZppwcLcii0nKv2GCQwpB73Fm9LgrN4evfgwN0Qrbo+LUoB52ciCpNQRPYEY40iDrHm/M
 dZUk9SNTkARqznnrUwMV4k1Fj6puQ6skwWvQJdgvr8IX3j6AqltyK412JY6x70zb36JS
 E2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717963941; x=1718568741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH2bbJQZx62FH+yi6CbFN3goot65ukkR8CGW+LAHUBA=;
 b=CJZHrGPdsvdI44/XafOOvTligF4ADhSP196wP9QIqTvhfm0Jnb7+v6wfQnolFulpyI
 tlWkMwsPG+xbSYAMTdV22Z6aIcwNLGLB+HMyk40UCGLSGJuPDvaOsI9P9sazkzhkb2vP
 wuPxijZzQDh81AKh9KE/ThtH2kHtpRMCEysBHxLKIQNPkcJC7OU7fJvuS+RDMjl8rZJX
 LLSyImB8eQ2AXCoQjpY+cxldE3jUIWsi9+6U4OI6IlQZdmuSXL1PerHY5QinzCMsf9MQ
 YMeiBKbu0Iv2vcb4WxPvxLX1/5pOSGW+ZhUoyHQ3oo/NR1P22+PYb17Ln3IbY41iaSHE
 cOtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1XKj+qMuenRsKzMBl1SICa/PrF49QVFPkcqMI+O6RpRGjsAlZL3ssckX8VUAQ08un6FXeLXvOnNi/Bl/Nk8tuVBGGOpE=
X-Gm-Message-State: AOJu0YybELCVYRBhWJ2Mh4M9Ic0njmelVlR6mj9nny8Rs/F4tPDN3lVh
 4Lps66ebIVKWLJhd2j0/vcWPQ7TBOOs87/kYzJlLCcWoPZGdaPDi6z1XlxYRMG8=
X-Google-Smtp-Source: AGHT+IHpOiwbE9+b5UYOwSwoWx1L2Viu8UeenSnsd4iEEARq+qgl8ihca0Lob2MmB13SM6T9caz1kg==
X-Received: by 2002:a05:6e02:20cd:b0:374:aa48:1a86 with SMTP id
 e9e14a558f8ab-3758030d55bmr100674415ab.13.1717963940857; 
 Sun, 09 Jun 2024 13:12:20 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70597e58921sm370049b3a.115.2024.06.09.13.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 13:12:20 -0700 (PDT)
Message-ID: <4ef90c2e-6542-4f1e-9810-ba05d547e96d@linaro.org>
Date: Sun, 9 Jun 2024 13:12:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Bsd user misc 2024q2 patches
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>
References: <20240609165557.52555-1-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240609165557.52555-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

On 6/9/24 09:55, Warner Losh wrote:
> The following changes since commit 3e246da2c3f85298b52f8a1154b832acf36aa656:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-06-08 07:40:08 -0700)
> 
> are available in the Git repository at:
> 
>    git@gitlab.com:bsdimp/qemu.git  tags/bsd-user-misc-2024q2-pull-request
> 
> for you to fetch changes up to cb4c259052cbc5dd04c17d963c789360cb8fe340:
> 
>    bsd-user: Catch up to run-time reserved_va math (2024-06-09 10:30:25 -0600)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


