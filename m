Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EDBCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 17:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx8sG-0002Qd-Vz; Sat, 05 Oct 2024 13:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx8sD-0002QD-5Q
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:47:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx8sB-0004rt-KX
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:47:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71dfc250001so143096b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728150438; x=1728755238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cPH4gjq4SfezuM2/RZc/QQ/tTqwRYbBXc/s3lmpCqls=;
 b=aZorkpnstmvC7TmBvrIo1SNuaDtWL4TYiskYZSE9wUp70/3LfhMs8D8uD6Qa0C8PnO
 3iKFWHsU0qtZ/Fj6xFrp9P4nbK6RTDm/AtArsikXT1reppNP5oeB9VuLPPtvjWeKEuIV
 RhqDYlo0ECB7J+3VODBirQ1Tw3QR+c31/3NlkVXvGp8TVyq9rwLOrtXC2Hlll3CNDWKE
 nEKFAKsk4yMLoYo2Xsc5IN1CUFcbBVTdQGZHgLqgJWwzrQmSkjUOO82DgSAtBQTLvHHH
 g9BXkov0kfEt9Da9kUuvNeEEwUJ58Bkjd0EGvwmQVDRB3DEEDoUP+uYBIc7WdFKCiOv3
 ZU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728150438; x=1728755238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cPH4gjq4SfezuM2/RZc/QQ/tTqwRYbBXc/s3lmpCqls=;
 b=thkY5U9QylziebTxAhd2s5P7QWNTTFjexax8eivaBsswGt3ZxUQjSAIKsn2pv4PXGd
 RbysNW5Zgea43L0BGJo1Nhzy3eAzH2r7TlbgFXlWTrMfEu1vk3CUsSFbW2Hj1A+Gjb+r
 5C3IW/9pbUpukbPopDPq+tNf6zfi1rQlAR1PvIR1qqbYKOFWpxH3B82NLX81GWPO/69g
 /qptbmVuKv4NFyH9Jzq5gy4WyTNnt1bXI2/DizWrZ7rev/BlK9eMd8M4QpycfbNLm35S
 v8uid7XpvO0DTEVM0vDng/kUO8fi7YxjN8fkiWT6z2sHP32z3YTPiaCQzAJXQhdSnbsG
 4PtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4YF5Sn1HxP8GAGvtqAkYdj8Bu6VBuDeDbofE+G3jP1FBWoLI23xSEiZ4yW0UoySagjlSWlYgw35lS@nongnu.org
X-Gm-Message-State: AOJu0Ywg4m8Mx+pM7TBbwiFfqr1NY8N80GhEW+6gm20Z9PLWnOKWN71o
 xvrxd62qcqzDe/i20p/nFSelIqpCinwn+6oryvTOfc1+M/xECbY5g7qx5Sl8CtU=
X-Google-Smtp-Source: AGHT+IHCccVMfHIst9Y+BRkfglv/USfmE4CECryAZduIuzY7u761A1349bnW3yQXt5eye2W8YKSiVQ==
X-Received: by 2002:a05:6a20:c89b:b0:1d4:4a69:a0dc with SMTP id
 adf61e73a8af0-1d6dfabc6c0mr7949625637.33.1728150438157; 
 Sat, 05 Oct 2024 10:47:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f68320ffsm1990114a12.46.2024.10.05.10.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 10:47:17 -0700 (PDT)
Message-ID: <451700d5-de4b-4542-9deb-007a02f8f871@linaro.org>
Date: Sat, 5 Oct 2024 10:47:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] linux-user: add openat2 support in linux-user
To: Michael Vogt <mvogt@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>, Laurent Vivier <laurent@vivier.eu>
References: <cover.1727795334.git.mvogt@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1727795334.git.mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/1/24 08:14, Michael Vogt wrote:
> This is v9 of the openat2 support in linux-user. Thanks to Laurent for
> spotting another missing tswap64() in v8 (and my appologies that I
> overlooked this).
> 
> 
> Looking forward to your feedback/ideas!
> 
> Thanks,
>   Michael
> 
> v8 -> v9
> - use "tswap64()" in strace.c for how.{flags,mode,resolve}

I added braces around the expanded structure in strace.
This is similar to how strace(3) renders structures.

Queued!


r~

