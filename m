Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642BE106ACE2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lf4-0000Ko-BR; Thu, 12 Mar 2026 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0lex-0000Ka-Rj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0les-00059P-Be
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773343520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bU9xLHAywFGn4GyxV/Qhqyy+Qm0eKB3M3cKVNASMchA=;
 b=KVLGmEXZD+4e9UJ2jUIlONUn4w/qjgGfveCgz8XdRZWNQdoKXKLgrisY1T+/y+OXu9oect
 Ap7gD5pIL5Q2hF6zgyH8C+F26EDPFwa1y1oBefpupAJuJaf4pafvwtQ4EZ9N/yMsWjmJdz
 goJ3DmGjAeCuSLdY/qkhxWsNl5P11KE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-QWO6dKg6NW-1I4Pk-lJvdA-1; Thu, 12 Mar 2026 15:25:18 -0400
X-MC-Unique: QWO6dKg6NW-1I4Pk-lJvdA-1
X-Mimecast-MFC-AGG-ID: QWO6dKg6NW-1I4Pk-lJvdA_1773343518
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5093b19111fso9336721cf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773343518; x=1773948318; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bU9xLHAywFGn4GyxV/Qhqyy+Qm0eKB3M3cKVNASMchA=;
 b=OkhCzT7Jx/Ja1jSuTD1CEvHUuMxZstF+ZHnx6aajk2Uq+qdiRoe+TZ+IoAEs4dMGoK
 41t0GyppOLqkeFcCXDfXGM3s1iLVZ216F3Yi4/FFm+nnsCP5FWRkQ+1LtiLoJklp1See
 P70ZbspVm3VGawhkkqF8gfx7WlmuSre2VnRrfze6fELFlTVQ+xcwIZsM4/5JBmulCTdd
 6YC2fhSkKujUNss/5pOI7bricXt7HzT2/nxNy+NuCHh0kOz4+oeh/HXpNbRz//awDrU2
 anLMnm4XYU+jctIT7+JLcy/7qGNOOS4XN47cAKKt3+Sbc4+Q2O5CdCabwJRcJAp15gKq
 i7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343518; x=1773948318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bU9xLHAywFGn4GyxV/Qhqyy+Qm0eKB3M3cKVNASMchA=;
 b=G9tX7elVEDwxG16eBn4fY2iNT6EdYs0OvrFv0GY807pZ/pl+nHFCQyz7d80UbNm/L4
 lk9VpEsgZ9Y2nw8CmGiCNop1ZGGs0wohdShyGY/f4VqM5CsFQpa8du+VzUgcrjaCYl5f
 P+xeaEBIZgW56EQFKJ8HE736XfhZ4em8V8D97KE5xJnqKgw/C3I2UtU8NACDlA9IUqFz
 TAuCXQgdckP92rERJPHVRpXN3J/NRrRSl2YiKZ+ReA+UwRW+9opyWrfFeDuekZ2r+3W1
 GwXtBXHkpz57c1o1ZyMvFLET/i0JtoxYys1SrNEd1jZR4NDhz0mY81L/qtznh2fcdoia
 CObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGEY80NKDgtne5td1ueZYDvRMdpUh0WqTO9JNBGdzj+PwQVel8yciH1W4jgL2e6S1vjYlrzMVS7OuQ@nongnu.org
X-Gm-Message-State: AOJu0Yx050CX1m95xGEIAMb7Wj+Lo8wyLl5XAVPaoctBVed9lPHCGNEj
 2Z5z7v96bq14LAJQUZ9ttHwXGclbINIiiBAuq04HQuSuBkZKonsIgvdjbOeKULExdOxp1KMUoFZ
 Sgn1Wa/diyLGxbP/DFW3v1Xryvu/pVdJO0N7cJzTfHQbT3WyldnqDNGuw
X-Gm-Gg: ATEYQzxCBybJN/IxG1nenin1FmHHOKYSN1tZ95DZZso2XokWBKIej8P5EZ6IZQXzUE7
 tMe692MRxgothEnc1TFbyTO7ZnyeiMP7IsVqSuJ9SLARD1zv88kkuaODJvNelKtsR/x9Pomf25M
 bisBInf7nhpsyBmkgPhU7AD7cNjYNf7rH0TC685WgpXv6g+qzmjPsiPvnNvYvWodd5Jn/HJkt5n
 ++1BzEUpWblcL08dd51AY7PfPQRHvmhAzCAmRNANYrg+wqi1vDhPMlrrfKjA7hzr15Fs5U0bzhc
 LUjPv9igbR/SRZ7s0aMaGmq6X9sfZvGwmeuRhg2Cf8sASo3i+Tf5AcjPma3RVXZDg5lBhMiJ5mp
 a5nqPBF84VL8frg==
X-Received: by 2002:ac8:7d89:0:b0:506:1edb:2cf8 with SMTP id
 d75a77b69052e-50957d5482bmr9467051cf.8.1773343518007; 
 Thu, 12 Mar 2026 12:25:18 -0700 (PDT)
X-Received: by 2002:ac8:7d89:0:b0:506:1edb:2cf8 with SMTP id
 d75a77b69052e-50957d5482bmr9466761cf.8.1773343517551; 
 Thu, 12 Mar 2026 12:25:17 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939e8e4cfsm39133051cf.7.2026.03.12.12.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 12:25:17 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:25:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
Message-ID: <abMTG0fXgZuoWrJB@x1.local>
References: <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
 <abGEwf-AG1rZ3kam@x1.local>
 <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
 <abLc_ppEEbKjNRUi@x1.local>
 <022c929e-ddda-4f74-8786-d01994107415@yandex-team.ru>
 <abMCMrRxdAWCc_hv@x1.local>
 <CAFEAcA-LEuiqbqL=DBVrPV6FJVGfVRoDE+1VH090g-aTV46Uxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-LEuiqbqL=DBVrPV6FJVGfVRoDE+1VH090g-aTV46Uxg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 06:27:05PM +0000, Peter Maydell wrote:
> On Thu, 12 Mar 2026 at 18:13, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 07:34:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Hmm. Probably, that this is the subsection, that exist only in our downstream.
> > > I don't know, was it mentioned clearly before, sorry if not.
> >
> > Ah.. Looks like it was not mentioned in the latest version posted:
> >
> > https://lore.kernel.org/all/20260312102626.891359-1-dtalexundeer@yandex-team.ru/
> >
> > Let's always mention this, because it's important piece of info, e.g. to
> > know upstream has yet no reproducer.
> >
> > > This subsection just not exist in master, and we are not going to upstream it.
> > > So, for upstream it's a "theoretical" bug in a protocol, which may be triggered in
> > > some future moment. And that's why there is not specific case in commit message
> > > but only assumption "Let's say there is a vmstate ...".
> >
> > In this case, for upstream we almost only lose but yet unknown gain with
> > this fix then, because we stop throwing useful info for unknown new
> > subsections, as PeterM pointed out:
> >
> > https://lore.kernel.org/all/CAFEAcA_mzXDdz_xjPnZ9Kc4K01Aoss_OH_qEoL3G33KdsnHrLw@mail.gmail.com/
> >
> > But I agree it is a potential issue, if we cannot justify QEMU can never
> > hit it.
> >
> > Sending "how many subsections are there" is one viable option as you said,
> > but it only solves this small problem, and knowing that number requires src
> > QEMU looping over the subsections twice so a bit awkward (first time we
> > need to kickoff ".needed()" hooks to do the counting; not all will be sent).
> >
> > The other way is to provide level information somehow in the stream.
> >
> > Say, we could attach START/END markers for each VMSD to be dumped.  That
> > may be able to help in other cases too, e.g. when we accidentally grow some
> > VMSD fields breaking migration, then IIUC dest QEMU can provide a more
> > accurate error message when it knows the bound of current VMSD that is
> > being loaded.
> 
> Could we perhaps do something like:
>  * mark up the vmstate sections we have that don't follow the
>    "/ is the separator" naming rule with some new struct field
>    that says "legacy_bad_subsection_name = true" or whatever
>    (or rename them if there are cases where we're OK with a
>    migration break, like "iotkit-secctl")
>  * have the migration code enforce the "subsection name follows the
>    / separator rule" via an assert when the vmstate is registered,
>    with a loosening for the ones marked as legacy names
>  * have the inbound migration code use the strong check on the
>    separator to distinguish "subsection" from "not subsection"
>    unless the vmstate it's doing inbound migration for is marked
>    as needing legacy name handling
> ?
> 
> I think that would keep migration compatibility, avoid the problem
> of wrong subsection names creeping in in future, and in practice
> mean we don't in future hit this issue upstream. (With more effort
> it might be also possible to tie the legacy names to QEMU versioned
> machines so that they can eventually be retired.)

Yes this is an option.  This will cause a few other things to maintain for
us, though..

- legacy_bad_subsection_name itself

- two different paths of parsing subsections

- if we want to get rid of this (i think we should..), we need the machine
  compat property for legacy_bad_subsection_name to get rid of it after 6
  years

We'd better also make sure we don't miss something when choosing the new
legacy_bad_subsection_name candidates, or it'll start to fail migrations
with a more strict check.

That so far just sounds slightly more work and less benefit comparing to
introducing START/END markers for VMSDs to me.  With START/END markers for
each VMSD (or something like it), we can actually drop the requirement on
"sub-vmsd names to contain parents' vmsd names", because we have the level
info, then it's clear which subsection belongs to which parent vmsd.

I wished we have that already; we almost have it (QEMU_VM_SECTION_FULL,
QEMU_VM_SECTION_FOOTER, etc.) we're very close except it's just that it
only works for a whole section hence only top VMSD, rather than every one
of them..

Thanks,

-- 
Peter Xu


