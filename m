Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA9606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GHkQNMT6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iF5kvm8G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbfX-0002hB-32; Sun, 01 Nov 2026 14:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xNbfV-0002gy-IZ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xNbfT-0004lY-0e
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793562995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ML78OHYtEkQxsCDcsEP/xECu4U2ijp66h7F5yN134g4=;
 b=GHkQNMT6UelINr9LcHPUf7OBF7GaXtqBhrRzJ7VRl1Gg/Mn8rUA3Uane/8L/8rhXVuVYYm
 xFdC7E9dG0zAxXcC1IeSWVv5LE9C9P8hVfxHenH4aZMjTahhzs9aEaXE5s6h5ZqIV86Xt3
 W2/zf5KA379+hcJxryJzqMb1PlZGlc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-JgLRh_iwOSqQpzeN_jphWQ-1; Sun, 01 Nov 2026 14:56:34 -0500
X-MC-Unique: JgLRh_iwOSqQpzeN_jphWQ-1
X-Mimecast-MFC-AGG-ID: JgLRh_iwOSqQpzeN_jphWQ_1793562993
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so2086245f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793562993; x=1794167793; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ML78OHYtEkQxsCDcsEP/xECu4U2ijp66h7F5yN134g4=;
 b=iF5kvm8GcBpoIs7Sgroq2NVAu73TMVsXJBH0qsJH0BiJAEOws3Rj7Nii1RKg6GWsYA
 el8mL3gq55LgkZ04j/UpLuAKvIbShl9rXVQIdcf2Eq/tnCmi89SnY/ntRZkAuZ6CpO/G
 qX6E+YZZED1Rqbtg0cEY949wng+xjeNy5N4yo+NRCPilTiYyfG0cE1Nn+FYChwp+1tbZ
 ZHp/EMzn18Eby1VCQEG7GdSc1e5duQ2/b5wlbNQUYg4Y2xbwf7m5OVHxzQTomBJpnGwv
 FBgxa2d81EpnBWrmHwAKpRWO2P6Z/u5Be2yX/ycJYrEM2LUvwNdXN7XjH6VJRYDmOsy+
 U/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793562993; x=1794167793;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ML78OHYtEkQxsCDcsEP/xECu4U2ijp66h7F5yN134g4=;
 b=ih4D/AQJan2CIHzxEUoGZRjlybdebDk60ft62/ZuRarc7jcYxrP3+FCSnV61sdkkpH
 rL0Zrg0lrSz5vDyzQDOmi4xz1iLl84BtobaGjDU75nJWnT62AREWK7fTD6KmWLCCni8U
 wZN/hu4Cdl1Avwr04d91qjGrTpP2Y53mY+N1Yo/JLk+BP2vuPfZMjQyT5sHaEWTaQp7O
 +MtF2EgFATAHgnoYuXKBvppTYPoEl3JxCQ8og6vrRlnLvsvbzxr6m+oJtqQP7BQ5RjAc
 xuEPe6wPgCeLDcEbvc2J75AeO8y3HVjrDs19FbMAHVXB6wxy6jv8A3HaGYvTCSAMS/no
 C41g==
X-Gm-Message-State: APuU4Z/GPEEtK3aMzO1WCCsGbJef2s7X9KXmcSuFnkTMhkFd7DsVme1H
 o+7iWvsCOUWCefR44CGxPOcByldX9NejCBFEoqVnQPv2vVJJp7IW90jTOlvuPBxnNOalfOdcs12
 AMsdWjrMw60SSoJTzW1Rmtyu3gNAlWLBCdSIkVU2oTKY10YIwBl91XPNO
X-Gm-Gg: AYBFou1zQZ9qeCZkUmlWx5dnJloAH2B36f5MlWUctLKSS8Do+B19xee/1EysCd6Drf4
 M9qN/Mn2cyOTfMkqeI+4HCLgrdKWGYlKGvh0Xn/iIc8WjwpEfzb+tChbV/sIksV9cKxjKpEiZwM
 frNhsrgcRkRINo6k4t6aTbU8UU0HAiNvSwqY/ULbfZ22uGN4U+Ht8V/uHgSxnRiXCrOdRU3pFwx
 nyP2/cs+ReUDfTXHnyJk4wOgW+zp65dfm7j041WMtGFN+Fqdv7m8otbxgxJa6sTbD61T8VnKLdL
 Wkl26cWAvhu7kniXg8CwHGgU3ceAFME8cOmPY8htzLlMpWE6cRHKDVFJl7hWjWE92Ugrnz8WXO/
 bCV96jV4bpWadLWmDR2psUKleFr+YDeEe+g8D9i7wwg==
X-Received: by 2002:a05:6000:200e:b0:48c:466e:9d08 with SMTP id
 ffacd0b85a97d-48e6e50ab18mr18044092f8f.43.1793562993010; 
 Sun, 01 Nov 2026 11:56:33 -0800 (PST)
X-Received: by 2002:a05:6000:200e:b0:48c:466e:9d08 with SMTP id
 ffacd0b85a97d-48e6e50ab18mr18044064f8f.43.1793562992481; 
 Sun, 01 Nov 2026 11:56:32 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm14248471f8f.59.2026.11.01.11.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 11:56:31 -0800 (PST)
Date: Sun, 1 Nov 2026 14:56:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tan Chi <tanchi25@mails.ucas.ac.cn>
Cc: qemu-devel@nongnu.org, jasowangio@gmail.com
Subject: Re: [PATCH] hw/net/virtio-net: skip automatic zero-init of TX iovec
 arrays
Message-ID: <20261101145557-mutt-send-email-mst@kernel.org>
References: <20261101151038.164841-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101151038.164841-1-tanchi25@mails.ucas.ac.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Nov 01, 2026 at 11:10:38PM +0800, Tan Chi wrote:
> virtio_net_flush_tx() has two large iovec arrays that are populated
> as needed. Entries are initialized explicitly or through iov_copy(),
> and out_num bounds the entries subsequently consumed through out_sg.
> Zero-initializing the entire arrays is therefore unnecessary.
> 
> Similar arrays in virtio_net_receive_rcu() already use
> QEMU_UNINITIALIZED to avoid automatic zero-initialization overhead.
> Apply the same optimization to the TX path.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>

Any optimizations should come with perf testing numbers showing the
performance gains.

> ---
>  hw/net/virtio-net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 54e42cfec9..76e3281831 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2783,7 +2783,9 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>      for (;;) {
>          ssize_t ret;
>          unsigned int out_num;
> -        struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
> +        QEMU_UNINITIALIZED struct iovec sg[VIRTQUEUE_MAX_SIZE];
> +        QEMU_UNINITIALIZED struct iovec sg2[VIRTQUEUE_MAX_SIZE + 1];
> +        struct iovec *out_sg;
>          struct virtio_net_hdr vhdr;
>  
>          elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
> -- 
> 2.53.0


