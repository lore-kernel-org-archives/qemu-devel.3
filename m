Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D234ACA5FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBp8c-0008Gx-UY; Wed, 30 Sep 2026 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBp8a-0008Eg-I4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:54:00 -0400
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBp8Y-0005Hq-4r
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:54:00 -0400
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb88abebdso1874502a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790754836; cv=none;
 d=google.com; s=arc-20260327;
 b=geh2FRXWMlIqo6J6sPhpk1pgxv7u0C7f7aNipt6wmH0eoWLYZoN6gyBYEgvy2dOmc/
 UXNth1TOgxzRZhrXoNTMrOErliT0fS0XwiR4qanB2/OP71x33OXJr7v2iSfWdJ+TIz13
 gbiDP+8ut/w4ZDeKLIQsm2DgJZYry3ujXlrpOy0KfkTUcAagwsF10prJ7VZ2LaADIkhI
 qA5vumDmtBchSqEUBF1FXkVM/syXEeJjmLSLB4Ds2fXIqIJTzoEAWLojIqtRf04m/Il3
 TLgfzEdc3j6nWAZVn5Tf2vVO9Svom7zESijIPJh7ap/kYKQNuxmgs/H/eXUk/6kkPOd6
 NMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DbIPhEl6hnumKe3veCA6SZ0VYwnMfD336BtRhx0BWmw=;
 fh=/XhB7PTqpds2+yqfZ8mzcKXS0fqCEV1XQQIG8MCCxOU=;
 b=eSy507f/bHUzH3gL4GRZIRMqy5kkgGpy0QaTwFZ2ZT3Ab7PUArstwVUoV6vrKzGrFC
 dk5qH8c+w6fRboRyZG9pBxDApDthgJXiJSo1JD+dtfLcfXpMsAXHYqwDgkJDHNZND9Ct
 se3ejo07YPisETQSvK6lxRnAwQvFnpW0OXEuiYhkobFWd2ZISgrC3CO2uRVu+nwSDgsu
 QGuNp1RKiW8CA3iSb2f4l9uEiJe4ULjy9cinUuGxWu1is99DMFoda9rh6gCkbFxj5GjG
 ehnoRKEFBzgVJHFvSu5qMoiVUtShMzg4hSLXDlBVXGNlguBzAeZulLWh/cWvdDpqM11Y
 FzNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790754836; x=1791359636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DbIPhEl6hnumKe3veCA6SZ0VYwnMfD336BtRhx0BWmw=;
 b=WxbBNzBb3hsysFFJstEAmbkFeUxH1FG51lUmdInhIVG3L5SoHXYfvJ3/T1l4n5xo5i
 zVT+bR+aDxHmDpH//orGBSyvMEQE8aWh/83iDxmHe459fEUlgKYr/NynqFDl3+fq4iIw
 OjlhEunvgVuVHCipVEJf2rb+VmvD3vnQ5aSxFGnK4k9dJriUbJDFdLYCv1voHLieuZLw
 XsQQpx+NteMxn6xOAu0dbPvxMid+WF8M6V8v2dTjhX+Bhae2mzDYURbb7Aqu4UGmXkZ/
 Pd8fxhK10B3Z5xShnRYwbwQ2fzdF4+uneQPzYuASUIh8f919g1bHg3hOI0OOjXWMjj0y
 vIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754836; x=1791359636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbIPhEl6hnumKe3veCA6SZ0VYwnMfD336BtRhx0BWmw=;
 b=jcgnsHtRHbXNugIMYLQAxjfRkeQiSr198H29bRlFdBJ9zgxKD7Zu0/PJpSL5jdTCRe
 /0rkI+0HSEM0zv9W8mp3iwDz71x1QGho8RBFjXbltVTXXJr12UWw39ET7/z4AfnEZ9ip
 VOtI/c0XSjJZZ7EiNh7AIBdM/yEhfwMeX7OXeeyb5kubEa9dBKoRMgdI76KNVYl0lk0T
 dSP4nbhiGzNVkCOAj38wSOrlkqKIc7ZJNYCs1NYvKQNOqDPvyJ3nE0+xRXJg3hwCMRH2
 1AdOzs65SZFmkleeHiW9a2dpSgmgvXaTB6UU6V7qLEJ0M5MRcEsX4sU8TApKt3P8zqVL
 NtUA==
X-Gm-Message-State: AFq9FYKuMwdpfnqbxi+EpmPL4G7BzD7FxRW6PofieGIEx4FdqZ+fWHqB
 J/Hk01aLgUEgymPjjg5qnIM/bWyPjk6V6Wmx8k+o9L0vKqV8VRbN0mrdh0cwZlNzz7mF93Goj6c
 mKnkriSVL9gDVe38OiN9E4J3Z9dYCUjU=
X-Gm-Gg: AYBFou3x6xHS8Fe8ONAAaWi6strXxpG4cc5cNtpjYjrA3qpiPtd/vSdYnywL22hOVSV
 1mi2CKw1j6do88JN8wSiSGFn1rhfOvxE4FkSXxsXA6WAcNvor8zj95Pl7bYzn02Vc0jFIs7FNko
 c3NZ2vRmrieise0FG6UzjmOVsR/k4GZcAyRZqUg0U3LTMz55Vd83Gbq66t8w/0K6MASXVTf1qce
 zLMOthBa3ytu6ogKl9mYFdaPn75yWlH+mlsL6xlh7I1yI+9u/Dttmtp/WLwNqBFYtPzWxL5Mz6H
 KNp3xxQM6griI345KEFe/JigeIk+yuPJJ1PsgUgNQq+C9Pw45Ntxa60=
X-Received: by 2002:a05:6402:324e:b0:6aa:fce2:7b30 with SMTP id
 4fb4d7f45d1cf-6ae1994611amr233447a12.18.1790754835426; Wed, 30 Sep 2026
 00:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260928052051.251-1-luoyonggang@gmail.com>
 <20260928052051.251-3-luoyonggang@gmail.com>
 <c7aadc02-6c5e-4ca1-875c-43050305f4ec@oss.qualcomm.com>
In-Reply-To: <c7aadc02-6c5e-4ca1-875c-43050305f4ec@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 30 Sep 2026 15:53:42 +0800
X-Gm-Features: AclHuK_AkJAslhEUYFEZ-FPW4v9lx98bN-SlXHVMCqGpvmbaqz9tw62QlduK1BU
Message-ID: <CAE2XoE-C15Y7MjqVCRdpqs=hBLw7+buGJWXdKei37WC7kQkkHg@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] accel/tcg: add cpu_loop_exit_excp
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Chao Liu <chao.liu@processmission.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Glenn Miles <milesg@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 29, 2026 at 1:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 07:20, Yonggang Luo wrote:
> > Add cpu_loop_exit_excp next to cpu_loop_exit_restore. Set
> > cpu->exception_index, then restore and exit the current TB the same
> > way as cpu_loop_exit_restore.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   accel/tcg/cpu-exec-common.c  |  6 ++++++
> >   include/accel/tcg/cpu-loop.h | 12 ++++++++++++
> >   2 files changed, 18 insertions(+)
> >
> > diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> > index d20cece1c5f..31fed8e497f 100644
> > --- a/accel/tcg/cpu-exec-common.c
> > +++ b/accel/tcg/cpu-exec-common.c
> > @@ -118,6 +118,12 @@ void cpu_loop_exit_restore(CPUState *cpu, uintptr_=
t pc)
> >       cpu_loop_exit(cpu);
> >   }
> >
> > +void cpu_loop_exit_excp(CPUState *cpu, int exception_index, uintptr_t =
pc)
> > +{
> > +    cpu->exception_index =3D exception_index;
> > +    cpu_loop_exit_restore(cpu, pc);
> > +}
> > +
> >   void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
> >   {
> >       /* Prevent looping if already executing in a serial context. */
> > diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.=
h
> > index f4d38bc2bca..856091020f2 100644
> > --- a/include/accel/tcg/cpu-loop.h
> > +++ b/include/accel/tcg/cpu-loop.h
> > @@ -65,6 +65,18 @@ G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
> >   G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t host_p=
c);
> >   G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t host_pc=
);
> >
> > +/**
> > + * cpu_loop_exit_excp:
> > + * @cpu: the cpu context
> > + * @exception_index: EXCP_* or target trap number
> > + * @host_pc: the host pc within the translation
>
> I'm not comfortable this is hidding the 'restore' part,
> not even mentioning no restore is done if host_pc=3D=3D0.

After thinking, maybe it should be cpu_raise_excp and cpu_raise_excp_restor=
e
That match the accel/tcg: add raise_excp and raise_excp_restore helpers?


>
> > + *
> > + * Set cpu->exception_index and exit the current TB, restoring
> > + * guest state from @host_pc the same way as cpu_loop_exit_restore.
> > + */
> > +G_NORETURN void cpu_loop_exit_excp(CPUState *cpu, int exception_index,
> > +                                   uintptr_t host_pc);
> > +
> >   /**
> >    * cpu_loop_exit:
> >    * @cpu: the cpu context
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

