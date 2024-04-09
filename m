Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B83C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9FU-00018y-5R; Tue, 09 Apr 2024 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru9FS-00018g-PY
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru9FQ-0004A7-VN
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712660549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erPHPdt5rj+XikTeyoNuocD+yf3tF/8+e+bjvyUaYw4=;
 b=IIjtXG9rgbtbxwFdNTnzLE0OzVr4LqUw/KNdtLUJ0SNewIws8oLLxwtRluE0+/aUzqjz77
 wMI++a1I0Fqb716vydiKdBi91OdCEJIGwmjU3ePHdTnbDPySuJOiqCLIDPwh+1OxdocNMz
 dQsCrTATY2lTZY943BJLEsCzC5S3okc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-3vOmEslkOeO6PlrbrBl5qw-1; Tue, 09 Apr 2024 07:02:27 -0400
X-MC-Unique: 3vOmEslkOeO6PlrbrBl5qw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3455cbdea2cso1167752f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712660546; x=1713265346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erPHPdt5rj+XikTeyoNuocD+yf3tF/8+e+bjvyUaYw4=;
 b=kpvs/fa0AEp82gBvR28YjlGlSEsNpZsxbfXugDYtIFd/8Cd91y22fsIzS6JF3jiSQf
 NIl8878Z+o1lsGEqbGz0Gr7pciaqynCZ+4D1ek9e4K+ZLc255DnHFMEFQDvsvlnvWNow
 t25GnMzNfFNyL6O0D5yM+qXrs/YMl52CQU3Ferugike32Qh/Mzy8OSIVAiFykDxWWeoN
 gxPN6EzzmZN5V8eJIp9gGOu0GNVsilTHIbcjy2cSeAzJbsFkhJ5ds5erO7896bxAcrdA
 hXQVytrG1AHmVnw+SOvPZUC5WTEHRgvpewyUF5rlSqUtczUVDvr22zZLJT0x/+h8qbyz
 MYnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZHO0jALCU/zE+hbt0c8GwtuLBhcMf9Z0Ssi0GKPIszuhp21WvqKeQWWsKl9tC8vCQQuUTuNsPMnR5Ii9f6NF+qpK47zw=
X-Gm-Message-State: AOJu0YxZdj8TUY2dJPHJDNEt9JeVriUR9VQ/UjyqKgDLQblSXyT3W4Mq
 QdXocKPokBujlyV927zti+HOsB04WCXRePdh7DGzUQCRl2jRfzwsaOn4gJMOnSNZRSUxiyBKc0o
 niJzUoopKhg70kLZKWcPCJwL7a6HLI468N9CM9m2FzEuSG8LutGdq9nyFbKcwUs8ILFbREFNC+5
 MeItsl3/Gl2vud9yNWDddUlCIECgw=
X-Received: by 2002:a05:6000:1a42:b0:343:bb49:2103 with SMTP id
 t2-20020a0560001a4200b00343bb492103mr1954788wry.9.1712660546150; 
 Tue, 09 Apr 2024 04:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQXvFCMSeRqMiktX/FGcWHW5jzEVVrqMdm0GojJ7nF4/ijWckWx8zS7Xb/EmpISy+nsLe066Xt9KXF8+PZVk=
X-Received: by 2002:a05:6000:1a42:b0:343:bb49:2103 with SMTP id
 t2-20020a0560001a4200b00343bb492103mr1954769wry.9.1712660545838; Tue, 09 Apr
 2024 04:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240311075806.668555-1-pbonzini@redhat.com>
 <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
 <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru> <ZhUi1NpSeUzXUuMu@intel.com>
In-Reply-To: <ZhUi1NpSeUzXUuMu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 9 Apr 2024 13:02:11 +0200
Message-ID: <CABgObfb8hn1qsr6Bu9ZxMr6DWd1uT5sb9Y+7GQd3hbMUvOxOXQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Giuseppe_Ghib=C3=B2?= <ghibo@mageia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 9, 2024 at 12:59=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Michael & Paolo,
>
> On Fri, Apr 05, 2024 at 08:30:43PM +0300, Michael Tokarev wrote:
> > Date: Fri, 5 Apr 2024 20:30:43 +0300
> > From: Michael Tokarev <mjt@tls.msk.ru>
> > Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
> >
> > 01.04.2024 09:02, Michael Tokarev:
> >
> > > Anyone can guess why this rather trivial and obviously correct patch =
causes segfaults
> > > in a few tests in staging-7.2 - when run in tcg mode, namely:
> > >
> > >    pxe-test
> > >    migration-test
> > >    boot-serial-test
> > >    bios-tables-test
> > >    vmgenid-test
> > >    cdrom-test
> > >
> > > When reverting this single commit from staging-7.2, it all works fine=
 again.
> >
> > It sigsegvs in probe_access_internal():
> >
> >   CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr); -- this one ret=
urns NULL,
> >
> > and next there's a call
> >
> >   tlb_addr =3D tlb_read_ofs(entry, elt_ofs);
> >
> > which fails.
> >
> > #0  0x0000555555c5de8a in tlb_read_ofs (ofs=3D8, entry=3D0x0) at 7.2/ac=
cel/tcg/cputlb.c:1455
> > #1  probe_access_internal
> >     (env=3D0x555556a862a0, addr=3D4294967280, fault_size=3Dfault_size@e=
ntry=3D1,
> > access_type=3Daccess_type@entry=3DMMU_INST_FETCH, mmu_idx=3D5,
> > nonfault=3Dnonfault@entry=3Dfalse, phost=3D0x7fffea4d32a0, pfull=3D0x7f=
ffea4d3298,
> > retaddr=3D0)
> >     at 7.2/accel/tcg/cputlb.c:1555
> > #2  0x0000555555c62aba in get_page_addr_code_hostp
> >     (env=3D<optimized out>, addr=3Daddr@entry=3D4294967280, hostp=3Dhos=
tp@entry=3D0x0)
> >     at 7.2/accel/tcg/cputlb.c:1691
> > #3  0x0000555555c52b54 in get_page_addr_code (addr=3D4294967280, env=3D=
<optimized out>)
> >     at 7.2/include/exec/exec-all.h:714
> > #4  tb_htable_lookup
> >     (cpu=3Dcpu@entry=3D0x555556a85530, pc=3Dpc@entry=3D4294967280,
> > cs_base=3Dcs_base@entry=3D4294901760, flags=3Dflags@entry=3D64,
> > cflags=3Dcflags@entry=3D4278190080) at 7.2/accel/tcg/cpu-exec.c:236
> > #5  0x0000555555c53e8e in tb_lookup
> >     (cflags=3D4278190080, flags=3D64, cs_base=3D4294901760, pc=3D429496=
7280, cpu=3D0x555556a85530)
> >     at 7.2/accel/tcg/cpu-exec.c:270
> > #6  cpu_exec (cpu=3Dcpu@entry=3D0x555556a85530) at 7.2/accel/tcg/cpu-ex=
ec.c:1001
> > #7  0x0000555555c75d2f in tcg_cpus_exec (cpu=3Dcpu@entry=3D0x555556a855=
30)
> >     at 7.2/accel/tcg/tcg-accel-ops.c:69
> > #8  0x0000555555c75e80 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x5555=
56a85530)
> >     at 7.2/accel/tcg/tcg-accel-ops-mttcg.c:95
> > #9  0x0000555555ded098 in qemu_thread_start (args=3D0x555556adac40)
> >     at 7.2/util/qemu-thread-posix.c:505
> > #10 0x00007ffff5793134 in start_thread (arg=3D<optimized out>)
> > #11 0x00007ffff58137dc in clone3 ()
> >
>
> I debugged it manually, and found the problem occurs in tlb_index() with
> mmu_idx=3D5.
>
> For v7.2, the maximum mmu index supported by i386 is 4 (since
> NB_MMU_MODES =3D 5 defined in target/i386/cpu-param.h).
>
> On Michael's 7.2-i386-mmu-idx tree, the commit 9fc3a7828d25 ("target/i386=
:
> use separate MMU indexes for 32-bit accesses") introduced more indexes
> without relaxing the NB_MMU_MODES for i386.
>
> Before this fix, probe_access_internal() just got the wrong mmu_idx as 4,
> and it's not out of bounds. After this fix, the right mmu_idx=3D5 is trul=
y
> out of bounds.
>
> On the master branch, there's no such issue since the commits ffd824f3f32=
d
> ("include/exec: Set default NB_MMU_MODES to 16") and 6787318a5d86
> ("target/i386: Remove NB_MMU_MODES define") relaxed upper limit of MMU
> index for i386.

Thanks Zhao! Alternatively, it's enough to set NB_MMU_MODES to 8 in
commit 9fc3a7828d25.

Paolo


