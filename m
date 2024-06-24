Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DB7C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 18:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLort-0005Hy-He; Mon, 24 Jun 2024 14:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLorr-0005Hi-Bv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:56:43 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLorm-0006T9-DG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:56:43 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7201cb6cae1so497643a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719255396; x=1719860196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eK+nyDUrjRa/9+1t/ZlLWR8uR05p5Ck9krOPq5DDAbw=;
 b=gcgJB9DLZrLqtGa/226QslZhyDITGyl4ym+ZUr5mW4CiTL5XujZ8MHmr5nwbjWH7id
 7RZDOM0YntdAAjiLVunJug03K8lMzKDwCc47cIyn317BKB7py7nMqNZIoUpuCKA5iaaK
 +GDz+Yk2bCaV9A/EgiRznojMR/iSDliMfwZCske0qz9HahvKF1DJHOS/xw9bnpCMzc2o
 N1/f9TRvCxszcC6vlPn6tJ/OFjR+QFws3SqCBHZnLkViMlErIW7AWlbEf6r+QhFMXcOP
 qw6Bc+x5ZSjeYa3gQcwvO2ty9u5d/n24bMvx+E6zGowq5zh95+CNQIVA4BtxlI2oB1ZI
 e/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719255396; x=1719860196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eK+nyDUrjRa/9+1t/ZlLWR8uR05p5Ck9krOPq5DDAbw=;
 b=hb1DzyJj3B3LMxRTz3LNSirYhy2bQGz7X7Ws4D/uhYkclQhks8LojFce7lh1jKi5N/
 fJmXyFf8ur+kd3tWuv3Tm2DHRlQX7ovietkiKTCGuT19kEZTSXMxe3rLFd7+mtJljRmK
 PpuyE5Ux+ozlv3m/Lzk4iNMxO4tSVflPJ0jCeDnQqve4AGtLUDADmYWoCmgXOLBjMuva
 ifrQyguq2FIrpf//v0X6XY1TSfQ2zwskSjFKcyqgqkXfD/ew3A3cnPIWx6DfaU/pi7Rw
 1mPWdUo08k96pYvAZI4SBjuZTNKyt6VuZgKlpfsVhVCumypXFvORStrQPvcSk6fXS2db
 zgYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBBtQfHzzKe5lT46Bzah5RZWdH39A+vEAJoodknZ0EVFszUClv1a+ifOxfVksFB0ObWye2RxxtSAs+8p1DoCMKYzP6V24=
X-Gm-Message-State: AOJu0YzT+p4+t4wV7jxCL/kcM9NH8AqyHkTQh39Xs92Y6TY9Btr2uztM
 INybcRtlOG/+lofe8l52gIs87F+KEH3PIAl/79Un7/eQ2R2XMKNeF0oTTZgCiNA=
X-Google-Smtp-Source: AGHT+IFTJPSpUertnuOuGf+340RMxHoyFrn3wWVhFumhajsHZe01khLCZGKQLZs0Ub9zxfDMxuFfAg==
X-Received: by 2002:a17:90a:3ee4:b0:2c7:af7e:dd46 with SMTP id
 98e67ed59e1d1-2c8582dba44mr3839309a91.44.1719255396238; 
 Mon, 24 Jun 2024 11:56:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a79ff4sm7104180a91.17.2024.06.24.11.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 11:56:35 -0700 (PDT)
Message-ID: <8cc1dcc6-22b9-4b6d-bd1b-863f37868656@linaro.org>
Date: Mon, 24 Jun 2024 11:56:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/23] Misc changes for 2024-06-22
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240624135939.632257-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240624135939.632257-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/24/24 06:59, Paolo Bonzini wrote:
> The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:
> 
>    Merge tag 'pull-target-arm-20240622' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-06-22 09:56:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 0753fbb4750ad6709c43b4263c3d29b00f7cd0bb:
> 
>    exec: don't use void* in pointer arithmetic in headers (2024-06-24 09:17:16 +0200)
> 
> ----------------------------------------------------------------
> * configure: detect --cpu=mipsisa64r6
> * target/i386: decode address before going back to translate.c
> * meson: allow configuring the x86-64 baseline
> * meson: remove dead optimization option
> * exec: small changes to allow compilation with C++ in Android emulator

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7174394076
https://gitlab.com/qemu-project/qemu/-/jobs/7174394063
https://gitlab.com/qemu-project/qemu/-/jobs/7174394088


r~

