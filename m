Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FF6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBiQ-0001c2-G4; Wed, 27 Aug 2025 04:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1urBiO-0001aU-1E
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1urBiI-0000bU-9L
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756284059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmLNmBwVw3n45Pxkk8dJAj5gWDzSv/qrgZqsaCKvWPk=;
 b=MRbDH9ps9bJz844lrg0nuH751Gy1wfyXF1x1B6RU3xTyDnpta/No9uOcmfxk86BHlt31WP
 dLoHo3eGv2iaSy8Cb/UTDpOOu/seHjUc36fC13h/AB6C6Fe1rHbBELYCy+XQg9DaF6i7Mv
 1Q9/mdXVbaPJxQ4sP5QS1Cm5Fo31ihc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-gmTzGqgTOfWv_S7NKoHYRQ-1; Wed, 27 Aug 2025 04:40:57 -0400
X-MC-Unique: gmTzGqgTOfWv_S7NKoHYRQ-1
X-Mimecast-MFC-AGG-ID: gmTzGqgTOfWv_S7NKoHYRQ_1756284057
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70d93f579ceso120523786d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756284057; x=1756888857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmLNmBwVw3n45Pxkk8dJAj5gWDzSv/qrgZqsaCKvWPk=;
 b=RuKu1389iqeDCVpD5/C6VJSoyKZ7Zwttc6N+vCDXj9MxNVuJFxmhcyhhNxc4ooEO5O
 iUtEldWYyGD5N3HLTBAGcRLvIoDqrhscO42wqzEV7VOyeiCx6drruxiaJh8AWBi23kr6
 oElanE/9mMg8AfnlL8SJe1FEgsu6PqM0MFtvhdd2sFf93rywapVLeJNu1xVP7QnERjL6
 wFwdQpiSnAXteVQ6XpHV5NTmLEhVwMwJ/GN8zjyZEB10Xb6r/cbCeFQgTXWq7jW9xaJk
 QI+zLCKW3e2lcs5dKAzPLdN9qwFdclH1EVknZAXuonIlgb4KECQqOlrszQk/F875J0uD
 a1Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+DKFmnWYfvoxI59uZ3X/JlTzIXIeVdt7/3cPe5G8YJxakotHANFWmtOsd0ZOEcCYrrUnoGuOskDs4@nongnu.org
X-Gm-Message-State: AOJu0YxZTgihchteoMIF5aQB0kto0lUe6zSGtTKLHkr6xqfO2afhFZP4
 eYP802Feo4wnGtaDiqIewRDpP+BHWtjIbKtIBLTJ7tTK3kgMjyUPatBfIGlMneYfhZuIYS6HzDF
 zD1ZRi3zR9LdFzrD2Q3XBNR3hceLNQ/fzpGNS7UGMg56YH9baWglrhWGp
X-Gm-Gg: ASbGncsKN193GtEq0VH8AJuQEXairjQ1ZD5PlQvzMknhEzem1z6nUBtkNGMGre062ue
 nvfzLQicxw7G181W3d4D0HTY+T1bKWQc6xpkdCFORKXNP170llcfrfy0ALzwcxzTPVjf9njfgBI
 9byqkGEKTf0gOs2QCLDyd2H8h2Dkupl5L1ouwWaHFMzbXbsNofBfS8ygVRIdLkm+AD7RUQLDnTf
 ICIcWdM2fqaeqclfEZORPmP294o0njhW1lcumqKonBNpQgWQYLIgYmH/xzFDxhS/dLUNS68/Agm
 RWXDG+ewdB9iFsMF15Co4zKRJF+1rg==
X-Received: by 2002:ad4:5741:0:b0:70d:c870:e7e3 with SMTP id
 6a1803df08f44-70dc870ea51mr95272646d6.12.1756284056719; 
 Wed, 27 Aug 2025 01:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJXXofhAMp1X9KQCrbTGZ3XeClKDy1MWR1ICwpFRuMaThc05cIwOZe8evjpo4reuh19qEurg==
X-Received: by 2002:ad4:5741:0:b0:70d:c870:e7e3 with SMTP id
 6a1803df08f44-70dc870ea51mr95272366d6.12.1756284056146; 
 Wed, 27 Aug 2025 01:40:56 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70de7e0ae63sm1390256d6.52.2025.08.27.01.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 01:40:55 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:40:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com, qemu-devel@nongnu.org, Peter Collingbourne
 <pcc@google.com>, Alexander Graf <agraf@csgraf.de>, Roman Bolshakov
 <r.bolshakov@yadro.com>, Sergio Lopez <slp@redhat.com>, qemu-arm
 <qemu-arm@nongnu.org>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v4 7/8] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Message-ID: <20250827104052.655134e9@fedora>
In-Reply-To: <c16db8b9-9b73-49c4-8233-370c1b46a382@linaro.org>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-8-imammedo@redhat.com>
 <c16db8b9-9b73-49c4-8233-370c1b46a382@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 25 Aug 2025 12:46:07 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 14/8/25 18:05, Igor Mammedov wrote:
> > when kernel-irqchip=3Dsplit is used, QEMU still hits BQL
> > contention issue when reading ACPI PM/HPET timers
> > (despite of timer[s] access being lock-less).
> >=20
> > So Windows with more than 255 cpus is still not able to
> > boot (since it requires iommu -> split irqchip).
> >=20
> > Problematic path is in kvm_arch_pre_run() where BQL is taken
> > unconditionally when split irqchip is in use.
> >=20
> > There are a few parts that BQL protects there:
> >    1. interrupt check and injecting
> >=20
> >      however we do not take BQL when checking for pending
> >      interrupt (even within the same function), so the patch
> >      takes the same approach for cpu->interrupt_request checks
> >      and takes BQL only if there is a job to do.
> >=20
> >    2. request_interrupt_window access
> >        CPUState::kvm_run::request_interrupt_window doesn't need BQL
> >        as it's accessed by its own vCPU thread.
> >=20
> >    3. cr8/cpu_get_apic_tpr access
> >        the same (as #2) applies to CPUState::kvm_run::cr8,
> >        and APIC registers are also cached/synced (get/put) within
> >        the vCPU thread it belongs to.
> >=20
> > Taking BQL only when is necessary, eleminates BQL bottleneck on
> > IO/MMIO only exit path, improoving latency by 80% on HPET micro
> > benchmark.
> >=20
> > This lets Windows to boot succesfully (in case hv-time isn't used)
> > when more than 255 vCPUs are in use.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> > v3:
> >    * drop net needed pair of () in cpu->interrupt_request & CPU_INTERRU=
PT_HARD
> >      check
> >    * Paolo Bonzini <pbonzini@redhat.com>
> >       * don't take BQL when setting exit_request, use qatomic_set() ins=
tead
> >       * after above simplification take/release BQL unconditionally
> >       * drop smp_mb() after run->cr8/run->request_interrupt_window upda=
te
> > ---
> >   target/i386/kvm/kvm.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-) =20
>=20
>=20
> >       /* Force the VCPU out of its inner loop to process any INIT reque=
sts
> >        * or (for userspace APIC, but it is cheap to combine the checks =
here)
> > @@ -5489,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm=
_run *run)
> >       if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TP=
R)) {
> >           if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
> >               !(env->hflags & HF_SMM_MASK)) {
> > -            cpu->exit_request =3D 1;
> > +            qatomic_set(&cpu->exit_request, 1);
> >           }
> >           if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> > -            cpu->exit_request =3D 1;
> > +            qatomic_set(&cpu->exit_request, 1);
> >           }
> >       } =20
>=20
> Interesting. IMHO to avoid future similar problems, we should declare
> CPUState::exit_request a "private" field and access it via a helper,
> where atomicity is enforced.

I did only bare minimum here, while
Paolo took over sanitizing/fixing exit_request part
see
https://patchew.org/QEMU/20250808185905.62776-1-pbonzini@redhat.com/
so this suggestion better fits there.
=20
> The only non-accelerator use is in PPC sPAPR:
>=20
> hw/ppc/spapr_hcall.c:512:        cs->exit_request =3D 1;
> hw/ppc/spapr_hcall.c:534:    cs->exit_request =3D 1;
> hw/ppc/spapr_hcall.c:627:    cs->exit_request =3D 1;
>=20
> FYI last week we noticed a similar problem with CPUState::thread_kicked
> when using HVF and I'll post in a few days a series containing this
> change:
>=20
> -- >8 -- =20
> diff --git a/system/cpus.c b/system/cpus.c
> index 26fb3bd69c3..39daf85bae7 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -464,10 +464,10 @@ void qemu_wait_io_event(CPUState *cpu)
>=20
>   void cpus_kick_thread(CPUState *cpu)
>   {
> -    if (cpu->thread_kicked) {
> +    if (qatomic_read(&cpu->thread_kicked)) {
>           return;
>       }
> -    cpu->thread_kicked =3D true;
> +    qatomic_set(&cpu->thread_kicked, true);
>=20
> ---
>=20
> It only affects HVF because this is the single access to thread_kicked
> out of accelerator code:
>=20
> $ git grep -w thread_kicked
> include/hw/core/cpu.h:484:    bool thread_kicked;
> system/cpus.c:449:    qatomic_set_mb(&cpu->thread_kicked, false);
> system/cpus.c:476:    if (cpu->thread_kicked) {
> system/cpus.c:479:    cpu->thread_kicked =3D true;
> target/arm/hvf/hvf.c:1825:    qatomic_set_mb(&cpu->thread_kicked, false);
>=20
> (Call introduced in commit 219c101fa7f "arm/hvf: Add a WFI handler").
>=20


