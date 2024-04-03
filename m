Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B0CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 12:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs07Q-00042n-Op; Wed, 03 Apr 2024 08:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rs07O-00042V-CR
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 08:53:30 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rs07M-0002yy-Hl
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 08:53:30 -0400
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a517a492055so22310366b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 05:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712148803; x=1712753603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4cj6vg+PLMD3bnAnC/7BKVkE+A86qwqaG5PcVTOt18=;
 b=j3gFZbmAFeLouKcoZ48PyCad2L7cg8HV2twDaOeEDbvSnoa17JjKQPZBSZy1GQoJKP
 YlqNQ2SJIwGQZN0EdBB48C/vqFrt6LGxP5s1RwPNvZsNeJpMRo5NjiX4bi8tww1PEkxX
 mG2WfjVCp8EMPmg94+hY5s8bXyJBIPgq2hxFiFd69x3Am1RRPWznfzo+lEK9zwMU288w
 qTnzagOjVS57RoMY/GJxXYMGpdBdPn49eJb7R2OtDn9vRl6YbkAWP89YUlRuJgdsJ8UB
 RLy0RKDrtnzdiXR3jE/1D0iPhMhNmhVo9aV1a2LKNM0TKd4e5L1DEYlMFEyb91lLJfnG
 BitQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEFcVN8wSd/ObnbPBu+wWiCYVpmSoF1igkSGEPSaJZP9GzIhzjWVMaJUtdVTXrY1AnKDzWF09Tk8Fz0/W4Sbx6Qtr3zQ4=
X-Gm-Message-State: AOJu0YybE+T4R2hYzRUcA2XgxmFBLRf5tZne3e1DGSP5RTiF6A89STZf
 vPr7C3WVE+osVJJHTS0dK8ZvnUbzonqqQK2ZOM+/b2FGC1ye/irG
X-Google-Smtp-Source: AGHT+IG/LZvkvkvKke8uVXcXbrYjZ9FSvr+Pm5+/tdlPUCoe15E1D9VDt24wooC2fGJfQa9Hdwxe2A==
X-Received: by 2002:a17:906:2284:b0:a4e:39f1:6374 with SMTP id
 p4-20020a170906228400b00a4e39f16374mr1812470eja.24.1712148803105; 
 Wed, 03 Apr 2024 05:53:23 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net.
 [2a03:2880:30ff:7::face:b00c]) by smtp.gmail.com with ESMTPSA id
 an3-20020a17090656c300b00a4e7c2b2070sm2694127ejc.8.2024.04.03.05.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:53:16 -0700 (PDT)
Date: Wed, 3 Apr 2024 05:53:12 -0700
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
 riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <Zg1ROBmnY0jaKvsf@gmail.com>
References: <20240329171641.366520-1-leitao@debian.org>
 <20240331160618-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=209.85.218.52;
 envelope-from=breno.debian@gmail.com; helo=mail-ej1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Sun, Mar 31, 2024 at 04:20:30PM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
> > @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  		return -EOPNOTSUPP;
> >  
> >  	if (rxfh->indir) {
> > +		if (!vi->has_rss)
> > +			return -EOPNOTSUPP;
> > +
> >  		for (i = 0; i < vi->rss_indir_table_size; ++i)
> >  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> > +		update = true;
> >  	}
> > -	if (rxfh->key)
> > +
> > +	if (rxfh->key) {
> > +		if (!vi->has_rss && !vi->has_rss_hash_report)
> > +			return -EOPNOTSUPP;
> 
> 
> What's the logic here? Is it || or &&? A comment can't hurt.

If txfh carries a key, then the device needs to has either has_rss or
has_rss_hash_report "features".

These are basically virtio features VIRTIO_NET_F_HASH_REPORT and
VIRTIO_NET_F_RSS that are set at virtio_probe.

I will add the comment and respin the series.

