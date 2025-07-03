Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98DDC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHmI-0003KO-AW; Thu, 03 Jul 2025 07:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHmF-00030v-Fd
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:06:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHmD-0006CZ-Ei
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:06:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so39300605e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540807; x=1752145607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SY3bbRxwwhqkW5iC4r3Kz/+8BMlWUXcP8I5mFKx4az8=;
 b=rF1eCr2ohynvWpF6PTC/wt6WgIdxzgq2TuClMt87p5hZDcdttjAwI5LWtLrnmgBHgD
 cN1O3hUKynvUx3lgLA76NqUb5ay+rqKjqtLJr+SbxIxZEyR/Uws3/3uFj4Yr8bgVBKgx
 Kl28oqBCTwkHnYRwB4czsMmbYliiSpGfX9dxuo/Hp6HzXWP25I2KaPaIKLm2pF1rcL3e
 2+MjhPRdoW8mBrrt49Tink4mGegbnmQCTRJVgXGZFvt/zp+eDccePR1bEL28Ok13IRMR
 vnmgkMD3dRf91TlS7aGFm4yhvW2XZviqRKD758mxYGkPZfOrMap6VtMi8nhSqyu+9Q0s
 1q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540807; x=1752145607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SY3bbRxwwhqkW5iC4r3Kz/+8BMlWUXcP8I5mFKx4az8=;
 b=lUc7KkF8S//8/Q1EmvccYUkqZk6QtuSrm4pCSTbLpTFvvysa4IeuBThA6FEclpOdwp
 gxXM4jfCcueC/YbjJW9Kj0aTGo+mJ3DkSgJupMqehviV5PilJObNKoYJvJfNeEkwqunJ
 NbvShLPWqSoDZwoDAknomI1ZEGVuNubmz7WeNKWAJhAlhtdMHssMIiQor/1XkMM7Tr2x
 Jq23q5C+Ry69WpV5ubgXyUVugGGekCAg8tQnre+kmI3UJCzs0+e25AZbCijGQtBuWtqq
 kkcv5d8Xb0lsbj6OIRvNhZ63R329fd2BDcgzOahic2YTCLp5kt35q4OFSApParzvHMfn
 iTGw==
X-Gm-Message-State: AOJu0YwzEfxRSXt8r1whwXYfjbJhFqzY5plnZOIslorzk/Qrkea1a7gu
 NwzM4X8ilax5ihS3T5O3WzdJ+0TnBTiAxAPTBaPQ9SvtjvzzuTXUY+6WnUoMQVEDvfnG88JgN3j
 /CscaeK8=
X-Gm-Gg: ASbGncsu4FniKPIO2+fNi2vYdoB4M4IFt7rL/79su+tKL7/5aLISM3gti5xy6VGUsi0
 cknzLgnsI5fZc9mpL2FQiA0N2D92YjRzjxpDGS9dOist0Aj757vt8tFu6eauF7HQOJ3NXGtIZxc
 4cfsRYb/Snh+eLcUPmNE0pZy9uG9Nt7QLuK3FqQUacBpN/4UsUbkbmsrA/aUXE+yguEQKc5yH2H
 wyCbQjle9iyzYUd9yOE0BDL8J4vOL1Jmlu/SLmOhvGleUf29lvGmVuNAg/0FfuozYb6dWN1DtiK
 9wmDQprObyeglc2eGBjqo71GkApKZJUH7cgRm3nAr92DdIAuWy6WzxF5MD1KLSLY8+xJY9I+mL2
 K
X-Google-Smtp-Source: AGHT+IHjgZAPP08KCJfBUi9HGXkOD5sakqCz6orLObgGHxB3KaUuSEYVzqSR4uUZvniC5txn6nd8BQ==
X-Received: by 2002:a05:600c:3504:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-454a36e483bmr72402135e9.10.1751540806936; 
 Thu, 03 Jul 2025 04:06:46 -0700 (PDT)
Received: from [10.79.43.25] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99a35f9sm23533485e9.27.2025.07.03.04.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:06:46 -0700 (PDT)
Message-ID: <deacf2fe-a84f-44aa-a612-7985ea9339ba@linaro.org>
Date: Thu, 3 Jul 2025 13:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/69] accel: Preparatory cleanups for split-accel
To: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 3/7/25 12:54, Philippe Mathieu-Daudé wrote:
> Missing review: 23-24, 27

> Few changes needed before being able to add the
> split acceleration:
> 
> - few method docstring added
> - remove pointless stubs
> - propagate soon required AccelState argument
> - try to reduce current_accel() uses
> - move declarations AccelClass <-> AccelOpsClass
> - display model name in 'info cpus'
> - add 'info accel' command to QMP/HMP
> - make accel_create_vcpu_thread() more generic
> - introduce hwaccel_enabled()
> 
> I plan to send a PR once fully reviewed (v5 likely final, 69 is a good number).
> 
> Regards,
> 
> Phil.

Series also pushed as the following tag:
https://gitlab.com/philmd/qemu/-/tags/20250703105540.67664-1-philmd@linaro.org

