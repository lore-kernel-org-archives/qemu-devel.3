Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBFC106ACD7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 17:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kCc-00012e-S4; Thu, 12 Mar 2026 13:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0kCb-00012S-5x
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:52:05 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0kCZ-0003xz-EE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:52:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-829a568f3ccso664407b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773337922; x=1773942722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=evQIVyJHtIR0KeUuDIOxxgjeidrn69n4aMRm81AmMPQ=;
 b=E522KuJb5lH/vr5aNxE1pP068A4acpp/xoGOf8V8tPp6pTRMMqgfSfykocEPrWQIEi
 vdOfBVInBAtNkkk+JnZxp0dY0/xalvQtUKfHj1znXTf7rK+MWbFZ+4abUQmCFH2zyOhX
 ZIU++Vr6uvI51z1bqZjt+h1K6y5woW2rxMvGiSNqOg1ayrOX03R61Cywh0vtsV+7DYgq
 BLGTqDVjLj+BuXrhuniST8oDtHqjUnwnBNmfjRS6Pvg527viKaK7Z2JR6cmD1ne5xfzk
 GZR5Bj0zOW6TLS0Qzf2Nzr/nX1vQ/44SDCo6+dc79SGuIs6RrPflzYEEziNkOwRofseb
 n1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773337922; x=1773942722;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evQIVyJHtIR0KeUuDIOxxgjeidrn69n4aMRm81AmMPQ=;
 b=ngGgVhls0Hf66yoDllhJXf6aH7QcCbXlAVsgYbXgN7fRLdQcaGCGONxTRjVM8s39z8
 KMzNAq9AAMFSvTw4W9RC+ire1ubxRd9Ji46CQcL4fHr3w0MKkl8raS0bO6oCQZ4jlX00
 AH6BUZaG8Ml2t3d1Ih4kAZdE4LgSdQ/ridAW819MEwofhEDeQs5Kl9KsUaOnURllghx9
 heFpEN0YtP84ztOwbKoqvMtdVU9mzvYXOr9k8KareFtOpjxCd8UmrsaN+aSVO4M5Ti/2
 uBcjGZKG8tAFER/z/rkth1icGl/CeU0xZdjikHnppJT8moUI4UUFLv5Ss9jvB9npORFx
 zRLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSqKaybhczlV+M8QvYV83jQK/nuwmp45mAVlywH1ugivajlS8VsK0REISbS4GanX+zx0mtfgu96ZVy@nongnu.org
X-Gm-Message-State: AOJu0Yw9SdNY3YmtFr+1ixEj3zadRH4SFWYSSjzfagFGcIjawixFDvZD
 D3+46sW+rqfj3OftVShP9XSobIoXTtN77NCNz7wLVj4UQBFBDPkBwa5i24YZHQHCcsg=
X-Gm-Gg: ATEYQzySmyTS2aYvWV35L5/0EJkAvyHxdKWmiUmvm0ADPVOtJiTcvVFER4FrAokYPSG
 9NZZckER0XKrbLzAUDEUai5+ZtufkAi2Hhzl1NDFaf02LgC2uVvCdOAuDkxbcI+uUbl8C+Yvvmm
 KRhZC2CUBDYZR/ki8aRf322ExJDKDkVF+bRINMQ5s8zLRWlPsAm7/W5zLqI2k4kNe4xwyT8Wqcw
 Xo7stL4RsPtPmT6AxxaFqDWoQggHHPCKFQc+ccj+XMVAXga9ljvVP0QnwoLneTd13LEzYpEACwR
 6pP5qDHhGe8+e02ZbhgI4zEHOEBwbWhuVz2gp+bNp6r2OiBWruqgtHTkIQal6ajLxm2du/ROVdS
 0kb+sg2MAd/p6DVN0i5n8m3n1HdedPqT+qxXvfhUGtM0CLdcxzh2IvniZHf3NxEdkex/e5if4bI
 or3T0qLefF8caLhv8390oi1yXIVp2oU28CFEuh5LxcjO2ZI37/ZDvgYI0CFiO7kmeTB9nbS+BCf
 Ap84Eo=
X-Received: by 2002:a05:6a00:b908:b0:829:8e51:505a with SMTP id
 d2e1a72fcca58-82a198fcbf7mr271830b3a.45.1773337921670; 
 Thu, 12 Mar 2026 10:52:01 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a072603c0sm3591479b3a.22.2026.03.12.10.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 10:52:00 -0700 (PDT)
Message-ID: <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
Date: Thu, 12 Mar 2026 10:51:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 6:10 AM, Warner Losh wrote:
> thunk.c is the same between linux-user and bsd-user (out of tree),
> so share it between the two.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> As part of upstream blitz bsd-user, I've discovered that bsd-user and
> linux-user have the same thunk.c file. Rather than copy it, put it into
> the common-user directory and share it. It has to be compiled
> per-target, unlike the rest of common-user, so modify linux-user and
> bsd-user to grab it from there.
> ---
>   bsd-user/meson.build                | 1 +
>   {linux-user => common-user}/thunk.c | 0
>   linux-user/meson.build              | 2 +-
>   3 files changed, 2 insertions(+), 1 deletion(-)
> 

Indeed, thunk.c seems to be highly target specific.
A good solution would be to move common functions to common-user/thunk.c 
and the rest in include/user/thunk.h. It may be cleaner than doing the 
meson hack. Or leave it duplicated for now, except if you plan on 
modifying it.

Regards,
Pierrick

