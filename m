Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF6CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTa4-0001KO-2U; Wed, 27 Mar 2024 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rpTa2-0001K8-Ke
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:44:38 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rpTa0-0001I4-Qt
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:44:38 -0400
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-568c714a9c7so7906683a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711547075; x=1712151875;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jLz16fmiK7clzNfffXEiofOH4lXEAbKlwPA6/CgGe8Y=;
 b=GqJo0DZYAsiouB1zAm6fc7A52dgcLlEi2Od+VrIgTfivczHIS2nvBZevLNXmlf4KI4
 ymgFF/jVo8mYKQRydc6pSLLsoDKPGtIRhIKMwhKOjso8pqWzlBdna9XqsVE5IlYDQGgI
 /KKVLlYeWbQ8xay2nqdhEMKAs4lKvPIz1Gbf3bvp/TMSk80WO1Y8bo31jdQX/Ef8CPOb
 ia4o0f1EFIV0lzFhdhPG/4XF1jcH5LZ7UAAmZ44OsaJ3qJasv97iuog6CvoIRg3X03L0
 baqbsloXgOxszHqHRClQ6CfTvi0rHihKDwWjs3U4sbKLWuhY3BEmzkXZhxpfixVAP9WT
 voTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcsMfdfM22XdlxUd0vuWifbdwvMa9iuAB6UKyYES1cEzYeDdRXGbDKAgmh5GTtY/xknRDvBzMbnTT6pkalgOCP80keqg8=
X-Gm-Message-State: AOJu0YyaRo/KNofiESDBvojIAnDLupb7kOjX1NFjKehBbq+TBxsMJcLL
 l54DsAqVLZCHYWAz2VRdlbw6a44gvbopQhxwdF7LGtk7Oc6dxw2N
X-Google-Smtp-Source: AGHT+IHlsqprzpnxJBYeJapDRINLx/aNTv+m24jMPvBz9QGVUn18hEMdVfXDoR7rOZNE4m03xIbPbA==
X-Received: by 2002:a17:906:e08a:b0:a4d:fae7:ece3 with SMTP id
 gh10-20020a170906e08a00b00a4dfae7ece3mr2030643ejb.5.1711547074857; 
 Wed, 27 Mar 2024 06:44:34 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net.
 [2a03:2880:30ff:4::face:b00c]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170906670b00b00a44b90abb1dsm5439004ejp.110.2024.03.27.06.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 06:44:34 -0700 (PDT)
Date: Wed, 27 Mar 2024 06:44:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
 riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <ZgQivw8YG7XT2boy@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <20240326151911.2155689-2-leitao@debian.org>
 <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>
Received-SPF: pass client-ip=209.85.208.46;
 envelope-from=breno.debian@gmail.com; helo=mail-ed1-f46.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:27:58AM +0800, Heng Qi wrote:
> 
> 
> 在 2024/3/26 下午11:19, Breno Leitao 写道:
> > There is a bug when setting the RSS options in virtio_net that can break
> > the whole machine, getting the kernel into an infinite loop.
> > 
> > Running the following command in any QEMU virtual machine with virtionet
> > will reproduce this problem:
> > 
> >      # ethtool -X eth0  hfunc toeplitz
> > 
> > This is how the problem happens:
> > 
> > 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
> > 
> > 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
> > 
> > 3) virtnet_commit_rss_command() populates 4 entries for the rss
> > scatter-gather
> > 
> > 4) Since the command above does not have a key, then the last
> > scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > sg_buf_size = vi->rss_key_size;
> > 
> > 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> > with zero length, and do the following in virtqueue_map_desc() (QEMU
> > function):
> > 
> >    if (!sz) {
> >        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
> > 
> > 6) virtio_error() (also QEMU function) set the device as broken
> > 
> >      vdev->broken = true;
> > 
> > 7) Qemu bails out, and do not repond this crazy kernel.
> > 
> > 8) The kernel is waiting for the response to come back (function
> > virtnet_send_command())
> > 
> > 9) The kernel is waiting doing the following :
> > 
> >        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > 	     !virtqueue_is_broken(vi->cvq))
> > 	      cpu_relax();
> > 
> > 10) None of the following functions above is true, thus, the kernel
> > loops here forever. Keeping in mind that virtqueue_is_broken() does
> > not look at the qemu `vdev->broken`, so, it never realizes that the
> > vitio is broken at QEMU side.
> > 
> > Fix it by not sending RSS commands if the feature is not available in
> > the device.
> > 
> > Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> > Cc: stable@vger.kernel.org
> > Cc: qemu-devel@nongnu.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/net/virtio_net.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c640fdf28fc5..e6b0eaf08ac2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >   	struct virtnet_info *vi = netdev_priv(dev);
> >   	int i;
> > +	if (!vi->has_rss && !vi->has_rss_hash_report)
> > +		return -EOPNOTSUPP;
> > +
> 
> Why not make the second patch as the first, this seems to work better.

Sure, that works for me. Let me update it in v2.

