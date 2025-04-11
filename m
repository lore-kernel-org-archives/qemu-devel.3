Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA8DC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 07:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u38ln-00060F-KE; Fri, 11 Apr 2025 03:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u38lX-0005zb-Fu
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u38lU-0007Ai-C4
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744356326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sa3AQtb5eZ4I6sEty3xv2SaGxAiR8pNzCUh07Y3IwzQ=;
 b=KGnudJ5rMihdXKZBkItWa0zm0+7LZhI0Uul1bNZRNcc7/3aeBcEmu0x0Nzcpy/QKPpNRh3
 ieye+4U7n0fWz8ihBFTJhX5PKExK8Ey+TsueMhlQKajX5kVTPzIHEMsWRrGjmC45iwbT/4
 2fl1sykejvxWD/udJlX/0z8rqbpoQHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-HSqxQkdQPsidpemv-kS3dA-1; Fri, 11 Apr 2025 03:25:22 -0400
X-MC-Unique: HSqxQkdQPsidpemv-kS3dA-1
X-Mimecast-MFC-AGG-ID: HSqxQkdQPsidpemv-kS3dA_1744356321
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso8238435e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744356321; x=1744961121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sa3AQtb5eZ4I6sEty3xv2SaGxAiR8pNzCUh07Y3IwzQ=;
 b=mLJrn99w0A3hTjj872yD49/cHkgwvq1LReUmyKRNobexir0ai4MYLagA1lqDuG73HD
 ZoSfoJAGAthtIxHBlD/O8gQDy1rbdXoSpCim93ajgDmkRLnEVpvkVUscpBsxqCtZpvcJ
 d5P8nH0fVz/KGq6LReY29xEWE6CdaC6zBXPE2P3mExGP6F6ien63cZmmT5sn40bxrIvA
 VuI5PSHxB50a3XOCL5hX7jgECBkS2pV67Haq8WcW1JxNKWXlhm3JfVvgnLU2U+WZ8qg7
 vLtlCyfM+goEIdsojHyNxLCGL0UdykoUtqnp/QmOX+OMYxtjdRx9k1nD+nAYp3rci3RZ
 +8MA==
X-Gm-Message-State: AOJu0Yzp8AUeGVrQZz5OL3gbJyI7/Lif492n/aLbo9FFzgcLJpN7lrh/
 0Tb5bRSbiwKo+73NwWz/5XFvKe0bfTNxG+4PcYijpgjnYrV0ZsveXLP2n8DieNFz0dnRmenFWnV
 zVMBF6Zj0zBCOgrmJsBStXGjiIjSIljHB2r6k8HS97SS2iBVs2ZQ3WD9sECh1csk4Vo8pavLp85
 Emg5i2FWe8m87nyA7shsoY47/DloM=
X-Gm-Gg: ASbGncsx63Df4T3nY24rURdXhDFBmypx5aq49RZGI1di+4uvug4QCSVg0gHOeECnrJF
 wNz3SdC3f5Sk09jIo/fOSKoiVyI1WHfmVq42+9yhHwuEHQaaeDf8EnJecrEcXVSFLuw6y96M=
X-Received: by 2002:a05:600c:1e1c:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-43f39622728mr13773625e9.1.1744356321313; 
 Fri, 11 Apr 2025 00:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwIBCw7gDRTR/8J8Lm3wIgxaFFtQEY1ECjxBSDCGlJbYVTH96gRBkhESqu1gO74fU7nrepLMwMV1e1OhbbwBA=
X-Received: by 2002:a05:600c:1e1c:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-43f39622728mr13773465e9.1.1744356320941; Fri, 11 Apr 2025
 00:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <87plhwgbu6.fsf@suse.de>
 <CAE8KmOyS+nPexU_NbF0yhK_=ubnGgKs5Lv+j7bH=xowgqQ2zkA@mail.gmail.com>
 <87zfgxjspn.fsf@suse.de>
 <CAE8KmOxi3w5sf_sd04qLxkg8Lys=KA0pMPJMcZ-=CJVGZRmivw@mail.gmail.com>
 <87h62vhitf.fsf@suse.de>
In-Reply-To: <87h62vhitf.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 11 Apr 2025 12:55:03 +0530
X-Gm-Features: ATxdqUGBEB7RXI_v1ys7_dRENJlwBKSb02dAsmttYCAPLIyCPVZi9-NiagpJ-kg
Message-ID: <CAE8KmOxrfMbJsLgyymGu2tNTUVXQvygwXgaaW7s19V-H=fZNwA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On Fri, 11 Apr 2025 at 01:48, Fabiano Rosas <farosas@suse.de> wrote:
> That's what it looks like. It could be some error condition that is not
> being propagated properly. The thread hits an error and exits without
> informing the rest of migration.

* The gdb(1) hanging in the postcopy_ram_fault_thread() is not
conclusive. I tried to set following break-points

    gdb) break postcopy-ram.c:998 - poll_result = poll(pfd, pfd_len,
-1 /* Wait forever */);
    gdb) break postcopy-ram.c:1057 -  rb = qemu_ram_block_from_host(...);

  gdb(1) hangs for both of them, there might be another reason for it.
Live-migration also stalls with it.

> Some combination of the postcopy traces should give you that. Sorry,
> Peter Xu really is the expert on postcopy, I just tag along.

* I see. Maybe it could be logged with --migration-debug=<level> option.

> The snippet I posted shows that it's the same page:
>
> (gdb) x/i $pc
> => 0x7ffff5399d14 <__memcpy_evex_unaligned_erms+86>:    rep movsb %ds:(%rsi),%es:(%rdi)
> (gdb) p/x $rsi
> $1 = 0x7fffd68cc000
>
===
>> Thread 1 (Thread 0x7fbc4849df80 (LWP 7487) "qemu-system-x86"):
...
>> Thread 10 (Thread 0x7fffce7fc700 (LWP 11778) "mig/dst/listen"):
...
>> Thread 9 (Thread 0x7fffceffd700 (LWP 11777) "mig/dst/fault"):
#0  0x00007ffff5314a89 in __GI___poll (fds=0x7fffc0000b60, nfds=2,
timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
...
postcopy_ram_fault_thread_request Request for HVA=0x7fffd68cc000
rb=pc.ram offset=0xcc000 pid=11754
===

* Looking at the above data, it seems the missing page fault occurred
in thread=11754 , it may not be the memcpy(3) in
thread-1(pid/tid=7487) that triggered the fault.

* Secondly, if 'mig/dst/fault' thread is waiting at poll(2) call, ie.
fault notification has not arrived on the mis->userfault_fd  OR
mis->userfault_event_fd descriptors yet.  So the "Request for
HVA=0x7fffd..." via postcopy_ram_fault_thread_request() could be an
already served request.


> Send your next version and I'll set some time aside to debug this.
>
> heads-up: I'll be off from 2025/04/18 until 2025/05/05. Peter should be
> already back in the meantime.

* Okay, I'll send the next version.

Thank you.
---
  - Prasad


