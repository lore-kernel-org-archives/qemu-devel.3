Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD537606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pqvyeyuq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP04o-0008WG-1V; Thu, 05 Nov 2026 11:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xP04j-0008UR-Bd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:12:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xP04g-0006eY-HY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:12:29 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso266785f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793895145; x=1794499945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cThoCKzcNWHWVRzxPBiXG6CPz0sEKxtSG0WvkJPGTrw=;
 b=pqvyeyuqW0tqJCAB6SxmsTaiQqQh355PxQoQXef1D1efph0spVmdakv1MDtMyAMwx8
 UxFEJ3fUDOz+rQwVrVPvFmOCo/Y+jG7TFuDS36vPsJNXxKYQtUZ4x9JI8bMK7/Hs4tN6
 qvV/SMfFLZO7ehhepgmzUQOVn7boaaPKQKJO14eUvQ9JFmJctkeVSmreKZ6eZGxa2c0z
 FKeuDaJYP4KAXLGucrjFaDFXzZPkFH/sVeakDiaVf+vQK6kj/isZ2WRShGgU2dlwWZck
 qWBXjRmviiCk4OB9pJaFX99k0qk1A8rx7npP9+63eQqwwBt8oVRSwhfdq4LvTo7MWCXW
 ewCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793895145; x=1794499945;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cThoCKzcNWHWVRzxPBiXG6CPz0sEKxtSG0WvkJPGTrw=;
 b=ARD3dwYPWCpvUZF/Syctit0ncFhrJiD1hmja/E39iZet5MTjL+JMHMOOz0FVFcldJb
 b9I4rHGuuneUHeoVBZ14lZZpu12NXoFlC2exIvimOUNRs/LK9u0jLs0uRHEQOIemZUCM
 IaZNE/KPJJb1poRAZVNwu6p0zlejSmf1c3UzfN32WMeviny3TWeDUbt+worBIpk3BJkg
 gzcS6V9tKxctuYN4JW5IzuGo4FGTWsq6yxkxVVeU2uP5rnwvUEv1VL7c2czMBKcSOZfs
 cdQOa7uUfUqUb/muoUmQaGJjvQBdWaZuz8xXJ/xW98MOkAmAlhQrbpwcsw63Js/11Vwj
 jfwg==
X-Gm-Message-State: APuU4Z+3UPIzItLLTfmRzwcSeGFFBDFMM8KhfubEMzISH6BfsscqhGdT
 MX2hzROIHaJ7LbPVCzc5/Rx2lZLB9cxDIcoeq2sU1SpULIIpfma5bJQBlMyldN2TVvs=
X-Gm-Gg: AYBFou2gxe5TX3T9wQ0j+oI/pQtGuPWJdtS77MNDaMlsObvm0u96b3DZZK2xhthEVqI
 /4diLKh5t1pz/MZRSeTffN2MohdfL9MbWe+4jjB09rcWLihs7ZBSmB9RaDKox7ZIIQk9gdiCbPx
 tbP9wAZe1dIXMOcPOfwswwZ5ZLKlObAnpsTyus3ZjR3m+vsDZm6uEjfk6l5aV45AzS9IrJXgDSY
 fx7T72KJKdyxXKOXGFjueC505b/FWvHoJeuSxenjeAY2IhfQYQ2yhyfCHBWgR+DDlC11AWmDKuk
 l9D/626hk2VbaHRWZjgn1GT3xWOVXB1SAK8EruHzzmdjqVjg+aw8/c3+qce4QgvnYa+/7XZixrp
 l3T+Yst1SKj/0MYJPCLkro4asbeR7IvP5QmMyCUj7nbrkMRTqoA5kR6ocBzp1Nj7ZFTrdq+9bWh
 gpuP12cyTYrZE/zBiO26O2HU1TdzbB2ne8X2tFmSAEtIS+I/GHQFUYAl2ocs+p0v7aXYJG8u/ld
 UgFrmsfhwDjoiGBI3D1rfSWkRtztS8PKUW7p7hb0NJoLGDjlRu3sEOzuHA58Dud1j1ECpNe9M6L
 7jxzZ8TIQsId+Ez4Ll1BiV2Ry+QA
X-Received: by 2002:a05:6000:2486:b0:48d:ff81:5201 with SMTP id
 ffacd0b85a97d-49277f88144mr107115f8f.41.1793895144611; 
 Thu, 05 Nov 2026 08:12:24 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feeb5196esm9849698f8f.58.2026.11.05.08.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:12:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B5EE45F8AF;
 Thu, 05 Nov 2026 16:12:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  Stefan Weil <sw@weilnetz.de>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH v2 10/17] hw/net/eepro100: Replace deprecated sprintf()
 with snprintf()
In-Reply-To: <20261105125203.40320-11-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Nov 2026 13:51:55
 +0100")
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-11-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 05 Nov 2026 16:12:22 +0000
Message-ID: <87wlqr5kbd.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Replace sprintf() by safer snprintf() to format debug dump
> silencing -Wdeprecated-declarations produced by Apple clang
> 17.0.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/net/eepro100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index aaa3eb60f8ab..44eff5fd3ad8 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -369,7 +369,7 @@ static const char *nic_dump(const uint8_t * buf, unsi=
gned size)
>          size =3D 16;
>      }
>      while (size-- > 0) {
> -        p +=3D sprintf(p, " %02x", *buf++);
> +        p +=3D snprintf(p, sizeof(dump) - (p - dump), " %02x", *buf++);

I was going to say the whole function could be re-done to avoid the
static buffer in nic_dump but that took me to TRACE and then missing() and
I realised you probably didn't sign up to modernise the eepro100
emulation ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      }
>      return dump;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

