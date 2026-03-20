Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF2C1099B29
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3dZh-0006cs-GQ; Fri, 20 Mar 2026 13:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serapheimd@gmail.com>)
 id 1w3dZf-0006cj-Tg
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:23:51 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serapheimd@gmail.com>)
 id 1w3dZd-0005m7-O8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 13:23:51 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cbc593a67aso188501085a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774027428; x=1774632228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/8YBAbDUDWnSFur+r4piUQwH9SvhSkhr91o3u0AYXE=;
 b=FVuSgFKyhpwG/gsgPMNc2TTsTUlsRM6h7Wq9AzbVbxIJN+3wsxTB5CVAvdm5fYDCHg
 In5BWDMBJKOXRCOnv+lGFqem6HveO3cQIOHXNFZE9W5al3P9PMbcVKDRHENpnVscogK3
 EP3na4axwT3E+tD2f3O6AzjMcyuNqQCN5nlZLPi88mZrwC4E8UekW/XzFpc38pi1hmtQ
 79NeGzgl/r87UHtqQ/sm6wLFGHpzhFFoQVXWt+Kk2ptZPBbIsBTKCMcTGfTpJ9no40c3
 TC27Y8bSZdRxCNytBuzEF5mX1OtYHYNLMbLTMRLdKk85bKTGIEs7TqGC27ywaLXekyt/
 OIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774027428; x=1774632228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/8YBAbDUDWnSFur+r4piUQwH9SvhSkhr91o3u0AYXE=;
 b=BRIlVhAEDXFm3lwq3kG3YFiMMzOw4rbLbN9QoLZmo7FtZo/lR2/am72wVY41aUGh4A
 rfzu02gRfvK4F/2FIWSDJqorZmI53TA6jxw38WMWlqjSkaRWgg3oSLCnn903+KcFTAXP
 OtHmbfC76nGks2V3ImYhTolGNPYr4XaElb/0AdUzdoOnQO/OUM+4V3QpQfcuQ+7psVD5
 zTzmUA+Nap3GitqCqkqN1gQm/sQW3auxv7xLQe3jvxuUBambWK0ICkARz7I1O2TZOzVK
 afznrjM66xAvim+TeDZ8gg4sRtVTgGNqXnJT+xjsUE9Ao4d1Ynm6RhPIr39X5Ck8Rhx1
 AHtw==
X-Gm-Message-State: AOJu0YwxYwazCrr4e5F20LWixA/iCs1B5qFWlpqnk/qj0ptAW//D2It4
 AoF0epyX7o3PnWdWAOltBAnp0mApJPQ2ZYb4OkDh9E26D6/Ft3zZxx9C
X-Gm-Gg: ATEYQzwvqLE4THthNR0WHLB7prjA2Fax6UyEh/GxD4HPklmLZbkWHKMwPZhISN3Lix0
 fkCiC5m/cEHSmRvCycUwX+8r7SLEmA5CE+09i/o2omfKf89iHUjV9R05QtIHkmR+/dhekhtZEwO
 MZ3JeXBZ0ZX8nZ7S8Zii+OaL8ya0TdEtLXZKNj/pOiZim11RCkJ0e/SzaErNondNMn+aa/MTAUc
 05M1ommj+256LXlsUqqyvp8hlLmfHu+5bTzdi0CK5k4sqPWisNxPTCc6Zf1sKOIAhzTTWdJMdrT
 xL/6mAT2BmWCeysnRgJDzUUfIWPJU2Njq6kmLRwIo+O811xs8Y3XJs5xjDlg4bPpAM29i2l69lj
 /tCVPZXPuva2r/hvb8UrLh8JkPFxDWLJo77gMq0VLZ40RxEN03i3oPj0ogMaXdMhSdrp0k0SLoo
 skewXOaCrkLUIyLJNoImoP2Kfy+lMf+gj4vHDEd/1Yn+nXU3ZiQdeyT7hUyXh0loM0O8P9AsPt/
 0PjdPchySe9
X-Received: by 2002:a05:620a:288d:b0:8cd:827a:2abd with SMTP id
 af79cd13be357-8cfc7f8adb8mr545184585a.72.1774027427841; 
 Fri, 20 Mar 2026 10:23:47 -0700 (PDT)
Received: from CW-FL20TJCW03-L.mynetworksettings.com
 ([2600:4040:9138:9600:4515:689e:be71:5726])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc908df50sm199675485a.26.2026.03.20.10.23.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 10:23:47 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
To: stefanha@redhat.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 sgarzarella@redhat.com, xieyongji@bytedance.com, weijunji@bytedance.com,
 15927021679@163.com
Subject: Re: [RFC DISCUSSION] virtio-rdma: RDMA device emulation for QEMU
Date: Fri, 20 Mar 2026 13:23:45 -0400
Message-ID: <20260320172345.4688-1-serapheimd@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAJSP0QX3JtwhXDTnEgS-heLYYncjJtttg1KmFqG-+_VUXbH+Ww@mail.gmail.com>
References: <20260316210600.62415-1-serapheimd@gmail.com>
 <CAJSP0QX3JtwhXDTnEgS-heLYYncjJtttg1KmFqG-+_VUXbH+Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=serapheimd@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

Thank you for the quick reply and thorough review! I waited a few days
before replying to see if any of the folks from the previous virtio-rdma
efforts would chime in but nothing so far. In any case, my responses
inlined below.

> I think this is a sign that virtual RDMA has a small community without
> someone willing to maintain it over the long term. Can you see
> yourself actively maintaining this over the coming years?
>
> If not, then it may be more appropriate to treat it as an experimental
> and out-of-tree project. That way the spec and code can be shared in
> case others want to build on it in the future without any commitment
> or the overhead of going through the full process of getting a device
> merged into the VIRTIO spec, QEMU emulating code merged, and Linux
> guest code merged.
>
> If you are going to ship products that rely on this, then it's
> probably necessary to go through the full process of getting
> everything merged upstream.

I understand the hesitation given the pvrdma precedent. I want to be
explicit that this is not a side-project. I'm a kernel engineer at
CoreWeave and having something like virtio-rdma is a requirement for
some of our current projects. Two of them that I feel comfortable
disclosing is our work with BlueField DPUs and Kata containers.

For NVIDIA BlueFields we currently do most of our work with real
hardware which for us developers is at times hard to come by as
we want to make sure that our customers take priority. Being able
to do emulation with QEMU means that every engineer on the team
can iterate without a dedicated BlueField. Moreover, our test suite
can run more often this way too.

For Kata containers today, to get RDMA you have two options. Either
use virtio-net and give up latency or vfio-pci passthrough pinning
the pod to a NIC. The latter not only breaks the security model but
also isolation (not to mention any prospect of live-migration).

I'm ok keeping this as an out-of-tree project initially in the short
term but would hate it if something else comes along later and we
have to re-work everything on our end. As far as long-term commitment
goes I commit to maintaining virtio-rdma for as long as it's upstream.
If I ever leave my role at CoreWeave and my next role is not related
to virtio-rdma, my team at CoreWeave will designate a successor
maintainer as it has organizational interest in this work. I'm happy
to formalize my commitment in a MAINTAINERS entry when/if the time
comes.

> Does this mean that memory is registered on VQ 0 and incoming RDMA
> WRITE (without immediate) requests modify that memory directly without
> virtqueue activity? I think this is necessary because registered
> memory is available continuously and the virtqueue model doesn't
> really work for this mode of operation.
>
> It's worth clarifying this because accessing memory outside of
> virtqueue buffers is a violation of the VIRTIO device model. That's
> okay, VIRTIO is pragmatic and some devices do this but it's worth
> mentioning explicitly.
>
> Stepping outside the VIRTIO device model can create implementation
> challenges because interfaces like vDPA/VDUSE may not be designed for
> it though.

Ok great point actually. Evaluating the potential paths forward I
thought of the following (though I'm open to other ideas if you have
them):

A] Use a shared memory window (like virtio-fs DAX) - this wouldn't
work because it changes the RDMA programming model. Real HCAs let
you register *any* part of memory via ibv_reg_mr(). Restricting MRs
to a pre-allocated window would thus break standard applications.

B] Just acknowledge the deviation explicitly and move - as you said
besides being a spec violation it doesn't concretely solve the
vDPA/VDUSE case as they may want to enforce IOMMU boundaries.

C] Go the IOTLB route - when the driver registers an MR, the device
triggers IOTLB updates for every page in the MR giving the backend
legal IOMMU mappings.

Let me know if you can think of any other ways but I believe [C]
may be the way to go as real HCAs do the same thing. In our case
this would look like so:

1. REG_USER_MR sends the page list (guest physical addresses) via
   the command VQ (virtio-compliant command).

2. The device uses the platform's DMA mapping mechanism to establish
   mappings for each page in the MR. I believe for QEMU that would be
   address_space_map() since it has full guest RAM access.
   (VHOST_USER_IOTLB_MSG for vhost-user and VDUSE_IOTLB_REG_UMEM for
   VDUSE).

3. RDMA WRITE/READ resolve (remote_addr + rkey) through those mappings.

4. DEREG_MR invalidates them.

The above should require VIRTIO_F_ACCESS_PLATFORM when used with
IOMMU-protected backends like vDPA/VDUSE. As for the per-page mapping
cost at registration I'm open to ideas but I wonder if it is acceptable
for the v1 pass as it is a one time cost.

One potential future scalability issue with the flat list is that
for very large MRs (128GB/32M page addresses) it can become too
long/heavy in the command VQ which could be prohibitive for any
potential hardware implementations (if there were to be any). For
v1 maybe we could just reserve VIRTIO_RDMA_F_INDIRECT_MR and leave
room for a future indirect page table model?

Let me know how the above sound to you and I can make sure to document
them more formally in the spec draft.

> [...] check how registered memory can be implemented both in VDUSE
> and in-kernel vDPA drivers.

The IOTLB model above should cover both cases but I can double-check.
For VDUSE, MR registration triggers VDUSE_IOTLB_REG_UMEM calls. For
in-kernel vDPA, the vDPA bus provides DMA mapping APIs that map to the
parent IOMMU. The guest driver should ideally be unaware of which
backend is in use and just send REG_USER_MR with the device handling
the rest.

> For the userspace virtio-rdma device implementation I expected a new
> UNIX domain socket protocol along the lines of vhost-user and
> vfio-user. That's because sharing guest RAM is only part of the
> communication that must happen between two QEMUs and I guess you'll
> need to define your own protocol to coordinate RDMA between QEMU
> processes anyway.
>
> When using vDPA or VDUSE, QEMU shares guest RAM with the device
> through the /dev/vhost ioctls.
>
> In both cases, I'm not sure if ivshmem is necessary.

Makes sense - thank you for the pointers! I'm almost done switching
to domain sockets per your recommendation. The new scheme is currently
peer-to-peer (not a re-use of vhost-user which is VMM-to-backend). As
a first phase/stage each side exchanges MEM_REGIONS messages with
memfd descriptors for guest RAM regions and the peer mmap()s them
(handshake). Then we forward send/recv via framed messages on the
socket. RDMA WRITE/READ operate directly on the mmap'd peer memory
(no message nor remote CPU involvement).

BTW I don't need to add that level of detail in my spec, correct?
From what I can tell specs seem to define device-to-driver behavior
only (e.g. virtio-net doesn't say anything about TAP/vhost-user,
etc.)

> It depends what you mean by async. Virtqueues can complete requests
> out-of-order, so a separate completion virtqueue is not needed from
> that perspective.
>
> There could be other reasons why a separate completion virtqueue makes
> sense. If RDMA relies on the separate CQ design to emit multiple CQEs
> for the same request or emits CQEs not associated with any request,
> then a single virtqueue won't work. I don't know RDMA well enough to
> say either way.

ok looking more at RDMA CQ semantics and assuming I understand what you
propose correclty, I do believe we need the separate queue for the
following reasons:

- An RDMA application may create one CQ and bind multiple QPs to it
  (multi-QP fan-in). ibv_poll_cq() returns completions from all
  associated QPs in one call. If completions live in per-VQ used
  rings, then polling means scanning 2N VQs, O(n) per poll. It also
  seems like a mismatch in the CQ abstraction being a single
  aggregation point and virtio VQ a per-queue used ring. The dedicated
  completion VQ gives you the fan-in O(1) for free.

- The RDMA spec mandates that when a CQ overflows the device raises
  IBV_EVENT_CQ_ERR, which cascades to IBV_EVENT_QP_FATAL on every QP
  bound to that CQ. The device must be able to detect overflows to
  trigger this. Detecting that with a dedicated completion VQ is
  straightforward. The virtio used ring on the other hand doesn't have
  any overflow semantics from what I can tell so we'd need to make
  something ourselves.

- ibv_req_notify_cq(solicited_only=1) fires only for CQEs with the
  solicited flag set. I'm not sure how we could express this as-is
  when virtio event index suppresses by count, rather than per-WR
  flag. This is less critical though as we could work around it
  by always notifying and having the driver filter in its interrupt
  handler in order to be functionally correct.

Let me know if the above reasons seem legitimate on your end. It
generally seems to me the used ring has no place to put whatever
fields are needed for an RDMA CQE (only handles generic completion
metadata). So using a dedicated one to return buffers that contain
CQEs makes more sense that trying to encode CQE data in the used
ring itself.

> Writing C devices is still perfectly acceptable in QEMU. With Rust you
> are likely to have to work on bindings and may hit issues just because
> Rust is new in QEMU, but it's there and you can absolutely use it.

Yeah that's what it seemed like when I checked. I'd like to keep things
simple as a first pass and make sure we get something working while
monitoring for any Rust PCI+DMA bindings for future versions of this.

> I think vhost-vpda-device-pci is good practice. It makes sure the
> device is self-contained and doesn't rely on device-specific VMM
> support. If it's possible to use just vhost-vdpa-device-pci, then
> that's great. It scales better because it avoids the need to implement
> a device in every VMM (like QEMU, Firecracker, etc).

Great! Will proceed with that.

> You can reserve a device ID from the VIRTIO Technical Committee
> separately from getting the spec merged. Ask
> virtio-comment@lists.linux.dev.

Will do!

> It is helpful to see the draft VIRTIO spec and RFC patches at the same
> time. So as soon as you want to discuss the specifics of the VIRTIO
> spec patches it would be a good time to send RFC patches showing how
> the spec is implemented.

Will do the above shortly. I definitely need to revise my spec and code
first to incorporate some of the above. I really appreciate your
feedback on this!

Serapheim

