Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDD2CA0EFB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjyk5-0004tU-EH; Fri, 30 Aug 2024 06:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sjyk2-0004sN-Dr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:20:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sjyjy-0000Rq-OB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:20:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7143165f23fso1322845b3a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725013225; x=1725618025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2BVh9yj4u13ZNAH9P7AK5Jp6VC+IKLtIdSSEALT0mg=;
 b=gEy1CNThFasCv8Us4X+XcbN4pBMo6dGSfH03Ims0+dJ74rX4vOJW3XY+PkQYqVPXXz
 8lai42dt9a6CnQCum3a4ulAvbRZoRl69rm+alNpbm65dJ3TIqaO+bWh5ymEJtRTFhGL6
 5DlENm9zVEGV6WL76uZoB4Nchij8YQ0hbmdm0JU11NwXQlkhWWNiaaJ4dRGKVCRGfsLS
 bJAsE6yYtZOFXaIhXhR3QqeBgKv8NK1jGi9VuWiFp2D6mSBvopcDO3JqB1fTeCGpULzo
 qQgj4YUdxtEA2QOo+VXdXG1QYu3XPKRXIsWECtumbRo1SGusbGZ7KcRfd42ntkJoNGyP
 8VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013225; x=1725618025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2BVh9yj4u13ZNAH9P7AK5Jp6VC+IKLtIdSSEALT0mg=;
 b=lplyOQqOEanCMQNCAYRyN8puL0NImfqOHFiGoY42tptBEktESkKYt0yn99DRtxIWfJ
 l9zyaWvcEus0IqO94t3a/b1WsA0UN+dtiYtiaKWDy0IbQsHM7PgwMTuqoEHU/ITbZQr3
 ReyUlnnR1wZJWVVtkU+4mblB5f6BQzStCNPFRjCHEd9FHYRagcuI/yoNX4WYBohgsfg5
 96iZxNppSk3eUNg5elAT5CQDu7yYAe+JfECWiaWO2kgWuWvzJulrDD8T42oDLDVQMges
 CfebNhByn9h/WKxYYPPlUR4ZouxhHnk0O//YOb56GUXb697bFXZF51+XDqyRAtsPqDO4
 38Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTQ46AhKikasnOAtjXvgX0dsAaR5h9R95+4w+6cyrmxBvD/kbmgazRD/eVmFH0PVme911Y5sesb+6Z@nongnu.org
X-Gm-Message-State: AOJu0Yz+jFGYMLTVYMA0LAbjTTBHoRtYLWPNanswpeGKs4iFrP7oQSRY
 6mKtS3OIafU0ALeszQHwFxLLzhQt3k0WZcEkO7U64a9jt+SwlGTLnfe03g==
X-Google-Smtp-Source: AGHT+IEZQz+IFPzcLqMrHdbULD/aepHakoEQJDidVvLjOTHBeGoJBKCab1IwtWMO9CnVNjxw67eCWg==
X-Received: by 2002:a05:6a21:648c:b0:1c6:a4e7:bd1a with SMTP id
 adf61e73a8af0-1cce103b05emr5263869637.32.1725013224576; 
 Fri, 30 Aug 2024 03:20:24 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e56a0638sm2443955b3a.118.2024.08.30.03.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:20:24 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Fri, 30 Aug 2024 15:50:21 +0530
Message-ID: <2620452.Lt9SDvczpP@valdaarhun>
In-Reply-To: <CAJaqyWeDxL039GV=QzreenSNGm7S1XWWp=FH2KeB6PLGf=11-w@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <1901750.tdWV9SEqCh@valdaarhun>
 <CAJaqyWeDxL039GV=QzreenSNGm7S1XWWp=FH2KeB6PLGf=11-w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On Tuesday, August 27, 2024 9:00:36=E2=80=AFPM GMT+5:30 Eugenio Perez Marti=
n wrote:
> On Wed, Aug 21, 2024 at 2:20=E2=80=AFPM Sahil <icegambit91@gmail.com> wro=
te:
> > [...]
> > I have been trying to test my changes so far as well. I am not very cle=
ar
> > on a few things.
> >=20
> > Q1.
> > I built QEMU from source with my changes and followed the vdpa_sim +
> > vhost_vdpa tutorial [1]. The VM seems to be running fine. How do I check
> > if the packed format is being used instead of the split vq format for
> > shadow virtqueues? I know the packed format is used when virtio_vdev has
> > got the VIRTIO_F_RING_PACKED bit enabled. Is there a way of checking th=
at
> > this is the case?
>=20
> You can see the features that the driver acked from the guest by
> checking sysfs. Once you know the PCI BFN from lspci:
> # lspci -nn|grep '\[1af4:1041\]'
> 01:00.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
> device [1af4:1041] (rev 01)
> # cut -c 35
> /sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0/virtio0/features 0
>=20
> Also, you can check from QEMU by simply tracing if your functions are
> being called.
>=20
> > Q2.
> > What's the recommended way to see what's going on under the hood? I tri=
ed
> > using the -D option so QEMU's logs are written to a file but the file w=
as
> > empty. Would using qemu with -monitor stdio or attaching gdb to the QEMU
> > VM be worthwhile?
>=20
> You need to add --trace options with the regex you want to get to
> enable any output. For example, --trace 'vhost_vdpa_*' print all the
> trace_vhost_vdpa_* functions.
>=20
> If you want to speed things up, you can just replace the interesting
> trace_... functions with fprintf(stderr, ...). We can add the trace
> ones afterwards.

Understood. I am able to trace the functions that are being called with
fprintf. I'll stick with fprintf for now.

I realized that packed vqs are not being used in the test environment. I
see that in "hw/virtio/vhost-shadow-virtqueue.c", svq->is_packed is set
to 0 and that calls vhost_svq_add_split(). I am not sure how one enables
the packed feature bit. I don't know if this is an environment issue.

I built qemu from the latest source with my changes on top of it. I followed
this article [1] to set up the environment.

On the host machine:

$ uname -a
Linux fedora 6.10.5-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14 15:49=
:25 UTC 2024 x86_64 GNU/Linux

$ ./qemu/build/qemu-system-x86_64 --version
QEMU emulator version 9.0.91

$ vdpa -V
vdpa utility, iproute2-6.4.0

All the relevant vdpa modules have been loaded in accordance with [1].

$ lsmod | grep -iE "(vdpa|virtio)"
vdpa_sim_net	12288  0
vdpa_sim		24576  1 vdpa_sim_net
vringh		32768  2 vdpa_sim,vdpa_sim_net
vhost_vdpa		32768  2
vhost		65536  1 vhost_vdpa
vhost_iotlb		16384  4 vdpa_sim,vringh,vhost_vdpa,vhost
vdpa		36864  3 vdpa_sim,vhost_vdpa,vdpa_sim_net

$ ls -l /sys/bus/vdpa/devices/vdpa0/driver
lrwxrwxrwx. 1 root root 0 Aug 30 11:25 /sys/bus/vdpa/devices/vdpa0/driver -=
> ../../bus/vdpa/drivers/vhost_vdpa

In the output of the following command, I see ANY_LAYOUT is supported.
According to virtio_config.h [2] in the linux kernel, this represents the
layout of descriptors. This refers to split and packed vqs, right?

$ vdpa mgmtdev show
vdpasim_net:=20
  supported_classes net
  max_supported_vqs 3
  dev_features MTU MAC STATUS CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 AC=
CESS_PLATFORM

$ vdpa dev show -jp
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "vdpasim_net",
            "vendor_id": 0,
            "max_vqs": 3,
            "max_vq_size": 256
        }
    }
}

I started the VM by running:

$ sudo ./qemu/build/qemu-system-x86_64 \
=2Denable-kvm \
=2Ddrive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=3D=
virtio \
=2Dnet nic,model=3Dvirtio \
=2Dnet user,hostfwd=3Dtcp::2226-:22 \
=2Dnetdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
=2Ddevice virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpci.0,addr=3D0x7,disabl=
e-legacy=3Don,disable-modern=3Doff,page-per-vq=3Don,event_idx=3Doff,packed=
=3Don \
=2Dnographic \
=2Dm 2G \
=2Dsmp 2 \
=2Dcpu host \
2>&1 | tee vm.log

I added the packed=3Don option to -device virtio-net-pci.

In the VM:

# uname -a
Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11 18:25:=
26 UTC 2024 x86_64 GNU/Linux

# lspci -nn | grep -i -A15 "\[1af4:1041\]"
00:07.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network device=
 [1af4:1041] (rev 01)

# cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
0

The packed vq feature bit hasn't been set. Am I missing something here?

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-1
[2] https://github.com/torvalds/linux/blob/master/include/uapi/linux/virtio=
_config.h#L63




