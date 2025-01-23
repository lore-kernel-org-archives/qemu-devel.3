Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB6EC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 11:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tavJV-0002tw-QG; Thu, 23 Jan 2025 06:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tavJU-0002tV-6S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tavJR-00029V-Nm
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737631430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9uURwdCCm34GKuHyTdynIgW82PlZ4ndfwFc2Wwr3TM=;
 b=VBRm+u83FHU0f/XO9obbV9PlUjSr2g1VsbeJEJ2kHMkFjr1pwrULHO2/Jy7r5jbOKLOObS
 Rotoqhj3GHNGsUWMtG0XI4rcVumRNv0DZwVEq851M4nofVHsxqaXW5ZRlkLQ6wA+rClkDA
 QgCA7/q6W+d7jed8w0lRp/8j66TZtpo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-x6fI6fBbOb-7b4hyH5e-Sw-1; Thu, 23 Jan 2025 06:23:49 -0500
X-MC-Unique: x6fI6fBbOb-7b4hyH5e-Sw-1
X-Mimecast-MFC-AGG-ID: x6fI6fBbOb-7b4hyH5e-Sw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6f3b93f5cso379302885a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 03:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737631428; x=1738236228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9uURwdCCm34GKuHyTdynIgW82PlZ4ndfwFc2Wwr3TM=;
 b=brp86GsCLn7gboHvMVnfox3MOcW+t1ImK0cUNDEyC1xjIrON7Tfck8WeMHMK5NG8jM
 2lHD3ERrIhHTcUHUu9Z8tl3XeynuyQLitWoWJgG6d9y1qssOj1I33LsiADqiqyTHJHWY
 H6tOixSSP8Mq1kKKTO5lAMgdwFBj3qW6RXHxVRQGBOmJWab9ztSFX0TB29qTVSgJVEs7
 TdnfU6hwOXz7lljr1ND3LVQxQK6pProZ+oAyOrKhIl2bvJJKtRwJqeY+eM4AUcQ3ACnI
 ShIqB/fgcirTD26rQjpzjUmG6sj34lCErg1Kl0dujYufz7PEc1MKL5ywRQbNNLudYqPw
 TTpA==
X-Gm-Message-State: AOJu0Yw8pD5eaJc3dfbEVAHvUEj3hXhoL0Qg3lsLdoXxoJZsoHl/byyK
 +VRj9jhmOhfS2Efcs0/wm1xApt5Cjm2J1QhJ5YDI9cdrxY58GSBcPJ1Sh6gbz3WQ4qAAi/hguMw
 U7m4J9HStC5kXBFh7meVk15aAFMAIr/cL/fOkCusJ6ZzVimE3VNnh
X-Gm-Gg: ASbGncup+H7m071fMo8WOR8nYq9gp4/ZsTVrjadai7xhGJ3OMJfRZoiizz6UsmYOl32
 CLYrcmtUrueoodUKUa6zre6Xm3W7WdYfZO230BFZV4Y72twc2GPIIW4iWKDKCcnU3K+qJrgKRO0
 QizV89TQYwapTF+2HOXOqgBmrY9uK+czPol9kXPwbL0NPYTXKZ5c30l0ByBVQ9eKrwhj3YM3D5t
 uKFcXCWQx9rkDGdcYWpagZYqYWHp+rqNjPj9I5VA0sk15mdq+IDqiqVlETVIx1+aEdNuwKe6Sl8
 NR6iMO2e8swJlOpptDTZYb3QyDCW8+kNiIcRBSac3w==
X-Received: by 2002:a05:620a:2806:b0:7b6:da9d:d810 with SMTP id
 af79cd13be357-7be93231a29mr385858685a.24.1737631428607; 
 Thu, 23 Jan 2025 03:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbPnCJ3+vvQ4jM8tO5YzpLQHsIOAsKsqLoABNJHBS5XxUESh9CiVCnAdVUk8hw/1kbnuh5Mw==
X-Received: by 2002:a05:620a:2806:b0:7b6:da9d:d810 with SMTP id
 af79cd13be357-7be93231a29mr385856685a.24.1737631428309; 
 Thu, 23 Jan 2025 03:23:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-u.redhat.com.
 [213.175.37.12]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61481543sm755283485a.48.2025.01.23.03.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 03:23:46 -0800 (PST)
Date: Thu, 23 Jan 2025 12:23:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
Message-ID: <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
In-Reply-To: <87frl9ls4g.fsf@draig.linaro.org>
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 23 Jan 2025 10:52:15 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > QEMU will crash with following debug enabled
> >   # define DEBUG_TLB_GATE 1
> >   # define DEBUG_TLB_LOG_GATE 1
> > due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_asyn=
c_work]
> > functions are called not only from vcpu thread but also from reset hand=
ler
> > that is called from main thread at cpu realize time when vcpu is already
> > created
> >   x86_cpu_new -> ... ->
> >       x86_cpu_realizefn -> cpu_reset -> ... ->
> >           tcg_cpu_reset_hold
> >
> > drop assert to fix crash. =20
>=20
> Hmm the assert is there for a good reason because we do not want to be
> flushing another CPUs state. However the assert itself:
>=20
>   g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
>=20
> was trying to account for pre-initialised vCPUs. What has changed?
>=20
> cpu_thread_signal_created(cpu) is called just before we start running
> the main loop in mttcg_cpu_thread_fn. So any other thread messing with
> the CPUs TLB can potentially mess things up.

it reproduces on current master, so yes it likely has changed over time.
I've just stumbled on it when attempting to get rid of cpu->created usage.


> > 1)
> > Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  accel/tcg/cputlb.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index b26c0e088f..2da803103c 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState=
 *cpu, run_on_cpu_data data)
> >      uint16_t all_dirty, work, to_clean;
> >      int64_t now =3D get_clock_realtime();
> > =20
> > -    assert_cpu_is_self(cpu);
> > -
> >      tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
> > =20
> >      qemu_spin_lock(&cpu->neg.tlb.c.lock);
> > @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t id=
xmap)
> >  {
> >      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
> > =20
> > -    assert_cpu_is_self(cpu);
> > -
> >      tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> >  } =20
>=20


