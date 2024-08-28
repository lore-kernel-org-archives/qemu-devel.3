Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1B4C63685
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKx7-0002bb-5n; Wed, 28 Aug 2024 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKx6-0002VM-2r
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:51:20 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKx4-0008O1-5o
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:51:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso1455003a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724860277; x=1725465077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRQWUlsgsZsze63eCUj92thrfENtfqzTMCWiy2Dv2M8=;
 b=cSHHzqDVnrRsgMlJ8UviG9zMKyDfAhHEV1I0Rr61lE2mKmGRnEZdX1XZeOf8thJ9+G
 MvDy3Y05hVU+xeCw9WibMzWk4kpGAiQwiMKEpWS/07RhVckqjNSwaAj3h3Vd8CInX5jk
 G8piqB5WlnkJp8O1cNqoVU/BJHuwihMZtSRbj4QUY6+jf5jFEmB3UVEdA2JqxKwjGNFY
 qAdvI6rEpMLc3LuLN9jTJ+b2s/qBq/LctDFmd2o6XmOanl5JDPANqopuaGr04pczGRxd
 83fMrCahW8OPdlmiM3q0KiiI7PfAMABn5ZINR0kEUmP9GcbCrktPdjLMKvuA0mco7KMg
 2fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860277; x=1725465077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRQWUlsgsZsze63eCUj92thrfENtfqzTMCWiy2Dv2M8=;
 b=ntq8i4saJum+ez6gg1w2h3NMZHA5dokZ3UOk9NVxD4WH1hjxybcTznT52SwGnmiTgu
 lLyRs/saJXVajXaj8oKMd5UyPyp/mkgjCwXeYDTuxJ+uGjwok7w5hlDRJwsxB4izAmqG
 j3TLzA23KtRuqQvT1WvGbe8/53w1b6XTwWNOFf0eoc5jtW1N61tujGxF4g2aoDJVfsYx
 C3bPa5lTNd6wUe3zbnBGZvK2Ee7j3pH9nZVh0S8OqaB3j5Ohjn2w4X+/xLj63lAK7cdN
 2K3XSx67zhKQkmcf1/TMPbg8fF4AWJ8OHMj8kMEk0unhfLdv5kOD9Oc2WURZvBWjlgx8
 E82g==
X-Gm-Message-State: AOJu0YzZ7q9W2W5KgFMrfAPlFuvDhyxOP7F1KM06scIEy7ny6oeBGked
 xdx62z9VTbOR/2yxbzO1Xu7KaDzVHuFb5M2hrnKqbjvAO8zY7HsCH7CXw0AG0LycpTlNtdR9S7T
 PKLpIaamiDSkMRKYprDsL8O3+mC4JEGGLpoh3OnJC5/JBPICd
X-Google-Smtp-Source: AGHT+IFooEWnMkbPsXq00AY99R+WjqHk84tZ3h8sAyG8YUPA0wrk4GuTXz9/sj2Ew/A625d7rtXYxcBIjI6VERPBveQ=
X-Received: by 2002:a05:6402:3494:b0:5c0:c559:ad6 with SMTP id
 4fb4d7f45d1cf-5c21ed29641mr16047a12.6.1724860276517; Wed, 28 Aug 2024
 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <241ba192-359c-483c-aeea-1023a47c4e74@tls.msk.ru>
In-Reply-To: <241ba192-359c-483c-aeea-1023a47c4e74@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 16:51:05 +0100
Message-ID: <CAFEAcA9=ALwWzRn5mitmgEELy07HaGQkesYr=w+D8ceZxg9UQw@mail.gmail.com>
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 28 Aug 2024 at 08:22, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 05.03.2024 16:52, Peter Maydell wrote:
> > From: Richard Henderson <richard.henderson@linaro.org>
> >
> > If translation is disabled, the default memory type is Device, which
> > requires alignment checking.  This is more optimally done early via
> > the MemOp given to the TCG memory operation.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi!
>
> Apparently this change also breaks picolibc testsuite (between
> 8.2 and 9.0, bisect points to this commit).
>
> For example:
>
> ./qemu-system-arm \
>    -m 1G \
>    -chardev stdio,mux=3Don,id=3Dstdio0 \
>    -semihosting-config enable=3Don,chardev=3Dstdio0,arg=3Dprogram-name \
>    -monitor none \
>    -serial none \
>    -machine none,accel=3Dtcg \
>    -cpu cortex-a8 \
>    -device loader,file=3D/tmp/picolibc-1.8.6/arm-none-eabi/test/printf_sc=
anf_thumb_v7_fp_softfp,cpu-num=3D0 \
>    -nographic
>
> (yes, this testsuite uses qemu-system as a substitute of
> qemu-user, sort of, (ab)using -device loader)

My immediate guess is that this code won't run on real hardware
either -- i.e. that is bare-metal code that was only ever tested
and run on QEMU and was previously relying on the incorrect
behaviour that we didn't enforce the alignment checks that we're
supposed to do when the MMU is off.

We'd need to look at the picolibc test harness and build system
to be sure, but it needs to do one of:
 * tell the compiler never to generate nonaligned accesses
 * set up at least a simple 1:1 set of page tables and
   turn on the MMU before jumping to C code

and my first move would be to check whether it is trying to
do either of those things.

thanks
-- PMM

