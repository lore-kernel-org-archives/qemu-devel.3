Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4FBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1Ub-0004zH-2w; Mon, 22 Jul 2024 18:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW1UU-0004xE-Pd
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:26:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW1US-0003jZ-Qh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:26:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso1334235ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721687202; x=1722292002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jWDfVrnaWMfIXgFgaz5jn1TeB6DYHTIuveHzb1zlTas=;
 b=p1H4DaDWUdhzSh2YHOC8BKoBqSU+lk9fFMwcgKSeViHDDPdBeiJIrCAI2YmOOfQDG+
 sR76fOqM+8LW7cY/pGFisRNcdT1+UTiGvDbSxgAuCQ+q261CX/9xg102/F2aVcItJoFG
 IYXx3kMQFbYe1uBt15PBinkVkucwRqUeD0xhquxIame8QfOiXz12Pqgeh0TbdTlLuh7Q
 G8rUBHgHRhFwp4FQN+UgQLSTFoR0Ub9TF5YU7Q4mS5kspxwRXdbBLqxvycTmpbwQ1U1o
 pLPkv7uQuMNBBpglbC0vqq31g5+PkhG0kpPk3rbib+ct7c5ysfmsP8qUUN2lQyTRIcQ4
 iv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721687202; x=1722292002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWDfVrnaWMfIXgFgaz5jn1TeB6DYHTIuveHzb1zlTas=;
 b=foLSGLxUGOJJAfRkfJMGUtZLMaWHlwY6X8MhMZpJ6K2s2Vl4rQfGq3L3WO/MqOCxw1
 9oIovM35gY6t3HugE6+bTUYqKSnVCfkrlSnx5HoIewhjGQt3U19iLeGNigHXRv7VFKX8
 gHAmGDuKDZPJcCzAxXffSx1yXAoHglZVTGgPHdAE0Pa40o3oZjVb5natuCYx+gR5S1dU
 QvxxnL/CvFQSVEm0wEWICuMTCF9nNISkzU9hdPvOnEnws7qQ9VpPRxGY2LN70ZcieA3T
 kKiIakSoQqO5KuGMAc9JdJj6JeVcIih9hI8enrkbM22gx1ygt7FQ+c0Z9ESvogJPILn9
 bE5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2OFTQ3uTvPXeV6Sw1zQKvcL401lQURNPOmUJ6SU/xyMeKKdY3odbjS5THcZ34TCQnDowaoWF102yBwP5WgfV1sCfCO9Q=
X-Gm-Message-State: AOJu0YzSvmc+woB7zn5UAhCKwp4k3gndItUuwcUNT0qjruZNUGuSrS0v
 6jnPjc8GCmb2aUqUJCiSnDX6977lj8XB8ZSowGb80RfygaAv1q0r2TCmMv4TqvY=
X-Google-Smtp-Source: AGHT+IHJaRcBecLaG+s6s7Jr5m4/zqMqNgiu6OHBl7rlc+yZoMKoacbn+TQZzB2dmvfRssg2iHDQJA==
X-Received: by 2002:a17:902:d511:b0:1f7:2293:1886 with SMTP id
 d9443c01a7336-1fdb5f50c4dmr10583875ad.12.1721687202167; 
 Mon, 22 Jul 2024 15:26:42 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f48ca81sm60119665ad.299.2024.07.22.15.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:26:41 -0700 (PDT)
Message-ID: <2f161331-26db-4b52-92ef-4c24b927ded4@linaro.org>
Date: Tue, 23 Jul 2024 08:26:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] Misc QEMU-GA patches 2024-07-22
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/22/24 17:00, Konstantin Kostiuk wrote:
> The following changes since commit 23fa74974d8c96bc95cbecc0d4e2d90f984939f6:
> 
>    Merge tag 'pull-target-arm-20240718' ofhttps://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-19 07:02:17 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-07-22
> 
> for you to fetch changes up to 24d12dfc5abb3b4ac2506f22c3fd0cda40a6977d:
> 
>    qga/linux: Add new api 'guest-network-get-route' (2024-07-22 09:51:12 +0300)
> 
> ----------------------------------------------------------------
> qga-pull-2024-07-22

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7401175099
https://gitlab.com/qemu-project/qemu/-/jobs/7401175098
https://gitlab.com/qemu-project/qemu/-/jobs/7401175093

../qga/commands-linux.c:2159:42: error: 'sscanf' may overflow; destination buffer in 
argument 12 has size 16, but the corresponding specifier may require size 33 
[-Werror,-Wfortify-source]
                            &Use, &Flags, Iface) != 10) {



r~

