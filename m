Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3505DC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuviU-0003tK-DB; Wed, 19 Mar 2025 11:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuviB-0003pz-Rm
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuvi8-0004h3-FZ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742399518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NmCZjd2FDDptlUuBh0kgbGj6liQHFttIzzq9dcJsuI=;
 b=ObSQZn0Wkiht12g9Rh9K0sklAEfXSFKLeHs8BP17A+68IIRJp0RxQGpHIi0qvyLvXeoJ+T
 P+PpdPROovXXDbYUyxYeJV+RFToZL+pJuU6zUvRZjDDVUsTygRbo5QyOIWgU6iQEIM0PiT
 Mh28Q9aPpGAcWLUXsxajaupyLzVBu0E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-etoL6-pLPdOuuIw8Co6GPQ-1; Wed, 19 Mar 2025 11:51:57 -0400
X-MC-Unique: etoL6-pLPdOuuIw8Co6GPQ-1
X-Mimecast-MFC-AGG-ID: etoL6-pLPdOuuIw8Co6GPQ_1742399516
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so4527814f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 08:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742399515; x=1743004315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NmCZjd2FDDptlUuBh0kgbGj6liQHFttIzzq9dcJsuI=;
 b=s92u0swwo9C67CpCg253tXtVKZhuSKy4OmpU9JBPLsPkUislgXhGyB2n1rrezu8XFy
 vRmlG4fP+oNK7iCMvVqt+uM6DFLVNTcWsa0af3WDASHOrw4UmTHbXJ5mE+UpZcCam8OJ
 i/WkIxl0ZmPQPy4PK/Diq9xcKrp6GeKQZBeJqRTD5wJBoMi66wgSDaHwsVlLFJAU8Ep9
 D14iO71dDNKy0nMrJalmZZOgj7ZSqh9Z7mETlawLSSbAEwLIpISuTKWuL4LxFzyLh+b6
 qAE5dHSxG+CjeNXgfybaXjcMgW6Q4TaJ1mniDqadHsWC/hJvK2AnQBFxVoa/zVleRSa6
 nofA==
X-Gm-Message-State: AOJu0YyIyUzSGyk/cO3bnWiCLV6EXbzmY43aw6H6gSqFLwEiQ85woaYu
 Q80mB/0rzVd9srl1Rzml+F9kqqL1frzQ53iFCXpPiHV7S295p4PwAVEgmJa5Z4Y6oxbubud/k2Z
 Ch6FIFOcgi2XxER0ZMmTBrdklmrQJthCj2KNUv5D0T6UPjKX1w7QInVC7xBD+rH4eHcPIB3AOXY
 nv+5VYkfJJiSshGWg2wfQdlYVafdwLs2BiAUo=
X-Gm-Gg: ASbGncu5Mk54V2Mrw841cnELpM+hqhLyiQNFRjZSKgJAkFgo0zqlKCrlshhIRJAEXGu
 bi/KcLu607SLVJXJPFlzlMbnJNyGNI1WcyZLQ6FtTnpoL8ist5NckCN4zu6Je7UEwINQF1a28XA
 ==
X-Received: by 2002:a05:6000:2c7:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39973afa511mr3964069f8f.40.1742399515141; 
 Wed, 19 Mar 2025 08:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAPP1+0qjkE5HL5DaEj+p+ESr+olIFxg04dKDv/DPKOOjnUfYJ0o7nE128z5Pg10Ue7yE12SEY8KJYl/IBAm4=
X-Received: by 2002:a05:6000:2c7:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39973afa511mr3964042f8f.40.1742399514720; Wed, 19 Mar 2025
 08:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-6-pbonzini@redhat.com>
 <8183674f-a9cc-4727-bb52-fe3d3e44804b@proxmox.com>
 <CABgObfaKJ5NFVKmYLFmu4C0iZZLJJtcWksLCzyA0tBoz0koZ4A@mail.gmail.com>
 <dffba4bb-081b-4f34-a9d4-ce16d8d6a15a@proxmox.com>
In-Reply-To: <dffba4bb-081b-4f34-a9d4-ce16d8d6a15a@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Mar 2025 16:51:43 +0100
X-Gm-Features: AQ5f1Jrn4ks-jO9h5cFRTcHiZ_xP9CAmjEq3VCqPqoPbM49aPQLhrKSJrThVpdo
Message-ID: <CABgObfYnOzg=BPeG5BjSmGEV_Q0pR7xGg6L3XNQCONtU_GiuGA@mail.gmail.com>
Subject: Re: [PULL 05/11] hpet: fix and cleanup persistence of interrupt status
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 19, 2025 at 4:47=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
> We'll only be able to disable it starting from a new (downstream)
> machine version, but that is fine. For now, I'll go for the revert,
> thank you for the suggestion! Is disabling it strongly suggested because
> of those bug reports? Or are there issues in general?

No, the bug reports are really just for corner cases and there are no
huge issues. However, both Linux and Windows give the HPET a
relatively high priority that it probably does not deserve. :)

For Linux you should be using kvmclock already, and for Windows the
Hyper-V paravirtualized clock. If you don't have the Hyper-V pv clock,
the RTC periodic timer is more battle-tested as an emulated
clock/timer device; disabling the HPET ensures that Windows uses the
RTC.

Paolo


