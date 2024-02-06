Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A637C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLew-00036Y-5Z; Tue, 06 Feb 2024 08:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rXLet-00036G-8h
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:38:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rXLer-0001Ym-MQ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707226719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRNUGvj0O6Sq5KZdyYr9owqpW87BNjR7MV51I+Ab3c0=;
 b=avo/ALe8B97YZ3BZ3EfB5jUnpem556jI8d+Iw+WR54Kr0gah8nDaG72dZsqTsy8zvnM7hx
 kKxuU0gO4rLLebQ/OpJYMCv3xD9+QNVj+ExcCL3Q017GPLlYGsUCk99cS7KmZQP/yVHbqi
 Do/c/JiB5IEOaQ9cneFRChODoDt+kG8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-1ro20DHZP-a9_aaAiwREhQ-1; Tue, 06 Feb 2024 08:38:37 -0500
X-MC-Unique: 1ro20DHZP-a9_aaAiwREhQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6e2b25d1fe8so314403a34.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226717; x=1707831517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dRNUGvj0O6Sq5KZdyYr9owqpW87BNjR7MV51I+Ab3c0=;
 b=wehZvwTCBwL0iD2MkMwSfo6E5xr9YVPSJ8CSlq4fCW24h3osmwd3R5qDxCHo1gbCc5
 pXSvnJ38eE4YegqObOcdjgIovnR6VV5HrRLeY2BAeJ4VQp7xwr9BALuoZiATyqJ+1ziR
 IpK0g68h8DCIr4ofe6uPE2OoY7H2Z6Cy17rT9bS1Q4NLG9rCjaMF/VFKb/6tFoQUoFaq
 vHdsVtpjAvJ01lqid+GqSSN8lBZikAh7W8LTxCsH85jYIXPQd5naBiwVRQo7yrOgjWKC
 ETll4On2i5JRIu9prg3DjV2T+eCRjh4EG1KUt7urO8CJsHfnz+UV9MX4ddwDqZZNnABa
 CLLQ==
X-Gm-Message-State: AOJu0Yzv6aSNBNxMsvANXF3u6MqBhURw+ziSUQWIv0cIy0+GW4wDwxZ6
 o1SQkfeGJQ4H5rUYjYfhEKx8keA6T6cSYpz0+S/kDbtHXk7gY0S/fkE7AraLmrvOqf8omcl0BXI
 +r2njA/1hltI+NFvNeYX87Yj5j3a3amEN6Mo1nBFlSgmxvb6ns5zMh/P34p9/mKKmVhJIGtzAZs
 zUehaqp73mY/zu7NJrlL0Fn09khvc=
X-Received: by 2002:a05:6830:1e3b:b0:6e0:d4d0:eece with SMTP id
 t27-20020a0568301e3b00b006e0d4d0eecemr2428281otr.19.1707226717277; 
 Tue, 06 Feb 2024 05:38:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlssJpHIJowTBjKMq7ovb50bJCUXz7BftbzkIhm4EJDC5iuU3WayNOg4rwTXc9UTFIC/sllRLr6kZaZpeN7yc=
X-Received: by 2002:a05:6830:1e3b:b0:6e0:d4d0:eece with SMTP id
 t27-20020a0568301e3b00b006e0d4d0eecemr2428267otr.19.1707226716994; Tue, 06
 Feb 2024 05:38:36 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Feb 2024 05:38:35 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20240206021002.208805-1-lixianglai@loongson.cn>
MIME-Version: 1.0
In-Reply-To: <20240206021002.208805-1-lixianglai@loongson.cn>
Date: Tue, 6 Feb 2024 05:38:35 -0800
Message-ID: <CABJz62MEUeWw2pL9TYKxD8E2qWOrzPegCbRVaAd0P+0=5_46mQ@mail.gmail.com>
Subject: Re: [PATCH V2] loongarch: Change the UEFI loading mode to loongarch
To: Xianglai Li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
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

On Tue, Feb 06, 2024 at 10:10:02AM +0800, Xianglai Li wrote:
> The UEFI loading mode in loongarch is very different
> from that in other architectures:loongarch's UEFI code
> is in rom, while other architectures' UEFI code is in flash.
>
> loongarch UEFI can be loaded as follows:
> -machine virt,pflash=3Dpflash0-format
> -bios ./QEMU_EFI.fd
>
> Other architectures load UEFI using the following methods:
> -machine virt,pflash0=3Dpflash0-format,pflash1=3Dpflash1-format
>
> loongarch's UEFI loading method makes qemu and libvirt incompatible
> when using NVRAM, and the cost of loongarch's current loading method
> far outweighs the benefits, so we decided to use the same UEFI loading
> scheme as other architectures.
>
> Cc: Andrea Bolognani <abologna@redhat.com>
> Cc: maobibo@loongson.cn
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  hw/loongarch/acpi-build.c   |  29 +++++++++--
>  hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>  include/hw/loongarch/virt.h |  10 ++--
>  3 files changed, 107 insertions(+), 33 deletions(-)

For future reference, it's usually good practice to keep track of
changes between subsequent versions of the same patchset.

Can you please confirm that the build of edk2 added with [1] is
intended to work with a version of QEMU that contains these changes?
I'd like to test things out as soon as I get a moment.

Thanks.


[1] https://github.com/lixianglai/LoongarchVirtFirmware/commit/985ce19438d9=
544968c7e921c6acf2c74fd4713e
--=20
Andrea Bolognani / Red Hat / Virtualization


