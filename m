Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903CFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdJw-00014P-4Q; Mon, 11 Mar 2024 06:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjdJu-00014D-Dj
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjdJj-0006hu-VL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710154539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKLfNinsugPgo1c9nFFEWQfwl4qtOWnF6NPRgJPm0tE=;
 b=GUtKbCYtVuVEtv413hLstnFDNdgk+74xmB7zxdhKf7rkXTkqkO2lyfLOnz+d5BFtRURvgD
 SBmfCNgKjDKX4NzwVQw2cbhAjluMFVU/BRPNNwDF8kgFIkxLFMQByJiV5nWzyhTFQbseFx
 gnJ2cy87Q+n25qDwdJrrqHeCivQnFgU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-x1dmJ9jMMUSnyoKJ2sFGTg-1; Mon, 11 Mar 2024 06:55:37 -0400
X-MC-Unique: x1dmJ9jMMUSnyoKJ2sFGTg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e705fb2abso1755596f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 03:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710154536; x=1710759336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKLfNinsugPgo1c9nFFEWQfwl4qtOWnF6NPRgJPm0tE=;
 b=iTTWfd9TyKTnWIfnXvPKpHkVc2eQzqp7OYLVbYG0goRFC2b864gsEESc2E5rnNFcrl
 swB/ui+9TZwCec2wu2JmgQPgJuokkfoFRpqmCS3Ft76EiXcvrDEL6qNQO/0Jk0d4U96u
 mfkMWXjyOflLVNPttmphaHU8qSY4H1tDXScEf89lBqdH1dc/1wHncIGtMBmsFsrPyTp/
 4hQvENgs56abszdaP946xApppb42cNqRUJeER6nZ9rKQMKOrnqTDEHMN7xwDewTyR2PX
 W+nGEhyNFppB0+KzAUPzed/fy0IQOKKhzLxK2nIad+oDG4Kl3un8xRp6F9CpOrZ27Ud9
 cyYg==
X-Gm-Message-State: AOJu0YzlEyeLHRVfqcPtHkla+bLt3q9wubjNyNkJjNTA8JRUS5zC0S36
 FsG0Zxscn9QCfbI+3z8X7k7F7TJvkM9P4uZ+ZrwIvLdYl8fHsWSLIadzJPWwdSZ2NchAVyEmeUY
 nWuhGyrRCb6rIVmOc4Lf7d/Mt218RtxDZHMPvHPNQj67m0EfKhswMuLS0S6W6EspSsimp9Vo0IH
 c15H2Urfdg3PszBrNZCZNPhy1kIp7YGDCQEGrCJg==
X-Received: by 2002:a5d:4561:0:b0:33e:78d2:7f7 with SMTP id
 a1-20020a5d4561000000b0033e78d207f7mr4004273wrc.55.1710154536315; 
 Mon, 11 Mar 2024 03:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELvTkNiWzZC7Zkz0N4AKIUHVo/Xeko8sEFJTK5TnsT3SHw1+nxSrBrSR/dQ6A7wyj0Hnlad5BFyTNR/YlN+o0=
X-Received: by 2002:a5d:4561:0:b0:33e:78d2:7f7 with SMTP id
 a1-20020a5d4561000000b0033e78d207f7mr4004260wrc.55.1710154536013; Mon, 11 Mar
 2024 03:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240305105233.617131-1-kraxel@redhat.com>
 <20240305105233.617131-3-kraxel@redhat.com>
In-Reply-To: <20240305105233.617131-3-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2024 11:55:23 +0100
Message-ID: <CABgObfZ13WEHaGNzjy0GVE2EAZ=MHOSNHS_1iTOuBduOt5q_3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kvm: add support for guest physical bits
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 5, 2024 at 11:52=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> w=
rote:
>
> Query kvm for supported guest physical address bits, in cpuid
> function 80000008, eax[23:16].  Usually this is identical to host
> physical address bits.  With NPT or EPT being used this might be
> restricted to 48 (max 4-level paging address space size) even if
> the host cpu supports more physical address bits.
>
> When set pass this to the guest, using cpuid too.  Guest firmware
> can use this to figure how big the usable guest physical address
> space is, so PCI bar mapping are actually reachable.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/cpu.h     |  1 +
>  target/i386/cpu.c     |  1 +
>  target/i386/kvm/kvm.c | 17 +++++++++++++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f52..d427218827f6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> +    guest_phys_bits =3D kvm_get_guest_phys_bits(cs->kvm_state);
> +    if (guest_phys_bits &&
> +        (cpu->guest_phys_bits =3D=3D 0 ||
> +         cpu->guest_phys_bits > guest_phys_bits)) {
> +        cpu->guest_phys_bits =3D guest_phys_bits;
> +    }

Like Xiaoyao mentioned, the right place for this is kvm_cpu_realizefn,
after host_cpu_realizefn returns. It should also be conditional on
cpu->host_phys_bits. It also makes sense to:

- make kvm_get_guest_phys_bits() return bits 7:0 if bits 23:16 are zero

- here, set cpu->guest_phys_bits only if it is not equal to
cpu->phys_bits (this undoes the previous suggestion, but I think it's
cleaner)

- add a property in x86_cpu_properties[] to allow configuration with TCG.

Paolo

> +
>      /*
>       * kvm_hyperv_expand_features() is called here for the second time i=
n case
>       * KVM_CAP_SYS_HYPERV_CPUID is not supported. While we can't possibl=
y handle
> --
> 2.44.0
>


