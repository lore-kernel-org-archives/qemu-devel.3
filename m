Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88C7CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmb48-0003q6-0f; Tue, 19 Mar 2024 11:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rmb46-0003pg-Am
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rmb44-0006ki-40
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710860860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6F9q+YXbYKCoXfYHDgbcPJJcywmHJ8Ru4epojDtvcw=;
 b=JO5lgAim426yn5RmwJAqL6MglI727eFdwMedaKZQuRJ5I6vJw7+HN8oRoxvUneCyOeQklT
 pbYYaQLGkl9laAgFlb+KWtKYScc6bx4hsTlS5QaZmMPnzJ9lvy4T0m9R/x5WeBcPPbScKb
 h3/Xy2f0FhEG9qEJ2zQaiYI4T5hJrak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-FZr3_qVXPDOKyFn5jFIQ-w-1; Tue, 19 Mar 2024 11:07:38 -0400
X-MC-Unique: FZr3_qVXPDOKyFn5jFIQ-w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed2555b61so2127025f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710860857; x=1711465657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6F9q+YXbYKCoXfYHDgbcPJJcywmHJ8Ru4epojDtvcw=;
 b=rMdqx3jodOejD8/sPvrHrbhxPpM94C1M+i3i+KkWhXnzblPdzutLFm1k2Q0Or3hIW8
 bJ5snhB8GvPN/9wSozLl+6nJxKa/+4SOpv+zuw4hLQRmTRxNaqoS2arfku3Q+d6ogTIY
 InqCLaQBlvcCVS4tHgF6XZm09rrVyQM5UhzkzPv1hr+rysWTMizJyRBQ7WX6ozwU4Lwp
 0bq1lhLu1z5yEM0eaHhUYxfo59iSSnugigO0P00feNgFVOewy+oeAFoCuVjP8s2bpm0w
 bv9a9GbNbb3tQdRHkglGFcSAy8qEeiuuB2D5gXG399FZn9LwWQdBKxZrwRH1VWnHAYIx
 wwmw==
X-Gm-Message-State: AOJu0Yxgn5sC4pwr9G7zFaDPoZEmaoQMo87srqc36y4c40D27XAAvoX1
 QnNiJqLdN59xrUrEPjPLZGcR1qUv1tx8O39XOrhZEGYfn75PcGnrQPxnW0YXBAiFZU1c2Nc6zZC
 QskIfGDpZSgqUDNgcRrBf5uPL/aAwBC09DoADVUupKVlEmdEdr4wI
X-Received: by 2002:adf:ec8f:0:b0:33e:d04b:f1fd with SMTP id
 z15-20020adfec8f000000b0033ed04bf1fdmr8990276wrn.6.1710860857751; 
 Tue, 19 Mar 2024 08:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVpwdKGTIlFEczO6FqbiWFNfi/QSrVr2SRwYvjvD8z5EIsThK098BwR781UphMoxFyxo3b8w==
X-Received: by 2002:adf:ec8f:0:b0:33e:d04b:f1fd with SMTP id
 z15-20020adfec8f000000b0033ed04bf1fdmr8990260wrn.6.1710860857406; 
 Tue, 19 Mar 2024 08:07:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 f1-20020a5d4dc1000000b0033e99b7cfa8sm7395550wru.13.2024.03.19.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 08:07:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:07:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 0/9] Introduce support for IGVM files
Message-ID: <uknv3zep6t775h6fyr2m6l76exklpncqpu7rkga4hd6vsa2ccn@45ueizerlprr>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Roy,
thanks for this series!

On Tue, Feb 27, 2024 at 02:50:06PM +0000, Roy Hopkins wrote:
>Hi everyone,
>
>This initial patch series submission adds the capability to configure
>confidential guests using files that conform to the Independent Guest Virtual
>Machine (IGVM) file format. The series is based on the master branch commit
>1b330da. Alternatively, the series is available here:
>https://github.com/roy-hopkins/qemu/tree/igvm_master_v1
>
>I look forward to welcoming your comments!

I saw that the series has been a posted for a while and maybe you're 
going to send v2, so I'll bring back some little things that I saw, but 
I didn't do yet a deep review:

- We use "Isolated Guest Virtual Machine" or "Independent Guest Virtual
   Machine", are they interchangeable for IGVM?

- `./scripts/checkpatch.pl --codespell` reported some warnings:

5/9 Checking commit 81f60e5cdd01 (i386/pc: Process IGVM file during PC initialization if present)
WARNING: 'initalization' may be misspelled - perhaps 'initialization'?
#15:
     initalization of the target.
     ^^^^^^^^^^^^^

9/9 Checking commit 66745c0bb940 (docs/system: Add documentation on support for IGVM)

WARNING: 'encaspulate' may be misspelled - perhaps 'encapsulate'?
#27: FILE: docs/system/igvm.rst:4:
+IGVM files are designed to encaspulate all the information required to launch a
                             ^^^^^^^^^^^

Thanks,
Stefano

>
>Why do we need Independent Guest Virtual Machine (IGVM) files?
>==============================================================
>
>IGVM files describe, using a set of directives, the memory layout and initial
>configuration of a guest that supports isolation technologies such as AMD
>SEV-SNP and Intel TDX. By encapsulating all of this information in a single
>configuration file and applying the directives in the order they are specified
>when the guest is initialized, it becomes straightforward to pre-calculate the
>cryptographic measurement of the guest initial state, thus aiding in remote
>attestation processes.
>
>IGVM files can also be used to configure non-standard guest memory layouts,
>payloads or startup configurations. A good example of this is to use IGVM to
>deploy and configure an SVSM module in the guest which supports running at
>multiple VMPLs. The SVSM can be configured to start directly into 32-bit or
>64-bit code. This patch series was developed with this purpose in mind to
>support the COCONUT-SVSM project:
>https://github.com/coconut-svsm/svsm
>
>More information and background on the IGVM file format can be found on the
>project page at:
>https://github.com/microsoft/igvm
>
>What this patch series introduces
>=================================
>
>This series adds a build-time configuration option (--enable-igvm) to add
>support for launching a guest using an IGVM file. It extends the current
>ConfidentialGuestSupport object to allow an IGVM filename to be specified.
>
>The directives in the IGVM file are parsed and the confidential guest is
>configured through new virtual methods added to the ConfidentialGuestSupport
>object. These virtual functions have been implemented for AMD SEV and AMD
>SEV-ES.
>
>Many of the IGVM directives require capabilities that are not supported in SEV
>and SEV-ES, so support for IGVM directives will need to be considered when
>support for SEV-SNP, TDX or other technologies is introduced to QEMU. Any
>directive that is not currently supported results in an error report.
>
>Dependencies
>============
>
>In order to enable IGVM support, you will need the IGVM library installed.
>Instructions on building and installing it can be found here:
>https://github.com/microsoft/igvm/tree/main/igvm_c
>
>As mentioned above, this series was developed as part of the effort for
>COCONUT-SVSM. COCONUT-SVSM requires support for AMD SEV-SNP which is not
>available in current QEMU. Therefore this series has also been applied on top of
>the AMD SEV-SNP branch (https://github.com/AMDESE/qemu/tree/snp-v3-wip). You can
>find that version of the series here:
>https://github.com/roy-hopkins/qemu/commits/snp-v3-wip-igvm_v2/
>
>Generating IGVM files
>=====================
>
>To try this out you will need to generate an IGVM file that is compatible with
>the SEV platform you are testing on. I've created a tool that can create a
>simple IGVM file that packages an OVMF binary for AMD SEV or AMD SEV-ES. The
>tool is available here:
>https://github.com/roy-hopkins/buildigvm
>
>I have tested this on an AMD EPYC Genoa system configured to support SEV. Both
>SEV and SEV-ES have been tested using IGVM files generated using the buildigvm
>tool. The SEV-SNP alternative patch set has also been tested using COCONUT-SVSM.
>
>Roy Hopkins (9):
>  meson: Add optional dependency on IGVM library
>  backends/confidential-guest-support: Add IGVM file parameter
>  backends/confidential-guest-support: Add functions to support IGVM
>  backends/igvm: Implement parsing and processing of IGVM files
>  i386/pc: Process IGVM file during PC initialization if present
>  i386/pc: Skip initialization of system FW when using IGVM
>  i386/sev: Refactor setting of reset vector and initial CPU state
>  i386/sev: Implement ConfidentialGuestSupport functions for SEV
>  docs/system: Add documentation on support for IGVM
>
> backends/confidential-guest-support.c     |  69 +++
> backends/igvm.c                           | 718 ++++++++++++++++++++++
> backends/meson.build                      |   4 +
> docs/system/igvm.rst                      |  58 ++
> docs/system/index.rst                     |   1 +
> hw/i386/pc.c                              |  12 +-
> hw/i386/pc_piix.c                         |   4 +
> hw/i386/pc_q35.c                          |   4 +
> include/exec/confidential-guest-support.h | 107 ++++
> include/exec/igvm.h                       |  35 ++
> meson.build                               |   8 +
> meson_options.txt                         |   2 +
> qapi/qom.json                             |  13 +
> qemu-options.hx                           |   8 +-
> scripts/meson-buildoptions.sh             |   3 +
> target/i386/sev.c                         | 365 ++++++++++-
> target/i386/sev.h                         | 110 ++++
> 17 files changed, 1489 insertions(+), 32 deletions(-)
> create mode 100644 backends/igvm.c
> create mode 100644 docs/system/igvm.rst
> create mode 100644 include/exec/igvm.h
>
>--
>2.43.0
>
>


