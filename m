Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD305C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzqT-000282-Ux; Mon, 22 Jul 2024 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVzqS-000277-76
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVzqQ-0000I8-MX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721680877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkmtHvclAyJaNkiLv+MWPU9tEc42jBXKMUOJLq0bQ7E=;
 b=QTmpz+fuE61CQAfk4zHMnN0mHO/YVyKVRzyj72yNomwFbNTxz/Z/pxErvEDMXyYS7XdBBz
 trukC5YJJFLDDGZfjtSZMVo+jxnGPqmCqIwuozKH3vdspyFVont8F4blP6x0OJ6a7R9+/Z
 SQNXzcPTE9XL2cLeWla1DnalXZH1T08=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-iCdRDb1UOaOHHRL9X9AI2w-1; Mon, 22 Jul 2024 16:41:14 -0400
X-MC-Unique: iCdRDb1UOaOHHRL9X9AI2w-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4f51ae60628so84279e0c.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721680874; x=1722285674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkmtHvclAyJaNkiLv+MWPU9tEc42jBXKMUOJLq0bQ7E=;
 b=fyPzTg0FtwcLzEkEUoTw6mI8u1dEJHE3UA9csDBroKg1ne6rg7HNIKyW4VA+uTX916
 TVw5JuD5zXKMflFzjv/PmbWUilzGG6Tdn1tK0JeGd1ECFnrm5sJTdrejb9dUVafRnu77
 iCicf3NVunoa1rYkiKYbXWFRKvxU7qeeeFWiHFYo9xXKW11ndQquzde5wxOJ8BWGZEQX
 BFV1G2jy4XrYQRFXkATvuXrSq6/UNgqT4BGDoxRBkrOtO6zOF3cmd/O22Ye8PqEhDGmC
 p+575iDCcz8GArEldN6VTJvmPWj5WGZXxr/ywHhh8/GHr1+6K1J2oLbega/tAscxIQT7
 JTGw==
X-Gm-Message-State: AOJu0YzGpso8ZBnhBxZvuanNn5sbAT6MbknfIZMZfxhBBJwPg+jMNNQe
 phTr2tfH/FFFHc25Q3ilQTif0fGqWn7JcuSwi5tS/M7ocAjG4Ajw7bhTpb/T1xeqGesqCY7P3hI
 fC+bx34ZI5oRdyvtKnL5x1AMg2axj2I+NDMAYB1jGp9whnxeowU45
X-Received: by 2002:a05:6102:1626:b0:492:ab16:d05b with SMTP id
 ada2fe7eead31-492ab16d2f2mr1763754137.0.1721680874025; 
 Mon, 22 Jul 2024 13:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUpByCWiaWvSGwaouzSahrJ4hrnd1L9LQnXWBvxPdSfNQIiIJXMmjw/gswMcHrLz6Etv8EWA==
X-Received: by 2002:a05:6102:1626:b0:492:ab16:d05b with SMTP id
 ada2fe7eead31-492ab16d2f2mr1763741137.0.1721680873575; 
 Mon, 22 Jul 2024 13:41:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19900570dsm399812285a.68.2024.07.22.13.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:41:13 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:41:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 9/9] migration/multifd: Replace
 multifd_send_state->pages with client data
Message-ID: <Zp7D59BBkjUVdThg@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-10-farosas@suse.de> <Zp65Iqiz_rRleE_Q@x1n>
 <87jzhdyxyu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzhdyxyu.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Mon, Jul 22, 2024 at 05:26:49PM -0300, Fabiano Rosas wrote:
> >> +void multifd_ram_save_setup(void)
> >> +{
> >> +    uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> >> +
> >> +    multifd_ram_send = multifd_send_data_alloc();
> >> +    multifd_ram_send->u.ram.allocated = n;
> >
> > IIUC this line won't help, as the type is still NONE.. We may need to reset
> > this in multifd_pages_reset() even if it's a constant to RAM code.
> 
> I could maybe just hardcode it in the packet. No point setting this
> every time.

Yeah sounds ok.  As long as this keeps working after VFIO can reuse this
object at some point (and overwrite "allocate"), then it looks fine by me.

-- 
Peter Xu


