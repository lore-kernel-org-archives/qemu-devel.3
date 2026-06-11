Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A0CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXi23-0007x1-18; Thu, 11 Jun 2026 12:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXi21-0007wm-Ts
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXi1z-00026S-Az
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781194402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kf6Sev/w0rBNUJxDj3vhxE/lISnasr7flvFzrUIZvwQ=;
 b=Y3xFr+1JiYWO5S79dAhtDW1ncHvgdqfoRE8FsMhrT6i8H6DqdLmkvxEpZa1ghRgXF794B1
 v81IFSw7TfYbYf7lFbr+G7af0E774kJMiLNqy4Cv7h2bXiUOuW9Bg6XCyiZ9FfP7shRhPP
 Dfq2qXIqloK8GmHubUFa9qLWxF2ANO0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-JuJtfCutMBqzlcAh32vFIw-1; Thu, 11 Jun 2026 12:13:19 -0400
X-MC-Unique: JuJtfCutMBqzlcAh32vFIw-1
X-Mimecast-MFC-AGG-ID: JuJtfCutMBqzlcAh32vFIw_1781194398
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so5423848f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781194398; x=1781799198; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kf6Sev/w0rBNUJxDj3vhxE/lISnasr7flvFzrUIZvwQ=;
 b=S7TJ7+jD/UVXUThXSxIbr8VpxU6zvOzgpvQJ9kVdux82wIn30cw/DkBlg9Ag2JsCtQ
 veZ9IuOhoSLvrjN9fQD+augj3czj6mD+6WJa22/Ln969Z/VTpuEnL/GiNFmgaTgXBvci
 Jg72OyzkEtupKWKhfVMl5wGd1W/Z19aiQJly3KlX2YRmFeUCHygFcZNSRbRNWoEToBZ0
 5bQ9JIYvT9sVzxOR8Q5X9C4or6YY9yVlUuYu5JLXq9BmWkXE0t/BwKb3cf+ZZiHxVXhc
 EsHjiKlmldd4iKZJ2EbLNaE9QRUxC2PupAe84m/choXAYcejAOrvwqlObMUoYoSO48u7
 x4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194398; x=1781799198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kf6Sev/w0rBNUJxDj3vhxE/lISnasr7flvFzrUIZvwQ=;
 b=GD+cEPJfb9AwxWhweEtt13iTqxmGG/ewpp2zPGt1yygBStTIRy0YpkNQcbgis1FjRU
 UsKwzICtw87z5yphmfm8KxgiXEAmhWw7MF8bfCQLrRgNh/9EtR8OxtzsjDQV5RM7Qm/B
 frYr7yoQOLGPQybG0cA0wVhFE45FlYGdUkVNx64s8PTeqan8q/+GANO+zdhy4t/+gZeV
 KoPxPfKQ+ML/XH5EMMVb1e3sqnDcfnUVSewCdfDt/X4Ef6dD1he41wdk+WMp2O0Ptuk7
 u6R3zqzgX9k4vz26zrZHZphI/FyqT5G7JQdY0tpphJGdoUEIjJfCXkBReWOKQXdYCnsO
 QHKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ugo2e5m7C5wCw5LKW7c/JzL8Ahr1wYz/rOnDkGcGcQEBCnoBGdr6h6Js8+xlyePRoQbR8ZJOVDLvJ@nongnu.org
X-Gm-Message-State: AOJu0YxgN17DeMQqLDuNqFczwEg5XikHOv/y1JOksb7CF9CQqxWYcGfk
 H+nHFi0pyYBtgT6H36rrQLQsC/14Q1Zs3RTyDGHt4Q9DuElo6HtSeQPEMj2eE9LNGgIh78lpB1R
 QzDRAzSnJ5wL9vf5koWH3UZXYikZGZGLVK29j83hu6TwqT22LZT126Rb3
X-Gm-Gg: Acq92OHG4OEZo4QUKbq4iZxXQayNfESzCE09T7ATtheUVcPcaDOq4B548wQJe45/FZw
 xn56qGKdqIb8m0bCoWEtBoWdeoXYvAh3Axa+1hIgYdAAoqPSsLQnJXhWmLOGCui0PUUPhGD+4Vs
 bspCP1QJRvc35wwpXzFTJBm4wqy3sAog1VlnyVkJRWCJB8UBDQS5jQ7yzMFq+360sPJevyYlwM8
 5RY6G33KWT1nXYT0m1UxjbqfPc4wsnXL7BXhBcINRIARXYuSF8M5FCOcfkurmPtY9Si9UPUuhxH
 qCvgjuXZGBdzVN9jOcZpu2uWUfbJoFy0rb7RePYK9ymuETO6H62RfcRnJhK4mW1nsdF1z9/Cy3y
 ursvK+e3GXjcbNpf4m3r1cFATUuvLmuNVBK8K7AeGSvk=
X-Received: by 2002:a5d:5f82:0:b0:460:50a1:b23a with SMTP id
 ffacd0b85a97d-460677ae8e3mr5525642f8f.27.1781194397976; 
 Thu, 11 Jun 2026 09:13:17 -0700 (PDT)
X-Received: by 2002:a5d:5f82:0:b0:460:50a1:b23a with SMTP id
 ffacd0b85a97d-460677ae8e3mr5525589f8f.27.1781194397565; 
 Thu, 11 Jun 2026 09:13:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm76782849f8f.8.2026.06.11.09.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:13:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:13:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611120325-mutt-send-email-mst@kernel.org>
References: <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611110156-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 11:05:35AM -0400, Michael S. Tsirkin wrote:
> > If and where we need to provide guarantees about "this access will
> > really definitely only do this size access and it won't break it
> > apart or anything like that" then we need to either be using compiler
> > atomics or else inline asm.

BTW you meant intrinsics, of course, but speaking of atomics, they do
not work on device ram, or not yet. E.g. kvm does not support them
when exiting to qemu I think (only if emulating within kernel)
and it prints "emulating exchange as write".

We are quite far from "arbitrary access" even on pure device RAM.

-- 
MST


