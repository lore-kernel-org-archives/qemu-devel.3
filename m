Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC02C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXE8H-00041N-Ls; Fri, 26 Jul 2024 02:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXE8G-0003xU-JW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 02:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXE8F-0003O4-6Z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 02:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721974126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrydteazi6UF4EDLH63hU357PWdSjODW7RxOZFLxuKE=;
 b=JF5OpmXjyTl0BSPfE37p3Ke/PraryOzoGt6m+VrJiG92runqE86FiCWaOe/EukphCL54qY
 Zi7N4v3i2g0Xk347JWmqjtiDECcyUW/6PDRvHtWyzBWBlhmRWjl5WK9zKVZElt8v3MBeMd
 9NIr0+KQBe9mkarN2yRxCllshOJLsjE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-dyl_OXAcOP25-aynoZQLfA-1; Fri, 26 Jul 2024 02:08:44 -0400
X-MC-Unique: dyl_OXAcOP25-aynoZQLfA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso12477995e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 23:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721974123; x=1722578923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrydteazi6UF4EDLH63hU357PWdSjODW7RxOZFLxuKE=;
 b=sOZO8qnYE7tK4QWDTm4akOZ9OSEJYuECMf35rbmch7xgGphO9j6a3K15+2W4sQg5/g
 fbXLTRyvlz5T9ves4DZPTACQbulCl1Ark5JsreGgFtPJbsTWBvdrP7DQ1gWV/jZJplFd
 ACTuFt5QpBv7d9tvD43j5XIuzorU/84Pl3kVcd9/xU8vIGdbcGjrtZGD+eb8FfZpKg+Z
 IeThXyGujqnBSKxi0bokTU/eNJkoM1bO9I/3gyrKNjU4I+/eT+R9DZwjLd0KtKSD3TNc
 i8DusEVfMDZQSzvPRQBGwIHhWAPsKjxxHvmCpdc6sK/GGJbwVzHeyoJ+0ov+KAtbvktT
 nh4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNpNZEOb+nWN9VhfslVaVt8p4X3DVPEpQmVw89BkNUdYQKNrhBZL4KApx3+ZMYwNP1JfD/IHRZYNHGtWhzXwkEHvom1QU=
X-Gm-Message-State: AOJu0Yw5CzLj+/OJ4k4U4oqqlkEVfI7lHLizEAQfhkMAuuVZJ/Ub/vhx
 Z9aA3PuYfEA4bejh9Yv3x7ItEDAWGQ9BXeBeIEBAyPzZZbr07eONQ4vtOp7LMLdW68NcFliDbJD
 26F3/LZrDwpnf7XMpSQRMlaSZQAZPETgxkKe8I0zHMCa+gHXmIaTE
X-Received: by 2002:a05:600c:3b1e:b0:428:9a1:f226 with SMTP id
 5b1f17b1804b1-42809a1f49fmr14274865e9.1.1721974123397; 
 Thu, 25 Jul 2024 23:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqRXd/rcZXdYps8gvrtGIzX6odmLDuTFkBVbV9xF7QTeYIfzu0tcKRPSpIDz7myCSd5h9Tww==
X-Received: by 2002:a05:600c:3b1e:b0:428:9a1:f226 with SMTP id
 5b1f17b1804b1-42809a1f49fmr14274535e9.1.1721974122586; 
 Thu, 25 Jul 2024 23:08:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057b7274sm63316485e9.40.2024.07.25.23.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 23:08:41 -0700 (PDT)
Date: Fri, 26 Jul 2024 02:08:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240726020656-mutt-send-email-mst@kernel.org>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqLPLBnbfD5r6z7D@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > USO features of virtio-net device depend on kernel ability
> > to support them, for backward compatibility by default the
> > features are disabled on 8.0 and earlier.
> > 
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> 
> Looks like this patch broke migration when the VM starts on a host that has
> USO supported, to another host that doesn't..

This was always the case with all offloads. The answer at the moment is,
don't do this. Long term, we need to start exposing management APIs
to discover this, and management has to disable unsupported features.

-- 
MST


