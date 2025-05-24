Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D0CC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIt12-0005LM-MV; Sat, 24 May 2025 13:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uIt10-0005L8-N9
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:50:34 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uIt0y-0002ak-7m
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:50:33 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-477296dce8dso8225311cf.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748109029; x=1748713829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHnobuPoj1ossbI4FcI68P2O5rSq2nbjHUXRqGOiZzk=;
 b=fMP6RUD3hZIIPH141oo9wbWX41fdxhgtfzJK2hjPWgCGdMJIPZMvVbCZP28+4usVbx
 S8s1NS0IzetIKt5On0Sfn/AjPifKLXdR0uvxuUEKLe4rdkTJcYY3b+huzeDDL7IWl04w
 JeX3x+z7ouIdGFiP3vPm5SCoYLavrkMtnYaLHZI2+jMl7g4fjFZ/VpCcGAaTiIGxK7pL
 JZCHFiilv9Bonr9+L7+iSs9SvzgzLt2TpEwi5dY3D0yCqFAo8IwzqKHxbjwGcYwSJNut
 1RmM94zINZjwLvB80ZvNVZL11fu+PvZZxNKgptUprqfL+qLiZEha8vXVRnn6tYW4+/1F
 gRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748109029; x=1748713829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHnobuPoj1ossbI4FcI68P2O5rSq2nbjHUXRqGOiZzk=;
 b=StY1bVWRofqf785Ffa/ZMrQKLTNEiEdbHcsTW8JYptti3eIzl9HSkBQ4dQz8j1Lzy7
 xLL440NkiGedr/Dq707Vk/ZXFjISY5JBE/yQpTwQPN3U308oH5Pbkc1gqS51s7hkUqvA
 0XIxkAMNsoJRETJzZ8X5U/gmPdcdUX/YTmPOpc5aLlmF3exjm7LMfw/lyxM71NAHe4XK
 /BENs06AbWy1umkh5vBVY9RrdirI+D8xgCvy9BNa3ceDIS8TrqLgWnwX06lO+Ncm57d3
 +dNiRryVM/ewo3YZpVqrKi3hhaallO8lNtmIs8dUuNvT/Nw+mZosuYgUYBEU5nm1dqC+
 sBdQ==
X-Gm-Message-State: AOJu0YwscEnnePZHiTxxbivhqyZedW8STpGU8jotgc/xx8BivI6wUd9v
 smNwAp+owuoWLtQUGwoKH51RzQa07AdTV0NqXoz5JAe/FVgTavWat25EtRuFL+BdTEPTmwY8uT4
 rMeTkaJUQ6AObdr8fpPg1fN53Ttbfmz8=
X-Gm-Gg: ASbGncu5YJ/GlBWcM28a+1EXdxo8/4ooReSine/vcvb8aicEaKOwLxpUC/Bsk6sdau1
 hnxZ97wkhcx9aH0+3dRehX4+Z8QAerXBXiw6ZT0ymjoeEo54Ypryopn+Jwx/WsgJ1iHiFr0QOW9
 eeRUSY+udvNdaTkzAxbPyOQvgunu7RCVctBKaG9PIi5ILOz4fqMbMvt59AB72iTGf1Bg==
X-Google-Smtp-Source: AGHT+IF+Nc5xK69v4MnwyVSFXLd7BFGIpza2oroNp61U7Xr8VeYjzpaGgdz2FA23qy/lquHFn0StbWXg+59vReTnNPo=
X-Received: by 2002:ac8:690e:0:b0:494:f705:3ba7 with SMTP id
 d75a77b69052e-49f481bec7emr66821121cf.44.1748109029406; Sat, 24 May 2025
 10:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250515222014.4161-1-farosas@suse.de>
In-Reply-To: <20250515222014.4161-1-farosas@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 24 May 2025 19:50:18 +0200
X-Gm-Features: AX0GCFu7R88caG_kVUZGZ-hai-NC-auifFeQrEJqkwDyCBuBfvwQniBY5C89JqA
Message-ID: <CAJ+F1C+wJ4od6G3wbRw9iNvD8Des2YSKdwAzbHh0XwNu6sOtcw@mail.gmail.com>
Subject: Re: [PATCH 0/4] chardev: Fix issues found by vhost-user-test
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

Hi

On Fri, May 16, 2025 at 12:21=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wr=
ote:
>
> Running vhost-user-test with ASAN on a loaded machine reveals several
> intermittent issues. These show up every time I test the qtest tree so
> I'm trying to get rid of them.
>
> 1- UAF of IOWatchPoll.
>    This one is self explanatory, ASAN caught it.
>
> 2- Reference counting issues in glib. It seems it's possible to unref
>    a source while adding a callback to it, and glib asserts. This
>    shows up on all architectures, only on the ASAN build after
>    hundreds of iterations.
>
> 3- Extra yank_unregister_function call leads to abort(). This shows up
>    on all architectures, but it's quite hidden due to vhost-user-test
>    using a dedicated server thread which dies and causes timeouts in
>    the test.
>
>    Manifests as assert(s->fds_num) failing. Only on the ASAN build,
>    after tens of iterations (quite common).
>
> Thanks
>
> Fabiano Rosas (4):
>   chardev: Fix QIOChannel refcount
>   chardev: Don't attempt to unregister yank function more than once
>   chardev: Consolidate yank registration
>   chardev: Introduce a lock for hup_source

Daniel, would you take the first 3 (or all) patches in your next I/O PR ?

>
>  chardev/char-io.c      |  5 +++++
>  chardev/char-socket.c  | 38 ++++++++++++--------------------------
>  chardev/char.c         |  2 ++
>  include/chardev/char.h |  1 +
>  4 files changed, 20 insertions(+), 26 deletions(-)
>
> --
> 2.35.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

