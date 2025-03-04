Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC60C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNMD-0006rW-F0; Tue, 04 Mar 2025 03:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpNMB-0006rI-1P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tpNM8-0006PU-Ix
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9BrnmCE4pyQiSr0AD9StEE+RAnPdyhggFa6ESMlJOvk=;
 b=UecSdjcJ8ea6m4JD1S8A0CCAWLRrv3MjQO5kBk5f6R2DY31eVqYH02S5jWE/HJXDT0Dn2K
 spBESHgpBS9VKRzJNHJTtyg/BUM0cNEASwKI8y7C8Xuvmy1JM6u4lPVSu/UnrbSiiqnCNU
 bIGF08ag0LxDqay+5EI3WO8+NpFo0Ig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-VToJh2Z6OsuX0FoaKMiWag-1; Tue, 04 Mar 2025 03:10:21 -0500
X-MC-Unique: VToJh2Z6OsuX0FoaKMiWag-1
X-Mimecast-MFC-AGG-ID: VToJh2Z6OsuX0FoaKMiWag_1741075820
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390df5962e1so2573440f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 00:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741075820; x=1741680620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BrnmCE4pyQiSr0AD9StEE+RAnPdyhggFa6ESMlJOvk=;
 b=h0w8Xv/E8ZrI1cF3yavJNHrL+VpH75FvpBYFUe6cqIJYyKw7zuovn9zlJ7PFiSjrYO
 TujkmuDXPnDxkjqiqrxemcZqGN1PQytlGETq6BFp0eMIVkOTPeb8B987EQnphqDjUQdp
 VDAU4GiVhfuw8pnOcX/roK2Fnxi9TJ3lg7mFnO3PDcE9ITApOxedBfqyd0PwzBJ3NNcS
 vW0hhcPdbzlr4sTB0VRupJ9uf5AsW6AcCVH/2appBjOWN5nQGTpjj+7FOTq6/JLwo3KI
 CFTDM/cu+uX/o12wpyjWosatljl2gQVJHCF7tfU4M4XzoD01ebkxUHwqrb5HtmeyUEgu
 SBgA==
X-Gm-Message-State: AOJu0YxsXJBIM2t5FtndjuLamUwI7W2qLuDCT3oXJCJzfYmUCrVJ5jaY
 yMi4Wbj2hEA5GnFpWaeKhEowc4da+hP0GA/hCTurXk8+PNRUEJ2s6xMXhaBpy88Zu+zpa+hLNQD
 Y3pDZuTQAd3ym5lHEnlqhEy5+SpznltZitwW7kzMWLhntQymKBajYntMG/fBPQxSyacVb2dBE5Q
 M4X/3Xcy9pE1b8BHluSrygcXm993A=
X-Gm-Gg: ASbGncsWBVdHBTvr6HDiYIjFspEtXCsh/ftrZrNcZV6VCppKaumklYz/Jac80r/ceqf
 P729EAWQ2qtfjSw4Lc+FiQb+fXZ/fUPFc7ISY7CoKTOGoF9zAWyMk7TusfcbrxYk2mRjywlEqk8
 k=
X-Received: by 2002:a5d:64cc:0:b0:390:e535:8740 with SMTP id
 ffacd0b85a97d-391156052bamr1598003f8f.14.1741075819874; 
 Tue, 04 Mar 2025 00:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOGamvraQhwHz/0voTqJa4UNENmJC7DkbXeqPTOzeNVRBTq6VBkvGVoj1kcxsQAjUnFN4VpV4raIt6mlJUWRM=
X-Received: by 2002:a5d:64cc:0:b0:390:e535:8740 with SMTP id
 ffacd0b85a97d-391156052bamr1597984f8f.14.1741075819543; Tue, 04 Mar 2025
 00:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
In-Reply-To: <Z8XBowkG72G-l3L4@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 4 Mar 2025 13:40:02 +0530
X-Gm-Features: AQ5f1JopWkbfAFr-sScV0yeTQOnGFX4U2VcdTwOqFmuQ5GTXyNP3TQdwQZMsasg
Message-ID: <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Hello Peter,

On Mon, 3 Mar 2025 at 20:20, Peter Xu <peterx@redhat.com> wrote:
> We need the header.

* We need a section type, which is sent by qemu_savevm_command_send()
as 'QEMU_VM_COMMAND'.

>  Maybe the easiest as of now is one more hook like
> qemu_savevm_state_complete_precopy_prepare(), and only use it in RAM as of
> now.

* What will this helper do?

> > * But earlier we discussed 'flush and sync' is enough for that, no?
>
> Yes it's ok I think, but this patch didn't do that.
>
> +            multifd_send_flush();
> +            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
> +            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
>
> I don't think it sent RAM_SAVE_FLAG_MULTIFD_FLUSH.  IIUC you need the
> complete multifd_ram_flush_and_sync(), and the new message not needed.

* If we look at multifd_ram_flush_and_sync(), it does:
     1. multifd_send()                       <= this patch does it via
multifd_send_flush()
     2. multifd_send_sync_main()    <= this patch also calls it above
     3. send RAM_SAVE_FLAG_MULTIFD_FLUSH  <= this patch sends
MIG_CMD_MULTIFD_RECV_SYNC

* What is missing?

> Instead of I prepare the patch and whole commit message, please take your
> time and think about it, justify it, and if you also think it works put
> explanation into commit message and then we can go with it.

* The commit message does explain about flush and sync and how the
migration command helps. What else do we need to add?

> > * And multifd_recv_sync_main() function on the destination blocks the
> > 'main' thread until all multfd_recv_threads (mig/dst/recv_x) have
> > exited, only then it proceeds to accept the incoming new postcopy
> > connection.
>
> I don't think it makes sure threads have exited,

* 'multifd_recv_sync_main()' blocks the main thread on
'multifd_recv_state->sem_sync' semaphore. It is increased when
multifd_recv threads exit due to the shutdown message. ie. the 'main'
thread unblocks when all 'mig/dst/recv_x' threads have exited.

Thank you.
---
  - Prasad


