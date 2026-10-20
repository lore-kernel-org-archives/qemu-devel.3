Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4A606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NEGvqXDz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ5uu-0005WD-Ut; Tue, 20 Oct 2026 05:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJ5ur-0005Vv-5d
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:13:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJ5up-0004tZ-I1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:13:52 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so4256982a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792487629; cv=none;
 d=google.com; s=arc-20260327;
 b=L2zU79VZc3F+hqxGI2dibvQeITCSUONkB1wfvpnItVzVrP8aNLZ6cEZoBEXaNiiDqb
 k1sdZbB1ZDX66S2oaqhVi9FwE+20ShZ55hsg8drDxyvVoc9ZvkSr2DerDUfFlYimESzK
 YPnQzCvdO7CTji/8w3h3VrMEabrXu+R27EhxJhipSzMnIWnazPVO2fTe/dSe2mz0YXYK
 FSOac0LENZWR+T1N+H3UTXsFPcDxGO5t37kxHHicSXdJ2gQx17ZJpSy49RPjhxeB+uzx
 k9uJf5Yk4Mn9n7TCHgUKAfABTpgCzrB8PNkVByCSbxHmOGV1aC6CUMrG6BXI1x2QwW7P
 /Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=oi+DiORcv8oPY+bwo7vKR3lVC7t8yHxl0tr6tfI0oE4=;
 fh=6NgOZ+w4lYYtlbsSC0SpMMJrPrfMzyA6V9Gx96Cfks0=;
 b=ddebcJ5g77hUpD1ml/mo80XtzKL6bRJb9mPlnOqiFAQ8PIRwwhIcSwSsTYmr7HxT96
 VMcchNXFETmIRrugEiA0vgCSo57m48WUxAi/3S28CcXscMs9Nh4AB61txCJ4oWOpkW5k
 MJ/gXza0d5pG5I3Kjyo7Y8dNIwW9myfhl5MCKvTXVqwn7uIleDfJ/aMquJz3TiUPE/af
 3/ij8PQszez9AEnY7Xb3YP47USnRnZVcE2iFtMZho691XEE+MgCXDkH/ye/1pKdZzB5k
 GUhD6BW76WWMwmN2ZtBcs4zxit2b31zZweGdJvXND61od9/9TrnrA+MEdvCPzbxSfYXt
 uasg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792487629; x=1793092429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oi+DiORcv8oPY+bwo7vKR3lVC7t8yHxl0tr6tfI0oE4=;
 b=NEGvqXDztZb7Vm6SzaIMrGDah/e+iGZNXUk6LzwNhBjI1unFHIvtmsVPmLI6NhR+8i
 zP/zdVcSYbMe9Fda/XNBSg8UUYjulpkS2uTwJZDFzVJOxe3kS+yry/BXbzK0+0HB1u+2
 44HKj2ExGGGvDo68Qrrs8q92ooC4L5NjnxLZCjTzAWJtAcnkLkEaKouZciaZXB0J6pxC
 5uXUEcYrqO5Qp8AWLDMOh9xJP6EJlSCbkd6zweqALF1gLp49WEwZ6Nb8+2tzKiC03bbi
 Oy9FsRojlI1ONvUfZod/Bg60REg+MiaK7q5PWPHyjIWezWEcMgvb7/lI8XQSk+rypgMY
 +mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792487629; x=1793092429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oi+DiORcv8oPY+bwo7vKR3lVC7t8yHxl0tr6tfI0oE4=;
 b=OtpDXBlvKuQjXVkosHcB2dsts+qPwyL8ShUkiJHj2VIyQEhDUa+oALsGoqOtAvqAUA
 Poe7qQ4M/KCWZvam+EQ/KuXU1mi02YjHi9JYQaphRFVpeg5TFigix6DavKX5ui6pXp2f
 LKr4c/TdAO6MPLsrq0uezUc3RW4JMmMAcOOAOs9kFwdqJBpQPFt/2qDtTcCBOFI5qngN
 jHLNUi6Rk50QSKxgCegliNT6oedDmMtD8G5w2hQlZYqdwelB4NtUgC8ocYqwwSLci+X6
 kvximh4sTHFLq0zaZ8uOkZzcfc5TxTd2WXCNpiEdvbeONW2sWul/bhvwF05KEDcZ3PpI
 QByQ==
X-Gm-Message-State: AFq9FYKkeuSOjBcLuUVF3ifUgcTXn0ReTRl66CPWGPFhfXzWINAJLoTB
 9fvmhMnqEpbiJAd5C+2nfDzjRC7hCQvbseqMQ3Ev+Qx5df17KsCSMLi6qAiOa8dXO0szqtSF8xC
 3nWtyHsKXgYrcBeCAVNzXGv589u0O75I=
X-Gm-Gg: AYBFou1G0QXUa/EzswShG4zOeECWY6eyiuN49w64DvkH6gNClgyxyfXLT8OP/751+/Q
 cv4wqFGyZ7aByszgqyEvGdPSNO5L3BaoaXLMMNMTTFtbX5eC31RokJVu6GEUaAwhiI3D14Q0PJM
 4uMcryZQJ5zcaZJXuN/S3nnXlx3/iESnBRXPGq1JzMGIojTNiWbhxyBbv+DV6r8MBdBTOL16u2+
 hD0XM5fcvUiRq8+WKY/EcAPYTWBOHSGPkuGl8ks6Qed49XoI0J0pchE/LtjDOQmRRKetzz50FDU
 0C5F7h9oQovKDEV8bkXKlw5zh1gibWtPstAd1RfihevGFL38l1Yzxzw=
X-Received: by 2002:a05:6402:4404:b0:6b1:df89:7e1e with SMTP id
 4fb4d7f45d1cf-6b3a80d48a3mr6300579a12.1.1792487628673; Tue, 20 Oct 2026
 02:13:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
 <4070aab4-ba81-4ecb-8144-e0b1c7415ed2@oss.qualcomm.com>
In-Reply-To: <4070aab4-ba81-4ecb-8144-e0b1c7415ed2@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 20 Oct 2026 17:13:36 +0800
X-Gm-Features: AclHuK-d7QwUlRsfPqUv3TlxcEw-NpBzTXy_v18vi6bnKQlCH2wdHiczOhwg38w
Message-ID: <CAE2XoE9wAdCAS229CV6SqAboZdEOjvT8Msjamp9EnLc5LiH-WQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] multi-target: remove qmp_query_cpu_model_expansion
 duplication
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 6:17=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/16/2026 9:25 AM, Pierrick Bouvier wrote:
> > This series allows to link multiple targets that define
> > qmp_query_cpu_definitions. It simply replaces the duplicated definition=
s with
> > target-specific ones and a single dispatcher.
> >
> > It follows the exact same approach and structure than:
> > https://lore.kernel.org/qemu-devel/20261015005355.62406-1-pierrick.bouv=
ier@oss.qualcomm.com/,
> > which was merged yesterday.
> >
> > Pierrick Bouvier (6):
> >   target/arm: rename qmp_query_cpu_model_expansion to
> >     qmp_query_arm_cpu_model_expansion
> >   target/i386: rename qmp_query_cpu_model_expansion to
> >     qmp_query_i386_cpu_model_expansion
> >   target/loongarch: rename to qmp_query_loongarch_cpu_model_expansion
> >   target/riscv: rename qmp_query_cpu_model_expansion to
> >     qmp_query_riscv_cpu_model_expansion
> >   target/s390x: rename qmp_query_cpu_model_expansion to
> >     qmp_query_s390x_cpu_model_expansion
> >   qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher
> >     function
> >
> >  hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
> >  include/system/qmp-cpu.h              | 21 +++++++++++++++++++++
> >  stubs/meson.build                     |  1 -
> >  stubs/qmp-cpu-arm.c                   |  8 ++++++++
> >  stubs/qmp-cpu-i386.c                  |  8 ++++++++
> >  stubs/qmp-cpu-loongarch.c             |  8 ++++++++
> >  stubs/qmp-cpu-riscv.c                 |  8 ++++++++
> >  stubs/qmp-cpu-s390x.c                 |  8 ++++++++
> >  stubs/qmp-cpu.c                       | 14 --------------
> >  target/arm/arm-qmp-cmds.c             |  7 ++++---
> >  target/i386/cpu-system.c              |  7 ++++---
> >  target/loongarch/loongarch-qmp-cmds.c |  7 ++++---
> >  target/mips/system/mips-qmp-cmds.c    |  9 ---------
> >  target/ppc/ppc-qmp-cmds.c             |  9 ---------
> >  target/riscv/riscv-qmp-cmds.c         |  7 ++++---
> >  target/s390x/cpu_models_system.c      |  7 ++++---
> >  16 files changed, 107 insertions(+), 48 deletions(-)
> >  delete mode 100644 stubs/qmp-cpu.c
> >
>
> Ping (sorry for the short delay) on this series, to try to get this in
> before freeze.
>
> Regards,
> Pierrick
>

Acked-by: Yonggang Luo <luoyonggang@gmail.com>

For this series, fine for me

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

