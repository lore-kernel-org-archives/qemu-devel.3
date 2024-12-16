Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812C7E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBKf-000665-Oy; Mon, 16 Dec 2024 08:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBKd-00065Z-E8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:40:19 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBKb-0003nU-KJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:40:19 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef7640e484so46780387b3.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734356406; x=1734961206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2vANnnaNjz2R71XowDCOG6EKd4B7F5XmlfphlyVhIWY=;
 b=BnQyWvA4sdI/M+M+YTUKEsDodLIY2iNOUT+FwJqLeKZkAIEYS8Nk+pYzJCIbZAMIb3
 Mts6FSVYdwmtTDS7DvqzbEFZ/xR8yvKJ+4fuH+op0d0o+j/em2zAHTYCw1ZFVopWCtn+
 61eB6EBWKMx0X5s/9FjlgoEV7S4485XINmAO7r/Rfui8EFp7bL5gP6JisXn5w6wUGOCu
 8hj6Q2H1IV4fsZ6tOVU4ryGai0ETJCF6TY6UuKBFkEWv2a/nWTn9cw6qcV4j70GK4wMe
 EdNLCfDDhyUKs+7q9xktU2poM5NRNNbypPh421X+BHLXRxYgNgLsQbxSTci5UUpSL0X2
 M+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734356406; x=1734961206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2vANnnaNjz2R71XowDCOG6EKd4B7F5XmlfphlyVhIWY=;
 b=Nq9KOalp1W2ijxk0CuppFTovQMFdpqqRinKf7Uy8U8fH0k90uKJBjlwrlN51SNFpa4
 sixMCGpDwNQRduFneI7BugeSyyBKZObLlwpSB1V9ZXZ9RVxge3zoYBmrV8ua6/RUGWBh
 MWZGgLnliDU9sQqTcd/RyDLB9SZtorXBPOsRK4/Y1Q8HeuJxzBrGVO2RpjanUl4tohjX
 T9WYD6FZhVwD4YEWjHsEygy9WiNekLb1GCCKTs4up/C9hLUkA0KkNUWoQxWPClI5dguM
 3W8FtpJo59Pd6yGoXWIuj5ZhRG8c5n9bFC6LczMQ96OMPDaJ6fAJ3FR/W09Y9OgYSRx+
 p6DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEMz9gTiw+wD4BSfqCHOnY5XgjRvvoCD5Q+kKlsBV3eU3z4LQ+oIyge8UNQ1JUbopC0n3h0czwaVIs@nongnu.org
X-Gm-Message-State: AOJu0Yx79KkmopbT9fOUVSFKgmNTUOBKvTrzVBhBVq/aIPaZXLgDABKO
 yMEsnwhULxcFp/5290CJkpaHH0T6YrfcWKv1DQ7BGS8l9EUvk1howO9fpPE3jy74j1H/Y+4PUNe
 kfNKyyVYivnQJWW/4ho0DBtDmdPPWNZ3byWVocw==
X-Gm-Gg: ASbGnctXU0ynzMNiChQU6yj62mQxs/boTKa4rku978gbHS6Er8IRHlPCdkgpn9QyI7g
 cCP0EdRlwomdKHcmLt6j3K9gyOjORf/TSrEwj9sA=
X-Google-Smtp-Source: AGHT+IHUoanIejV52iFNcx7cGLa26+c7uWq9EJLjMPAzgT7nGDYvqIUoRguxM76OaTzGd2fsEBlUbpMP5tXN9EEiKn0=
X-Received: by 2002:a05:690c:d92:b0:6ef:4696:f1cc with SMTP id
 00721157ae682-6f279b38a51mr95580347b3.22.1734356406227; Mon, 16 Dec 2024
 05:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20241213224020.2982578-1-nabihestefan@google.com>
In-Reply-To: <20241213224020.2982578-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 13:39:54 +0000
Message-ID: <CAFEAcA_MR86C5+jV9=uQsZZ905w7+OgHozfQZKYXx+=Xdv_xqw@mail.gmail.com>
Subject: Re: [PATCH v2] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 13 Dec 2024 at 22:40, Nabih Estefan <nabihestefan@google.com> wrote:
>
> V2: Removed scripts/meson-buildoptions.sh.tmp Extra file that slipped
> through the cracks and shouldn't be in this patch
>
> Recent CDMSK Watchdog changes (eff9dc5660fad3a610171c56a5ec3fada245e519)
> updated the CDMSK APB Watchdog to not free run out of reset. That led to
> this test failing since it never triggers the watchdog to start running.
> No watchdog running means that the timer and counter in the test cannot
> start, leading to failures in the assert statements throughout the test.
> Adding a reset and enable of the watchdog to the reset function solves
> this problem by enabling the watchdog and thus letting the timer and
> counter run as expected

I don't understand this. The watchdog on this board is not
an input to the timer/counter, so whether the watchdog is
running or not should not affect whether the timer and
counter can run. Something else must be going wrong.

> Also renaming the reset_counter_and_timer function since it now also
> affects the watchdog.
>
> To reproduce the failure at HEAD:
> ./configure --target-list=arm-softmmu
> make -j check-report-qtest-arm.junit.xml

This does not fail for me, and nor does running just the
single test case in a loop. (Tested on ubuntu 22.04 with
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0.)

thanks
-- PMM

