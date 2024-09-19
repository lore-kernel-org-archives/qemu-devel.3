Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D9DCF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 16:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srK8d-0007aL-19; Thu, 19 Sep 2024 12:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srK8Y-0007Zd-Pk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srK8T-0000w9-7i
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726763762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sutqMnTlTrYHh00BbhIIgIv/+Gu4NeycoH86AKbO3Cc=;
 b=JJVVaAxfHSS6HxpdcM3XY+xUhX0eP2SzzefMr7IcRskks8Vb3iCdLS78oc2KGxdBR5AVdj
 +KYLwlseMdxD36ZF3Jny8qDPc/5Wb8scD+xR/b56sJCteoG7hTjNkubacUkmCJMS9FP3Ly
 onppgj0RqG7dryohJ2xCVLsIX4665qE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-LV8psizzMGusQtkXONAUow-1; Thu, 19 Sep 2024 12:36:01 -0400
X-MC-Unique: LV8psizzMGusQtkXONAUow-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c5bd369336so15682496d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 09:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726763761; x=1727368561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sutqMnTlTrYHh00BbhIIgIv/+Gu4NeycoH86AKbO3Cc=;
 b=qMqFXrhpMJ2skWWAxDhJsfJCxMsVlgv775Bo/XBm6uoagzKP+07CabvFFWfFOgdT3C
 rqOi1RDSoP70WQ63nibbErm70Nt79evEhuwM0KrQgJNdgIxKDCF3v/cdHgYRGSL2znPC
 5bO5ZtW8n+k7hsxLgMEpsg7/h019bBnnFde0JVg4jFzbR42xPRbS5djCGKjFc994azSe
 YQQJlCL6G6kvmQnEXR8aL3iInuMbAfN5gkP15hN3MOHRpSsYCksCrmHuWCURYC9EBYyf
 fUbBXfn82yqHBVLBsgboK0ZFx13evJUty6FtE+79gsudY7ALrDpy3+r3fMkd8UWyQe4V
 daGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs1ZQ8JTITPr/GOmLa+CiZlTazAkLonE1HRJLE486/skktXeK8uvRWUtooePWGOlsCLYCHqQUfwsFT@nongnu.org
X-Gm-Message-State: AOJu0YzXNLTebz7szEo/FTcX+D4nmelMAcqlF2IDvFM/iJKfLCMAJ1iM
 D0w6V6i7vlcB87QqMVnM4Mokxmzdu/GXZrUSV/gS3fOsPFU83DCFrdpBNLbr43lQdUUGRqh8Vz4
 vvmegfD3OFcQCPjFKHQSllRQAs5o839sSBGE7gdH/FDan32RuQ5uG
X-Received: by 2002:a05:6214:2c01:b0:6c3:6d23:4ee8 with SMTP id
 6a1803df08f44-6c573556147mr374632806d6.28.1726763761119; 
 Thu, 19 Sep 2024 09:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4FfhAgsbdf8FytXT+h/5UPWbpxmxvMaBSjINUZayHh30q8y8rqPQehS9CjQHdKQKiSu/fmg==
X-Received: by 2002:a05:6214:2c01:b0:6c3:6d23:4ee8 with SMTP id
 6a1803df08f44-6c573556147mr374632556d6.28.1726763760766; 
 Thu, 19 Sep 2024 09:36:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e557e77sm9025626d6.85.2024.09.19.09.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:36:00 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:35:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PULL v2 0/6] Migration 20240917 patches
Message-ID: <ZuxS7fQN_rajluic@x1n>
References: <20240918183151.6413-1-peterx@redhat.com>
 <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
 <ZuwSGJODsyj_bA4P@x1n>
 <CAFEAcA_9HKtTciFtrs9T9PG06GgYdoDoCASeBi7wO9CswA=1tw@mail.gmail.com>
 <87r09feo2f.fsf@suse.de> <ZuxRd1vu3PXT_VpK@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuxRd1vu3PXT_VpK@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 19, 2024 at 12:29:43PM -0400, Peter Xu wrote:
> > > CID 1527402: In migrate_fd_cleanup() Coverity thinks there's
> > > a race because we read s->to_dst_file in the "if (s->to_dst_file)"
> > > check without holding the qemu_file_lock. This might be a
> > > false-positive because the race Coverity identifies happens
> > > if two threads both call migrate_fd_cleanup() at the same
> > > time, which is probably not permitted. (But OTOH taking a
> > > mutex gets you for free any necessary memory barriers...)
> > 
> > Yes, we shouldn't rely on mental gymnastics to prove that there's no
> > concurrent access.
> > 
> > @peterx, that RH bug you showed me could very well be caused by this
> > race, except that I don't see how fd_cleanup could race with
> > itself. Just having the lock would probably save us time even thinking
> > about it.
> 
> I can send a patch for this one.

Oh btw I think that may not be the same issue.. I did observe one memory
order issue only happens on aarch64 when looking at that bug, and I _feel_
like there can be more.

Bandan (after his long PTO) from our team will keep looking.  Since that
can relatively constantly reproduce (IIRC..), we do have chance to figure
it out, sooner or later.

-- 
Peter Xu


