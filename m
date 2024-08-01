Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26025C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZT0g-0005RN-HJ; Thu, 01 Aug 2024 06:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT0e-0005Ed-Vk
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT0d-00080w-67
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722507969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+xdwoYH/ax7vQ/V8wiL8K/KTdmTO9Qxp/6uMUaYUBQ=;
 b=RWG0Sj/fXlRRNYz5I+6dTNCNw2e64kKf+J/g/10wDTf05nTGdOkH3oNcZuNJUMteDJdcKQ
 Roqsdysz2LPWqDWtR8NW4Nn5o3jHrTpxzKF9Ta8HvO3x1k2xQT9FnV5G5cX6NbgyVeDAV9
 3snQwc8CngWJKh8uzuYEzBUPs4C3/0o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-jlKUR5PQN1aMIHn5xhnaIA-1; Thu, 01 Aug 2024 06:26:07 -0400
X-MC-Unique: jlKUR5PQN1aMIHn5xhnaIA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7ab644746eso592417566b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722507966; x=1723112766;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1+xdwoYH/ax7vQ/V8wiL8K/KTdmTO9Qxp/6uMUaYUBQ=;
 b=nIwsyj8Yqu6UjrgAXL0mZ/ZqABA0bUFoKY0eqQOErQqF1Cgbgrl7ZREQIy+2Nrsxwi
 19n4S8BH5UVxde1b/5bzV3JZxZ5DPYExOliBqHxhAW4Z6hQpRkCf+Nag/9e+J8km3bNW
 VI2mxhNfyrXup5b3a0+5p5HWYbyOF6dGoce7QFsLEQtdlR5OptwehOAdXr5V5XWT9n7t
 wdp1hSfJMLXYbqeCPv8y1B9xEc3WCg96p1OUucF5jjUXCbZ9KlYoqPHZFMEqmQg2MYOh
 xaQLhAHuvh8rEZx8zAXAKNGRWcAEt8YstqJuQQiTxUApF79okWd9r3nfEuhNFZ9ipO0p
 621A==
X-Gm-Message-State: AOJu0YwiIVm5j5+mq7B4LDsYfcLFYnBiBLKLzr77UWB1xFK0lfUk2SCp
 883MrM+DIfiwAEBwoHJxXlSMFBLb64o67a1dfunPPIUWmmUEBrTlQw5aXwxP/yAuNaTCaPXRQZa
 hOvH8qvN0TJYYEKVGAuJN337XRlsHjDPJo7yirwhyLmgHH9eMRFbiMKAPDGM7
X-Received: by 2002:a17:907:8688:b0:a77:db34:42ca with SMTP id
 a640c23a62f3a-a7daf77b539mr133791666b.49.1722507966431; 
 Thu, 01 Aug 2024 03:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrGkbGt7lK1WMQrMEUvJlo6lUCaY64GKE1+KLvMWryhKv+qiHBSHVkuZlj+SYC2BXfZHyPJQ==
X-Received: by 2002:a17:907:8688:b0:a77:db34:42ca with SMTP id
 a640c23a62f3a-a7daf77b539mr133788766b.49.1722507965724; 
 Thu, 01 Aug 2024 03:26:05 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4119bsm872218166b.115.2024.08.01.03.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:26:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:26:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240801062459-mutt-send-email-mst@kernel.org>
References: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
 <20240720145819-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.0ff73b39.722e.4462.b426.f477adef04f2@feishu.cn>
 <20240801042507-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.cce6af4a.43f3.41da.bd6c.5fdb96e92401@feishu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.cce6af4a.43f3.41da.bd6c.5fdb96e92401@feishu.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Thu, Aug 01, 2024 at 05:48:36PM +0800, BillXiang wrote:
> 
> > From: "Michael S. Tsirkin"<mst@redhat.com>
> > Date:  Thu, Aug 1, 2024, 16:26
> > Subject:  Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE
> > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > Cc: <qemu-devel@nongnu.org>
> > On Sun, Jul 21, 2024 at 11:20:56AM +0800, BillXiang wrote:
> > > 
> > > > From: "Michael S. Tsirkin"<mst@redhat.com>
> > > > Date:  Sun, Jul 21, 2024, 03:01
> > > > Subject:  Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE
> > > > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > > > Cc: <qemu-devel@nongnu.org>
> > > > typos in subject do not inspire confidence.
> > > 
> > > Sorry
> > > 
> > > > 
> > > > On Thu, Jul 18, 2024 at 04:31:03PM +0800, BillXiang wrote:
> > > > > From: BillXiang <xiangwencheng@dayudpu.com>
> > > > > 
> > > > > We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request
> > > > > in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02559.html
> > > > 
> > > > Pls put commit here not ML link:
> > > > commit ABCDEFGHIKLM ("subject")
> > > > 
> > > > > and will send this message only for vq 0.
> > > > 
> > > > you mean "should send"?
> > > > 
> > > 
> > > What I mean is the commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
> > > will cause VHOST_USER_SET_LOG_BASE to be sent only when 'vq_index == 0' in vhost_user_write, 
> > > so that we can not use vhost_user_read to get reply when 'vq_index != 0'
> > 
> > 
> > do we try to do it now? in which configurations?
> > 
> 
> Sorry, I'm not certain about what you're instructing me to do.


I am asking that commit log is structured like this:

currently, abc happens, as a result, def happens
do hij, such that klm instead



> Maybe I should merge this patch whit commit 7c211eb078c4
> ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
>  and "[PATCH] vhsot-user: Remove redundant judgment" into one patch.
> 
> All of these three patches are aimed to do the same thing as 
> commit c98ac64cfb53 ("vhost-user: send set log base message only once")
> which is not a good solution because there is already a function vhost_user_per_device_request
> for those messages that should be sent only once per device.
> 
> In commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
> I added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request so that it will be sent only once 
> per device when 'vq_index == 0'.
> After that we should remove the check add by commit c98ac64cfb53 ("vhost-user: send set log base message only once")
> in "[PATCH] vhsot-user: Remove redundant judgment".
> And last, in current patch "vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE"
> we should only read reply when 'vq_index == 0'.
> 
> > 
> > > > 
> > > > > 
> > > > > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > > > > ---
> > > > > V1[1] -> V2:
> > > > >  - Refrain from appending flags to messages that could 
> > > > > precipitate validation failures upon execution of the 
> > > > > `vhost_user_read_header` function. 
> > > > > 
> > > > > [1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg01923.html
> > > > > ---
> > > > >  hw/virtio/vhost-user.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > index 00561daa06..fd12992d15 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
> > > > >          return ret;
> > > > >      }
> > > > >  
> > > > > -    if (shmfd) {
> > > > > +    if (shmfd && (dev->vq_index == 0)) {
> > > > 
> > > > extra () not needed here.
> > > > 
> > > > >          msg.hdr.size = 0;
> > > > >          ret = vhost_user_read(dev, &msg);
> > > > >          if (ret < 0) {
> > > > > -- 
> > > > > 2.30.0


