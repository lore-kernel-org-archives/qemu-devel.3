Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B6606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kHBnpJRb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM96u-0005d2-5z; Wed, 28 Oct 2026 15:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM96r-0005cO-0O
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:14:53 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM96p-0004x1-3i
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:14:52 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2e8c710847so185497166b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793214887; cv=none;
 d=google.com; s=arc-20260327;
 b=JfbTJP1NOlwQoh28wXJ5ThQi9FTPXXIkYJT76mR1AkCJnhG9WkYgFT2SnF8KR+PqJR
 JmiXOSrQuaWZoIbxVuN7ob4ABlK6/bsE+vSSWh1tH5TdJ9aVMqcF/6f4BYwdpL2LODgN
 DSafOUHIcdjfCq9ZRZurvSQ/mhmmirJS+FBeF5Hm0qus/PM4rGfLp9oaTtTQLYdJlIti
 W878Ruz5tCQLAs0zCM7V2hwWvaM7cavFrPrdx+Ig5zawIHTDTBzNBve1On/wmOzE8i8Q
 jpRfgCQkDez8l0ZNtt9eAwyw5XUfJgo6N2E0zAODCvQHeiBbqBhHGs2J0fMXqgkcQAoD
 9lzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=faK6rKBgMQPv3D/LENcLclP4Ya62UqVuzVudfJYBIeA=;
 fh=fNd1VJextNIOEttbvvUeA/wmqj685Y8nTpKvBYlvE1s=;
 b=kFDIqhDoX7IewnuwX9T23y/HsRHR4wDPGObyynS/yVYHqQTO8oMdXPJZkOjxNK1Qja
 IVIxAdIsKNXR+KY/zaQa7042/ZNB/5iIuLBvmEUGoRcvKqzjtq3taHZUx5qBI4jY+EmW
 q6xz1dIvLIKHzMqUPHo7n8jK02kpadAoN5vUX4CG28iFUL+UTespahhDdNnHJ4wkJP+a
 WswjbORuFdKhnQLvlyQ0HYxHbkTvDM/AFlXQXcJWeA542zszAW1mddArswAN7vrY4mrQ
 aAPdXrvigcJXvk3Gn3x5z4OfKrWrsj3bXINuO0hty05zAl+tHg/S9GWELRPpAQIwCuM9
 2ECA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793214887; x=1793819687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=faK6rKBgMQPv3D/LENcLclP4Ya62UqVuzVudfJYBIeA=;
 b=kHBnpJRbY+oL45ig0kTMyBqRcs6iwT/aQMHDo3wql+NnDegyVkLqwHOu8rsXbXA3Sa
 6qR6M11GH2FBVg9w362hTd+GDt2oHqv+pOH0UcAiE+HPE7F91Jp2A2eU8i8AITRLxrqB
 kv3d+grX5EsrAWeKJ3pZGlAM2r2tP9Px1vKNIornqXMOWxqmF9opuZL9qI7PYfrdPgxS
 bNt0p1xjJmAWFA2SJ/TyvUs00M8Mr/H6mZ3nCnx97j8duFJAfltoEEPG0GtwNbj/aVv9
 62y4cRpClwsMvl+UEv0xWfVHHUHp2jSBiPdkXzLw7jGCHkKdWFmlyPd5vt9EHTrGfFzf
 3jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793214887; x=1793819687;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=faK6rKBgMQPv3D/LENcLclP4Ya62UqVuzVudfJYBIeA=;
 b=StiNfE62ieQL/DSTRl0bcTcUrivf5rYCHGsQ3JbqSCahKgKXE+CQT+pWfL0tCfBaHt
 LMC8Rd/PB/qu/+B778uZxOwe6nxDSPWmV9/cMQaf1vDWiRwV3Ii3WPAyge7zFoHJ/FGF
 p3BZei0zB0SbGsskHY3iKKqT2rlG8Q8b26X4tu2rOOn89JUARlM/NYzsQHxa9SEUo5Ao
 KVT2WDavmuYmC5cDjzFgcLHIRwKQbo9SdgSEtaYF1Y4wPxmyjHdMDvuBAsFDaVFgvpJc
 /lfIS8H2oz+QE9huu44cx/AIqD9FGKtwO4X/R5n2j3B+9U6aUUD+5bkBrpzAjrgwwFbw
 buww==
X-Gm-Message-State: AFq9FYLPHpkwV4AbkvC2mH4HemVRQBU4kTQ2R3tfwrEnK45M1mKCTDdz
 dfquRyrnfqol8caq7kNeT8coct88APhH77GR8UyYfE/dTHsQ5I2YJPbHaIHZLRL6rHzr0aIOu1O
 jrX89vYTSW9lRvq0wyDSY7I0F/Xp4RSF6kksA+uwJ+Q==
X-Gm-Gg: AYBFou0Y7zur8vZWbq+gpQmBBSh6e3Wufa0h7mY8kGvrftmjXxKuB6j16mG1vVMTSUJ
 jUo7XAXM/qBoBbs/ofQtlTvsBPf2iYejw4alFm5guFfZyxIUYAYcYMUa99AQ2Kdb8H/cJChlSwC
 tGuosh37eFfdWp8UOjdpcTbxIhJQnomWqlbGcH1T5vYzrN/GvPkIcNPvwNlIYCxDxeQbckG4O7F
 9vr7PwBVs062AVEwDZxNPGD6wPY5/FqqyDOSmVf8RbyKPWi0IUbKVY7tPRFQBk4u/UGA65XH/oU
 mPneiUDjfNk+xpI2VZYaaytxqGSsDleIDzj6ZJLdaHsNYWKrKdT3fLywWRRssNT0OeVIVLwVOLV
 FBnwxpVq1zwH4sy+ICU+j3FnOpRCckuvx/UoyNQh4shA+Sp1jF/sV8+vF3s0bn3rGwgqQBoRESQ
 JCid8J+/wdXYqHElRDRsRU
X-Received: by 2002:a17:907:724f:b0:c42:aec7:c805 with SMTP id
 a640c23a62f3a-c49bddacb95mr311770466b.3.1793214887373; Wed, 28 Oct 2026
 12:14:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028-stdout-path-baudrate-v1-1-34281c1f34ad@redhat.com>
In-Reply-To: <20261028-stdout-path-baudrate-v1-1-34281c1f34ad@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2026 19:14:35 +0000
X-Gm-Features: AclHuK_gHckEgw54qXS1HF21DocOKNo0-ohUutEL5tKCTgP3BTjT83-Our1gEUE
Message-ID: <CAFEAcA9t4-UCOY5fWy7VRuz7fXd-A1Dfo=OrDoMY9y03MBbkpg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: use alias and baudrate in stdout-path
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 18:29, Enric Balletbo i Serra
<eballetb@redhat.com> wrote:
>
> Set stdout-path to "serial0:115200n8" instead of the raw device node
> path, so that Linux can automatically configure the console from the
> device tree without requiring an explicit console=3D kernel argument.
> Apply the same fix to the secure UART stdout-path using "serial1:115200n8=
".
>
> Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> ---
>  hw/arm/virt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d56197dacee..d93850feafa4 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1529,8 +1529,9 @@ static void create_uart(const VirtMachineState *vms=
, int uart,
>                           clocknames, sizeof(clocknames));
>
>      if (uart =3D=3D VIRT_UART0) {
> -        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", noden=
ame);
>          qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename=
);
> +        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path",
> +                                "serial0:115200n8");

Where is this binding documented? The kernel's Documentation/devicetree
doesn't mention chosen/stdout-path. The "Devicetree Specification"
v0.4 from devicetree.org says

"A string that specifies the full path to the node representing the device
to be used for boot console output. If the character =E2=80=9C:=E2=80=9D is=
 present in the
value it terminates the path. The value may be an alias. If the stdin-path
property is not specified, stdout-path should be assumed to define the
input device."

Which doesn't mention needing to specify baud rates at all, and sounds to
me like our current "nodename" is correct.

More generally, if the virt board's serial port is connected to something
virtual like stdout then the nominal baud rate is irrelevant, and if
it's connected passthrough to a real serial port then (a) our pl011
model doesn't actually implement that yet and (b) you would need to
match the actual baud rate the other end is expecting, which might
or might not be 115200. So what does this get us?

thanks
-- PMM

