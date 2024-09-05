Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FA6CD5BD6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFH0-0000t1-So; Thu, 05 Sep 2024 12:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smFGy-0000sA-Nh
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smFGx-0007px-4V
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725553428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TORdoPka1ZnRakrMoezien+psJJ0ugjPuE7EmxeirD8=;
 b=P7sG5c485vpB0K9+XsWEfmxgs5dGZgnOi9HfioDzuLDf/zonu7fHH6K7XjGiYpyPml3Ccq
 xMJDvspRzP0XWeRgCH3GjeTI5BbYqHYDVVrk2CPazoPra8I2JTP6UyY2vA+RcnSvYPNri3
 7kj26P3QHOkt3I42po+oxfvxHepx2KI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-whYcj-9vNh29S0xvye4E7w-1; Thu, 05 Sep 2024 12:23:47 -0400
X-MC-Unique: whYcj-9vNh29S0xvye4E7w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a81b8a55b0so169922885a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725553426; x=1726158226;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TORdoPka1ZnRakrMoezien+psJJ0ugjPuE7EmxeirD8=;
 b=jNI1MBEmV9w/8beqNAcAr2tvbrHrQ4kavaJhXPh+vwPFfefPhbQvzl8BU9qwf+bZsD
 hpTTLxhnB4OkxWy9g40NDSZOzvFQu+5v8wI/AUdf0O3zeyX8OljPetANB4hyzYyRxxid
 O5bqm9tSnDjoEuW4W6zwzQr8/ADBmUtTSiMLECubWwFF//wyKpiBg4lQi1JUdfyREG3N
 ofm8NkZVHj9CRlKuyZZzMoPtXIAUWdUWUbZ6VInziTzXghUxmuRGE7ZhWNB4UW1nNo1B
 j2SWEI4L/zS75EvqBBm6vemPz6MV40na5rSro1/TclcmJ8KTPKlqJjPq1gT/PPlooZhK
 85wQ==
X-Gm-Message-State: AOJu0Yw18fr6MhWit9K/EI7ixUDyn1DE49o8miuHEBTgQc5w+/3bdjeI
 F9L8wLWSZTKTOCYM00eengcfYGS3WEExj+mZtOdujIFjf147OEMOXOamknVtTYNV4XFvlUZS77f
 Lcifp3mR4zuz9XVNPDMkx6Z2q3lxiQX3m4o6bt5fInXVV44dJRdcb
X-Received: by 2002:a05:620a:4015:b0:7a2:e6c:422b with SMTP id
 af79cd13be357-7a8f6bab170mr1923666085a.24.1725553426561; 
 Thu, 05 Sep 2024 09:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ8l6Iv/6Gey6MIZ0f8JbfmaMsj7eW24vAe34e6wgKjJGTtrypoVDiRH5dkRwXhaWxXup/LQ==
X-Received: by 2002:a05:620a:4015:b0:7a2:e6c:422b with SMTP id
 af79cd13be357-7a8f6bab170mr1923662285a.24.1725553426114; 
 Thu, 05 Sep 2024 09:23:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98f00fe15sm87230585a.108.2024.09.05.09.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 09:23:45 -0700 (PDT)
Date: Thu, 5 Sep 2024 12:23:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
Message-ID: <ZtnbD69EeXhR6FFc@x1n>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
 <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
 <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 05, 2024 at 07:07:28PM +0300, Avihai Horon wrote:
> > So I wonder why stop-size can change from a driver, and whether that can be
> > reported in a more predictable fashion.  Otherwise I see little point in
> > providing both stop-size and precopy-size, otherwise we'll always add them
> > up into VFIO's total pending-size.  The line on provision which data falls
> > into which bucket doesn't seem to be clear to me.
> 
> Stopcopy-size is reported by VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl, which
> states that this is "[...] the estimated data length that will be required
> to complete stop copy".
> So by this definition, stopcopy-size can change during precopy (it can also
> change if device resources are created or destroyed).
> 
> Precopy-size is reported by VFIO_MIG_GET_PRECOPY_INFO ioctl, which states
> that this is "[...] estimates of data available from the device during the
> PRE_COPY states".
> 
> Maybe the confusion was caused by this line in vfio_state_pending_exact():
>     *must_precopy += migration->precopy_init_size +
> migration->precopy_dirty_size;
> 
> Which I think should be removed, as stopcopy-size should already cover
> precopy data.

Would you please help double check on the kernel drivers' side?  If that's
true I agree that should be dropped.

Does it also mean then that the currently reported stop-size - precopy-size
will be very close to the constant non-iterable data size?  If so, is it
cache-able?  It doesn't need to be 100% accurate as the ioctls are not
atomic, but still if it's mostly usable (again, will need you all to help
justify that..) as that then it looks like we have some way to report that
without the concern you raised before.

Thanks,

-- 
Peter Xu


