Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD59D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 19:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdw4N-00078G-6Y; Thu, 08 Jan 2026 14:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdw3w-0006zz-Cm
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:52:56 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdw3u-0005Un-Sy
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:52:52 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34f0bc64a27so1870263a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767901968; x=1768506768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ZE0OYRa9Do3TupsGX3R8QSwtxkIeSFWvcwrSFql6U0=;
 b=ZyEF9dcpcznhCKZ8vybMb+7cVCiItplSOQd7qJt3PI63eskO4Mkpj8FJxhUfo2jtVd
 q5GwHeSvvOL+lHUFdZ3dFSCVUJBRnzkejiMukvij8KoDMKtoowtDg97abf1/SJJT2Uwv
 d9su/3mTzVyoTMruBOkqQcE8xVLnLdfCvSQYWSIjOeDw6Jg1PQbtgn7oB8Vb5MaYqb53
 DrmYBpx9SGSYdZX25fuMdj4YTCWIGZ86tmcDZYmOP6cEuGoK6bk8OiMit30ZqWANYajv
 sWpxfwKl+qgS5jt3Rldhf74doJnoEd1xkPFEXpJgqTh7AaYh9Ps+2xsmj5KFLQ0yUBUP
 QQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767901968; x=1768506768;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ZE0OYRa9Do3TupsGX3R8QSwtxkIeSFWvcwrSFql6U0=;
 b=l7cU0g9OzRiy89kPQTy5XZok5HkfdAQOr5kpkd7NhTGMdp5upnLMnCnCd71rRTNrim
 cJ5o71TTAQMu0p+kvd3XPh/TU3B4Ils4zCVxYkJu/ToGho20DV5F3VMmcP5WIDbD7f9T
 vMHM3khN4xkwuVd2avppxHctXjeRIqj3T84c3pn77ifa+pqVuLANRU5xd8EH06YMbFCm
 OdWrZsXuKL9d2fIVXN6NSeRUuAMCqQpQgTOdPXh68F2CDdBIKjVdXRmiMVpZknYnEtHs
 x//WeUI0/kE8Bi0lxAv5FKTU/RgiNqsY+xpPj9v2qCDIkwL9AujDKr4JS7HWG/srVtL1
 zALg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU2iaVTegOl8bWc6lS6/OLkeYUAMdpIkkxcmh7wXcf/8cIsuZ4b1sfBh5/d9L1gX2mbQnkrvd/WxV5@nongnu.org
X-Gm-Message-State: AOJu0YyRvYl/1277ifO8qbLhdfXL9hlG1urC25B5gvwa+Q9J715eCZS3
 mXiQbiapA3MNU/4SxsjXv2yORsmZEVIiCus2nXR4XcsAqmDPxRbE8jefGqILODxH6TlUsdzJR0J
 uAH16
X-Gm-Gg: AY/fxX48Wi+xJh5msS4NQjvAjNoflaoqVZJMLgPjL3DhsvAEVw3kyyfGVWNZT9JfCHh
 x3hdaeiz4RPf2mDDs/hfGEAZlag+b+R/o4gt26oXL7x25yoWYJSpbDWzRelBo+BiZVe91O6L0gl
 DDb6yGp8aFaiJZu/tr3gIJM8e2CKat6Df9OTn5nn8IvDHr+47L5oQIl/3bM7KrcHavpjcyrcAgt
 C+RqzlON2/qZBrosXjKmRqrk/MHcRSsYsDZJj7juVCXM6laEgI6PLRNMPZ6+NGcaKjeAwzHfhVe
 xzesUZAfWrNIRnflvwAgZaswy15JL0j4M8cQ7EBxpKeyz3pc24yZ12H2l3stOMOm7UBtaRXr3/Z
 Hf8e8Jcekon7fmZF0mHgO9mo82MtaCL3ly9a1xMTTcTN5XVrBUgBzhgKwiDz/KjCefysRPLpYcm
 ZTj0ukjDa/G3XYmakWBRhQRasHXIM/XUiiFzkd5ath20jctLUzEYqORwZv
X-Google-Smtp-Source: AGHT+IEC27IKT5jUiHhZvzImtmJPy9hM0lhOixH3qi7Yp7tvQWtBu3frVoNZg2ij/dcQ6yes9SB6qQ==
X-Received: by 2002:a17:90b:4f48:b0:349:2154:eede with SMTP id
 98e67ed59e1d1-34f68b661b0mr6724829a91.14.1767901968259; 
 Thu, 08 Jan 2026 11:52:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88e968sm8705349a91.9.2026.01.08.11.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 11:52:47 -0800 (PST)
Message-ID: <f2ecbe03-a172-4c48-aec4-0a1e4eb3be2d@linaro.org>
Date: Thu, 8 Jan 2026 11:52:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user: cleanup epoll_pwait ifdeff'ery
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260108174317.239955-1-mjt@tls.msk.ru>
 <20260108174317.239955-2-mjt@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108174317.239955-2-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/8/26 9:43 AM, Michael Tokarev wrote:
> All linux targets these days have epoll_pwait system call
> (while some miss epoll_wait, which is less generic).  And
> all linux targets definitely has one or another epoll_*wait*
> system call - so whole code block dealing with this system
> call should always be present.
> 
> Remove the now-unneeded ifdeff'ery.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 

Makes sense:

        epoll_wait()
               Linux 2.6, glibc 2.3.2.

        epoll_pwait()
               Linux 2.6.19, glibc 2.6.

Which has made this available for 9 years.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

