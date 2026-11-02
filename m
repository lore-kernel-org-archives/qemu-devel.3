Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7D60A188A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W1mmZ0c6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNv0y-0000Zk-KE; Mon, 02 Nov 2026 11:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNv0w-0000Z6-Jf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:36:06 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNv0u-00039k-Qm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:36:06 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3adf5f6833cso1673608a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793637363; x=1794242163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CFLwWRsk8mAtuo5V4NMaHenn+Kw0HJ/t+WxmROVoi/A=;
 b=W1mmZ0c6n0tsDPDU22zOvRvGt4qKIOUIeHVQ0qaMHlnMgStRAgipNiNEljZPMrO4R8
 x+QjlPSAPdOVvOfi9pujmvlKIV5a8+Yz+aDXklYwfHYUcUshtS0ChaNdVauikn6R0pke
 etBEMUxG35yR6xZw/tw1ftaMUZOMIP9PLTGWkDw5Hi+42a2p0YFk/7IcQsT4u9iWDyw+
 SFMXgYaQLgMzKrIy2IBQHMKy75qAQ0EZhzq3YBzmnpry0SOH0e75YeiCg3P1RzHOIlU3
 rCYWMgrQ63o5r2iB1APRUKYxkjPUjsqJk8qby/zYWQl3R9oeFXtRqNypd4bhsdl4sVDW
 EX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637363; x=1794242163;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CFLwWRsk8mAtuo5V4NMaHenn+Kw0HJ/t+WxmROVoi/A=;
 b=L+KbBr2pISOAM6r2rdRpxAdazJdNlulxv2nAvNISk+oDnmgPPGStScY1AogFvIPeW9
 VKQxZjLvD5AQd0YXpKLd/ma0rPvsHlKHJh6NpvgIu5uKFZhjbhyXTsHwI1vBYFtS21GG
 zZEvdl+YhQ/6IfhVwoRNJIeeVwDp3sx8W25tLRNaQi+t1zxMnS27MbIi7y5S3NqX5nDv
 /2e5hYMP6LvLq2JgiI1jt9970V3BUbWCgp7FlIgIg+jVxCT56VJy0+td4bN7FxpCqjaz
 eWw8xxBAUqjnAdVrxkLT6zoxj5TZNGysM1t5ps1ckpRsroNTRM3Jvh3bm2tFYdfuTyr5
 KVDA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZg1erH5suqOdle8+KWrv+rQisYT/K8M1Y5LztjbLK0u/7wsCSp65FaShvE8EKeMMs9ByV3wCb+go9@nongnu.org
X-Gm-Message-State: APuU4Z+9Qivzc3tPkiG3QAeSNcdESETMyrI7T6tHsZIoY8tpfVwMncaK
 yJFjb7Lv29LsgNgqt5v48fQ2r/5ItPmrWCNtSbG1ZOTqNSpyfeudzle6/OrZVDIauYA=
X-Gm-Gg: AYBFou0212YnU9xnJtYMMa0CkTEvljBD58/n2bGmC0cKQlpuRl39SxOJa0BxSe3UTqJ
 X1VZU/8hR0qK6nMBIsRPDyj0/CGNgMNy3wbN5XcCIT1pV2Fs7iNnRU9dLBxhQWDAXaRAw82bMme
 f7EM2gbqMLZBKZ6ssy/OL2UT/uVNqmbVwiea8560QnE4jOeMJwQKH6S3SGMSdrXXjjpv6707SSH
 w0Ku1hFDw2YuqxIG9CYX/hpu2VHkYYewWZNuaMYMiQRDTWV8+FvuXR6rp1VOYh1Vi8z3OQpFYEQ
 bGRM3gUAevBg6VO75pVRNIkos1HNLPJqps2t9uosaPU8Cvo2B6auhshSGutDJgM32rbWpIwbNm8
 WcflEr+7cHGV2F0VVjQ5BeASmOcJHbLtC0SadZl0EsKqzHoIt9h55H5OzP73R265cMaNUOfTrCg
 EaX4uX/t9uD94Kcn76sf7qAZOT1mJMGZEyBDisMJ/ulSgmcHHamhhIsqWTkAH86TKELKy/r2ZDd
 c9WZIt79Wyu/Tjm2/lJCm0aHzYy/Az2Vhu5Z58q2DtQ5Iy+o0FFx4ItQL8tieXy8U6mAcZNUv9a
 OdoRBptMFsynE3wA6LcX5/tnl13fUyW/0vNHgwW4rShSGTXPxKr0JeIvqCAmzlco9usFQQ==
X-Received: by 2002:a17:90b:3b46:b0:3ad:d4aa:8559 with SMTP id
 98e67ed59e1d1-3ae896f8266mr7673185a91.17.1793637363122; 
 Mon, 02 Nov 2026 08:36:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845ecaf5sm14851153a91.16.2026.11.02.08.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 08:36:02 -0800 (PST)
Message-ID: <d11965a7-6a8c-4d83-aaad-a208f5d3ef28@linaro.org>
Date: Mon, 2 Nov 2026 08:36:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261102122645.3353402-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102122645.3353402-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 04:26, Daniel P. Berrangé wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to f4b560dd12612fa12217f3a621ab54dfb6157040:
> 
>    accel/nitro: mark 'nitro' accelerator as secure (2026-11-02 11:08:45 +0000)
> 
> ----------------------------------------------------------------
> * Mark virtualization related machine types as secure
> * Mark KVM, Xen and Nitro accelerators as secure
> * Use getexecpath on OpenBSD
> * Use qemu_dup() over dup()

Fails build on windows:

https://gitlab.com/qemu-project/qemu/-/jobs/17671461626#L2066

> ../io/channel-file.c:57:17: error: implicit declaration of function 'qemu_dup' [-Wimplicit-function-declaration]
>    57 |     int newfd = qemu_dup(fd);
>       |                 ^~~~~~~~
> ../io/channel-file.c:57:17: error: nested extern declaration of 'qemu_dup' [-Werror=nested-externs]



r~

