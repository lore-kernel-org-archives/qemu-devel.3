Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6893C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnc1j-0006vF-KP; Fri, 22 Mar 2024 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rnc1g-0006uy-Bl
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:21:28 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rnc1e-0007xI-T2
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:21:28 -0400
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a470d7f77eeso229831566b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711102885; x=1711707685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGqjI6P0mTPBiKZTNOwbVNYIjw9Vw14Zd3G3C6QS6wY=;
 b=t2ya8eKZJFzjVcYcgv+lMfHt9zUKTem+TDhce6g2taVV00ZeCtZYq7DF/HlNE7+5KO
 m4q8JkT79oscs85/TVNlly4bvWLmRKdJuZ6THPBJ2AzlLnDT8lvT3aPjp1vLGSLYK/kC
 9m/OaGjh3tBCPM76gUSEw8y0olAp1tLdZCQGe6n/JA4S7kXfiRb8lnqXwnrUqBpx3Ovn
 /MujNTMHqhhgLjEo61SMPJQDKs9wg4RPPsGOR/Up4c7w3/9ie8ElMJQ+T+pEO6KNZ8CJ
 QMFVIsq1w3IknK5mY8d9aZBl/I2qpCZpwPl0ei1fsJ1t+VqXq2adnmmoQTEGdpO2krPX
 zj5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ADY1ywoqSnfDEHkL2XUcMoixtLVE5g+1/MMfRIvsBwcmp6Utf+UessTU5fj83gKwXSYwsa4ImszAg0ljIfm84FKQ+Tk=
X-Gm-Message-State: AOJu0Yz8w2xSWTn4ERmzwY3XnvUaEaZXVHpSwY/AkvyMJr+et8rSE2/Y
 HfKVSqJMFP8lNfw8Yym0S8xDwTnv1dVcoS8osVPJFhzmMnXpegbX
X-Google-Smtp-Source: AGHT+IGEXDCR4iq9rvwz5B26z4GLijSPqxuBAhYB8+zqYJlK7HGPtfYNr6wzSSm9SN6zugWqLIWZmg==
X-Received: by 2002:a17:907:7e94:b0:a47:3527:90c0 with SMTP id
 qb20-20020a1709077e9400b00a47352790c0mr673262ejc.14.1711102884800; 
 Fri, 22 Mar 2024 03:21:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net.
 [2a03:2880:30ff:4::face:b00c]) by smtp.gmail.com with ESMTPSA id
 bo10-20020a170906d04a00b00a4728151908sm705505ejb.93.2024.03.22.03.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 03:21:24 -0700 (PDT)
Date: Fri, 22 Mar 2024 03:21:21 -0700
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
Message-ID: <Zf1bofzE4x0wGEm+@gmail.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
Received-SPF: pass client-ip=209.85.218.52;
 envelope-from=breno.debian@gmail.com; helo=mail-ej1-f52.google.com
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

On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:

> > 4) Since the command above does not have a key, then the last
> >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> >     sg_buf_size = vi->rss_key_size;
> 
> 
> 
> 	if (vi->has_rss || vi->has_rss_hash_report) {
> 		vi->rss_indir_table_size =
> 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> 				rss_max_indirection_table_length));
> 		vi->rss_key_size =
> 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> 
> 		vi->rss_hash_types_supported =
> 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> 		vi->rss_hash_types_supported &=
> 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> 
> 		dev->hw_features |= NETIF_F_RXHASH;
> 	}
> 
> 
> vi->rss_key_size is initiated here, I wonder if there is something wrong?

Not really, the code above is never executed (in my machines). This is
because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.

Looking further, vdev does not have the VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT features.

Also, when I run `ethtool -x`, I got:

	# ethtool  -x eth0
	RX flow hash indirection table for eth0 with 1 RX ring(s):
	Operation not supported
	RSS hash key:
	Operation not supported
	RSS hash function:
	    toeplitz: on
	    xor: off
	    crc32: off

