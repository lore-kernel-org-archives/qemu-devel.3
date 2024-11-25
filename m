Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD4AD3B7CA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 02:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFPBZ-0002cj-Vp; Sun, 24 Nov 2024 21:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tFPBY-0002cX-Rc
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 21:50:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tFPBX-0001og-9m
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 21:50:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3823f1ed492so2680448f8f.1
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 18:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732503045; x=1733107845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUJbZS3C7fmzQr1Tn+81Zq025uSX+jp9kLROGKOS1kY=;
 b=hBQ7x9m6tC9i792XbkRWEM/1Qc8OxjupzHGqAd2fio+sx4JlkSOXZ+Z8avkqehtbre
 ymGCAuN4q83qO3wCUWMYWOlP8XRefheI7hNFD17K60bn7wq+7bDs0XwLgfCAnqgmZwPy
 mkS9xyE22qNbwyawMPrvfC6tIv6YxWz6BccUBc1+cTq8h8x+a8St0rHSK4f4CAf9QFD0
 K/zonTSXp8tE/r3qYyfGrHG3dEUaopAWpEGgnSSPic7AR7bxnL0UmiznC2ZlMICgaCq6
 4mESDrRhEjfMDjJXKrvcxwQzdNeYY3E+ev4bZ6h9k+WPu2cb9kzzsvYim0FeEG2bxf7R
 Xgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732503045; x=1733107845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUJbZS3C7fmzQr1Tn+81Zq025uSX+jp9kLROGKOS1kY=;
 b=PIKI1qID8Uwd+no0idOPWCchDsLOr8gKlxjIM8/waPtBkj4aWEB+uImlxGx+3D8Ss8
 lFwEIsNf0IkuHY3UYylUU5UDyA6SYp0N37g9MXxdv3wMrIq3nHy2nY4IlZnWseus26kk
 7L6M5rsmNVPjxN9gblEs4kwGwh+4D19V3duWJSt1M3tYLEN68luljC9kTjoEEf6Xjbwc
 IKGuICtsxBvBAY/ELdYFQY+0W0dqTXjG0xzrRwf6dvfeAamYQCPNV2HTdWPjZVtuCCFF
 /jh8tAF4fQAI7ZiXuy+PHE5Vdg/MfSCAkCF0nIsW3H8opEF78ajCp4/o8u0kc+Lvhgxj
 heyg==
X-Gm-Message-State: AOJu0YzRoWzzGZ72rDn6JwNY+kx64cGiiYbLd/Rc9ivPVH9yarLADG0m
 naG/5ljh+LDi/lvOcGf/td3fym5XDxKazX907mjCkVLzKCuyUKAoxxaMfSrR04QbgnBNR/+jy6e
 NtnoMPTtm4oHOGAU2SMGuyAWBcLI=
X-Gm-Gg: ASbGncuQG7kuKcp9A3UIR0E32VimkZlK5ibfFXVGP9A3yY0w+IEYKhaWk/gTZaEGOQh
 N/AMmsyCCsMQu+fKEyy2ht9VrRtFsaSs=
X-Google-Smtp-Source: AGHT+IG0PfVw8i323s2yaFk/ubjuQt+AROo/WH3zStx0XZsbDsuyfwgdpXSddh8YcoKpmnZBj5lJrVPJ6uJ3NfCmpl8=
X-Received: by 2002:a05:6000:1545:b0:382:3efc:c6de with SMTP id
 ffacd0b85a97d-382601132d7mr7128793f8f.3.1732503045159; Sun, 24 Nov 2024
 18:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20241120151515.56884-1-xndchn@gmail.com>
 <20241120151515.56884-2-xndchn@gmail.com>
 <4d3f8a83-7c03-4b48-9a84-d99b88b0d47c@linaro.org>
 <CAJ=gGT3v9WrDButDKP7C_6b7dLnX7AS0Gfyy5x1cLYunJqWBwg@mail.gmail.com>
 <501e74e5-72b1-4d0c-8e22-c213dd4a75da@linaro.org>
In-Reply-To: <501e74e5-72b1-4d0c-8e22-c213dd4a75da@linaro.org>
From: xndcn <xndchn@gmail.com>
Date: Mon, 25 Nov 2024 10:50:34 +0800
Message-ID: <CAJ=gGT1B8kC7tzT0dKbZ2053e8fQZS82qfRT9CHj2xWpONf7zA@mail.gmail.com>
Subject: Re: [PATCH] system/physmem: Fix cpu_memory_rw_debug for armv7m MPU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=xndchn@gmail.com; helo=mail-wr1-x436.google.com
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

Got it, thanks.
It seems like there is still a lot of work surrounding the API, so I
create a issue to track it
https://gitlab.com/qemu-project/qemu/-/issues/2697

On Mon, Nov 25, 2024 at 5:23=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/23/24 22:30, xndcn wrote:
> > Thanks. This patch at least guarantees normal read/write access to
> > addresses with r/w flags, although there is still a risk of
> > misidentifying accessible regions within continuous address spaces.
> >
> > Actually, initially I did write a patch with a modified page size as
> > an argument, but I soon found that the current implementation of
> > armv7a (pmsav7) will return the page size (lg_page_size) as 0 in many
> > situations (such as overlapping regions).
>
> 0 was arbitrarily chosen as "anything less than TARGET_PAGE_BITS".
>
> > Maybe we can simply make the page size as 2^5 (minimal page size) when
> > the returned lg_page_size =3D=3D 0?
>
> No, don't lie, or make unhelpful guesses at the generic level. The only t=
hing you could do
> for arm m-profile is give accurate information, which for now will be imm=
ediately
> discarded as *still* being less than TARGET_PAGE_BITS.  But I do have pla=
ns for that.
>
> Anyway, nothing you do with page sizes is helpful along the debug path.  =
For that, we need
> to swap away from "pages" to "ranges", where some ranges are in fact page=
s, but others
> aren't.  This means changing the API for cpu_get_phys_<something>_debug.
>
>
> r~

