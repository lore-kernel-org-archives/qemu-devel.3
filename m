Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BDCC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubie0-0004Zc-Vp; Tue, 15 Jul 2025 12:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubi6E-0000QL-Jh
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubi6C-0000my-6B
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752595301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQ0j1/DqwHYNjpT8525Bm0Q0Yv2cqtqle57qb7lTBDY=;
 b=F3cPCG0CJNeqVPDy2rv4EOlAjxFm7m++co3+UkBr/e+9jW3XmNyl3ZY/WUH8foXeB8Vt9C
 /BPGw1j0knrGcNBbHTRgA0HRY6LWZJ2tuxRZG+4OJ2YP298sQ4djPK5KG1ROIYAuIo4p9u
 T42y9LOdFhS+7GRkaayjtv2ezMQ5vBU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-BFjdHVa3OZ67IQtgHZcLGQ-1; Tue, 15 Jul 2025 12:01:34 -0400
X-MC-Unique: BFjdHVa3OZ67IQtgHZcLGQ-1
X-Mimecast-MFC-AGG-ID: BFjdHVa3OZ67IQtgHZcLGQ_1752595293
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae371f9e3f5so1443266b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752595292; x=1753200092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQ0j1/DqwHYNjpT8525Bm0Q0Yv2cqtqle57qb7lTBDY=;
 b=IA+z6BZlmxbmn8jxQcL+9A/sqcUMXUbuU0Ex5ToGEleSBZm5m7Tpc/mJ8rntlRnQQc
 H3R0E7RjH2M8/cheYFa3BuA64JSS7Ms/mynQWfqMfq8vLkQt9TNqNotSVE4HKV39nasy
 ZcAKhiXuYrGvLzrmx8G37t9PU0BnO5fXlF9KjGYRyDMLo87DPWOB2CRKp87uvihPDPfm
 P4IseGmqfoogiNy7cOmfl8ia+Ktsu/MB6GlvFfZoXO7izsvAas8fqE24Qc6nzNPVfflK
 jwy4qYTrvI9BqjiWMRpTYgbqCDnKw4OhJlSK+B+rcWhLVfk3+QXKMYfQzLVFy+UuKnFH
 yNkg==
X-Gm-Message-State: AOJu0YxL+K5JdnnyxE3Kpv+EOQSdoRBpTWIpr+bY6PH6oCI/3OXpuAxy
 qtzionXFtnttB49XIsqHk/CD9exaxUPFPWQC/++1KogW7g2ouQdpGAXTepl04FbWNXuXL8fSWdr
 eXwVYTTHwpR/QwCBc/AmZ1SKw/1Mg1YVeKrGT3d4P+2lYCe27go5pC6YKPrBNimjkaqJPXEJfp6
 7AiwFn1EeKX1qXU9hzw12eC7Fc74r7puEUvLaRw9hSdg==
X-Gm-Gg: ASbGncus2rDr4U8n2q2mnNsd72M4siYfG7lXdiLMmg7ZJXTLhSwxU7YnfkYTH7u7w4n
 HSCVJlBEhm34w04Yjdok7wbMC3VZ//bU0E8JXdYPSnU1T4C05qO3NIYJm0zv5ytW/uWgWuv4HwY
 yd0rjAnbGRNse6s4Ekpicn1Q==
X-Received: by 2002:a17:907:6d10:b0:ae6:f7b5:70b4 with SMTP id
 a640c23a62f3a-ae9b5d3255cmr491381266b.16.1752595291994; 
 Tue, 15 Jul 2025 09:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBNkiu+KQ5oFA0wwnTagSgW/CRAwhWpJ4c1BHoReinXdEEf7eauOJVlEwHLa0R5HQVe1DaLCb/j1PYAiAn6ZY=
X-Received: by 2002:a17:907:6d10:b0:ae6:f7b5:70b4 with SMTP id
 a640c23a62f3a-ae9b5d3255cmr491368266b.16.1752595291206; Tue, 15 Jul 2025
 09:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
 <e0d7a518-7736-4de1-814c-578f14e591f2@linux.ibm.com>
In-Reply-To: <e0d7a518-7736-4de1-814c-578f14e591f2@linux.ibm.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 16 Jul 2025 00:00:54 +0800
X-Gm-Features: Ac12FXwbzANFFYILs9MpijrHBLLCk_jwZgVFJCwhCCMj8OCKSYeIH2n0WXXELOI
Message-ID: <CAPpAL=wXjo7tBzZAcNV01Lm3nZBx6+O2KqaN4JgGaP6WyPNaXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] virtio-net: Fix VLAN filter table reset timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, 
 Konstantin Shkolnyy <kshk@linux.ibm.com>, eperezma@redhat.com, mst@redhat.com, 
 jasowang@redhat.com, virtualization@lists.linux.dev, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Tested v2 again with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 10:28=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 14-Jul-25 04:31, Akihiko Odaki wrote:
> > Konstantin, I would also want you to test this new version. Please also
> > give it Tested-by, and, if possible, Reviewed-by.
>
> It works as expected during the boot. All bits in vlans[] remain set
> until virtio_pci_common_write(VIRTIO_PCI_GUEST_FEATURES) comes with
> VIRTIO_NET_F_CTRL_VLAN set, and clears vlans[]. Then I see
> virtio_net_set_status(0xb) and virtio_net_set_status(0xf).
>
> I can't test migration because currently it's not supported on s390 for
> PCI devices.
>
> Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>
>


