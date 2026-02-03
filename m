Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050CDE8784C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 17:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnKGk-0003bC-Iz; Tue, 03 Feb 2026 12:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnKGB-0003Tu-Qi
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnKG5-0007T3-OM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770139928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nV1QEexHhULTt9lndN8UjP2uphSwtHjKv3xbuHKA1OU=;
 b=Nu/1QxVc6xkDvtaWLSQI5TpjFb+jRfJwus4F0S2Eap6EsMKjmxJ1j4wOoYlaLuhIchKixT
 +Lb8GNAs25B5BFSTxE9Q0FwlhqpUMSHGgcAQdABgCGubw6W67SdgqRYG8qUqlYfTfX7Qky
 cZvUbzdReHhB0PojN+9sL85CYhp1KOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-FFmjUgBnOxyHPLKxD9wC9w-1; Tue, 03 Feb 2026 12:32:07 -0500
X-MC-Unique: FFmjUgBnOxyHPLKxD9wC9w-1
X-Mimecast-MFC-AGG-ID: FFmjUgBnOxyHPLKxD9wC9w_1770139927
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48057c39931so64241455e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770139926; x=1770744726; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nV1QEexHhULTt9lndN8UjP2uphSwtHjKv3xbuHKA1OU=;
 b=GRA8uMlJl06xnfn7xuaTTB0L2GMHWUJBJcclAd2SSkLTZ/TAVSHvjghx1tVOulZjD1
 mvnMMy2Kvj38KHGt0DlUsBy87ynBwDNoyapf2xUC3x2xyXWOOAnxoFiqjYhHMH6+G0R+
 gMcLSnurpvc6DiG8UdqZB07d5uyBg0miYPRAmS3s0iGpU/cIrGt59lm8YFxr2dhERbDw
 PDUZQJh6YBEsb+BjefpqEfz8/AlDzpWBOQUCsGASlb6EPUVHtSrgq5Wbt5fZG88/44U5
 RjnUOoa4S1RVRkaXbqPL1+dwFHkz9aaV5stO0KyKoH+xjbYKDZAjTYYBY1+xUGXAWK4K
 H2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770139926; x=1770744726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nV1QEexHhULTt9lndN8UjP2uphSwtHjKv3xbuHKA1OU=;
 b=YgQodx1YFP7oUULIOBM2iCELRvh/LMYHJgbDy1SMuUlAQQ9cg8O4HldKyHfDGhf/BP
 mpu/WAujvhoYJ/9Kr1EwkMZhE/CoVh71oGfDs+X0EuwAZ2R+TTjkTTGioEakjxoTpc1r
 CcxmQI2/J6lvvh2YJIC37mHoaN0w+zZmL56M52Dbr02o1YJpVTH4JMUnG6iqpw0DrPyT
 GeyyiF1RhKruMTV0OD794fFny3sgAfH/iqPskLSHBVGqcMD9HEkbgKKKV7Mt5hYgnmNj
 4utVZbBdfDbPYJ19RO77f+/hU8WLsCXj1R+p1s16XaV5JEUTBXLOTcEjpnYDLNNc8fnS
 jzEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0di/gt7rchRZTCBWNGe1ORrvJ2jiwT3KQ/gqC9vNDj8/QjtSX3gJIU4Nj6JvlrA9bSTPask5q2cl/@nongnu.org
X-Gm-Message-State: AOJu0Yzd6shUbXa1VGbJucPo0G2zsJvSge8pBaQ9s7RbP2FEWGkhzDq5
 zC2Vo6+QaEytsuqI2S0u0Ue3tIHdU2YUiIrL2wjSuTqfgvtbm2VSlYvrRuzFU6rx+i/Gq+SEYUn
 SCSu5MS3uz69mJWlRWCsh8YLuJdJR89KvEg19SWy2cFkjSpw7cvPCmaOA
X-Gm-Gg: AZuq6aKudxDp1lQRLczUDc0t4qkoDIaUGpYGxLkkq3fZz2mQ8xCpU4k+ULvvVvTDHyk
 iYDQ8+488C1Nt65YabD/u4xQ/kHUTXu/XNUvPbilIttJdEgY1hBXo/lafZRz4lO88WT/a/t0t17
 k4cQRb+QVk2v3d8u6gK3orP3JJ4dl5rDT0n9AvwZQSPptPwb5X9BLVa7RR/SUGcuZPJfZ2REWDn
 t7Yup/qUraUEVz1qKfAZj2O9K71jdWiUunfUnr5jCXHXrFm0mDMWW+UO9OGZ7+xYfP/xvXPZqe7
 Xj4T18c4fxQj3WWDtwH2NAtq39I5bHLnOTLaC0TrRT7JPyGOlL+RIXnrdcj7fD8E77AeJUGdNeG
 X7Q5H5gwO3xQESlhCk8kKnrpsvkVwcbXG2g==
X-Received: by 2002:a05:600c:3e0d:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-4830e96fb0cmr5089395e9.20.1770139926329; 
 Tue, 03 Feb 2026 09:32:06 -0800 (PST)
X-Received: by 2002:a05:600c:3e0d:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-4830e96fb0cmr5088945e9.20.1770139925795; 
 Tue, 03 Feb 2026 09:32:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830515381esm80484405e9.11.2026.02.03.09.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 09:32:05 -0800 (PST)
Date: Tue, 3 Feb 2026 12:32:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex@shazbot.org, clg@redhat.com, cohuck@redhat.com,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, kjaju@nvidia.com, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/4] hw/net/virtio-net: Adapt hash handling to updated
 UAPI
Message-ID: <20260203123143-mutt-send-email-mst@kernel.org>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-3-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113113754.1189-3-skolothumtho@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 13, 2026 at 11:37:52AM +0000, Shameer Kolothum wrote:
> The virtio_net_hdr_v1_hash layout changed in the Linux UAPI, replacing
> the 32-bit hash_value field with two 16-bit fields, hash_value_lo and
> hash_value_hi.
> 
> Update hash handling to populate the new fields correctly and adjust
> offset and size calculations accordingly.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>


Has to be squashed in patch 1 or bisect will be broken.

> ---
>  hw/net/virtio-net.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 317f1ad23b..512a7c02c9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1879,7 +1879,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
>                                               n->rss_data.runtime_hash_types);
>      if (net_hash_type > NetPktRssIpV6UdpEx) {
>          if (n->rss_data.populate_hash) {
> -            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
> +            hdr->hash_value_lo = VIRTIO_NET_HASH_REPORT_NONE;
> +            hdr->hash_value_hi = VIRTIO_NET_HASH_REPORT_NONE;
>              hdr->hash_report = 0;
>          }
>          return n->rss_data.redirect ? n->rss_data.default_queue : -1;
> @@ -1888,7 +1889,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
>      hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
>  
>      if (n->rss_data.populate_hash) {
> -        hdr->hash_value = hash;
> +        hdr->hash_value_lo = cpu_to_le16(hash & 0xffff);
> +        hdr->hash_value_hi = cpu_to_le16((hash >> 16) & 0xffff);
>          hdr->hash_report = reports[net_hash_type];
>      }
>  
> @@ -1990,10 +1992,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>  
>              receive_header(n, sg, elem->in_num, buf, size);
>              if (n->rss_data.populate_hash) {
> -                offset = offsetof(typeof(extra_hdr), hash_value);
> +                offset = offsetof(typeof(extra_hdr), hash_value_lo);
>                  iov_from_buf(sg, elem->in_num, offset,
>                               (char *)&extra_hdr + offset,
> -                             sizeof(extra_hdr.hash_value) +
> +                             sizeof(extra_hdr.hash_value_lo) +
> +                             sizeof(extra_hdr.hash_value_hi) +
>                               sizeof(extra_hdr.hash_report));
>              }
>              offset = n->host_hdr_len;
> -- 
> 2.43.0


