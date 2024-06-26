Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DA2C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTjO-0000jZ-OV; Wed, 26 Jun 2024 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sMTjD-0000hM-4P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sMTjB-00020W-0m
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719412466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LBCozej+B/PUJ8S5t0cl01x7B24++4YHxfIvDavDuI=;
 b=fTL7K+VsToMQTW2U0QGKXwuNCHIwohwuQkHU4u/tAHr1bXVh+36dO0Ohk1D3J7abO8OMnD
 GJVKDdh88kHvzO3tuCClGreg1rVpQm60iw2wKck+L3DG0FfWVQQyqlQE3hHwh+ZAFMRJaD
 fchl5nmyn6XDjeSeG8TMNCR8i5vj7wg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-5zdLsOi_NRq2HZSaRNpmIw-1; Wed, 26 Jun 2024 10:34:24 -0400
X-MC-Unique: 5zdLsOi_NRq2HZSaRNpmIw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a725eed1cecso176598466b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 07:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719412463; x=1720017263;
 h=in-reply-to:references:user-agent:subject:cc:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LBCozej+B/PUJ8S5t0cl01x7B24++4YHxfIvDavDuI=;
 b=ZYWFs1ts8RvfBcxCBAzEok6Y18z+GBOHqsgk1D4aLZ3bU7eaXZegTFCcXVepmpW9x3
 DCKvV/GrP+xX33UhPp2mlr5YAtQNUHsA+QtK5if7oTyu3JUlMNjU5GmNb4SLejPWiy3d
 +8sDjqvuU/D7KGjEGsRAgeCrjfI/z6eBikA+AT21V9h9GZrQInvYeNNF3hENCWaOeczY
 cNpsHAHqxvDEmo3cq1jHtAgcODWwD/FcB7ZYqeoIvHqoI8cEqgEeq0PEqJopfSgwdn7c
 7zF04cvMe3uJgc/BZ8kNPbjgVlwWzYsCgCvUUE7lHjtGZQBDkQaC1/Nik0AEBjhtRrrW
 qz8g==
X-Gm-Message-State: AOJu0YxVYo5Zg0uFBlc5p4SdNvYWWajSrkAYPso28Q9SZ8S2xZqQ2pwY
 L036i1hWiJWYSFKiVNYnSD6Hu1snBrI9La1cwZL6A3heTG1NmPkfkbeFKlXcu/zBZpgYKRaa/4j
 3lC1KILoTSp9YUpe8cDDWCT4BNVYvN8w1xBulEZr2sCBb8zw6yOu+
X-Received: by 2002:a17:906:11c7:b0:a6f:4a42:1976 with SMTP id
 a640c23a62f3a-a7245bacda1mr598111866b.37.1719412463129; 
 Wed, 26 Jun 2024 07:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjtnfaNge1nTBMJiLXs6x9B96jeH1Zsvp8ik1IKa1N95z/ILJ05bnDRHPi4dmeZ8nFbsrC+g==
X-Received: by 2002:a17:906:11c7:b0:a6f:4a42:1976 with SMTP id
 a640c23a62f3a-a7245bacda1mr598109466b.37.1719412462465; 
 Wed, 26 Jun 2024 07:34:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a724d8a362fsm367084166b.158.2024.06.26.07.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 07:34:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 16:34:21 +0200
Message-Id: <D2A0UK7BHZ6L.YM25MR6VFI31@redhat.com>
From: "Anthony Harivel" <aharivel@redhat.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>, <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
User-Agent: aerc/0.17.0-121-g0798a428060d
References: <20240522153453.1230389-1-aharivel@redhat.com>
In-Reply-To: <20240522153453.1230389-1-aharivel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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


Just a gentle ping for the above patch series.


Anthony Harivel, May 22, 2024 at 17:34:
> Dear maintainers,=20
>
> First of all, thank you very much for your review of my patch=20
> [1].
>
> In this version (v6), I have attempted to address all the problems=20
> addressed by Daniel and Paolo during the last review.=20
>
> However, two open questions remains unanswered that would require the=20
> attention of a x86 maintainers:=20
>
> 1)Should I move from -kvm to -cpu the rapl feature ? [2]
>
> 2)Should I already rename to "rapl_vmsr_*" in order to anticipate the=20
>   futur TMPI architecture ? [end of 3]=20
>
> Thank you again for your continued guidance.=20
>
> v5 -> v6
> --------
> - Better error consistency in qio_channel_get_peerpid()
> - Memory leak g_strdup_printf/g_build_filename corrected
> - Renaming several struct with "vmsr_*" for better namespace
> - Renamed several struct with "guest_*" for better comprehension
> - Optimization suggerate from Daniel
> - Crash problem solved [4]
>
> v4 -> v5
> --------
>
> - correct qio_channel_get_peerpid: return pid =3D -1 in case of error
> - Vmsr_helper: compile only for x86
> - Vmsr_helper: use qio_channel_read/write_all
> - Vmsr_helper: abandon user/group
> - Vmsr_energy.c: correct all error_report
> - Vmsr thread: compute default socket path only once
> - Vmsr thread: open socket only once
> - Pass relevant QEMU CI
>
> v3 -> v4
> --------
>
> - Correct memory leaks with AddressSanitizer =20
> - Add sanity check for QEMU and qemu-vmsr-helper for checking if host is=
=20
>   INTEL and if RAPL is activated.
> - Rename poor variables naming for easier comprehension
> - Move code that checks Host before creating the VMSR thread
> - Get rid of libnuma: create function that read sysfs for reading the=20
>   Host topology instead
>
> v2 -> v3
> --------
>
> - Move all memory allocations from Clib to Glib
> - Compile on *BSD (working on Linux only)
> - No more limitation on the virtual package: each vCPU that belongs to=20
>   the same virtual package is giving the same results like expected on=20
>   a real CPU.
>   This has been tested topology like:
>      -smp 4,sockets=3D2
>      -smp 16,sockets=3D4,cores=3D2,threads=3D2
>
> v1 -> v2
> --------
>
> - To overcome the CVE-2020-8694 a socket communication is created
>   to a priviliged helper
> - Add the priviliged helper (qemu-vmsr-helper)
> - Add SO_PEERCRED in qio channel socket
>
> RFC -> v1
> ---------
>
> - Add vmsr_* in front of all vmsr specific function
> - Change malloc()/calloc()... with all glib equivalent
> - Pre-allocate all dynamic memories when possible
> - Add a Documentation of implementation, limitation and usage
>
> Best regards,
> Anthony
>
> [1]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01570.html
> [2]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03947.html
> [3]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02350.html
> [4]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02481.html
>
> Anthony Harivel (3):
>   qio: add support for SO_PEERCRED for socket channel
>   tools: build qemu-vmsr-helper
>   Add support for RAPL MSRs in KVM/Qemu
>
>  accel/kvm/kvm-all.c                      |  27 ++
>  contrib/systemd/qemu-vmsr-helper.service |  15 +
>  contrib/systemd/qemu-vmsr-helper.socket  |   9 +
>  docs/specs/index.rst                     |   1 +
>  docs/specs/rapl-msr.rst                  | 155 +++++++
>  docs/tools/index.rst                     |   1 +
>  docs/tools/qemu-vmsr-helper.rst          |  89 ++++
>  include/io/channel.h                     |  21 +
>  include/sysemu/kvm_int.h                 |  32 ++
>  io/channel-socket.c                      |  28 ++
>  io/channel.c                             |  13 +
>  meson.build                              |   7 +
>  target/i386/cpu.h                        |   8 +
>  target/i386/kvm/kvm.c                    | 431 +++++++++++++++++-
>  target/i386/kvm/meson.build              |   1 +
>  target/i386/kvm/vmsr_energy.c            | 337 ++++++++++++++
>  target/i386/kvm/vmsr_energy.h            |  99 +++++
>  tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++++
>  tools/i386/rapl-msr-index.h              |  28 ++
>  19 files changed, 1831 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>  create mode 100644 tools/i386/rapl-msr-index.h
>
> --=20
> 2.45.1




