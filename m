Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666DEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQdg-0005g1-HY; Mon, 29 Jul 2024 09:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sYQde-0005eo-JU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sYQdc-0005Xz-9W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722260527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lwnirV7hQJXSZNMeOlqHSfVmmjAzNWaLEYDtaPLNSig=;
 b=ZXzlZRcfJqRsBxNPqNxdZ8OO8HRj1gjP34dsi1ZZyzhm1OaIshurzO6HNVZ/JY4onMvI0G
 DJIm12BrolqSNUQMRs49Nfzy2kZd4CQ2YGmBVE8TONRB7lOy3s2ui7483J/LWnWUjF6hLw
 5nUJ+2y6A2VLSzXQ/JOEHHTlTojESwY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-j4Gv2kC9NcydqCs-bqe6Uw-1; Mon, 29 Jul 2024 09:42:05 -0400
X-MC-Unique: j4Gv2kC9NcydqCs-bqe6Uw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef2ebe1ec4so35000981fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 06:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722260524; x=1722865324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwnirV7hQJXSZNMeOlqHSfVmmjAzNWaLEYDtaPLNSig=;
 b=ZsD0igKO50OL51e0VqOimvyyuLxQ3Zu8TzS+SG+nHzgzM+/DZGCic3Nq2DnaBcsfN+
 v2E+GkMAVMeF0u4rYD8d1DnOVI3WY5T6lBwKUMrsyI82zkK6zi1obItcn5JdY3ImClFW
 +ybSCczQ7lNsIaR8JIcsBQMUQraJEhoNst2Mu0Ql4WzYT8UnUmKeG2HsqByddW0z4l+0
 6vLLMqXJPR0HkVKGQ6HakEr2nYK5Ru7jU+et0cEOVmtbpz5MdwOAaznbkqLHLiEg96Rb
 5bgwPb+tdPEiNHqtlWtCZZESEC1Wtc+BqTiyyBp8JBWGy3AGrn0dj/5wKBrZdhf2SVrK
 1zug==
X-Gm-Message-State: AOJu0YxMfBVW9deeqrvMCAQkuNF5X81E4vjpxo3h3HQ841YXEEyEnS6f
 n4ED7FmI3g33rW2nrpiNQjTBTO5SiKHOsNyNLQ4c92Y414x9GxKDfZzK46bTcy9AJQKXkhMTj9M
 h+6bvqbdeddwImru0GmH4joNQFi4Nkszl13oeUFHtle6BTN8VxJTN
X-Received: by 2002:a2e:8608:0:b0:2ef:2dfd:15e3 with SMTP id
 38308e7fff4ca-2f12ee05e22mr50936391fa.19.1722260523989; 
 Mon, 29 Jul 2024 06:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCKsDAn8AF3DKJ65ZnRllPlMkfr2GHbfVt5P8tzoc+83q1m2jPu2xbFJsDhU635otX3FIo1g==
X-Received: by 2002:a2e:8608:0:b0:2ef:2dfd:15e3 with SMTP id
 38308e7fff4ca-2f12ee05e22mr50935931fa.19.1722260522943; 
 Mon, 29 Jul 2024 06:42:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it.
 [82.57.51.79]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f92c7cb3sm221177495e9.0.2024.07.29.06.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 06:42:02 -0700 (PDT)
Date: Mon, 29 Jul 2024 15:41:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 11/17] docs/system: Add documentation on support for
 IGVM
Message-ID: <glrev4xvxqb4gohmnmjpi4qaehpfr7nh5zwnlwmlswm4usrbzz@4zfjsmjjbnfm>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <10ccd85a95b302c7a7465190fcb0dcbe534133cb.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <10ccd85a95b302c7a7465190fcb0dcbe534133cb.1720004383.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 03, 2024 at 12:05:49PM GMT, Roy Hopkins wrote:
>IGVM support has been implemented for Confidential Guests that support
>AMD SEV and AMD SEV-ES. Add some documentation that gives some
>background on the IGVM format and how to use it to configure a
>confidential guest.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>---
> docs/system/i386/amd-memory-encryption.rst |   2 +
> docs/system/igvm.rst                       | 173 +++++++++++++++++++++
> docs/system/index.rst                      |   1 +
> 3 files changed, 176 insertions(+)
> create mode 100644 docs/system/igvm.rst
>
>diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
>index 748f5094ba..6c23f3535f 100644
>--- a/docs/system/i386/amd-memory-encryption.rst
>+++ b/docs/system/i386/amd-memory-encryption.rst
>@@ -1,3 +1,5 @@
>+.. _amd-sev:
>+
> AMD Secure Encrypted Virtualization (SEV)
> =========================================
>
>diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
>new file mode 100644
>index 0000000000..36146a81df
>--- /dev/null
>+++ b/docs/system/igvm.rst
>@@ -0,0 +1,173 @@
>+Independent Guest Virtual Machine (IGVM) support
>+================================================
>+
>+IGVM files are designed to encapsulate all the information required to launch a
>+virtual machine on any given virtualization stack in a deterministic way. This
>+allows the cryptographic measurement of initial guest state for Confidential
>+Guests to be calculated when the IGVM file is built, allowing a relying party to
>+verify the initial state of a guest via a remote attestation.
>+
>+Although IGVM files are designed with Confidential Computing in mind, they can
>+also be used to configure non-confidential guests. Multiple platforms can be
>+defined by a single IGVM file, allowing a single IGVM file to configure a
>+virtual machine that can run on, for example, TDX, SEV and non-confidential
>+hosts.
>+
>+QEMU supports IGVM files through the user-creatable ``igvm-cfg`` object. This
>+object is used to define the filename of the IGVM file to process. A reference
>+to the object is added to the ``-machine`` to configure the virtual machine
>+to use the IGVM file for configuration.
>+
>+Confidential platform support is provided through the use of
>+the ``ConfidentialGuestSupport`` object. If the virtual machine provides an
>+instance of this object then this is used by the IGVM loader to configure the
>+isolation properties of the directives within the file.
>+
>+Further Information on IGVM
>+---------------------------
>+
>+Information about the IGVM format, including links to the format specification
>+and documentation for the Rust and C libraries can be found at the project
>+repository:
>+
>+https://github.com/microsoft/igvm
>+
>+
>+Supported Platforms
>+-------------------
>+
>+Currently, IGVM files can be provided for Confidential Guests on host systems
>+that support AMD SEV, SEV-ES and SEV-SNP with KVM. IGVM files can also be
>+provided for non-confidential guests.
>+
>+
>+Limitations when using IGVM with AMD SEV, SEV-ES and SEV-SNP
>+------------------------------------------------------------
>+
>+IGVM files configure the initial state of the guest using a set of directives.
>+Not every directive is supported by every Confidential Guest type. For example,
>+AMD SEV does not support encrypted save state regions, therefore setting the
>+initial CPU state using IGVM for SEV is not possible. When an IGVM file contains
>+directives that are not supported for the active platform, an error is generated
>+and the guest launch is aborted.
>+
>+The table below describes the list of directives that are supported for SEV,
>+SEV-ES, SEV-SNP and non-confidential platforms.
>+
>+.. list-table:: SEV, SEV-ES, SEV-SNP & non-confidential Supported Directives
>+   :widths: 35 65
>+   :header-rows: 1
>+
>+   * - IGVM directive
>+     - Notes
>+   * - IGVM_VHT_PAGE_DATA
>+     - ``NORMAL`` zero, measured and unmeasured page types are supported. Other
>+       page types result in an error.
>+   * - IGVM_VHT_PARAMETER_AREA
>+     -
>+   * - IGVM_VHT_PARAMETER_INSERT
>+     -
>+   * - IGVM_VHT_VP_COUNT_PARAMETER
>+     - The guest parameter page is populated with the CPU count.
>+   * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
>+     - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
>+       page.
>+
>+.. list-table:: Additional SEV, SEV-ES & SEV_SNP Supported Directives
>+   :widths: 25 75
>+   :header-rows: 1
>+
>+   * - IGVM directive
>+     - Notes
>+   * - IGVM_VHT_MEMORY_MAP
>+     - The memory map page is populated using entries from the E820 table.
>+   * - IGVM_VHT_REQUIRED_MEMORY
>+     -
>+
>+.. list-table:: Additional SEV-ES & SEV-SNP Supported Directives
>+   :widths: 25 75
>+   :header-rows: 1
>+
>+   * - IGVM directive
>+     - Notes
>+   * - IGVM_VHT_VP_CONTEXT
>+     - Setting of the initial CPU state for the boot CPU and additional CPUs is
>+       supported with limitations on the fields that can be provided in the
>+       VMSA. See below for details on which fields are supported.
>+
>+Initial CPU state with VMSA
>+---------------------------
>+
>+The initial state of guest CPUs can be defined in the IGVM file for AMD SEV-ES
>+and SEV-SNP. The state data is provided as a VMSA structure as defined in Table
>+B-4 in the AMD64 Architecture Programmer's Manual, Volume 2 [1].
>+
>+The IGVM VMSA is translated to CPU state in QEMU which is then synchronized
>+by KVM to the guest VMSA during the launch process where it contributes to the
>+launch measurement. See :ref:`amd-sev` for details on the launch process and
>+guest launch measurement.
>+
>+It is important that no information is lost or changed when translating the
>+VMSA provided by the IGVM file into the VSMA that is used to launch the guest.
>+Therefore, QEMU restricts the VMSA fields that can be provided in the IGVM
>+VMSA structure to the following registers:
>+
>+RAX, RCX, RDX, RBX, RBP, RSI, RDI, R8-R15, RSP, RIP, CS, DS, ES, FS, GS, SS,
>+CR0, CR3, CR4, XCR0, EFER, PAT, GDT, IDT, LDTR, TR, DR6, DR7, RFLAGS, X87_FCW,
>+MXCSR.
>+
>+When processing the IGVM file, QEMU will check if any fields other than the
>+above are non-zero and generate an error if this is the case.
>+
>+KVM uses a hardcoded GPA of 0xFFFFFFFFF000 for the VMSA. When an IGVM file
>+defines initial CPU state, the GPA for each VMSA must match this hardcoded
>+value.
>+
>+Firmware Images with IGVM
>+-------------------------
>+
>+When an IGVM filename is specified for a Confidential Guest Support object it
>+overrides the default handling of system firmware: the firmware image, such as
>+an OVMF binary should be contained as a payload of the IGVM file and not
>+provided as a flash drive or via the ``-bios`` parameter. The default QEMU
>+firmware is not automatically populated into the guest memory space.
>+
>+If an IGVM file is provided along with either the ``-bios`` parameter or pflash
>+devices then an error is displayed and the guest startup is aborted.
>+
>+Running a guest configured using IGVM
>+-------------------------------------
>+
>+To run a guest configured with IGVM you firstly need to generate an IGVM file
>+that contains a guest configuration compatible with the platform you are
>+targeting.
>+
>+The ``buildigvm`` tool [2] is an example of a tool that can be used to generate
>+IGVM files for non-confidential X86 platforms as well as for SEV, SEV-ES and
>+SEV-SNP confidential platforms.
>+
>+Example using this tool to generate an IGVM file for AMD SEV-SNP::
>+
>+    buildigvm --firmware /path/to/OVMF.fd --output sev-snp.igvm \
>+              --cpucount 4 sev-snp
>+
>+To run a guest configured with the generated IGVM you need to add an
>+``igvm-cfg`` object and refer to it from the ``-machine`` parameter:
>+
>+Example (for AMD SEV)::
>+
>+    qemu-system-x86_64 \
>+        <other parameters> \
>+        -machine ...,confidential-guest-support=sev0,igvm-cfg=igvm0 \
>+        -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>+        -object igvm-cfg,id=igvm0,file=/path/to/sev-snp.igvm
>+
>+References
>+----------
>+
>+[1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
>+  Rev 3.41
>+  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>+
>+[2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
>+  https://github.com/roy-hopkins/buildigvm

Should we also put a reference to the tool we have in Coconut SVSM?

BTW, this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>\ No newline at end of file
>diff --git a/docs/system/index.rst b/docs/system/index.rst
>index c21065e519..6235dfab87 100644
>--- a/docs/system/index.rst
>+++ b/docs/system/index.rst
>@@ -38,4 +38,5 @@ or Hypervisor.Framework.
>    security
>    multi-process
>    confidential-guest-support
>+   igvm
>    vm-templating
>-- 
>2.43.0
>


