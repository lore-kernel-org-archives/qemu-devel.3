Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB15C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 23:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWPez-0003iD-5c; Sat, 03 Feb 2024 18:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWPex-0003i5-Sn
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 18:42:55 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWPew-0005Fc-G1
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 18:42:55 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dc6d8f19ab3so3156671276.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707003773; x=1707608573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zlPNtx2kjLEC+hQo74cEwsmQfREJ3FqIy930DbSoWd8=;
 b=y3ylzzmNoRtf77FdeOGWIsFm0Ow+Gl6bZ1eKIqKt37gQEkS3A4Dwf9wCvTnDTHLHHn
 XUEDZJlnA0CixlrrJRFDW2FhmKx+cHdji+O/UT79jswZN67tHOzNq6Z0dZXhVhcVywO9
 5E2w30nl6uQPBuAIBDK9OXGDxNL53pEkER990c3/x4ctOcol2I22sL8pi9Ew9l7GCPIu
 X/hrmVSGkMcf49UxOlpwwWUdYi493KfmbV7Z/wsazi/AN0u9GWoBqn7aSy8aS5Z5slFa
 L8qhdhuuKq/29Xrdkc2pz3l8MGTzVeVXFoRSQp6sCzuCLzrhQ1o2rf37lLckbvtZipbM
 o4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707003773; x=1707608573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlPNtx2kjLEC+hQo74cEwsmQfREJ3FqIy930DbSoWd8=;
 b=v4wVzlVDzf6eWm+Vt28BEba67+F+rGh8UPyFtBuS4VsxCjERzM3a2xWQQK1hyNM9bb
 ko/aJXl6dDfzNKW1oIAnCWJEZmWJ5bWVMlV4w9oHkSPmOkQLDdy85c4aTcJ3iSSmvcfL
 kH4ZUaxlzvPREZUQtDB9HJ5ZJzG2CwDLsrRU7MsMJvGucHwKIKRaA+AWZsFa73PXQHJO
 JxEbMJuT8qLWVsOJAaFjzLW8TZ32YuYKNxamYbacHsFPMwWXG5x0sgNKVBk6xiWzWCTh
 7T0Kr2rO/TMOUKbsxp11yYXmUvZIWLrpGVgjrclB4TIfr/6Tnbj8V3K6ta/zH2eD8sGC
 0jqQ==
X-Gm-Message-State: AOJu0Yx84Y+gkdtLROd3d1yM2gKgQt78NWBc5Amr9k3KqlCSaezd00H0
 JZNiTrRt4LFi4LDZJ7K5w73yLNr7xreuvbrAxwxfenKskPmfKfhK6G1kuSm1jxw=
X-Google-Smtp-Source: AGHT+IE7Te4gERwXvV3ZtliFIccYzQdXQSOMxWWK34H+Vb3IK/708fD/SUDm0NQJvdvDZ/XYbmCnFg==
X-Received: by 2002:a25:b116:0:b0:dc2:53ad:9a3f with SMTP id
 g22-20020a25b116000000b00dc253ad9a3fmr3723991ybj.27.1707003773157; 
 Sat, 03 Feb 2024 15:42:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUlZPDXIlQ3EsY5Q08FAh3AcXm5X6+EW/PDjqp+86yT29HrPoBKLQLHvFfvvdG6iTc/E1f3p7kf1tNwZgC+WwWwlVwbdiw=
Received: from [192.168.103.227] ([172.58.109.135])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a5b0708000000b00dc6d6dc9771sm1123483ybq.8.2024.02.03.15.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 15:42:52 -0800 (PST)
Message-ID: <b441f38a-6035-45b0-857b-c360545afc78@linaro.org>
Date: Sun, 4 Feb 2024 08:58:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/33] tests/tcg: Extend file in linux-madvise.c
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-26-richard.henderson@linaro.org>
 <nh6ly2ton626edkc3nwcthrighpa3lopsdcmpk6wq4dbwrq5s7@3vpizdp2fpne>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <nh6ly2ton626edkc3nwcthrighpa3lopsdcmpk6wq4dbwrq5s7@3vpizdp2fpne>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb35.google.com
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

On 1/30/24 23:13, Ilya Leoshkevich wrote:
> Is there a way to set the guest page size from
> the command line?

No.  Before this patch set, guest page size was a compile-time constant.  Afterward, it 
would be possible for any TARGET_PAGE_BITS_VARY target.

I refrained from adding such a command-line switch because, other than selecting the host 
page size, it only leads to breakage.  That doesn't seem helpful, even for developers.


r~

