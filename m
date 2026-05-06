Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF57FFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbnr-0006MP-Vk; Wed, 06 May 2026 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKbnq-0006M8-8G
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:56:38 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKbno-0008DN-N5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:56:38 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479eb8bcacbso3749244b6e.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778072195; x=1778676995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEolH7i1oXAGkF9CKsdUuiITApWx6d/0YJ0j+KiJPJY=;
 b=FOX0om3mVOFMaGBq7ZcpFe+pEvgUl20V/ZIpntvLUjRMG2jRph2GXbl/lkO/VU2EZn
 hdZ5Wkw4d68w3IbWYnxy/M4Oio+GpRM9mowM3HPW0mRLG6akSVJ3zrl7TeSsOW2EDJvU
 vbYEQjuYkBNMeGs+XQBRCXDqMeowqrUhJzLFd7q3xtnvoUQnQ92R6i9cWUMf4+hWGtTH
 pfU06zJ5jmBOrukf/s3+bm8Bz7/XbkNwrFi9UsGmi/2442tqc0unAWeOepW+GVGpy//h
 UK9Zw61h6liDSmLwoVGWD72j8KUcYhDc3Tui328XbyyEoRcwN4Zkib2sF+lwmi7LaRiU
 YtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778072195; x=1778676995;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEolH7i1oXAGkF9CKsdUuiITApWx6d/0YJ0j+KiJPJY=;
 b=cuM8InkX50VPnOIDb6EOyd0rz6Bi0iYi//sPvRP6jTAHHBAmo37aX7XOoLb5RiyxAn
 fX/e6fhrAf2hvgUXwQuaCe0IM5aXnNhkgQEm5+ZexFWqHBx2Lte0+2yGl27XN2yRARrS
 qPz7kDqHtxS8pcXH/A8wA//zm6zSYPw85Ds0nTjtnSPBcbcQY4MwcM/TUVbLzQYIZimL
 X/z9z6kO2wtxahvXMTuM8YOsy8W2dfVgBHzPELdKOX7jbLuACw+hwp9sCFUHU1H7/JBD
 EoHiQ2yw7JQ39x5mAuD8k+0vSOFgmZMHEmGwX92GvGQGRCduerfVgzPSQIziRQclgTI6
 OAWA==
X-Gm-Message-State: AOJu0YyIlZTXMjOTeSos8rYAI7C/CLRJcbcw2RfaefbcqAxOoiWjLwpd
 AkGReYmB5No/UMjToo/SY3qBc6E0a05ucsj15lyP7g3++xyD3Ao7dM7lyd1dPlJ77RQ=
X-Gm-Gg: AeBDies1eQlai9Lct34QFjcgtpw8VkPycOi/3sS6aDz+v2xyf0yVQnaKF3f2EZaMIBo
 gSlDZVX2A4yp3arIxmaPr4P1jqQmsPD7bntnJHyNaKOibnVAwlSH8eVc8SOx3yD4wZiuH1GGl4j
 W7KVruT2wz39gPM2EwvXxLlH9r3Yhd9r2zWCp1newse1eCYKR5sti2yb16XXmBxJLrWeVorNKoY
 h6WthUBNUe0h7V4KsQZ5JvoM//Bw+LAzj1ZjKn4xELX5qqFx/4ymgV7j/CjepdS/mje/sNws6Mt
 t2gq1LTogEi0xGwUChUZqCk6kfR7u+R2yEXs2BzWpITId+78W3U0p1wPmwh1zsi+Fs7ap3PXEm6
 zLfVgXCpFy7rAcrVjr4sd+A75y2Doy8IY1JFCxdV5hgMNYsqW7tw8lMid7o8u4LoLrbfIGdn+ZB
 jEP208H1QhU+qekaT4oYbpp0BElYxsGASlkXvbGnbaUjLtM8NYZIUoGr7aq1YDsruyp4X7ruF4x
 9Bjm2Gom8juBTcS6fKZ24PVGokbiTU=
X-Received: by 2002:a05:6808:221b:b0:463:93a5:a5bf with SMTP id
 5614622812f47-480420597famr1614361b6e.8.1778072195231; 
 Wed, 06 May 2026 05:56:35 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76400028sm10518380b6e.5.2026.05.06.05.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:56:34 -0700 (PDT)
Message-ID: <7269f32e-2577-4487-a828-c9dd55d48e04@linaro.org>
Date: Wed, 6 May 2026 07:56:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
 <c7a83814-1ce7-4092-8df5-0a845bdf5b41@linaro.org>
 <CANCZdfqofJ8J-0UQgRVvaM3C=swpbF=jfw8kApntNUnJBLSwew@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CANCZdfqofJ8J-0UQgRVvaM3C=swpbF=jfw8kApntNUnJBLSwew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 5/5/26 17:52, Warner Losh wrote:
> 
> 
> On Tue, May 5, 2026 at 4:40 PM Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 5/1/26 11:11, Mohamed Ayman wrote:
>      > +++ b/bsd-user/qemu.h
>      > @@ -44,12 +44,10 @@ extern char **environ;
>      >   #include "accel/tcg/vcpu-state.h"
>      >
>      >   #include "qemu-os.h"
>      > -/*
>      > - * TODO: Remove these and rely only on qemu_real_host_page_size().
>      > - */
>      > -extern uintptr_t qemu_host_page_size;
>      > -extern intptr_t qemu_host_page_mask;
>      > -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
>      > +
>      > +#define HOST_PAGE_SIZE        MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)
>      > +#define HOST_PAGE_MASK        ((intptr_t)~(HOST_PAGE_SIZE - 1))
>      > +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)
> 
>     This is a bad idea, hiding the true size of the host page.
> 
>     There are oodles of corner cases that require the exact size of the host page.  If you
>     hide this in a macro, you are going to stumble over them all of the time.
> 
> 
> Yes. I've thought about writing test cases for maybe aarch64 16k page binaries on a 4k 
> x86_64 mahine.
> I don't suppose there's tests like that for linux-user today?

No, because it doesn't really work there either.


r~

