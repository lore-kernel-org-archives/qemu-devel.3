Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADBCC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmn4-0001WT-37; Thu, 13 Jun 2024 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sHmn2-0001V8-A9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:55:04 -0400
Received: from esa7.hc2706-39.iphmx.com ([216.71.137.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sHmmw-0005PX-DO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:55:04 -0400
X-CSE-ConnectionGUID: O8cTlx1hQMO3mlzqm2a0WQ==
X-CSE-MsgGUID: 0SK0OwzJSkGfNjDEB8B+ew==
X-IronPort-RemoteIP: 209.85.222.198
X-IronPort-MID: 370939764
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:CmtYe6AaCEFMKRVW/2Liw5YqxClBgxIJ4kV8jS/XYbTApDklhGcPy
 jAWUG7XaPaCazf1fYskYY7go0kHupXUz941TANkpHpgcSl2pJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+1HwdOGn9SQhvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYctitWia++3k
 YqaT/b3Zhn9i1aYDkpOs/jf8E0256yr0N8llgdWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ai87XBtJFAatko2zhc+RK9
 Tl4ncfYpTHFn0H7sL91vxFwS0mSNEDdkVPNCSHXXce7liUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwD2AGUhST3uKP5ZXgT+1+n8F5JZHUBdZK0p1g5Wmx4fcORJnCR+DT5oYd0m5h1oZBGvHRY
 8dfYj1qBPjCS0cXaxFHVdRkxr3u3yivG9FbgAv9Sa4f6mzDygBr+LLwdtfZZ7RmQO0OwR7J/
 TOZoTiR7hcybOe8kR2a4FCXhcDBuyHXdahCPv616as/6LGU7ilJYPEMbnOirPykz0KzRd9bA
 0oT/CUosO417kPDczXmdxixoXrBpx1FHtQJQr185waKxa7ZpQ2eAwDoUwJ8VTDvj+duLRRC6
 7NDt4iB6eBH2FFNdU+gyw==
IronPort-HdrOrdr: A9a23:qEliZqheYOrOA/vz1d6iK6nMV3BQXucji2hC6mlwRA09TyX4rb
 HJoB1/73WYtN9/YhAdcLy7WJVoOEmzyXct2/hoAV7AZniAhILLFvAG0WKK+VSJcBEWkNQttp
 uIG5ITNDSaNykfsS+V2njbLz7+qOPpzEjO7d2utktQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A5yjOgGhXVL4IjhDnsadQrvAMBjJuVS3W8HPAek+?=
 =?us-ascii?q?BLEEyTbmHUFrK8ftbqp87?=
X-Talos-MUID: 9a23:qq4E1wiIecWBh9k6KElNoMMpbPxLu4OxGmI2kroIncuoGAYgEXSQk2Hi
Received: from mail-qk1-f198.google.com ([209.85.222.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Jun 2024 11:54:54 -0400
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-797e08e5d9eso133502485a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1718294094; x=1718898894; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H/qCMwgn0nhGbT+NuzYYOoETEb1b8M8/gisRsLw1sYU=;
 b=F4Qkg8q1DOPWN1uzo4VVaAMnZ1iggfs70x2NxoDrNoJ975kgEFpbkaI4cHmsUUG5I3
 LgAOEDC7LrqhZm1Qfgr1pxsCtz+YUd9zTnBNd8JaaD0YTAr7tNOCRvP7DnDRKPGfEkuT
 8jG6C3zmymdfVwc/+a1jH1WD5bO5omvCFhox9LKRAqK/0dTxtVOlzDKd2OwYfW1uMTYM
 Or+bo8MA/irNYBBYdhNpCngx0U5QO482/lNLb260H/RxubvxuRILnPIgLbSrMMtqBtSR
 IOx7M2G7trkicRHHvWzneuNCqVTTjtnm+G0w80hmQai2SMBQpEOsgxs2mWyH9y+mVlgq
 z1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718294094; x=1718898894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/qCMwgn0nhGbT+NuzYYOoETEb1b8M8/gisRsLw1sYU=;
 b=hCawhoS3UgghX5FGAOcbsasZ+G9ft7iNDyBezLMhKViZsZjWOxTatI7AEQh+u3pke8
 haLVBzx/wxeEPJbmqCs/yOL1Z6oerXPOylI3LL4zZlE7uDuItvC3WU3nj2whZiDEzO8J
 tOlJXSTkhb+g2NgRkv523HLmuumHAOcqvfRQJFpUQI81sLkGemW97ty99UXkp6M4nINE
 pz3VLixsdXUX8gjSJNl3K0Z6P6TL0t2fZtZQoXc3X6Rx7kw6SjGGG3ZWFvdTni3PHCyv
 GOrajUj7G3QSvVOW+Uf4eibadpMhd2qanWUDSZKWcS99NV5mTiW/CHpAehmnGX3npTtO
 7ioQ==
X-Gm-Message-State: AOJu0YyaDVsmMMAuBRdIlrHX+h4eNA0b0E6zesJY/3gdS7pIGaC4SNkK
 lUmebSIRkjUu9sB7D/4w0v0etUcBF4h3WdXNkVCRHbOr+ojfNfSdabID4ZIUfOyv0FJf63T/bTs
 YOz7IPzIsEWs6xRFXd+bI5GvP8PRkaHtkAd8o4Zr700N6zNJbv693Gct+BF3wP+GStA==
X-Received: by 2002:a05:620a:4688:b0:795:47c6:79b1 with SMTP id
 af79cd13be357-797f602757amr518510685a.21.1718294093786; 
 Thu, 13 Jun 2024 08:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Q4Am5Nw00uHGHvjIKW1skZW6+ZRm9PtNnDp5grAnmf9Tx6zT0IXH+aJNGvwY4pgwYZuDiQ==
X-Received: by 2002:a05:620a:4688:b0:795:47c6:79b1 with SMTP id
 af79cd13be357-797f602757amr518508785a.21.1718294093343; 
 Thu, 13 Jun 2024 08:54:53 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc03812sm62532685a.93.2024.06.13.08.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:54:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:54:48 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] tests/qtest/fuzz/virtio_net_fuzz.c: fix
 virtio_net_fuzz_multi
Message-ID: <20240613155448.5m6zuv2idqbbpnf2@mozz.bu.edu>
References: <20240523102813.396750-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523102813.396750-2-frolov@swemel.ru>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.80; envelope-from=alxndr@bu.edu;
 helo=esa7.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

This fixes the almost-immediate timeout issue for me on the
virtio_net_fuzz target, but I'm not sure why this works or if it is
fixing the right problem:

qtest_probe_child is designed to run from a libqtest process which
uses waitpid on the PID of the child (qemu) process (stored in
QTestState->qemu_pid) . With qemu-fuzz we do not have a separate
libqtest and qemu process:

(gdb) p s->qemu_pid
$1 = 0

So we are calling waitpid with pid = 0. From the man-page:
"0 meaning wait for any child process whose process group ID is equal to
that of the calling process at the time of the call to waitpid()."

And we are calling it with WNOHANG. So I would expect that this almost
always returns 0 unless some adjacent thread has changed state
(libfuzzer uses extra threads to manage timeouts).

I'm happy that the fuzzer works again, and am happy to leave a review,
but I would like to first understand what the behavior of
qtest_probe_child here is, since it isn't really designed to work with
the fuzzer.

On 240523 1328, Dmitry Frolov wrote:
> If QTestState was already CLOSED due to error, calling qtest_clock_step()
> afterwards makes no sense and only raises false-crash with message:
> "assertion timer != NULL failed".
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> index e239875e3b..2f57a8ddd8 100644
> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> @@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
>          /* Run the main loop */
>          qtest_clock_step(s, 100);
>          flush_events(s);
> +        if (!qtest_probe_child(s)) {
> +            return;
> +        }
>  
>          /* Wait on used descriptors */
>          if (check_used && !vqa.rx) {
> -- 
> 2.43.0
> 

