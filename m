Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC5606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aTVT5gKq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hsKbvj7S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZku-00040N-D9; Thu, 12 Nov 2026 13:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xRZkr-000400-BN
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xRZkp-0002qU-CR
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794508953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3++6SSdAWARjbTLG3hk+lQQ7aiEgqNJA3N4D+HfgX0=;
 b=aTVT5gKqoFT+9mxuodV+9EBFchlIpNOuTy6qSNV91LWBhhrK1miFrlJh8ak0dd/R1ySQ/v
 PEnYa23zMZ4pQrD/HPeNG0j6o9JCGibSVGgmigTNP5CkI2tpn5D7Nefas6JcWCXx5Lu9wR
 yH/P8LlhZ+6nAKOMVg6CpA17/0l8vY4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-OImyIn6hNLuPBhzrE5oC9A-1; Thu, 12 Nov 2026 13:42:31 -0500
X-MC-Unique: OImyIn6hNLuPBhzrE5oC9A-1
X-Mimecast-MFC-AGG-ID: OImyIn6hNLuPBhzrE5oC9A_1794508951
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b17b31c3beso54940a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794508951; x=1795113751; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A3++6SSdAWARjbTLG3hk+lQQ7aiEgqNJA3N4D+HfgX0=;
 b=hsKbvj7St/PA5pi7l7SwpcmC6Pxa+nJohUXgqIFAj7GCDhRpXHj4VgM5U4qrP6/pjZ
 GTDPoESjsurMOzS76Re9c6aoHo0PDWz0hrdNwT9UOdKbX+6xIRfFLEhaPBueclQhdTbO
 eTGBSC/rBXBgbpY5l1zo+NgcgjTZvEPCNnB/uVXJI3HXtLb0iKwvnQq0KLbZPOQXGo4W
 9RLiXV3KKYw7gEEbvLsFjMrOkM0AO0RDjQ21Reo2jtHVLzg2xzXGnsbb8CIY4kSnYxRE
 MWsLmnvv6dOuVfsTRtFZ7GGw3hvPx9KadC03gymNry1ZrnbHiwomBgFuSqjGxlfhgSqf
 iptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794508951; x=1795113751;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3++6SSdAWARjbTLG3hk+lQQ7aiEgqNJA3N4D+HfgX0=;
 b=YILxhq1LOVBPoG8yfParE5OmltL1G37O7lqYDfD8M28nrHt1UWLb5TVVU1FQHUYVOl
 aQZiWm+P41tHILlgytCZDhTy/gLPiwEBxkznFfmoyVhN4NfwzdhPPpQypD+RRcbTllxr
 vqzKrklBfJu7r2fXqpR7PfUTsGCY8LNlqzDGxc3FdGo6ZaLg0ydWNKDS0i5SS+fIXZYy
 JrpOKxrxpcLA4929HJaCaL1j78enuNYu9BsEZKmU6ZVmppaf/QlnYQaJJYH/03Jm4nPV
 289QfbmHq33yPytO0BL40Ai33iIYyw0tSkVqO/lcC4gET2yCESCBdLPCVycJwJJ/lge5
 QH2Q==
X-Gm-Message-State: APuU4Z/YLO8uW5BKXNQv/TSP4S9fHahWKYrDBzEpbTzoIH4eua9pSz5C
 EWztfJ1QIrZLV/FP6EyQ3zYiS8pwt6Mmlg0/zjmII7q4IBES1BFOvCIXI6h3CrTsnhoZ3yrJk2o
 DEO1KZ3kT4vwVc2AVbeWAd1CRltaT4qs1+BlFzjvnZn5cUpL3Mwr75UW+
X-Gm-Gg: AYBFou3oOUgER90Grml9dDv9J4qCR7wftA6FqhBELpSu/mCr1XKw3BMR+8DCAPnJuaT
 GYbE4zJxCx96bj8f0oy4AR8TE1YI3q7O7cKPVN6jLyW/6RgQU8PcUbg2z3jMxIoUHxcIDWdBBVt
 LAHxPtBiW3N8E9cxEfCpWtzU02NPXMCSeyM01Pd77QyRvZtrU6sfX/mbNF6f/O9nKYURXI2faR9
 5lxCUZ08FjiRvRTZ0WyXXxoz/FAZD/MeZsfRzm2uFzZJM5a2TKQjrEljQQcTwODrFNrKlDygLaQ
 sLQSKVVlyPl7wZtwSluvy7TKG7SPEbPqWK161h+TPc0gea5ovfQO0SY58PBTbuM470ahruEtXI0
 hI0G3dPsqt2uLOWWCCI9b4V9OBrShqhBGapGceoyNzafZsOTqVx2n
X-Received: by 2002:a17:90b:3c83:b0:3ac:a993:5b5c with SMTP id
 98e67ed59e1d1-3b1b081b573mr654a91.6.1794508950619; 
 Thu, 12 Nov 2026 10:42:30 -0800 (PST)
X-Received: by 2002:a17:90b:3c83:b0:3ac:a993:5b5c with SMTP id
 98e67ed59e1d1-3b1b081b573mr637a91.6.1794508950030; 
 Thu, 12 Nov 2026 10:42:30 -0800 (PST)
Received: from sgarzare-redhat ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1ae981c55sm584343a91.1.2026.11.12.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:42:29 -0800 (PST)
Date: Thu, 12 Nov 2026 19:42:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Lucido <simonlucido@meta.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 vhost-user@lists.linux.dev
Subject: Re: [PATCH] libvhost-user: return the backend address in SET_MEM_TABLE
Message-ID: <avYHUgnTmWUiA1Qy@sgarzare-redhat>
References: <20261109-setmemtable-fix-v1-1-00fa83a0c6fb@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261109-setmemtable-fix-v1-1-00fa83a0c6fb@meta.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 10:55:42PM +0100, Simon Lucido wrote:
>During postcopy, the vhost-user backend ought to return the base address
>at which they mapped regions during SET_MEM_TABLE and ADD_MEM_REG calls
>[0]. This was done properly for ADD_MEM_REG, but not for SET_MEM_TABLE,
>so any frontend that was relying on that call would not work.
>
>QEMU wasn't affected as it uses ADD_MEM_REG, but any combination of a
>frontend that uses SET_MEM_TABLE and libvhost-user backend is.
>
>[0]: https://gitlab.com/qemu-project/qemu/-/blob/144393da8d4bd307a22525c7feea2bb29a0a7556/docs/interop/vhost-user.rst#L1263
>
>Fixes: d288eef3a0a8 ("libvhost-user: fix -Waddress-of-packed-member")

IMO the commit message should explain a bit better why that commit 
introduced the bug. I spent some time to understand the relationship, 
that IIUC is because from that commit we are using a local copy of 
VhostUserMemory.

The patch LGTM.

Thanks,
Stefano

>Signed-off-by: Simon Lucido <simonlucido@meta.com>
>---
> subprojects/libvhost-user/libvhost-user.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>index 52817cc733d..df215810339 100644
>--- a/subprojects/libvhost-user/libvhost-user.c
>+++ b/subprojects/libvhost-user/libvhost-user.c
>@@ -1119,6 +1119,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>
>     if (dev->postcopy_listening) {
>         /* Send the message back to qemu with the addresses filled in */
>+        vmsg->payload.memory = m;
>         vmsg->fd_num = 0;
>         if (!vu_send_reply(dev, dev->sock, vmsg)) {
>             vu_panic(dev, "failed to respond to set-mem-table for postcopy");
>
>---
>base-commit: 144393da8d4bd307a22525c7feea2bb29a0a7556
>change-id: 20261109-setmemtable-fix-d9841f2d0eb7
>
>Best regards,
>--
>Simon Lucido <simonlucido@meta.com>
>


