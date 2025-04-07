Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68490C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 09:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1iwo-00043O-Qe; Mon, 07 Apr 2025 05:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u1iwm-00042p-JU
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u1iwj-00045D-3z
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744018748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPd2KHQ3p7Cec6E+EUzqXE4hYP79ZrxtpZRLiCQxwdM=;
 b=HW8HBiLea68ZHqzA+tE151uFzW/bPH3qNXZh+3mozcM7t3SfIYj15LDbIz8ZrFYOTM27n4
 ZK0MT+ESSQ1LiUyEF4c+8EVX8rBK0n+ZHS52bgmS4fj2UCGD1nS9OPT/QxUNw9k0s1brOm
 TLp3/JayLwNihuurfmyYq6XZH1HN2v4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ESn24vgqPNyFJLxbl_Omlg-1; Mon, 07 Apr 2025 05:39:07 -0400
X-MC-Unique: ESn24vgqPNyFJLxbl_Omlg-1
X-Mimecast-MFC-AGG-ID: ESn24vgqPNyFJLxbl_Omlg_1744018746
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3978ef9a284so1845499f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 02:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744018746; x=1744623546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPd2KHQ3p7Cec6E+EUzqXE4hYP79ZrxtpZRLiCQxwdM=;
 b=qNB9RsyG2LG9tnR6QeTZWxPtvkf++7LB439b9JtSHfCLuRDYhrAa0/vlYAzXIMVn3C
 k2CKAD2yofWDxSuwSTdhu4mwMy8qcItZQzdkD9bRx1JhSptBW56Gq3iyUpvRN5M1lv0B
 OxGMZxRMWbafjL8TbfvihrsOksRw0Zb8p6roPcsEKMyZCBH9e3XzoMZ05U2NdakTcJq7
 zPpu5Z9j67swSgmAlbVfglenbHr3SE8fFiGpOqVg8ikuryjfNCyEmuO87AzWaZZgUpMp
 d/SBQpD09mRDYBJthe8pjVHtVi9ZMjvDh1kSY9DwIsLi6SGhyfBDgYKs7Yn1g0pJUR6K
 CrMA==
X-Gm-Message-State: AOJu0YxIkjwNv6k8GrBh86+h2JoOsMKlEEayHS7R2ExlUqw09Ct+i1hs
 GSC8PPYYMpfmDix/TFZZvX4lPNMsDSelDJHYy9CV97VNNVOqIYHbLiUUFAsDUrqn5VY3pKFe+SU
 6QwVnLGgwnrgbIcUk2nXFdVNyNxqlnaV+C/4OvRWGmQJ8QdQBrSWR
X-Gm-Gg: ASbGnctzyQRCDc1Mo8tLhKN/vOHeGEllEWRd502iTh56WzQ/Q+pOq9iY9gqCQN1dE8P
 MwvM8gJjpQX/m91QO5uI5aV2cf2Nn4QC5K38TfkMYfbumGWO0YVj2QizlWzvj0i2F7ZyUwDsrur
 /a7wegS8aNGHacR5gjhvvpDpVUT2RAUk4iAvLQ5FevEyJSC5MZHzPvODPyErGaqucZ2XxGudU/d
 lSWAZgY7pnsPX+XA5F9WFR2j3o89hT3bpydx5iNd0Iffh6i2iWry2CxKux51YuXc68I10q0XzkU
 zgoNSm9eHQ==
X-Received: by 2002:a5d:6da1:0:b0:38f:3224:65ff with SMTP id
 ffacd0b85a97d-39cb357585amr10265964f8f.5.1744018745787; 
 Mon, 07 Apr 2025 02:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHeJwwn0+tifGmAOKpbHWT3a2PWV+3qFBF8VGndgFw69+iwfzZfR5CG8eB20coaK0LXa7rXA==
X-Received: by 2002:a5d:6da1:0:b0:38f:3224:65ff with SMTP id
 ffacd0b85a97d-39cb357585amr10265939f8f.5.1744018745363; 
 Mon, 07 Apr 2025 02:39:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b69c4sm11386348f8f.43.2025.04.07.02.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:39:04 -0700 (PDT)
Date: Mon, 7 Apr 2025 05:39:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "T.J. Alumbaugh" <talumbau@google.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] virtio-balloon: Working Set Reporting
Message-ID: <20250407053811-mutt-send-email-mst@kernel.org>
References: <20230525222016.35333-1-talumbau@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 25, 2023 at 10:20:11PM +0000, T.J. Alumbaugh wrote:
> This is the device implementation for the proposed expanded balloon feature
> described here:
> 
> https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/
> 
> This series has a fixed number of "bins" for the working set report, but this is
> not a constraint of the system. The bin number is fixed at device realization
> time (in other implementations it is specified as a command line argument). Once
> that number is fixed, this determines the correct number of bin intervals to
> pass to the QMP/HMP function 'working_set_config'. Any feedback on how to
> properly construct that function for this use case (passing a variable length
> list?) would be appreciated.

It's been a while. Is there interest is reviving this? I also note that
reserving a feature bit is very much recommended to avoid a complete
mess.


> New in V2:
> =========
> 
> - Patch series is now: header file changes, device changes, QMP changes, HMP
> chagnes, and migration changes.
> 
> - Exmaple usages of QMP and HMP interface are in their respective commit
> messages.
> 
> - "ws" -> "working_set" throughout
> 
> Motivation
> ==========
> As mentioned in the above message, the use case is a host with overcommitted
> memory and 1 or more VMs. The goal is to get both timely and accurate
> information on overall memory utilization in order to drive appropriate
> reclaim activities, since in some client device use cases a VM might need a
> significant fraction of the overall memory for a period of time, but then
> enter a quiet period that results in a large number of cold pages in the
> guest.
> 
> The balloon device now has a number of features to assist in sharing memory
> resources amongst the guests and host (e.g free page hinting, stats, free page
> reporting). As mentioned in slide 12 in [1], the balloon doesn't have a good
> mechanism to drive the reclaim of guest cache. Our use case includes both
> typical page cache as well as "application caches" with memory that should be
> discarded in times of system-wide memory pressure. In some cases, virtio-pmem
> can be a method for host control of guest cache but there are undesirable
> security implications.
> 
> Working Set Reporting
> =====================
> The patch series here includes:
> 
>  - Actual device implementation for VIRTIO_F_WS_REPORTING to standardize the
>    configuration and communication of Working Set reports from the guest. This
>    includes a notification virtqueue for receiving config information and
>    requests for a report (a feature which could be expanded for additional use
>    cases) and a virtqueue for the actual report from the driver.
> 
>  - QMP changes so that a controller program can use the existing QEMU socket
>    mechanism to configure and request WS reports and then read the reports as
>    a JSON property on the balloon.
> 
> Working Set reporting in the balloon provides:
> 
>  - an accurate picture of current memory utilization in the guest
>  - event driven reporting (with configurable rate limiting) to deliver reports
>    during times of memory pressure.
> 
> The reporting mechanism can be combined with a domain-specific balloon policy
> to drive the separate reclaim activities in a coordinated fashion.
> 
> TODOs:
> ======
>  -  A synchronization mechanism must be added to the functions that send WS
>     Config and WS Request, otherwise concurrent callers (through QMP) can mix
>     messages on the virtqueue sending the data to the driver.
> 
>  - The device currently has a hard-coded setting of 4 'bins' for a Working Set
>    report, whereas the specification calls for anywhere between 2 and 16.
> 
>  - A WS_EVENT notification through QMP should include the actual report,
>    whereas right now we query for that information right after a WS_EVENT is
>    received.
> 
> References:
> 
> [1] https://kvmforum2020.sched.com/event/eE4U/virtio-balloonpmemmem-managing-guest-memory-david-hildenbrand-michael-s-tsirkin-red-hat
> 
> T.J. Alumbaugh (5):
>   virtio-balloon: Add Working Set Reporting feature
>   virtio-balloon: device has Working Set Reporting
>   virtio-balloon: Add QMP functions for Working Set
>   virtio-balloon: Add HMP functions for Working Set
>   virtio-balloon: Migration of working set config
> 
>  hmp-commands.hx                               |  26 ++
>  hw/core/machine-hmp-cmds.c                    |  21 ++
>  hw/virtio/virtio-balloon-pci.c                |   2 +
>  hw/virtio/virtio-balloon.c                    | 239 +++++++++++++++++-
>  include/hw/virtio/virtio-balloon.h            |  13 +-
>  include/monitor/hmp.h                         |   2 +
>  .../standard-headers/linux/virtio_balloon.h   |  20 ++
>  include/sysemu/balloon.h                      |   9 +-
>  monitor/monitor.c                             |   1 +
>  qapi/machine.json                             |  66 +++++
>  qapi/misc.json                                |  26 ++
>  softmmu/balloon.c                             |  31 ++-
>  12 files changed, 449 insertions(+), 7 deletions(-)
> 
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog


