Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388ACC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6XQ-0001Dx-AZ; Mon, 03 Mar 2025 09:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tp6X3-0000w8-Tj
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tp6X1-0006Hk-73
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741011147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWteq7IsfO98h1Bj/PvrrNVm+toLC3uI/bhJCQyLh6E=;
 b=VW8T9SAUXf+bAQutLp/EqPEn9piFyC+DafUJCHRASQRHqsQhkKjzGpwENw43DR1OrIjqf4
 tmUnWaHFzJ2c7Masw7Eh4ebHRYWUpk82dFmDG2Keq3m4OfWY4M8eraIFfLENXn+EqMEFT/
 8pir6x3zK4GknOjbXDX1CiPzuxSKcX8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Ppf_8eWYN-CwyVdRFA7GQQ-1; Mon, 03 Mar 2025 09:12:24 -0500
X-MC-Unique: Ppf_8eWYN-CwyVdRFA7GQQ-1
X-Mimecast-MFC-AGG-ID: Ppf_8eWYN-CwyVdRFA7GQQ_1741011144
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e8c68dae82so25720426d6.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011144; x=1741615944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWteq7IsfO98h1Bj/PvrrNVm+toLC3uI/bhJCQyLh6E=;
 b=qG68zOhAPJvX43Iotdr6kTrNuSX2rKaPTMIqAjxJZxk65lIMYESS/ASsn4WMY6g0TS
 NpyMZlHnXV5yMUfylJbo/Tq6mXOq4lslWzIE9r6C4VE3Va67rb1dM+NxH3WTUEwCujg7
 9LvO0jjSVeQ3WBqrCtw9QC9fVxM6A9MAltdRe/MzzpQr85pAIGKBK5gIURUlCpPXkeJM
 u/yZ+A6i4x6xA37xLI9A8vP/PeFUcrshpTpPi//In9sh9mrPi1UuJiT21NZXwzIVJPm5
 Q3/iZ6SDg83sH2hGXNZ6l/fiQ82zH/3XgsrFWvzo/wVv8vYIWTpvdlUDi0oFRJxLsbDQ
 yiLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3m9vTzgqqSVWEeGeJH7KPx20qOaFtMp44Ob/uCmXESeqsfUyXQdtFKCpPLuZ/WoQ2cKAc/fv3jx9g@nongnu.org
X-Gm-Message-State: AOJu0YyTgCsLam+v4J3Nhqt3LwitDuh+xhZ23e0Yf2XVlQlPBz05ej1h
 LfeikOUSfO4Wr9h3YNB2e+dkq1861wxcz6xL9InVxe5vr68nERdxCODHBpaBrbrtVeHMiT/JD5O
 rJhfa+rxnqRAvnCRftM1APwwXjUNazc8N9AnwNQTRwwuDw2TIDQiY
X-Gm-Gg: ASbGncvpbmz7iZs4lV3OATHGDAfumPUzsJ6WcREf4fI1k4PE2cox+1MrkoFis2Brbp0
 MU73rLI8nV4Uv5guWOg1dVK//ioMTgrhpG1AM8cxq0hNaiYNVPJ5ouQufoDWKMxOXFNuffxEd9K
 qecYmROv23Zen2vW23KhHBsq4AkHHV9/QufZhhcc6Gwq1h3quNd1rKG5irAFZoYoATnDeDcvtNj
 Y1o4OAzQSGiukSjmHREhpXd1+ySCg0+yFmMwrMX/EQrzQtfge5OfdRyMqdhYIJRdJpEPbZJSe3Q
 CZNrlV8=
X-Received: by 2002:ad4:596c:0:b0:6e6:5bd5:f3a8 with SMTP id
 6a1803df08f44-6e8a0d8fab2mr184414236d6.29.1741011144388; 
 Mon, 03 Mar 2025 06:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKdrUfZqkSYtZZQ1uDCo+KgCmPozIcrv3KxvCU2tN7bE3lHMYeC5VTw2mOGiic+raqEDWwug==
X-Received: by 2002:ad4:596c:0:b0:6e6:5bd5:f3a8 with SMTP id
 6a1803df08f44-6e8a0d8fab2mr184413986d6.29.1741011144025; 
 Mon, 03 Mar 2025 06:12:24 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e897661633sm53332376d6.58.2025.03.03.06.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:12:23 -0800 (PST)
Date: Mon, 3 Mar 2025 09:12:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
Message-ID: <Z8W4xVOLLAD1wXjC@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 03, 2025 at 04:17:53PM +0530, Prasad Pandit wrote:
> * I think we (you, me, Peter) are all looking at things differently.
>     - In my view Patch-2 is the minimal change _required_  to enable
> multifd & postcopy. In your view we are _revamping_ channel discovery
> parts while _sneaking_ in a feature of enabling multifd & postcopy
> together.
>     - In my view Patch-5 in this series is an isolated change because
> it adds a new migration command to allow multifd threads sync from
> source side. But Peter thinks without that 'flush and sync' Patch-2 is
> incomplete, so we should merge it back there.

Just to mention, my suggestion does not conflict with splitting patch 2, as
long as you keep every patch complete on its own.

Patch 5 needs to be squashed to either patch 2 or a split patch out of
patch 2, because current patch 2 (or any possible way to split it into
smaller ones, then one of them which enables the feature) is buggy.

Thanks,

-- 
Peter Xu


