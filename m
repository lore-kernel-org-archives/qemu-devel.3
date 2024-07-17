Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C486C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4mT-00037F-Lk; Wed, 17 Jul 2024 09:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU4mN-00030F-Si
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU4mL-000636-D0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721223186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcL306DTYN6PZ4GqAGy2fodmbrbn5AcuAQz0YWNEALo=;
 b=aCaAEyq2WjpZA2JZxTebHn29ZMtPtejHk+XEcnkQLUWnemOaYvYEs3YvTFiW/zr3TtGE6c
 hlv27U7wO+vBPuLh7/UnvBxH+zQb0zXEUtCTdfIHGEzsFzyblQphHm68IYh0T6rXTkwx8K
 U9H5KhHU+YjP2LGGHPDts/ZrtBgk8Mo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-TsbnHGaWMiyCGC25WuefuQ-1; Wed, 17 Jul 2024 09:33:04 -0400
X-MC-Unique: TsbnHGaWMiyCGC25WuefuQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-448335bb53aso7630551cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223184; x=1721827984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcL306DTYN6PZ4GqAGy2fodmbrbn5AcuAQz0YWNEALo=;
 b=V5jizw8QFHQd5X81L00/9oFCXTEi28YjE3AWgFfliPYe641pGPmiV3VOH3aTamWlj0
 kbf8wTab/8BQr5KAiunkn362c7I9pA29Ji0TNzHst8ePoJj0uQynN96REZM27QMsNWm0
 WjFI1Hmhg9MPuiUVDMPB2W5CMos/LkCRN50mMhzqCTIIseW3gMZmppnVCEpeeLo4IpvG
 YB7dUcW4adYTl7Cy9/5xWORo0hntE6cpTOngvF7b7CS4Tl3MGO1fREfziSbllyOdgY2j
 YR9jl76n/YMfU1P574c9fhTApOCd8Q0VgYXCZWHrElj+rSAwr3YzT5OndCfB9z7muQ4x
 yykg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMywkFlAmZUefDhVsr0HQg+eqalDH/Pd6xpzSiS0TJwNRwEHLr0oiEjjp8deCFHgyyhSZVVEPmWH/TnfkfJasDyLNRsf0=
X-Gm-Message-State: AOJu0YzzZS9LyJZIvXQROTZeUH1znuRH2IaXl1bsT8xnYhaaCfQ+Xq6o
 A5WOHdgwW/ymRNaBxDWZKH9xBEncHMsj2i8ppTK5tT7DF5Vaa/tb4715clPe6GCS07qcuvqc6iq
 td0M6zQ8mxkXR43pgVjG/kAtkWrmym5O6R5yo4dgKoQjQ0HmzTYcr
X-Received: by 2002:a05:6214:4401:b0:6b5:4bf:e0b2 with SMTP id
 6a1803df08f44-6b78e2b40b4mr12430346d6.6.1721223184088; 
 Wed, 17 Jul 2024 06:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1IEZayWuHe/zxz4MVlNRQw0O+4rkZ5wbqETr5odxARFgdLYYBqB5uQ+ujz6QuYLWGkWAvLg==
X-Received: by 2002:a05:6214:4401:b0:6b5:4bf:e0b2 with SMTP id
 6a1803df08f44-6b78e2b40b4mr12430156d6.6.1721223183564; 
 Wed, 17 Jul 2024 06:33:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b799a96ae1sm910316d6.21.2024.07.17.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:33:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:33:01 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <ZpfIDUwS9vawpzT5@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n>
 <20240717045335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717045335-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Hi, Michael,

On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> I just want to understand how we managed to have two threads
> talking in parallel. BQL is normally enough, which path
> manages to invoke vhost-user with BQL not taken?
> Just check BQL taken on each vhost user invocation and
> you will figure it out.

Prasad mentioned how the race happened in the cover letter:

https://lore.kernel.org/r/20240711131424.181615-1-ppandit@redhat.com

     Thread-1                                  Thread-2

vhost_dev_start                        postcopy_ram_incoming_cleanup
 vhost_device_iotlb_miss                postcopy_notify
  vhost_backend_update_device_iotlb      vhost_user_postcopy_notifier
   vhost_user_send_device_iotlb_msg       vhost_user_postcopy_end
    process_message_reply                  process_message_reply
     vhost_user_read                        vhost_user_read
      vhost_user_read_header                 vhost_user_read_header
       "Fail to update device iotlb"          "Failed to receive reply to postcopy_end"

The normal case should be that thread-2 is postcopy_ram_listen_thread(),
and this happens when postcopy migration is close to the end.

Thanks,

-- 
Peter Xu


