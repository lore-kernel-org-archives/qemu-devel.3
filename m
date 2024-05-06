Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82063C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 13:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3y79-0004P6-3j; Mon, 06 May 2024 09:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3y77-0004Oo-A9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 09:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3y75-0005IV-Pf
 for qemu-devel@nongnu.org; Mon, 06 May 2024 09:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715001038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sm632hvadCPIW1vd8okXxXRUR8xDRpvG9Kf+IaJIM8=;
 b=ZzaT/4nixEHKpwxvh1lfMbC+V1x6GCOiQDPIVcp91LQ/ezdalVVVQjC191MeqgemPAnK78
 EeKh8e9aIFf/U7wHcj8vTgVw/rj9/4IURdfBDDPH4Jkbb74tfohkmCbnN1wB5s0LOEGWpB
 LIquXtLGRgmk7tVSTCD4ywga9/dpA4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-FviI1mvyNkCfLKCYA0grgg-1; Mon, 06 May 2024 09:10:37 -0400
X-MC-Unique: FviI1mvyNkCfLKCYA0grgg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34dcec2cbbbso1386507f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 06:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715001034; x=1715605834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7sm632hvadCPIW1vd8okXxXRUR8xDRpvG9Kf+IaJIM8=;
 b=I0oYCwej6nDzHcG2PoLoRWAK2C6f8xlVTu14M4i0EnPPPbSJ48qdCXpjwoU/A6a71G
 55jEBh/x1PWOpO+lolRseG0+Xs48110TSIkgG5kZuByRCAsBnOW/EoC3ymb5SRe0AZWV
 BUjIYsnywr/97SUhBVKcVIiU7nJ0q6DQawOvzFooTMbClJQqmjPTtR1p3c8Pw/kdLmO1
 jqvZcAkG0Rp6UJHNNcSMgCXpebguwVLitwVGtOGIC1L8IcaAfoZybvwUM/5HZCLkxTHW
 OOJVJ12UjHLkBF/LPPPi75p4gk6GBkygxYtt/QIiZvWHYY3zP8Ht6VI2gdHjbbmo6mpf
 Wc8w==
X-Gm-Message-State: AOJu0YzqQZAXmqWs7Kxn/q+Q+FMG0zLWHRE6jsE9hX0yvHL0AXk4RIJf
 wdNPOAmt+I3K5vzV+0S68WXg2AHk02sm9E5HyZ/5AUIahBhS3d7O+/sq1m54NmcL68e1x+UMEN6
 /GoEgHlsE3z11pn3MgEviPZ5FtKT9njYTXBYkRc5orqHt4CVaDTpKrHVLTI/IXundLlnvuMTt9G
 WI8TJigNqAaGsk+hyMCDFoB95RFH0=
X-Received: by 2002:a5d:540c:0:b0:34d:9055:c5e7 with SMTP id
 g12-20020a5d540c000000b0034d9055c5e7mr6492081wrv.3.1715001034111; 
 Mon, 06 May 2024 06:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmFFj1H45Jo2jVugh1xqEmrGPNtQw+BT1tTRgCxgWUnComm5IXE4iRDyfYs66KmLMm5p9BU+NN55fNslTGI7M=
X-Received: by 2002:a5d:540c:0:b0:34d:9055:c5e7 with SMTP id
 g12-20020a5d540c000000b0034d9055c5e7mr6492066wrv.3.1715001033737; Mon, 06 May
 2024 06:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240506112058.51446-1-thuth@redhat.com>
In-Reply-To: <20240506112058.51446-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 May 2024 15:10:21 +0200
Message-ID: <CABgObfaPUQvnP-+Ff9gb6TZw5G1SLS5C-=QbmJ0HRy5cFoM2nw@mail.gmail.com>
Subject: Re: [PATCH v2] qemu-options: Deprecate "-runas" and introduce
 "-run-with user=..." instead
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 6, 2024 at 1:21=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> The old "-runas" option has the disadvantage that it is not visible
> in the QAPI schema, so it is not available via the normal introspection
> mechanisms. We've recently introduced the "-run-with" option for exactly
> this purpose, which is meant to handle the options that affect the
> runtime behavior. Thus let's introduce a "user=3D..." parameter here now
> and deprecate the old "-runas" option.

No need to deprecate it, there are other shortcut options that are
just a couple lines of code to implement:

            case QEMU_OPTION_watchdog_action: {
                opts =3D qemu_opts_create(qemu_find_opts("action"),
NULL, 0, &error_abort);
                qemu_opt_set(opts, "watchdog", optarg, &error_abort);
                break;

However that would be a larger patch, basically moving all of the
--run-with handling to qemu_process_early_options() (and, as an aside,
setting .merge_lists =3D true in qemu_run_with_opts).

No objections to your patch, but also no objections to cleaning all of
--run-with; I should have caught it and proposed the shortcut options
when it was introduced or when --chroot was removed.

Paolo

>                  if (!os_set_runas(optarg)) {
>                      error_report("User \"%s\" doesn't exist"
>                                   " (and is not <uid>:<gid>)",
> @@ -3612,6 +3617,16 @@ void qemu_init(int argc, char **argv)
>                  if (str) {
>                      os_set_chroot(str);
>                  }
> +                str =3D qemu_opt_get(opts, "user");
> +                if (str) {
> +                    if (!os_set_runas(str)) {
> +                        error_report("User \"%s\" doesn't exist"
> +                                     " (and is not <uid>:<gid>)",
> +                                     optarg);
> +                        exit(1);
> +                    }
> +                }
> +
>                  break;
>              }
>  #endif /* CONFIG_POSIX */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cf61f6b863..3031479a15 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4824,7 +4824,8 @@ DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
>  SRST
>  ``-runas user``
>      Immediately before starting guest execution, drop root privileges,
> -    switching to the specified user.
> +    switching to the specified user. This option is deprecated, use
> +    ``-run-with user=3D...`` instead.
>  ERST
>
>  DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
> @@ -4990,13 +4991,15 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, =
"", QEMU_ARCH_ALL)
>
>  #ifdef CONFIG_POSIX
>  DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
> -    "-run-with [async-teardown=3Don|off][,chroot=3Ddir]\n"
> +    "-run-with [async-teardown=3Don|off][,chroot=3Ddir][user=3Dusername|=
uid:gid]\n"
>      "                Set miscellaneous QEMU process lifecycle options:\n=
"
>      "                async-teardown=3Don enables asynchronous teardown (=
Linux only)\n"
> -    "                chroot=3Ddir chroot to dir just before starting the=
 VM\n",
> +    "                chroot=3Ddir chroot to dir just before starting the=
 VM\n"
> +    "                user=3Dusername switch to the specified user before=
 starting the VM\n"
> +    "                user=3Duid:gid dito, but use specified user-ID and =
group-ID instead\n",
>      QEMU_ARCH_ALL)
>  SRST
> -``-run-with [async-teardown=3Don|off][,chroot=3Ddir]``
> +``-run-with [async-teardown=3Don|off][,chroot=3Ddir][user=3Dusername|uid=
:gid]``
>      Set QEMU process lifecycle options.
>
>      ``async-teardown=3Don`` enables asynchronous teardown. A new process=
 called
> @@ -5013,6 +5016,10 @@ SRST
>      ``chroot=3Ddir`` can be used for doing a chroot to the specified dir=
ectory
>      immediately before starting the guest execution. This is especially =
useful
>      in combination with -runas.
> +
> +    ``user=3Dusername`` or ``user=3Duid:gid`` can be used to drop root p=
rivileges
> +    by switching to the specified user (via username) or user and group
> +    (via uid:gid) immediately before starting guest execution.
>  ERST
>  #endif
>
> --
> 2.45.0
>M


