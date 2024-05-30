Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12FCC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZfv-0002Np-9c; Thu, 30 May 2024 02:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZft-0002NI-JO; Thu, 30 May 2024 02:54:09 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZfr-0001gH-Lq; Thu, 30 May 2024 02:54:09 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2bdd8968dabso389658a91.3; 
 Wed, 29 May 2024 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717052046; x=1717656846; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGiqS+hnpRfXvXsah7rwzLP71Wqm6cIVseD8PfOo2AE=;
 b=l6xTnS+9RaSiwSpwV6CXt2MrqcYr+2VPIecQlkR6aQX+7cQFBrSZoDbJeAL/q6jZi3
 KMe1JINfs7qabe8rLAjDdyzG6td5o/E3fjZ8nbFKgi74h0oY3Q7KLiuVZE32mKQkGYfQ
 o8dvvfaLfkF9SsNYpIyCOHVF60K3EelH3yvMcLVEFp1eekk57ynGJZ7s8uqDJjqS90wV
 RhUxD1fmj1E/VfMiQxURrX2SoKBIFAjBFFeR5PaMEvYKDhIBQicaUaRiCQ1iAD+NRN1O
 cnjMjmDIWNMfGB0VEQomld2SZiv0V/uwajLh8dLij7dw9cKnvg4R3AtsXOoY7WAngZYe
 SJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717052046; x=1717656846;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zGiqS+hnpRfXvXsah7rwzLP71Wqm6cIVseD8PfOo2AE=;
 b=F9nB46bO5KONuM3knv4ZGPJ8HCCpq+E844gDFnWxZ1CkIptIPSM433hdI9UPNSBQzY
 PI819xfkbh5bb8fvO0tjV1DcJxzK2SthoUvD3LBP9proI0t5IHnzyVjtgZE68Vj+yhAX
 MnOedfnty0XeEn9tCgBAvqd2bZmWNw0l5WiifzXCFzfr40MAqhNbYB7HqE41HU9102Oi
 oYPFJOJZPnxbvN6oBLzz2uAAeDul9JwMeVBgyoaxYFq2PPhWG6U/fRyQNd9QyOpM75zC
 X6cs+FF11ahUMoG/LVmX+E0GlUUirtRb3/6NHVLQpDT0Dahb/1njIRsfK8cfEwxcYEJs
 +CZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvmta3t8Blpj0uTaMpAvTJcmBtuekqDWmANxmAHevTpbkTDDc6ysjaszB3FPtSwGcrcN4n4CgBDMQbii3Mx0ksGC8o2OhEpYAC/3D2H1Rvpv9FRtImDw4YXL0=
X-Gm-Message-State: AOJu0YxFH6hGHMF5DwW9KXZn+zf8KqAwX3naby8bMZQI+GsAV7fPkdJj
 YSPYYUSdGLw4iuXr/yVjGlOqlp44LRxzBVouvoOSYNugDs2URu0z
X-Google-Smtp-Source: AGHT+IFWPHu5j5rRWGLoa/pwBTGqsv6iPV7ii95lSdH8EUj3x3kmFxgvMxNywQTIDOl9rPAY2T1NRA==
X-Received: by 2002:a17:90a:66cb:b0:2a5:5a2c:6066 with SMTP id
 98e67ed59e1d1-2c1abc42fefmr1234946a91.37.1717052045655; 
 Wed, 29 May 2024 23:54:05 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c02df08078sm1592948a91.0.2024.05.29.23.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 23:54:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 16:53:59 +1000
Message-Id: <D1MS5D7X0YO4.V49CFAJQ7GBN@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 09/10] ppc/pnv: Implement POWER10 PC xscom registers
 for direct controls
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-10-npiggin@gmail.com>
 <7f54afb7-3c2c-44b4-bc00-8b24e0ba51e1@kaod.org>
In-Reply-To: <7f54afb7-3c2c-44b4-bc00-8b24e0ba51e1@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed May 29, 2024 at 5:00 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/26/24 14:26, Nicholas Piggin wrote:
> > The PC unit in the processor core contains xscom registers that provide
> > low level status and control of the CPU.
> >=20
> > This implements "direct controls" sufficient for OPAL (skiboot) firmwar=
e
> > use, which is to stop threads and send them non-maskable IPIs in the
> > form of SRESET interrupts.
> >=20
> > POWER10 is sufficiently different (particularly QME and special wakeup)
> > from POWER9 that it is not trivial to implement by reusing the code.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/core/cpu.h     |  8 ++++
> >   include/hw/ppc/pnv.h      |  2 +
> >   include/hw/ppc/pnv_core.h |  3 ++
> >   hw/ppc/pnv.c              |  7 +++-
> >   hw/ppc/pnv_core.c         | 88 ++++++++++++++++++++++++++++++++++++--=
-
> >   system/cpus.c             | 10 +++++
> >   6 files changed, 112 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index bb398e8237..52a8fc65cb 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -974,6 +974,14 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
> >    */
> >   void cpu_exit(CPUState *cpu);
> >  =20
> > +/**
> > + * cpu_pause:
> > + * @cpu: The CPU to pause.
> > + *
> > + * Resumes CPU, i.e. puts CPU into stopped state.
> > + */
> > +void cpu_pause(CPUState *cpu);
> > +
> >   /**
> >    * cpu_resume:
> >    * @cpu: The CPU to resume.
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 93ecb062b4..bec603f1a8 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -111,6 +111,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *ph=
b);
> >   #define PNV_FDT_ADDR          0x01000000
> >   #define PNV_TIMEBASE_FREQ     512000000ULL
> >  =20
> > +void pnv_cpu_do_nmi(CPUState *cs);
> > +
> >   /*
> >    * BMC helpers
> >    */
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index 39f8f33e6c..9599da15ea 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -109,6 +109,9 @@ OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD=
)
> >   struct PnvQuad {
> >       DeviceState parent_obj;
> >  =20
> > +    bool special_wakeup_done;
> > +    bool special_wakeup[4];
> > +
> >       uint32_t quad_id;
> >       MemoryRegion xscom_regs;
> >       MemoryRegion xscom_qme_regs;
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 5364c55bbb..765142965f 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -2700,12 +2700,17 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs,=
 run_on_cpu_data arg)
> >       }
> >   }
> >  =20
> > +void pnv_cpu_do_nmi(CPUState *cs)
> > +{
> > +    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> > +}
> > +
> >   static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
> >   {
> >       CPUState *cs;
> >  =20
> >       CPU_FOREACH(cs) {
> > -        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> > +        pnv_cpu_do_nmi(cs);
> >       }
> >   }
>
> What about ?
>
> https://lore.kernel.org/qemu-devel/20240424093048.180966-1-clg@redhat.com=
/

I haven't forgotten it. I just didn't put it in the first PR since
there was quite a lot of pnv patches to do so I thought I will collect
most of them for another PR.

Thanks,
Nick

