Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2893C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rRU-0001q9-E4; Thu, 10 Apr 2025 08:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2rRM-0001pL-KJ
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2rRI-0004DR-6A
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744289726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uY+GXIRcFHjEMDAwApDq5u+dpMv+32eCMLTfB4Go5sE=;
 b=BgPDnAtxBn5JnWbR/HmrPPp69vhj+NtCRd+Z4AaiYA18Am8Z1v7jVQ4THDNAS/JzksggTJ
 3o6nomsAuSiX+XQOpnTnjmtBmpiVXdYwIpz/fjRiqlOfh+3K0Siqu4W363KTtf80nrpAC8
 q98GuCoZQs2T3XQJDek4Ms+HakhFHkg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-ue-yKNEqPOmurWAZK6CeQg-1; Thu, 10 Apr 2025 08:55:24 -0400
X-MC-Unique: ue-yKNEqPOmurWAZK6CeQg-1
X-Mimecast-MFC-AGG-ID: ue-yKNEqPOmurWAZK6CeQg_1744289723
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so4611885e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289722; x=1744894522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uY+GXIRcFHjEMDAwApDq5u+dpMv+32eCMLTfB4Go5sE=;
 b=fnuaT6ZwURaNBD1+heTKPqFsTUz+PgletHDdB1Bl+G24iR9Pxl2T+AjhvXdO8whz83
 v6Px7KPN1dHAxKdibYZ61wH16mGmD8bDOQpqk0TJaQIAXE8fDwB6GsQuU3ZJ8tjTBQ8i
 TekC+5bc3qlUTnL64PtUzvTbHwVoGu5M7xkq6zx9yFfZbmJB6p5v/QTN/+BVYb7GTLgW
 pI76wD5DK6VRbqzPNM3CBa6og7QPJZx21T0tKnz3h1BUBQ9W9IS9tx54UEJVEvWAIYjx
 jtZl5/WtxpMarwls3yZKyDJ0o1/smHMmT34DIVGKfbSdIAwGWVz1KGUxNoBWhRL+CKBO
 oL/Q==
X-Gm-Message-State: AOJu0YwVZAhd8qm0GmRoSgzCOS+UPS+s7JZJRkq8IFAwGIYXSkHxRW4l
 6NZ/IGnwOWaoFr6RoEv+X0zPdIMuzOTzl4kGn9bXmV3yaUI7r+usoszndToK1LJR1vkRpk8vIoJ
 LUAtzPizb+XVou/VWhv2vCAUkbhUGNGoCIMN2OjdCGwgmjd4gOpZR+13hupGCzFHbh6GqcI6XMd
 kQmaVhnXkLlQaTp7CoLrz69pmQQSa6jUHNWWixwA==
X-Gm-Gg: ASbGncvIsYiUfpkHCCzKGtdoamd30ea5P7ihPC63uz6Yk8la7GWT/HW/OHWTry+cFnZ
 e7s6aAmbPelaX54RYW4pmBTUOj5Hf5GAEajD9TSIJ+a/mu8St87whVClvMVMlGkSpaTzWqCE=
X-Received: by 2002:a05:600c:444f:b0:43c:ec28:d301 with SMTP id
 5b1f17b1804b1-43f2d95a8cemr20170415e9.26.1744289721791; 
 Thu, 10 Apr 2025 05:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW/oI6PJ2sPXRseyY0hIx68eNKE/Q8Rq3HCpYvGRDu8u/qXQI7NkJgh7YcxTWBGAQGR7S5ei7TJG0O7JjER24=
X-Received: by 2002:a05:600c:444f:b0:43c:ec28:d301 with SMTP id
 5b1f17b1804b1-43f2d95a8cemr20170155e9.26.1744289721389; Thu, 10 Apr 2025
 05:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <04b7137a464e0925e2ae533bbde4fcdfe0dfe069.1744032780.git.ktokunaga.mail@gmail.com>
 <e0dcc4e6-1e8e-468f-83e5-36ffb014eeef@linaro.org>
 <671805c9-f802-412b-998e-ba83719f1e72@redhat.com>
 <CAEDrbUbnAzXpmNSNi11j7+a0DCYHy7d_MCY=TMqHUoxmo_ZHGw@mail.gmail.com>
In-Reply-To: <CAEDrbUbnAzXpmNSNi11j7+a0DCYHy7d_MCY=TMqHUoxmo_ZHGw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Apr 2025 14:55:07 +0200
X-Gm-Features: ATxdqUGKmzOKJOybqP1sPUXX_2b_QdTs7865rXacRygnAG-Afji3ov0U768K7SU
Message-ID: <CABgObfaL3f3BD56ajE=Dv+VKidjpW=FRuwTyFHr_Fpu5uAqmpg@mail.gmail.com>
Subject: Re: [PATCH 05/10] meson: Add wasm build in build scripts
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 10, 2025 at 2:24=E2=80=AFPM Kohei Tokunaga <ktokunaga.mail@gmai=
l.com> wrote:
> > >> has_int128_type is set to false on emscripten as of now to avoid err=
ors by
> > >> libffi.
> >
> > What is the error here?  How hard would it be to test for it?
>
> When has_int128_type=3Dtrue, I encountered a runtime error from libffi. T=
o
> reproduce this, we need to actually execute a libffi call with 128-bit
> arguments.
>
> > Uncaught TypeError: Cannot convert 1079505232 to a BigInt
> >     at ffi_call_js (out.js:702:37)
> >     at qemu-system-x86_64.wasm.ffi_call (qemu-system-x86_64.wasm:0xa377=
12)
> >     at qemu-system-x86_64.wasm.tcg_qemu_tb_exec_tci (qemu-system-x86_64=
.wasm:0x65f440)
> >     at qemu-system-x86_64.wasm.tcg_qemu_tb_exec (qemu-system-x86_64.was=
m:0x65edff)
> >     at qemu-system-x86_64.wasm.cpu_tb_exec (qemu-system-x86_64.wasm:0x6=
762c0)
> >     at qemu-system-x86_64.wasm.cpu_exec_loop (qemu-system-x86_64.wasm:0=
x677c84)
> >     at qemu-system-x86_64.wasm.dynCall_iii (qemu-system-x86_64.wasm:0xa=
b9014)
> >     at ret.<computed> (out.js:6016:24)
> >     at invoke_iii (out.js:7574:10)
> >     at qemu-system-x86_64.wasm.cpu_exec_setjmp (qemu-system-x86_64.wasm=
:0x676db8)

Ok, I guess a comment mentioning that it's a libffi limitation is enough.

> > At least -g -O3 -pthread should not be necessary.
>
> Thank you for the suggestion. -sPROXY_TO_PTHREAD flag used in c_link_args
> always requires -pthread, even during configuration. Otherwise, emcc retu=
rns
> an error like:
>
> > emcc: error: -sPROXY_TO_PTHREAD requires -pthread to work!
>
> So I think -pthread needs to be included in c_link_args at minimum. I'll =
try
> to remove other flags in the next version of the series.

Reading more about -sPROXY_TO_PTHREAD it seems that you need it for
all calls to emcc, even when compiling, so it's better to leave it in
everywhere.

> > For -Wno-unused-command-line-argument what are the warnings/errors that
> > you are getting?
>
> I encountered the following error when compiling QEMU:
>
> > clang: error: argument unused during compilation: '-no-pie' [-Werror,-W=
unused-command-line-argument]
>
> It seems Emscripten doesn't support the -no-pie flag, and this wasn't cau=
ght
> during the configure phase. It seems that removing
> -Wno-unused-command-line-argument would require the following change in
> meson.build, but I'm open to better approaches.
>
> > -if not get_option('b_pie')
> > +if not get_option('b_pie') and host_os !=3D 'emscripten'
> >    qemu_common_flags +=3D cc.get_supported_arguments('-fno-pie', '-no-p=
ie')
> >  endif

Meson should have passed the -Werror=3Dunused-command-line-argument flag
when doing the above test (CLikeCompiler._has_multi_arguments ->
has_arguments -> Compiler.compiles -> _build_wrapper ->
build_wrapper_args -> ClangCompiler.get_compiler_check_args). It would
be great if you can check what's wrong in this theory so perhaps meson
can be fixed, or at least send here a meson-log.txt.

My suggestion is (if possible) to split out the parts of this series
that are enough to run QEMU under TCI, and get those in as quickly as
possible. The TCG backend can come second.

Thanks,

Paolo


