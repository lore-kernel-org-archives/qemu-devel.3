Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA38DCCF9EA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 03:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEJoM-0004cI-0L; Wed, 29 Oct 2025 23:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEJoJ-0004bm-V3
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 23:58:51 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEJoA-0002IY-Lo
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 23:58:48 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b64cdbb949cso133650266b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761796718; x=1762401518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ra9qUgDea4oKl33xzGequJ4DqMuIUibU+BNR0ZsASRw=;
 b=VgLhX3SRdO4xxwGTk1sWvPIIhBdOEVSVG6r3tjsM9SxIKDGvXmxVpQanCE/wXHzIDZ
 YV+oOXR6K9QGzISJi7SZFzXr/o3YNXM/e8yhaBU+7LtC4Qflz06gkWbjLx042DaQCXXq
 pXUpvvOvMKImv9SMBKsbYeuhingTBv1WrNMFtjTRI9S2UXkfm/gtTd5xB2UFC0Fzj19s
 54D8sqBjCVYgHMbh56i9qa261MBc+NSeXOll7OLHClwMereqzUxEDvT7sc7073bb/7D/
 qJS32669ynM9ns+A74prRZ0yLBLLtnm313lCW7TpeE+yx6yjSFWng2/g8TyUQPUbsJF5
 AZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761796718; x=1762401518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ra9qUgDea4oKl33xzGequJ4DqMuIUibU+BNR0ZsASRw=;
 b=HwrM05H5RkkrCa2Cv9AT68dXEfp7I7Ibsl4IyQI16kMTP7WRx+uksJDtL9XUTUanri
 1x+N583S1+YD9P3bcblpjkDqQE2kLUBeWAsu1TIIf93fDbG+re73VCk+8+oC96GYYt80
 vUOKZ2ufHal6OwjOWOE2kcgubsMf66pbOhzHnwyNshu6gLkvAXb2KLGmn743WS1h8/+m
 naXXS9OcZsx/aiHvC9CEcKmR9CVBZNLX7e4lnEeqZhLKiDQ0gjvQ4/0NMMmdtrY/g5hY
 aqKNaEC9S+TTfwXy2e+G6eWRYpiDGQpZg60HJSBzLIH7nXhAcyfRP6OGFdJsrgCUAo6u
 rzEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDxU7UTNZYDTijwNAy2ATUHUNACbeHQ5O5JGzIIoE346jYQptwHdcUAKylgssLvj33KvKOygxpOW9s@nongnu.org
X-Gm-Message-State: AOJu0Yx7FnlaJ9FNtCJmpV7EVSNmk14xJn5IE0J8pnlOjQ8mt/ny/vKP
 3zPK3dzBkfPklzZUx+w36lYxE85AsoFa9zG1J3heJk3krJDIs03YV7EQatkp6lio3vG0IXwICu2
 I93TJz7xpFA/C7MThnsJCZLj2nnj0sL4=
X-Gm-Gg: ASbGncuRLD18a8fLhVmhu1uXItrmdZmtpQ2Vpxkv0rMe8ShiPVl9LQ4VRPDMkQWMMdj
 FreY/MyBvsUz5iW7x7M9EQlHJNQoLJBWOqOV3x/Eau8dXJwhLtnBQJKti1V5hZcPQRgqcS84NAZ
 I+Qrb52gJwDUbZlWq0RI7m/EjFy7rvWk7xlZGh6OpwMXON1c3t221ojiOXP+gU5+Z24uEoJxaJl
 YvwNbK5Q+Sl8cTYxwwmk1T61D1pyfCD42LSF5OpMrEYPjQ7ESwud/ztHiuccsm78S3PR1WWwr15
 pyqMvEqlbeM/2Rc=
X-Google-Smtp-Source: AGHT+IGBH2jQwtWAlZi4rqnhfwr2g/dPAQ5s/91fRWHSqEbW75AfIDkYYia+0A1bPyeh1At2J+rryca10xRj94cTppo=
X-Received: by 2002:a17:906:6a2a:b0:b0a:aa7e:a191 with SMTP id
 a640c23a62f3a-b703d5fa89dmr602228466b.57.1761796718073; Wed, 29 Oct 2025
 20:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251027112803.54564-1-thuth@redhat.com>
In-Reply-To: <20251027112803.54564-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Oct 2025 13:58:11 +1000
X-Gm-Features: AWmQ_bkXDcw830nZ8jomMV8HJqeeNF80oI26AZ6r3ccjkfiO2M2H2yDsJuPgAq8
Message-ID: <CAKmqyKONHJBpfCi-C6KUFOXmNG2N4gOSLTTwPhou38YS2C+miQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/riscv64/test_sifive_u: Remove unused
 import statement
To: Thomas Huth <thuth@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 27, 2025 at 9:29=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Thomas Huth <thuth@redhat.com>
>
> skipIfMissingCommands is not used here, remove the import to silence
> a pylint warning for this file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  tests/functional/riscv64/test_sifive_u.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional=
/riscv64/test_sifive_u.py
> index 358ff0d1f60..847f709da12 100755
> --- a/tests/functional/riscv64/test_sifive_u.py
> +++ b/tests/functional/riscv64/test_sifive_u.py
> @@ -13,7 +13,6 @@
>  import os
>
>  from qemu_test import Asset, LinuxKernelTest
> -from qemu_test import skipIfMissingCommands
>
>
>  class SifiveU(LinuxKernelTest):
> --
> 2.51.0
>
>

