Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2B8C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYuuK-0004Je-Ru; Tue, 30 Jul 2024 18:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYuuG-0004Iz-Uq
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYuuE-0003eJ-GV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722376876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=asQxELLFt9tKL5trJpyTUQDKkk4gC3FqwHZ9MJ1di/8=;
 b=T+sowu4HhFGCUZoiUF3QNJO+kKPCPX3jpYQjxQ5Xf/1RNErlM8kOyw/+eCycUDTZhxH1w6
 lNBZfAvIt4o2h6SNgcEYuxWdHZUy3+0ehFTbKteoRngtsOryXMpuWQKWW/wbqhC3C+z1Fe
 tDKjrw8vnIDodJjfFKAWlpufZ+nfVik=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-BzwW7i89PliPSVPUil_Ruw-1; Tue, 30 Jul 2024 18:01:15 -0400
X-MC-Unique: BzwW7i89PliPSVPUil_Ruw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b798c6b850so6235496d6.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722376874; x=1722981674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asQxELLFt9tKL5trJpyTUQDKkk4gC3FqwHZ9MJ1di/8=;
 b=jqshQzcGiyLLS+hZhFH7y0sO5lRwLmAUgeG2vbnx0arrsEmpRI9lvBcDd9aC2Mz6jJ
 Dmq0GfQN83+34T03qVvUJxH/FvI37658eN0kRIAv16tqCPlk3DftItV66DoFTyGAQiaI
 7KgWOLQdIwMNm1ljWY0+m5Sv2k7JaF0pbjkLREOX+PbKP/U/dLyuKw0Ql40PEvm/x6O7
 +fCd9Y53RNMzZ6hTDLNNVNXydfXVM+tY7eq+Y/sZLoITt6PTS0TtxgEmq9vmc0bSfGQC
 aG7LVzpGw+3kgXf+6kXlRrnp5JIAcVXz/5ZDKZmWqavYXl2MsuEEm/y323p8rHL05EIT
 kcOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVll+i2Twp3Y0GuiDC9JSC+DTPkr2ZPjylYVRerSDxUHgff2e34GH9w6UjA1Y7u1Ydj41z+kdu3mTfRrzJdE1Q9AA3mQ9w=
X-Gm-Message-State: AOJu0YyvUbHNSn3iqK+FkaVTjRxxSLUFwiO0RFQy4AcqWK4OoqbJ8961
 reFmWZJJPaQlwynzBRBWzZyCisMO5dX2ZmwCDLJgPNgyN5dbls1PVjgktS3iH0qUd6waEh06jtP
 mBfldVS0sblN6AnpGgOhsvFQBW6BzDR5QRu7kWVcRd7WsIBLvDWtq
X-Received: by 2002:ad4:5d6e:0:b0:6b7:586c:2cf9 with SMTP id
 6a1803df08f44-6bb3e37aa7bmr144649076d6.8.1722376874198; 
 Tue, 30 Jul 2024 15:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzZQxewD+1UKMk3PY+O2ZzKv8XF+lwfovcikFECt73gAUS0ed090OnquERZvRXqoH9WVPubg==
X-Received: by 2002:ad4:5d6e:0:b0:6b7:586c:2cf9 with SMTP id
 6a1803df08f44-6bb3e37aa7bmr144648866d6.8.1722376873768; 
 Tue, 30 Jul 2024 15:01:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb79c4f3dbsm9792776d6.30.2024.07.30.15.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 15:01:13 -0700 (PDT)
Date: Tue, 30 Jul 2024 18:01:10 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqlipqJBwZVzFSx0@x1n>
References: <ZqQLbGxEW3XT7qL-@x1n> <Zqe8C9AfaojKHM8A@redhat.com>
 <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730172148-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 05:32:48PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
> > On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
> > > This is not what we did historically. Why should we start now?
> > 
> > It's a matter of whether we still want migration to randomly fail, like
> > what this patch does.
> > 
> > Or any better suggestions?  I'm definitely open to that.
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> 
> Randomly is an overstatement. You need to switch between kernels
> where this feature differs. We did it with a ton of features
> in the past, donnu why we single out USO now.

Right, my previous comment should apply to all such features, so it's not
sololy about USO*.

For old features that Jason mentioned that can also be auto-OFF, my wild
guess was that most of them should be supported in most of the kernels that
people are using, so they're fine.  Otherwise I don't see what stops it
from happening in other features too.  And that's also why I am thinking
maybe we don't need to fix old features, but for this USO* one - I'm not
sure yet; it could hit already.

For the future, I definitely want to avoid such issue; that's also one
major reason / goal I wanted to discuss this thoroughly this time..

> 
> Basically downstreams just don't separately add kernel features vs
> qemu features. There's little reason for them to do so.

But we hit this bug in downstream tests..  IIUC it means this is not the
case?

To be explicit, for RHEL9 some version we added USO* features for QEMU, but
not yet for the kernel TAP drivers.  AFAIU that's the context where we
trapped this failure where we have some system supporting the QEMU feature
but not supporting the kernel ones.  While some newer systems will support
both.  Then we hit this when migrating back to the RHEL9 system.

Thanks,

-- 
Peter Xu


