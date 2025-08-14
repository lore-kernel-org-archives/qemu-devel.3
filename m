Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87DCA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 06:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umQzY-0006NI-6t; Thu, 14 Aug 2025 01:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umQzW-0006My-SU
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 01:59:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umQzU-0002rZ-ML
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 01:59:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b00f187so2268885e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755151145; x=1755755945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2JjKCTC9K1kiDGuNKFBG4RIwkb/S6tmEvKvIzD3PpbI=;
 b=x7yrA/5B5kDXRfmyYXZemvFoUFHY6wzf5UX9VjPTSHseLs2Yr6fHr33Vf42GiDedEq
 aLVhDJTvr1/7m8O609V5d/2Z4p0HOuEKaiv/Tp8zPFelVUUperHZkopcgBY2Wgsi76BI
 cNhtsqaAyRf/qvo0KUrUzVor29yrCxWe2bkw1T1l+SZ6GHd/FtJt6ne6HE8bGVjpC/Mx
 TDUHWEmueAlnzPmQ1bDPV6UTiZJmXawYMKuqr12MfbZcY2QK1pe3eYlX6R1O7UxFQTwg
 ZK4CiE2WnrerU8WFxyxAuOEcn1NUjaJUBK2aK2DX5ve5zJ9NctM34TX1KQGhog2NztvG
 QLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755151145; x=1755755945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2JjKCTC9K1kiDGuNKFBG4RIwkb/S6tmEvKvIzD3PpbI=;
 b=bzpukxlIkEsqSVBCuXQLprQBqEOCLHW9zj0H129PlzmGX6n3Yfw3P2o8IITG3QFnj2
 B1VFqQgPWkwir9gGGuctqCAbO/H/Cqir1I9CxQqAnbEBWKyfpOBhxued8W/NJz9Co6NM
 MNUAAaLmrd1Um8SQLxBA+nz8iWKO3wRRxxs0iUjhTohFkf3SMTWA5qrbbVcc7CtCyui8
 7W1V+bAQGZRWULAwnKmXkI9XA3ks+lwH3H0zNHGHWomkdR7DKnTZk1ltV0rFuCovd0di
 TVJ9q7K5SyDPjQqzuPT9CW6CGTW56gEcSbz5bHj8TsrvAUgHyTuJT8YMzaB7xEuN9wPG
 LbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyUw1XdGvcTKoAIb4lS9TtXCAztJWPdsbWm8KwyvBvDM2eTvDKtGNkNwrjZgekpy//qE8B3IxzO+Gu@nongnu.org
X-Gm-Message-State: AOJu0YzyoM0ZS4w7cI7hkNMZHQxFI/3ZvIWmp2eqbaSRdBPciWZ/LgL7
 4duAm9k1hLvo5+IHGzqVLd5kdllzUy9Qf+Wfr7Tb6gwi2e1F3naYc37YY9i7rN3SfUM=
X-Gm-Gg: ASbGncs7h4aQ8dj3/3j208DM/4yG4OIyZRpvCEN5EonUYLZAcn3YhfF/nt2hUftZ7o6
 w3B9bg1sRVpFSnb/x3uzl3rp77S03sh5BXHpP5y46FD3UMqlapVPR1qgUvEcZ0wrj3u0M+RK6Rs
 3MSNVJdjKmzrFCwiRdX3RKov3YVxd2Zd+Kvdx98q1gZUXTU9JCT9VBPkz82rkxQGBo7sHHUtLAQ
 hr1xoZk6sZ7VJ9F15nXdU+qeFci+FTV1fGoKHhaI6SxiBKalbwX0LnMt5O8UeuGnYfMCQyUG/rg
 /rqb3GqoYMxbXD5du91xjrPdJ1cmDKEiWDHRPD+c33ZSxNoz7mj6QSLekt52+nhZcjN8XH6uy4q
 cXwHZkqDAydVeMeV40li3FJrxFoAdTY/oVyBks7qaHuCKC7zdFss02rvXOM/iy7DiLg==
X-Google-Smtp-Source: AGHT+IG8awe427xNWu4WpDCbr1loDJV16BIdoIKH1yqxkux1JrxRkKGlmtP2pzzbwbERp3jUl8IoIw==
X-Received: by 2002:a05:600c:3b83:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45a1bceddf1mr6839345e9.6.1755151145258; 
 Wed, 13 Aug 2025 22:59:05 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c748a9esm7628445e9.19.2025.08.13.22.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 22:59:04 -0700 (PDT)
Message-ID: <ac13c020-988f-4d02-9369-2f337b476c51@linaro.org>
Date: Thu, 14 Aug 2025 07:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] vhost-user: make trace events more readable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-22-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250813164856.950363-22-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/virtio/trace-events |  4 +-
>   hw/virtio/vhost-user.c | 94 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 94 insertions(+), 4 deletions(-)


> @@ -430,7 +519,8 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>           return ret < 0 ? -saved_errno : -EIO;
>       }
>   
> -    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
> +    trace_vhost_user_write(msg->hdr.request,
> +                          vhost_req_name(msg->hdr.request), msg->hdr.flags);

Mis-indent ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>       return 0;
>   }


