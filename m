Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DA1C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFxZ-0007qR-EX; Sat, 20 Jul 2024 15:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFxX-0007po-Ss
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFxW-00068o-CB
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721504493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AnDvVRqV211hC2RNwgM3Iz2tf/DX/PVJVQ/RaV5B8s=;
 b=UqS624pdpjz27kZSqalERseB4bOAnJiDFlRSQntevZ0EXzPyGL96QpCq2LWQPolj6uRxNl
 Ej+WXu2cIvW6J0zY35C4VGVj3T1aAxJi3QI/RBg2hDFQix+yines3Th8sUuVp4QUYOUyJB
 nlJ93zsQI/9twjv1+5fZxzCCao0uWjA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-f7ZXSj3vO2KIuWzIM-g8vg-1; Sat, 20 Jul 2024 15:41:31 -0400
X-MC-Unique: f7ZXSj3vO2KIuWzIM-g8vg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42674318a4eso28975755e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721504490; x=1722109290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AnDvVRqV211hC2RNwgM3Iz2tf/DX/PVJVQ/RaV5B8s=;
 b=tsBaPtCM7U3+2XG9PoAb0KR+OESLdiGHNIokal5iRis3scVnNNnjHl3FTCdTP3a73v
 D3xwADS8M/Lw06sE3VZGtSrEDeQahi+Vo/rP8TNpSz5QRFarSC52bimqHsPACEL2qi7Z
 ItLdcJi/XZMUv3eOPpWeQ1KkSn2wfYqT1/6an7JgfXTzFkphOMBaxrsxOqmwv7Aq4hj6
 5DK6JvmUEovwjeydEpt7lLwAbeV2v6oxisUhDQPRiQITE8NMQy/AZ/iVrafIjeTlwyQT
 ArdnXrHGKAiaoWqP3I5ogngeJJ9AjfeU8ZLw72KR537eTUj+V6TaiWAJoW3qxpAo06Dy
 /NnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjaNUgv+d1rwLd3xD/Ke5Km62NQidArO9f3tlOIdzAwpu0ut+yMup8QOuzUeAbEeGuCgfNu3mny0nflbO9amaxoFR4OKw=
X-Gm-Message-State: AOJu0YxTdT+Mj63t0FuIR9FUG/ZloNGCQ5I8FziIx3DM2qtcdKxlyMjm
 ZF4uSOXG+fcNelu8gPHaFxh3UZkvAJ/EvBqRDt/g9xOssNSwaCPULR7AgFh212qhRzPDBS4ISz1
 3xG5HY16PxKqgGsPSAV9oCdg/OQeaOQyxA+PY+3qIfWRXy5+Py9CfOpzGegvR4u4=
X-Received: by 2002:a05:600c:468b:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-427dc55bc31mr15976425e9.30.1721504489817; 
 Sat, 20 Jul 2024 12:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnOakmSqkuYl8SkyJ01OguNMeNDdrWoinoantQhFWzhwL5VUwiEpHu97IP3Qhb2wzaNKmlCw==
X-Received: by 2002:a05:600c:468b:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-427dc55bc31mr15976305e9.30.1721504489208; 
 Sat, 20 Jul 2024 12:41:29 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929981sm65980775e9.36.2024.07.20.12.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:41:28 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:41:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <20240720154116-mutt-send-email-mst@kernel.org>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n>
 <20240717045335-mutt-send-email-mst@kernel.org>
 <ZpfIDUwS9vawpzT5@x1n>
 <20240717093911-mutt-send-email-mst@kernel.org>
 <ZpfLZbiJ3cn6fEba@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpfLZbiJ3cn6fEba@x1n>
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

On Wed, Jul 17, 2024 at 09:47:17AM -0400, Peter Xu wrote:
> On Wed, Jul 17, 2024 at 09:40:06AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 17, 2024 at 09:33:01AM -0400, Peter Xu wrote:
> > > Hi, Michael,
> > > 
> > > On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> > > > I just want to understand how we managed to have two threads
> > > > talking in parallel. BQL is normally enough, which path
> > > > manages to invoke vhost-user with BQL not taken?
> > > > Just check BQL taken on each vhost user invocation and
> > > > you will figure it out.
> > > 
> > > Prasad mentioned how the race happened in the cover letter:
> > > 
> > > https://lore.kernel.org/r/20240711131424.181615-1-ppandit@redhat.com
> > > 
> > >      Thread-1                                  Thread-2
> > > 
> > > vhost_dev_start                        postcopy_ram_incoming_cleanup
> > >  vhost_device_iotlb_miss                postcopy_notify
> > >   vhost_backend_update_device_iotlb      vhost_user_postcopy_notifier
> > >    vhost_user_send_device_iotlb_msg       vhost_user_postcopy_end
> > >     process_message_reply                  process_message_reply
> > >      vhost_user_read                        vhost_user_read
> > >       vhost_user_read_header                 vhost_user_read_header
> > >        "Fail to update device iotlb"          "Failed to receive reply to postcopy_end"
> > > 
> > > The normal case should be that thread-2 is postcopy_ram_listen_thread(),
> > > and this happens when postcopy migration is close to the end.
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > 
> > 
> > OK, so postcopy_ram_ things run without the BQL?
> 
> There are a lot of postcopy_ram_* functions, I didn't check all of them but
> I think it's true in this case.  Thanks.
> 
> -- 
> Peter Xu


So pls document this in the commit log.


