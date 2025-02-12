Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E448BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDUz-00026A-Lf; Wed, 12 Feb 2025 09:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tiDUr-00024v-Rf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:13:50 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tiDUp-0000oY-5k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:13:48 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5deb1b8e1bcso1256410a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739369623; x=1739974423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tGbJu/1QcDuX79ARwpOfrV2Fky9wfHGbVp1x/5SFSc=;
 b=neSeTjdDy3sTIsZxru8+ibTgC4XC4jGMOfknmzX7Ad9PKs1xVWfpmvARZOJjVUG7Uc
 dIZ2//A3v9bKyKqUG5Kjw7bdEl7AINpRdvs/nh8FHb7EI/mwnre45mNteAvcJvIgS3WX
 aqJdQI1H1aI5OqrhGsdCzcg9PgQjgXRAD1ffFBXuM49J3SqxG8CYL8W7I/FbmxRUPurP
 xd6gaOFNvsF62tEUVseu4P28sPLE4Bm+2NZrXuVzROTt73oSBRaXBVKzCtoKrZFCbFUi
 O5B5m8OxrJIAn57VsYNXdDifsYj3KpdW7s4+7Kqnf+EvUwFwXYuufa7wIbV/B2YeWUJa
 1B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739369623; x=1739974423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tGbJu/1QcDuX79ARwpOfrV2Fky9wfHGbVp1x/5SFSc=;
 b=weMhYccJ5rga7haIHmYjP/N40FW4Hp1fDHEnr+9u26sPTnZtxzWay5D91VSFrGtX3U
 Fm6zQLldNgV/UgNnP88+SQDkkMqy/4nHiVDshzB2sTMfAUxorBWf3yIOSfh0tI7jSvln
 QoiO7lXJ2ak9Sk9PNaqm4I56f0js1DMLeoFPMk0+fTMF9NvM3Ydh++JJhZ6/5iQC7CHv
 wy/glgDN73QfsUbNzV008ArDHzWOm3WEsclZ5ClZPH5r1RMgzmmf6kcqUQFrKCPY4iHw
 d4BpaE37AzzxelkYvIJBqsYRcwU/tx0CXzeyCbLivHxjf6j4pUOq9rnz4K7ZjRatmJPm
 LBJA==
X-Gm-Message-State: AOJu0YwfQp6OMina1rjotAj9SwOF11f2TapXxHdXRXnPpUResFgfdeWV
 1tpTpkpAtkEvlHS0UzsAUB9No5tS0hqWQ8OpAeDxFJPzUSu6yK4AkDrwm12bDYFfQcuRFQagya1
 naJg/wjojv60X75Lh72U6+WRrdko=
X-Gm-Gg: ASbGncsLPSre+XhHuRFbNHAWpf7mVxrxX6Ut7XqpGWMX+h3E5GVZdpCYCrEq7y0ivyf
 yTjpnR0FEYGiadCijBRATeko478nJQEtxBuPIuIH9t/OszWzZuprJcqzf16XfAJzSgs0a8Zg=
X-Google-Smtp-Source: AGHT+IEv38sXy/2CN/BoL/+/4FUmVDqNYTuqFMiYipuFtwfhe6JQR9BnHH9EYt6dFxQJpvNaoMQu8+FNDr1019adFMk=
X-Received: by 2002:a05:6402:358f:b0:5dc:7425:ea9c with SMTP id
 4fb4d7f45d1cf-5deaddde8d1mr2807182a12.26.1739369622782; Wed, 12 Feb 2025
 06:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20250211225059.182533-1-peterx@redhat.com>
 <20250211225059.182533-3-peterx@redhat.com>
In-Reply-To: <20250211225059.182533-3-peterx@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 12 Feb 2025 09:13:30 -0500
X-Gm-Features: AWEUYZmGcy382Eeud0Wi3rlMSQmEDel5L50okUcYsYft8Z2WDiYwzcfWrbhrKLs
Message-ID: <CAJSP0QUFX56ePKQ=jD7jMkP6TYPF83zwdnEXCyLG7FMgcjZ9UQ@mail.gmail.com>
Subject: Re: [PULL 02/14] os: add an ability to lock memory on_fault
To: Peter Xu <peterx@redhat.com>, Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, Feb 11, 2025 at 5:52=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> From: Daniil Tatianin <d-tatianin@yandex-team.ru>
>
> This will be used in the following commits to make it possible to only
> lock memory on fault instead of right away.

Hi Peter and Daniil,
Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9117106042#L3603

Thanks,
Stefan

>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> Link: https://lore.kernel.org/r/20250123131944.391886-2-d-tatianin@yandex=
-team.ru
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/system/os-posix.h |  2 +-
>  include/system/os-win32.h |  3 ++-
>  migration/postcopy-ram.c  |  2 +-
>  os-posix.c                | 10 ++++++++--
>  system/vl.c               |  2 +-
>  5 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index b881ac6c6f..ce5b3bccf8 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>  void os_set_chroot(const char *path);
>  void os_setup_limits(void);
>  void os_setup_post(void);
> -int os_mlock(void);
> +int os_mlock(bool on_fault);
>
>  /**
>   * qemu_alloc_stack:
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index b82a5d3ad9..cd61d69e10 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
>      return false;
>  }
>
> -static inline int os_mlock(void)
> +static inline int os_mlock(bool on_fault)
>  {
> +    (void)on_fault;
>      return -ENOSYS;
>  }
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 6a6da6ba7f..fc4d8a10df 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingSt=
ate *mis)
>      }
>
>      if (enable_mlock) {
> -        if (os_mlock() < 0) {
> +        if (os_mlock(false) < 0) {
>              error_report("mlock: %s", strerror(errno));
>              /*
>               * It doesn't feel right to fail at this point, we have a va=
lid
> diff --git a/os-posix.c b/os-posix.c
> index 9cce55ff2f..48afb2990d 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -327,18 +327,24 @@ void os_set_line_buffering(void)
>      setvbuf(stdout, NULL, _IOLBF, 0);
>  }
>
> -int os_mlock(void)
> +int os_mlock(bool on_fault)
>  {
>  #ifdef HAVE_MLOCKALL
>      int ret =3D 0;
> +    int flags =3D MCL_CURRENT | MCL_FUTURE;
>
> -    ret =3D mlockall(MCL_CURRENT | MCL_FUTURE);
> +    if (on_fault) {
> +        flags |=3D MCL_ONFAULT;
> +    }
> +
> +    ret =3D mlockall(flags);
>      if (ret < 0) {
>          error_report("mlockall: %s", strerror(errno));
>      }
>
>      return ret;
>  #else
> +    (void)on_fault;
>      return -ENOSYS;
>  #endif
>  }
> diff --git a/system/vl.c b/system/vl.c
> index 9c6942c6cf..e94fc7ea35 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -797,7 +797,7 @@ static QemuOptsList qemu_run_with_opts =3D {
>  static void realtime_init(void)
>  {
>      if (enable_mlock) {
> -        if (os_mlock() < 0) {
> +        if (os_mlock(false) < 0) {
>              error_report("locking memory failed");
>              exit(1);
>          }
> --
> 2.47.0
>
>

