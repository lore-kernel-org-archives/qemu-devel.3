Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFF4C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWY2-0007cK-Kw; Thu, 04 Jul 2024 20:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sPWY0-0007Za-I1
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:11:32 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sPWXz-0003mb-2j
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:11:32 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-700cc97b220so563890a34.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720138290; x=1720743090; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXXMZYJxG+2kac9nslse7DqcnNMW1WMLzQI5zO4YJ7A=;
 b=mR1d0mLg85Vl36NHRSL65WNYZ94G4RwYcOQoK1TJhLwj6en/zCFHcvksPHU+OiJRh4
 19lFL6GpZkRXKekuNmYdGnJ2WKMyopahp7gA2O7xBxPF9dpHjEndfM2IBfrQSHdyLWgp
 VRCHBEcs6LKBJVWP4GrPRy44dmZg7d6Of9Ud0c9uanaeFDaYFVh6uUlYdkTKpB1X6ZOj
 4Nrb9PZ7bjDB94ASIsqJYUWz/C4bot8zoQpsw5qmAeZbWe7Ifa5Nvji2LGDZNMzHGggR
 2JDNgLLlDskXLG6USgkHaeuOvBjqi9KFM0cM3roWHJnX3f0r8u0A5zMsMeTWNV2IOyxb
 zVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720138290; x=1720743090;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LXXMZYJxG+2kac9nslse7DqcnNMW1WMLzQI5zO4YJ7A=;
 b=Mrf0hBuDn1w0BRiUp4lW+YFlas3gF8e+SuhjM5caYrAYWurB3YB8YUNNWPw6brh59z
 JLrvNlcqiKk9nwYA97fXpO15CQrm/VprTvKWb1w7cxAUjOf1T+x9c3sZsgT2teHBB2+c
 cIWlJxGJyKdAadYeTiLERUXLzNZxoqaReVpPqD2JNCFGM1i1tuACt1cTLEMPkrFwEaYc
 gHVfO/dqXipqqcgVCtgL/XX54lZfa+aYzPfCEMxSiiG3S74ZKBr9Z0nXhxAPosPXU63b
 5HyQiK/hnoYeLHa4tWEAmNSpfmX+FiZsaNZhIIuJu5g2WGH2PCOwpxibP26GoQNFev/c
 FMhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO+eZmA3y3juW4bXh802nwymiK/3hp9jNjIKEOEUXgNkS5U5AYqT7xa4ev7wz1H9vLLpcMGzNsBAnDOObFKgjNf0dddcc=
X-Gm-Message-State: AOJu0Yxe+fodVxhIcGBLLqOfm6kGpu18AqnmvHjjngDUNxS0bZynxsuQ
 0YGUT1xfWStGv61/dEuXKrX4+trRTugww4V4nq3iA5t3EQu3PfhM
X-Google-Smtp-Source: AGHT+IG+B6T1XCqEa7DMTuRF4IbBDkNo1YS3Ku2/I8cU+pcxHSMyilLM7m8dcrFwqYmd/YE1TZHzBw==
X-Received: by 2002:a05:6830:1d47:b0:700:9657:de8c with SMTP id
 46e09a7af769-7034a76a36amr3142102a34.14.1720138289544; 
 Thu, 04 Jul 2024 17:11:29 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c69b54d31sm10094399a12.19.2024.07.04.17.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 17:11:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 10:11:24 +1000
Message-Id: <D2H64QRBPW25.2EAZ540HEHA4H@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>, "Richard
 Henderson" <richard.henderson@linaro.org>
Cc: "Prasad Pandit" <pjp@fedoraproject.org>
Subject: Re: [PULL 02/12] tests/qtest/migration-test: enable on s390x with TCG
X-Mailer: aerc 0.17.0
References: <20240702103310.347201-1-thuth@redhat.com>
 <20240702103310.347201-3-thuth@redhat.com>
 <D2GPQVG9Q7RY.1HUJR9EC96HWC@gmail.com>
 <db14e63e-3a86-4173-b4f6-cd469a511f10@redhat.com>
In-Reply-To: <db14e63e-3a86-4173-b4f6-cd469a511f10@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jul 4, 2024 at 9:48 PM AEST, Thomas Huth wrote:
> On 04/07/2024 13.20, Nicholas Piggin wrote:
> > On Tue Jul 2, 2024 at 8:33 PM AEST, Thomas Huth wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >>
> >> s390x with TCG is more stable now. Enable it.
> >=20
> > Ah, you did a more complete version of my flic fix that migrates all th=
e
> > state. I didn't see that go by but yeah I suspect that was probably the
> > correct thing to do. Thanks for that.
>
> Drat, seems like I forgot to CC: you on that patch, sorry for that, that =
was=20
> by accident and certainly not on purpose :-(

Ah that's fine I was leaving it for s390x people as I said, and
you're s390x people :)

> > Should the s390x flic migrate fix could be got to stable, perhaps?
>
> We need a new machine type for enabling the fix, so it does not make much=
=20
> sense on stable, unfortunately.

Okay.

> > There's some kvm-unit-tests s390x migration tests that can be enabled
> > after the fix too don't forget.
>
> Right, I'll try to remember to enable it once QEMU 9.1 has been released.

Great.

Thanks,
Nick

