Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320B2CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbef-0002pB-E3; Wed, 06 May 2026 08:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKbee-0002ob-6Z
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:47:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKbeb-00066z-Fl
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:47:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so4928753f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778071624; x=1778676424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrstlO32eLoi+BnOCMzLVUQmrL/dxDYeCxPNxhHgXG8=;
 b=B5eSzLQyON1fNaSVkaa4/Gowd/fbTm5hGys4jH8ZwYIVctfzHhTDZJNjlkhK10cP5v
 SJeLqsyBi1MNRPilbJPtDPbTM6sm4Sf4jFSlALwcBH/5KznHhfkqpQ+usPZOE16lHZqV
 kylxekFxgtDT6136AVc54XH+JrC3jvlXbaP05yP7EQ/djyfqdegqUfWOCr6xhEKAWeDD
 Tv6shkmCC975youUkFZ3vgjMmSHu+WWP9isYPCEGJrfrNhySy95es7HeDP7OcF+VntIf
 cya7VOJp73Z4C1Bhgr3rNL9nj8qMFMLSL15m6lDIUqDUv4zovI/q0cm1CLHR2/Ou8FzE
 WPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071624; x=1778676424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrstlO32eLoi+BnOCMzLVUQmrL/dxDYeCxPNxhHgXG8=;
 b=H8+Fxh2WiH2DnWxZBaEoshTDvuywgyieoYaWLrjyY6bg8StctNJuey3SdviC6bxIhu
 999zh0JPm7NhQzU6M9MNdfAgYcjzGSTk+YGXlkYbXZHxE5V36rOB9zIQSi5yq/J0cpL7
 w/SNLNnP3rRgf5n2xdavrvx3vrQMNZYzEg98rdKblOhTJiAT0eAEYH2tVmISg6bwL0gT
 82R+zo4GWD5kLWvXmzymwRW2DCXUxl43nPwHQIaQtO9cHUYiqz8yKF8ADL4AwT8b3xKk
 I9WaakW+ji1Isy3tL6uRrTnrTmByIwWyOtc7SV40LLgIfSKZ0VAB0Qb7GWoW/l1seEvG
 Kkiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FDb1+/xmsHMTZmG7QmF6r63AsZ1NKcRf4PK+HSQzPuDLJRSZz6Y/fkLk50K2kBo0Vd/PcIbuFVkig@nongnu.org
X-Gm-Message-State: AOJu0YySJahNg5UKP9EaBi8YVJNTDPrPg1HwNkRH3sdHh2Rb06mYhqv2
 jnsv8Ynfk1QaQvMx/gVueUCX4W+eSXLsNNt+zM3aiHU1Hsjb9mW/esm7PYL+TGSdxbQ=
X-Gm-Gg: AeBDieueUS6Xxv+dx7+PhcJ5/vTMEeh6pVMDF8NM8/dryJQdQn1iSs7j/vKQI5bMTM9
 DVOpFIBJ1WD1myslmyZINl78ZC6DPHc/VFTjzBu7MG2E+FK3FihmYPhqQUTUolI56Tg4arDQOLJ
 +ZxbHcU2hzdXRMZRwbyvxXNPRaqQBA5K+27p1N7vtntwRcZ4TBzaXakmErCqjzCZZBkWpxDsUTS
 A+Essy5KoFkGCo6YLlpwp/9vyvvzPKVeX5hq9I48CJ7+NOkDHgjS16dElVsYU7f5pT09sarrn1Y
 qMzJr4PcwnlQUf3TUcpDpuj9i/5V3dnG5p2j/ctZuaYav4XzfIcDp/SOqZLnM60P6/j3zfZ03Kr
 uXow2XcIo+4fftFUbzOikJX2u2Ydbo9sMeoTd2BO8U13NruYxxe8hQZ1/63hgf9qXMIup7jK/xH
 JuplILLtD8LO0MMUdo5x6wGAO5F6WSD1YSxUStsJi6Z6/NQWgDp2t3/sLNmgF2hrv18FwvtExz5
 g5hYK39ylC3yaE=
X-Received: by 2002:a05:6000:280c:b0:451:6760:fc2d with SMTP id
 ffacd0b85a97d-4516760fc6bmr3589140f8f.0.1778071623637; 
 Wed, 06 May 2026 05:47:03 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a4878fsm11915712f8f.9.2026.05.06.05.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:47:03 -0700 (PDT)
Message-ID: <b3769c81-9a75-41cf-a66c-8b7efc7bcc8b@linaro.org>
Date: Wed, 6 May 2026 14:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/26 14:01, Markus Armbruster wrote:
> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
> 
> There are a number of MAINTAINERS entries with S: other than "Orphan"
> without M:


> Some of these have R:


>      MAINTAINERS:2022: Machine core
>      R: Philippe Mathieu-Daudé <philmd@linaro.org>
>      R: Zhao Liu <zhao1.liu@intel.com>
>      S: Supported

See:
https://lore.kernel.org/qemu-devel/20260422080406.62638-5-philmd@linaro.org/

