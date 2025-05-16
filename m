Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A44EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 16:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFyKa-0000Ai-3H; Fri, 16 May 2025 12:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFyKX-00005V-93
 for qemu-devel@nongnu.org; Fri, 16 May 2025 12:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFyKV-0000ju-74
 for qemu-devel@nongnu.org; Fri, 16 May 2025 12:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747414476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9m/IbYsRTWxJmmlJ876O9Ajx7r7jQGRZUFnl5nJ7atI=;
 b=CVOoCvp6PEGO328YMmB6xGLczxVgncLXRQFiB1xmjgiKyiz6guD4YpMhD5/jbXIyDNcO4T
 bZ7f7pslH/8MR222qrZOC+paYqEOrsTlq0HN6ya1iVY2b1mpp1cay3sfoBS5EkFHsZhjrn
 wnHmRiVrjbHw55JRTSgkHMNWLHGaVMs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-pvaiSUjGMOSNLq2BR-5zyg-1; Fri, 16 May 2025 12:54:35 -0400
X-MC-Unique: pvaiSUjGMOSNLq2BR-5zyg-1
X-Mimecast-MFC-AGG-ID: pvaiSUjGMOSNLq2BR-5zyg_1747414474
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-73c09e99069so2721409b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 09:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747414474; x=1748019274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9m/IbYsRTWxJmmlJ876O9Ajx7r7jQGRZUFnl5nJ7atI=;
 b=KbRnKVxYoRZGcgfpjALJjW7OL9hC/LElcHAMOO7njnj6zDE0mDtEmRgjQqusDJY8Ae
 F1UcLJweMteO6G0cRLU3eA9dSwYA+FyugOk5APkCbszccphBzbGDPfOkbvzm0gYB/SFg
 7VXaBtCBp+la9STk/W8evXB5CeE/opAwKdfwHvayJAGx6hNhqwSy+EbUCmNMw3JWG0JT
 E9MSUi2A3hqvvJs/0mrWF8AeI7v8h39BX/vGBPE6C7KSJCNEE7pTtiMXGwPM8zEyTb+L
 pNMyEYLLR6Xpaya9eQRD7QNYUgkV/CqX8RlDHkKd1a81XYyS652Q4gy8opyMF0BYs2aW
 YS4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUim9TxeWwM6rK6QgY0l/IsKDQ1qshRf3NA/UWig86osquoYDWJqeicwRIfkFZGa41nuVHIiLJ09xQ1@nongnu.org
X-Gm-Message-State: AOJu0Yy17UnW5brxvuof+mq6ODLdkjsUlLcBEZjFyBP9e7YlLGpNRPp/
 1we0FQ7sG4VijVRbbC0IyhRkYhBdpOenjA89LOFj5uu2bCPDDImBmR23IlJB8iNT2G/CzhvgqLc
 QjAYfe7Z346sOwB03QztWROnyBCkxj0mSZTCcr4nxIRhMlLxSuhzMmUEI
X-Gm-Gg: ASbGncsfKLnBRu462pAXaxax3OZrKp5Xs32p/xqmRej5bQ49n2AQGFY5MZEjDMFp2tF
 jXc84YR6lkjH+7tyCZkppHZhCMO2UamdUymfGlywOZ1XQnM0j7/yBu+Dn8HzXAvyi7bpOZ5TtVw
 D+jz0sUO78wOeGdy6ZU91n7S0kfkxz2IZmSSqZOWjnhpuwgE7AVbgfF1kGhFLwgUuifgowSDmT6
 YV05mbbxZxgIQMhI7RDT1ap9LYdxzx6IYDOzxeTqd5+oZaUu1aUCQYuTI8pH0YzHI42douE2+vm
 er8=
X-Received: by 2002:a05:6a21:3990:b0:215:da29:149f with SMTP id
 adf61e73a8af0-21621934da6mr6533436637.25.1747414474074; 
 Fri, 16 May 2025 09:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJe5YcMx1R7MITdEWCRdIlO3YiFT0DZOyuLClGuh18woCRDS12vF97m+Ot0OFZAwyflSC6g==
X-Received: by 2002:a05:6a21:3990:b0:215:da29:149f with SMTP id
 adf61e73a8af0-21621934da6mr6533398637.25.1747414473761; 
 Fri, 16 May 2025 09:54:33 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98770c2sm1742907b3a.150.2025.05.16.09.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 09:54:33 -0700 (PDT)
Date: Fri, 16 May 2025 12:54:28 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: Don't send device state packets with
 zerocopy flag
Message-ID: <aCdtxA_c4zUk3TiP@x1.local>
References: <3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Fri, May 16, 2025 at 03:53:03PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> If zerocopy is enabled for multifd then QIO_CHANNEL_WRITE_FLAG_ZERO_COPY
> flag is forced into all multifd channel write calls via p->write_flags
> that was setup in multifd_nocomp_send_setup().
> 
> However, device state packets aren't compatible with zerocopy - the data
> buffer isn't getting kept pinned until multifd channel flush.
> 
> Make sure to mask that QIO_CHANNEL_WRITE_FLAG_ZERO_COPY flag in a multifd
> send thread if the data being sent is device state.
> 
> Fixes: 0525b91a0b99 ("migration/multifd: Device state transfer support - send side")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

queued, thanks.

-- 
Peter Xu


