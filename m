Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C37ACF65E2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYcX-00030c-9n; Mon, 26 Jan 2026 21:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkYcV-00030F-R7
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 21:15:55 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkYcU-0005cp-E5
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 21:15:55 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a09757004cso47976485ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 18:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769480153; x=1770084953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w229xaoDrAusU4bOiAXWvgNFWJFUGUS0vN44VVraYbE=;
 b=IPZ3dXRAWUEgfGmqNflGM7yRnKzScRwgmq2ziu13P1PmmgQ4baOJZXaOnF64lacWw/
 +djhNR0YdKgfd47vkvEms5E6Jr5Gk4TpezRQTuopiGkzFxNfJ/FcNtscmsGlIXR2YSZB
 HwEyA5eJVvZzRmLNN388oOVkXpvz4XzDqM8sA5Z6wVIGdxwtaGSKSLvlj/CvJiE3D0OO
 RwHRvzRyYD63FyM03BwqBDV0GVF1GRQPnN4KJTAwyanznfOJYJ0N9PZa77ei3Ef7X3bv
 MQsYHtMeGzgO+rBbWa5xuTUTMxPM3L4HHgXkctl/Ogy6HskBgBSVIyxOMl5vlnYRyYXG
 D2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769480153; x=1770084953;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w229xaoDrAusU4bOiAXWvgNFWJFUGUS0vN44VVraYbE=;
 b=f238Mx3iUZj6zuFIFbfYC2pGcUkOBd/ttVyKD7WcvAT8bBNaVZJrLSPISqt/vDpNc0
 kWHuNfqOEdcbRoBwFdauBho0bBHVfE693aZgdMAfAO04Gx26VrFEzSkA+ABnAnFO3FYZ
 FaIE0XxIHbXmomvTkgVwXXO4ZWQ46OWioFOEYIGPxGn+WjSV/XVwaITCmk0A8WSe9rRA
 O97ocRN2sl/DVmwQC4lr2Jo+IwI7wmN2GYvLWugIp+iP3gLpEK6j2Jc7gdTId4PSf2aX
 1s5OfXkxUOfO0YH2pX+EvKhBqK8O29CeiR3oh0BA0D1Bce9BKa7/2T69RMN6PK81PhqP
 xHiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXYmPcataqF2FLjJPCivtWXmGN+Vv+J/GhoV0v9sEOKcazTaMCHMYZLg9OPfqOSCHSyRrwPTlRLb3A@nongnu.org
X-Gm-Message-State: AOJu0YwgF3lLpiV9Kh+CipnGE+jPGvXyuE9YudJTvNYqvS06sMivsy6Q
 oickQeHn9XWVpHjL9HEGg4o32KzobpL5bwPSZ362cx4z1gkCqrmsRQ+aHWxnF6kCENQ=
X-Gm-Gg: AZuq6aK0jnl5pJuSJaBHBLniNO0DMAo8ZSgz1cl3UYkC4LsBxQ+lWg9CV6RCWEYTIKC
 RX2JpQwYLo16bemi2gWN5363DtBUciY5p/betg7LakM1fEtVx39XHtN7jXbmmXLv2U8DPv8atlN
 TcREw6+0eBQDsnrQDkcG1UIT3W1SM9HXXimo6wGAbhGI7l2KxKFR11O+Hk8XALnBNc6rnHpVxVO
 MeCQmXm34dbWpp0JI/b4X00LQEZXP7TTv53zEZ0/R8pdmOkljXR+ITUH6vJ44EpBpUm9WfFPdY3
 r2C3RDwkJ4Rjmq8G0X+IJQM30RCDAclW4OQawI7xrQRgK5s4V7QFRqCOy/Alq13EH2u+hjw9Mro
 hYrNCc4BjB0YWyHUSqdVo2513ZfTemXl06oiyp8F+U6iYQLMlx7oXMZ1wBXTnrhbaPXjM1dZlAO
 AkO2pcM4vrJgDPvZb9hMFz7mBQMmeoJg==
X-Received: by 2002:a17:903:2b0e:b0:2a7:95d1:3c0 with SMTP id
 d9443c01a7336-2a870d6384fmr2439185ad.23.1769480152864; 
 Mon, 26 Jan 2026 18:15:52 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f978c7sm100737985ad.65.2026.01.26.18.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 18:15:52 -0800 (PST)
Message-ID: <90520ad2-8256-4bc7-94e3-010455659394@linaro.org>
Date: Tue, 27 Jan 2026 13:15:48 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitlab docker registries
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87ecncc4sg.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87ecncc4sg.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/27/26 10:50, Alex Bennée wrote:
> I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
> wasm64) because we base the tests of the existence of dockerfiles and it
> now generates multiple targets.
> 
> Do we actually use the wasm32 stuff anymore? Maybe we can just rename it?

All of the wasm32 stuff is supposed to be gone.

r~

