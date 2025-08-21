Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3828CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4nI-00048h-06; Thu, 21 Aug 2025 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1up4nE-00047v-HJ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:53:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1up4nA-0001YB-8r
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:53:22 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B3DD3F7BA
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755780796;
 bh=apBKgYCZDlYFOgxJyo5Iec9QoGpeogEx6tEmk7Fpshk=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=G6BqtxswczeiaxpgSTRz1VAZi/BSmQV44ZUrFoBgrJ4IfECqOaqpnvVQoCJhpgnit
 OkVX3M0bnFuq3mwwsJBmWVpohtTTcG2N1dWs1Wi28lyNCSm6sRqXflagSKX5ASXr4S
 xkwT1CZbfZU2NknZnmuUNZFytcE9edjusIPgJMwYk4mSY3J/GkaNoxHdD+Ygc3SZwr
 QKUUx4pB/SL3nYVAu4b//F3MRiWWG7bLBffLF6tcuK11288xDmPm+hge6tpoAM8Ehe
 T0eES9NJBuEINE+qYYCD8hOt2CwamlIqaXmMQXeBw0RNBqOc6ekQb9l1DrASX/p7Ml
 iHbMlgRoqGQ0g==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-618bc9102a3so1314410a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 05:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755780795; x=1756385595;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=apBKgYCZDlYFOgxJyo5Iec9QoGpeogEx6tEmk7Fpshk=;
 b=TT6vVKxex1A7y5yJnz0kqa064QWYh5ZEheYf+vkqE0jUVSDp7Q45HEisyh9TbzSWQA
 QAokjOjh9p0JQb+EdwzDYvAw229kPEIpmg4hWx59xBmQjAvU6NG4rtTK2YLwBHCBf1x9
 Ky0rmUyEtDW5PiseSX8m1y6dVGzwZcm7I2UOBM82lW8gQCrf61Etc13Jk4hI73nk7VEa
 lfX3rytzEx4ZiZ5KoxFc/wGuMdwaBr2JFfOm2kQWIOCcuXisfMfPob0/odhIcREVrhnr
 QJct75rT2be1mjaiFGJFT7E8UvmKQv7J/RxHspVmgXhiMKZOXGZ35eIPxjYBirNaP3LV
 YmmA==
X-Gm-Message-State: AOJu0YwiOk4pCn1E2LmIDC0x7AgsAGsdeO+BriD5FxyqL99QBTbyLX5v
 qykAxnD0vdYZhtd9W8cs5z72LtpXybaqgq9KHg2CNqgxjpF8etybH/WbMO9dksHwUuzRf2IAEZE
 8Zi6tpmNrvOVqa/cv+eI/mMdLhqlkxo6kylrMbWUISeMsqIfeVg0i6QwVQCVzZMRv3OTVtg8+1Y
 gYIFzX+zD50itE6v6cOUCXRn2RUPbHHkeYX420xnxQNekCKRIKLR1ED/TjSg==
X-Gm-Gg: ASbGncteYTlnHAwNlTgRTIp2Afv0EMtxjduKeFmIz5uhBpEdo4SWeq0dO1ZzD56DlD3
 sVKyjP21q7EpkXMvn1Dk9/S4pIkjOKuYRxTu9X5gA4VrWvqVTtcdMXedopjsK93AwC+mO5djnBA
 dUYE58AONvOeWDqkYzQDWW
X-Received: by 2002:a05:6402:42cf:b0:615:77cf:782e with SMTP id
 4fb4d7f45d1cf-61bf8734a31mr1937944a12.25.1755780795305; 
 Thu, 21 Aug 2025 05:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvWoEXrF8lRePdYlexNo1pf7YxBhQ141Ez1F48TYXCJxARPD90XMJ7SLabZNuiFQSzh3jK4giTTPanKv/HS1k=
X-Received: by 2002:a05:6402:42cf:b0:615:77cf:782e with SMTP id
 4fb4d7f45d1cf-61bf8734a31mr1937931a12.25.1755780794832; Thu, 21 Aug 2025
 05:53:14 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 21 Aug 2025 14:52:46 +0200
X-Gm-Features: Ac12FXy3RCMc8ooDS5qSIrAA5WE82HhcO_YJ-_I7ejs5gCnWjisSqqi_jGUeRpU
Message-ID: <CAATJJ0K6coKjwwmkzaWP7dzQHLsEoL3rkU95T69rxZ6fdbnXqg@mail.gmail.com>
Subject: snek testsuite breaks in 10.1 for qemu-system-arm on armhf
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Hi,
Debian and Ubuntu run the self tests of snek as integration tests like:

`make SNEK_NATIVE=/usr/bin/snek SNEK_ARM=/usr/share/snek/snek-arm
SNEK_RISCV=/usr/share/snek/snek-riscv -C test check`

Those tests recently generated signal by failing in the arm emulation
tests with `qemu-system-arm` - full log [1].

```
224s Running test pass-precedence.py.
224s     pass python3
224s     pass snek
224s pass-precedence.py:72 Syntax error at "".
224s     ***************** snek-arm fail *********************
224s     pass snek-riscv
```

14 tests failed, but all with quite similar signatures.

But that only happens when executed on armhf, the other host
architectures are all happy [2].

I've separated the test and ran a git bisect on qemu 10.0 -> 10.1 as
somewhere here is the trigger.
That worked fine and identified this change [3].

I must admit, I was able to debug it until here, but I can't see how
these snek test failures could be caused by that change.
And yes - arm emulation on an armhf platform isn't the most common scenario.

I can't predict if there is anything wrong in snek which now is
treated differently by qemu to trigger this or if snek is all fine and
qemu broken something - Therefore I've also reported it to snek [4].

The tracking of the initial finding in Ubuntu is here if you want to
see more about how this commit was identified [5].

[1]: https://autopkgtest.ubuntu.com/results/autopkgtest-questing/questing/armhf/s/snek/20250818_045020_246a4@/log.gz
[2]: https://autopkgtest.ubuntu.com/packages/s/snek
[3]: https://salsa.debian.org/qemu-team/qemu/-/commit/cf4905c03135f1181e86c618426f8d6c703b38c0
[4]: https://github.com/keith-packard/snek/issues/103
[5]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2121124

-- 
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

