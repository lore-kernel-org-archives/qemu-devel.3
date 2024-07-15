Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEDDC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLkD-0007tg-D1; Mon, 15 Jul 2024 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTLkB-0007t6-Gk
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTLk1-0005A2-SD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721050062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o77D+3+EpheCtqg69Fmtg0LzvP4yoS7faoaZKaajlMA=;
 b=PHV8CgyyhpnwaPNRAOquD4l9W0Io1Te+5KeUkuhy4Hv+JOqPCzOPv+zXpRkIvoKvFWaKFB
 nhOtxrOSTYz8qHJxIuekeT2RCuBXCJJykmCCBDEp58f1n+q64JqFiTeS084ee9mUKcxf/F
 MHiplTLHHD+TOvMHnFXHeBn0NNyDUZc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-sAZoSLmIOIGCF3bMNBQC7g-1; Mon, 15 Jul 2024 09:27:40 -0400
X-MC-Unique: sAZoSLmIOIGCF3bMNBQC7g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-447dfad3387so10933771cf.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050060; x=1721654860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o77D+3+EpheCtqg69Fmtg0LzvP4yoS7faoaZKaajlMA=;
 b=ItjidYS8+PxyQMPgU5yaGzaIcJ5FVJ61gt0Y7B1vudJQVC/K+HNHpSqpCUI07xYyl1
 6aEes6Tb3EnMnRvkkhcY8T1PjjvFOLCUZM2S15QV4+IFZBWS/hywtAWcEAjWcEVZkDyX
 j49g4oi4OOQBdbG/BA9VA9Ne4T3Yb79Pwflo3Q2ZwWoUfsFbO9ogj0nyWpkfQe2HWpVF
 bzJ04G2sGJe3Y5YBr9ZN5Qd4mnvn/9zorPod3UzqAzMe6+6btzhnuQfEqIlcwZ/sZne2
 EQCQFoJRGQWBfGfq5eBJvYX8xLkb9nCw06L4SmzLGkB/NlZqUu7I3nxEnpUvYOZULtwZ
 xVbg==
X-Gm-Message-State: AOJu0Yy6Gj6+2rdydeFg0np+jL1NWVkuRECvt2z4+eK2V3h22LqM6xf6
 guuePggOm2stl1DPRXXBJaHmZYfXwm8zutHY00Jb6aPu4RGe4YbNoDCwvgWqOSIFtrId3UVqksM
 Q3S3Du4TU8pRcoXfni5b1gf3iAIUzL2mnyvGWu0+Uh6M7j86pCskM
X-Received: by 2002:ac8:724c:0:b0:44e:cff7:3741 with SMTP id
 d75a77b69052e-44ecff738a4mr63489621cf.7.1721050060025; 
 Mon, 15 Jul 2024 06:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjRgYzA3ibP40PNf10p/Oga8VnXfT+TJmJ+AB2FmWDQ1kZjozYSnpNnXV58M8ZaMAlJIZ2GA==
X-Received: by 2002:ac8:724c:0:b0:44e:cff7:3741 with SMTP id
 d75a77b69052e-44ecff738a4mr63489421cf.7.1721050059694; 
 Mon, 15 Jul 2024 06:27:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7e32ffsm24613611cf.24.2024.07.15.06.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:27:39 -0700 (PDT)
Date: Mon, 15 Jul 2024 09:27:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 1/2] vhost-user: add a write-read lock
Message-ID: <ZpUjys64KeOI1Kmx@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com>
 <20240711131424.181615-2-ppandit@redhat.com> <Zo_9OlX0pV0paFj7@x1n>
 <CAE8KmOzrAdxGMVb7=hYMOgAOuhhzUT+N0X=ONNN456S6f2i87A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzrAdxGMVb7=hYMOgAOuhhzUT+N0X=ONNN456S6f2i87A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 15, 2024 at 01:44:00PM +0530, Prasad Pandit wrote:
> On Thu, 11 Jul 2024 at 21:12, Peter Xu <peterx@redhat.com> wrote:
> > I apologize if I suggested WITH_QEMU_LOCK_GUARD when we talked.. I don't
> > remember which one I suggested, but in this case IIUC it'll be much easier
> > to review if you use the other sister function QEMU_LOCK_GUARD()
> > instead.. That should make the diff much, much less.
> 
> * Yes, QEMU_LOCK_GUARD simplifies the diff, but it may extend the time
> for which lock is held, delaying other threads, is that okay?

I think it shouldn't be a major deal in most cases, if the extended cycles
only cover a bunch of instructions. In special case we can still use
WITH_QEMU_LOCK_GUARD, but I'd start with the simple first and only switch
if necessary.

Thanks,

-- 
Peter Xu


