Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43720CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyW5t-0001JV-Dp; Tue, 16 Sep 2025 09:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyW5o-0001Ig-58
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyW5m-0002le-44
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758030691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNH5axLRBBfc2OscUdjexc//x2LlMBFWmvb7n1xsZmQ=;
 b=Q8tadrCfsLEef5s42OBQy6S5ZcXkOXCy0oHV2LiUM5FmJ9/XdcsPoECLi41RjjYJQAZWra
 qgLy1tPdDQoNeyPnY1Dlq9RQh71+c62EYip8NMcHzAzr6Q9n/9Juic3oqDQjYGudksB6O5
 euKnbDHcbDDeaR8FkKB4D4DdomMoNHw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-WGN-p4D2OUyd0OQOwPCVJw-1; Tue, 16 Sep 2025 09:51:30 -0400
X-MC-Unique: WGN-p4D2OUyd0OQOwPCVJw-1
X-Mimecast-MFC-AGG-ID: WGN-p4D2OUyd0OQOwPCVJw_1758030689
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b793b04fe0so63616081cf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 06:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030689; x=1758635489;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNH5axLRBBfc2OscUdjexc//x2LlMBFWmvb7n1xsZmQ=;
 b=POQRT0Fx79p7o8TJhAXts9F9IzfAl8kW6kW1B+2wXfA7R0hiKXjJDQkfc2eUR7T7aR
 0nN828qc2IruyIID5j4iB9cUB8a+m5d4XF5gXkanvu92GuDOuTh530mu5tdZMbDJE1m+
 3oUF/a4A7r6AeWz4HWmZ74y5XiJYJSO59SwxgYybm9a9pW7uMCtzzo9YfEndD59ND2Uy
 euypjQJC9/9b4hwWR/t4HBi2LPYxy8yTSjvb77N+dBSF367u9dNLSTGlsFDq+djNT9cA
 DnR8xsLg6YvjJC1DA0XBTq9o8BSNlw/wTuCivzf21Ew8tTLkBoPVmeekWioeemnNSJQS
 RLcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWihcBnWGFraYF9v9VaMzW2OGCvAFQhe1T9Cwy0JQ7ehmRryHXmemAF1Xz0GCM9R9it1tPRruKI7BsM@nongnu.org
X-Gm-Message-State: AOJu0Yx0BdkHh9ezy9f9BUPpktwk8q5b1Mtj/4iJi1Jia7qjhKmANekD
 1eVO9aZKrAh83NB+ikG+PY85CYcdSmHZYaEAfCthavbeQ+X7NBJdxReHgBUUkfA0iWTt94TIClU
 dHdvKk/kp83GuwDXSvglh6l1Synl1Z0v5ns66DRgNauLp0l5fLpzQGo90
X-Gm-Gg: ASbGncsOP2KtiP97rIdb+AFV3riWxYTikdteZV7GRCPuyeXe9DoBMfPYXRZjARDRUQj
 mRzNqKSqHrjuf+0ytkY5xIE2ouqtH8dwcNYCh5UZpTA29w25IUAuh4+QAEdwvwnBNoAX8NH75G+
 lwgHJKXc2bI1WVj0VyXghNnGyS/5cV2Rrj2tXmqqCfOVDhEKOfKPeoAZkPgLSvSSGdhvbz6N2/o
 y1RpbGRGbqOUqN0xv13qUUO0AVKzdQQIf4lhfK4izLDOuDsWGbHPEs4Ptrt4Tb8EsaFxv786EZV
 eImMqAvla3aFgraI60BgO7LD4YzXA1Ou
X-Received: by 2002:a05:622a:393:b0:4b7:9c8d:1bb2 with SMTP id
 d75a77b69052e-4b79c8d1e89mr88251381cf.74.1758030689124; 
 Tue, 16 Sep 2025 06:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNGPHtHrMfWbcbR2EBlWXFWMGWUfZrTAYjjkq+hZOmtstdSB0YnN4bZ8r9EvZC9jbsBuQwbQ==
X-Received: by 2002:a05:622a:393:b0:4b7:9c8d:1bb2 with SMTP id
 d75a77b69052e-4b79c8d1e89mr88250931cf.74.1758030688298; 
 Tue, 16 Sep 2025 06:51:28 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639dad799sm85441071cf.28.2025.09.16.06.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 06:51:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 09:51:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, leiyang@redhat.com,
 marcandre.lureau@redhat.com, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 05/12] migration: qemu_file_set_blocking(): add errp
 parameter
Message-ID: <aMlrVHYxhuj1TYYL@x1.local>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-6-vsementsov@yandex-team.ru>
 <aMh0sjXkQ9IYo_SB@x1.local> <aMkfn2_GBUDlUB6O@redhat.com>
 <7f6b159e-6d97-4b0e-a825-7b8042c27e99@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f6b159e-6d97-4b0e-a825-7b8042c27e99@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 16, 2025 at 04:01:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.09.25 11:28, Daniel P. Berrangé wrote:
> > On Mon, Sep 15, 2025 at 04:18:58PM -0400, Peter Xu wrote:
> > > On Mon, Sep 15, 2025 at 10:30:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
> > > > so let's passthrough the errp.
> > > This looks all reasonable in general.
> > > 
> > > Said that, using error_abort in migration code normally are not suggested
> > > because it's too strong.
> > Note, that prior to this series, the existing qemu_socket_set_nonblock
> > method that migration is calling will assert on failure. This series
> > removes that assert and propagates it back to the callers to let them
> > decide what to do. Ideally they would gracefully handle it, but if
> > they assert that is no worse than current behaviour.
> > 
> 
> In details, prior to series:
> 
> posix + set_nonblock -> crash on failure
> 
> other variants (posix/win32 + set_block, win32 + set_nonblock) -> ignore failure

Correct, but IIUC that's for sockets only.

Major channel types that migration cares the most should also include file
now.  qio_channel_file_set_blocking() also doesn't assert but return a
failure.

> 
> > > I did check all of below should be on the incoming side which is not as
> > > severe (because killing dest qemu before switchover is normally
> > > benign). Still, can we switch all below users to error_warn (including the
> > > one below that may want to error_report_err(), IMHO a warn report is fine
> > > even for such error)?
> > IMHO ignoring a failure to change the blocking flag status is not
> > a warnnig, it is unrecoverable for the migration operation. It
> > should be possible to propagate the error in some way, but it will
> > potentially require changes across multiple migration methods to
> > handle this.

In most cases I agree.  But still, using error_abort doesn't mean to fail
migration, but to crash the VM.  We still at least doesn't want to do it on
src..

Meanwhile, this could violate things like newly introduced exit-on-error,
but I agree we used to ignore those, so even if it fails before and didn't
crash, we could have ignored those errors.. and not reportable to libvirt.

The ideal way to do is to always fail either src/dst when set blocking
failed for sure, but yes, it's slightly involved on some paths this patch
touched.

So.. I think we can go with this patch, with a sincere wish that it'll
simply almost never fail.  But then, let's mention that in the commit
message, (1) this patch only asserts on the dest qemu and only before
switchover (hence src can still fallback), never src, (2) state the facts
that it so far is a slight violation to exit-on-error, but it's extremely
unlikely to happen anyway (NOTE: this is not a programming error that
normal assertions would do, so it falls into exit-on-error category).

Thanks,

-- 
Peter Xu


