Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2BCC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 14:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsjCz-0006MW-B6; Thu, 13 Mar 2025 10:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsjCr-0006M7-0n
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsjCp-0005gC-Ez
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741874798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9iA4d1tAkCZAqEX1kydnE36V7Z8aSZWlnXlgShijZw4=;
 b=TFuArIiZGiVy+nuR2u7GGd0P1gf9Bq8JpplKdx/DYcjfECCROlsnapPIVaeLZKg+WZ0fgE
 HZwD+xF2vQTXSS3tyi3zUZuq9wirldQ1Fp1Awhbzx6OeubtPqnMiV0qRyA+aTFl939cn6m
 hzVPVYvuzmDC6Hxd0687odEBZQAR6LQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-0xq9iEabNhGP6g6c5CG4cw-1; Thu, 13 Mar 2025 10:06:34 -0400
X-MC-Unique: 0xq9iEabNhGP6g6c5CG4cw-1
X-Mimecast-MFC-AGG-ID: 0xq9iEabNhGP6g6c5CG4cw_1741874793
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac29f1e54baso89287666b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741874793; x=1742479593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iA4d1tAkCZAqEX1kydnE36V7Z8aSZWlnXlgShijZw4=;
 b=tT6fxmgtsivS9v6eyJRyySFLaHE3akmLeDvvtYYIGM19+OBJfWbitmpC/AxlwUgO+g
 aGKfpPPhu5MlFo9MdZxr+fJx01QX7KpUiig8a16dhxwmIjlDAVzHSNv1Mufn/V0ZWe7Z
 7BW5M2vl3q93eBdi9P8SaoBQn5UJrDzMs8QfI5OTY8Cbev/HgBXWdUVWFykyR3vp8kHM
 Gcgpt82Q8ht5srWa6WJmAxq5WrDF4V4YMm0JEUStKqVB/84PG5sAZmzOQL/Fk/hdejQd
 OFSLZxZ0b+uPpCt/VjAI6kOHI5DVlJnhlWXiCYLPGpo+lvYAdTLTln/bX+cPKfXdDYFh
 /hQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Vi+BS4seudHiOdvw6BzQE33aoiAMQLuixEACQq/A0fwzD2zVQcdMmqwWIs/A3rw+ShxHDKxgZj0K@nongnu.org
X-Gm-Message-State: AOJu0YyWfWfTVc9TTK5ZgkpmpnQBcxoDvmW6PXyBGZilpyey9bVf8pyc
 dwa9al9joinzAxI1/nMRV2oENSj6tS1gX5HrQDIbwAmo3dspK6pYT+XAw4zPwRBzqK72bm+Nz95
 MdMJRcyW2ouhzOl6H1q8kItukZQU0qrc0/WDmTjRjc+b7/f7Wbl5wcFbvdE6UCmfWMspNmnFatj
 hq+3tezjFVt4xtGuzg69Iac/QAcUs=
X-Gm-Gg: ASbGnct6JCjBjmFBqWVkLGNWtOq9HLr4736vaqWi0fVaqlkA+7JG/d+VnVPpgzoU12I
 ldWBC3xwfI/yFYybm4D+T/3BjGT2RxmvPK3BG+MkRvxyNqIPQz8rO+zT1z+bvjZmiFU7b1qpcx8
 A=
X-Received: by 2002:a17:906:f593:b0:ac1:db49:99a3 with SMTP id
 a640c23a62f3a-ac252fc6bdemr3235969066b.40.1741874791092; 
 Thu, 13 Mar 2025 07:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQvFiZF27N31RRf3Gb3dYoc6auj5FaQC6mz2AWQFBTfRnFi3HjInO48nqNLSWYJ9I1SbqnYcwQwDP50fYt0VU=
X-Received: by 2002:a17:906:f593:b0:ac1:db49:99a3 with SMTP id
 a640c23a62f3a-ac252fc6bdemr3235943266b.40.1741874788925; Thu, 13 Mar 2025
 07:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
In-Reply-To: <Z9LeILiEU5GfEHrl@8bytes.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 13 Mar 2025 19:36:17 +0530
X-Gm-Features: AQ5f1JoxVP8v7vhcENkE76VTZoWPzgsJg90EUeyew4PUYpvmSbcznNAftzvUuag
Message-ID: <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Gerd Hoffman <kraxel@redhat.com>, Alex Graf <graf@amazon.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Mar 13, 2025 at 7:01=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> Hi Gerd,
>
> On Thu, Mar 13, 2025 at 01:05:13PM +0100, Gerd Hoffman wrote:
> > // regions_addr points to an array of this structure
> > struct vmfwupdate_regions {
> >     uint64_t size;
> >     uint64_t src_addr;       // source address (before update)
> >     uint64_t dst_addr;       // destination address (after update)
> >     uint64_t flags;          // control bits
> > };
> >
> > // flags
> > #define VMFWUPDATE_REGION_FLAG_COPY     // data must be copied
> > #define VMFWUPDATE_REGION_FLAG_ZERO     // dest must be cleared
> > #define VMFWUPDATE_REGION_FLAG_MEASURE  // data must be measured
> >
> > (1)   is still not covered.
> > (2+3) can be handled with FLAG_ZERO regions, with and without
> >       FLAG_MEASURE.
> > (4)   Alex already pointed that the cpuid page is special, guess we
> >       need additional flags for those oages.
>
> That looks better, when the host VMM guarantees the order in which it
> translates these regions into VM setup calls, then it is a step
> forward. Although there more things to keep in mind, like the guest
> policy and SEV status parameters.
>
> > Open question is what we do about IGVM.
> >
> > One option would be the guest vmfwupdate tool loading and parsing igvm,
> > preparing the region list, then invoke the update.  Problem is that som=
e
> > igvm feaures such as initial register state can not be easily supported
> > that way.
> >
> > We could also expect the hypervisor support igvm, so the guest can
> > simply load the file into memory and pass address and size to the
> > hypervisor.  Either as option, say via VMFWUPDATE_REGION_FLAG_IGVM, or
> > mandatory, i.e. scratch the region list and use IGVM exclusively.
>
> This is of course up to the QEMU maintainers to decide, but I want to
> highlight that IGVM already solves all the problems mentioned above,
> including setting multiple memory regions of different type, special
> data pages (cpuid, secrets, id-blob, vmsa) and more. It defines the
> order of setup calls the VMM has to invoke for the new context and also
> works for multiple platforms like TDX, SNP, non-coco, and in the future
> ARM as well.

My take on this is that instead of making the interface more complex,
let's empower the guest to use IGVM if they think they need more
guarantees around those things that IGVM solves very well today. QEMU
already has IGVM backend support. To that end, we can make small
changes to the hypervisor side so that instructions can be executed by
IGVM loaded in guest memory. My talk in the KVM Forum was "empowering
the guest" :-)

>
> Regards,
>
>         Joerg
>


