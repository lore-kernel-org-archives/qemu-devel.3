Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D3CC3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 00:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWm1W-0002YQ-43; Wed, 24 Jul 2024 20:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWm1V-0002Xa-BP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 20:07:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWm1T-0001GX-L5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 20:07:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so2838745ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721866074; x=1722470874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q29X9Kk5wA0BKFvBR2hSL6jPiMLoZWNF1zPAoTNlJPE=;
 b=zUAorRqEY9EVRo+2q9ZXUGNn9n57375t46ufqWCTzWkK4W/oMk5UnTABrDcnrVz/+r
 O9796Y8sevd8sMUc18oedwHya3mx79R6QplWBue0VMAFSztdXckEvO8lQ2uAphYtgyeF
 +PCHuUChLTKmmMiWi+xKBvHARK5gPJ8m7wJ6gEzgEfX+rcdZpvHEs8/jsCzDG/6Qcqy/
 TmEQhSPDG7TckhjDFhUOpyiUd466qJ1uBUdVCHmtCETQZoJDNhMt9Lca/pbLdpbmCirh
 YsktqytwMxdE1p5toZ/JIkWZ/gl5tgBOrdufCm4WZoW6ZMWQhvoPkH7dJTzikXJVo/V5
 /Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721866074; x=1722470874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q29X9Kk5wA0BKFvBR2hSL6jPiMLoZWNF1zPAoTNlJPE=;
 b=GLtFjVHeLKv5xuMaW1Eo6VC9QnEUK4TcezyB9RoEcPi/wKt4Pu9J8eW2rgzjWYy2RO
 /IpPCPiqOdBBYTVxJpwfskuJxM74Vauh7yvfVF8q9nyLwn3b0T+X9l2+BYHWvLXs9fgQ
 aQlTdDetnT1gYdDUhVRz0HGxhDsgJE2z80dPKHTB80OqkbufMRqCHocq3YfoD4y3IImY
 tjmefXaIxuDevs+D6JRT2wXp3E3C531SofdwyMGkbBCzRFyMdzXDNcbsaR20hob09IMg
 HWa9BJi0/Ag97LsI3HoFzrSjdZlVinRL6IQiEnXMUBRAVKxoFXfdHp6SBKA82cK105K3
 mtQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWQo520JikENK9LEf+R7tZ+KpOqHFfEiW1571ZaecnGZQbE8po1cnOQnfd0d8ChaMyNN9vW6BohUsFvD1o2oe/yg0VAu4=
X-Gm-Message-State: AOJu0Yz4j9TKyKOJLajfSF1Ualb+hps6GLIyi2SlFZBcYlFt1HhbA/8i
 b5anFm5pxTs/R8ifpDgKBXzSIlumuYC5heffSHENpAJq9I0bsd7TdJRo+DmPFnA=
X-Google-Smtp-Source: AGHT+IGL++uB14CeKShz1fHbzaxUIEZrseL5aOM+76/jK2l8maxZKrtMcZvYuZDUThb1eu+3QqOtMw==
X-Received: by 2002:a17:903:244a:b0:1fd:64d2:62da with SMTP id
 d9443c01a7336-1fed92739d2mr2448595ad.29.1721866073736; 
 Wed, 24 Jul 2024 17:07:53 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fe1a26sm1548265ad.288.2024.07.24.17.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 17:07:53 -0700 (PDT)
Message-ID: <0679a991-a8bc-4406-8e9f-5ee134136666@linaro.org>
Date: Thu, 25 Jul 2024 10:07:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Bsd user for 9.1 patches
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240724220449.10398-1-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/25/24 08:04, Warner Losh wrote:
> The following changes since commit 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd:
> 
>    Merge tag 'ui-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2024-07-23 15:23:05 +1000)
> 
> are available in the Git repository at:
> 
>    git@gitlab.com:bsdimp/qemu.git tags/bsd-user-for-9.1-pull-request
> 
> for you to fetch changes up to ec018b76798e1196882ebcbf3df15e6d86ac9d7c:
> 
>    bsd-user: Add target.h for aarch64. (2024-07-24 16:02:07 -0600)
> 
> ----------------------------------------------------------------
> bsd-user: Misc changes for 9.1 (I hope)
> 
> V2: Add missing bsd-user/aarch64/target.h
> 
> This patch series includes two main sets of patches. To make it simple to
> review, I've included the changes from my student which the later changes depend
> on. I've included a change from Jessica and Doug as well. I've reviewed them,
> but more eyes never hurt.
> 
> I've also included a number of 'touch up' patches needed either to get the
> aarch64 building, or to implmement suggestions from prior review cycles. The
> main one is what's charitably described as a kludge: force aarch64 to use 4k
> pages. The qemu-project (and blitz branch) hasn't had the necessary changes to
> bsd-user needed to support variable page size.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

