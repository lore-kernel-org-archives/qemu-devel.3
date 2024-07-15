Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743A2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 16:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTOVM-0001Qr-DW; Mon, 15 Jul 2024 12:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTOVK-0001Pp-KK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 12:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTOVJ-0006AW-4D
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 12:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721060683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uDDixXogx16EYB/YMw4dDLZGhCNdaTS6cPV5ZbUWeKk=;
 b=EUSMT6wZu1n0OuI6p/ETeH3MNpDwY4w8ZAeV0v+HCFkVMTttyUoS5UhGl/2rJPTXZnSBhr
 L36iG1/7IpeYBUqelBH6sPfCplAyJNSwuClZqIpWcNplxDePO9YNV5DBpOD4zvaLNpI4t0
 1uzGliVFP3CzzFzEkW3UEH3TTKdiatE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-RJjiG2miO_6RQHaposzW6w-1; Mon, 15 Jul 2024 12:24:41 -0400
X-MC-Unique: RJjiG2miO_6RQHaposzW6w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36792df120fso3403796f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 09:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721060681; x=1721665481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDDixXogx16EYB/YMw4dDLZGhCNdaTS6cPV5ZbUWeKk=;
 b=YN/2kSVdey57+feeevhv35yMtwWnWZ0wYqpq+zTkQokvaKokzqzBwglhs+jRzsk/TI
 kqDEz2nRw+Himjr2+Tcs1mHxBvjIP3H4wKhh8woKy/qpdn5qVFtrxxB0CAMybVIZZK/k
 b4fHq+xmWvSmF26mrlq6Ln+hxOZ33efAWlzH6gqz+EnldXetW6aybNA8TzFhEr8YQzBY
 g4anJn2RR+0WHeX5EpZxwN4LfruGTxiqxBSVgaVsOFkJb5+qjYZoIOlPUcw49fOnnQeL
 zlWnDk5xiN2FUPTg7ufWMB6SzF26EtzPHSErv0qjDUnwpJR33s73Thuonzp/DyVwJg5W
 R5ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMiAdWJFNa2EBkbM3p1Md08sZ9+P+SO1Wqt1cKe7NEHMrMJv8w7l9NFlbnF7ZKURKSkAB/CGzs2LC+3+On8CCXiD5n1oU=
X-Gm-Message-State: AOJu0YxsaLuaKHUDD01GMIZmLXTMnYcSJffjFlWFMHLr6eET9MkjMRKV
 t/4gT5PT8Rgot0FJqglD7Z0Hh4+L427xkHK9bDMheDqRFeZnaQ6s/0DPRrEs3DR3kS3WlX/TRuo
 7bC1bxR2jIEksTlSeTrRO1lXISecEOCjjXgKEimsriGQi0mLLJ4lh
X-Received: by 2002:adf:9c82:0:b0:367:f13b:ae8c with SMTP id
 ffacd0b85a97d-368240d020amr153322f8f.47.1721060680744; 
 Mon, 15 Jul 2024 09:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDt6m56NItKZx9JfEjbqFtFb7gxFXRNuI/9ZxIifaucj+aAOnQKHt+5v0jpKE9K54MUIKwYw==
X-Received: by 2002:adf:9c82:0:b0:367:f13b:ae8c with SMTP id
 ffacd0b85a97d-368240d020amr153284f8f.47.1721060679758; 
 Mon, 15 Jul 2024 09:24:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e1csm6820732f8f.2.2024.07.15.09.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 09:24:39 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:24:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>,
 "Kumar, Shivam" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Message-ID: <20240715122009-mutt-send-email-mst@kernel.org>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715104015-mutt-send-email-mst@kernel.org>
 <PH7PR11MB59410B8B35F932AF55C8A243A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941FD211A0357828F1DA20CA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5941FD211A0357828F1DA20CA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 15, 2024 at 03:57:42PM +0000, Liu, Yuan1 wrote:
> > > > > > > > that is 23% total CPU usage savings.
> > > > > > >
> > > > > > >
> > > > > > > Here the DSA was mostly idle.
> > > > > > >
> > > > > > > Sounds good but a question: what if several qemu instances are
> > > > > > > migrated in parallel?
> > > > > > >
> > > > > > > Some accelerators tend to basically stall if several tasks
> > > > > > > are trying to use them at the same time.
> > > > > > >
> > > > > > > Where is the boundary here?
> 
> If I understand correctly, you are concerned that in some scenarios the
> accelerator itself is the migration bottleneck, causing the migration performance
> to be degraded.
> 
> My understanding is to make full use of the accelerator bandwidth, and once
> the accelerator is the bottleneck, it will fall back to zero-page detection
> by the CPU.
> 
> For example, when the enqcmd command returns an error which means the work queue
> is full, then we can add some retry mechanisms or directly use CPU detection.


How is it handled in your patch? If you just abort migration unless
enqcmd succeeds then would that not be a bug, where loading the system
leads to migraton failures?


-- 
MST


