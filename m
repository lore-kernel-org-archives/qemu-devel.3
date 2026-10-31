Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF809606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOyIjbRo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN050-0006Q8-U9; Fri, 30 Oct 2026 23:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN04y-0006Py-Qz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:48:29 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN04x-0004XP-4P
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:48:28 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3ab3dd9670bso12101691fa.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418505; cv=none;
 d=google.com; s=arc-20260327;
 b=jPofdu8YW4sTzlQtztBj/gLzyFXEG3zeLiUar5GLWhig4CAmYkWkgfddUbBqofbIdj
 Df2uXWU3uow0+FIZBupzP8W/ni7FGzaTHX+MX5RUxIWnAYsx2+W/VKHRJzYrVzCuMPJT
 Bg5yvd1V8IWPJPDotE3lIx7sELjxJY/Fi5EEsRvTNoyTTfyuIyD0xzOqXV1GerUBtjjm
 jH07UlucKCQsx9/abzeVWZr/pu8ltYf5xD+LcY5d2u4w/Eon51FmVbCMw/fa9w7fJUpL
 EM2XPDJGkX/z1S3GKGksTbWIFHo5vnO5SF+OfAbMcxb+boUD4bYl5LW6LbwmedhLraM5
 HrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GYEdyPbOh31NQ28PRtFb/nQwOWBqjP6BqeYNQFgCCfs=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=qNmaQ6K5uiRWXsQ1l11lB7Q76zhR7y6kHtRgn05vUwAfCtdjmmgh83GbGaczVhT+mZ
 QlNkYqTypeF91I9cOfDAAp3H4riNNv9JSqjCWluQmzBARDc9sTn7snsrFX3wrMBV5HGY
 0Tztm4tLKskPhInPVaaxlRY+oZFTqGmzNu2WqrqPT2Jzrdhu7JiuMRzkoAbsTex7y0X0
 +AtS1ZHDpw87FS1+E3IZt7OSzDHhGFec3RyVVZDJlfg8tTtXTkiKDtP1DmShyYggyBS/
 pXNzlkfGE7MNIdExVMhSdIFXYvzvDxGz3WEw2zOhVUmGCu22RNFnq8RzLvjVNtIBUNW5
 3wvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418505; x=1794023305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GYEdyPbOh31NQ28PRtFb/nQwOWBqjP6BqeYNQFgCCfs=;
 b=DOyIjbRoNvgAO51mADFZ1BgSu1acL+H9hbfPZmzZiE7MI1mxRLtuqSOkJIn7BT7fz8
 CL/NkYGtgHaHjVVZZtjsxLmW8h+kFHeliotJr6MHMgysMfScJmjCFEN2sC5GVV68Rit8
 gtB9xsp65ofE0Qypt4f7eYI4xow1LwGjFoOeixrbKAqPWwpvqtYuBTD26rNv/wEEAuBe
 wAecxXiAP/mMF66k85e/RibW160bjbyNgS/8BYH4zhS5vRDMRxHjfihYCI8euCD6tyQr
 f2OS0njmr4Tu/dE4mvz1ZBhBQxe91DueJfm5xY1bpnCd/TF0j3VJL8Jlg9V39T3pdiZu
 qOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418505; x=1794023305;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GYEdyPbOh31NQ28PRtFb/nQwOWBqjP6BqeYNQFgCCfs=;
 b=mMJh3blF7AWCRZBOtV1DYGhoTbVay6YaBgmCRVA83gG9P0EkaZzAD4Bu5Y00oN0QI0
 Md9UYff3wqhgNUR6LxRyI0fPVuIs+UMc7V1Sq45XOHXmTpUz+mQy4CxWzw95lBC1GOu5
 qFFCcJaRe9NqobeVWiN0nRrjRM/QAUJ4KAIhFHL4Wo8qSWr8xOshrE8okS3xpc6eAfFW
 altI7jCmSBtNUsxiErurTgpm1z5MFHMwY+4SsV5HebBUQSUJjk/zyhrP3dv22PBBp87O
 Jj4G6aGwQYHAVJynTUtsUj5vOkuq/Kh9xD4xDBi4qvnvxUB+nMmBk7/AIwmPBpp+Z/iQ
 MyLg==
X-Gm-Message-State: AFq9FYI2rBi7dfLr+1xY2/GZFq/X3fiiZ3LweFki/YIs1EwRTFqb7vXh
 F3cSQHQySYC5/FZmFRGqPOHhLZx66sewnKdymN/1yMh4zR1WfvIvhiTfblCfadqTVEacc2hEKzD
 +ThCFQNw94Fun4H1efl4iA1czOLyvw/g=
X-Gm-Gg: AYBFou28n+86brpaH/VyAHFVJ4DG22BkvkCXF24BnoI61L/gdAqzR6WKPqyTLi6cyyx
 ljEHuY6zh1ikCOWG5DJOGovqSTKBdn6lmSpoVJ7dak3F+QC7dwRCzTxtEiDWwdlmkFEyftsIbvb
 Icr5R4pTpVBHBN1AJOs9tYHsuX3CIY3oyXYFmpG7TjffnLCYjVYGySfLAiJ5TyooSU6af2weNP3
 9lve6KDw7pIthLDEDu5EbhSo0BYXhTiQuMKUiV3N0/pL/SB6CG8qIe8YK8Qltm8QIZa1wfY+BR/
 kaQR+i6poaBRDfYSA1aSHD82MRe4ToXsiWwtur6dAiL4WRijZYJmDYZIj8Tv3YK6bN1oCQhQ6Vl
 oCLdCU1yIUp9/YRVyKPWICN302qmYC2Y5yLScn6ZbYSau82HtzSTCrlqAaPZa34uMxG54Sx8QUJ
 pyRZC4PGP/SxlVcfIHQ845MKyufmeb3WYazPlTm5orEjnfs0clOvcM
X-Received: by 2002:a2e:b896:0:b0:3a6:4452:bff1 with SMTP id
 38308e7fff4ca-3acb7a65e2amr9342521fa.16.1793418505292; Fri, 30 Oct 2026
 20:48:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-11-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-11-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:48:12 -0400
X-Gm-Features: AclHuK8f2MyLlGyYFtBzCvBc8dZ595mD9YaKvFgMdMCCK9kmWt-U7_A8uOgVKXY
Message-ID: <CAEdQ38G7W9PDX0OpMLRrYXvP=4VRAbCHvxWANUH=fo_PgT3dBA@mail.gmail.com>
Subject: Re: [PATCH v7 10/14] tcg: Add INDEX_op_goto_jc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:56=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> +   * - goto_jc *jc*, *pc*, *cs_base*, *flags*, *label*
> +
> +     - | *jc* is a CPUJumpCache pointer.  Generate code for:
> +       |
> +       | if (jc->pc !=3D pc) goto label;
> +       | tb =3D jc->tb;
> +       | if (tb =3D=3D NULL) goto label;
> +       | if (tb->flags !=3D flags) goto label;

*flags* is the 64-bit flags:cflags pair, not tb->flags, and the backends
load it as one word. Please say so here, along with the host-endian
layout. *jc* also isn't a plain CPUJumpCache pointer: it's biased by
hash * 16, and the backends use array[0] offsets from it. It also needs
the "This operation is optional" line that goto_ptr has.

