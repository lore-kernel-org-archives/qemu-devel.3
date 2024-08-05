Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4C4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7Xq-0001JY-4b; Mon, 05 Aug 2024 19:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb7Xo-0001J2-7Z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 19:55:16 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb7Xm-0004yh-IB
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 19:55:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc566ac769so2167865ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722902113; x=1723506913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MyGTooQ3SPqRVhpXmPYmHp2zAXd+BZtzykWjoXW0s80=;
 b=LHCynY5y3vEO3jN6FcFladHKqyCvmWmSfNhQ/ZA1tCuOjHr8oD2x/4sx+MacAr/FqR
 Iz7VJhskWUcLg8v1MCMER1+RPEreKrdk4ptrxBiQYOYZXVIhRHehBooKog3GPux+Zfwf
 7Bh+MAvrLNMcw0uLGDnO7T2nLcI43lh5lUM2dkkf6hTS4+zQG+RdhV0AlJADAc/LiRzW
 YZhrIekLOhSU5SxhFZnhaj6wvtodRda3LK3H58VzaT4QZ1DTwQYj/wNJI/+FA/M0sG1I
 FsgGSADbfPZtDTPlpoSBOg2pwxXCgUOMN7zTv8EwyjXv9rH96rbE6AR3ozN+iFIoburD
 1f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722902113; x=1723506913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyGTooQ3SPqRVhpXmPYmHp2zAXd+BZtzykWjoXW0s80=;
 b=oU/BQOgmplbJAzz/wvpEbxv4lrqdve/Zh5mc/lZOXGtf9TnlGIzMSD2PIk5rzajcQc
 W7rJFdWZWbrvxJOoP58As4GtS83tj/GiX3wR9+QvoswIC/zda1+kiag/6Rip6XztlMhu
 MsgZG7KFXCmV6rdaSaM/9+1fusCHvvyHImHsK7XVO+6Acw6jf1UIYKnZXrGNXPC2fKVL
 lbB7neqJf+wtzSyO5GqIUZQNbsXY3h59fGppNQALVLmOF3aFQd1+n49c4k4Wm0T45U3w
 P2jBx9Tcvmi5QTuzao009+KyPS6VlaMe9rd62l7WRalMXO1dLPVvJ3wU9i16lcaIGnWQ
 m/dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs60bYUrOWB5/mmTC1QyHe/ObGcwrnJduFqMVyXg4mrArdYaH/eqIpaDMh4rmDg20wa/pFE4yClK2FTicyjUvCuF0Ni4g=
X-Gm-Message-State: AOJu0Ywv9wyyP47MRxb8jgDVDqkac/EVvqEWxqOSbmG8o+2NvZzJC6/M
 OHrrw/4rmV8rpVK7JDxrmF9OTK5GHUVW9Dn6L6090TWXqn2OE5/gGdo+40nwWBdZ15k4Obq/BhE
 ndO8=
X-Google-Smtp-Source: AGHT+IGZxOZu5BpSuP/kklnYVh4YcIE0PlL4eHtdvIgkXuXhVSIXdb6rlm2mRqksxNVSM3xZmXJewg==
X-Received: by 2002:a17:902:c40c:b0:1fc:6a13:a39f with SMTP id
 d9443c01a7336-1ff572bc192mr127166355ad.25.1722902112730; 
 Mon, 05 Aug 2024 16:55:12 -0700 (PDT)
Received: from [192.168.0.152] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b5b4sm74501615ad.122.2024.08.05.16.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 16:55:12 -0700 (PDT)
Message-ID: <0a7d5e34-bd34-4f2c-9fe6-1de6d2103640@linaro.org>
Date: Tue, 6 Aug 2024 09:55:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] QAPI patches patches for 2024-08-05
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240805075925.2062973-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240805075925.2062973-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/24 17:59, Markus Armbruster wrote:
> The following changes since commit f9851d2ffef59b3a7f39513469263ab3b019480f:
> 
>    Merge tag 'migration-20240802-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2024-08-03 07:26:26 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-08-05
> 
> for you to fetch changes up to ef71d8209f5786c4e68b5ac7dbc0da7a43f0ed4e:
> 
>    qmp: Fix higher half vaddrs for [p]memsave (2024-08-05 09:34:34 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-08-05


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


