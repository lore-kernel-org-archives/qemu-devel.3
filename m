Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF27CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjdZ-0001mT-Ld; Thu, 11 Jun 2026 13:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXjdY-0001mD-Bo
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 13:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXjdW-0002Ub-LI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 13:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781200573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0APqX4pqiUkphtQmWTZ80G/2Du4D1Xrbspassh8B6eE=;
 b=YBf3xm94Vyp3LzCZNEJAMz5n6fl14JrA7gv9EOBm5i/ATaw5R2KtZXWexVKUwSNgab43LS
 qQ5sLjAs3hPCQm70X7W/WPhI3U9Wu/ux/TLkh4oF+PPJDtEtfRGqZwdl/Igz4ntQMYQ2iA
 SJLKrW8VI1EesVisgXKmLfLW/iweJ8g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-bXOgtpUOOK6cQOjCuGqBpg-1; Thu, 11 Jun 2026 13:56:11 -0400
X-MC-Unique: bXOgtpUOOK6cQOjCuGqBpg-1
X-Mimecast-MFC-AGG-ID: bXOgtpUOOK6cQOjCuGqBpg_1781200570
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175a1e32e3so1408921cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781200570; x=1781805370; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0APqX4pqiUkphtQmWTZ80G/2Du4D1Xrbspassh8B6eE=;
 b=Gib4PsDJK11+fivzwUdsqOvLXGAFLzeOei3v23I4tL7D9QtA+/ssvT6MajlPuvt5Wv
 b2uRYk0nk20/1lpO7fQWvqzsfxarA06+0keBuQNO3slQ6lk3BLoTuWOCVcW8HIj/NS60
 MuluB6kNcJ+EI5K8N2kmmORHR8VpqG48TcTcyeQriquOE7O/WpjdIRzUq9CZL5uyWHou
 L1DThidI1o9etOB2Jfu1k68XxU/ATYb+/DdRF1UEvVyg3vO8Ri85zbghRJmnEC/hbeMq
 STMnhvMzWbOqnDj30qb+gLJLh7rIERUrJUjlUuiOKjzcqrBf3jmmI8xQEtCON43DSgDp
 9bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781200570; x=1781805370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0APqX4pqiUkphtQmWTZ80G/2Du4D1Xrbspassh8B6eE=;
 b=kI9Ti2IDf7qaBEEYseYbtf/aqBXOTOXJLycEtcZNRhBLR3Rbz0wtHfl8Qa1sOxsRYP
 ac7qHyKpCoZL+ZTRlO7qQQCh45HXYLg9DtGfya+qs6WycXglPCLKKGpNVaiD1+/rYHCs
 NrssDHcLjFLHNKLoaxGezW5tYleOXni+vwawI7AxDbwe9dOAB+dSXGQUhkOZjPmFuRx/
 TXoDuVEy8LD8adEZIY9hNmOEdtzuoKwM3JlCKNpEjXmtwusUNJ52fLKBRROIVslqyJIx
 Lf4hrJCrcif2RwbH6vWwccd2fVE4/LkC/NOmPz094+Mink8/NV6dV20r8MAmS3lMzeCb
 l0nA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nQ9BJNuA/awkY4Qx8jxI73OxK64WfnSXm/EDZOkWJ+c6MwH3pjyWqvmpzIDIYfWngb2YtT+vKnJL2@nongnu.org
X-Gm-Message-State: AOJu0YzGkMS4C+yOyE64uwuvzKp3hU7/0+lnko28TtKk/geZ4iU3rU8d
 WlMU3Kxc4792O0smqj6cgzOMIRdII9CLUTW5UXb15bt7968ofoU0ot8BlctoUBwjIElAdSZK7sL
 ytmBRVUw1+LU6bukz+6uWG/QqusRaZYp/hGceeurnm21Wi3rzPsHaYuP7
X-Gm-Gg: Acq92OH0ViMiOnJPqPSfTmugDgYpBxpVMKjU2A6cb54awUjY0wQeBojwUdHgyLYpP/O
 7TY89A4aZ3tLAnaV57HdENjgU2Cu4tDeBzkbRhi4aNgHTnOm+lpva4V8vJ/5r2BEnnIjalxkdp3
 BnrfLcSrW0iV/FRyAVhDPkQbZIoNPj3ExP+pFyPB+3xbFLXTfskihmuGLoPPNiH94SIyu3+AZxz
 FrZ9VfHb0JzLFivApIn5sSDtqx1if4K9qPFbLkoOBygvA9gOWiv+2TqQqoke2KMxW4WRj2v/g2S
 9VEg57ikk10VjZK5DciuFIfIkmlkdcWK7OTGFTAj3x1Y78tqJGOEWx3C/9fW3PKuGjvUEFHz5hA
 yy3FkhyVNJ89OpbA=
X-Received: by 2002:a05:622a:1e9b:b0:517:282c:b894 with SMTP id
 d75a77b69052e-517ee3d306dmr58574461cf.53.1781200569829; 
 Thu, 11 Jun 2026 10:56:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1e9b:b0:517:282c:b894 with SMTP id
 d75a77b69052e-517ee3d306dmr58573691cf.53.1781200569189; 
 Thu, 11 Jun 2026 10:56:09 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef69fc4csm23361231cf.29.2026.06.11.10.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 10:56:08 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:56:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/qtest/migration: Add migration test on loongarch
Message-ID: <air2t3bsG19h_A86@x1.local>
References: <20260611084312.70042-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611084312.70042-1-maobibo@loongson.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 04:43:12PM +0800, Bibo Mao wrote:
> Add migration qtest on loongarch64 system, the test passes to run with
> the following result:
>   qemu:qtest+qtest-loongarch64/qtest-loongarch64/migration-test OK 15.94s 9 subtests passed
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Add SPDX-License in __note in file tests/qtest/migration/Makefile
>   2. Regerate file tests/qtest/migration/loongarch64/a-b-kernel.h with
>      __note information
> ---
>  MAINTAINERS                                   |  1 +
>  tests/qtest/meson.build                       |  3 +-
>  tests/qtest/migration/Makefile                |  4 +-
>  tests/qtest/migration/bootfile.c              |  4 ++
>  tests/qtest/migration/bootfile.h              |  4 ++
>  tests/qtest/migration/framework.c             |  6 +++
>  tests/qtest/migration/loongarch64/Makefile    | 20 ++++++++
>  .../qtest/migration/loongarch64/a-b-kernel.S  | 46 +++++++++++++++++++
>  .../qtest/migration/loongarch64/a-b-kernel.h  | 20 ++++++++
>  9 files changed, 106 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/migration/loongarch64/Makefile
>  create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S
>  create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b5b581e17..91d72feebe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1359,6 +1359,7 @@ F: hw/intc/loongarch_*.c
>  F: hw/intc/loongson_ipi_common.c
>  F: hw/rtc/ls7a_rtc.c
>  F: gdbstub/gdb-xml/loongarch*.xml
> +F: tests/qtest/migration/loongarch64/
>  
>  M68K Machines
>  -------------
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 45ea497fa5..1636b8616e 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -154,7 +154,8 @@ qtests_loongarch64 = qtests_filter + \
>    (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
>    (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
>    ['boot-serial-test',
> -   'cpu-plug-test']
> +   'cpu-plug-test',
> +   'migration-test']
>  
>  qtests_m68k = ['boot-serial-test'] + \
>    qtests_filter
> diff --git a/tests/qtest/migration/Makefile b/tests/qtest/migration/Makefile
> index c183b69941..626e3974f7 100644
> --- a/tests/qtest/migration/Makefile
> +++ b/tests/qtest/migration/Makefile
> @@ -5,7 +5,7 @@
>  # See the COPYING file in the top-level directory.
>  #
>  
> -TARGET_LIST = i386 aarch64 s390x ppc64
> +TARGET_LIST = i386 aarch64 s390x ppc64 loongarch64
>  
>  SRC_PATH = ../../../..
>  
> @@ -23,6 +23,8 @@ help:
>  	@echo " Possible targets are: $(TARGET_LIST)"
>  
>  override define __note
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Maybe this'll need a regeneration of headers just to inject this line
all over.. I'll do that when I pick this up.

Thanks,

-- 
Peter Xu


