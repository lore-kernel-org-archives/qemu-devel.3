Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8EBC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPsS-0003js-K7; Thu, 16 Jul 2026 13:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wkPsN-0003jU-Hb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:27:59 -0400
Received: from mail-oa1-f41.google.com ([209.85.160.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wkPsL-00016e-60
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:27:58 -0400
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-456395f4e7bso979547fac.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222875; x=1784827675;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=df4xxXKfud+vHTeMMkueAvHLfaVdA07+CRchcpoXFaA=;
 b=BIRip9A8cWoKostY/0nvg56E/Tkm1Z4kjk1sIEQps9vaFaFOOSuhc5OiYFradPhKmW
 CZp/iG2Lw1rq1kdUiqnr7CT/cMkY3NsgCjv5Apaw0kvPlzb3tkgHOVYBLmoZZJ5sZ7cE
 xUdPN4zSLEcZoNYuZebV6GXFf5pi5yYaVbplPeMTowX8PX6PFEAdBtAKqgaGeHrCyhrA
 OLjgrfERa1lHXO7lUjLz3oyrzutjWsPyQx27o1uJyib27b+SPGrgPbU2rUvhi/snD5wX
 LFt2BmlAUeb7Tx9C68B58kPa7xm2CyuTKdHsLnmWLE7l0HYOdW0GJ95Jdsagyovabhxj
 GhWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMDbImF8GnLpCHZJRrMQnoss7xamcokDZ8X/zBNxTERvNLrFctWIpEUskRE15j5JNScM2JIfLifbmV@nongnu.org
X-Gm-Message-State: AOJu0Yw5CH+n0GWxZDvJv79gIP0v4zfO3KBRj+iKhy9Vj5lyssiusvHs
 PNNPHT4iFegE5ohZ64TrnnTWya+yR0nH1ePPj3YSLSfGbqKhbJaVS7WVOqjV6OI8
X-Gm-Gg: AfdE7ckyMp3MC2B1eJJ8wLbUzQunYekcu+hUFrWknh4wlNRid83nn9ZfPyMSJRkEi2Q
 SPWfevqlWnH6uW41H7eaJi64n99dX83OchUwfm6i0jvXIxamaFazztEektzA5d4zeBdePr0wIwB
 Axjs6uiAoI2soBbYOvMpVvqYTTcicAiBa+8BsgLORyZdvzhF0uBZNOr/jknQ2+50XjYMt3+1IJU
 +dBIFvtJJs7Aceo2vsMjFIp0hmQjWvcK34lZnec18N5Ti3kg8Qtie3yD88GGMDgDilCKnWfMWbI
 JgfTB0VK9Itr9H7jZ3QqKDbA6JNG5qQBz1ftT6s0jOnYwy2lb6MYdHnEAn3luBQTfhEUsCj7rKS
 4KprOIkGHNSbfcBCbbfmfXD01hb6WO1QqMtNShrMZn5rfsJQTLzO0Sgc1eTaXPA1ASHAQXCFfFo
 dN7mWfUQ1JkETfckGS2WlvJSA2myYls4a+EIIurQ==
X-Received: by 2002:a05:687c:218:b0:456:5d8b:5681 with SMTP id
 586e51a60fabf-4565d8b6a2bmr2056784fac.1.1784222875336; 
 Thu, 16 Jul 2026 10:27:55 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com.
 [209.85.167.170]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451a0ceccf1sm21794074fac.6.2026.07.16.10.27.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 10:27:54 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-489f3611e0cso4621278b6e.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:27:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rrmxfj+R7OPl0t4RfrQG9z4OEZkLt8Is7SDudB/4do0V+yxmJyJE52XPcGoL7yGI1WUFbVV56Bx3ZGQ@nongnu.org
X-Received: by 2002:a05:6808:5393:b0:485:48da:133d with SMTP id
 5614622812f47-4a495e65f8dmr5457005b6e.10.1784222874593; Thu, 16 Jul 2026
 10:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
 <CAFEAcA9LCRKmU+r77zGp+4Rgd-uaZLPnoPPQDSfG8X5eeiynJA@mail.gmail.com>
 <91ad4c80-adc6-4f37-8346-20230638e5f0@oss.qualcomm.com>
 <CAFEAcA-hnm17d4PR0wmaKwQmM-K50nHeRYv0a-pCk3J1qUbPsg@mail.gmail.com>
In-Reply-To: <CAFEAcA-hnm17d4PR0wmaKwQmM-K50nHeRYv0a-pCk3J1qUbPsg@mail.gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Fri, 17 Jul 2026 02:27:42 +0900
X-Gmail-Original-Message-ID: <CANTT7qh6X7ESRwgfM5PRkfCx9BSVUXHy8GL+n8SmX3LtusWiGw@mail.gmail.com>
X-Gm-Features: AUfX_mwX-oH7xTIBahJbzBsn_H3IPboItZP6cQIpBWcV3Pl7WpvRiXf5alPdeZo
Message-ID: <CANTT7qh6X7ESRwgfM5PRkfCx9BSVUXHy8GL+n8SmX3LtusWiGw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.160.41; envelope-from=yisooan.dev@gmail.com;
 helo=mail-oa1-f41.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

2026=EB=85=84 7=EC=9B=94 13=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:34, P=
eter Maydell <peter.maydell@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Fri, 10 Jul 2026 at 23:56, Philippe Mathieu-Daud=C3=A9
> <philmd@oss.qualcomm.com> wrote:
> >
> > On 10/7/26 17:37, Peter Maydell wrote:
> > > On Tue, 23 Jun 2026 at 13:56, Leesoo Ahn <lsahn@ooseel.net> wrote:
> > >>
> > >> It's worth cleaning up all resources that the guest taking and to qu=
it
> > >> if an exception in el1 could not be resolved.
> > >>
> > >> Otherwise, the guest will get in the infinite black-hole by
> > >> unmodified pc.
> > >>
> > >> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > >> ---
> > >>   target/arm/hvf/hvf.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > >> index 8b902c6882..4358cf90e8 100644
> > >> --- a/target/arm/hvf/hvf.c
> > >> +++ b/target/arm/hvf/hvf.c
> > >> @@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu,=
 hv_vcpu_exit_exception_t *excp)
> > >>           cpu_synchronize_state(cpu);
> > >>           trace_hvf_exit(syndrome, ec, env->pc);
> > >>           error_report("0x%llx: unhandled exception ec=3D0x%x", env-=
>pc, ec);
> > >> +        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> > >>       }
> > >
> > > We should do something here, but my question is whether
> > > qemu_system_guest_panicked() is the right thing. We mostly
> > > use that for "the guest OS wants to tell QEMU that it has
> > > panicked, so QEMU can reflect that to the user and perhaps
> > > reboot or exit", though we do in a few places use it for
> > > things that are more like "we don't handle this case". I'm
> > > not sure exactly what the right thing to do here is, though.
> >
> > We usually abort() for programming errors (here unimplemented
> > case) and don't let the guest mis-behave.
>
> We've definitely used that strategy in the past (either directly,
> or indirectly via hw_abort() or cpu_abort()), but I think these
> days we'd prefer not to let the guest trigger QEMU to abort().
> Some of those cases we've been able to convert to LOG_GUEST_ERROR
> and continue in some manner, but some cases are just not
> continuable from.
>
> I think we could probably use a better mechanism for "something
> went badly wrong and we can't continue executing the guest", where
> e.g. we can suspend the VM and let the operator look at its state:
>  https://lore.kernel.org/qemu-devel/alSqlDRT9L8OqAso@redhat.com/T/#m9ab2f=
4a819e33cd5ac0f6d22ab30f98a0d599866

I keep my eyes on the thread and agree with your idea.

>
> For this specific patch: what is the case where we get into this
> codepath (and in particular what is the EC_FOO exception subtype)?
> Maybe the fix is to handle that case. Compare an earlier thread:
> https://lore.kernel.org/qemu-devel/8D0BCB24-BB1B-40EF-A361-0F79D65600AE@u=
npredictable.fr/
>
> If we're getting here by falling through from EC_INSNABORT,
> I think that can happen if the guest tries to execute from
> an MMIO region.

EC_DATABORT already deals with traps by accessing MMIO regions.
Yet I have no idea what kind of instruction abort could be raised in MMIO.

BR,
Leesoo

