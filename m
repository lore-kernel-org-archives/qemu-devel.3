Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E57E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 06:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3VW-0006be-Bq; Tue, 07 Jan 2025 01:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@gmail.com>)
 id 1tV3VU-0006bQ-KP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 01:56:04 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@gmail.com>)
 id 1tV3VS-0004Ju-SV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 01:56:04 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso16374497a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 22:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736232961; x=1736837761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjkY+h+3PAVYP0RDSnP8zFyX0O1SvOK7FYUU1P1wjuc=;
 b=T59d0fhW+GaYLkZGOgxjdd59rObYKKxOlqIa6pioGAT24pwiUx7LPUXL4Xx6oxkoBb
 YOdPMyIS7cd3hFKWKpPxSPwy/ggAnzEABITOyyR86UWCa0H3bnzrswF374n+YGeGqGdF
 UNMmDcSKeaXyL2Ms2086UZhljrwdSbg4C4yWhZVf+FgMPdRDDgI19qy4OpsvMnr6lk9o
 bxbbxGURjSmYu3A4vncyiapkoEh/BSDMjFuETAqWm84bfwXMWVqc+kqPlCwu6BVmu6sZ
 Z8x9TyIBHKze6WiSFggSllnynCDfmX0s5218g5xoGu3EAvsHGETqyE/nMc8Tj8Qj5ZYd
 k7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736232961; x=1736837761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjkY+h+3PAVYP0RDSnP8zFyX0O1SvOK7FYUU1P1wjuc=;
 b=hdFfDuFTQVrca9UObxT7R9b7wH0vCCTbae7rLzboSvQ5nqlduW22bQwor1hCuaYmCI
 WBGtYBgdUVYWR0s4xEtB0sGArjcCbcS/tCCw23IIFC1ZuLQ9ctboCNABqocb7JCh+9BH
 zMxIuUS/QwCW4g5DjrnndjR9EfiGLNnHmWFzRdqvfwsjH/895xuaeeifvQ4JegAUAhPx
 VR8l6sALbdhT/ZvSvs4hrhr458tmuBdWCRmlNUAEvhZd+2/vwy77CLobqdiXaWuUNA8/
 I/V8usIoTW/YF3c8dDrCP0Bu90QW7Kxg9ODbGLis2sBnVgG04DYQDUYZiTasyt/XShCU
 Vn+Q==
X-Gm-Message-State: AOJu0YxvuLOVv+eefwHg+Yakb3kraRD2p2JG2OKIEtXQrwDK6zOaZxhq
 wz8xcEcq3rE8ccGICkbBWVEirzRz2ZtKG/kKU05IKhHS35gAYbbTIZKQLM4WsqgHOzQfSbaGUV2
 1RVEu4ZZfaSNeLe/CnCcpP6Voe2g=
X-Gm-Gg: ASbGncurRLof79bflP5pX3PUy+mFCstR3kZ7+Kvn4mYpo5wiNwt7qBrCVMlrHd/L9dx
 MYxBXGSiW7lNPOo4P0U7cwgKUc0ZbQ4f9cOyTCemp80c=
X-Google-Smtp-Source: AGHT+IETKWJ40R/SxPDkwGI3lsZI7j/UiBbeCzuDmwt4hMwzT42E3yMOygxi+UiQXLUlGioeOEpvAIKf5UF28Z9LPzE=
X-Received: by 2002:a17:90b:2c8e:b0:2ef:2d9f:8e55 with SMTP id
 98e67ed59e1d1-2f452e458e5mr97271841a91.17.1736232960786; Mon, 06 Jan 2025
 22:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Tue, 7 Jan 2025 14:55:49 +0800
X-Gm-Features: AbW1kvZ0e3DvMC6UJquw_C4kE0tJ_4rq-wxgQP9KWYVP7qlwKOMMEH0a3Rt8ygI
Message-ID: <CAMj5Bki73PNZdZvNAsK1YJiWGMeZugQCZ18QPekCM5EN61QqBg@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangfei.gao@gmail.com; helo=mail-pj1-x102b.google.com
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

Hi, Joao

On Fri, Jun 23, 2023 at 5:51=E2=80=AFAM Joao Martins <joao.m.martins@oracle=
.com> wrote:
>
> Hey,
>
> This series introduces support for vIOMMU with VFIO device migration,
> particurlarly related to how we do the dirty page tracking.
>
> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
> provide dma translation services for guests to provide some form of
> guest kernel managed DMA e.g. for nested virt based usage; (1) is special=
ly
> required for big VMs with VFs with more than 255 vcpus. We tackle both
> and remove the migration blocker when vIOMMU is present provided the
> conditions are met. I have both use-cases here in one series, but I am ha=
ppy
> to tackle them in separate series.
>
> As I found out we don't necessarily need to expose the whole vIOMMU
> functionality in order to just support interrupt remapping. x86 IOMMUs
> on Windows Server 2018[2] and Linux >=3D5.10, with qemu 7.1+ (or really
> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
> can instantiate a IOMMU just for interrupt remapping without needing to
> be advertised/support DMA translation. AMD IOMMU in theory can provide
> the same, but Linux doesn't quite support the IR-only part there yet,
> only intel-iommu.
>
> The series is organized as following:
>
> Patches 1-5: Today we can't gather vIOMMU details before the guest
> establishes their first DMA mapping via the vIOMMU. So these first four
> patches add a way for vIOMMUs to be asked of their properties at start
> of day. I choose the least churn possible way for now (as opposed to a
> treewide conversion) and allow easy conversion a posteriori. As
> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
> allows us to fetch PCI backing vIOMMU attributes, without necessarily
> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
> was doing in v3.
>
> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
> DMA translation allowed. Today the 'dma-translation' attribute is
> x86-iommu only, but the way this series is structured nothing stops from
> other vIOMMUs supporting it too as long as they use
> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
> the toggle/report DMA_TRANSLATION attribute. With the patches up to this =
set,
> we've then tackled item (1) of the second paragraph.

Not understanding how to handle the device page table.

Does this mean after live-migration, the page table built by vIOMMU
will be re-build in the target guest via pci_setup_iommu_ops?
Or done by page-fault again?

Thanks

