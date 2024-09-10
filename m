Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EDCEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5gc-0005ZC-RS; Tue, 10 Sep 2024 14:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so5gV-0005So-SX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so5gU-0001pa-0S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725993228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5QubyzazeYcC8SO14xGob3qlbEQlM4zNDfWeQ8DfIA=;
 b=I3deYtsGpkBew//mSYafAnKSaaRvh5bM1QwbMjU0FGKxd4VvwQtQPIN+mnzzFK1Vf6wy++
 8M0qt1iU1Muehksl8BqHNi4B8DofK886fnVzNEa2SX+95bBHLRJJDTUy/8Xxl2VXPnI/wB
 EXBMXNnrKTEWCSojw9V+eHS2DSAaPSc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-N0WTq1zEObaJG2JtgSZmZQ-1; Tue, 10 Sep 2024 14:33:47 -0400
X-MC-Unique: N0WTq1zEObaJG2JtgSZmZQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374bb1e931cso52781f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993226; x=1726598026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5QubyzazeYcC8SO14xGob3qlbEQlM4zNDfWeQ8DfIA=;
 b=E2Pq0rLTxOrG3Ccd7/WvkifDFfrKJZSyMDRZRK8bN1QiW0FvF66DNuK89CCJh5kWMg
 ygS53zzYwUSXdaaR6+L/D8tsYv0Ti0IQLOBQi9TQ3J1G9FUC+x7oi5fzSy7Cn4LnAjz2
 H12/be5m2EeQjXFGIj0rapTN9gP0hfoaILmaa1BKRzy4rJasGW9zdHILmDLmSni3E+/B
 Dh1W9w4uEs5u4g5tKTovMdfN86QUdQkRkkKB4hF+AP8Fp2pRdUvoGQlDXEEWKPFtc0yz
 NEjj9bvVI6QN8LaDF91tWjLmdcvszAG1uHhHjzMRuRSGQFpIVh40R8bOr0y7PbqZXXYD
 6Z8w==
X-Gm-Message-State: AOJu0YyVBaWWr/cMhJiXxVObdzmQ8iIB6UTnGJzo+sSim3kR84vivIgp
 TZQSmO3kW5N9JyVUdHbw6CEiQQC5MbsSI1J+pYk5Nw5v9iS8d4hkYdMNlRgKwrdZxBHXx+Jfhbs
 /8MB31U7xObnoEAMaIRzoVjuys79RG45+EyKd1cLNbUMDLGU+I1o5
X-Received: by 2002:a5d:518e:0:b0:374:d006:ffae with SMTP id
 ffacd0b85a97d-378a89fd144mr2843515f8f.6.1725993225791; 
 Tue, 10 Sep 2024 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGND48/STFxd5ZJeRLqDtbLKJRi/ilhU91bnyC0ih2DoCm5XifPdD7htSB8epOfraTaeZtyBA==
X-Received: by 2002:a5d:518e:0:b0:374:d006:ffae with SMTP id
 ffacd0b85a97d-378a89fd144mr2843494f8f.6.1725993224935; 
 Tue, 10 Sep 2024 11:33:44 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b21sm9555636f8f.49.2024.09.10.11.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 11:33:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 14:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
Message-ID: <20240910143224-mutt-send-email-mst@kernel.org>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 10, 2024 at 07:57:55PM +0200, David Hildenbrand wrote:
> This series is based on:
>     [PATCH v2] virtio: kconfig: memory devices are PCI only [1]
> 
> I finally found the time (IOW forced myself) to finish virtio-mem
> support on s390x. The last RFC was from 2020, so I won't talk about
> what changed -- a lot changed in the meantime :)
> 
> There is really not much left to do on s390x, because virtio-mem already
> implements most things we need today (e.g., early-migration,
> unplugged-inaccessible). The biggest part of this series is just doing what
> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
> well, messing with the physical memory layout where we can now exceed
> initial RAM size and have sparsity (memory holes).
> 
> I tested a lot of things, including:
>  * Memory hotplug/unplug
>  * Device hotplug/unplug
>  * System resets / reboots
>  * Migrate to/from file (including storage attributes under KVM)
>  * Basic live migration
>  * Basic postcopy live migration
> 
> More details on how to use it on s390x -- which is pretty much how
> we use it on other architectures, except
> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
> 
> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
> be documented at [2] once this+kernel part go upstream.
> 
> There are not many s390x-specific virtio-mem future work items, except:
> * Storage attribute migration might be improved
> * We might want to reset storage attributes of unplugged memory
>   (might or might not be required for upcoming page table reclaim in
>    Linux; TBD)


I don't see anything needing virtio specific here, let me know if
I missed anything.
A quick look is fine so I guess you can add
Acked-by: Michael S. Tsirkin <mst@redhat.com>



> I'll send out the kernel driver bits soon.
> 
> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> 
> David Hildenbrand (14):
>   s390x/s390-virtio-ccw: don't crash on weird RAM sizes
>   s390x/s390-virtio-hcall: remove hypercall registration mechanism
>   s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
>   s390x: rename s390-virtio-hcall* to s390-hypercall*
>   s390x/s390-virtio-ccw: move setting the maximum guest size from sclp
>     to machine code
>   s390x: introduce s390_get_memory_limit()
>   s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
>   s390x/s390-stattrib-kvm: prepare memory devices and sparse memory
>     layouts
>   s390x/s390-skeys: prepare for memory devices
>   s390x/pv: check initial, not maximum RAM size
>   s390x/s390-virtio-ccw: prepare for memory devices
>   s390x: introduce s390_get_max_pagesize()
>   s390x/virtio-ccw: add support for virtio based memory devices
>   s390x: virtio-mem support
> 
>  MAINTAINERS                    |   4 +
>  hw/s390x/Kconfig               |   1 +
>  hw/s390x/meson.build           |   4 +-
>  hw/s390x/s390-hypercall.c      |  77 +++++++++++
>  hw/s390x/s390-hypercall.h      |  25 ++++
>  hw/s390x/s390-skeys.c          |   4 +-
>  hw/s390x/s390-stattrib-kvm.c   |  63 +++++----
>  hw/s390x/s390-virtio-ccw.c     | 143 +++++++++++++--------
>  hw/s390x/s390-virtio-hcall.c   |  41 ------
>  hw/s390x/s390-virtio-hcall.h   |  25 ----
>  hw/s390x/sclp.c                |  17 +--
>  hw/s390x/virtio-ccw-md.c       | 153 ++++++++++++++++++++++
>  hw/s390x/virtio-ccw-md.h       |  44 +++++++
>  hw/s390x/virtio-ccw-mem.c      | 226 +++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw-mem.h      |  34 +++++
>  hw/virtio/Kconfig              |   1 +
>  hw/virtio/virtio-mem.c         |   4 +-
>  target/s390x/cpu-sysemu.c      |  35 ++++-
>  target/s390x/cpu.h             |   2 +
>  target/s390x/kvm/kvm.c         |  12 +-
>  target/s390x/kvm/pv.c          |   2 +-
>  target/s390x/tcg/misc_helper.c |   6 +-
>  22 files changed, 746 insertions(+), 177 deletions(-)
>  create mode 100644 hw/s390x/s390-hypercall.c
>  create mode 100644 hw/s390x/s390-hypercall.h
>  delete mode 100644 hw/s390x/s390-virtio-hcall.c
>  delete mode 100644 hw/s390x/s390-virtio-hcall.h
>  create mode 100644 hw/s390x/virtio-ccw-md.c
>  create mode 100644 hw/s390x/virtio-ccw-md.h
>  create mode 100644 hw/s390x/virtio-ccw-mem.c
>  create mode 100644 hw/s390x/virtio-ccw-mem.h
> 
> -- 
> 2.46.0


