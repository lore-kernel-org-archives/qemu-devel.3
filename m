Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F930CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 16:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzHIu-0002SK-5p; Thu, 18 Sep 2025 12:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzHIr-0002Mi-Bl
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 12:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzHIo-0002DV-LZ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 12:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758212168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7cfihwC+DHwd44Qb7Kpf7JbNbzJ0yG3FhNUTk1uBe4=;
 b=EGITGH/w40jhfPACt9OuAc1DgnO4vn5/kwRBF6cM9TkpOHGosT+t53BkI24AGlHiChBvd0
 CAOysRty4+2lI8IF3vxPIKRq2yP589HwER8WIhMxI2r7KqIwfMoFiQN0TQ1DkAGLs/oY+v
 Rv+6nmjhqGseVpIRId+dJKHtI0TOJRk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-oHyj85qwOPiUZJQzKpqieA-1; Thu, 18 Sep 2025 12:16:06 -0400
X-MC-Unique: oHyj85qwOPiUZJQzKpqieA-1
X-Mimecast-MFC-AGG-ID: oHyj85qwOPiUZJQzKpqieA_1758212166
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b7ad72bc9dso29854441cf.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 09:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758212166; x=1758816966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7cfihwC+DHwd44Qb7Kpf7JbNbzJ0yG3FhNUTk1uBe4=;
 b=W2ifpINm/+NwKTJfxI/b5nNsuSlYzUOe0Q+Mg/EIqQDEp1CtzSQGdMx4J5IMTClCON
 h92j03v592UbgiFLWNwWvbZbgy/eSgfwT3WBPIUwBQgMN+NVJuNRkn6Sb0Qk+8gqrWJm
 +t4U1/GqP/n189XmyGDoATai9Y2Jd270JkdE9jniMX+keHc8J3cTm8XL5K4T/3hWc9em
 W44i2uPQLaIt4pjVqdeMn/qdLWu3pqGAFwyNe4lWQE1Pl+S+SC8aABBGYbN845aKe2LY
 5G/4XxnwoQCIJ0Ujd3ePOcUMoGJHBl6BnDqc2d7htrsNAwpr8mtpuH1dJoxxDU5UYj64
 msqg==
X-Gm-Message-State: AOJu0YzSRoyNnn5ykdI1cH3mNbP/haYBRN9eejb+esFBS44eLhzOkpuB
 Wa8Na/u8ASKSpvpMuBIoC7sn6WICEdhxh5SADYX1jlcJZarLPLTWNqHgCy5OVS0nWiNgOqSvF+d
 CTZixM+XVwFQ8TbKbgihWXsyLTnCK1PcbvjSOLGu3Gbq5WQrRON86VUiT
X-Gm-Gg: ASbGncvC/AKSW4QtJlC0IyM76v4zE2QAa/o5lgOjnRTWoffZQQ/5Fzgv6A7fYHp8LC0
 eRLp+w3DNDsgOveUUKQg+5r3KU91mwdvpPzBojOA0rLvmwZpOqBBZdVlk05Blv/RS7kjmoe6LlY
 VHnZ8YEciILVNqQaIbRFeBjaG/bk8THLa0n7umqoMNdO/F6lLcK+omv0oC5qoUdActMNvp5SDP9
 +iPIIKYWPpOImX895SZZb5n87sx4gD8gSyTe5sf3cefIUExvSlh1dk9H+xN4I6FO7U0qoAo16vM
 tmonpTXN+R1V59q0blt3PgJX+ObIp3/s
X-Received: by 2002:a05:622a:202:b0:4b5:4874:4f92 with SMTP id
 d75a77b69052e-4ba686208d8mr79066471cf.13.1758212165886; 
 Thu, 18 Sep 2025 09:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkctG+vJIHsx/u/098IpHmt7fYeL69op+jVFcnESPWzLbf/Bt7NAdcJI4Tgzyrmy2wrqeyvQ==
X-Received: by 2002:a05:622a:202:b0:4b5:4874:4f92 with SMTP id
 d75a77b69052e-4ba686208d8mr79065841cf.13.1758212165367; 
 Thu, 18 Sep 2025 09:16:05 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-836292954b2sm184490885a.29.2025.09.18.09.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:16:04 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:15:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] migration/tls: Graceful shutdowns for main and
 postcopy channels
Message-ID: <aMwwOfX8lL25aLf7@x1.local>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <aMLK5nT4CVPrcZCB@x1.local> <87tt10vlvb.fsf@suse.de>
 <aMstJdBDMR8S2S9-@x1.local> <87ikhfvpmj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikhfvpmj.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 18, 2025 at 10:47:48AM -0300, Fabiano Rosas wrote:
> I'm thinking if it's possible for a premature termination to be detected
> by TLS before we did the shutdown(). So my suggestion was to always
> bye() before shutdown(), not matter the state migration is in. But maybe
> your way is ok, I'm not sure now. Let me read the other versions of the
> series...

For failing / cancelling migrations, premature termination is likely fine.
IMHO we also shouldn't care too much on error reports on premature
terminations because it's failing anyway.

So maybe you're talking about shutdown()s when the migration is
successfully completed.

We can try to do that, but maybe it's not easily doable.  E.g., we have the
preempt thread currently only be able to be kicked out by a shutdown() from
the dst main thread.  While we can start to inject a bye() there before the
shutdown(), it'll be:

  (1) a bye() sent concurrently while the preempt thread is still logically
  owning and operating on the preempt channel (luckily, so far read-only),
  and,

  (2) we need to double check if this works if we send bye(WR) from dest to
  src and whether it'll also gracefully shutdown the src side.

  (3) currently, a shutdown() is synchronous.  bye() is yet not.  We may
  then need similiar treatment (e.g. changing IO to block tempoararily?)
  when doing explicit shutdown()s.

I very vaguely remember when working on this series I tried (2) and it
didn't really work, but I'm not very sure. Anyway, all these will add some
complexity, and we'd better justify it's worthwhile..

[...]

> Ah, sorry, I didn't see the v2 on my list. But it's there.

Nah, that's not your fault, maybe mine.

-- 
Peter Xu


