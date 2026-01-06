Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C11CCEFD01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 19:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdD2c-00042O-Dd; Tue, 06 Jan 2026 14:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdD2b-000425-FP
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:48:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdD2Y-0001f4-No
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767728904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQM0QAPX/R4gKXcAVQ0nMKr+SQR2xWZtsSLrMCxsukM=;
 b=LntnnBSdbAdBuC24oC0qezqYi10AD5ODCIUKefgSMwsQ4kKdim8LcNbR149pcmdZkyhh5F
 DlautogvZJhaez7NNhFSPKA2/bDRCBsEDaBQufW7MdULbeXmUF8sh0sgsB7roqC/wZDxgF
 Wuq23cBP3litOpPjnZutsOMHC/qJUcg=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-7xiHp4NmOiS_NLMmrCBLAw-1; Tue, 06 Jan 2026 14:48:23 -0500
X-MC-Unique: 7xiHp4NmOiS_NLMmrCBLAw-1
X-Mimecast-MFC-AGG-ID: 7xiHp4NmOiS_NLMmrCBLAw_1767728902
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-11dd10b03c6so868260c88.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 11:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767728902; x=1768333702; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sQM0QAPX/R4gKXcAVQ0nMKr+SQR2xWZtsSLrMCxsukM=;
 b=s2k1Zd6IyomB422viHsuuB87F1w9QXFCGVNU0dRdXEj07nH/M8edb+1swTqXfkMSgL
 SzejlwfreY0Lq10+yyhBSDofyQHVz7rYlXkK5Gcc8XmZc1Uz54YxaHECk02lKkaobVFk
 4yFAqtpuWf4tSM3ro8QDsqr1hlnve32qBmKstaI25GCyzm2g/u3Vg6Vl4Zc1ILMZqjCS
 gFrYdarP1kqtZcH1XacUyJg6tu83JKdydRznqZvSWOHUjMiV9nzThzTbxHooI7waTePu
 iSS/2AAowgUV7wevJDzy2WTKaWiHc+dLksFTcKKa+5rk9rxn3Aaty2kw0tSW7gZ9RhfG
 TOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767728902; x=1768333702;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQM0QAPX/R4gKXcAVQ0nMKr+SQR2xWZtsSLrMCxsukM=;
 b=KZ6jctKMDIb8yrcxB1sEg9Cy57njfCAjJDZzUNQBU25xhW2q+ugeL2RItXQPG9gDcJ
 kitgZ/kaZJvrQDmxcRB7s/D4RV5iKAyk2N6XByK+EJzyTv7CU+Qsj3VgHTC80kbV87Wu
 Sob3CIiS7qQfoCoEE+L3ksGM7qskcrNoWzBeB8+PUKZWa73e3QKr2nvqoqO+RjAWqxoU
 FSBgMZGRbUkK8ONRZkUGM+RGXDcccY+m3uN2SzSHlqEPK6qrm/O4hv6ZDTOm2Og0xmuE
 w2ZdVCFlLp8rAkAI1f/pL9VVtvu6RvFAqFYsUlhgPJ6WeaShxR9THf33sW6fA1uqg2Rw
 WDaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXGIqJxorcuO1DQBXlFtl7cj1i3tJ4oQ8q4yJ92n6hnd6wg+kyCZl/KSBNNFnec7d8GOXQBQ/D+KmD@nongnu.org
X-Gm-Message-State: AOJu0YzIzyrboTVkuILqCz7G2xH3tuLueRN8l69syCGXnx7th4ao0MTt
 vZ/ujtKLiPZw+TK8aNNjdxtzueGAHuMlnFS7ZVpD634agIz62GFmlyZJ4yL7wds/lRNgDVDePss
 ZqFP3SA60PoFs072Qsa1YaQHan81XtxperUYG+6V9YIsSlC09HHyfsEEl
X-Gm-Gg: AY/fxX6OQKsXKrE5gyJn57dyDFE4pDYxwTzq8K+FAF/40QqBb/IGNWQUhoWSWS/MjnD
 cX8YamHOcVL+aktmpbxgDVPusmCGp/JcvX2f/iILoIr5nnNia9i+dFOsrRfd0vo+1Kpz+k3tPsV
 Wc98g1MR2i988KuZtRIMmmW7O8c6cjcBp+sLCuL2ddZukkyCwzMnS5UqUzjVIjssZ8c0f1Krl+R
 7RPgOIMhic1V9mRxECmZz19KaJkdZWYOCDZznrbd2pUw0v4jDS6OOleMTmMJr4lj+9WY4NP6End
 8niVmHG/TU1Bqk6y+9hmKOT/NSEQr+kmp0WBzl0Frzga1sDr/AF7KdITsQGMIqOv69FzE6khIPG
 QeaQ=
X-Received: by 2002:a05:7022:927:b0:11b:9386:826b with SMTP id
 a92af1059eb24-121f8b9cf08mr47977c88.48.1767728901865; 
 Tue, 06 Jan 2026 11:48:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyoslrf2j6jB+78/YYaXaPKDg12pp2k3aSTCyFUoKi9E3Js2jubsZFQduK8wESR5wLrOe2fQ==
X-Received: by 2002:a05:7022:927:b0:11b:9386:826b with SMTP id
 a92af1059eb24-121f8b9cf08mr47955c88.48.1767728901238; 
 Tue, 06 Jan 2026 11:48:21 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f24984a3sm7435636c88.13.2026.01.06.11.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 11:48:20 -0800 (PST)
Date: Tue, 6 Jan 2026 14:48:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@trasno.org>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: Re: [PATCH 0/3] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <aV1m_vneDzI_5WDV@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <aVPpg_LwlGFIPfen@x1.local>
 <CAK3tnv+f8b9fd_n9_6Od3f__ZuNUtuT2Q_MXszam_k=ooRPqyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3tnv+f8b9fd_n9_6Od3f__ZuNUtuT2Q_MXszam_k=ooRPqyQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jan 04, 2026 at 01:44:52PM +0800, Zhang Chen wrote:
> On Tue, Dec 30, 2025 at 11:02 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Dec 30, 2025 at 03:05:43PM +0100, Lukas Straub wrote:
> > > Hello everyone,
> > > This adds COLO multifd support and migration unit tests for COLO migration
> > > and failover.
> >
> > Hi, Lukas,
> >
> > I'll review the series after the new year.
> >
> > Could you still introduce some background on how you're deploying COLO?  Do
> > you use it in production, or for fun?
> >
> > COLO is still a nice and interesting feature, said that, COLO has quite a
> > lot of code plugged into migration core.  I wished it's like a multifd
> > compressor which was much more self-contained, but it's not.  I wished we
> > can simplify the code in QEMU migration.
> >
> > We've talked it through before with current COLO maintainers, it looks to
> > me there aren't really much users using it in production, meanwhile COLO
> > doesn't look like a feature to benefit individual QEMU users either.
> >
> > I want to study the use case of COLO in status quo, and evaluate how much
> > effort we should put on it in the future.  Note that if it's for fun we can
> > always use a stable branch which will be there forever.  We'll need to
> > think about QEMU evolving in the future, and what's best for QEMU.
> >
> > Thanks,
> >
> 
> Hi Lukas and Peter,

Hi, Chen,

> 
> Thanks for this series, I will support for background info if Peter
> have any questions.

Thanks, I believe my major question so far was, whether we should deprecate
COLO in migration framework. :)

The netfilters and rest can be discussed separately.

Now looking back at my initial ask in Zhijian's fix, I still agree with
Zhijian on these two points mentioned:

https://lore.kernel.org/all/b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com/

That is:

        - Active users who depend on it.
        - A unit test for the COLO framework.

Meanwhile, I can't see how COLO would win if to be compared with some
app-level HA infrastructure.. considering the overhead it requires on
running two VMs and compare every packet.

Lukas, thanks for trying to fix the 2nd.  I apologize that I still
requested you to send these patches, without further raising the attention
that I still want to discuss deprecation.  I don't think anyone yet proved
we should keep COLO.  I do plan to send one patch adding COLO framework to
deprecation, if nobody would stop me in a week justifying question 1 above.

We kind of proved almost nobody is actively using COLO anymore in the past
few releases.  If nobody is using COLO, we should simply drop it.

> And CC Hailiang Zhang, although he hasn't replied to emails for a long time.
> If no one objects, I think Lukas can replease Hailiang for COLO Framework.
> 
> COLO Framework
> M: Hailiang Zhang <zhanghailiang@xfusion.com>
> S: Maintained
> F: migration/colo*
> F: include/migration/colo.h
> F: include/migration/failover.h
> F: docs/COLO-FT.txt

Right, this is also another reason why I think we may want to deprecate
COLO framework.

Since I requested this series (sorry again, Lukas), I'll review it today no
matter if we decide to merge this series at last, or deprecate COLO
framework.

Thanks,

> 
> Thanks
> Chen
> 
> > >
> > > Regards,
> > > Lukas
> > >
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > > Lukas Straub (3):
> > >       multifd: Add colo support
> > >       migration-test: Add -snapshot option for COLO
> > >       migration-test: Add COLO migration unit test
> > >
> > >  migration/meson.build              |   2 +-
> > >  migration/multifd-colo.c           |  57 ++++++++++++++++++
> > >  migration/multifd-colo.h           |  26 +++++++++
> > >  migration/multifd.c                |  14 ++++-
> > >  tests/qtest/meson.build            |   7 ++-
> > >  tests/qtest/migration-test.c       |   1 +
> > >  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++++++++++++
> > >  tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
> > >  tests/qtest/migration/framework.h  |  10 ++++
> > >  9 files changed, 294 insertions(+), 7 deletions(-)
> > > ---
> > > base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> > > change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> > >
> > > Best regards,
> > > --
> > > Lukas Straub <lukasstraub2@web.de>
> > >
> >
> > --
> > Peter Xu
> >
> 

-- 
Peter Xu


