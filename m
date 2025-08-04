Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D5AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwzZ-0006T9-Gk; Mon, 04 Aug 2025 11:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivb5-0004Jr-I5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:51:27 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivb3-0003eH-Pw
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:51:27 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae35f36da9dso836969766b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315483; x=1754920283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HD9t+q6wBaWUm1s+MeKD23B5r/HJmi1+zrbwR/NzI2Y=;
 b=phLJGHq3GuHdf0JzOer99tLSSx/L2nUrkrbXlMENUHw5I/ajuhMo8tL6lkRKBlcp8t
 eplYQZqSZ9ZDaCXRaDkJsyPgApdm88p1Vlbp4+JGRjKX8APwIRcMN0kk7lV9a2Sf/Qf7
 jQb37NOoHNAZIcdAoN6vuEHI2G3zXODsFWDBhQrCbRykBOBgD7eiDiHJME1tVgl+M6sb
 3/bbTJVukNPALUniV7p2AThl7nQmbQ+7CkBhCBhTpfSDlGZsqQSAP4QCf1iqfmZSnTGv
 2Wu+JYyC5zpmzcqYD1XwE2S3VXV5LwR3dWGuzu1pFvsZBs8j+cEyxlgJlPSLYV7pz68e
 b9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315483; x=1754920283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HD9t+q6wBaWUm1s+MeKD23B5r/HJmi1+zrbwR/NzI2Y=;
 b=IOoxKRG13YuJvs84n3KjhCoP06G2Nn67rcBKEA6AekgdjLAMC0Asoj8kns02Gg6KmW
 yKvJS71Z7cmq/wLDK1FQKEcn6JrLuS5dCJPPmPVocP35MpW7hNpI+ddSOgfZ0ZOx9uPa
 GPMZbe0mMenIM0zvlen3Z5D5hhe/HzJxLYSbplxSHm3XVyf9uitK6BSZmSS2r8NJcTA0
 JUpNAOU8yWDUUd0x4C7JoE7AAvl0D1cYVXpfZfolzl/1n3Kb6MaAnB1Y1Sq5L1wL3msH
 1/dCElWqMwuPAV4P8D5JELY0fLRNUCG8Lpz6EqE/jnR2enfLtGy1RRqSqlYK9Yn4joFF
 53gQ==
X-Gm-Message-State: AOJu0YwD2Mfo9+iPMoXVkpyk1bQX0tJAqZKWz3MjBImp9qmPhFSLNLwu
 c2Yxp0B/7gohJLIQkEZngcBjTPi/0yn6nglHIkcKQyuezv5gvzr6c4REulmQnilzT6PBU4CsLxk
 0dKWOqUD2LmxxeClWoWYKj9FpOzxYJUdkcqzEpG3Fng==
X-Gm-Gg: ASbGncs7SY0jmq96C0qQo52f4z39D62MIPRJK3jJMw/uPgm8q8/5Jme3HnLPj0UBTr0
 jWoiUFNYRsOGPfcyFD9JkGMiAnoPFhBGKWcgmVk3Q15IAyCAJ1UzTTof9JH8h+1jztjUNDAk83S
 V6ZuQnrNOLpo8NeFTrd5Vdc9G2Mls74J5u/gdwuFXfDljUxIXuSjjW/C3Vd8lyIv6Kf9bqr4Ugj
 zq/PG8izI9tVrAQ8w==
X-Google-Smtp-Source: AGHT+IENVtBE/JNmYlYKIgJ9aKFQWtWP7ZSNpG4j9Pr7b9NWljob3CtWVDo7721p+1c2ruflM/P0jbGe/mYyWSWafC4=
X-Received: by 2002:a17:907:7210:b0:ad8:9a86:cf52 with SMTP id
 a640c23a62f3a-af93ffc06ddmr964345566b.11.1754315483524; Mon, 04 Aug 2025
 06:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250804104308.250949-1-alex.bennee@linaro.org>
In-Reply-To: <20250804104308.250949-1-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 4 Aug 2025 16:50:57 +0300
X-Gm-Features: Ac12FXyYy1oyigCtMPHne6njc68j8Ail6HBXV24cr8V5pM58BI5fhpTSFj2EJvo
Message-ID: <CAAjaMXa++WKtdZYnLVJzv1GeMJh5tzxCtS2+S10oMkjyUCQhWg@mail.gmail.com>
Subject: Re: [PATCH for 10.1-rc2] tests/docker: fix docker-all-test-cross
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

On Mon, Aug 4, 2025 at 1:43=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> It turns out you can't easily expand an ENV var across multiple steps
> in a dockerfile. This meant we silently dropped the architectures we
> should have even on amd64 hosts. As the updated AVAILABLE_COMPILERS is
> only needed for the following apt install line just merge them.
>
> Fixes: 6da616bb170 (tests/docker: handle host-arch selection for all-test=
-cross)
> Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-all-test-cross.docker | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/test=
s/docker/dockerfiles/debian-all-test-cross.docker
> index ef69bbc8a51..420a4e33e60 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -62,9 +62,7 @@ RUN if dpkg-architecture -e amd64; then \
>    export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-powerpc64-lin=
ux-gnu libc6-dev-ppc64-cross"; \
>    export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-sparc64-linux=
-gnu libc6-dev-sparc64-cross"; \
>    fi && \
> -  echo "compilers: ${AVAILABLE_COMPILERS}"
> -
> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +  DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          apt install -y --no-install-recommends \
>          ${AVAILABLE_COMPILERS} && \
>          dpkg-query --showformat '${Package}_${Version}_${Architecture}\n=
' --show > /packages.txt
> --
> 2.47.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

