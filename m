Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C2606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGmEkAzD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMpq-0006sb-Q0; Tue, 17 Nov 2026 12:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xTMpm-0006mG-Av
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:19:07 -0500
Received: from mail-lr2-x08.google.com ([2a00:1450:4864:38::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xTMpj-00074L-9u
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:19:04 -0500
Received: by mail-lr2-x08.google.com with SMTP id
 38308e7fff4ca-3ad8a138a11so423261fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794935939; cv=none;
 d=google.com; s=arc-20260327;
 b=m7LK/Fxo5WMRqKDcgH/uU/4PuUcuktOOdLMsz2rDXt0j9xxD6yqdPIQCBJFYtRZXER
 1ilEUdDb4SYdpPtAbUzfBJqA+Rc4vburrJ0c9eyS01pldRaFbX4GVvnGkyL0miRmbgBV
 Avk39/59y1XnQcSlkcdTXui5r7EXewG546lX8TslqPRCa+Hq4C55w/eB5K1v1JYoHFW/
 e5YHZsBKRc4SWb2lhzI11/ETIZQ2R3wvwys97rxgO5UgS7TfNT+mu8WQ4LeOf4pt+OXW
 n1w82Rf/Wc3HTGZDhEjXm/NcdKv0sfEooC65kZN9+zGKYMqkZIvQJm8NWmPkaP9qVJKF
 u2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CSBMjVt8o/BBJbawu88h/nGiV8IS15ds2LHtBjYxnQQ=;
 fh=/HwHFVvkDzUHizvHLWnm7TU7KUV4jwA3sQcIhUkfdF4=;
 b=I4l326wLRZBo153+/sjGvIHCx/xcvOBfLfUu3dPJle3dQARPRwv7zcV+dtq9dl63PC
 XcvAHO4ZAf69JjEUphugvUV/GrXhMyksEdZT9wr6krN/68XxU6uL00Rg/F8fk0OtCpK0
 Z5VzHNRZdo/pdwiU2V347qCXzTY3J2jXpfHsiPqO5SJ0ljsma23Mawse1YpvE/maAN8m
 961e/wQ15kXTyr5lawFZjIbkDHt5UeODbMjR4aZLKGYeXN5lgQ6i9nTDX1tMd1nnYU8b
 yF/Vk1nvuyXd/vD5cLhV6yoW50jylqC1D/mSHOjBqyBf2bxRmBL2lcXEUfAn6uuZYD0r
 TFkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794935939; x=1795540739; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CSBMjVt8o/BBJbawu88h/nGiV8IS15ds2LHtBjYxnQQ=;
 b=IGmEkAzD+2IJimxmtJM1ZhJBOkZXcC+NK3TbCxeOXp/ObVz9GqRIFU3LP/vj1c8f26
 eKzIxE93IHSaZjuFmBK1Y5fe6OX4nHTmyvCkv3SpPkfh4xxBNPgG5qZgR1cOXM7LZ4Cl
 5mmmMp6BAe6H/tihag9TUglkk7qQKkkv9kCPUdgO13zr1zamxjIZUieJ/jvpEqAOOShu
 fMHDMr21gKDyZoo4IdQSCF4sBKPwpLRSnmx9WL75uU3pyadHR9TBmTit9LTl5NzMxj2t
 ZKu91xbH6APc4lUHTtbm3kbawtNtSN418G+GeVnKVKT/udBhCcjAkwI+KtXdIg30lgCf
 +wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935939; x=1795540739;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CSBMjVt8o/BBJbawu88h/nGiV8IS15ds2LHtBjYxnQQ=;
 b=LSFZq+J3axTAI4UeSysCTKAPjY7AuGJxoDwI4pdFwL90ZniyoLq+HvVSdgfL2h4yVl
 UP8TwvUXwG5fuKFywsiMMBlrD6HwzHUj/E8AV4jIsH6XoFDIC0nILalWz+W8jQQAaaDg
 /TftosR0oN2lAOsa5dGT/TxrGZGKiQsNQej+GebegH7cZ4ErOAkm0C89Mgsmxr5pQ9X5
 UrVgsGUa7jh0fsTaahVgATn4orqb9/HfSMfVmFcBIkg+0BdrWKj3NLihfcGfWYx4GIzW
 GdMBKbi/2bLfwn84AllhHss8ZA5/a3WVQ1w2jrK6F6rzITnuqyeTkNf7GIe7UX4hxWbD
 NESA==
X-Forwarded-Encrypted: i=1;
 AL+hErGEyEUX+bIGxOxuBG95ztEQvBgZsa7QoSBTSs3xM/+0LuaMi1Jx87FWIzfc2GrneJrcmA7i/DjkS7Ka@nongnu.org
X-Gm-Message-State: APuU4Z+viCyjNhG4utWvl1zk8EPAxoYsC7mif/RMt328WrjQikuNCOin
 W3tyuC3YJKXuygugXLHhmFPg8IT9CGMG5b0VK6vfHg5MhzIJOqlZXIxpiGthbxEygfcmKoxqeY6
 PPcLfXVKVjbXGoDzrGeQU5NEQCYsVdtI=
X-Gm-Gg: AYBFou3gsLwfxAM+RY5T7AsOnHbgHL2oMXfirMCXP3rX4E7UultjvLn1KpDPGaQPXA6
 1On+rdTm5nnmdE0PLd8QA2A0hMcv7iBSu3Wo15uAEjT6gZlbq3GWcmFte/itw208ICXOR4tbDWK
 0hylhOnH6DrHqcBOpoocptdqWSa2BQM1QPgkQ37qhQGNiGb4vubn8SxD+SCXjOIY2aA00xftvvw
 thfE/y9bgZdS0RfvKSCCZkgl03YIHh98YJddc8QjTaXbPRyZoOsuI5dUAUllP6YWmUC7THzv7Ij
 8s+nqE9EUcuMsANTisj2YJvxpOUj9p2oo91c5LcIAiK/Nm+LX7FuU1/5mzQoac/BZEBJr4YU5kY
 9KERO98KwvWXpBHbWpCkx4Xh3YLsilaDuSUdbZA==
X-Received: by 2002:a05:6512:3da7:b0:5be:41a1:d2b5 with SMTP id
 2adb3069b0e04-5c1709f99famr5747239e87.53.1794935938953; Tue, 17 Nov 2026
 09:18:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117133750.322253-1-pbonzini@redhat.com>
 <20261117133750.322253-15-pbonzini@redhat.com>
 <f385f947-aa36-4e13-aac4-1602b4844b76@oss.qualcomm.com>
In-Reply-To: <f385f947-aa36-4e13-aac4-1602b4844b76@oss.qualcomm.com>
From: Zixin Wang <w1355457260@gmail.com>
Date: Wed, 18 Nov 2026 01:18:46 +0800
X-Gm-Features: AclHuK93Z5v10_eai8RAM0HlJ2ZeoF7nb5ju0YyOgDaoTHpKzB4SSI818XjrrEs
Message-ID: <CABG6VKOJGsT9Fsw3qEY9swX-c+-oi4j2QSugkPqH1RUBb8SzZw@mail.gmail.com>
Subject: Re: [PULL 14/15] target/i386/tcg: treat ENTER's size operand as
 unsigned
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::8;
 envelope-from=w1355457260@gmail.com; helo=mail-lr2-x08.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

Yes, "Zixin Wang <w1355457260@gmail.com>" is the correct name for the
S-o-b. Could you also update the author From line to match? The "z Y"
there was just a stale display name in my tooling, and I've since fixed
it on my side.

The patch content itself is unchanged, so no need to resend anything.

Thanks,
Zixin Wang

On Wed, Nov 18, 2026 at 12:24=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 17/11/26 14:37, Paolo Bonzini wrote:
> > From: z Y <w1355457260@gmail.com>
>
> Zixin Wang <w1355457260@gmail.com> as S-o-b?
>
> >
> > The first immediate operand of ENTER is the size of the dynamic storage
> > area and is unsigned.  Decoding it as a signed immediate sign-extends
> > values with bit 15 set, moving the stack pointer in the wrong direction=
.
> >
> > Decode it with I_unsigned and add a regression test covering 32-bit and
> > 64-bit guests.
> >
> > Tested with a minimal x86_64-linux-user build; the new test fails befor=
e
> > the change and passes after it.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4643
> > Signed-off-by: Zixin Wang <w1355457260@gmail.com>
> > Link: https://lore.kernel.org/r/CABG6VKODisrETOuH5thhimg_DtJLH+1wmARKL5=
OsoND5Qse_TA@mail.gmail.com
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/translate.c      |  2 +-
> >   tests/tcg/i386/test-i386-enter.c | 42 +++++++++++++++++++++++++++++++=
+
> >   target/i386/tcg/decode-new.c.inc |  2 +-
> >   tests/tcg/i386/meson.build       |  1 +
> >   tests/tcg/x86_64/meson.build     |  1 +
> >   5 files changed, 46 insertions(+), 2 deletions(-)
> >   create mode 100644 tests/tcg/i386/test-i386-enter.c
>

