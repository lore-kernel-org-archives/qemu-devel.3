Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEUjZ-0003lx-P4; Mon, 12 May 2025 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEUjU-0003lO-Dk
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEUjQ-0003Gr-HY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747062369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cy8TKlaEjh/1/iAb0ycpraX4hwQr7xq7u1lrsROBwNg=;
 b=YPEWcus23QZYQOieZLwNcqVc7M8No2yeb3YCc68B3v1wwG6Dyw/xZ1T9M0Ebdkh6q1HUiH
 yp76bTpcizbjKWZLKfx96/BhAshO01jyjSmfK1JNPzof7/hMMJydx4IF2MnDw115Vcgjks
 8M8NNBcc6S/pfnhMxiz06AZmSbr3bj4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-zABAObWoPpWz1lmVv5GtVA-1; Mon, 12 May 2025 11:06:07 -0400
X-MC-Unique: zABAObWoPpWz1lmVv5GtVA-1
X-Mimecast-MFC-AGG-ID: zABAObWoPpWz1lmVv5GtVA_1747062367
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f544cf3f6dso86291286d6.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747062367; x=1747667167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy8TKlaEjh/1/iAb0ycpraX4hwQr7xq7u1lrsROBwNg=;
 b=PfQyxSb4sBnloLeMJcQiDLY3Iv8xnWHge+Hdam7CE7ZhW4mcxksv6T3977cF3bJ+Xe
 psxv5cqyLna8u3xoDXmVW3O1z9EkHxPFeuDxG5Kp/7Hi8CzT+DvcPV7dSmjBllQgubfC
 GUGe8X3Oay4+VFLM1vVZMxxdOszatpPJr/rFMbFdmOH2g5irja3g7qH8FnE8+qIjewZ2
 eyRnAYJTh2yf45Ty16559Q+Q5m0dy6IHtL6jBWr1c24swQRbg5murF7iNc/K/x4gUDDO
 tqNYjexB6yQGTxRKw8+g//Cz2R01QIuxNC2Q8i/Ifn3aXz9usv0oQbaDlwhL/zJ/keMD
 eQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGki0cjA4kgFP+TfpJb/RoeEH0rDqqNb+LKDZ992BrYUILpqS0325NykYV+C7baSIVVHKsVrW331fo@nongnu.org
X-Gm-Message-State: AOJu0Yz6C/BPhy+ljKXfUghLylbenDjjZMF0VM61W05ALiwQqMa5mJ3O
 /k424SuSVdpY5XplqaRM2q4mPH+P3z76Cd0sVa/WP2Wj6/p6Xdombb+dblKQ5r/zqQ8qV3P390E
 NJFtR3TEBCTuCtWipX/YSlRV0psO/E0OBHjnSLmAKrJqJXfd+PU3z
X-Gm-Gg: ASbGncsiAp2OEJITDz3N/CeXbydqEn+vOlxy0FHfuofKxCoh0+0e79lAwzxMECqwsdb
 Bp3wbTyUU3ESdsWxoD37z8eOF8p6ec5b9dGWsoglcSUrO62DGRwXN6NhlXEG2UScPNnefTjrD4s
 kFBV1z7Giq7zc9H7ME72p3hDkIiU9UWFKnpvd62LmDKFnYdx3QhX47Fl1aQPglR+9zZXsRqIRTc
 ep+buML1yGWA5taQAeOOMNURlzldLfs1yxWDctQRgQKeDhM9uqvbNTzPPhBEOYUiDp7RS0WDSId
 XKI=
X-Received: by 2002:a05:6214:f03:b0:6f2:a4cf:5fd7 with SMTP id
 6a1803df08f44-6f6e4848aa4mr206096376d6.45.1747062367265; 
 Mon, 12 May 2025 08:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGXXAQ2YSN1Q/OTdFjuNlGpVLu+KZzTj0kmwYhbpn3N6fMtLUJQ8V1lKubvstRHApq/AQyGA==
X-Received: by 2002:a05:6214:f03:b0:6f2:a4cf:5fd7 with SMTP id
 6a1803df08f44-6f6e4848aa4mr206096176d6.45.1747062366954; 
 Mon, 12 May 2025 08:06:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e39f4d40sm53838616d6.48.2025.05.12.08.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 08:06:06 -0700 (PDT)
Date: Mon, 12 May 2025 11:06:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
Message-ID: <aCIOWo36zJeCxTJO@x1.local>
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
 <87ecwzfbnk.fsf@suse.de> <aBzQYslYtUZgXjgO@x1.local>
 <CAE8KmOzi8Zzy5hE2SMdTbMZJQD5_XH34rfEP_B85jstUF9E08g@mail.gmail.com>
 <aB4bGYf-EuGES73h@x1.local>
 <CAE8KmOwFDJhFE6wJpTfDBAG4mJ-Xjsfh8VJwqVYLzT3gGZLZUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwFDJhFE6wJpTfDBAG4mJ-Xjsfh8VJwqVYLzT3gGZLZUA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 12, 2025 at 11:56:31AM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Fri, 9 May 2025 at 20:41, Peter Xu <peterx@redhat.com> wrote:
> > Isn't that what multifd is doing already?
> > typedef struct {
> >     ...
> >     /*
> >      * This array contains the pointers to:
> >      *  - normal pages (initial normal_pages entries)
> >      *  - zero pages (following zero_pages entries)
> >      */
> >     uint64_t offset[];
> > } __attribute__((packed)) MultiFDPacket_t;
> > Or maybe I missed what you meant.
> 
> * Why are we memsetting zero pages on the receive side? What I'm
> trying to get at is, if destination memory is zero-initialised at the
> beginning of migration, we might be able to do away with this
> memset(3) call and this optimisation altogether. All zero page entries
> could point to the same zero page as well, if we don't want to
> preallocate all zero pages at start.

I didn't follow, sorry.

It's still uncertain to me whether the initial pages would be zero before
migration touching it.  I'll need to check some day, because it looks a
matter too as long as we avoid memset in the 1st round.  But I don't
understand what you meant by "do away with memset... altogether".

What is the change you're suggesting?

-- 
Peter Xu


