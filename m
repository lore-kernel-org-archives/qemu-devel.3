Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D44606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dqlk5Oxc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLIVM-0002wT-Aa; Mon, 26 Oct 2026 07:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLIVF-0002vr-Mi
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:04:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLIVC-0006Sk-5X
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:04:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so8688345e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793012668; x=1793617468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kEK8tkmyLWl6LotOTWVhW3sU1QgieqQDpBUfDDQPhA8=;
 b=dqlk5Oxc9Ne10LWSzCGRLTltD1/fmnwZtduN39rzCgQoivNU7Gw7+PsmEWJ71+NQZX
 paJX+64QSbDLzQIvku+MkJU6oPyD7lujfKwtlMxo5xvJDRal9mLvrCKgz8GgwkuYbMCH
 0EWE2mbmH5FO59gh+tF5AAhb49fW9R73Sa248FLvpWRS0gBxDHjNk782bae4VFhTh3zK
 4tf+uEccGpdAoaFkItgiSs1dhXZ3JOPM4n26rgVAGuSL8WL5HaTsAx06Qd87npW6djWK
 202uql6Vgc73W3+wTrraCRw5rPMxNaZRYP4fDh70R7ewYJsoHG+MzGUuDlAdjSo45SU+
 f6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793012668; x=1793617468;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kEK8tkmyLWl6LotOTWVhW3sU1QgieqQDpBUfDDQPhA8=;
 b=EZM79snNJnvETqmFZn2Bvifq9aACihNZbzb5Aru5kzE9xZYdSewlXlQLbUIr8g1WZy
 ruXCEUqUSB6sWGrksGKQPoqqQKilbVFN60M4V0q6C8Z6XnkKxG/ObrN54p89hXNQ0EAe
 s2sw/d9SrZbjIU13LnRwGXNbvgZwohv1k3wmpaBXBfzQd3T0or7j6rH3ovDTzyA+HS1c
 x9Ciwugbko4+JmNrFXAnwd3tKbjs+86pYBh2gOuQipYs7wVH3jNubqgEvx/oNeckSVxm
 HHd+qJYDCWeUzCpv/LCJbN3jXc0y3mNvZRJhBYFNQDd3jrLEyIPjUkG4yKh6QgftmZjj
 ojLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByvPR1IU5PWDxtMuszG51mlpTy7bZxE4T50HEwIoONGljmLYKQsda6nCgeTfQ0UURs0uagOZqsz/izH@nongnu.org
X-Gm-Message-State: AFq9FYJm20jeev6uSbj7FFO5a8jVDKJpYKlXkbSZhGIdfQTCuJvZbLVJ
 itvy9+4fOzn+gg7IEvHxEarJfM1yVS4KwE2wN13V2XPXgzotNzpvo/u5iDPisR7eaw2PFcdgUlY
 0dUZyvWM=
X-Gm-Gg: AYBFou0mjNfJ+iwC07VelvvJ97nvm/u4jTXhgHJi7ckH+W3ZyFER1Z1E0eAIf1cfchb
 0r3Ye1O5Lr9zmgLrBDUYj7Mpu7k+RyZ4i8cGzI2yvci0DPb2Psu/6R5yP3Z9LzKqgc/iCDXxhG/
 3LWivXPAvtLj3fbvaH+FCLBo8nZCSBHAU5GnIk9XzmwysF1HLbsDn0SgQicHNoU3AXShbhegxGL
 TSKhJmZgDgvUKMT9PXklYUFXhZDvx+Eb2DLvc4dC1Ajvoa4CNXPnlOSE8pn6jn/r2HNEqTdyU9W
 GuyXlf6efYUQfOLy5DL0Dkl+I/KZcCy2oIx/Ztw5zwSoEc8QXj7WRNB6GnX6ZbwCJkeEwNd+Olh
 wG923oMi7Uu2h2oauTz5bX1QJ5aL1Ei/uTg632YSLxzkr3ZwcVBYJXexITFGZZ+f5W/VdIvQxWH
 gNt+GvKczRV7vn/dAVtcc82l6mWea4ZHoZxJgai+Zd0Bl+GWlt7Qtyb1n1sCnIx82T9T1l/WvBI
 pmXA3J9cz7umoIxD9gm+L5Tgo4dhbgF86GmmaSbhHJt/PtEdIu/QEI=
X-Received: by 2002:a05:600c:c173:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a35acb9b05mr102166745e9.35.1793012668278; 
 Mon, 26 Oct 2026 04:04:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm186154565e9.0.2026.10.26.04.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:04:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D58A85F7FF;
 Mon, 26 Oct 2026 11:04:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: Increase the timeout of the
 device-introspect-test
In-Reply-To: <20261026092313.480889-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 26 Oct 2026 10:23:13 +0100")
References: <20261026092313.480889-1-thuth@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Mon, 26 Oct 2026 11:04:26 +0000
Message-ID: <87fqxs67ut.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thomas Huth <thuth@redhat.com> writes:

> I'm occasionally seeing timeouts of the device-introspect-test for
> the aarch64 target when running "make check SPEED=3Dthorough" - looks
> like the 720 seconds aren't enough anymore nowadays. Add 2 more
> minutes to give some more headroom.

What is taking so long, I can run all the introspect builds in under 10
seconds:

  =E2=9E=9C  time ./run meson test --suite qtest "*device-introspect*"
  ninja: Entering directory `/home/alex/lsrc/qemu.git/builds/all'
  [1/38] Generating qemu-version.h with a custom command (wrapped by meson =
to capture output)
   1/29 qemu:qtest+qtest-avr+slow / qtest-avr/device-introspect-test       =
                  OK               1.03s   6 subtests passed
   2/29 qemu:qtest+qtest-rx+slow / qtest-rx/device-introspect-test         =
                  OK               1.10s   6 subtests passed
   3/29 qemu:qtest+qtest-tricore+slow / qtest-tricore/device-introspect-tes=
t                 OK               1.07s   6 subtests passed
   4/29 qemu:qtest+qtest-m68k+slow / qtest-m68k/device-introspect-test     =
                  OK               1.21s   6 subtests passed
   5/29 qemu:qtest+qtest-sparc+slow / qtest-sparc/device-introspect-test   =
                  OK               1.15s   6 subtests passed
   6/29 qemu:qtest+qtest-hexagon+slow / qtest-hexagon/device-introspect-tes=
t                 OK               1.33s   6 subtests passed
   7/29 qemu:qtest+qtest-microblaze+slow / qtest-microblaze/device-introspe=
ct-test           OK               1.32s   6 subtests passed
   8/29 qemu:qtest+qtest-sh4eb+slow / qtest-sh4eb/device-introspect-test   =
                  OK               1.75s   6 subtests passed
   9/29 qemu:qtest+qtest-alpha+slow / qtest-alpha/device-introspect-test   =
                  OK               1.90s   6 subtests passed
  10/29 qemu:qtest+qtest-sh4+slow / qtest-sh4/device-introspect-test       =
                  OK               1.81s   6 subtests passed
  11/29 qemu:qtest+qtest-xtensa+slow / qtest-xtensa/device-introspect-test =
                  OK               1.77s   6 subtests passed
  12/29 qemu:qtest+qtest-hppa+slow / qtest-hppa/device-introspect-test     =
                  OK               1.89s   6 subtests passed
  13/29 qemu:qtest+qtest-mips+slow / qtest-mips/device-introspect-test     =
                  OK               1.86s   6 subtests passed
  14/29 qemu:qtest+qtest-loongarch64+slow / qtest-loongarch64/device-intros=
pect-test         OK               1.90s   6 subtests passed
  15/29 qemu:qtest+qtest-mips64+slow / qtest-mips64/device-introspect-test =
                  OK               1.89s   6 subtests passed
  16/29 qemu:qtest+qtest-mipsel+slow / qtest-mipsel/device-introspect-test =
                  OK               1.88s   6 subtests passed
  17/29 qemu:qtest+qtest-or1k+slow / qtest-or1k/device-introspect-test     =
                  OK               1.89s   6 subtests passed
  18/29 qemu:qtest+qtest-xtensaeb+slow / qtest-xtensaeb/device-introspect-t=
est               OK               1.82s   6 subtests passed
  19/29 qemu:qtest+qtest-sparc64+slow / qtest-sparc64/device-introspect-tes=
t                 OK               1.88s   6 subtests passed
  20/29 qemu:qtest+qtest-mips64el+slow / qtest-mips64el/device-introspect-t=
est               OK               2.08s   6 subtests passed
  21/29 qemu:qtest+qtest-riscv64+slow / qtest-riscv64/device-introspect-tes=
t                 OK               2.24s   6 subtests passed
  22/29 qemu:qtest+qtest-riscv32+slow / qtest-riscv32/device-introspect-tes=
t                 OK               2.35s   6 subtests passed
  23/29 qemu:qtest+qtest-ppc+slow / qtest-ppc/device-introspect-test       =
                  OK               2.46s   6 subtests passed
  24/29 qemu:qtest+qtest-ppc64+slow / qtest-ppc64/device-introspect-test   =
                  OK               2.89s   6 subtests passed
  25/29 qemu:qtest+qtest-arm+slow / qtest-arm/device-introspect-test       =
                  OK               3.26s   6 subtests passed
  26/29 qemu:qtest+qtest-aarch64+slow / qtest-aarch64/device-introspect-tes=
t                 OK               3.49s   6 subtests passed
  27/29 qemu:qtest+qtest-s390x+slow / qtest-s390x/device-introspect-test   =
                  OK               3.74s   6 subtests passed
  28/29 qemu:qtest+qtest-i386+slow / qtest-i386/device-introspect-test     =
                  OK               5.36s   6 subtests passed
  29/29 qemu:qtest+qtest-x86_64+slow / qtest-x86_64/device-introspect-test =
                  OK               5.42s   6 subtests passed

  Ok:                 29=20=20
  Expected Fail:      0=20=20=20
  Fail:               0=20=20=20
  Unexpected Pass:    0=20=20=20
  Skipped:            0=20=20=20
  Timeout:            0=20=20=20

  Full log written to /home/alex/lsrc/qemu.git/builds/all/meson-logs/testlo=
g.txt

  ________________________________________________________
  Executed in    8.20 secs    fish           external
     usr time   30.44 secs  871.00 micros   30.44 secs
     sys time   21.28 secs  160.00 micros   21.28 secs

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2d01837ff29..540aa5fc8d3 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -3,7 +3,7 @@ slow_qtests =3D {
>    'aspeed_smc-test': 360,
>    'bios-tables-test' : 910,
>    'cdrom-test' : 610,
> -  'device-introspect-test' : 720,
> +  'device-introspect-test' : 840,
>    'ide-test' : 120,
>    'migration-test' : 480,
>    'npcm7xx_pwm-test': 300,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

