Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 16:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2vm3-0003Th-VC; Fri, 03 May 2024 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2vm2-0003TI-61
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:28:38 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2vm0-0003aN-Jm
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:28:37 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so1345941766b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714753715; x=1715358515; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5QcAtR3CP0dKrpmYLCBHjaCV//LHjKr7WeUxEfJJ08E=;
 b=Tz2IwvI6Fy00IjE1APSSVPC84m4Ct/G3tuvu+qQydz/PlQWvWGIosctGArjRGmv0p1
 736wgvpCauNCuM3tS4AIzAuvclncwS/I5AO8QPdUvicQxB9E6maH8BCO03QGI+akymXd
 itCFQ3V7vZsYwIbXqUpks7igOqdDidG7ktfjBWnPuL38GYk1RHebVbCDOl/OLt0lBOSy
 8HgHWetB8Eo4r891jv6TZ4+Ctn/LsD6BVQkzWEZZvYEBUg1qECv3LXLMjYEKpIcN+/9U
 WP2bCs8cF+9Ks7DL2ncaVmeLgiaAFAMvzBVYdtcVvvMsclP2HaBS5RAOa+F+jZZvkiwa
 nbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714753715; x=1715358515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5QcAtR3CP0dKrpmYLCBHjaCV//LHjKr7WeUxEfJJ08E=;
 b=Yg1wAMuu9dUFNTHttFdubRyfOp7FdVDtRnhUAG99EqTFqSYAbpEgxZTVwCq4OSw3ef
 f0JkUmR8JKfggN4VwJ0JzNOkjc3gCDIM6EXo/pQ0IeK+CHFtKI6dNlkd3Jp4kgss9WaB
 syhffY7GL0wEqdz6DAU48UE3sEfGWQkQXzpa1lMQ4v7zod27WoZNlt1E57SitNrsswAX
 bV5WSUY4pqOdhNlKP3+PmVSeUjdDr+C2rvKgCgZhB+ZTYseNFnceAAWklnhgdZpiNY2b
 9yGRqyx6PBJ+maUF0LLJ0+Kc8NjwQUYv0pQ4sXdA3yLUSNFiXQfFScKy/uL+WXQVR9rg
 w/pw==
X-Gm-Message-State: AOJu0Yw+btcdMQe8zEJWMZdWdx+5ZNdJtOqUcDXtSBNskOAKobHbEWY6
 EX4XDb0/zjgQ7/sJt6TCF79668Y4C7Z1uInUqra6tTKjOz3htN5dZ2zlKuWj0Wc8hhAVTI/ILBy
 AfOsaEbIPvtgnKgNcOh+Y3ikHgeRc/34QrYKFJg==
X-Google-Smtp-Source: AGHT+IFsLrlq3KvTgoXHTMyCpeuqDtqAHa9T5wKohKFqUv1P5udbewLHzmp5tnQtR65QDgZq+fa9NPKu00Hmz1pSMrg=
X-Received: by 2002:a50:d657:0:b0:572:a6e9:58ca with SMTP id
 c23-20020a50d657000000b00572a6e958camr1926353edj.10.1714753715094; Fri, 03
 May 2024 09:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
In-Reply-To: <20240419183135.12276-1-dorjoychy111@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 17:28:23 +0100
Message-ID: <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Fri, 19 Apr 2024 at 19:31, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
>
> Some ARM CPUs advertise themselves as SMT by having the MT[24] bit set
> to 1 in the MPIDR register. These CPUs have the thread id in Aff0[7:0]
> bits, CPU id in Aff1[15:8] bits and cluster id in Aff2[23:16] bits in
> MPIDR.
>
> On the other hand, ARM CPUs without SMT have the MT[24] bit set to 0,
> CPU id in Aff0[7:0] bits and cluster id in Aff1[15:8] bits in MPIDR.
>
> The mpidr_read_val() function always reported non-SMT i.e., MT=0 style
> MPIDR value which means it was wrong for the following CPUs with SMT
> supported by QEMU:
>     - cortex-a55
>     - cortex-a76
>     - cortex-a710
>     - neoverse-v1
>     - neoverse-n1
>     - neoverse-n2

This has definitely turned out to be rather more complicated
than I thought it would be when I wrote up the original issue
in gitlab, so sorry about that.

I still need to think through how we should deal with the
interaction between what the CPU type implies about the MPIDR
format and the topology information provided by the user.
I probably won't get to that next week, because I'm on holiday
for most of it, but I will see if I can at least make a start.

In the meantime, there is one tiny bit of this that we can
do now:

> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index cc68b5d8f1..9d5dcf1a3f 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -487,7 +487,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>      /* CPUs */
>      for (i = 0; i < nc->num_cpus; i++) {
>          object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
> -                                arm_build_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
> +                                arm_build_mp_affinity(ARM_CPU(&s->cpu[i]), i, NPCM7XX_MAX_NUM_CPUS),
>                                  &error_abort);
>          object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>                                  NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);

In this file, the value of the mp-affinity property that the
board is setting is always the same as the default value it
would have anyway. So we can delete the call to
object_property_set_int() entirely, which gives us one fewer
place we need to deal with when we do eventually figure out
how the MPIDR values should work.

If you like you can submit a separate patch which deletes
this one call.

thanks
-- PMM

