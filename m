Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B2CC55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrnOI-00025d-1Y; Wed, 05 Aug 2026 21:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wrnOH-00025V-8t
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:59:25 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wrnOF-0003pu-CU
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:59:24 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso1404831a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785981561; cv=none;
 d=google.com; s=arc-20260327;
 b=mw3CUU/FtI3IyrspBNEnZOnEnleTkvTOq7EplYw+UUrtLM/5dJmZggPrd3/ousKxCp
 lkLiKwtwvprzFzQPN9A8mLz7gJ3cFBC7lnLEBnm3WQBAGUzCPi4IFqJbGAyUzZlGSJZY
 83lRd/lQeHZgy0J5eGBahAI82Izv8bDc+nH/KH73a3mq68CoRJ9hATDA7xc6Awnjm3XT
 HtKFXL+4MEcjhO5XFLy1AEt6LnZxsPpovLMx5F1HVqfnGJePwc6uiGh0GDt6trDH+Qj/
 HFZQkRhwNdOWrWj95yMcnKGyad6cN+wzKe6N3WFihEXBm8DIfeLogJUlTsWTzITQoaXI
 /EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JcExX3OtCcWVHs5/FKk+EsQEYLIm/8oE1VWwwDAgLXI=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=D2JkZ1OVrnzBeJM2JEoGfvEJ1zo2rXbCJxZjWUa52hzuTQqYrc7/nELayWBmzSR/nm
 BPGtBxWhYFuokdkKOJD1ukJPs/aC6SETD0ZFjpz9LAVpPq2EBLbG64o6EAc2g1qOpIVg
 gut7JCKH24wClvKzZ6jiC/W1unALSKOXuwDp5PPVOuVZqLa25E5gbny0Ibq01gSgHRCn
 DM93qBc/bZ5s8dYbaDRC3dAQ5kwJZyoteBB+MnJbzPC45Va0WQL3x2I1jaC/mW1iYNFs
 M1aotTSvAvGqLpkZSKOc9wIQG+5Wbdh4egjP4FvIolltrnU/bdftc2vCQN/ZWVQp405W
 UHpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785981561; x=1786586361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JcExX3OtCcWVHs5/FKk+EsQEYLIm/8oE1VWwwDAgLXI=;
 b=e2ecOmUxBaQhy3/tIt/scqhFGxQqE83/BJaLtWI7xryjMioueo584xwnM32bg4cDdF
 Bw2OxbC8YgWAFmljZXHHPDi6h9k3QLLHOu62p+QR6T8wlO2xpyKAiB4DXa4UsD8P7ihx
 Srb904x8uT5hCNQuDI4tRhLsiHqeOzfHP/LWoUv2PkUZp+QRIJPJ/ic6pJjV9B0dML18
 imUpmSSaYIVuCrVBfx3YK8X5Xxy7wgE/WpFsvphoHomYDViwF4m/MF4GUfkG0LStOLxU
 Ony7Il8bpHlqiBnRtZ6Y5IfPKZkQXjA+qiaip9jOnfWMU+fGrAjKKx/hP+NCYJ4wDtLC
 iYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785981561; x=1786586361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JcExX3OtCcWVHs5/FKk+EsQEYLIm/8oE1VWwwDAgLXI=;
 b=XFt5CR2Y1aFRRLR03iDYKDxuqMqb1eoMDZPPKSyuFej5Ch/eMy27DA0ehKFCg1dp4T
 T1JGKQMUr7G7UYX16n4mydiEIEoqELVMPUL5BaDcaTSz+yrpF1Wa4a/q+9Lcm3OK1/Og
 Oy1rGHgJVT8H4j5yfhj8hSd+vYt6adCl56hMwyc4fKkdUf4w2D6H/3yaiFJgMEhbf3qx
 oqj33CoV3t5ha+2/w70lGbZKTfNQq19TXvnPKStRoixXmNFylEuCQmkNjxOW3QjbojCM
 WUvJf/yKpHpBGbDE+iqrUUoenxHG7n09SW7O4bzHkMEN62zjQQkPzhSRwfY4jKdRoQiA
 chmQ==
X-Gm-Message-State: AOJu0Yw4ACfFfF7bfG7VtJKDT95cJAQSfR4o6IAfbeykIUkP9liEw8DO
 Fe3S8zS8pZj1MBXvWZE7CF+EBGuSnrbwJjae6NUK10vBode2PB8LYYKEvRppzt+oyiqIWM+lHpM
 UBK1Z/kUrSfGSgmMEaaRk4KLGdLRvshQ=
X-Gm-Gg: AR+sD13cFKcptNCEm85X9DFppVGuwu6dQrAO5a5N8zkPklg2i7M8pw8roSyf7EYdjNX
 b65MDqZs7gEb3iE7RiTxbZLhDUrjV/9Px3LK40nnarHzZjwt054bTENjQz8K7HP0CxLSwKEKHIo
 vekg0W7w+/LSHjF3gCY91UhsQk1MtV4oXqyUCbpVESOlxqj6fmZwlRYdKPWVt7irnckjH1qy7gO
 s1CCXqcNNnzA2hZTMqKNBdA5ycJyK2nUOh4IPjGyI3jUr9ClKVkQBaE4v/qy/+Rw20d0fF6fSjS
 J6lC348Z+4RP7YuOTdMvcNCObGRwPrA4cxdHzyDG4Q==
X-Received: by 2002:a05:6402:551a:b0:698:1973:1daa with SMTP id
 4fb4d7f45d1cf-6a14f14c814mr5935617a12.18.1785981560967; Wed, 05 Aug 2026
 18:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-7-zhangckid@gmail.com>
 <87a4rkplof.fsf@pond.sub.org>
 <CAK3tnv+UMEsZTR12iY74sD42m5nNhYEtyF58QxVoG-JAeUZHcw@mail.gmail.com>
 <87cxw3aah5.fsf@pond.sub.org>
 <CAK3tnv+g_m27CEj_PRUyHVsViZv74H+dtHmxw9yjEQqSVVuN-Q@mail.gmail.com>
 <87ik5r6cn5.fsf@pond.sub.org>
In-Reply-To: <87ik5r6cn5.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 6 Aug 2026 09:58:43 +0800
X-Gm-Features: AUfX_mwrxdNBBMXef-WWCMS4Td_IsVN_BY9ZA3VUhoNDMmOaNqag0knxwWrGvJc
Message-ID: <CAK3tnvKp3E3t94tbO4Jcxqq9m0TL1cwd_h333g9SzLjmqktUJA@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 06/15] monitor: Update tracking iothread users
 with holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x534.google.com
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

On Mon, Aug 3, 2026 at 12:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Fri, Jul 31, 2026, 3:23=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > On Tue, Jul 21, 2026 at 8:33=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com>
> >> wrote:
> >> >>
> >> >> Zhang Chen <zhangckid@gmail.com> writes:
> >> >>
> >> >> > Based on monitor QOM path tracking iothread users with holder.
> >> >> > Introduce the AioContext in the Monitor struct to avoid repeated =
calls to
> >> >> > iothread_get_aio_context() and ensure symmetrical ref/unref durin=
g
> >> >> > monitor lifecycle.
> >> >> >
> >> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> >>
> >> >> Why are repeated calls bad?
> >> >>
> >> >> How would symmetry be lost?
> >> >>
> >> >
> >> > OK, will add detailed comments like this in the next version:
> >> >
> >> > Avoid repeated calls: Under the holder tracking model, fetching the
> >> > AioContext increments the IOThread refcount and registers holder met=
adata.
> >> > Dynamically querying it in helper functions (e.g., suspend, BH sched=
uling)
> >> > leads to redundant refcount churn.
> >>
> >> Right here, we still have
> >>
> >>     AioContext *iothread_get_aio_context(IOThread *iothread)
> >>     {
> >>         return iothread->ctx;
> >>     }
> >>
> >> and complicating code to avoid additional calls feels dubious.
> >>
> >> PATCH 14 changes it to
> >>
> >>     AioContext *iothread_get_aio_context(IOThread *iothread,
> >>                                          const IOThreadHolder *holder)
> >>     {
> >>         /* Add IOThreadHolder to the list */
> >>         iothread_ref(iothread, holder);
> >>
> >>         return iothread->ctx;
> >>      }
> >>
> >> Are you making this change in preparation of PATCH 14?
> >>
> >
> >
> > Yes, following Stefan's earlier suggestion allows for lifecycle managem=
ent
> > to be completed with minimal disruption.
>
> The commit message is problematic, because it's written as if PATCH 14
> was already applied.  Please adjust it.  Something like "A subsequent
> patch will make repeated calls ... undesirable."  Same for symmetry.
>

OK, will update in the next version.

Thanks
Chen

> [...]
>

