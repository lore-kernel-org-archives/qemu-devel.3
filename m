Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E977C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvnv-0001Jy-5F; Wed, 20 Mar 2024 09:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmvnq-0001H9-3h
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:16:22 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmvnn-0000eW-Ft
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:16:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56890b533aaso7645992a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710940577; x=1711545377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsRYT1HRMt2r17mBvQ9bRL50YsCuqo96buii4qi2KtE=;
 b=kV9ciY3KebhOVc87zJKLt84dVNLwhkkS+k4ySzt6sQn9xQzxPpFmHqlxsz1zP6Omwa
 Z+geU+k+8Dg/NAnMTxyiUdaFVuJ7l5RyG72OD08t/WChMIbZbs06nmm1ASIrzb2Qglt7
 taP3kmABw1iCibPNVUj7rl9sVqNQlrXUADXvGrKvmWn5CFq+YOUk76TgntZh3gf6Btp3
 lD8Cg3D8mvCmGqQSHeALy5yVFoD9prQyyUt5R0iJdGX5aQSnREf3L0eUWZXyaAiNFCW4
 ImKU7X+ZmSkjFDcWx64LRwDsY60lT39PK+5GrV2qFbX/U8voLXjfS1Xg41xLqZxxFPfO
 X/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710940577; x=1711545377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsRYT1HRMt2r17mBvQ9bRL50YsCuqo96buii4qi2KtE=;
 b=WV/Ww8eSAHzJ/BCO48AFbO51v/Bmy6aqGJUAfz2jwfgMgLdVJreWHpJImtb/O6KO3U
 rDEm4fba8uhl/QEF6eb/GkCxWwP1NEtJt+nx4DO4voob0JU82u7AOzli4pmJi2BsyDwX
 Q8Er+bMnVZzkKjPNJ/2xrWxcv3n8sBD7VWafPPsNpN4ElG5UPegGquUDaK3yJBmnzKRu
 48JMsfLLmuVqCmLAt3RZSV0WH4oTtGBxVzcUlRgjimppH00KZPrFwJnwWZYOK3RwY0lR
 AEX7ARfttNigDmTXaxxVV6uicmMzibRIrp9GFQ29/xCF+BvXz2W0lksuHfAX9WM23gIG
 LUsA==
X-Gm-Message-State: AOJu0YylVEiTh18ko8xH8+THHyTJWozh+bur3BPmmht89RmTveSI1iLd
 t4c4EZwDY6X64ZnC+Y8mirfWZ7Bfk7aweW5PywARkEhihPmYXej7ld7ySPYQ3dhvanRFGpXW71c
 NmaNC+d6NUWTJe8Uk++6mpu4nOVvNvu1XizkEwA==
X-Google-Smtp-Source: AGHT+IEyk+jviDbh/t/v74Rq6UgzQ02bSJtzlH7c/Xa+1T8F8mRP1I3+sPiF9+ADBEOveFWS+sTuWC4l0BXKBGnVbXs=
X-Received: by 2002:a05:6402:43c5:b0:568:bc48:5f27 with SMTP id
 p5-20020a05640243c500b00568bc485f27mr3820732edc.39.1710940577355; Wed, 20 Mar
 2024 06:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-3-philmd@linaro.org>
In-Reply-To: <20240220150833.13674-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 13:16:06 +0000
Message-ID: <CAFEAcA9yvS1UCiszV3NqkYq91Rcv9w_=rZqOBLueX_+NiDmTKg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/s390x/virtio-ccw: Always deliver NMI to first CPU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We can trigger NMI from HMP or QMP.
>
> QEMU maps the NMI to the s390x per-CPU 'RESTART' interrupt.
> Linux guests usually setup this interrupt to trigger kdump
> or crash. Such crashdump can be triggered in QEMU by HMP
> "nmi" or QMP "inject-nmi" commands.
>
> Using QMP, since we can not select a particular CPU, the first
> CPU is used (CPU#0). See the documentation from commit 795dc6e4
> ("watchdog: Add new Virtual Watchdog action INJECT-NMI"):
>
>   @inject-nmi: a non-maskable interrupt is injected into the
>                first VCPU (all VCPUS on x86) (since 2.4)
>
> While we can select a particular CPU on HMP, the guest behavior
> is expected to be the same if using CPU #N or CPU #0. Since
> always using CPU#0 simplifies API maintainance, update s390_nmi()
> to deliver NMI to the first CPU.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  qapi/run-state.json        | 5 +++--
>  hw/s390x/s390-virtio-ccw.c | 4 +---
>  hmp-commands.hx            | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 08bc99cb85..a2542f1a50 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -320,8 +320,9 @@
>  #
>  # @none: nothing is done
>  #
> -# @inject-nmi: a non-maskable interrupt is injected into the first
> -#     VCPU (all VCPUS on x86) (since 2.4)
> +# @inject-nmi: a non-maskable interrupt is injected (architecture
> +#     specific: on s390x only the first vCPU receive the NMI, on

"receives"


> +#     other architectures all vCPUs receive it). (since 2.4)

This part isn't really true, because it's machine-specific rather
than architecture-specific (and many architectures don't implement
it at all). But I don't think we want to introduce that doc cleanup into
this patch. Maybe we should leave it as only saying "all vCPUs on x86",
though.

>  #
>  # Since: 2.1
>  ##
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 62804cc228..ba1fa6472f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -605,9 +605,7 @@ static HotplugHandler *s390_get_hotplug_handler(Machi=
neState *machine,
>
>  static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
>  {
> -    CPUState *cs =3D qemu_get_cpu(cpu_index);
> -
> -    s390_cpu_restart(S390_CPU(cs));
> +    s390_cpu_restart(S390_CPU(first_cpu));
>  }
>
>  static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 17b5ea839d..2b01bb5926 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -851,7 +851,7 @@ ERST
>      },
>  SRST
>  ``nmi`` *cpu*
> -  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
> +  Inject an NMI.
>  ERST
>
>      {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

