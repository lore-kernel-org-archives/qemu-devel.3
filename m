Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430BBCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 22:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTc0-0003gD-M3; Sat, 30 Aug 2025 17:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTbz-0003fg-9g
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:59:51 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTbx-0007vy-PK
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:59:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-324e6daaa39so3053139a91.0
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756591188; x=1757195988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KpBNOd1gjcJO1ux45Mtl8htnjkMz794eiQCdcH7eGLE=;
 b=l2nZbWeQuKXE5/HYZtnsHBCNK260/q0SvCBiEqr7vu/7sx29S3vnLZXA3rzseCvm9O
 cHZN+aDagTJi2TDw+0ZXkmtIKJ0Ur4sIZXVLMKJPRxBkMocUJFKI40lhaVuKVRfUOet6
 v4B4dC/QpI9BzAjgegqN4dRU3cSQNZCUSNwYdymXOf+BSqSzofIXwlDaDPkqN3qC9F4S
 TrH2imBTnuYqERgMwGFHSDr2wuBL4TrdQDmNOi0OQwJp4qagzwMdCPiIrd7DOcQxYdYP
 hI9nTGx6yMv3ZTknioFQi7xF313miIrfJAXGMmBUPPrvmLGf+aOWq6Vnjj2RaFetvg2Y
 mfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756591188; x=1757195988;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KpBNOd1gjcJO1ux45Mtl8htnjkMz794eiQCdcH7eGLE=;
 b=v+0rucdlTlBbcC/0nIzl0ZlYEPZTeXTGnjzx0CdgiNBWrH33ydlvYnlVjDwxFg9DoU
 tSl2TP10jNe6nYAo3ocehL04jLg49ADAu9DneGF3yesRFns00Ba7j2U6Vn1MbOdf6fPs
 GNquhB1ypA93BulFH8lfXi9gp79Cm4MfozF3q9B7JJpXVF5JJQqlUymvVqE9aHnKRxWe
 y/P8t1PWvKjFcmtzQVsWWNeErZnxygrqY1LYCqDxW7uEXHjLqbX79FOLd4Q5F7w7czMP
 RLUpsj0+mCp9bOakSR3kMmYeg0m3UsFxxq5pzMFBI4kwug5vokwKf4BuwXi3lgAjSC9H
 sQ0A==
X-Gm-Message-State: AOJu0YwictN1KNrPj5AQ81qxqu3SN79j2UIk3V2WMI2L71702inZXmf5
 DC+WChBCcTaeSqfRK5Lx4rhQ2KHCjT2Z+a1uckXrQPfZixY/lXMAoHy3ixs70gDr2OprpVh2c1G
 nevoDll0=
X-Gm-Gg: ASbGncsX3/ybQqsxtV84svoLh/CDxnoS/UBCFuBbamVPS9SzmCySQ/YriUH3wWTIRMU
 ItpONJ2SZw6rWVxEj0ltCCto50bxJSpvW+A1b6Q6ZS999s+5QnKEj8bi0GnJ20oP5REh3QC3yW4
 /Yc3rKvnLMleKcnrIGelBeKeufUF2yZYRcsGa/H/c8BjtmqA4Ezc3/lmmyhtbRj+0e5WEPhxQHN
 oiH617IMJMSG+rT4f67teH8D+Iqze4XlnlZjliFAIX5HPuflQwfIj+9xPrFkn0lmMtLyJ0Ys7HX
 cnYK7Tr3cNMy+ai642BT82M4Whs9gl8TCGPJl+pHhDRoAqpEAzHXDWBClQ+7LLxdKVRGbdeF2Yh
 XOOuPeidYSA7O5aQLvIZ2lcGoJS7KKT27DMmjFzIOlEjvpQLJJy/4HcAqGOTghuEzbacfBw==
X-Google-Smtp-Source: AGHT+IFLPmbLsbT/WgBNJd+9km1F2pYcrGdun+G2RDtxLtjxjhJEVWNYk8rNp3y+6WGM5x8cQTdSNA==
X-Received: by 2002:a17:90b:55c8:b0:327:dc81:b3a9 with SMTP id
 98e67ed59e1d1-32815437a2amr4565508a91.10.1756591187924; 
 Sat, 30 Aug 2025 14:59:47 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a5f7a9csm6070691b3a.91.2025.08.30.14.59.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 14:59:47 -0700 (PDT)
Message-ID: <93d905c1-3c1b-4aa8-a227-efeb661df972@linaro.org>
Date: Sun, 31 Aug 2025 07:59:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] system: unconditionally enable thread naming
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-4-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-4-berrange@redhat.com>
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> When thread naming was introduced years ago, it was disabled by
> default and put behind a command line flag:
> 
>    commit 8f480de0c91a18d550721f8d9af969ebfbda0793
>    Author: Dr. David Alan Gilbert<dgilbert@redhat.com>
>    Date:   Thu Jan 30 10:20:31 2014 +0000
> 
>      Add 'debug-threads' suboption to --name
> 
> This was done based on a concern that something might depend
> on the historical thread naming. Thread names, however, were
> never promised to be part of QEMU's public API. The defaults
> will vary across platforms, so no assumptions should ever be
> made about naming.
> 
> An opt-in behaviour is also unfortunately incompatible with
> RCU which creates its thread from an constructor function
> which is run before command line args are parsed. Thus the
> RCU thread lacks any name.
> 
> libvirt has unconditionally enabled debug-threads=yes on all
> VMs it creates for 10 years. Interestingly this DID expose a
> bug in libvirt, as it parsed/proc/$PID/stat and could not
> cope with a space in the thread name. This was a latent
> pre-existing bug in libvirt though, and not a part of QEMU's
> API.
> 
> Having thread names always available, will allow thread names
> to be included in error reports and log messags QEMU prints
> by default, which will improve ability to triage QEMU bugs.
> 
> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   docs/about/deprecated.rst |  7 +++++++
>   include/qemu/thread.h     |  1 -
>   system/vl.c               | 11 ++++++-----
>   util/qemu-thread-posix.c  | 18 +-----------------
>   util/qemu-thread-win32.c  | 27 ++++++---------------------
>   5 files changed, 20 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

