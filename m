Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0545C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPyF-0001xF-Db; Mon, 29 Jan 2024 06:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUPyD-0001qq-2E
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:38:33 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUPyA-0002lO-UV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:38:32 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so3157909a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706528309; x=1707133109; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FYuYnvv5ATwPfPNW6Y7WG2GH0c3ngYPYkwU/wu4yKSE=;
 b=dc1pyoKNim5s5iaWMUrbq+YdEfUjuUZRWtPQlL3+bVDEGlSW+rSoO+mO0tcq7SfF26
 uFeiBxSYK3OufqWjHSKqL0G5F0gm9ZdnBsN3B7OmEiaZVjacxLnHmEMR6gdUvrvpa7YS
 KxyWq3UxKcvaFmO4BLvLfexRsKqBZlebb4Ka9vb+rvlosi/L1a6FwaAv106ufLHDsQJN
 inuBX6vLLmI43Ia9LDA3qC2Ba7OjnQyKBZaf78ilbeIYFSjtI/b1zgLo6Eh9EWsqSFTE
 Pjz1IulXxaF7I7Vc4DVSmm+M9HKaQKWVvFIS1UFVSEagAsNBAIvDkPxBzJ2x+HuIKsY1
 elmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706528309; x=1707133109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FYuYnvv5ATwPfPNW6Y7WG2GH0c3ngYPYkwU/wu4yKSE=;
 b=lEz583PAjqLCyhEPRMDIY9Oe3rs6+GnkcmsfIOzN36hdDGWIe3rvP59bW0xzhLOBPu
 llEcoIa95LwIwoskNtQ4t8SI+VQEeIuiZT3nUUHYDxPov4LDzaO54vyrtub8kaEu3i5t
 mfsvEVUTrWR7WqrsRw7l5vQPgxt1TPYjn8kcbvVG5Fcnod67EE6TkpoYTijblMmLCAeV
 t+8lk3JwBHgm9QZoT15PPzlFdOUP6fVg2CdvKE2VcdOaseYGEjtgVgjK3MzHJj2ZTW2e
 nJ0Q+opuq2CPSBzi+H+Me20xpxoZ2iyUR7VQQBM6e7LFLm9u+phZ0K8TAJ9E06apKodF
 Tvnw==
X-Gm-Message-State: AOJu0YwEHvDV+Y4d5U++BEjnYDju5VnSmgH4R/yUZzyod9GJxa5mY+vx
 SSN1GzbTtGbz5Dc53c3vaVVgUlZYUy+ulVT44JWH03YbXy5Dv5KSdMVq5buK2ffYKCi6xFvKluF
 oDKl5ftQaAIo5UdoG35dkH28Kc3qZfTPYAo4S3A==
X-Google-Smtp-Source: AGHT+IFju2qwTjbqnF/NBGN7ayq+nKdzSdkhoyCNM6p3/gtc2kIu3HDScpRf/Pg/AF8Dd0a5tyfJGvTcMhJItWC6NCE=
X-Received: by 2002:a05:6402:5245:b0:55e:ece1:4a16 with SMTP id
 t5-20020a056402524500b0055eece14a16mr2758914edd.17.1706528309013; Mon, 29 Jan
 2024 03:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20240116190042.1363717-1-stefanha@redhat.com>
In-Reply-To: <20240116190042.1363717-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 11:38:18 +0000
Message-ID: <CAFEAcA-A-7H7nb++fkCr1O-aCt_U3JzrF_9=Sxp2Mg+kCWD_-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] monitor: only run coroutine commands in
 qemu_aio_context
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org, 
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Jan 2024 at 19:01, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Several bugs have been reported related to how QMP commands are rescheduled in
> qemu_aio_context:
> - https://gitlab.com/qemu-project/qemu/-/issues/1933
> - https://issues.redhat.com/browse/RHEL-17369
> - https://bugzilla.redhat.com/show_bug.cgi?id=2215192
> - https://bugzilla.redhat.com/show_bug.cgi?id=2214985
>
> The first instance of the bug interacted with drain_call_rcu() temporarily
> dropping the BQL and resulted in vCPU threads entering device emulation code
> simultaneously (something that should never happen). I set out to make
> drain_call_rcu() safe to use in this environment, but Paolo and Kevin discussed
> the possibility of avoiding rescheduling the monitor_qmp_dispatcher_co()
> coroutine for non-coroutine commands. This would prevent monitor commands from
> running during vCPU thread aio_poll() entirely and addresses the root cause.
>
> This patch series implements this idea. qemu-iotests is sensitive to the exact
> order in which QMP events and responses are emitted. Running QMP handlers in
> the iohandler AioContext causes some QMP events to be ordered differently than
> before. It is therefore necessary to adjust the reference output in many test
> cases. The actual QMP code change is small and everything else is just to make
> qemu-iotests happy.

Hi; we have a suspicion that this change has resulted in a flaky-CI
test: iotest-144 sometimes fails, apparently because a "return"
result from QMP isn't always returned at the same place in relation
to other QMP events. Could you have a look at it?

https://gitlab.com/qemu-project/qemu/-/issues/2126

thanks
-- PMM

