Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FDA10F284C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69hP-0007uy-9S; Fri, 27 Mar 2026 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w69hI-0007ra-S0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w69hH-0007SQ-4v
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774627566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zy3V9/KpzXz1A1LAjq2O42P8JAk5vwjeznTSjN4KBco=;
 b=VjxHtVWzwBu/i2FLd/C/06Z2bHcJGlnr6KfPw0Kyr1u+tz7D6kajwdzEz/XYwQ7ntbfJ77
 E3yCRnGXqAOF9w+fedQuKuAin90T4VM5yWJEtAj3V5YN/YTEv9xwlWDL6hVBdM2caXltjR
 ej4RZRvSB2iYkW9qkEpc6v4WS+nZ2f0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-OU66zg5eOC653FDdy1xVqA-1; Fri,
 27 Mar 2026 12:06:04 -0400
X-MC-Unique: OU66zg5eOC653FDdy1xVqA-1
X-Mimecast-MFC-AGG-ID: OU66zg5eOC653FDdy1xVqA_1774627563
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC139180034E; Fri, 27 Mar 2026 16:06:02 +0000 (UTC)
Received: from [10.45.224.71] (unknown [10.45.224.71])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC37E1955D84; Fri, 27 Mar 2026 16:06:00 +0000 (UTC)
Message-ID: <b355a891-fbbe-41fd-9d47-247ade12383b@redhat.com>
Date: Fri, 27 Mar 2026 17:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] docs: add WHPX section with initial info
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
References: <20260327011152.4126-1-mohamed@unpredictable.fr>
 <20260327011152.4126-3-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260327011152.4126-3-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/27/26 02:11, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   MAINTAINERS           |   1 +
>   docs/system/index.rst |   1 +
>   docs/system/whpx.rst  | 144 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 146 insertions(+)
>   create mode 100644 docs/system/whpx.rst

Needs a few fixes since this is rST not Markdown:

diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
index 2f906ec5866..3e1979028c9 100644
--- a/docs/system/whpx.rst
+++ b/docs/system/whpx.rst
@@ -5,8 +5,8 @@ Windows Hypervisor Platform is the Windows API for use of
  third-party virtual machine monitors with hardware acceleration
  on Hyper-V.
  
-It's implemented on top of `Vid`, which is itself implemented
-on the same set of hypercalls as the `mshv` driver on Linux.
+It's implemented on top of ``Vid``, which is itself implemented
+on the same set of hypercalls as the ``mshv`` driver on Linux.
  
  WHPX is the name of the Windows Hypervisor Platform accelerator
  backend in QEMU. It enables using QEMU with hardware acceleration
@@ -20,11 +20,11 @@ WHPX requires the Windows Hypervisor Platform feature to be installed.
  Installation
  ^^^^^^^^^^^^
  On client editions of Windows, that means installation through
-Windows Features (`optionalfeatures.exe`). On server editions,
+Windows Features (``optionalfeatures.exe``). On server editions,
  feature-based installation in Server Manager can be used.
  
  Alternatively, command line installation is also possible through:
-`DISM /online /Enable-Feature /FeatureName:HypervisorPlatform /All`
+``DISM /online /Enable-Feature /FeatureName:HypervisorPlatform /All``
  
  Minimum OS version
  ^^^^^^^^^^^^^^^^^^
@@ -58,8 +58,8 @@ Launching a virtual machine on arm64 with WHPX acceleration::
          -device usb-kbd -device usb-tablet \
          -hda OS.qcow2
  
-On arm64, for non-Windows guests, `-device virtio-gpu-pci` provides
-additional fuctionality compared to `-device ramfb`, but is
+On arm64, for non-Windows guests, ``-device virtio-gpu-pci`` provides
+additional functionality compared to ``-device ramfb``, but is
  incompatible with Windows's UEFI GOP implementation, which
  expects a linear framebuffer to be available.
  
@@ -69,10 +69,10 @@ Some tracing options
  x86_64
  ^^^^^^
  
-`-trace whpx_unsupported_msr_access` can be used to log accesses
+``-trace whpx_unsupported_msr_access`` can be used to log accesses
  to undocumented MSRs.
  
-`-d invalid_mem` allows to trace accesses to unmapped
+``-d invalid_mem`` allows to trace accesses to unmapped
  GPAs.
  
  Known issues on x86_64
@@ -88,19 +88,19 @@ Workaround: for affected guests, use a more modern graphics mode.
  Alternatively, use TCG to run those guests.
  
  Guests using MMX, SSE or AVX instructions for MMIO
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  
-Currently, `target/i386/emulate` does not support guests that use
+Currently, ``target/i386/emulate`` does not support guests that use
  MMX, SSE or AVX instructions for access to MMIO memory ranges.
  
-Attempts to run such guests will result in an `Unimplemented handler`
+Attempts to run such guests will result in an ``Unimplemented handler``
  warning for MMX and a failure to decode for newer instructions.
  
-`-M isapc`
-^^^^^^^^^^
+``-M isapc``
+^^^^^^^^^^^^
  
-`-M isapc` doesn't disable the Hyper-V LAPIC on its own yet. To
-be able to use that machine, use `-accel whpx,hyperv=off,kernel-irqchip=off`.
+``-M isapc`` doesn't disable the Hyper-V LAPIC on its own yet. To
+be able to use that machine, use ``-accel whpx,hyperv=off,kernel-irqchip=off``.
  
  However, in QEMU 11.0, the guest will still be a 64-bit x86
  ISA machine with all the corresponding CPUID leaves exposed.
@@ -111,10 +111,10 @@ gdbstub
  As save/restore of xsave state is not currently present, state
  exposed through GDB will be incomplete.
  
-The same also applies to `info registers`.
+The same also applies to ``info registers``.
  
--cpu `type` ignored
-^^^^^^^^^^^^^^^^^^^
+``-cpu type`` ignored
+^^^^^^^^^^^^^^^^^^^^^
  
  In this release, -cpu is an ignored argument.
  
@@ -127,7 +127,7 @@ from an HLT when using the Hyper-V provided interrupt controller.
  This has been addressed in QEMU 11.0 on Windows 11 platforms but
  functionality to make it available on Windows 10 isn't present.
  
-Workaround: for affected use cases, use `-M kernel-irqchip=off`.
+Workaround: for affected use cases, use ``-M kernel-irqchip=off``.
  
  Known issues on Windows 11
  ^^^^^^^^^^^^^^^^^^^^^^^^^^

Adjust and applied, thanks.

Paolo


