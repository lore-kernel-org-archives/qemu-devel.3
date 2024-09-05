Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A36CCE7A81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHJJ-00008T-Qq; Thu, 05 Sep 2024 14:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smHJH-000073-2s
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smHJC-0002wD-68
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725561241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Of0OYBusisIVAVlBl7A3JFHWo+MdKWhVvWG8dm7hwOc=;
 b=CrcpJ4QJCvO3gvSNNQC07Xh67CXng58q7+4mxrUj0EUwf55o2SKTZHp71hIyKmv6MTPtKv
 xKq0BOJkZsE5Vo52dWeVsz+omeA/Hc0x3Pu//Bwgh9uXd4SehWOwALd0XDKzUysOGNUnV8
 9pybDBLlGNzMQ3po0UdGmFQxL73SIG8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-4FEUW4QfN42SUnE_5vj6iw-1; Thu, 05 Sep 2024 14:31:40 -0400
X-MC-Unique: 4FEUW4QfN42SUnE_5vj6iw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6d73dd8ac65so46301707b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 11:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725561100; x=1726165900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Of0OYBusisIVAVlBl7A3JFHWo+MdKWhVvWG8dm7hwOc=;
 b=L7pxt2K4pNnKqS2CPvgcRDxjNWv4OkqY24jiRNHRGSZXkfr4TaaqDU9ksOlj3ifqHW
 rh3VSawgR7MQULvmj8X3wVTlfRC0iNiBPQeO+HIf2Jx8flS1M+cAiF6YJkz8wXfuUzow
 tYXKmN2E1864j5t1efhW2MEs3rdSJHZI3jScansOYtm8gkEnfwTN7vjyJvN1+905/6x1
 L5syUNeVJqYtT3wr+KUWY3pB6phr5MfonecsIPuv7Z2Nm6v6QcM9fhtnIfxyhgKht0e9
 OJUAzvHmaylv8fRz6u2SEQD4IjVoTRb0oFE5js/JVqtgP9ziTXFGcHPS6FEzAa7r4rEM
 Ec4g==
X-Gm-Message-State: AOJu0YzLOnzZ6laVXNyiuMh/zl4xxc7SnVsVQ2DrxuUuJht6YT7utdkd
 +scV7L07zKuIDfvTOd7aUfLMJZs/J8ttCaToZhcc20UzGpHnK4HmMP4o7ztkneNKmisi7QnCNad
 tbOMAvMoglKcae63tnvzExID/RZVLxbEO7PLhYL/7pDll91qsxXh6
X-Received: by 2002:a05:690c:3187:b0:6d6:7c9a:bf71 with SMTP id
 00721157ae682-6db451678e5mr369927b3.40.1725561100307; 
 Thu, 05 Sep 2024 11:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhBvCtmL93nv9CaYGiUgZXrRvf7D7Im/ngmUAPP3HubRPakpnKVXr0SRJ8UAlrvkWjgX/Zg==
X-Received: by 2002:a05:690c:3187:b0:6d6:7c9a:bf71 with SMTP id
 00721157ae682-6db451678e5mr369597b3.40.1725561100009; 
 Thu, 05 Sep 2024 11:31:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5202de943sm9688826d6.73.2024.09.05.11.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 11:31:39 -0700 (PDT)
Date: Thu, 5 Sep 2024 14:31:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
Message-ID: <Ztn5CcxhzYR-SFfE@x1n>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com>
 <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
 <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com>
 <ZtnbD69EeXhR6FFc@x1n>
 <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Sep 05, 2024 at 07:45:43PM +0300, Avihai Horon wrote:
> > Does it also mean then that the currently reported stop-size - precopy-size
> > will be very close to the constant non-iterable data size?
> 
> It's not constant, while the VM is running it can change.

I wonder how heavy is VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl.

I just gave it a quick shot with a busy VM migrating and estimate() is
invoked only every ~100ms.

VFIO might be different, but I wonder whether we can fetch stop-size in
estimate() somehow, so it's still a pretty fast estimate() meanwhile we
avoid the rest of exact() calls (which are destined to be useless without
VFIO).

IIUC so far the estimate()/exact() was because ram sync is heavy when
exact().  When idle it's 80+ms now for 32G VM with current master (which
has a bug and I'm fixing it up [1]..), even if after the fix it's 3ms (I
think both numbers contain dirty bitmap sync for both vfio and kvm).  So in
that case maybe we can still try fetching stop-size only for both
estimate() and exact(), but only sync bitmap in exact().

[1] https://lore.kernel.org/r/20240904223510.3519358-1-peterx@redhat.com

Thanks,

-- 
Peter Xu


