Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEA0D358F6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPXs-0007z0-O7; Thu, 29 Jan 2026 05:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1vlPXn-0007wq-Kd
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:46:37 -0500
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1vlPXj-0004TU-Bi
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:46:34 -0500
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 64E6C1C0A37;
 Thu, 29 Jan 2026 11:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1769683585;
 bh=j5JwmiDsttfzg19wCJAsVxjUAiPWxASKMp4aK2rACgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lHUWIZmGbkJdGY95uAJNREsTcSd1VTFZuKTx1drhJYbhKzzspYZxOWvoi/R4Tdjm3
 LGrqb3p0JEkufGXBTP5rm2tBm9RD/EvwOd6adbioszBz0Uo00Kb0YQqNRYuAC+5l2l
 1uNi2X8hFrLJm8HK7XGQle12gALM6HHP8DHDi9ieQIh54ib+WjDyo/Tz/SS+poUbOG
 IKef6TbsgsTk9cThlj0rrLfAWuUoWNUKxJdeAaH6qHwBmocgFF6s33v4w0n44frv85
 04MGS270dLrYLq/sYar+E0QooNSHZeX5cWg+Xp0tGvMUVGgWUTSGqWkHtE38NMmm5Y
 kz8bjgfFxOQsA==
Date: Thu, 29 Jan 2026 11:46:24 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: COCONUT-SVSM project ideas for GSoC 2026
Message-ID: <h4uue2ekbnlh26rylj4ilsqzyxdrfzrq7czleysrkbowlgp4q2@wtbm7zi4kev5>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

Thanks a lot for running this and allowing the COCONUT-SVSM project to submit
ideas under the QEMU/KVM umbrella!

After some discussions in the community we came up with these two project ideas:

=== Observability Support for COCONUT-SVSM ===

'''Summary:''' Implement Support for COCONUT-SVSM Observability within the TEE

COCONUT-SVSM is a Secure Virtual machine Service Module that runs at a
privileged level within a Confidential Virtual Machine (CVM) to provide trusted
services, such as a virtual TPM, to the guest operating system, independent of
the host hypervisor.

The goal of the project is to implement support for observability of
COCONUT-SVSM from the guest OS. When finished the guest OS has a way to
fetch runtime metrics and data from the COCONUT-SVSM running within the same
TEE. Runtime data includes the log buffer, services logs, memory usage, and
possible future extensions.

The project consists of several parts:

1. Design an experimental SVSM observability protocol for exchanging metrics
   and data between COCONUT-SVSM and the Linux kernel. This protocol will be an
   extension of the SVSM protocol specification.
2. Implement a handler for the protocol within COCONUT-SVSM following the other
   protocols COCONUT-SVSM already implements.
3. Implement a Linux device driver which uses this protocol to get
   observability data from COCONUT-SVSM and make it accessible to Linux user-mode
   via a device file.
4. Implement a Linux user-space utility to fetch and save the observability
   data using the device driver.

'''Links:'''

* COCONUT-SVSM Repository: https://github.com/coconut-svsm/svsm/
* Development plan: https://coconut-svsm.github.io/svsm/developer/DEVELOPMENT-PLAN/#observability
* SVSM protocol specification: https://docs.amd.com/v/u/en-US/58019

'''Details:'''
Skill level: Intermediate
Language: Rust and C
Mentors: Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>

--->8---

=== Support X86 Process Context Identifiers (PCID) in COCONUT-SVSM ===

COCONUT-SVSM is a Secure Virtual machine Service Module that runs at a
privileged level within a Confidential Virtual Machine (CVM) to provide trusted
services, such as a virtual TPM, to the guest operating system, independent of
the host hypervisor.

The goal of the project is to enhance the COCONUT-SVSM kernel to make use of
the PCID feature on X86 to reduce the number of runtime TLB misses. The work
consists of several steps:

1. Implement generic CPUID feature enumeration support by building a code
   generator which automatically creates a Rust crate from the data provided by
   the X86-CPUID project. Use that generated crate in COCONUT-SVSM for
   detecting the PCID feature and clean up all the open coded CPUID checks.
2. Design and implement a PCID assignment strategy for tasks and threads in the
   COCONUT kernel.
3. Apply the PCIDs in the COCONUT page-tables and adapt the TLB flushing code
   to take PCIDs into account.

'''Links:'''
* AMD64 APM 2 (PCIDs, Section 5.5.1.): https://docs.amd.com/v/u/en-US/24593_3.43 
* X86 cpuid project: https://x86-cpuid.org/
* COCONUT-SVSM: https://github.com/coconut-svsm/svsm/

'''Details:'''
* Skill level: Intermediate
* Languages: Rust
* Mentors: Joerg Roedel <joerg.roedel@amd.com>, Luigi Leonardi <leonardi@redhat.com>

--->8---

Thanks,

	Joerg

