Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9018CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 08:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwGQh-00081k-5m; Wed, 10 Sep 2025 04:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uwGQe-00081E-Ct
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:43:48 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uwGQX-0001GE-5S
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:43:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso6099103a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757493817; x=1758098617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ww8TBYaHpdqpB4vVxgYrbfF4ro1OCvfUEnwzXDhof8U=;
 b=q9hghzrSaCd++NJj+jVcEBunQxZxQq6njxN0XjfaV4RYWJziWo0RRSc3u2E/KhUHPq
 Kn7PHzW7QMA7kgQEx1Duo/KiJAKag9vQp432bych/tXxD4AYB5I3vswawiTVrxgMXsg3
 qmgkspLS8sHW5J9APZD64p5OrRD9xqMZu2KXHQyn1kg59+00COm6TumdIDi9GhE7soQn
 XqTk/RjZHav11gZNDe5t+3o2wOikEICGYb+dYMndVl1gaml7G5P694w0HZZ85KQyUxC+
 kPXvB8PKMhQ8WvtLzgbWhDdm1K4CjZiAZemFZLdk8XCqs0C36imCTkQeOdMS9Gxp3ATx
 cxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757493817; x=1758098617;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ww8TBYaHpdqpB4vVxgYrbfF4ro1OCvfUEnwzXDhof8U=;
 b=bpVn/xiFetqEdPGep8oTMu7m6RaFipwxNw9miWbc4LIbyT1d6KOkaxshdYapl57qxq
 iYR5MsqjZuR9HyW5H7YvOAOYir3fdJh2SD3Sic1CgSGoYmtI8vsBL8ORIlJYnOTEqMe3
 K4CzN6dFsVCfSRXVE6ddrQSJtFA08sVJKEqWCidFt+zow/nuOSi1m5CCKNH/ZkMXGWPw
 zAZ4Y8gPC9fKWG7ITizNx5DCIvVJKkWQ/9ZedB8aui0xjSnAvqCVxgB9mhsnlqcGsWrc
 hUrGRthcXgzJtD9fbV5zP+oeFHXBCnam3SyLgEDK5jKK8BSJlrvhVWWCT9y12in+RnOh
 Y62g==
X-Gm-Message-State: AOJu0YyOLDSv1TnT6Yf/yPPbPANNCCTcHKW4Sso7XZ1gdRdSkRfiM9P9
 ZkF+X6Bkt6bEqFieWg04DK82EzarH4B5fAJslR4fORZgH71OMIbC32H8Gyf3F8qlIj09cEZyPTL
 7tBLzU7U=
X-Gm-Gg: ASbGncuVww1Bk+MkzCq/ibHVYSbyjDxO1H/V9hL/fNPAAQjMYGnoUeKQq/e81ri9R+W
 DHw57DchVsC13N1l04LomA92RKphtAx0qr2Ww8BLUsUqwJ8C9XoJpO6bP4JxysW/bh2nGlkZikG
 JKJP8EXSdY1oL5GVhW3469ui2MMeiBXJFxBueEk/MvT53OPwO2QV9sBEZez3Y/MoCQmS93G+MWI
 vfzamPCx3qSGUHKV/mdAfBZ0lMGaKmI7oWoAX51oUrrrQXsNGWyrvLj79k7MnwsN/SpoV9kGMWQ
 CaSLJakTqeL9egPYxykrUoDU7h60MvUB4vYAKkvOc3MC5mTAKWCH4NFKeX8cx750y6S5eN7ztCs
 Knb3541p4hYhPp2JtI+6wVaI=
X-Google-Smtp-Source: AGHT+IHehCckBB5uO6SLHw4HTqXYGMmIzgkdVLZt2KQOsXJ5sk8154mic7VsPuog3MPge2FtGFg+9A==
X-Received: by 2002:a05:6402:5110:b0:627:5841:7ae1 with SMTP id
 4fb4d7f45d1cf-62758417d89mr11176701a12.21.1757493817463; 
 Wed, 10 Sep 2025 01:43:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62c01bdb952sm2888798a12.52.2025.09.10.01.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 01:43:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91A295F82D;
 Wed, 10 Sep 2025 09:43:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Arkadiusz Marud <a.marud@post.pl>
Cc: qemu-devel@nongnu.org
Subject: Re: Question: ThreadSanitizer support in QEMU user-mode
In-Reply-To: <CB3C08B0-0B52-4C27-89CF-8621B2A9E0E3@post.pl> (Arkadiusz Marud's
 message of "Wed, 10 Sep 2025 08:45:04 +0200")
References: <CB3C08B0-0B52-4C27-89CF-8621B2A9E0E3@post.pl>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 09:43:35 +0100
Message-ID: <87348u7l54.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Arkadiusz Marud <a.marud@post.pl> writes:

> Hi all,=20
>
> I am experimenting with running a C++ project built with ThreadSanitizer =
(TSAN) under QEMU.
> The documentation describes TSAN usage in system-mode (qemu-system-x86_64=
) with --enable-tsan,
> but I couldn=E2=80=99t find any reference to support in user-mode (qemu-x=
86_64).=20=20
>
> Does QEMU user-mode support running TSAN-instrumented binaries, or is
> TSAN available only in system-mode builds?

I don't think the compiler cares and our TSAN helpers are mode agnostic.
However there may be some fork/thread things that it can't track.

>
> Thanks in advance for clarification,=20=20
> Arek

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

