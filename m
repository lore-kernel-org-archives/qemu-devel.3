Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A121606A335
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ByoRzxac;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FeZLZWRB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTx1F-0000o3-6M; Thu, 19 Nov 2026 02:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTx1D-0000nq-Ih
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTx1B-00006c-SS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795075036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OC+NrRRjpOgo6jyFR5o7PbtIaDMv9L0mTOdROv2E7Bc=;
 b=ByoRzxacj+E/UuO4IE3MZV85zHFf6mXPqlUj0JzNtetWsW6rYLjIA+x6WkD4M3pktB8VG8
 vRRTjpGtucYzmlvIiwq0Bn/DclxRVHRH/SN3+tpMwt1nUaNnLElulK28PIpOPtY0vk+cZR
 E5bkRpw24vZdo/KhY5QGRz/nZEFylKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-g3ZLoSfBNxiKPWmFy7iUNQ-1; Thu, 19 Nov 2026 02:57:14 -0500
X-MC-Unique: g3ZLoSfBNxiKPWmFy7iUNQ-1
X-Mimecast-MFC-AGG-ID: g3ZLoSfBNxiKPWmFy7iUNQ_1795075033
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a35e1d2dddso15309875e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 23:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795075033; x=1795679833; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OC+NrRRjpOgo6jyFR5o7PbtIaDMv9L0mTOdROv2E7Bc=;
 b=FeZLZWRBYQteqihgSm4ZdfuBBwxryohO1NPxEbHW9FurIVf8OSHg3S3ILm20j9M8df
 cZYYW8Gx4jGzb042hVkG6NJJvh031GwXmv56udekTCVuqfKrWEVjjBO19c1wIrn0Ozyb
 FSaf0/6GfIlkZPsSIv/5p3y7WcWkiLAKMZy6hcnXZrWteAhkklDqJ+izyhlDhb3mSQIk
 nbzaQYdskRoQuQNVTE6zuiVay9L2wcg4M2FTdztdI/FfD13a2+QxhBOIv9wkUwnJk06q
 7UsA4ygY5vam80mTKv6wynDoruPI7Iir2KlmG78MHCaZVvJBExTG9NXn209uuTSHNegq
 ai+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795075033; x=1795679833;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OC+NrRRjpOgo6jyFR5o7PbtIaDMv9L0mTOdROv2E7Bc=;
 b=VQADecB3iSWdYwbuCP2Pg0YmFV1OjBVI19jrCu287ABXm1Sx5a0MaUY2bTY5vLiYSo
 B6LFeCYL9OYL4V4kuBvivWO0B0rdyp1nJfjPqpdlinaaOROEGnMVcaF5fYjVG2cOHhE2
 W7suGu2tQ+F3n7pkZxZfB9gxdk2K3hPjn6d5bOP4oBqoF5dW6gOLjeFl2WlFdSCY/0dP
 GAZET1boFEE6ReIYA9GMzNDlvF7wquxHQRHDvnD9SKiSbVpDPgf6Ai1oA+ChEb+c1oL9
 uXM0twO3ysfJSmvVKJ4nYhEwuEGO1wUlZnTqKQ1sOyAh5CPLsr8zVSKNq10605AyP6bT
 sN5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGQmAgemMBGYn9gGRnvg7fZI4uiWSWjeMZeuXXP2WvwbBGFvRyCZvq1LfYJuQNx1xItExBjOWAIN9U9@nongnu.org
X-Gm-Message-State: APuU4Z/SCF9cle0V4EBbDEOpxQ2KH8mFLEwo9k3K1+EKvWCofmvRzb6v
 IzudZhTwAzkzLbRbDSQ7HUfCIx9dmqHl4y0crb+9AOuokYsoIrTJRB6tNZxWUpC05eZ6igCqQKt
 h1afrcNJTKiP6+h0sSUckQkFllUB+HCgRdXp2dQDbPMUxlYfhDurD93vn1IVfcI8i
X-Gm-Gg: AYBFou34POuJBhO57DmlYgXQf32PH/McHOulolCZm7UQOD8Yiv4BEhUvx7AL4fUF872
 tHKP+dLRZL/SZog5O4e3GjaihPOKuPKQW/RWssUS1E1YR9uDpBfXl1OPguFLRbNnVCZg31FQGdM
 33uFYVY+VUcEllHi0ERYGxDwVPPm/Npni3Edq1h28PycIP+xSA7sAMVxYcRrW6Rsn9ONM5huWfv
 0XlWnLgMQ+Aaq72wZMk1kQqe9EZwovMSiQpM+kjgw5uIyesCUWFnloy5Q0+l4r92ztToOF6xwRv
 uY9AaOaMg3gCc9fD+rfV5H+gMGgNdTb36d1muMN5yT0iokSv/6pAyhZBP8wP0aF4B94Atf5Qrhd
 Kt3dxfeosb7ZZD+By+Bwymj6waIqdMAhu7Q2j9ShVMLY=
X-Received: by 2002:a05:600c:4e02:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb7da4b889mr102655795e9.23.1795075033208; 
 Wed, 18 Nov 2026 23:57:13 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb7da4b889mr102655285e9.23.1795075032600; 
 Wed, 18 Nov 2026 23:57:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655f9f53dsm8399468f8f.35.2026.11.18.23.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 23:57:11 -0800 (PST)
Date: Thu, 19 Nov 2026 02:57:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/1] virtio-scsi: fix hot-plug event racing device realize
Message-ID: <20261119025646-mutt-send-email-mst@kernel.org>
References: <20261023162000.2796947-1-den@openvz.org>
 <805b4bb7-eb0e-477b-8ba6-9ba9f89e1f03@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <805b4bb7-eb0e-477b-8ba6-9ba9f89e1f03@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 08:53:44PM +0100, Denis V. Lunev wrote:
> On 10/23/26 18:19, Denis V. Lunev wrote:
> > This email originated from an IP that might not be authorized by the domain it was sent from.
> > Do not click links or open attachments unless it is an email you expected to receive.
> > A disk or CD-ROM hot-plugged into virtio-scsi sometimes never shows up
> > in the guest. QEMU has the device, the guest has consumed the RESCAN
> > event, and a manual bus rescan finds the LUN at once. We see this in CI
> > with Windows Server guests (vioscsi) and with Linux guests, always with
> > the controller on an iothread.
> >
> > The event is pushed from the plug() callback, before the device is
> > realized, and the iothread request path does not see unrealized devices
> > since 8ddf958e8d62. A guest that scans right away gets BAD_TARGET and
> > does not retry. The patch moves the event to a main-loop bottom half.
> > The alternative, letting the request path see a plugged but unrealized
> > device, would undo what 8ddf958e8d62 protects against.
> >
> > There is no test in the patch. The window lies inside a single
> > device_add under the BQL, and a qtest or iotests client is served by the
> > same main loop, so it cannot send a request in between. To reproduce, I
> > booted a Linux guest with virtio-scsi on an iothread, ran QEMU under gdb
> > in non-stop mode and stalled the main thread for 3 s in
> > scsi_bus_set_ua(), right after the event is pushed, then hot-plugged a
> > scsi-cd:
> >
> >   break scsi_bus_set_ua
> >   commands
> >     call (int)usleep(3000000)
> >     continue
> >   end
> >
> > Without the patch the guest never enumerated the LUN (3 of 3 runs).
> > With the patch the same stall falls after realize and the LUN appeared
> > every time (3 of 3). Without the stall both builds pass, which is why
> > this only shows up on loaded hosts. tests/qtest virtio-scsi passes.
> >
> > Every release since 5.2 has the bug, hence qemu-stable.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Fam Zheng <fam@euphon.net>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > Denis V. Lunev (1):
> >   virtio-scsi: fix hot-plug event racing device realize
> >
> >  hw/scsi/virtio-scsi.c | 38 +++++++++++++++++++++++++++-----------
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> >
> >
> > base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
> ping 

pong. I'm not applying patches I'm not CC'd on. Paolo, wanna take
a look?


