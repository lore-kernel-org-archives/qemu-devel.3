Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A8EC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGV1-0005vF-C4; Mon, 30 Jun 2025 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGUY-0005eX-1H
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:32:25 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGUR-0000Kn-2l
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:32:20 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-714078015edso23920017b3.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297531; x=1751902331; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBv5z/VpiWqm6TUtxvPZN70k+f7CGqEYeEiw2nVISzY=;
 b=GQaP1ajrwi2MxcOS0whhzOgb7kVFhlNBRSoXJPWFtAz/1r7EHhtAUtQ3+XUd7rJJ4s
 Ylr845FGeWf1iLelv7Dgl/IloLavlC1H/VPSbRJxSqq9sYO6kZCZ+yOJ8WxXvQcAE/i3
 Vxb7ONOHtx773bKYcjAv23PQ1pNpZPJs6T30gOyfH+JEeJOou+6vvsMUBiMHZHIAY+bf
 7sd3ogL/12StSJtjybREKCVMN1pLSsTqo+4bK/4b7T+wVYVA5JuY1EU8R7cCO6rBUF75
 IMhDf9CSEc/C58nJRabJBUniIELOA7dGwe6sKnneGkO5DHF9NF+7qDT9TCJzK39IBZ7x
 H0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297531; x=1751902331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBv5z/VpiWqm6TUtxvPZN70k+f7CGqEYeEiw2nVISzY=;
 b=j14+AB8IqmxetO4vnunwCARZBrPxQE97b5UasTchfARliM/SGBlaNGxKmqhhF1LlWb
 q9d3Qdpdbvah63rQ8sXAxkXSkz/fqLvs+McssV5GjBJ+5DB4JfPic6W9eTZqTEV/0x8m
 18LYh2LjrlCEOEorDirjtnk3tbvCg9EKAjCvDIa6VIBQDci2SUjdq4J4gQp61lZtllj3
 V/xEjTvYCzbeI+x++QHW7g/q1Eg3n60Oi7q5J4SG//qU93M+RHSM8ltl+8+yiRZ8Mycm
 AgzVfgrFH+JoYz8RlymSGrIpux7QnUIhrE/ny0NgH3dGl/Hak9GXBmC0VcQZY40fOoy1
 KpbA==
X-Gm-Message-State: AOJu0Yx+F7KvWVxuFYpeVGObWnk1ryo00WH9qfJb5tzVRrwvjNnqKWzk
 FBdhDU/Godk1ZUkl4ksWZTz4waMoRQHmjsH1saFWiXmlqJ4mljdUzQy+mIuSEImdhPil/ZMIepq
 SINmS0w6A3va5euzXxU0qkZZug814XlkQTmg2hD+uaw==
X-Gm-Gg: ASbGncvZX/xR5AajeosGh6qKsI1TqzdFwFjZ5m6/mUh9WFoWMQzKBO0PdH2dJnBsAPI
 YegmObQJzqjHiG+nSIeRzpAg2+9H5PPc0b43dF0uZ+t+UrumNmQ91oUPN3ULp9tU9nl4+izLkJD
 +Q+jBPIAUgADh5+Ewys/br03DPysxSjVcCIjwMi313ABdN
X-Google-Smtp-Source: AGHT+IHy8nnqmhTcZqN296zS/GH2AzcmKJFgjhBGMvlHCoJRvN7kCBoPACAJDbr1konLbK5VYHH+YUoYt2nSk6mM5yk=
X-Received: by 2002:a05:690c:4b8c:b0:710:edf9:d93b with SMTP id
 00721157ae682-71517158331mr260393347b3.11.1751297531250; Mon, 30 Jun 2025
 08:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-11-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-11-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 16:31:59 +0100
X-Gm-Features: Ac12FXxL7r8Fqtmkx3bL2CVmkkdzP7qpLkzAMPTSCdtXWbBVYPe4zZUG2yIbwZA
Message-ID: <CAFEAcA-fe_8qZFWjTAB3EGFpR6vO=fHj-yB7cV=CYgjsVgLOcg@mail.gmail.com>
Subject: Re: [PATCH v3 10/26] accel/hvf: Model PhysTimer register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Emulate PhysTimer dispatching to TCG, like we do with GIC registers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/hvf/hvf.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)


> @@ -1639,16 +1640,12 @@ static int hvf_sysreg_write(CPUState *cpu, uint32=
_t reg, uint64_t val)
>      case SYSREG_OSLAR_EL1:
>          env->cp15.oslsr_el1 =3D val & 1;
>          return 0;
> -    case SYSREG_CNTP_CTL_EL0:
> -        /*
> -         * Guests should not rely on the physical counter, but macOS emi=
ts
> -         * disable writes to it. Let it do so, but ignore the requests.
> -         */
> -        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
> -        return 0;
>      case SYSREG_OSDLR_EL1:
>          /* Dummy register */
>          return 0;
> +    case SYSREG_CNTP_CTL_EL0:
> +    case SYSREG_CNTP_CVAL_EL0:
> +    case SYSREG_CNTP_TVAL_EL0:
>      case SYSREG_ICC_AP0R0_EL1:
>      case SYSREG_ICC_AP0R1_EL1:
>      case SYSREG_ICC_AP0R2_EL1:

This adds three registers which aren't GICv3 registers to
a code path which has a comment

        /* Call the TCG sysreg handler. This is only safe for GICv3 regs. *=
/

In general the TCG sysreg implementations aren't expecting
to be called for non-TCG accelerators. I would like to see
some analysis of why this is OK for the timer, please.
(Compare commit a2260983c65 which notes the limitations under
which this works for the GIC registers and had to make some
minor changes to the GIC code both noting that it might be
called for non-TCG accelerators and adjusting things so
that would work.)

thanks
-- PMM

