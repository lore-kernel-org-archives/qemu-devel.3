Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9ADC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 00:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXsa4-0008Sv-Eg; Wed, 07 Feb 2024 19:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXsZt-0008OP-1j
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 19:47:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXsZq-00061B-NS
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 19:47:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40efcb37373so11611435e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 16:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707353258; x=1707958058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFVoDOBEh0E8Oz1n3p1fvwFUP4G7bkewPRQZKza5i10=;
 b=ff6LGPBPYz+7gTxINuIWcnIfm9rthn5hUijxCvMCi5Tx26HPEsKIKZSw+98LRtQ/oc
 BNkFqOYiV8dQd1RI7MGlh91Zr5YtY51/Q5bBN+F/3Y4qTzlCOh4tPvhwwA2DHLKRLaYZ
 iCxz6Cy7YDqEwBDRVg+dKS1D06y+ODu7N/LaVvXrOGO98JXNKutrDStBUPl+SQre5lUS
 +vxyqn5MX9nLhIz5VKyBp02HvckL6XF3lyxaxldVIq77SVU7cAR1P6TySfB/jU1uO0+9
 ZqTJrzFuW0ShtMAy5/VO2SJT0mORZNLvNZqzMglGCH8G+32eBpYSYE91o5YXqBsMcZ53
 +gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707353258; x=1707958058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFVoDOBEh0E8Oz1n3p1fvwFUP4G7bkewPRQZKza5i10=;
 b=jTjLW8LR4naspDqpD5vpqna+h+gKPLlpAxBuSCVdoisi6Pk5e/V0C4sj7e7Z+Kw/xg
 V1gERBZmtzz7HlMeDFiu4qCmM9AEQwtXXmQPZ6mTk2iacK0Jbok5TM/2FCfFl1mDeht/
 dyfnO7seY4N6ktmqc+eaeckX1Bv2KqSsk+4c4MDGaHd9WoMGAbsEO4A3aQnkjgdd6ACp
 Hnm7PkKL14qP45s7wFAJe8fSsu/Uwai4d5LjJVSFOXzhJ2ddWJUN/4u4P/3Ih/vamAXY
 ynP/mzVo0Vx99TT2PC26zqQImId7ESrmOq19queyebCVvNozd0+uw4DN9yWzKwY4KE7F
 xqqw==
X-Gm-Message-State: AOJu0YzJ9pb2/HG11cjjfJMkt0+HHtL1/TAEjjiJikmaI3WRwAvzMlMo
 PAMwqDB5kX17o+q7ZD3pbahebG/iGavpEokm4pSf07YENwrgULdeHaI8aLuYx9YWghZ+obrPT2C
 hYOFDruFQA/bm2p/wrlO/ofPdlHjOyt2rMxpqiTLg17mzy4nx
X-Google-Smtp-Source: AGHT+IFZASS5sJRitI48ABvnWMFyBTaMBVQQn5IlwBSdkDZWwtQd4LS6uCeqc3zy6rXqj7I4Os7YLWkfyesRk48DUyg=
X-Received: by 2002:adf:ffc3:0:b0:33b:506e:5513 with SMTP id
 x3-20020adfffc3000000b0033b506e5513mr2338883wrs.9.1707353258262; Wed, 07 Feb
 2024 16:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <ZcL7aIwo_Z8gn6h3@x1n>
In-Reply-To: <ZcL7aIwo_Z8gn6h3@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 7 Feb 2024 16:47:27 -0800
Message-ID: <CAAYibXjQYkpL+L8pLX5DQ4hTWqFAc2pcpkJFmE5bs=O5vzhDPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/6] Introduce multifd zero page checking.
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=hao.xiang@bytedance.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Feb 6, 2024 at 7:39=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 06, 2024 at 11:19:02PM +0000, Hao Xiang wrote:
> > This patchset is based on Juan Quintela's old series here
> > https://lore.kernel.org/all/20220802063907.18882-1-quintela@redhat.com/
> >
> > In the multifd live migration model, there is a single migration main
> > thread scanning the page map, queuing the pages to multiple multifd
> > sender threads. The migration main thread runs zero page checking on
> > every page before queuing the page to the sender threads. Zero page
> > checking is a CPU intensive task and hence having a single thread doing
> > all that doesn't scale well. This change introduces a new function
> > to run the zero page checking on the multifd sender threads. This
> > patchset also lays the ground work for future changes to offload zero
> > page checking task to accelerator hardwares.
> >
> > Use two Intel 4th generation Xeon servers for testing.
> >
> > Architecture:        x86_64
> > CPU(s):              192
> > Thread(s) per core:  2
> > Core(s) per socket:  48
> > Socket(s):           2
> > NUMA node(s):        2
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               143
> > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > Stepping:            8
> > CPU MHz:             2538.624
> > CPU max MHz:         3800.0000
> > CPU min MHz:         800.0000
> >
> > Perform multifd live migration with below setup:
> > 1. VM has 100GB memory. All pages in the VM are zero pages.
> > 2. Use tcp socket for live migratio.
> > 3. Use 4 multifd channels and zero page checking on migration main thre=
ad.
> > 4. Use 1/2/4 multifd channels and zero page checking on multifd sender
> > threads.
> > 5. Record migration total time from sender QEMU console's "info migrate=
"
> > command.
> > 6. Calculate throughput with "100GB / total time".
> >
> > +------------------------------------------------------+
> > |zero-page-checking | total-time(ms) | throughput(GB/s)|
> > +------------------------------------------------------+
> > |main-thread        | 9629           | 10.38GB/s       |
> > +------------------------------------------------------+
> > |multifd-1-threads  | 6182           | 16.17GB/s       |
> > +------------------------------------------------------+
> > |multifd-2-threads  | 4643           | 21.53GB/s       |
> > +------------------------------------------------------+
> > |multifd-4-threads  | 4143           | 24.13GB/s       |
> > +------------------------------------------------------+
>
> This "throughput" is slightly confusing; I was initially surprised to see=
 a
> large throughput for idle guests.  IMHO the "total-time" would explain.
> Feel free to drop that column if there's a repost.
>
> Did you check why 4 channels mostly already reached the top line?  Is it
> because main thread is already spinning 100%?
>
> Thanks,
>
> --
> Peter Xu

Sure I will drop "throughput" to avoid confusion. In my testing, 1
multifd channel already makes the main thread spin at 100%. So the
total-time is the same across 1/2/4 multifd channels as long as zero
page is run on the main migration thread. Of course, this is based on
the fact that the network is not the bottleneck. One interesting
finding is that multifd 1 channel with multifd zero page has better
performance than multifd 1 channel with main migration thread.
>

