Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ABCC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8Ez-0001P8-AA; Tue, 23 Jul 2024 01:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW8Ey-0001KT-1o
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:39:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW8Ev-0004VO-Mk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:39:11 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso3214575ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721713148; x=1722317948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePXbvrz2owIZAgKwsC8DIPvxfFBnNSm7YOhYFFacvq8=;
 b=L8Oqn9g3R994iTa9eQtV+mH80tuz+tP0NQoJEgw6rszYPXknRHGM9MSZklf0JB6PD0
 Fyri2PuAxoQQz4Xc8tZm/4WsnOhrcaOGGqSn7gkijt6zuxrJa7TOPRtk+muCOrLzlQZr
 OfmTgDxwpTCW32p3zBIQ5mAGgqfFefC4h0MGR78cl0v7TCB0Bvumoc71OPdjTG8K2lhM
 bk3lE/IyRsKETmuY208RvgX1S/GpmxuVZyZp6+HMYsBZLA3iOdKNJkghR/oDoRJrodvJ
 fSi5UfWx/jNTeMfNh7ldjhcRsyj1Kr+WkRSCSXNHW8a7szG/dJiYEr7/AiPapa4XP0rc
 kFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721713148; x=1722317948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePXbvrz2owIZAgKwsC8DIPvxfFBnNSm7YOhYFFacvq8=;
 b=lDY00ddoaKDifx20/XO+1fFJl5U0FFEAOr/IkZfCZLfrLjvgg1MjamGO181aFTTtLy
 t8TWbVPRYgRfwB/fDqxAEPQkZcC4JIwu7C6Y5ZPy9ijzQ+Eicm31dUmDT0NtIcYc+7o6
 MqLGhwfqdE9oiNgYUr3Ihzokv4VUHNF0z9MpS99/8v8KoXd7Qmv4NgE48HUylfsk0kcq
 w2AikrrmBXKQ/T89Mr4yNPJCEmqBzwfMcsSNkgfIdc0FJlL3HE99dSaiMJUcTVu1eUqE
 3BLqtuBqvaKKa1yZ7zMqTn4Kz6ECqqBYzhp4JeG0VTdjmj20b+wAOMoXcucdUNtXhHjg
 ylnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl8wLj1Ao0Vt5Lt2nc07T60YDQvMLc1zITRWNnn6cUcRTFak2Oquma1Y46EY2JESTSNApoRvV+6o/5o1FyohgIKHAgZ8U=
X-Gm-Message-State: AOJu0YwDnYhLiV3hJcb/7PNwgB/S8SX568orvXcVUlmxSCCrZ6Jang6D
 rwntosuKBWR+aw74ELmvtdk6TD38FGnmTSYS+6vvqAaztjPLX+vcFGFrYsFiCk4=
X-Google-Smtp-Source: AGHT+IGYL5LCCSadpWI4Zztg6kYU/LY9Ntf26pF+mlNZpaE3sURBzV3fhO7nEqfCTZib7NRfTeSbTA==
X-Received: by 2002:a17:902:cec4:b0:1fb:247b:aa2a with SMTP id
 d9443c01a7336-1fdb5f971b6mr16114075ad.59.1721713147948; 
 Mon, 22 Jul 2024 22:39:07 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f28cf4bsm65098395ad.85.2024.07.22.22.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 22:39:07 -0700 (PDT)
Message-ID: <1509eff8-8969-47c4-ad02-c40b9fd0a3f2@linaro.org>
Date: Tue, 23 Jul 2024 15:39:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722214313.89503-15-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/23/24 07:43, Warner Losh wrote:
> Add the aarch64 bsd-user fragments needed to build the new aarch64 code.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   configs/targets/aarch64-bsd-user.mak | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 configs/targets/aarch64-bsd-user.mak

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

