Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BF6C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitDT-0006pF-74; Mon, 04 Aug 2025 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uisyu-0008SW-0i
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uisys-0000Ye-Bx
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754305429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1d0CY9GSomb1CkpFeckVYckUZpK69zq9jnU0awIDjPA=;
 b=KWNzxbUDtBMCpbkVeGyurpthGGcVi0vpBjCAs3988UX9KXbmtg22wSnBmDz1UM9qipO29H
 cxV5ygSO0BadW21XWijs0inU66I91XdFH/USJiFrq8/R91GCGu7JcHEeko6soM1McJKBIe
 ZfNEQR6v86e30b2HQg/JocIh9TG68E0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-FWKdA4-gMdeBoanjX583BQ-1; Mon, 04 Aug 2025 07:03:48 -0400
X-MC-Unique: FWKdA4-gMdeBoanjX583BQ-1
X-Mimecast-MFC-AGG-ID: FWKdA4-gMdeBoanjX583BQ_1754305425
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-458b9ded499so13442365e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 04:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754305425; x=1754910225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1d0CY9GSomb1CkpFeckVYckUZpK69zq9jnU0awIDjPA=;
 b=H18LnucKfv64s4ZpaOuQlJuqna2rJgNcgSFoITDF7bq2qJPvbie3xaq/iQisLWrKaN
 IILiODb8/7z7sEdj6MfFRe0F9WD2YiirgpkNeHY+4hUyFby8ded2dFNqCEdM7zBf71rx
 Cy+Jg14Ik9w56WgjSWrd1HlVBNYVVRuq/kA8NkJLc2WW01hdjNXTKf86HoVq8h+WHACN
 uS1t7Gwfh0aLbBv/OK4IWMF9NyOp0jdjO1tScIU83Lq62PwuIQ7fzBwQq1rNiBwbDTsm
 P4x9D2zIWQXDpHoD9dDwoxTMifrTBKmN0b99TjntYweBq+Ew4mkekMXft+10+gkPK+nh
 z7Lg==
X-Gm-Message-State: AOJu0Yx3a1vAeN0TTH7h/oSkgx+K4xGc0GytWhpvhlYZ4BaUQNj1patL
 HOU4bWYgouYwNhOy5ZLjhc1GERPRiDmtVNTcZ7osb6gcKWZAuk2AoHcHGDoj4Rr+lx7guPTTj99
 PoeMLpiACFYcui95q8Ry1ILc9O+G/xM7IpZ/X08b3Q88ZPx/kYnuwpe+tL2u4XXmM2kRGVxL71X
 CRKHXSeTtoPeP6veDlIesvJfabb59I6bU=
X-Gm-Gg: ASbGncsq8A8w/barv8wjLX9JjmKOSY/LpAUTm6B2rtHPDVXYh6AAFFIsVunuBKJvykx
 pGtgiXhylq54sjCtqiZ2oyDMBQXztWaEbsd3ZBlsizSCNLX8YbW+QQODN2aYefiMHtqEe5XIDEZ
 REPtBHU3Ven/l6aZa7qyXcDHw=
X-Received: by 2002:a05:600c:5248:b0:459:d4b5:623a with SMTP id
 5b1f17b1804b1-459d4b56388mr36916015e9.9.1754305425221; 
 Mon, 04 Aug 2025 04:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbyQXPe7QWzJDdxKh+xqR/bkaTvvAezq0RKYJYU8p+ZgTj4MQPEdrhzifgR5lH+Ocd0FGBhO3fBo4odTXmZAo=
X-Received: by 2002:a05:600c:5248:b0:459:d4b5:623a with SMTP id
 5b1f17b1804b1-459d4b56388mr36915685e9.9.1754305424730; Mon, 04 Aug 2025
 04:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250801170212.54409-1-berrange@redhat.com>
 <20250801170212.54409-2-berrange@redhat.com>
 <CAE8KmOxzskHzPsfUCZP56qmFHC7Rgi8x0HacUuZgzUv4UNiYyQ@mail.gmail.com>
 <aJCJ-tqqimnrDDgZ@redhat.com>
In-Reply-To: <aJCJ-tqqimnrDDgZ@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Aug 2025 16:33:28 +0530
X-Gm-Features: Ac12FXx3gqerdTokiC_jz6P5duck2uyaIB7L8Xwz5P9eKMbjXkPSo7eAa80on3I
Message-ID: <CAE8KmOyGVhqQNmF1eZYWVENa6DCW0+m-mdT4ot1xSaBiEVFCiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: simplify error reporting after channel read
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 4 Aug 2025 at 15:52, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> The migration protocol knows whether it is expecting more data or not.
> If we want more data, then a call to qemu_fill_buffer must successfully
> read at least 1 byte.
> If we don't want more data, then we would not have triggered any call
> to qemu_fill_buffer.
> Thus, a call to qemu_fill_buffer which gets EOF is an error scenario.

* I see. In that case the change looks fine.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


