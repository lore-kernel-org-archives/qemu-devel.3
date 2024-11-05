Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2920D12676
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8GNe-00006o-Bm; Tue, 05 Nov 2024 05:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8GNZ-00006D-Vg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8GNY-0007wV-G5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730800899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uKQT+r4BKL3A33JSY+MXptz+0BNeaIcvY+Zwk3cVGT8=;
 b=RYI+NaCExx7UWHIQAyBx5qs0YhRrIkMNr/rXdRqI3szAa5W4qn7J39bFUe/uU+nqgAqa1c
 BTTQIN5INdfZhm8Hd+DNy8wwDfxH9Ust26PnYAi8T8HD3BvJVCQsw3LOMjJPTSyFsEiZ71
 fXx0VJDkgaP09wvo2h4M/V3UZ0ooZgE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-khHqtfxcOrat-tm5nV_cMw-1; Tue, 05 Nov 2024 05:01:37 -0500
X-MC-Unique: khHqtfxcOrat-tm5nV_cMw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so35595105e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730800896; x=1731405696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKQT+r4BKL3A33JSY+MXptz+0BNeaIcvY+Zwk3cVGT8=;
 b=rtMihc9oEtzXoyammO5AXWPCvU5EBLi7yH8GVTauQhKuAaM1tskRTdCpb++fesb2NR
 FofgXyRqvr5x65ftIPegAt0aEHHXJQib4172XFeTQ3T2udhLKSoRvqPVMJArkzgQN42f
 go6KthENUIJfvlXitov5z2V5JRob5jk1H0kbNn4UKnalVM0QTEy0ul7J7GLJi7aAW/EF
 TyPTDYRZvc7UVLeIgjgPFTbTjZnYUQgBB8B/mYkiakBkSOvqmGsvkZZQHCqmJrFraPd9
 WXMhFhZaYLZbPZnitTisxs0IwoGgDsqKVlb5f5wekcqalckmV8N1ehcDLTslbbj8dyT7
 8liw==
X-Gm-Message-State: AOJu0Yx1JavCYp7KXzWroDFBFmC499Sekn7B4JxWzGYLY4ZxZDSaGOWP
 SMFrkMnG2k++msKf+wdAKcFG757pKLez890MQUV1cLR5fImlHYY/8u4L2U+slwFUFKADBZxOYP4
 6kZxEzHiopAZyv+USPKaag0SWuXY9AWM/kbB23TD8c/EBmQ2El3KeSlVqMun72DZjvE/BK6Xj+4
 ooqIWqdJlG1a1izMEfH92OomuuNSJ+4e6rjcU=
X-Received: by 2002:a05:600c:1ca9:b0:42e:8d0d:bca5 with SMTP id
 5b1f17b1804b1-43283242bafmr117522865e9.2.1730800896138; 
 Tue, 05 Nov 2024 02:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrpo9emjt8xWnMDLxIK9ZAQPExSg9MFGGZEHCRxYOkN+h6S9VNBnyC9QKLPq094b/WL0nSc3Smbn/15mqt8BY=
X-Received: by 2002:a05:600c:1ca9:b0:42e:8d0d:bca5 with SMTP id
 5b1f17b1804b1-43283242bafmr117522595e9.2.1730800895759; Tue, 05 Nov 2024
 02:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-5-ppandit@redhat.com>
 <ZyToBbvfWkIZ_40W@x1n>
 <CAE8KmOyi+_U2H1r=MyQmppNj6v3mMqpjMyMo=q9zm0=-49+B3g@mail.gmail.com>
 <Zyj9rz6eD-gAm4fa@x1n>
In-Reply-To: <Zyj9rz6eD-gAm4fa@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Nov 2024 15:31:19 +0530
Message-ID: <CAE8KmOy-up_gi8t0qGwtM04QmFvaEK7VmL=1JxEFR-ksHLiQ1w@mail.gmail.com>
Subject: Re: [PATCH 4/5] migration: refactor ram_save_target_page functions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, 4 Nov 2024 at 22:30, Peter Xu <peterx@redhat.com> wrote:
> Yes, IMHO it's better when merged.
>
> One more note here, that even with ZERO_PAGE_DETECTION_MULTIFD, qemu will
> fallback to use LEGACY in reality when !multifd before.  We need to keep
> that behavior.

* Where does this fallback happen? in ram_save_target_page()?

> > * Ie. drop the 'migration_ops' object altogether? And call
> > ram_save_target_page() as it used to be before multifd mode?
>
> Yes.

Okay, thank you.
---
  - Prasad


