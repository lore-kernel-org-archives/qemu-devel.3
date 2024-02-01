Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9B9C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbQl-0003qa-Il; Thu, 01 Feb 2024 13:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVbQZ-0003jI-6C
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:04:46 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVbQW-0002p1-No
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:04:42 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55eedf5a284so1606803a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706810678; x=1707415478; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SP1wbre1TKg8XYIERNLlFsNP6c4mIeB0Ldh6ArJkWqA=;
 b=a873KP8SP1WCw23+2NWwcWkSmrh815ExfW0cw3j+7JNmOQff6beihmaXguqNoEWaD6
 0YDDJq2FIPbWfIY5brs+NPcWcAbxUB8orwHVzQdWdsirpo70UaGiPYKtHiKH5hfbwNuJ
 pKM/p1UWA6GoCC36KU7NogUUF78ASeysLs5gNBEtF38IwX+YQaJNeTfHEZ1+AWXtpoac
 9+TWICLl4UgD3c8T9FUyvMK5p3BY9ivlfb2wmjpVSRJqEkKqUGES/tMgV3rJAtb5gOAV
 WdPbhSFo/s9Hq2idXcy43017ojxZ+W6WX/szeDmGMOTn3+XrBV6oC4ZKCa2uQNnb8097
 flJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706810678; x=1707415478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SP1wbre1TKg8XYIERNLlFsNP6c4mIeB0Ldh6ArJkWqA=;
 b=ZWPYv1dFUxdrRbW5/lKy1Z++cIPDlZw/Wm9j9pTG3ghS94qjF22lmfdgx5EA0N7dGU
 6oAx5HtfXORYf2V3Z/FBkI+JKXEjRLpZeI+7hyzSb6/Rzieijs3/JELhDLw2sdoP+FR+
 +xRvX9rHpy2L8YzZtzit3cdkxRWJKeoG0e/2kBRccnnqlFaF5wCJUqrfEMdScRsnMd2k
 R9aM6wT9l4abdXuQtfujm+cr9vE1fzYDu+zpGm3J/IvKjV+707EQ6CWO2Iwo9KNOHxK8
 hprrMF0XnJnYS3eM9ss3N8WIfA7S1mIkU22nsibVA1V6nYtY/nXQzUqB6PkbhWqt+Ii4
 Wdyg==
X-Gm-Message-State: AOJu0Yy3iulSl1hP6qD4zq71uixI40RgEmaalOs0iNzOpOdKn0zRMeej
 zVVWexI52Rcp4um/dHPITN2ENUJ4EQFNqv138nKzQpJuvzazJ6Bg0KkUNHvg4/g5kk6Pt6RNqGk
 btZPIYfPRjMJhgrk5v96/+UOUlyWmrL4JOHQ3Vg==
X-Google-Smtp-Source: AGHT+IGzy1N72I2rrCXG/4KcOL+tTuBhKhzU4Dn2aVeMwt1jgyd54zIHxLMa8oKrJV9epVOmokiWm0YaKX3KPZFh+DY=
X-Received: by 2002:a50:fe83:0:b0:55f:e35e:137c with SMTP id
 d3-20020a50fe83000000b0055fe35e137cmr173322edt.25.1706810677883; Thu, 01 Feb
 2024 10:04:37 -0800 (PST)
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
In-Reply-To: <87r0hwjdvl.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 18:04:26 +0000
Message-ID: <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sajjan Rao <sajjanr@gmail.com>, 
 Gregory Price <gregory.price@memverge.com>, 
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 17:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> >> > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D2=
3937, val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../ac=
cel/tcg/cputlb.c:2853
> >> > #22 0x00007fffa9107c63 in code_gen_buffer ()
> >>
> >> No thats different - we are actually writing to the MMIO region here.
> >> But the fact we hit cpu_abort because we can't find the TB we are
> >> executing is a little problematic.
> >>
> >> Does ra properly point to the code buffer here?
> >
> > Err.  How would I tell?
>
> (gdb) p/x 140736029817822
> $1 =3D 0x7fffa9107bde
>
> seems off because code_gen_buffer starts at 0x00007fffa9107c63

The code_gen_buffer doesn't *start* at 0x00007fffa9107c63 --
that is our return address into it, which is to say it's just
after the call insn to the do_st8_mmu helper. The 'ra' argument
to the helper function is going to be a number slightly lower
than that, because it points within the main lump of generated
code for the TB, whereas the helper call is done as part of
an out-of-line lump of common code at the end of the TB.

The 'ra' here is fine -- the problem is that we don't
pass it all the way down the callstack and instead end
up using 0 as a 'ra' within the ptw code.

-- PMM

