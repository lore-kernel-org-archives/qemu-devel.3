Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B2C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 14:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Qw5-0007ll-T2; Tue, 21 May 2024 10:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9Qw4-0007if-2s
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:57:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9Qw2-0006Rr-LB
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:57:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so368503b3a.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716303469; x=1716908269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Em0vDjMYEzQAOdnYeaVvY4R828QJkTVdXNsFzANY4nI=;
 b=t9vLbDmxJ/DZxnPiEiLBkupcEg9ardQjxZ/NJonNbDtRX22w//lzoFwJ95K4y+ztj9
 LQGUFFEflYZS18UijPcotEDutlCJGivU0EdnbSTgFj1q/1IoWed3xvu3CGQLv/D7bX32
 bt5W+b6daTRWXRQl6KF4vhbcxPytKMRWXhkMmhXCAt5BdnjVDpC+Io5W4647MvyeLZWk
 +o/a/QtPcvy2Izfzmqfc1iNC2QgoIyyKn8V9N30J4HmAZe49kMn0HLZKTjUK3hoa5tiK
 swrrKQXmScUI5IPb8gw7jBjB2hOEpBSjTdEM41kSyYHY+s0SO0Yr32FRcalPf7XLINB+
 A52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716303469; x=1716908269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Em0vDjMYEzQAOdnYeaVvY4R828QJkTVdXNsFzANY4nI=;
 b=YsbYDwFdV+lanz3LLPCDYeRnrpKmdq2tktVsaRFUofTQVCuXChi25gOVY3CpQOrfUS
 jzKvQratUHrsACocoVnjg6Ul/m50DyxOZG2Ue2t0xJ+ad0CzSQ8tpazN7mQHAK/BchkD
 ymsyRDUDst/dhiMYA/X2fWy4gZBvypcYF7M30W9oZW+JvBsy4sMSM/ilNrC9QM/ut/M5
 5jNMVDZx8AcKpHdZk9z7BSqO7we7A1OSNS+psEJjxZoTxNaeR5rSInY5y0+ryr7Yli4q
 8B/kVvrSNIrMWY3WCSTeon6adrY/9CEvawqYmYKZ/uNRIVL6gqG8LjIsacJxqAycXD6S
 87Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjYCKcCqh49LsHoa9E9ERvSFd4jBRnUbN6bE1MdWVkMxFJ5GPOnFZTPwVELSOezjFQ7MiWFpTY76dfjyowqySHaKZ2x10=
X-Gm-Message-State: AOJu0Ywl82Uk201Yz8e9zWodIBo0MWMvUjONHpOMluBRwKMrbNR8rv5D
 uvt7U4k69yrmrNu59yWO5Pubo7OJcisN2JpO6ui7iUtgNgZ82MRsIXNpHXQD24dZU6ap16iTAq3
 Q
X-Google-Smtp-Source: AGHT+IHy2f7b0yavXfVydeX/mHl6GaSGZZl4LAmmPVtr4P479eQsIia1gdNqKurlF44mynmi+imb9g==
X-Received: by 2002:a05:6a00:2445:b0:6f4:47b0:6b5d with SMTP id
 d2e1a72fcca58-6f4e0391f7fmr33285202b3a.30.1716303469248; 
 Tue, 21 May 2024 07:57:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2b2648fsm20906722b3a.189.2024.05.21.07.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 07:57:48 -0700 (PDT)
Message-ID: <aa3d3005-9095-4edb-987e-fb46bcf870d5@linaro.org>
Date: Tue, 21 May 2024 07:57:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] testing/next: purging remaining centos 8 bits
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240521125314.1255403-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240521125314.1255403-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/21/24 05:53, Alex Bennée wrote:
> Alex Bennée (4):
>    ci: remove centos-steam-8 customer runner
>    docs/devel: update references to centos to later version
>    tests/vm: update centos.aarch64 image to 9
>    tests/vm: remove plain centos image

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

