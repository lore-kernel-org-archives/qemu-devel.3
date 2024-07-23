Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E65C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJgz-0006CR-UT; Tue, 23 Jul 2024 13:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWJgx-0006Au-1W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWJgv-0006nB-3h
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721757166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+MQm6RCdLzyFPlFIR1UQlGYM+zbQquylpuCMJ1SDvkM=;
 b=Be+2fbC0Gl8M4VFyA/xhdz2IdAgDKd12XIDeN4Y0p3X31ngQSHJtWwfy8fY1qoyP44L8Op
 Sh0Na6715kvFBVAPLpzIZVHw52SuVWPXUcOAhV7lu4Ya8s8uUsqDZ0omTisjBB/JiXECzw
 P89RsgbAPlta5FsC+iEpio693z2eYYM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-ifCqU4gyN8u8acHO2fSY7w-1; Tue, 23 Jul 2024 13:52:43 -0400
X-MC-Unique: ifCqU4gyN8u8acHO2fSY7w-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d9404e1d54so683549b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721757162; x=1722361962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MQm6RCdLzyFPlFIR1UQlGYM+zbQquylpuCMJ1SDvkM=;
 b=TnP5FXJP1ap/eyqjlDrO7NCcYP1hgnj1PhsoE4x3VzENWOVIIsPEbc09qI7ohzfUGY
 yibSm7FXmQs75PQ8xqgAabBH0bECjdAFPPOS5lCbLbxtXK0/8fOuQR5Kxkc1FxuJoGKt
 ZN9Jh1kphFVp56XU+jlyjH5Oh/AA7EK4Jzr78JJWz9nvsTLpReKemDDK88SmPFEw3sx4
 Rff8ey12cC5PcHdpR145i2cPVSnGzg0nZb9H+Y79F8zTNePBPnkEh7Ad/tTeoh+Fm9M7
 51arwgl+piRHHcbvUArN9vw9Q7l5/fxwxiCZRwMVdXyCdfd/KWKVMDZFCHeySa4kuGfX
 ++LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCEDYlnMT+ZxXLa9zisPne0LD6nJK3OnE2bL98O/KaH3JLCyqfP18DQkpSrtrd2VyvqymcoEOX4L9RxsxD6DFBZNuKpoY=
X-Gm-Message-State: AOJu0Yxq1uZPM8QhXHF5mYiDeb0VXPTulyehmB6a/FHzKxAZ58afFcev
 j/J9JcuTBvgqkOFLMnJsx9ELqEFpwmrOG/s5mBNfLiMjcSGYJwIoXOX7zlHcsl8CGxHUhzWk+zj
 qvnSiJU1j2dixq6ZdpDSYjvtE+58MDi+Rct8M9mtrbY/23uj91nk1
X-Received: by 2002:a05:6870:63a6:b0:261:934:873d with SMTP id
 586e51a60fabf-261215c9bc0mr6277173fac.5.1721757161969; 
 Tue, 23 Jul 2024 10:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMukVJXd5GO1OKra1uY5F6KWWl4ewn4iSIZcIWflk/BKmn54pg8FN+/yhFcZOMSr+125ZDBw==
X-Received: by 2002:a05:6870:63a6:b0:261:934:873d with SMTP id
 586e51a60fabf-261215c9bc0mr6277157fac.5.1721757161501; 
 Tue, 23 Jul 2024 10:52:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19905a8f3sm500292685a.80.2024.07.23.10.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 10:52:39 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:52:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <Zp_t5bCHP9NRuFua@x1n>
References: <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n>
 <20240717045335-mutt-send-email-mst@kernel.org>
 <ZpfIDUwS9vawpzT5@x1n>
 <20240717093911-mutt-send-email-mst@kernel.org>
 <ZpfLZbiJ3cn6fEba@x1n>
 <20240720154116-mutt-send-email-mst@kernel.org>
 <CAE8KmOwv-NiXwmeCAjFNu=R67D2GcNLffV8NedfMBXhY9ODh8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwv-NiXwmeCAjFNu=R67D2GcNLffV8NedfMBXhY9ODh8w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 23, 2024 at 10:33:58AM +0530, Prasad Pandit wrote:
> On Sun, 21 Jul 2024 at 01:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> > > > > > I just want to understand how we managed to have two threads
> > > > > > talking in parallel. BQL is normally enough, which path
> > > > > > manages to invoke vhost-user with BQL not taken?
> > > > > > Just check BQL taken on each vhost user invocation and
> > > > > > you will figure it out.
> > > > >
> > > > OK, so postcopy_ram_ things run without the BQL?
> > >
> > > There are a lot of postcopy_ram_* functions, I didn't check all of them but
> > > I think it's true in this case.  Thanks.
> > >
> > So pls document this in the commit log.
> 
> * ie. IIUC, if we take BQL in postcop_ram_* functions, we don't need
> this 'vhost_user_request_reply_lock patch'? I'll check the
> postcopy_ram_* functions to see what's happening there.

Go ahead, Prasad.  But just to mention postcopy stuff doesn't take BQL may
be because there's some good reason. So if you're not confident on some
changes, you can share a patch before testing in an involved environment.

Personally, I'd avoid using BQL as long as it can be replaced by a finer
grained lock.  Otherwise the lock semantics can be more unclear, and we'll
never get rid of BQL.  IOW, I'd prefer a smaller lock in general if
possible to avoid BQL, but we can see how the patch look like when it's
ready.

Thanks,

-- 
Peter Xu


