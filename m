Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247D4EB596A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3YD-0006BU-JF; Wed, 11 Feb 2026 01:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vq3YB-0006BI-TA
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:18:11 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vq3YA-0000Tx-0L
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:18:11 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82310b74496so3287526b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 22:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770790688; x=1771395488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b87t3ueJwz9GkBiLXaIG8w+XMv22nfpygxfcbll84wU=;
 b=A0pm8EwxW72cnbB1G581IK32UxtaHx2n6V0/6arBQr7fmi/w1PpG/RTZcpjjN2nKsh
 fherlhWKc3rxI1IEqWG20SldXszZMidG8E+NvEtO6mr5ghM1iuqUIySTzA/XU2JEZm9+
 3MjTudF+bRNMIIew2VoT/ruHiJYPGkb9mpDcO+FAsPrEFGag53Ucj9rRFFavIhz1Bd1M
 czktgzEFVc9kyBmoM6vvIWz+uL1y9P4FQCzKbRUfIx8b8QyU3JyKYexSCek391Gokk6B
 hO1nYUbufm4nuyiHp+/AOmTr2uH/0gtNWYKr/Ypi31NdL90zI+zFshfqqpxDGlkvS3O4
 JYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770790688; x=1771395488;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b87t3ueJwz9GkBiLXaIG8w+XMv22nfpygxfcbll84wU=;
 b=L7VRqXJglxYzLhYVrKqyOx5a+TzZLILYe0YFisfLDQuL/VwH42Ab0bj/wd9vV9MyiI
 jNYCT9NLnlwMQa5ozFXKtgWpzhynnjp3ZHq1eT8gQ4+1tKNsNN/QIWIfXC0pqqe35unc
 etTJ/Jv8/4eQW+kop34rDRX8Spb4xkSAnJ19RCAUJ9QuUUZINSKlvBJlTMdbg7NeJxP8
 S/zZQe4M27vEpBpiQh9Fg+YHuQU9lD9YiFTolYVknc7G0GZ875OTvmF4ioCQsCNT7fL4
 v0HJ/urekqXJVhY/RiMK6jYLyUCgxyioecWZiW9xV+TdgYG/hXrJc1e/o5OXg2zk2Xfu
 Kc1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxSdQocuDtAEfjqrGOzMzVJTF5zMaNGxMS6iOmLAhaSjrsHgIG3gfb8EW4L3k3/X9IJGqtWSU5n6cu@nongnu.org
X-Gm-Message-State: AOJu0YwWBQBuzMguM1H6Smnpsta0+YALCBU+wG1Svuf6xLO3X9TENJkh
 3YliNFNLYgxG3NQY5X/KxAMAH0VRgFvPdd5pOToAwSg36xLR/tpaSAtGuKdlbDM1luKAFmx9yHE
 6OIza
X-Gm-Gg: AZuq6aImBec7I5gHPMyVW1PrFMos3rlqPu9lvLZ/Z/agmuaxBSTXy+v7JbpjkbsBgnN
 ClmoPb35jUekXjm1uligYLDdtklwtrtOKxqngJ3DjGaO2zVSYXXeNaINoqbd0XyY/tAy2UZlGhQ
 Fyxb/E0GW4RtBK00cKJTPUCJE4+6WUznCGu/XTgBXaDSPnSEK7+wC9fxHKRU6PUK6OKmGimvaWB
 Caz6Syxc4BDJNsKu7KhzPexADi+XewPrA5tHuj9DBPnJJPUm1bjWnYbyGy1MVajkaNLlYfyF0Vy
 IhAUuphZ1wPryk0QiybC/XcKjj2ViofX+prh4iqFAz7PeNqsRYdUlNLXc21ysM6UyzOhksziz3c
 2rOU4o6uKQX3DWwOd40ggN9uGg9Z4nBl4NwBnJmqvNJrQLqnl0e6lxP6mb3v87H9XHtlRZizTO2
 Nsi3JNAXnfjnU6kykvVIJtc3+ga6O1sXCryx7LE0L6bg3txiWVmaSAlKmqIU34IQDhdPP/X+OeR
 MfV95+Xp8dXYdWheew7SLMX
X-Received: by 2002:a05:6a00:390c:b0:7e8:4398:b36c with SMTP id
 d2e1a72fcca58-82487b039e5mr4182782b3a.63.1770790687532; 
 Tue, 10 Feb 2026 22:18:07 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e3af080sm926486b3a.15.2026.02.10.22.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 22:18:06 -0800 (PST)
Message-ID: <f195c112-4064-4798-b48c-04751fcea01d@linaro.org>
Date: Wed, 11 Feb 2026 16:18:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] bsd-user: Remove netbsd and open support
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/11/26 01:46, Warner Losh wrote:
> bsd-user switched to supporting a single BSD compiled in 2022. We've
> only built on FreeBSD since 2021. The NetBSD and OpenBSD support in
> bsd-user, even when a hacked meson was used, hasn't compiled in years
> due to bitrot (the last time I tried it was early 2023, and it failed
> then due to easily correctable reasons).
> 
> In 2018 I tried to connect with the NetBSD efforts to get bsd-user
> working there, but they didn't get beyond a few emails. I contacated the
> OpenBSD people and they said at that time they'd not used user-mode in
> years. I'd kept the code in the tree on the off chance it would allow
> this work to continue, but there's been nothing contributed to either
> bsd-user/netbsd or bsd-user/openbsd since the initial import in 2008,
> apart from the work I did with FreeBSD to separate the BSD-specific
> requirements out in 2021. What's there now is so badly bitrotted it
> would take a very large effort to make it work.
> 
> It's time to give up, at least with the current code. This series
> deletes the netbsd and openbsd code in bsd-user. I do plan on still
> trying to keep the bsd split, with some common code for the 4.4BSD
> interfaces that are still around (not many: most system calls have
> evolved independently since the late 90s). And I do remain open to
> working with people to make netbsd and/or openbsd support in
> bsd-user. As it stands now, there's code I'd like to merge from
> the qemu-bsd-user fork that this code is in the way of.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Changes in v2:
> - Drop build changes from this series
> - Link to v1: https://lore.kernel.org/qemu-devel/20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

