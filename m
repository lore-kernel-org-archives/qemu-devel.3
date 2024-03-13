Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6472C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMW8-0003pb-VE; Wed, 13 Mar 2024 07:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkMW7-0003nf-6Z
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkMW5-0002bM-I9
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710328284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pk8as5rYWyM7zG5+pi5cxZqilmp2BzK6GW+OvFg/vc=;
 b=GaUjzhnivzwfhr/HD5robtpIAJxU1NDRBfaJQh7XxnZt3hYmNpdMITuplxkbhc1bQZCHVJ
 iA4yMLR1b/rnSoSqrgLOnKAE9pv/AJ7lz1sA+zpiTjmLnaUTq0xlYucmQmhkLTRQhzde9J
 toDhi3IzliO67ac7u13aikZGaxB1bH4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101--hbB5ZM2P1moFHrg25W2Zw-1; Wed, 13 Mar 2024 07:11:23 -0400
X-MC-Unique: -hbB5ZM2P1moFHrg25W2Zw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d449d68bc3so22899371fa.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710328282; x=1710933082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pk8as5rYWyM7zG5+pi5cxZqilmp2BzK6GW+OvFg/vc=;
 b=QrNZIUzNirDZ9FvB3sBT0zmNIae9OLBlU6o6s5lQPoluWKMyNQO6lVPlhqx5jG36xM
 6Ox3z0fmZe2y7UHHScAxVaYy3JLILDpV8Q41nczrW4kAyhLU/zPehrLEa+qPOFD2BH3U
 PKKOwNL9UHrYfZNw9z1lAQp8MhCnBOgxJYMg2m9ZIN4htw1dpyo6TCbUGIFdp3CkUzg/
 1K6/fVGHXbYvUjB/7a+c22O68MrPEcCsq8ZYs98xuoe2os+9kp7k1pSxzaiPuV9VpXGn
 RDj6xJdcVf60t2sCX1fUeZnMvDxwWl3fxasKb55/8nhhAKPHmV0oGJvNCyfTxK+kMrU5
 fFFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFrsabxkYyARkoD/2zyN6wqCGnbcT/AsK3B80L/lz+nTuPBrQzT+4yXofP5liPRcfcZE/YQhmhxH1dNz4mgxv7qgfYc0M=
X-Gm-Message-State: AOJu0YxSKngkWVuc/woiu6Q1NDC/YmSJXM7SFcrYfvvjpfy7wZsxJ2yy
 vw3r1iseM0uvHSHb4yxMaHWKGKKvWT9FIy7bbtFA8OkKsPUdwF0AGvuAUpkzlFIObv3e9kVJLhF
 FEbEYKAufvhiRWi5HwtbK0O+QgdvUKRlH2TTFztw7BM6Rscjc1m0I
X-Received: by 2002:a2e:8902:0:b0:2d2:d252:7d07 with SMTP id
 d2-20020a2e8902000000b002d2d2527d07mr7984757lji.15.1710328281801; 
 Wed, 13 Mar 2024 04:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg8/wzU5B+gh73Atq6tU2yWnM6acrM+FpofbjYQLw6ZKgz8s2H4em0z3pLEXMqTUbRiYutvg==
X-Received: by 2002:a2e:8902:0:b0:2d2:d252:7d07 with SMTP id
 d2-20020a2e8902000000b002d2d2527d07mr7984731lji.15.1710328281195; 
 Wed, 13 Mar 2024 04:11:21 -0700 (PDT)
Received: from redhat.com ([85.190.233.128]) by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d816000000b005687e041608sm985228edq.37.2024.03.13.04.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 04:11:20 -0700 (PDT)
Date: Wed, 13 Mar 2024 07:11:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
Message-ID: <20240313070857-mutt-send-email-mst@kernel.org>
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
 <87h6hah7bb.fsf@pond.sub.org>
 <20240313051034-mutt-send-email-mst@kernel.org>
 <87msr2fp16.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msr2fp16.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 13, 2024 at 10:40:21AM +0100, Markus Armbruster wrote:
> I could be awkward for the use case described in PATCH 1's commit
> message:
> 
>     However, we sometimes want to compare features and status bits without
>     caring for their exact meaning.  Say we want to verify the correctness
>     of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
>     QMP command x-query-virtio-status to retrieve vhost-user net device
>     features, and the "ovs-vsctl list interface" command to retrieve
>     interface features.  Without commit f3034ad71fc, we could then simply
>     compare the numbers.  With this commit, we first have to map from the
>     strings back to the numeric encoding.

So, consider how guest kernel presents features then. Do you happen to know?
It's actually a binary string:

static ssize_t features_show(struct device *_d,
                             struct device_attribute *attr, char *buf)
{
        struct virtio_device *dev = dev_to_virtio(_d);
        unsigned int i;
        ssize_t len = 0;

        /* We actually represent this as a bitstring, as it could be
         * arbitrary length in future. */
        for (i = 0; i < sizeof(dev->features)*8; i++)
                len += sysfs_emit_at(buf, len, "%c",
                               __virtio_test_bit(dev, i) ? '1' : '0');
        len += sysfs_emit_at(buf, len, "\n");
        return len;
}
static DEVICE_ATTR_RO(features);

-- 
MST


