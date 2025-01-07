Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F96E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4ch-0007il-RD; Tue, 07 Jan 2025 03:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tV4br-0006dV-04
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tV4bn-0004Gc-OS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736237198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCp4dUmRuHUITIfovnhzHixnGBspsZDveLljizE15Cw=;
 b=VvZ7g4JCyyeZGFmprE2UKo6iK78eSf0jS6HwjK5sO+NaCQU5drLiOF5ccyMbBvr7PTBoHw
 9WfCQ1lwiSJjNQUFrxAxlt1o82z+BBNqyl72V5NlfJ33zhm3bCppYOcrZJ7cMfCW5AjoN+
 vg1X7Gataaotf0KOLdB0Oqz8Qnkki0E=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-AXl8jjJ2M6S7Mn_yIWhbYg-1; Tue, 07 Jan 2025 03:06:36 -0500
X-MC-Unique: AXl8jjJ2M6S7Mn_yIWhbYg-1
X-Mimecast-MFC-AGG-ID: AXl8jjJ2M6S7Mn_yIWhbYg
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e544a56f461so13871384276.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237196; x=1736841996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCp4dUmRuHUITIfovnhzHixnGBspsZDveLljizE15Cw=;
 b=v3xAahkHSS+2eSvxva67sfoVxTqqw5IIudVdcSxzeZYMnLvbsoZQ/B+NY/l4S88hUp
 IRvf16hYjZXi7uYmAv08HTEJQWqsWlpu8TKP+F4pUzXyr11ssX1rFrvOUWqtWtMIj8oY
 kd1BTdDUmTyxS6P6pDfW9mwZNeCyC09EfMOBpOG3EVXn6J/weECv64WzBreoF/Dpr44+
 NjxwuMQC3wyl+dohupIXVE1Tw+FoNm7tt+KMHwIAf/srHxxx676noSrEkCOwP2awN9Bz
 ewApYegNSoSMwBJOFyDNJLWW3XzAMMKGTNT7h9O3f0imUrXaDW3Fk11B5c0sPNIvhG7N
 2bqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeUiDur79UCJGgx5siPN19m6hpuUm2dXLbslN0/gmhgdOA95h6DfgKfE5nqeu5vljUr2zNCBLIS3gP@nongnu.org
X-Gm-Message-State: AOJu0Ywi+fN/PmQ68snTDu/ACAN4u8q24nvA8gaBjJKqBbm7zggQbTuS
 c3ePBMHhy1o2HZvn9sXSt2QynTvkgb48qBYHF45OTyqz+jBwAlceh+Zx4zz5KQp2aHyOWqExlPX
 +7kB0Qd4+Y4ATHYIyayzZKto3TIlvfqorR7MDu6FqyrdXg/+S1zChGevc7kZL8CujGwNDHmo8N7
 Oqc6S73AdrRFHxnpGTfXlt/6xeQ8c=
X-Gm-Gg: ASbGncv91GqQM1wZ2q6NxHJNYF0Naj9GIhtJLK0+AIYtOSMeTO9+5Q+OQ13IPb6jXUy
 F9ask/WMvtCj8Vebauw3XCThJnyChS74M8wGSKQ==
X-Received: by 2002:a25:cc2:0:b0:e4a:6807:a58c with SMTP id
 3f1490d57ef6-e538c208bf0mr28170196276.6.1736237195956; 
 Tue, 07 Jan 2025 00:06:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEklJy+wFbx2u2mhiXLyal34rkvrYXLA+o9PwICCvo5TCVDOp7cFIpWOFaGB2eUpnnheP/JmXAIW/gCEJx725Y=
X-Received: by 2002:a25:cc2:0:b0:e4a:6807:a58c with SMTP id
 3f1490d57ef6-e538c208bf0mr28170173276.6.1736237195266; Tue, 07 Jan 2025
 00:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
 <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
 <CAJaqyWdx6GGrQ8-Pm9k9jE11djdk3B1OHda+uGTQqYbq5tyX7w@mail.gmail.com>
 <d747027b-4c59-4f01-bb36-b9a00aa7d3a9@gmail.com>
 <CAJaqyWeKW3VVATqdWMrRUxCZxsrCUur7uwiyDqk2Y2W1wqZusQ@mail.gmail.com>
 <9b20ffc4-b55b-42c8-9847-a677c30c0051@gmail.com>
 <CAJaqyWf_9btBAtZ1TrUDpCh-eTD47ELHO5jxWJW3gOAZO0tMCw@mail.gmail.com>
 <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
In-Reply-To: <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 7 Jan 2025 09:05:59 +0100
Message-ID: <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 3, 2025 at 2:06=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Hi,
>
> On 12/20/24 12:28 PM, Eugenio Perez Martin wrote:
> > On Thu, Dec 19, 2024 at 8:37=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/17/24 1:20 PM, Eugenio Perez Martin wrote:
> >>> On Tue, Dec 17, 2024 at 6:45=E2=80=AFAM Sahil Siddiq <icegambit91@gma=
il.com> wrote:
> >>>> On 12/16/24 2:09 PM, Eugenio Perez Martin wrote:
> >>>>> On Sun, Dec 15, 2024 at 6:27=E2=80=AFPM Sahil Siddiq <icegambit91@g=
mail.com> wrote:
> >>>>>> On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
> >>>>>>> On Thu, Dec 5, 2024 at 9:34=E2=80=AFPM Sahil Siddiq <icegambit91@=
gmail.com> wrote:
> >>>>>>>> [...]
> >>>>>>>> I have been following the "Hands on vDPA: what do you do
> >>>>>>>> when you ain't got the hardware v2 (Part 2)" [1] blog to
> >>>>>>>> test my changes. To boot the L1 VM, I ran:
> >>>>>>>>
> >>>>>>>> sudo ./qemu/build/qemu-system-x86_64 \
> >>>>>>>> -enable-kvm \
> >>>>>>>> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,me=
dia=3Ddisk,if=3Dvirtio \
> >>>>>>>> -net nic,model=3Dvirtio \
> >>>>>>>> -net user,hostfwd=3Dtcp::2222-:22 \
> >>>>>>>> -device intel-iommu,snoop-control=3Don \
> >>>>>>>> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable=
-modern=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_us=
o=3Doff,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Don,event_id=
x=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >>>>>>>> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >>>>>>>> -nographic \
> >>>>>>>> -m 8G \
> >>>>>>>> -smp 4 \
> >>>>>>>> -M q35 \
> >>>>>>>> -cpu host 2>&1 | tee vm.log
> >>>>>>>>
> >>>>>>>> Without "guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,
> >>>>>>>> guest_announce=3Doff" in "-device virtio-net-pci", QEMU
> >>>>>>>> throws "vdpa svq does not work with features" [2] when
> >>>>>>>> trying to boot L2.
> >>>>>>>>
> >>>>>>>> The enums added in commit #2 in this series is new and
> >>>>>>>> wasn't in the earlier versions of the series. Without
> >>>>>>>> this change, x-svq=3Dtrue throws "SVQ invalid device feature
> >>>>>>>> flags" [3] and x-svq is consequently disabled.
> >>>>>>>>
> >>>>>>>> The first issue is related to running traffic in L2
> >>>>>>>> with vhost-vdpa.
> >>>>>>>>
> >>>>>>>> In L0:
> >>>>>>>>
> >>>>>>>> $ ip addr add 111.1.1.1/24 dev tap0
> >>>>>>>> $ ip link set tap0 up
> >>>>>>>> $ ip addr show tap0
> >>>>>>>> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_cod=
el state UNKNOWN group default qlen 1000
> >>>>>>>>         link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
> >>>>>>>>         inet 111.1.1.1/24 scope global tap0
> >>>>>>>>            valid_lft forever preferred_lft forever
> >>>>>>>>         inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kern=
el_ll
> >>>>>>>>            valid_lft forever preferred_lft forever
> >>>>>>>>
> >>>>>>>> I am able to run traffic in L2 when booting without
> >>>>>>>> x-svq.
> >>>>>>>>
> >>>>>>>> In L1:
> >>>>>>>>
> >>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>>>>>> -nographic \
> >>>>>>>> -m 4G \
> >>>>>>>> -enable-kvm \
> >>>>>>>> -M q35 \
> >>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhos=
t-vdpa0 \
> >>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,=
disable-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0=
,addr=3D0x7 \
> >>>>>>>> -smp 4 \
> >>>>>>>> -cpu host \
> >>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>
> >>>>>>>> In L2:
> >>>>>>>>
> >>>>>>>> # ip addr add 111.1.1.2/24 dev eth0
> >>>>>>>> # ip addr show eth0
> >>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_cod=
el state UP group default qlen 1000
> >>>>>>>>         link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>>>>>>>         altname enp0s7
> >>>>>>>>         inet 111.1.1.2/24 scope global eth0
> >>>>>>>>            valid_lft forever preferred_lft forever
> >>>>>>>>         inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixro=
ute
> >>>>>>>>            valid_lft forever preferred_lft forever
> >>>>>>>>
> >>>>>>>> # ip route
> >>>>>>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>>>>>>>
> >>>>>>>> # ping 111.1.1.1 -w3
> >>>>>>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3D1 ttl=3D64 time=3D0.407 ms
> >>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3D2 ttl=3D64 time=3D0.671 ms
> >>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3D3 ttl=3D64 time=3D0.291 ms
> >>>>>>>>
> >>>>>>>> --- 111.1.1.1 ping statistics ---
> >>>>>>>> 3 packets transmitted, 3 received, 0% packet loss, time 2034ms
> >>>>>>>> rtt min/avg/max/mdev =3D 0.291/0.456/0.671/0.159 ms
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> But if I boot L2 with x-svq=3Dtrue as shown below, I am unable
> >>>>>>>> to ping the host machine.
> >>>>>>>>
> >>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>>>>>> -nographic \
> >>>>>>>> -m 4G \
> >>>>>>>> -enable-kvm \
> >>>>>>>> -M q35 \
> >>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dt=
rue,id=3Dvhost-vdpa0 \
> >>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,=
disable-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0=
,addr=3D0x7 \
> >>>>>>>> -smp 4 \
> >>>>>>>> -cpu host \
> >>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>
> >>>>>>>> In L2:
> >>>>>>>>
> >>>>>>>> # ip addr add 111.1.1.2/24 dev eth0
> >>>>>>>> # ip addr show eth0
> >>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_cod=
el state UP group default qlen 1000
> >>>>>>>>         link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>>>>>>>         altname enp0s7
> >>>>>>>>         inet 111.1.1.2/24 scope global eth0
> >>>>>>>>            valid_lft forever preferred_lft forever
> >>>>>>>>         inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixro=
ute
> >>>>>>>>            valid_lft forever preferred_lft forever
> >>>>>>>>
> >>>>>>>> # ip route
> >>>>>>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>>>>>>>
> >>>>>>>> # ping 111.1.1.1 -w10
> >>>>>>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>>>>>>>     From 111.1.1.2 icmp_seq=3D1 Destination Host Unreachable
> >>>>>>>> ping: sendmsg: No route to host
> >>>>>>>>     From 111.1.1.2 icmp_seq=3D2 Destination Host Unreachable
> >>>>>>>>     From 111.1.1.2 icmp_seq=3D3 Destination Host Unreachable
> >>>>>>>>
> >>>>>>>> --- 111.1.1.1 ping statistics ---
> >>>>>>>> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, =
time 2076ms
> >>>>>>>> pipe 3
> >>>>>>>>
> >>>>>>>> The other issue is related to booting L2 with "x-svq=3Dtrue"
> >>>>>>>> and "packed=3Don".
> >>>>>>>>
> >>>>>>>> In L1:
> >>>>>>>>
> >>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>>>>>> -nographic \
> >>>>>>>> -m 4G \
> >>>>>>>> -enable-kvm \
> >>>>>>>> -M q35 \
> >>>>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhos=
t-vdpa0,x-svq=3Dtrue \
> >>>>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,=
disable-modern=3Doff,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,guest=
_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,packed=3Don,bus=
=3Dpcie.0,addr=3D0x7 \
> >>>>>>>> -smp 4 \
> >>>>>>>> -cpu host \
> >>>>>>>> 2>&1 | tee vm.log
> >>>>>>>>
> >>>>>>>> The kernel throws "virtio_net virtio1: output.0:id 0 is not
> >>>>>>>> a head!" [4].
> >>>>>>>>
> >>>>>>>
> >>>>>>> So this series implements the descriptor forwarding from the gues=
t to
> >>>>>>> the device in packed vq. We also need to forward the descriptors =
from
> >>>>>>> the device to the guest. The device writes them in the SVQ ring.
> >>>>>>>
> >>>>>>> The functions responsible for that in QEMU are
> >>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is call=
ed by
> >>>>>>> the device when used descriptors are written to the SVQ, which ca=
lls
> >>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to =
do
> >>>>>>> modifications similar to vhost_svq_add: Make them conditional if =
we're
> >>>>>>> in split or packed vq, and "copy" the code from Linux's
> >>>>>>> drivers/virtio/virtio_ring.c:virtqueue_get_buf.
> >>>>>>>
> >>>>>>> After these modifications you should be able to ping and forward
> >>>>>>> traffic. As always, It is totally ok if it needs more than one
> >>>>>>> iteration, and feel free to ask any question you have :).
> >>>>>>>
> >>>>>>
> >>>>>> I misunderstood this part. While working on extending
> >>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf() [1]
> >>>>>> for packed vqs, I realized that this function and
> >>>>>> vhost_svq_flush() already support split vqs. However, I am
> >>>>>> unable to ping L0 when booting L2 with "x-svq=3Dtrue" and
> >>>>>> "packed=3Doff" or when the "packed" option is not specified
> >>>>>> in QEMU's command line.
> >>>>>>
> >>>>>> I tried debugging these functions for split vqs after running
> >>>>>> the following QEMU commands while following the blog [2].
> >>>>>>
> >>>>>> Booting L1:
> >>>>>>
> >>>>>> $ sudo ./qemu/build/qemu-system-x86_64 \
> >>>>>> -enable-kvm \
> >>>>>> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,medi=
a=3Ddisk,if=3Dvirtio \
> >>>>>> -net nic,model=3Dvirtio \
> >>>>>> -net user,hostfwd=3Dtcp::2222-:22 \
> >>>>>> -device intel-iommu,snoop-control=3Don \
> >>>>>> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-m=
odern=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=
=3Doff,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Doff,event_id=
x=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >>>>>> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >>>>>> -nographic \
> >>>>>> -m 8G \
> >>>>>> -smp 4 \
> >>>>>> -M q35 \
> >>>>>> -cpu host 2>&1 | tee vm.log
> >>>>>>
> >>>>>> Booting L2:
> >>>>>>
> >>>>>> # ./qemu/build/qemu-system-x86_64 \
> >>>>>> -nographic \
> >>>>>> -m 4G \
> >>>>>> -enable-kvm \
> >>>>>> -M q35 \
> >>>>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtru=
e,id=3Dvhost-vdpa0 \
> >>>>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,di=
sable-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,a=
ddr=3D0x7 \
> >>>>>> -smp 4 \
> >>>>>> -cpu host \
> >>>>>> 2>&1 | tee vm.log
> >>>>>>
> >>>>>> I printed out the contents of VirtQueueElement returned
> >>>>>> by vhost_svq_get_buf() in vhost_svq_flush() [3].
> >>>>>> I noticed that "len" which is set by "vhost_svq_get_buf"
> >>>>>> is always set to 0 while VirtQueueElement.len is non-zero.
> >>>>>> I haven't understood the difference between these two "len"s.
> >>>>>>
> >>>>>
> >>>>> VirtQueueElement.len is the length of the buffer, while the len of
> >>>>> vhost_svq_get_buf is the bytes written by the device. In the case o=
f
> >>>>> the tx queue, VirtQueuelen is the length of the tx packet, and the
> >>>>> vhost_svq_get_buf is always 0 as the device does not write. In the
> >>>>> case of rx, VirtQueueElem.len is the available length for a rx fram=
e,
> >>>>> and the vhost_svq_get_buf len is the actual length written by the
> >>>>> device.
> >>>>>
> >>>>> To be 100% accurate a rx packet can span over multiple buffers, but
> >>>>> SVQ does not need special code to handle this.
> >>>>>
> >>>>> So vhost_svq_get_buf should return > 0 for rx queue (svq->vq->index=
 =3D=3D
> >>>>> 0), and 0 for tx queue (svq->vq->index % 2 =3D=3D 1).
> >>>>>
> >>>>> Take into account that vhost_svq_get_buf only handles split vq at t=
he
> >>>>> moment! It should be renamed or splitted into vhost_svq_get_buf_spl=
it.
> >>>>
> >>>> In L1, there are 2 virtio network devices.
> >>>>
> >>>> # lspci -nn | grep -i net
> >>>> 00:02.0 Ethernet controller [0200]: Red Hat, Inc. Virtio network dev=
ice [1af4:1000]
> >>>> 00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network=
 device [1af4:1041] (rev 01)
> >>>>
> >>>> I am using the second one (1af4:1041) for testing my changes and hav=
e
> >>>> bound this device to the vp_vdpa driver.
> >>>>
> >>>> # vdpa dev show -jp
> >>>> {
> >>>>        "dev": {
> >>>>            "vdpa0": {
> >>>>                "type": "network",
> >>>>                "mgmtdev": "pci/0000:00:04.0",
> >>>>                "vendor_id": 6900,
> >>>>                "max_vqs": 3,
> >>>
> >>> How is max_vqs=3D3? For this to happen L0 QEMU should have
> >>> virtio-net-pci,...,queues=3D3 cmdline argument.
> >
> > Ouch! I totally misread it :(. Everything is correct, max_vqs should
> > be 3. I read it as the virtio_net queues, which means queue *pairs*,
> > as it includes rx and tx queue.
>
> Understood :)
>
> >>
> >> I am not sure why max_vqs is 3. I haven't set the value of queues to 3
> >> in the cmdline argument. Is max_vqs expected to have a default value
> >> other than 3?
> >>
> >> In the blog [1] as well, max_vqs is 3 even though there's no queues=3D=
3
> >> argument.
> >>
> >>> It's clear the guest is not using them, we can add mq=3Doff
> >>> to simplify the scenario.
> >>
> >> The value of max_vqs is still 3 after adding mq=3Doff. The whole
> >> command that I run to boot L0 is:
> >>
> >> $ sudo ./qemu/build/qemu-system-x86_64 \
> >> -enable-kvm \
> >> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3D=
disk,if=3Dvirtio \
> >> -net nic,model=3Dvirtio \
> >> -net user,hostfwd=3Dtcp::2222-:22 \
> >> -device intel-iommu,snoop-control=3Don \
> >> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-moder=
n=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Dof=
f,guest_announce=3Doff,mq=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Doff,even=
t_idx=3Doff,bus=3Dpcie.0,addr=3D0x4 \
> >> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >> -nographic \
> >> -m 8G \
> >> -smp 4 \
> >> -M q35 \
> >> -cpu host 2>&1 | tee vm.log
> >>
> >> Could it be that 2 of the 3 vqs are used for the dataplane and
> >> the third vq is the control vq?
> >>
> >>>>                "max_vq_size": 256
> >>>>            }
> >>>>        }
> >>>> }
> >>>>
> >>>> The max number of vqs is 3 with the max size being 256.
> >>>>
> >>>> Since, there are 2 virtio net devices, vhost_vdpa_svqs_start [1]
> >>>> is called twice. For each of them. it calls vhost_svq_start [2]
> >>>> v->shadow_vqs->len number of times.
> >>>>
> >>>
> >>> Ok I understand this confusion, as the code is not intuitive :). Take
> >>> into account you can only have svq in vdpa devices, so both
> >>> vhost_vdpa_svqs_start are acting on the vdpa device.
> >>>
> >>> You are seeing two calls to vhost_vdpa_svqs_start because virtio (and
> >>> vdpa) devices are modelled internally as two devices in QEMU: One for
> >>> the dataplane vq, and other for the control vq. There are historical
> >>> reasons for this, but we use it in vdpa to always shadow the CVQ whil=
e
> >>> leaving dataplane passthrough if x-svq=3Doff and the virtio & virtio-=
net
> >>> feature set is understood by SVQ.
> >>>
> >>> If you break at vhost_vdpa_svqs_start with gdb and go higher in the
> >>> stack you should reach vhost_net_start, that starts each vhost_net
> >>> device individually.
> >>>
> >>> To be 100% honest, each dataplain *queue pair* (rx+tx) is modelled
> >>> with a different vhost_net device in QEMU, but you don't need to take
> >>> that into account implementing the packed vq :).
> >>
> >> Got it, this makes sense now.
> >>
> >>>> Printing the values of dev->vdev->name, v->shadow_vqs->len and
> >>>> svq->vring.num in vhost_vdpa_svqs_start gives:
> >>>>
> >>>> name: virtio-net
> >>>> len: 2
> >>>> num: 256
> >>>> num: 256
> >>>
> >>> First QEMU's vhost_net device, the dataplane.
> >>>
> >>>> name: virtio-net
> >>>> len: 1
> >>>> num: 64
> >>>>
> >>>
> >>> Second QEMU's vhost_net device, the control virtqueue.
> >>
> >> Ok, if I understand this correctly, the control vq doesn't
> >> need separate queues for rx and tx.
> >>
> >
> > That's right. Since CVQ has one reply per command, the driver can just
> > send ro+rw descriptors to the device. In the case of RX, the device
> > needs a queue with only-writable descriptors, as neither the device or
> > the driver knows how many packets will arrive.
>
> Got it, this makes sense now.
>
> >>>> I am not sure how to match the above log lines to the
> >>>> right virtio-net device since the actual value of num
> >>>> can be less than "max_vq_size" in the output of "vdpa
> >>>> dev show".
> >>>>
> >>>
> >>> Yes, the device can set a different vq max per vq, and the driver can
> >>> negotiate a lower vq size per vq too.
> >>>
> >>>> I think the first 3 log lines correspond to the virtio
> >>>> net device that I am using for testing since it has
> >>>> 2 vqs (rx and tx) while the other virtio-net device
> >>>> only has one vq.
> >>>>
> >>>> When printing out the values of svq->vring.num,
> >>>> used_elem.len and used_elem.id in vhost_svq_get_buf,
> >>>> there are two sets of output. One set corresponds to
> >>>> svq->vring.num =3D 64 and the other corresponds to
> >>>> svq->vring.num =3D 256.
> >>>>
> >>>> For svq->vring.num =3D 64, only the following line
> >>>> is printed repeatedly:
> >>>>
> >>>> size: 64, len: 1, i: 0
> >>>>
> >>>
> >>> This is with packed=3Doff, right? If this is testing with packed, you
> >>> need to change the code to accommodate it. Let me know if you need
> >>> more help with this.
> >>
> >> Yes, this is for packed=3Doff. For the time being, I am trying to
> >> get L2 to communicate with L0 using split virtqueues and x-svq=3Dtrue.
> >>
> >
> > Got it.
> >
> >>> In the CVQ the only reply is a byte, indicating if the command was
> >>> applied or not. This seems ok to me.
> >>
> >> Understood.
> >>
> >>> The queue can also recycle ids as long as they are not available, so
> >>> that part seems correct to me too.
> >>
> >> I am a little confused here. The ids are recycled when they are
> >> available (i.e., the id is not already in use), right?
> >>
> >
> > In virtio, available is that the device can use them. And used is that
> > the device returned to the driver. I think you're aligned it's just it
> > is better to follow the virtio nomenclature :).
>
> Got it.
>
> >>>> For svq->vring.num =3D 256, the following line is
> >>>> printed 20 times,
> >>>>
> >>>> size: 256, len: 0, i: 0
> >>>>
> >>>> followed by:
> >>>>
> >>>> size: 256, len: 0, i: 1
> >>>> size: 256, len: 0, i: 1
> >>>>
> >>>
> >>> This makes sense for the tx queue too. Can you print the VirtQueue in=
dex?
> >>
> >> For svq->vring.num =3D 64, the vq index is 2. So the following line
> >> (svq->vring.num, used_elem.len, used_elem.id, svq->vq->queue_index)
> >> is printed repeatedly:
> >>
> >> size: 64, len: 1, i: 0, vq idx: 2
> >>
> >> For svq->vring.num =3D 256, the following line is repeated several
> >> times:
> >>
> >> size: 256, len: 0, i: 0, vq idx: 1
> >>
> >> This is followed by:
> >>
> >> size: 256, len: 0, i: 1, vq idx: 1
> >>
> >> In both cases, queue_index is 1. To get the value of queue_index,
> >> I used "virtio_get_queue_index(svq->vq)" [2].
> >>
> >> Since the queue_index is 1, I guess this means this is the tx queue
> >> and the value of len (0) is correct. However, nothing with
> >> queue_index % 2 =3D=3D 0 is printed by vhost_svq_get_buf() which means
> >> the device is not sending anything to the guest. Is this correct?
> >>
> >
> > Yes, that's totally correct.
> >
> > You can set -netdev tap,...,vhost=3Doff in L0 qemu and trace (or debug
> > with gdb) it to check what is receiving. You should see calls to
> > hw/net/virtio-net.c:virtio_net_flush_tx. The corresponding function to
> > receive is virtio_net_receive_rcu, I recommend you trace too just it
> > in case you see any strange call to it.
> >
>
> I added "vhost=3Doff" to -netdev tap in L0's qemu command. I followed all
> the steps in the blog [1] up till the point where L2 is booted. Before
> booting L2, I had no issues pinging L0 from L1.
>
> For each ping, the following trace lines were printed by QEMU:
>
> virtqueue_alloc_element elem 0x5d041024f560 size 56 in_num 0 out_num 1
> virtqueue_pop vq 0x5d04109b0ce8 elem 0x5d041024f560 in_num 0 out_num 1
> virtqueue_fill vq 0x5d04109b0ce8 elem 0x5d041024f560 len 0 idx 0
> virtqueue_flush vq 0x5d04109b0ce8 count 1
> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0ce8
> virtqueue_alloc_element elem 0x5d041024f560 size 56 in_num 1 out_num 0
> virtqueue_pop vq 0x5d04109b0c50 elem 0x5d041024f560 in_num 1 out_num 0
> virtqueue_fill vq 0x5d04109b0c50 elem 0x5d041024f560 len 110 idx 0
> virtqueue_flush vq 0x5d04109b0c50 count 1
> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0c50
>
> The first 5 lines look like they were printed when an echo request was
> sent to L0 and the next 5 lines were printed when an echo reply was
> received.
>
> After booting L2, I set up the tap device's IP address in L0 and the
> vDPA port's IP address in L2.
>
> When trying to ping L0 from L2, I only see the following lines being
> printed:
>
> virtqueue_alloc_element elem 0x5d041099ffd0 size 56 in_num 0 out_num 1
> virtqueue_pop vq 0x5d0410d87168 elem 0x5d041099ffd0 in_num 0 out_num 1
> virtqueue_fill vq 0x5d0410d87168 elem 0x5d041099ffd0 len 0 idx 0
> virtqueue_flush vq 0x5d0410d87168 count 1
> virtio_notify vdev 0x5d0410d79a10 vq 0x5d0410d87168
>
> There's no reception. I used wireshark to inspect the packets that are
> being sent and received through the tap device in L0.
>
> When pinging L0 from L2, I see one of the following two outcomes:
>
> Outcome 1:
> ----------
> L2 broadcasts ARP packets and L0 replies to L2.
>
> Source             Destination        Protocol    Length    Info
> 52:54:00:12:34:57  Broadcast          ARP         42        Who has 111.1=
.1.1? Tell 111.1.1.2
> d2:6d:b9:61:e1:9a  52:54:00:12:34:57  ARP         42        111.1.1.1 is =
at d2:6d:b9:61:e1:9a
>
> Outcome 2 (less frequent):
> --------------------------
> L2 sends an ICMP echo request packet to L0 and L0 sends a reply,
> but the reply is not received by L2.
>
> Source             Destination        Protocol    Length    Info
> 111.1.1.2          111.1.1.1          ICMP        98        Echo (ping) r=
equest  id=3D0x0006, seq=3D1/256, ttl=3D64
> 111.1.1.1          111.1.1.2          ICMP        98        Echo (ping) r=
eply    id=3D0x0006, seq=3D1/256, ttl=3D64
>
> When pinging L2 from L0 I get the following output in
> wireshark:
>
> Source             Destination        Protocol    Length    Info
> 111.1.1.1          111.1.1.2          ICMP        100       Echo (ping) r=
equest  id=3D0x002c, seq=3D2/512, ttl=3D64 (no response found!)
>
> I do see a lot of traced lines being printed (by the QEMU instance that
> was started in L0) with in_num > 1, for example:
>
> virtqueue_alloc_element elem 0x5d040fdbad30 size 56 in_num 1 out_num 0
> virtqueue_pop vq 0x5d04109b0c50 elem 0x5d040fdbad30 in_num 1 out_num 0
> virtqueue_fill vq 0x5d04109b0c50 elem 0x5d040fdbad30 len 76 idx 0
> virtqueue_flush vq 0x5d04109b0c50 count 1
> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0c50
>

So L0 is able to receive data from L2. We're halfway there, Good! :).

> It looks like L1 is receiving data from L0 but this is not related to
> the pings that are sent from L2. I haven't figured out what data is
> actually being transferred in this case. It's not necessary for all of
> the data that L1 receives from L0 to be passed to L2, is it?
>

It should be noise, yes.

> >>>> For svq->vring.num =3D 256, the following line is
> >>>> printed 20 times,
> >>>>
> >>>> size: 256, len: 0, i: 0
> >>>>
> >>>> followed by:
> >>>>
> >>>> size: 256, len: 0, i: 1
> >>>> size: 256, len: 0, i: 1
> >>>>
> >>>
> >>> This makes sense for the tx queue too. Can you print the VirtQueue in=
dex?
> >>
> >> For svq->vring.num =3D 64, the vq index is 2. So the following line
> >> (svq->vring.num, used_elem.len, used_elem.id, svq->vq->queue_index)
> >> is printed repeatedly:
> >>
> >> size: 64, len: 1, i: 0, vq idx: 2
> >>
> >> For svq->vring.num =3D 256, the following line is repeated several
> >> times:
> >>
> >> size: 256, len: 0, i: 0, vq idx: 1
> >>
> >> This is followed by:
> >>
> >> size: 256, len: 0, i: 1, vq idx: 1
> >>
> >> In both cases, queue_index is 1.
>
> I also noticed that there are now some lines with svq->vring.num =3D 256
> where len > 0. These lines were printed by the QEMU instance running
> in L1, so this corresponds to data that was received by L2.
>
> svq->vring.num  used_elem.len  used_elem.id  svq->vq->queue_index
> size: 256       len: 82        i: 0          vq idx: 0
> size: 256       len: 82        i: 1          vq idx: 0
> size: 256       len: 82        i: 2          vq idx: 0
> size: 256       len: 54        i: 3          vq idx: 0
>
> I still haven't figured out what data was received by L2 but I am
> slightly confused as to why this data was received by L2 but not
> the ICMP echo replies sent by L0.
>

We're on a good track, let's trace it deeper. I guess these are
printed from vhost_svq_flush, right? Do virtqueue_fill,
virtqueue_flush, and event_notifier_set(&svq->svq_call) run properly,
or do you see anything strange with gdb / tracing?


