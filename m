Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770EDC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYck0-0001fu-HH; Mon, 29 Jul 2024 22:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcjx-0001Sy-RO
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:37:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcjw-0001RF-CS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:37:29 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7094468d392so1319230a34.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722307047; x=1722911847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UkxhqVskosWYsmghIKrkGJHQueaGIU1S8W3rD0Y7lcI=;
 b=eH7lGUNRIH9i4ndM6gN6fShW0GLspfA5daSp+NA9gEMOs3fRAvF4GLwE/iYLO6yCyG
 /uO+omjXCn1lGXEkb2tv8v52D6fRUx0PwdvW5kM47w4yfrPvwo2qzg0lbtIrk6fwcDnw
 rXWgs7We6W7OYswU47GeZOY2gsKf3oCLU9kXMNXPHi3pep8yKhXIe9wLBxtHFO4LLnTu
 +0n7AasJVoxDGNjEJhY+o4mpS1NMK0kHiXv16yuZHjzgZV3d4O2eazs/cQPZTR4GPgLI
 vhJATlegJY6npQy7JXBeaFgUHq/iP1UGwn627Yq6NLum8zwIg+lkNWDwdj83UyWI1Slx
 fIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722307047; x=1722911847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkxhqVskosWYsmghIKrkGJHQueaGIU1S8W3rD0Y7lcI=;
 b=iP931Zhdya75pdRGgHhUquTpUOEzbMeQwxi7RYymaN1rxcCcvj1O+6CVw9fsUzDZ6h
 aKCuFsyi2rPM7GjNHeshPVQzr4zw/csaqLqttH8u53XPbHhklbC0SXU1Aqc+PSQx5mMP
 fRop3MyZGCS3eY9nyGCHNSAV5xEiLMpFxyFDNSPp6jIbQBRmN/XyLEpYiHJnyACL14SE
 SXZx5H8KCehdmlVLicq1E+36pB7uJjXRsZfKiQOpUemJqOsRE81+oFS24qw3P/YhbmMj
 t1ONVwwjhqDCl0SKc2GsjgnFn8QN3SmfBpEzWWxQ+BVbEUQHssy6xdgGTT3MRQI7w+jD
 UcJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy3WoZl0ODsNJdHFfyARoEkMHIcuh79pl1A5FAQ149nWzVuBhfV9kDSM+8bAyBzTb1IaFwOTYS11zEiOECqgsy5/59mOE=
X-Gm-Message-State: AOJu0YxDb30sg2fdjipeDZd+ZCPMNK+14nN3nKma7/+AspMXhEoUupgt
 LzY1APyH9YAbmBrc7OQhEkmWu+PTj6DAEflMyvBRXejnZW63IPbgYITfZTkXibD5mLYieRmZ8Du
 ECq4=
X-Google-Smtp-Source: AGHT+IFuUffXihTUovsSyGvtQMTw/b6TrRR/pawwwkUOH0Uab4iFpKDona0PBgpRChDcnhFs/7+vHg==
X-Received: by 2002:a17:903:234b:b0:1fd:d0c0:1a83 with SMTP id
 d9443c01a7336-1ff048e5bdbmr90588405ad.43.1722292194438; 
 Mon, 29 Jul 2024 15:29:54 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c7fd99sm88710665ad.47.2024.07.29.15.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:29:53 -0700 (PDT)
Message-ID: <6d88c335-2fa0-4eaf-9da5-e8546883a765@linaro.org>
Date: Tue, 30 Jul 2024 08:29:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] docs: split TCG plugin usage from devel section
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> The devel section is getting quite messy with the breakdown of the
> example plugins which should be usable by users. As we mention plugins
> in the emulation section along with semihosting move the overview
> there leaving the development section about the details of writing
> plugins.
> 
> While we are at make the headings nicer and convert the option lists
> into nicely formatted tables.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   docs/about/emulation.rst   | 567 ++++++++++++++++++++++++++++++++++++-
>   docs/devel/tcg-plugins.rst | 505 ---------------------------------
>   2 files changed, 564 insertions(+), 508 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

