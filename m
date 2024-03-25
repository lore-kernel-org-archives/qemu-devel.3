Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CADC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 11:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roiT8-0000Wy-Ve; Mon, 25 Mar 2024 07:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1roiT6-0000RN-2m
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:26:20 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1roiT4-0000cD-AS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:26:19 -0400
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a468004667aso574313366b.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 04:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711365974; x=1711970774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8xMo+ECbJhP9I1J07PU9s5GaROGSCtTuRVYRDOh6X4=;
 b=qLIOogV6YbwsxRRt7AFitYaCBA9JuA5h7lKCEvL/T9xe0lRxUDnNtD0EnxOqnjLhyi
 lCUY2CJFHWC8yoiZn/1zzV6BVEmDS5/FSOCjKRvu8IIGEnd54kPGfdkyVp+uiryKbOvN
 OZlpry0nBD9aXdeBKyxBJR5p0LB7AQKhXlNcUySy9p34xLscaTto3gDa7ecnrVofGP39
 3i7ulIdjKzkgf0B0boU7OIxkrvax9q0L9RH6gG60NcjYWXNor+7Ri9u0mzf03fSaFTJh
 NHS4WtzDeABjky41zf342mkoV3IWcI8wV3vqMnNbUbtlcSv3NjkOk6vbo2rwlZ28PdLC
 q9wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh36TxmHc3nX9cTRraE3hkCkX0Vra5FgzHkbGTFis8hsXO2zo1gTrloqEpJkJcB+XkJe/v3ziBWKT6SQQUaibspFoiTvo=
X-Gm-Message-State: AOJu0YxxyF+GpNNR5BHqGxXetQa7wZ5Sc2W4XDq7/vTjALeFC45TSoUT
 gfjnJPgIU7HJNMT32bNv4y/RmegyN+tz4C147UCxhCVaeDO8SWo1
X-Google-Smtp-Source: AGHT+IFVtAuh0n4hICbWoDkom2iJ19P3TnM/NDfUNwYKnNpFz8nYX6QB+QDMtptvYVGfEvJDgAjrSQ==
X-Received: by 2002:a17:906:338c:b0:a46:f3cc:ccab with SMTP id
 v12-20020a170906338c00b00a46f3ccccabmr4396891eja.4.1711365974117; 
 Mon, 25 Mar 2024 04:26:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net.
 [2a03:2880:30ff:8::face:b00c]) by smtp.gmail.com with ESMTPSA id
 kh12-20020a170906f80c00b00a413d1eda4bsm2928231ejb.87.2024.03.25.04.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 04:26:13 -0700 (PDT)
Date: Mon, 25 Mar 2024 04:26:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Message-ID: <ZgFfUHQhMdAWixqB@gmail.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
 <Zf1bofzE4x0wGEm+@gmail.com>
 <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>
Received-SPF: pass client-ip=209.85.218.42;
 envelope-from=breno.debian@gmail.com; helo=mail-ej1-f42.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Xuan,

On Mon, Mar 25, 2024 at 01:57:53PM +0800, Xuan Zhuo wrote:
> On Fri, 22 Mar 2024 03:21:21 -0700, Breno Leitao <leitao@debian.org> wrote:
> > Hello Xuan,
> >
> > On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> > > On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
> >
> > > > 4) Since the command above does not have a key, then the last
> > > >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > > >     sg_buf_size = vi->rss_key_size;
> > >
> > >
> > >
> > > 	if (vi->has_rss || vi->has_rss_hash_report) {
> > > 		vi->rss_indir_table_size =
> > > 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > > 				rss_max_indirection_table_length));
> > > 		vi->rss_key_size =
> > > 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> > >
> > > 		vi->rss_hash_types_supported =
> > > 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > > 		vi->rss_hash_types_supported &=
> > > 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > > 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > > 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> > >
> > > 		dev->hw_features |= NETIF_F_RXHASH;
> > > 	}
> > >
> > >
> > > vi->rss_key_size is initiated here, I wonder if there is something wrong?
> >
> > Not really, the code above is never executed (in my machines). This is
> > because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.
> >
> > Looking further, vdev does not have the VIRTIO_NET_F_RSS and
> > VIRTIO_NET_F_HASH_REPORT features.
> >
> > Also, when I run `ethtool -x`, I got:
> >
> > 	# ethtool  -x eth0
> > 	RX flow hash indirection table for eth0 with 1 RX ring(s):
> > 	Operation not supported
> > 	RSS hash key:
> > 	Operation not supported
> > 	RSS hash function:
> > 	    toeplitz: on
> > 	    xor: off
> > 	    crc32: off
> 
> 
> The spec saies:
> 	Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it
> 	supports only one pair of virtqueues, it MUST support at least one of
> 	commands of VIRTIO_NET_CTRL_MQ class to configure reported hash
> 	parameters:
> 
> 	If the device offers VIRTIO_NET_F_RSS, it MUST support
> 	VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per 5.1.6.5.7.1.
> 
> 	Otherwise the device MUST support VIRTIO_NET_CTRL_MQ_HASH_CONFIG command
> 	per 5.1.6.5.6.4.
> 
> 
> So if we have not anyone of `vi->has_rss` and `vi->has_rss_hash_report`,
> we should return from virtnet_set_rxfh directly.

Makes sense. Although it is not clear to me how vi->has_rss_hash_report
is related here, but, I am convinced that we shouldn't do any RSS
operation if the device doesn't have the RSS feature, i.e, vi->has_rss
is false.

That said, I am thinking about something like this. How does it sound?

	diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
	index 5a7700b103f8..8c1ad7361cf2 100644
	--- a/drivers/net/virtio_net.c
	+++ b/drivers/net/virtio_net.c
	@@ -3780,6 +3780,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
		struct virtnet_info *vi = netdev_priv(dev);
		int i;
	 
	+	if (!vi->has_rss)
	+		return -EOPNOTSUPP;
	+
		if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
		    rxfh->hfunc != ETH_RSS_HASH_TOP)
			return -EOPNOTSUPP;

Thanks!

