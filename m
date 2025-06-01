Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ABCC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 10:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLg5S-0002yF-SA; Sun, 01 Jun 2025 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLg5R-0002xW-7i
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 06:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLg5O-00024Z-WF
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 06:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748774315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=saFRGIx6J4DcvCD97jSTzwKWGLimGJdMbZK5gBiknxA=;
 b=hrGanSMXv0Mg3+26pltHV4qUZWvNe/r3mCsSfYjYkZAwrLEF8Yb13GtudcETFxU3kmIowf
 QRXjEbUpzgOrYXu6K1PM/HlZ2Q9nleUANBrCBJP5cM0wtOiMoMKABHxHrfD38hYdjJPFRM
 YdHtmyS7tl3AlWmK+asFlZMYc5t3S20=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-Rzm549qmNIGJ9pyxw5N9Bg-1; Sun, 01 Jun 2025 06:38:33 -0400
X-MC-Unique: Rzm549qmNIGJ9pyxw5N9Bg-1
X-Mimecast-MFC-AGG-ID: Rzm549qmNIGJ9pyxw5N9Bg_1748774312
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso1619403f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 03:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748774312; x=1749379112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saFRGIx6J4DcvCD97jSTzwKWGLimGJdMbZK5gBiknxA=;
 b=QRg5xUXIi2PPcEYQ/Gk7+FqPu07qijgBUe1xT8LUyMbLo3PiAlwGuaUajwqWPHoD+F
 JwS6mFJRETeWJOp20R/Gkof9FmvQ5z+tMJ02liZ+x7wL+toxH4Km+iRf0NkB8rXjtAQI
 /8Ndt//GkGQCfXtM4BuM3WacJvZrtPOOAhXgsPvXbLhkSRenl7c3ePpzOVKgKLnFcYt9
 03P5c9zitWQHZwPzQX4hqh3Ov6KE9DdNJZ1QKp15Mrln32mw3e3OD3Q/xvCSRzkSAFoB
 xzeVG5MJ+iM1kHystBNwBJhdSg5TWaXvVm1M4c9w3wTmd2PZiVvGR22Zf42/27sQQUHJ
 4u3g==
X-Gm-Message-State: AOJu0YwjepAo8d9BBW9xVgiUj6+8DClju6s//J0mV20e5Nng2RG14A/Y
 W08Xk07deXkNkVJ2Pm12IdhMRdSyZfhP4gv9YRg20M56CDPDRIwlBN5kZ7psRQ5jvhRgDEz+DPs
 bf9jx2dMixhlIK/mY6w32NF9MB76VpEjfk14vH+lA3/bPx9y9jJZeuodV
X-Gm-Gg: ASbGnctms7cEmctgic00U3TjUrqrPoez5wSBktBcMmyGX+W3dv3psC1xmE58rt6oE1+
 7E9k6+ro1CPuZUUHwIkpdQMIsNiZ3OH5uObbJplx/Mrf2M3Mg38IQnqUbCC5Y/AZ2qM54NESXIa
 Pe4YDHk97aLBYuCXh6ncFT4SXU+WpElblwHtwnpp+9DFZPSukJQXniqMuqPx+EeXYuRhMNCYtXN
 8Y4Rde1yOmapBFEG2aMiCjfuaxx1jIxL3dabmWpGllM5FqgI7U8v/eF8HQ7Xgq15cRH1Ty/rS5z
 45k7Xg==
X-Received: by 2002:a05:600c:35c2:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-4511edf0aa8mr34600635e9.23.1748774312341; 
 Sun, 01 Jun 2025 03:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrCk1r+eXO3pTVrXT2hfHkXRl7fak4f/Q2dyXFdT9qsaCJQwwRirxv0cVT4r6iyeFcV4kI1w==
X-Received: by 2002:a05:600c:35c2:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-4511edf0aa8mr34600465e9.23.1748774311840; 
 Sun, 01 Jun 2025 03:38:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972d9sm11404300f8f.64.2025.06.01.03.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 03:38:30 -0700 (PDT)
Date: Sun, 1 Jun 2025 06:38:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, devel@daynix.com
Subject: Re: [PATCH v2] virtio-net: Fix the interpretation of max_tx_vq
Message-ID: <20250601063712-mutt-send-email-mst@kernel.org>
References: <20250322-vq-v2-1-cee0aafe6404@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-vq-v2-1-cee0aafe6404@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Mar 22, 2025 at 03:47:17PM +0900, Akihiko Odaki wrote:
> virtio-net uses the max_tx_vq field of struct virtio_net_rss_config to
> determine the number of queue pairs and emits an error message saying
> "Can't get queue_pairs". However, the field tells only about tx.
> 
> Examine unclassified_queue and indirection_table to determine the number
> of queues required for rx, and correct the name of field in the error
> message, clarifying its correct semantics.
> 
> Fixes: 590790297c0d ("virtio-net: implement RSS configuration command")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---


Breaks CI:


https://gitlab.com/mstredhat/qemu/-/jobs/10199709161


../hw/net/virtio-net.c:1463:48: error: taking address of packed member 'us' of class or structure 'struct (unnamed at ../hw/net/virtio-net.c:1392:5)' may result in an unaligned pointer value [-Werror,-Waddress-of-packed-member]
 1463 |         queue_pairs = MAX(virtio_lduw_p(vdev, &temp.us),
      |                                                ^~~~~~~
../include/qemu/osdep.h:419:19: note: expanded from macro 'MAX'
  419 |     MAX_INTERNAL((a), (b), MAKE_IDENTIFIER(_a), MAKE_IDENTIFIER(_b))
      |                   ^
../include/qemu/osdep.h:414:21: note: expanded from macro 'MAX_INTERNAL'
  414 |         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
      |                     ^
1 error generated.



> Changes in v2:
> - Handled unclassified_queue too.
> - Added a Fixes: tag.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250321-vq-v1-1-6d6d285e5cbc@daynix.com
> ---
>  hw/net/virtio-net.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadffe1..afc6b82f13c9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1450,23 +1450,29 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
>          err_value = (uint32_t)s;
>          goto error;
>      }
> -    for (i = 0; i < n->rss_data.indirections_len; ++i) {
> -        uint16_t val = n->rss_data.indirections_table[i];
> -        n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
> -    }
>      offset += size_get;
>      size_get = sizeof(temp);
>      s = iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
>      if (s != size_get) {
> -        err_msg = "Can't get queue_pairs";
> +        err_msg = "Can't get max_tx_vq";
>          err_value = (uint32_t)s;
>          goto error;
>      }
> -    queue_pairs = do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_queue_pairs;
> -    if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
> -        err_msg = "Invalid number of queue_pairs";
> -        err_value = queue_pairs;
> -        goto error;
> +    if (do_rss) {
> +        queue_pairs = MAX(virtio_lduw_p(vdev, &temp.us),
> +                          n->rss_data.default_queue);
> +        for (i = 0; i < n->rss_data.indirections_len; ++i) {
> +            uint16_t val = n->rss_data.indirections_table[i];
> +            n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
> +            queue_pairs = MAX(queue_pairs, n->rss_data.indirections_table[i]);
> +        }
> +        if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
> +            err_msg = "Invalid number of queue_pairs";
> +            err_value = queue_pairs;
> +            goto error;
> +        }
> +    } else {
> +        queue_pairs = n->curr_queue_pairs;
>      }
>      if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>          err_msg = "Invalid key size";
> 
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250321-vq-87aff4f531bf
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


