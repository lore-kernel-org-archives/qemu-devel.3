Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D248C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4tp-0002zH-Tf; Wed, 17 Jul 2024 09:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU4tQ-0002DC-Ts
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU4tG-0007hd-VP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721223614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CzZAVSpZPQcFIvxweomh2gEZAR3iEyJ7BXFBbs1oiIQ=;
 b=e6TjO2L8dB1UhpW2KbDepSKFRG7Ij7gxhyTA1Cv8HYUDS1Thcy06lmVBAgJQHt5awlNDt0
 PkML1Oa++HVpbz0VenmFAEAyzjYYA4+Jy+rUfxPKSWv9e/VPkWk30oFZwxtemNCIBjDA3G
 ZiJqx0y3MB+Q1Bo1D0Ll7lzPlF5U9D0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-2e_BvJisMiudvHSbCafmwg-1; Wed, 17 Jul 2024 09:40:12 -0400
X-MC-Unique: 2e_BvJisMiudvHSbCafmwg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4279c75c44dso44117265e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223610; x=1721828410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzZAVSpZPQcFIvxweomh2gEZAR3iEyJ7BXFBbs1oiIQ=;
 b=UtJjs76bepFOZ98FplInTGrEpwq27o0m8IcfXeWOsDzsZUEy1w9UyJYcQVipcstQka
 mzYP4+lhaDRLzT6SL0HEi2TjL6E2mBnPwLbSqkZkHpTxzFir9KAz2XNvgxQAmwLMXSqS
 nOGIkuQyjKD+qwo13rMIXJKbkrPORNeDlKmuirfZkBepJJpKqctCarbQzjG92y5eTYJW
 jZTk6rfSM5mtTTyKHJzsPbyBRYiu/BuDTZbPfmpWCacPIGuCzox0nRSSI6RtTzemsnLV
 IyOCqI4Wk4zWHcpbvE+eXuNUoj6Zu03Ml5m+KMS88/fyFyROK6/4szDmqLDsqx8TWIfN
 ukKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/5ekmRzQCnC2Ph9VfV28JnzL96/iC1owmiBwzAfW+HPSrW7iFB5Gord63EkgpJsMVv5VHvFZjbGFTX6hPxXpvd2B+zEk=
X-Gm-Message-State: AOJu0YzxX1TCm3LkUijZsYIahOgipEo+TS7Kg+gkxTVpN65xdZfQSAtX
 NZlfZPpx1MskxMasyYbfE4Dd74xjG14XJjGMFSm1ww+PvRiVz5CQHDsMd8QlQCKv0NX1hSAWXq4
 hi9iHkbXLaD75JNbuPZyB6aZXlgXtSpTii+rKKeqs56WQW0rotAA3
X-Received: by 2002:a7b:c451:0:b0:426:63b4:73b0 with SMTP id
 5b1f17b1804b1-427c2cff435mr12977805e9.34.1721223610718; 
 Wed, 17 Jul 2024 06:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLXATnoN705YurMt3X8E1LNazLqoK2EKs7hAjBKGsJpr31inWc/GQibwJgsMQn1tPF076A7g==
X-Received: by 2002:a7b:c451:0:b0:426:63b4:73b0 with SMTP id
 5b1f17b1804b1-427c2cff435mr12977525e9.34.1721223610100; 
 Wed, 17 Jul 2024 06:40:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:c194:849d:f1e:3618:dc03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427b9956088sm74095245e9.30.2024.07.17.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:40:09 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:40:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <20240717093911-mutt-send-email-mst@kernel.org>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n>
 <20240717045335-mutt-send-email-mst@kernel.org>
 <ZpfIDUwS9vawpzT5@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpfIDUwS9vawpzT5@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 09:33:01AM -0400, Peter Xu wrote:
> Hi, Michael,
> 
> On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> > I just want to understand how we managed to have two threads
> > talking in parallel. BQL is normally enough, which path
> > manages to invoke vhost-user with BQL not taken?
> > Just check BQL taken on each vhost user invocation and
> > you will figure it out.
> 
> Prasad mentioned how the race happened in the cover letter:
> 
> https://lore.kernel.org/r/20240711131424.181615-1-ppandit@redhat.com
> 
>      Thread-1                                  Thread-2
> 
> vhost_dev_start                        postcopy_ram_incoming_cleanup
>  vhost_device_iotlb_miss                postcopy_notify
>   vhost_backend_update_device_iotlb      vhost_user_postcopy_notifier
>    vhost_user_send_device_iotlb_msg       vhost_user_postcopy_end
>     process_message_reply                  process_message_reply
>      vhost_user_read                        vhost_user_read
>       vhost_user_read_header                 vhost_user_read_header
>        "Fail to update device iotlb"          "Failed to receive reply to postcopy_end"
> 
> The normal case should be that thread-2 is postcopy_ram_listen_thread(),
> and this happens when postcopy migration is close to the end.
> 
> Thanks,
> 
> -- 
> Peter Xu


OK, so postcopy_ram_ things run without the BQL?

-- 
MST


