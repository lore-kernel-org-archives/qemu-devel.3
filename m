Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18801C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saj5C-0000n6-Si; Sun, 04 Aug 2024 17:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saj5B-0000ma-Bz
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:48:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saj59-0004j8-DW
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:48:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd69e44596so35314975ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722808082; x=1723412882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XFI5vtmgOxVHEWEbSJx6bc4CIzbmwo3HRIJ/0zjQscw=;
 b=MRLGuBaLmt7BK/0ARnMdEy5jWlWoVcaunB7NhsELgVDlwSRenjriQePMDVztDEizzp
 nuAdErp6LjWMwLsRgReTjs+Wq29NKF3HNCKBGThFnTM1R5W2b/h5IBMJk3PwrrLtBKn9
 0d4TJmlgUnOSYQVpF6EnIdqf1JQRSes1HpZujlkZM7Cxw89NJEjFgOMf4GpYBonO4irT
 5+QsjxTrp+fj4/mrytHkgYwpd1Q0PR4Xe1xlTQN88E/YeDf1Bo6P84a/UTwwVZfVET6l
 1Jw5GoRWzy4Qvf8IMG7A4lFsi5SS/8rMpqZgO/PCCvkwKx/y7m80R8qM95138F+/fJfs
 DulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722808082; x=1723412882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XFI5vtmgOxVHEWEbSJx6bc4CIzbmwo3HRIJ/0zjQscw=;
 b=WcWxco/PU7/9oXT58DIVpUWTAvS9EhI9+13FLsNPF3A3axfST3XzHutqjPWchuTguf
 caGlBjeZl96VzHK60C+1tkl5JceBvpUejWMj8X3vF6rX7liCDMLz9IxdeFZAzNu9Scr2
 W2HUGm3V42Ng2ONBvoxACMZkbVaD1AcGy9V2m4XE+3pUgu/jAoMQhpL1q8HWLoIDhDPa
 GqWuRC1FeDQ7cdx05Ydl5vebGlBXN+GphfZUF3IXSHo8Y0u4HONXr7tadCgrBlW1CZDO
 uOrJc3nknNLealh2Gf5DyVq7Sqmwlgp4Jb4yjeCzOxZEsy8/u5822S4DJWB0QbuJtO+m
 7FlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyYtEdOdKnFG8jWbAsr931ij2vcDEDVRxsj2oecuf0O3NFYG6O1u/36PGjPNf7p9TB1b5LmurSgqGi9ZRLRl0QvbOepkE=
X-Gm-Message-State: AOJu0YyRoMDpdG5KOW1EeqL/tb2ZkS8AGIxYfHpIM9KYWpfOtjqw4Ebr
 yTPD9CFW0az4aMCFllMSV9FMMfxlPftJEOPe+4xFE3VXxyt+u62FzF3brZ1+QJs=
X-Google-Smtp-Source: AGHT+IEq8GbllRR3+5CGDmiSl/40UyXqP/Yt+YsZDVKKpuwIxYfhqFXNsoqm0RMVJHoAv3zi1Ivb6w==
X-Received: by 2002:a17:902:e5cd:b0:1ff:5135:131f with SMTP id
 d9443c01a7336-1ff57ea4b92mr161063895ad.25.1722808081794; 
 Sun, 04 Aug 2024 14:48:01 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff590608a7sm53752345ad.141.2024.08.04.14.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 14:48:01 -0700 (PDT)
Message-ID: <ba76ae2a-77a6-4d11-875f-f6bf77039109@linaro.org>
Date: Mon, 5 Aug 2024 07:47:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] bsd-user: copy linux-user target_mprotect impl
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-18-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-18-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Now that we're closer to the linux-user target_mprotect code, go ahead
> and grab the rest of the implementation. This moves from a stard, end
> impl to a start, last which will allow last page mapping, etc. This also
> moves to a more general algorithm. We're close enough that this jump
> isn't so large, and doing it incrementally further has become too
> much work for too little gain.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 138 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 90 insertions(+), 48 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

