Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58AEC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyLu-0003Ta-Lv; Fri, 30 May 2025 07:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyLt-0003T3-5Z
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKyLr-0003fU-6g
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748606202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VD3BjY4GHQ+mCSGlGp19ZvgTUZkqt5lpUczzmNa1moI=;
 b=QOzdMM+5rmsfF8LVaEcPgb0l/v0wxSbhPgcIU91QSRJn2LWeXEdbTB7QsrsgxARFbVvr/Y
 dHVJR3rn1bH+qNnbCIH2Hok+vQXITQd6aLlhhspHbBBkqBOW9P2gV7KyHdpjECnnI+X8bu
 gHEMFEoP2Rh+0kcq5PxLce01j40r/WM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-aZdJHCnGMP6tnThWyzzPvA-1; Fri, 30 May 2025 07:56:40 -0400
X-MC-Unique: aZdJHCnGMP6tnThWyzzPvA-1
X-Mimecast-MFC-AGG-ID: aZdJHCnGMP6tnThWyzzPvA_1748606199
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so133885f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748606199; x=1749210999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD3BjY4GHQ+mCSGlGp19ZvgTUZkqt5lpUczzmNa1moI=;
 b=PHiWTowtYtPQQfo9thWcHtWvaRjB9ZUJBl6zmYpejLbq0qPRUgWm8sm+rM37df9PMi
 3mwhcDRYEktXXAlInSzclByWWcfGFZD8iUblJD+2LN71MM34wfkdTdCeZlu3FPhzEw15
 xJjE7AxAgzha/PYG6nXtylJsP+/uPduuOIQf+v5h1vCEwKBq3bVLvkipCVzW5lIW9a5H
 sZ8KAyaA44ss2A6E3fIfO4xiyEAJS1T58h9YyBo6WiF/RfcMz4Z5eLJDnuk76zfVMoFF
 BX4MDLGQxHO5QiMSVfIteMSOwslfqjw+c88TGbMl8MTYvZZx6G0Oz8e+fVRzDLN1E5Wg
 rHtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTSYj3Ztp/DFQCYWuuQBc/C7GZ785vfVUBBqzL38hVMIsLv4UlVahuvxJd6VhB+ZjA5ZnAgOS/uMnk@nongnu.org
X-Gm-Message-State: AOJu0YxsDYCiTLHDMA6Fs2D4yC77HI9gTRyE8tkd0MTUDPdrtBPg+Dya
 +aM5PwHdEaInBH7sMRpzlACTfDcxjn7JaCU5GggzR2vsIb+TMnVjzQk72gEQYGp26hw0bBIL2JG
 BwTbdebcCqmnYuVfQlhzdxUXiFA5VsrmEsMYdyZEuMPx7Rr46cFkQ9J0e
X-Gm-Gg: ASbGncv9wzKfkWkUhhe69QpH3doKowWx7mZHQsUpRI04mrh6MxSEy2VporporjWdkzf
 jdpGLjYh5MIGrR2WHrRLd91Ghew6HIhscRFioPnUtg0Ey5RTqMdtmV14nqviuISP/bXklRKrOPM
 ayNcqp36kkb6E9+8dcWlgkUqTHR8Vb5bi6T5whCmRBXEoeq7dirTnJX7+M0F+/nKG06U4p5kzqN
 /S0gVOqCYcn6mfinpG8pFpfz06DovEOEmzIkzz/6qUTfm4NBlaLU36dLf0DQFEA7iE60ql7DeWa
 JDdWQ2ZnKgTPhRr1
X-Received: by 2002:a05:6000:2404:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a4f7ac4d55mr2381593f8f.58.1748606198997; 
 Fri, 30 May 2025 04:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmFfnBBo0dC9QKlvCBCKiQm0f5Q92AmCLFsSVzr3rV4qvSwKBjqVowhgOCrB24+Y1BKop7lw==
X-Received: by 2002:a05:6000:2404:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a4f7ac4d55mr2381562f8f.58.1748606198494; 
 Fri, 30 May 2025 04:56:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009748fsm4570952f8f.80.2025.05.30.04.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:56:37 -0700 (PDT)
Date: Fri, 30 May 2025 07:56:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, anisinha@redhat.com,
 armbru@redhat.com, berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 mtosatti@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
Subject: Re: [PATCH v11 0/6] Specifying cache topology on ARM
Message-ID: <20250530075601-mutt-send-email-mst@kernel.org>
References: <20250519153632.537-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519153632.537-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, May 19, 2025 at 04:36:26PM +0100, Alireza Sanaee wrote:
> Specifying the cache layout in virtual machines is useful for
> applications and operating systems to fetch accurate information about
> the cache structure and make appropriate adjustments. Enforcing correct
> sharing information can lead to better optimizations. Patches that allow
> for an interface to express caches was landed in the prior cycles. This
> patchset uses the interface as a foundation.  Thus, the device tree and
> ACPI/PPTT table, and device tree are populated based on
> user-provided information and CPU topology.


Not sure why doesn't this apply anymore. Can you rebase and repost pls?

> Example:
> 
> 
> +----------------+                            +----------------+
> |    Socket 0    |                            |    Socket 1    |
> |    (L3 Cache)  |                            |    (L3 Cache)  |
> +--------+-------+                            +--------+-------+
>          |                                             |
> +--------+--------+                            +--------+--------+
> |   Cluster 0     |                            |   Cluster 0     |
> |   (L2 Cache)    |                            |   (L2 Cache)    |
> +--------+--------+                            +--------+--------+
>          |                                             |
> +--------+--------+  +--------+--------+    +--------+--------+  +--------+----+
> |   Core 0         | |   Core 1        |    |   Core 0        |  |   Core 1    |
> |   (L1i, L1d)     | |   (L1i, L1d)    |    |   (L1i, L1d)    |  |   (L1i, L1d)|
> +--------+--------+  +--------+--------+    +--------+--------+  +--------+----+
>          |                   |                       |                   |
> +--------+              +--------+              +--------+          +--------+
> |Thread 0|              |Thread 1|              |Thread 1|          |Thread 0|
> +--------+              +--------+              +--------+          +--------+
> |Thread 1|              |Thread 0|              |Thread 0|          |Thread 1|
> +--------+              +--------+              +--------+          +--------+
> 
> 
> The following command will represent the system relying on **ACPI PPTT tables**.
> 
> ./qemu-system-aarch64 \
>  -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>  -cpu max \
>  -m 2048 \
>  -smp sockets=2,clusters=1,cores=2,threads=2 \
>  -kernel ./Image.gz \
>  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>  -initrd rootfs.cpio.gz \
>  -bios ./edk2-aarch64-code.fd \
>  -nographic
> 
> The following command will represent the system relying on **the device tree**.
> 
> ./qemu-system-aarch64 \
>  -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>  -cpu max \
>  -m 2048 \
>  -smp sockets=2,clusters=1,cores=2,threads=2 \
>  -kernel ./Image.gz \
>  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=off" \
>  -initrd rootfs.cpio.gz \
>  -nographic
> 
> Failure cases:
>     1) There are scenarios where caches exist in systems' registers but
>     left unspecified by users. In this case qemu returns failure.
> 
>     2) SMT threads cannot share caches which is not very common. More
>     discussions here [1].
> 
> Currently only three levels of caches are supported to be specified from
> the command line. However, increasing the value does not require
> significant changes. Further, this patch assumes l2 and l3 unified
> caches and does not allow l(2/3)(i/d). The level terminology is
> thread/core/cluster/socket right now. Hierarchy assumed in this patch:
> Socket level = Cluster level + 1 = Core level + 2 = Thread level + 3;
> 
> TODO:
>   1) Making the code to work with arbitrary levels
>   2) Separated data and instruction cache at L2 and L3.
>   3) Additional cache controls.  e.g. size of L3 may not want to just
>   match the underlying system, because only some of the associated host
>   CPUs may be bound to this VM.
> 
> [1] https://lore.kernel.org/devicetree-spec/20250203120527.3534-1-alireza.sanaee@huawei.com/
> 
> Change Log:
>   v10->v11:
>    * Fix some coding style issues.
>    * Rename some variables.
> 
>   v9->v10:
>    * PPTT rev down to 2.
> 
>   v8->v9:
>    * rebase to 10
>    * Fixed a bug in device-tree generation related to a scenario when
>         caches are shared at core in higher levels than 1.
>   v7->v8:
>    * rebase: Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging
>    * I mis-included a file in patch #4 and I removed it in this one.
> 
>   v6->v7:
>    * Intel stuff got pulled up, so rebase.
>    * added some discussions on device tree.
> 
>   v5->v6:
>    * Minor bug fix.
>    * rebase based on new Intel patchset.
>      - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> 
>   v4->v5:
>     * Added Reviewed-by tags.
>     * Applied some comments.
> 
>   v3->v4:
>     * Device tree added.
> 
> Depends-on: Building PPTT with root node and identical implementation flag
> Depends-on: Msg-id: 20250423114130.902-1-alireza.sanaee@huawei.com
> 
> Alireza Sanaee (6):
>   target/arm/tcg: increase cache level for cpu=max
>   arm/virt.c: add cache hierarchy to device tree
>   bios-tables-test: prepare to change ARM ACPI virt PPTT
>   hw/acpi/aml-build.c: add cache hierarchy to pptt table
>   tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
>   Update the ACPI tables according to the acpi aml_build change, also
>     empty bios-tables-test-allowed-diff.h.
> 
>  hw/acpi/aml-build.c                        | 220 ++++++++++++-
>  hw/arm/virt-acpi-build.c                   |   8 +-
>  hw/arm/virt.c                              | 359 +++++++++++++++++++++
>  hw/cpu/core.c                              |  92 ++++++
>  hw/loongarch/virt-acpi-build.c             |   2 +-
>  include/hw/acpi/aml-build.h                |   4 +-
>  include/hw/arm/virt.h                      |   5 +
>  include/hw/cpu/core.h                      |  27 ++
>  target/arm/tcg/cpu64.c                     |  13 +
>  tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 540 bytes
>  tests/qtest/bios-tables-test.c             |   4 +
>  11 files changed, 724 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.0


