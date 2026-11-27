Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B27606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=epaEcYn9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XUcz6J0T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWw0N-0008GZ-DJ; Fri, 27 Nov 2026 08:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWw0M-0008GF-Hd
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWw0L-0006I3-20
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795786122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FL+aLgO6FYL01hlx4Sc0v95TD8aRdFO+oFtYTZzkdHk=;
 b=epaEcYn95MsamprZ9qiVRs68svRltCCef6ucY4hAqhMzw2mudUAn4/k6MtFn1O2XCh4AhH
 IldV5vNR+e9eX6wjLCMfqCORVVfBa3RhYrAj9kVKng39XK8Y6MZrW4xfaEUX2+rhoChHZR
 zg9Q4vkk9f9DwK6Yx46V7XVUKefOrj0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-at-tcX2IMtqJWpr9ioarkw-1; Fri, 27 Nov 2026 13:28:40 +0000
X-MC-Unique: at-tcX2IMtqJWpr9ioarkw-1
X-Mimecast-MFC-AGG-ID: at-tcX2IMtqJWpr9ioarkw_1795786120
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-920ff6971a1so75521406d6.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795786120; x=1796390920; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FL+aLgO6FYL01hlx4Sc0v95TD8aRdFO+oFtYTZzkdHk=;
 b=XUcz6J0TcrfBcsHhhklCNNfmyLvp7MkAb0UoPbsUNYMGPgFmQyjhDAWKqExjyU4/N6
 bNEJEmlGy8xpuO7dZ9aJBULl0XlvoXaJW5YD18Rtdat/7Eyz+CeQExNdJ2fuUtw76ui5
 X5mveLfXhTf66TK303E8bmBLz9mMAyr3TNpJ4tONjLLqIHvwVvIshVnf5buLaRfQZSvH
 WXhyR7t0PGpEqTzz1ravEwkrOjoKDDTregjMgknk9Jn3JKP7jNufSCww6J/mhPvxGiyr
 PB8T6UvVUCWoYquMggNAByboWA4GQDdHuh84WstZXulu0cmiFNdw2LwZlMElkkxiYk52
 NbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795786120; x=1796390920;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FL+aLgO6FYL01hlx4Sc0v95TD8aRdFO+oFtYTZzkdHk=;
 b=z566FxClX7HxDDpvnReGAuLFKkmb7kpZnabREp+fKYhBDBVqCWuNUCP6DAocHvuTr/
 3iF5uVskzcOuzMSTArbQds/u0ZJ/1gQ7jsp2BD26akns9pxZR/GrJWpyruePpPaZY6YZ
 wQUT6tffAgVYoVJm9dOuMITGOSuqw8/DM6LIINU2+bBla1QEMizItEanfPEp2MYi1MaA
 S6sO/i/a6tIHbMyvVEolu1jJW5W0yYCYXl16Jz1mZ0jixHh/SUztnOfiegF+0KS8AyZX
 6TogIZQQi8qbwrc0T5QiCs8tumC02wFXPx4PZpRWi1ivf4Gf5o1kJygBebmh5SPLWt+B
 +U0A==
X-Forwarded-Encrypted: i=1;
 AL+hErFQPuZHThczJH5EjkRzpYqaKX5FDTlUiD4Hmvs1GvDUo24gHbPCPWYZU1bpKM/tfbmxXaI8r8d71zcz@nongnu.org
X-Gm-Message-State: APuU4Z+I6VWAnKsfh3GFBq4kHxGn5TkVyn06hPOIkmr74iMylpwW7bYe
 1w7pzeu2JCbUZH+3Do9wqLqEQybRJKkKuDBLUOav7wC4LuhPKU9Ee7I7dfSOB1LwqaqMd+wFSSa
 x+3GBcqzX7Z/dufmkeWpm8UbP+x2BDn2VXKa50MNeT7Vt2d58fLy14oYs
X-Gm-Gg: AZFdTZdiZTiV/yoLk/XwkusKMBM4/tXvXgOVV5PVi+5DTq6ifH2BTt+DB/GZjJOD8oh
 1qmogdQOGhlq60X6tPXUFWSsAiFXrk9NH4Zgh5Co9rbY4XVd4jWBERVsZdAEidAPJS8xhv9a9rX
 LXCW9cG2N+j7xeJH/ImvrL4RJqSbDmzfl/Qiu/fx37O5fja6VX8ell0k+GChVHRU7RmfVcFO1sx
 2wvCJKXKonEg30mQA+nPKvvoNWyrwkjdMbRpdtjczbIQuJadQGTDIk4vgCqr1S2USClmhIt5o+y
 J4p92NVhENQutjNlIaDgPSmL0SWqJpC57yKXXgwAqEh2eKYkl9Jl2UdWZeyP3p8rj22+RgoSBm7
 2HO8l2SQQrLGHXGiWRzW1uiVgj3CFskk+oLoQB+D4yNja
X-Received: by 2002:a05:6214:301a:b0:921:7f88:9ae9 with SMTP id
 6a1803df08f44-9217f889d14mr143230986d6.3.1795786120151; 
 Fri, 27 Nov 2026 05:28:40 -0800 (PST)
X-Received: by 2002:a05:6214:301a:b0:921:7f88:9ae9 with SMTP id
 6a1803df08f44-9217f889d14mr143230136d6.3.1795786119544; 
 Fri, 27 Nov 2026 05:28:39 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349d2322sm219866836d6.19.2026.11.27.05.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:28:38 -0800 (PST)
Date: Fri, 27 Nov 2026 08:28:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
Message-ID: <awmFhmY655FPdXI8@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
 <8733snslnt.fsf@suse.de>
 <awiJUEoMb3WxUjPo@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87y0afqoho.fsf@suse.de>
 <awl2GemtkJBdjcXk@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v75iqw0h.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v75iqw0h.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 09:49:50AM -0300, Fabiano Rosas wrote:
> >> One of the cancel tests issues migrate_cancel(to), that puts the error
> >> in s->error and since QEMU keeps running, a subsequent migration
> >> crashes. We free the error at migrate_init() and migrate_prepare() for
> >> similar reasons I think.
> >
> > But this is migrate_incoming, which means if something got wrong, instead
> > of retrying, we should kill the qemu and re-initiate?  I don't know if we
> > could have other loopholes on this path to be invoked more than once.. as I
> > never expected it to run twice (either success and take over, or halted for
> > query error only, or killed).
> >
> 
> I think this is only about calling cancel _without_ any migration:
> 
> $ (echo "migrate_cancel"; echo "quit") | ~/qemu-system-x86_64 -S -monitor stdio -incoming defer -trace migration_cancel
> QEMU 11.1.92 monitor - type 'help' for more information
> (qemu) migrate_cancel
> migration_cancel 
> (qemu) quit
> migration_cancel
> 
> So a state check in there could be good enough.

Ouch, so it runs through even without migration? :(

If the "state check" you mentioned means failing migrate_cancel() when
!migration_is_running(), I definitely agree.

-- 
Peter Xu


