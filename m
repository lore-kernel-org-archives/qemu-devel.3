Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F9CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 20:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtvM5-000622-0B; Mon, 08 Apr 2024 16:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtvM0-00061E-BH
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 16:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtvLy-0002VC-35
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 16:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712607148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvEVzIESl5BDg/8nTlU61W1lLKmP4rOZ/LF4avxr1Y4=;
 b=MVkiR0zTyi8l4s56zVdvmExbCTogzGfv5pkGSzPFmMcmuONV8VRnZgezoyuLVqT3jaY+5s
 8aW08lZctPn4ebJKsjQx8ZmxSzH9ukm7l072PqGXxl50Zm50ml/ZusiCli/FM2d5ulIxLa
 vChGswFRV5VMGi46Yu0reNVfzmrIkII=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-oXiROjluMGmjqvk7Ck1HVw-1; Mon, 08 Apr 2024 16:12:21 -0400
X-MC-Unique: oXiROjluMGmjqvk7Ck1HVw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343e00c8979so2197970f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 13:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712607140; x=1713211940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AvEVzIESl5BDg/8nTlU61W1lLKmP4rOZ/LF4avxr1Y4=;
 b=PRZQJ7BWac7pF1Ck6W6ItXuQZOjDtb+Il9rbiK/iNn1RJY54OuZaxf2eAn1rVnF+t3
 SBXCW4dO/X5aGvFy5/4asszyLqnfeG10gzQjJur4mZ33hX8LQiRB9ykOs0YLSWnIJNWl
 vpOdYyiHFV69RgC0DlKVbWNc9H6ymPug+6EFyT1yi1pGlL3zyeTj3vAARblZbpoy+z2X
 lQeHiRqVKaALkSfk6RrWYndPGu+LBbKfP6naiWHuG6ZTzT05ui1ap+QcRtau0Ctp5q1x
 XSFXIdFYTdbqVV2XsGLCbyLe2bOBj2f1WBcC6+ZOx2BcEd14evFu1HAuwwqDZ4wg6eQ7
 VaFQ==
X-Gm-Message-State: AOJu0Yx3AqhZ8ssTxxOPF15kw/CFkNlguQokQUgXYTQ//TcvlXXW4K6Z
 Qo6LRvP/WGfjOlmayhdDfCSPiORW0H4lc8AMhaW+yql9Q59zRcWgCMXBENh2TixxQ9jsaSnmLeg
 TEoa4ImMEOmSiwsKVXWn0OcmM4lSNz2/mkWgxGE5I6LMAoBP7clcK73Vuhfetyxd0fE6ZTR895H
 12t0xdOr+CT3/yq+qh4c2gRQ7LdBeTPxmMbwY=
X-Received: by 2002:adf:cc87:0:b0:343:7e98:e73e with SMTP id
 p7-20020adfcc87000000b003437e98e73emr6053646wrj.40.1712607139769; 
 Mon, 08 Apr 2024 13:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGuS5MbRiRTWSWdnWlbMWRF6DuHzFIAJnQWDbKh5q3+OHUvelFL2SvL01haT/QVL/A8TsDgCQSPnQDNFXQO8U=
X-Received: by 2002:adf:cc87:0:b0:343:7e98:e73e with SMTP id
 p7-20020adfcc87000000b003437e98e73emr6053638wrj.40.1712607139463; Mon, 08 Apr
 2024 13:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240311075806.668555-1-pbonzini@redhat.com>
 <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
 <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
In-Reply-To: <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 22:12:07 +0200
Message-ID: <CABgObfYncdWq3+40TqEGcpLgoxxBK-5b7-T7JmkK8itusVXhUA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-stable <qemu-stable@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000301f1406159b6ca0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000301f1406159b6ca0
Content-Type: text/plain; charset="UTF-8"

Il ven 5 apr 2024, 19:30 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> 01.04.2024 09:02, Michael Tokarev:
>
> > Anyone can guess why this rather trivial and obviously correct patch
> causes segfaults
> > in a few tests in staging-7.2 - when run in tcg mode, namely:
> >
> >    pxe-test
> >    migration-test
> >    boot-serial-test
> >    bios-tables-test
> >    vmgenid-test
> >    cdrom-test
> >
> > When reverting this single commit from staging-7.2, it all works fine
> again.
>
> It sigsegvs in probe_access_internal():
>
>    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr); -- this one returns
> NULL,
>
> and next there's a call
>
>    tlb_addr = tlb_read_ofs(entry, elt_ofs);
>
> which fails.
>

I will take a look tomorrow.

Paolo


> #0  0x0000555555c5de8a in tlb_read_ofs (ofs=8, entry=0x0) at
> 7.2/accel/tcg/cputlb.c:1455
> #1  probe_access_internal
>      (env=0x555556a862a0, addr=4294967280, fault_size=fault_size@entry=1,
> access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=5,
> nonfault=nonfault@entry=false, phost=0x7fffea4d32a0,
> pfull=0x7fffea4d3298, retaddr=0)
>      at 7.2/accel/tcg/cputlb.c:1555
> #2  0x0000555555c62aba in get_page_addr_code_hostp
>      (env=<optimized out>, addr=addr@entry=4294967280, hostp=hostp@entry
> =0x0)
>      at 7.2/accel/tcg/cputlb.c:1691
> #3  0x0000555555c52b54 in get_page_addr_code (addr=4294967280,
> env=<optimized out>)
>      at 7.2/include/exec/exec-all.h:714
> #4  tb_htable_lookup
>      (cpu=cpu@entry=0x555556a85530, pc=pc@entry=4294967280,
> cs_base=cs_base@entry=4294901760, flags=flags@entry=64,
> cflags=cflags@entry=4278190080) at
> 7.2/accel/tcg/cpu-exec.c:236
> #5  0x0000555555c53e8e in tb_lookup
>      (cflags=4278190080, flags=64, cs_base=4294901760, pc=4294967280,
> cpu=0x555556a85530)
>      at 7.2/accel/tcg/cpu-exec.c:270
> #6  cpu_exec (cpu=cpu@entry=0x555556a85530) at
> 7.2/accel/tcg/cpu-exec.c:1001
> #7  0x0000555555c75d2f in tcg_cpus_exec (cpu=cpu@entry=0x555556a85530)
>      at 7.2/accel/tcg/tcg-accel-ops.c:69
> #8  0x0000555555c75e80 in mttcg_cpu_thread_fn (arg=arg@entry
> =0x555556a85530)
>      at 7.2/accel/tcg/tcg-accel-ops-mttcg.c:95
> #9  0x0000555555ded098 in qemu_thread_start (args=0x555556adac40)
>      at 7.2/util/qemu-thread-posix.c:505
> #10 0x00007ffff5793134 in start_thread (arg=<optimized out>)
> #11 0x00007ffff58137dc in clone3 ()
>
>
> I'm removing this whole set from 7.2 for now:
>
>   2cc68629a6fc target/i386: fix direction of "32-bit MMU" test
>   90f641531c78 target/i386: use separate MMU indexes for 32-bit accesses
>   5f97afe2543f target/i386: introduce function to query MMU indices
>
> This leaves us with
>
>   b1661801c184 "target/i386: Fix physical address truncation"
>
> but without its fix, 2cc68629a6fc.
>
> It looks like I should revert b1661801c184 from 7.2 too, re-opening
> https://gitlab.com/qemu-project/qemu/-/issues/2040 - since to me it isn't
> clear if this change actually fixes this issue or not without the
> previous change, 90f641531c78, which is missing from 7.2.10.
>
> At the very least this will simplify possible another attempt to
> cherry-pick
> these changes to 7.2.
>
> Thanks,
>
> /mjt
>
>

--000000000000301f1406159b6ca0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 5 apr 2024, 19:30 Michael Tokarev &lt;<a href=
=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">01.04.2024 09:02, Michael Tokarev:<br>
<br>
&gt; Anyone can guess why this rather trivial and obviously correct patch c=
auses segfaults<br>
&gt; in a few tests in staging-7.2 - when run in tcg mode, namely:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 pxe-test<br>
&gt;=C2=A0 =C2=A0 migration-test<br>
&gt;=C2=A0 =C2=A0 boot-serial-test<br>
&gt;=C2=A0 =C2=A0 bios-tables-test<br>
&gt;=C2=A0 =C2=A0 vmgenid-test<br>
&gt;=C2=A0 =C2=A0 cdrom-test<br>
&gt; <br>
&gt; When reverting this single commit from staging-7.2, it all works fine =
again.<br>
<br>
It sigsegvs in probe_access_internal():<br>
<br>
=C2=A0 =C2=A0CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr); -- this =
one returns NULL,<br>
<br>
and next there&#39;s a call<br>
<br>
=C2=A0 =C2=A0tlb_addr =3D tlb_read_ofs(entry, elt_ofs);<br>
<br>
which fails.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">I will take a look tomorrow.=C2=A0</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
#0=C2=A0 0x0000555555c5de8a in tlb_read_ofs (ofs=3D8, entry=3D0x0) at 7.2/a=
ccel/tcg/cputlb.c:1455<br>
#1=C2=A0 probe_access_internal<br>
=C2=A0 =C2=A0 =C2=A0(env=3D0x555556a862a0, addr=3D4294967280, fault_size=3D=
fault_size@entry=3D1, access_type=3Daccess_type@entry=3DMMU_INST_FETCH, mmu=
_idx=3D5, <br>
nonfault=3Dnonfault@entry=3Dfalse, phost=3D0x7fffea4d32a0, pfull=3D0x7fffea=
4d3298, retaddr=3D0)<br>
=C2=A0 =C2=A0 =C2=A0at 7.2/accel/tcg/cputlb.c:1555<br>
#2=C2=A0 0x0000555555c62aba in get_page_addr_code_hostp<br>
=C2=A0 =C2=A0 =C2=A0(env=3D&lt;optimized out&gt;, addr=3Daddr@entry=3D42949=
67280, hostp=3Dhostp@entry=3D0x0)<br>
=C2=A0 =C2=A0 =C2=A0at 7.2/accel/tcg/cputlb.c:1691<br>
#3=C2=A0 0x0000555555c52b54 in get_page_addr_code (addr=3D4294967280, env=
=3D&lt;optimized out&gt;)<br>
=C2=A0 =C2=A0 =C2=A0at 7.2/include/exec/exec-all.h:714<br>
#4=C2=A0 tb_htable_lookup<br>
=C2=A0 =C2=A0 =C2=A0(cpu=3Dcpu@entry=3D0x555556a85530, pc=3Dpc@entry=3D4294=
967280, cs_base=3Dcs_base@entry=3D4294901760, flags=3Dflags@entry=3D64, cfl=
ags=3Dcflags@entry=3D4278190080) at <br>
7.2/accel/tcg/cpu-exec.c:236<br>
#5=C2=A0 0x0000555555c53e8e in tb_lookup<br>
=C2=A0 =C2=A0 =C2=A0(cflags=3D4278190080, flags=3D64, cs_base=3D4294901760,=
 pc=3D4294967280, cpu=3D0x555556a85530)<br>
=C2=A0 =C2=A0 =C2=A0at 7.2/accel/tcg/cpu-exec.c:270<br>
#6=C2=A0 cpu_exec (cpu=3Dcpu@entry=3D0x555556a85530) at 7.2/accel/tcg/cpu-e=
xec.c:1001<br>
#7=C2=A0 0x0000555555c75d2f in tcg_cpus_exec (cpu=3Dcpu@entry=3D0x555556a85=
530)<br>
=C2=A0 =C2=A0 =C2=A0at 7.2/accel/tcg/tcg-accel-ops.c:69<br>
#8=C2=A0 0x0000555555c75e80 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555=
556a85530)<br>
=C2=A0 =C2=A0 =C2=A0at 7.2/accel/tcg/tcg-accel-ops-mttcg.c:95<br>
#9=C2=A0 0x0000555555ded098 in qemu_thread_start (args=3D0x555556adac40)<br=
>
=C2=A0 =C2=A0 =C2=A0at 7.2/util/qemu-thread-posix.c:505<br>
#10 0x00007ffff5793134 in start_thread (arg=3D&lt;optimized out&gt;)<br>
#11 0x00007ffff58137dc in clone3 ()<br>
<br>
<br>
I&#39;m removing this whole set from 7.2 for now:<br>
<br>
=C2=A0 2cc68629a6fc target/i386: fix direction of &quot;32-bit MMU&quot; te=
st<br>
=C2=A0 90f641531c78 target/i386: use separate MMU indexes for 32-bit access=
es<br>
=C2=A0 5f97afe2543f target/i386: introduce function to query MMU indices<br=
>
<br>
This leaves us with<br>
<br>
=C2=A0 b1661801c184 &quot;target/i386: Fix physical address truncation&quot=
;<br>
<br>
but without its fix, 2cc68629a6fc.<br>
<br>
It looks like I should revert b1661801c184 from 7.2 too, re-opening<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2040" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/=
issues/2040</a> - since to me it isn&#39;t<br>
clear if this change actually fixes this issue or not without the<br>
previous change, 90f641531c78, which is missing from 7.2.10.<br>
<br>
At the very least this will simplify possible another attempt to cherry-pic=
k<br>
these changes to 7.2.<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--000000000000301f1406159b6ca0--


