Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68ECCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcymh-00075R-ED; Fri, 26 Jun 2026 01:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thecharlesjenkins@gmail.com>)
 id 1wcymg-000759-QX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:07:22 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thecharlesjenkins@gmail.com>)
 id 1wcyme-00007R-VK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:07:22 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-13986d61b4fso833292c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782450439; x=1783055239; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C/Z5ZZp43Cvspff6bn4ck5u628H+n/wkJCqZbYHrkes=;
 b=P+kkqAWCHqOTDBfqbvmPJhrhCBylt4Z1LH8rkiVnlUWKpagfuRCjWXRCRs36dGWEl8
 jz21Ftl2hKFozzY8oh7jloXe9+LAk5rxYjCYNnZP1VnCHnEMOG0tHsEG79jeSOqqPYGS
 Kb8gCCevg+9NZc1np8NehhGzPbcnGCGn64Ezj33+vKVLms94wHIrXiY1r7G0WncouiQ3
 WNJ9G3A1niI+Mcuc2ei3MwVq/pclINddZ4jVlqwiuLzaG92A1IqpYI1juGlDxK5Yf9Lu
 F2xTgQWSftk3sy0Xz2yuOQJPXSoz1yluBfcWJ56p5Oiz+Etr2fkk41kfldQFlSNkQ8aG
 CF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782450439; x=1783055239;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C/Z5ZZp43Cvspff6bn4ck5u628H+n/wkJCqZbYHrkes=;
 b=IurVVxnCnx/Gcsm04dhAps/5+cqRIw/Jx+rFsMhpXYhYBxJnl3mpuBSZTqmQVM8Cm+
 f38wNvk6IWrpb3WcoRdUrfUgxfNUzTyMxkcQUQ7dc3frsoff8t+2t9ueacnHTD35i8oZ
 XMvpo1OT369ODk/r8eLm9FQyzIpAYBNjWnotahGHwev2/hhjDdROq8uYf3ofDXPKy23H
 zwZ3JDBF9L8OqPPwSUhwLrfJghMG3xXeuqBbBYqkm1XcdgT7Pj46c6EKMa+GvOScvolm
 N0Akc/FAEMkLPiqItMleSk9hNf571TyBaOrheXvN8jAfGshHk/wvBcY+Jrt461GwGYVU
 bWuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ88HbLxcD7TfHBtJBJQL5vXXAp9qj6KGNG0smEIqfTZ7KT8eX1OtWnXIsD+K7g4l77QFzzwlcXUNM2Y@nongnu.org
X-Gm-Message-State: AOJu0YyGr9BhfiaU3yjGwcHrNYCvRjnELx2XOiKsXfXhNreBpskk6P2X
 dlzE4lVOfaC+dvTnMOpTBnO71/O7MmPJbEXp3BYAOInIEw2XZj9CMXfO
X-Gm-Gg: AfdE7clIIO6dsPcPPAXH/6ByZbOy9LH+6O9sT8wu0CYchmH/0VquAS8BtBbRbQspTjn
 LF3+OSEtSTh0tTmwADbXUM8Xv7Q8L+w/X4yCPFnM8jBVWOFGVMYhH/YwxyyIMsYHBOJjr1dK3fn
 xHJCdLOQ3UZ9aYqlkOeaQvhISQyd0DDxT7ndjAfLHKxPYdu1WWDch2kZEOeoXYeO7UaZAlTRilV
 p9CDVZWdzklGjohp1dBfVF8H/ynl+uBPTz8uVvfL3FbUUlP86tpO0fs1TCMrWg0nzh0lVXTSUjf
 kj9Gf90Gwvdq6rqs76/0Sx/IsU2bUDqX/heooyp4u2AVVRZo9m1JUJ8vu9vDs8Yh4JTFFZE9JSX
 /X6IHbCsGFJn9jZQDOgbvG+Fzcs42uNQc+CtJXlQVMpcp+Bl4mH1xlkAEUd/Kst/g7mo3iznPA6
 gW
X-Received: by 2002:a05:7022:ec0c:b0:136:e639:9c05 with SMTP id
 a92af1059eb24-139dbab9ce7mr4551650c88.31.1782450439023; 
 Thu, 25 Jun 2026 22:07:19 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::1947])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e4c33af7sm1795837c88.5.2026.06.25.22.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 22:07:18 -0700 (PDT)
Date: Thu, 25 Jun 2026 22:07:15 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Atish Patra <atish.patra@linux.dev>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] target/riscv: Report QEMU CPU archid as 42
Message-ID: <aj4JA1h7vYvgGE-s@blinky>
References: <20260624-marchid-v1-1-a0af7997071f@gmail.com>
 <15e2ffbd-cb14-4767-ab56-e647fdc38b15@oss.qualcomm.com>
 <88192e79-65af-4c91-9824-99dc810c7cd0@oss.qualcomm.com>
 <18878720-7dd1-4463-9a42-e4b91cfcfaf6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18878720-7dd1-4463-9a42-e4b91cfcfaf6@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=thecharlesjenkins@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 25, 2026 at 01:29:37PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 6/25/2026 12:10 PM, Philippe Mathieu-Daudé wrote:
> > Hi,
> > 
> > On 25/6/26 14:13, Daniel Henrique Barboza wrote:
> > > Hi,
> > > 
> > > On 6/25/2026 3:26 AM, Charlie Jenkins wrote:
> > > > When a non-vendor CPU is used, report the archid as 42 which has been
> > > > allocated for QEMU in the riscv isa manual [1]. This can help software
> > > > check if it is running in QEMU.
> > > > 
> > > > [1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
> > > > 
> > > > Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > > > ---
> > > > This series was original proposed by Palmer Dabbelt [1] with a follow up
> > > > by Daniel Henrique Barboza. This patch implement's Daniel's suggestion.
> > > > 
> > > > When booting with a non-vendor CPU such as with the qemu arg "-cpu rv64"
> > > > marchid will now be reported as 42.
> > > > 
> > > > > qemu-system-riscv64 ... -cpu rv64
> > > > 
> > > > processor       : 0
> > > > hart            : 0
> > > > isa             : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
> > > > mmu             : sv57
> > > > mvendorid       : 0x0
> > > > marchid         : 0x2a
> > > > mimpid          : 0x0
> > > > hart isa        : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
> > > > 
> > > > When booting with a vendor CPU like veyron-v1, the proper marchid will
> > > > still appear.
> > > > 
> > > > > qemu-system-riscv64 ... -cpu veyron-v1
> > > > 
> > > > processor       : 0
> > > > hart            : 0
> > > > isa             : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
> > > > mmu             : sv48
> > > > mvendorid       : 0x61f
> > > > marchid         : 0x8000000000010000
> > > > mimpid          : 0x111
> > > > hart isa        : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
> > > > 
> > > > [1] https://lore.kernel.org/all/20240131182430.20174-1- palmer@rivosinc.com/
> > > 
> > > Thanks for linking the discussion.  I have but a vague memory of it and the link
> > > helped.
> > > 
> > > 
> > > > ---
> > > >   target/riscv/cpu.c | 9 +++++++++
> > > >   1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > index fa497e5e8a..59d63f82c2 100644
> > > > --- a/target/riscv/cpu.c
> > > > +++ b/target/riscv/cpu.c
> > > > @@ -44,6 +44,9 @@
> > > >   #endif
> > > >   /* RISC-V CPU definitions */
> > > > +#define RISCV_CPU_MVENDORID 0
> > > > +#define RISCV_CPU_MARCHID 42
> > 
> > Worth adding a comment (possibly linking to the previous URL)
> > making explicit this is an assigned number and not the answer
> > for the ultimate question of life, the universe, and everything.
> 
> Don't forget to thank for all the fish!

Haha yeah. I'll link the riscv-isa-manual entry for it.

> 
> > 
> > > > +#define RISCV_CPU_MIMPID 0
> > > >   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
> > > >   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> > > >                                 RVC, RVS, RVU, RVH, RVG, RVB, 0};
> > > > @@ -1198,6 +1201,12 @@ static void riscv_cpu_init(Object *obj)
> > > >       }
> > > >   #endif
> > > > +    if (!riscv_cpu_is_vendor(obj)) {
> > > > +        RISCV_CPU(obj)->cfg.mvendorid = RISCV_CPU_MVENDORID;
> > > > +        RISCV_CPU(obj)->cfg.marchid = RISCV_CPU_MARCHID;
> > > > +        RISCV_CPU(obj)->cfg.mimpid = RISCV_CPU_MIMPID;
> > > > +    }
> > > > +
> > > 
> > > Two things:
> > > 
> > > - we have a 'cpu' pointer at the start so you can use cpu->cfg... instead;
> > 
> > Yep, cleaner.
> > 
> > > 
> > > - the "cpu_is_vendor" check shouldn't be needed.  Whatever is set as default during
> > > cpu_init() must be overwritten by CPUDef settings done in each DEFINE_RISCV_CPU()
> > > macro.
> > > 
> > > This happens at this point:
> > > 
> > > 
> > >      env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
> > >      riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);  <================
> > > 
> > > Therefore we can remove the "cpu_is_vendor" check and just assign the default QEMU IDs
> > > as long as we do it before cpu_cfg_merge(e.g. right after "cpu-  >cfg.max_satp_mode = -1;").
> > > If we do that we'll ensure that all CPUs will carry the RVI archid 42 unless told otherwise
> > > by the CPU definition.

Oh, much better :)

> > > 
> > > Yes, this will end up changing the IDs for vendor CPUs that don't set their own IDs.  This is
> > > fine - if the CPU doesn't bother setting its own ID this means that the CPU is perfectly
> > > fine with whatever default ID QEMU will provide.> > 
> > Should we check for unset marchid and warn or even not accept config
> > with this field unset?
> 
> Hmmm maybe we can adopt a new policy where new CPUs must have an explicit
> ID set, even if zero, to be clear that the CPU doesn't care about the
> field.  But I wouldn't bother about existing vendor CPUs that doesn't set
> mvendorid TBH ... people will most likely complain about existing CPUs
> throwing warnings that they weren't throwing before.
>

I agree, it probably won't be an issue for any existing vendor CPUs to
fall back to the new value, but it would make sense to expect new ones
to set the values explicitly.

- Charlie

> 
> Cheers,
> Daniel
> 
> > 
> > > 
> > > 
> > > Thanks,
> > > Daniel
> > > 
> > > 
> > > >       accel_cpu_instance_init(CPU(obj));
> > > >   }
> > > > 
> > > > ---
> > > > base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> > > > change-id: 20260624-marchid-80d176b873d8
> > > > 
> > > > Best regards,
> > > > -- 
> > > > - Charlie
> > > > 
> > > 
> > > 
> > 
> 

