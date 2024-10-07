Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3F8CFB443
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxo1r-00074d-0u; Mon, 07 Oct 2024 09:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxo1o-00074N-RG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:44:00 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxo1m-0004u7-JG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:44:00 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2facaa16826so38279091fa.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728308635; x=1728913435; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hRKnH+GxMI/pnGkUrmSW2Za4+scqiueWs1vVnch9jTA=;
 b=AAgVVcyh0WwfkV5gbQ7YgpRTxtpFlyNa1jjqNyqV+6zLpf4oLvIRahYxgbqG8k1MsS
 TLgdE7yTL62cU7sVJv7uu7qGlTbbGthzUnlFpMiGPkHzuTxhqFsD6S+upnB2l/igiGlT
 cpLeiGBnAKyDOMhDyPFVOGs9WwWLfeuFbeeDsj+AGK9fdKdDmT4aZSgCIYv3ZOQPyn3g
 SNhUZDFx1o3HxufC8v9YU7rA2JJ9EY21e/1usd5/uDBwBcRCHeBjGsBdyvVuX/Y5XlgD
 U/KwHggRPMtyg5u29N+wLwffKTG/zT42koZIRLD6nfvncBDGo7ZV/24jjtQBGiDn7E78
 XHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728308635; x=1728913435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hRKnH+GxMI/pnGkUrmSW2Za4+scqiueWs1vVnch9jTA=;
 b=uX8kmWrJO1gQ/EBZU3hVWQ8/od2KTW546tF+ma/oUFO1RtLzSLQ0pf2KbwWZxm1OC8
 +Xrx7pxKdJO03IusU0taEmlMbuqmzzC6FS4LPOgkUCtCq7Whk7Ld4jLAFZhN7K4JpdUe
 3UZFTb421cPuVpU1YO3igQd3lPFOKaqgeK9ut6hz+Mv6IfG0AjDzzF9qSis89BcH5tLb
 fi6IJUSIxIzA8g2ZWQx6DkAr87iC/5S9HrFU5LU8UjEb02hmpCQbqhZDhKhFRDQyDVsR
 +LZ3JXayfwWeThUWL0aQXuHsrauHOp0PxK5lUxS9/egDHJM1GMjBbgFi+mZSYT11wTUw
 I9CQ==
X-Gm-Message-State: AOJu0YwIiqzozwpEBHhFzQyqWLKo3JGz8igWQ4bxBqxTKubLzTDCSO/9
 G7XZRJnwdgQC4uaz1eksOIgXxVVWUNsSmvruWXuKsXQuTGUTn4nlcW1Py2nB6V3e8TbQJTTuG66
 jFi2GZrJs+l3WdcvYWulUV2DUDCF+tcQUITXrtybu8TPlsOMb
X-Google-Smtp-Source: AGHT+IFx31Y5SU3tVca4HZdpRuFkDooD3a2naOplDZoPICchZWnVFKdbFuLuR9v6LLgptwcNKbmR6Z7SiJZ2PvowtWM=
X-Received: by 2002:a2e:8488:0:b0:2f6:5fa7:2640 with SMTP id
 38308e7fff4ca-2faf3d75bbbmr45331691fa.34.1728308635093; Mon, 07 Oct 2024
 06:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241007115027.243425-1-thuth@redhat.com>
In-Reply-To: <20241007115027.243425-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2024 14:43:43 +0100
Message-ID: <CAFEAcA8C1K5jXvSAf_DpSFDDzj-hDSuduCsuyLa5N2M1Vu0_kQ@mail.gmail.com>
Subject: Re: [PULL 00/12] CI fixes and various clean-ups
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Mon, 7 Oct 2024 at 12:50, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-07
>
> for you to fetch changes up to d841f720c98475c0f67695d99f27794bde69ed6e:
>
>   tests/functional: Bump timeout of some tests (2024-10-07 13:21:41 +0200)
>
> ----------------------------------------------------------------
> * Mark "gluster" support as deprecated
> * Update CI to use macOS 14 instead of 13, and add a macOS 15 job
> * Use gitlab mirror for advent calendar test images (seems more stable)
> * Bump timeouts of some tests
> * Remove CRIS disassembler
> * Some m68k and s390x cleanups with regards to load and store APIs
>
> ----------------------------------------------------------------

This suggests it's moving back to the gitlab mirror for the
advent calendar tests, but one CI test still failed trying
to access http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
and getting a 503 from it:

  https://gitlab.com/qemu-project/qemu/-/jobs/8009902301

The clang-system test also hit a couple of timeouts:
  https://gitlab.com/qemu-project/qemu/-/jobs/8009902206

61/109 qemu:qtest+qtest-alpha / qtest-alpha/qmp-cmd-test
  TIMEOUT 60.10s killed by signal 15 SIGTERM
93/109 qemu:qtest+qtest-arm / qtest-arm/qmp-cmd-test
  TIMEOUT 60.04s killed by signal 15 SIGTERM

which are presumably pre-existing intermittents, but I
mention them here just FYI. Some of the other qmp-cmd-test
runs in that job also came close to timing out:

102/109 qemu:qtest+qtest-m68k / qtest-m68k/qmp-cmd-test OK 56.56s 65
subtests passed
105/109 qemu:qtest+qtest-mips64 / qtest-mips64/qmp-cmd-test OK 53.74s
65 subtests passed
106/109 qemu:qtest+qtest-s390x / qtest-s390x/qmp-cmd-test OK 45.48s 65
subtests passed

so maybe we should add it to slow_tests with a 120s
timeout...

thanks
-- PMM

