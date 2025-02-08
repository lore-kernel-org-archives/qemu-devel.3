Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FEC02199
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 02:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgaGD-0004BJ-L1; Fri, 07 Feb 2025 21:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@gmail.com>)
 id 1tgaGB-0004Ap-Q0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 21:07:55 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@gmail.com>)
 id 1tgaG9-0007Je-P3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 21:07:55 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so20955975ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738980472; x=1739585272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTMdW6hNFsTAb1VH85K0+3nOEFz1Thjnz9Om4MyPZDU=;
 b=lYc+dpm1oXMz5zuCH4fsF1Nu25ksgYqhaIdnIEDN0AeKaC7n2tYA+aFmt8lEvmBeLt
 oXYUvGKmUH9N/gmyjA/18Iw+WIyQGIh9K9swPuxfwMeh16gfIcbMobdroabQSc/R0HX9
 AhCb8+f2cYNgWgCJO9qoz1RagBmk8fWI4Oc57em6DblYzWEF2f9ergyB4NJgnvfTOgHu
 d2lT4kfNmUg1XC5ohA7sWncFjirhqTqG1zugh2+ggcfl6OMq8uxY9GKpAh7CpKYqdY60
 AJXAgOzIt8w7JrypMWY+4TA9qSUYsnZ/QcDncMOeCv12Slw9L4PlhgVFb9/4KqjGN3QS
 sHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738980472; x=1739585272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTMdW6hNFsTAb1VH85K0+3nOEFz1Thjnz9Om4MyPZDU=;
 b=O/SY5Giv1CpVFLDCOZmtE9BzV2eXanrV4YjqNlyHUbKCdEpyJlrewobk/9HTIXABAA
 Yv9ExRLYpf3PacnZv2vDoQjRpTaYQLrRLkzuvWETMwWXEkL772bbWgokvRW7KXdG09R+
 XNBjhA9OgIC3fXcmpS7jxW2OR5WJlNVTg3lB5AZkKR2b+kJe2C+DPQQCsB7sZNb2RJrA
 gx9RRMJSzyC13eiR1Lmw0Ib95vjd5cAPT/JWBKviuBTAcTN9R5/tbRZnZzYaQpthAUAd
 IymLeORy1yIGqTFGXbRgv3clPi+VbkIW6Y4fI5qoOOBrdXTT3KKnd7KT1zFMU9tfzlHS
 zg9Q==
X-Gm-Message-State: AOJu0YzQXaGvIvonIdVhBKwH/Cv2d8dhSq40eOTwQIv6rrUVSxfEn6PO
 xCTJmB8lcrJtqU9JkbtcBqg67ujC8ZRX2uuBwFt+U+mNUiKOrNlCzaMvplg53Xu+SUkFvaWUtvU
 Kgwmo5tJwo79F8lN1EKTeG8BgU6A=
X-Gm-Gg: ASbGncsNV+3fc1GM3CDbOytNp2i8sGx26lav4B7S2ytgjW5kfHBj6cZsHXpgLZPZ7U0
 S4lHlLtI3FgNj0mZWeEBdlTGAIJdZxpLAS11/5n3nnJ86Es5NXCC8mU1PoQMnc/Q5vLxhklFeHq
 SLXA==
X-Google-Smtp-Source: AGHT+IFYR5arAQZKPJ4H0AH9VCzSGmRFT8cYL+mhkVufL0LpZIgzwCzWwiIzH66qRajKZgczbYnJ/eJfynhjWaR5XAE=
X-Received: by 2002:a17:902:db0b:b0:21f:123b:8f84 with SMTP id
 d9443c01a7336-21f4e76ec2amr97398115ad.46.1738980471702; Fri, 07 Feb 2025
 18:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <CAMj5Bki73PNZdZvNAsK1YJiWGMeZugQCZ18QPekCM5EN61QqBg@mail.gmail.com>
 <62d4bffa-a912-48b4-9a7c-b16b21bffb7a@oracle.com>
In-Reply-To: <62d4bffa-a912-48b4-9a7c-b16b21bffb7a@oracle.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Sat, 8 Feb 2025 10:07:40 +0800
X-Gm-Features: AWEUYZl1VAjvmacfxZ2ekARikAbYi_kzLmN2XJSxkjuU1uXv9Q0eLxvv2cd3OBU
Message-ID: <CAMj5Bkh9zEGBa6NgWAD3X7F4sG_we5tnKKyQdA6HF_ZyPBqwjA@mail.gmail.com>
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
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
 Zhangfei Gao <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangfei.gao@gmail.com; helo=mail-pl1-x635.google.com
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

On Wed, Jan 22, 2025 at 12:43=E2=80=AFAM Joao Martins <joao.m.martins@oracl=
e.com> wrote:
>
> On 07/01/2025 06:55, Zhangfei Gao wrote:
> > Hi, Joao
> >
> > On Fri, Jun 23, 2023 at 5:51=E2=80=AFAM Joao Martins <joao.m.martins@or=
acle.com> wrote:
> >>
> >> Hey,
> >>
> >> This series introduces support for vIOMMU with VFIO device migration,
> >> particurlarly related to how we do the dirty page tracking.
> >>
> >> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
> >> provide dma translation services for guests to provide some form of
> >> guest kernel managed DMA e.g. for nested virt based usage; (1) is spec=
ially
> >> required for big VMs with VFs with more than 255 vcpus. We tackle both
> >> and remove the migration blocker when vIOMMU is present provided the
> >> conditions are met. I have both use-cases here in one series, but I am=
 happy
> >> to tackle them in separate series.
> >>
> >> As I found out we don't necessarily need to expose the whole vIOMMU
> >> functionality in order to just support interrupt remapping. x86 IOMMUs
> >> on Windows Server 2018[2] and Linux >=3D5.10, with qemu 7.1+ (or reall=
y
> >> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8=
)
> >> can instantiate a IOMMU just for interrupt remapping without needing t=
o
> >> be advertised/support DMA translation. AMD IOMMU in theory can provide
> >> the same, but Linux doesn't quite support the IR-only part there yet,
> >> only intel-iommu.
> >>
> >> The series is organized as following:
> >>
> >> Patches 1-5: Today we can't gather vIOMMU details before the guest
> >> establishes their first DMA mapping via the vIOMMU. So these first fou=
r
> >> patches add a way for vIOMMUs to be asked of their properties at start
> >> of day. I choose the least churn possible way for now (as opposed to a
> >> treewide conversion) and allow easy conversion a posteriori. As
> >> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
> >> allows us to fetch PCI backing vIOMMU attributes, without necessarily
> >> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
> >> was doing in v3.
> >>
> >> Patches 6-8: Handle configs with vIOMMU interrupt remapping but withou=
t
> >> DMA translation allowed. Today the 'dma-translation' attribute is
> >> x86-iommu only, but the way this series is structured nothing stops fr=
om
> >> other vIOMMUs supporting it too as long as they use
> >> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
> >> are handled. The blocker is thus relaxed when vIOMMUs are able to togg=
le
> >> the toggle/report DMA_TRANSLATION attribute. With the patches up to th=
is set,
> >> we've then tackled item (1) of the second paragraph.
> >
> > Not understanding how to handle the device page table.
> >
> > Does this mean after live-migration, the page table built by vIOMMU
> > will be re-build in the target guest via pci_setup_iommu_ops?
>
> AFAIU It is supposed to be done post loading the vIOMMU vmstate when enab=
ling
> the vIOMMU related MRs. And when walking the different 'emulated' address=
 spaces
>  it will replay all mappings (and skip non-present parts of the address s=
pace).
>
> The trick in making this work largelly depends on individual vIOMMU
> implementation (and this emulated vIOMMU stuff shouldn't be confused with=
 IOMMU
> nesting btw!). In intel case (and AMD will be similar) the root table poi=
nter
> that's part of the vmstate has all the device pagetables, which is just g=
uest
> memory that gets migrated over and enough to resolve VT-d/IVRS page walks=
.
>
> The somewhat hard to follow part is that when it replays it walks all the=
 whole
> DMAR memory region and only notifies IOMMU MR listeners if there's a pres=
ent PTE
> or skip it. So at the end of the enabling of MRs the IOTLB gets reconstru=
cted.
> Though you would have to try to understand the flow with the vIOMMU you a=
re using.
>
> The replay in intel-iommu is triggered more or less this stack trace for =
a
> present PTE:
>
> vfio_iommu_map_notify
> memory_region_notify_iommu_one
> vtd_replay_hook
> vtd_page_walk_one
> vtd_page_walk_level
> vtd_page_walk_level
> vtd_page_walk_level
> vtd_page_walk
> vtd_iommu_replay
> memory_region_iommu_replay
> vfio_listener_region_add
> address_space_update_topology_pass
> address_space_set_flatview
> memory_region_transaction_commit
> vtd_switch_address_space
> vtd_switch_address_space_all
> vtd_post_load
> vmstate_load_state
> vmstate_load
> qemu_loadvm_section_start_full
> qemu_loadvm_state_main
> qemu_loadvm_state
> process_incoming_migration_co

Thanks Joao for the info

Sorry, some more questions,

When src boots up, the guest kernel will send commands to qemu.
qemu will consume these commands, and trigger

smmuv3_cmdq_consume
smmu_realloc_veventq
smmuv3_cmdq_consume
smmuv3_cmdq_consume SMMU_CMD_CFGI_STE
smmuv3_install_nested_ste
iommufd_backend_alloc_hwpt
host_iommu_device_iommufd_attach_hwpt

After live-migration, the dst does not get these commands, so it does
not call smmuv3_install_nested_ste etc.
so the dma page table is not set up and the kernel reports errors.

Not sure if we need to set up these commands in the dst, or directly
copy the existing page table from src to the dst.

Thanks

