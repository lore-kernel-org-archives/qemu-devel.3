Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5686DD59D6A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfF5-0004zy-OR; Mon, 25 Nov 2024 14:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF4-0004zb-1B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:30 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF1-0004ko-6E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:29 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38231e9d518so3171375f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564765; x=1733169565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NQdjbNJo82Ka/fNwJ7wcx5D7rnYFRAomfI+Kpoun9L8=;
 b=wFUsmvnkeWFCpFNFd1NhI3BZ1F8XX3JypL/AZp5fNUo9K0GCDFj60keDZnlt1ILfMo
 Ril5JlvQbnLrBftNF+8QaOWvfGNt8C49dCPyUHcAQEPi8JKyNwHzBVJiNtxQBddRN1xi
 91mQFdLcmYaqlI3CU7E/Gsaoy1iYhqns/lXV9Wn9GcpP1blW225hDmPPTAHSiLYaYfFq
 RH+PhhzrTCapTyLV5cXQ4UJ3Bq1wvxRm7CnomG6a4LJZmpXTNfPSe3jIT+DOHeqoqNRW
 epqHt3FXlO+ljXgkYWvy/wl/79Pe8pip2wrOnCp7/kBLcO930zL18obrc354GtpGtx1C
 rLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564765; x=1733169565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NQdjbNJo82Ka/fNwJ7wcx5D7rnYFRAomfI+Kpoun9L8=;
 b=kdxt13sKDG3POxKDZE540iaa3AiGGx1Llx4JyVAPkJsuFTNzp5BGIq76zLoJ5KSHZx
 lQ1zC+OVqn//KtBrta+ClQ83BxMw6Lf1CN7C03VuFhqk929Qcg2RhIzzi6v1XQx8c8UJ
 KBUuasX3D5puuX5Qd8R1NIN0LcnnmnYQDPOqzw4e4Y2rvtFH9orDG5ogQfGSgg+/LSZd
 DmWRRhxQjwibH9pF3h1yOEOqzbGTTroFMl8JLkSdq2O0WBOhB/z7OeqDOLhDcs/YmJtN
 qiU6PN0jNcM8aCsWo7S5r2xiSaWgMN5jFW6GJ08N7bw7xhdFU+y9yvvCBmPaPVi4L3tj
 jLug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFCYF3BvgxiTN5hs5tsYqBmZdFuieEMpkcBYlaXLwR3i7M/o4qmH4cslWgt8iYHBueJ31KpvkL5/in@nongnu.org
X-Gm-Message-State: AOJu0YysDsUbhxkgtSnGMBjpPGiGXVh6BH2u9XJ6EeBnRJRe/cCFFTE7
 m7xe7tMGb9dbjOrhUhH7v7rEplfQ4gqhXvEq3Tr9Yx++pLTJ3B+VRc6ZGbTDAVk=
X-Gm-Gg: ASbGnctjwtU16GeOy8BNs1+M1DQ3SwZ3Xq0PMdcxpZxThcKd6NxTJ/lXfdaRxmeiYqh
 TbamQs75bRJFtXIPmwIEFUN5YRn96HpPu4E91nq6kc3pYdQjGvMJxzKnxwRt35NC8guNa0CsXLT
 0GePox990k1yxByUeQaotnlZTtDY5tJNIhW0mo7LJX6udHzBF5ycdjlOUNuxhhpNENfN9ZIY/cD
 gtxjo2r7VppyhW0/r3ZkTSgShmH8LUm1YTAHGlWPSZKPQuVoD/AYM+3kVIDIiewDh1w
X-Google-Smtp-Source: AGHT+IG6221Dw9HWcwl73Lh3zVMg5g0Wskxp7U4Hw/lkgPr5UuBFjbM7BebqKN5BnkI2c0sZQm25Mg==
X-Received: by 2002:a05:6000:491a:b0:382:518d:5890 with SMTP id
 ffacd0b85a97d-38260b58769mr11767599f8f.17.1732564764316; 
 Mon, 25 Nov 2024 11:59:24 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:24 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Gonda <pgonda@google.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 00/26] arm: Run Arm CCA VMs with KVM
Date: Mon, 25 Nov 2024 19:55:59 +0000
Message-ID: <20241125195626.856992-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_PORT=0.001 autolearn=unavailable autolearn_force=no
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

This series enables running confidential VMs on Arm CCA. The host KVM
support is progressing but still under discussion [1], so there is no
urgency to upstream this series. I'm sending this new version to give a
status update, and also to discuss remote attestation below.

Since v2 [2] I addressed comments on the QAPI patches. The support for
running Linux in a Realm will be in Linux v6.13 [3], so the guest-facing
interface is now stable. One important change since v2 is the requirement
to initialize the whole GPA space in RMM before boot, which we do in patch
9. The 'earlycon' kernel parameter now requires an unprotected address
parameter (see Documentation/arch/arm64/arm-cca.rst in Linux v6.13).

Documentation to try this series out:
https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU

The new RFC patches 21-26 are ideas to make remote attestation easier.
They're all optional, and in order to understand which patches should be
kept and what should be standardized, we'd like feedback from people who
will provide hosting and verification services, and also from people
working on other VMMs, who will be faced with the same problems.


QEMU and Realm attestation
==========================

Confidential computing wouldn't be complete without the ability to attest
that a remote VM you own is running your software on the correct hardware.
There are many components in enabling remote attestation, but I'd like to
discuss specifically how to independently reconstruct the initial state of
the VM created by QEMU.

We can illustrate this problem using the keybroker attestation demo [4]:

          ┌──────┬───────────────┐                           
          │  NS  │    REALM      │            RELYING PARTY 
      ┌───┼──────┼───────────────┤     (b)    (you are here) 
      │   │      │               │  evidence  ┌────────────┐ 
      │EL0│ QEMU │ keybroker-app ┼────────────► keybroker- │ 
      │   │   │  │      ▲        ◄────────────┼   server   │ 
      ├───┼───┼──┼──────┼────────┤   secret   └─────▲──────┘ 
      │   │   │  │      │        │     (d)          │ (c)    
      │EL1│   │  │ guest kernel  │              ┌───▼────┐   
      │   │   │  │      ▲        │              │veraison│   
      │   │   │  ├──────┼────────┤              └────────┘   
      │   │   ▼  │ (a)  │        │               VERIFIER    
      │EL2│  KVM ┼───► RMM       │                           
      │   │      │               │                           
      └───┴──────┴───────────────┘                           
                ATTESTER                                       

QEMU and KVM load data into the VM memory (kernel, initrd, firmware, etc),
before activating it and sealing its initial state (a). The initial state
is recorded by the RMM as the Realm Initial Measurement (RIM). Additional
data may be loaded at runtime, for example a bootloader loading an initrd
from untrusted storage. Those are recorded in Realm Extensible
Measurements (REM).

Now say you want the VM to run an application, keybroker-app, that
downloads a secret from your keybroker-server, for example a private key
to open an encrypted archive.

  keybroker-server -e http://10.0.2.2 -vv
  keybroker-app -e http://10.0.2.2:8088 -v <key> 

keybroker-app obtains signed evidence using Linux configfs-tsm, sends it
to keybroker-server (b). The evidence contains a platform token describing
the platform state (host hardware, firmware and RMM), and a realm token.
The signature and platform verification, proving that the VM is running in
a confidential environment, is offloaded to a trusted third party in this
example (c), though you could of course run veraison yourself.
keybroker-server then checks the RIM and REMs contained in the realm
token, to ensure the Realm is running the correct payload, and sends the
secret key (d).


Computing the Realm Initial Measurement
---------------------------------------

The simplest way to obtain the RIM is to run the payload once on a trusted
machine, extract the reference values and provision keybroker-server with
them. On the first run the demo tells you how to do this:

  INFO Known-good RIM values are missing. If you trust the client that
    submitted evidence for challenge 352278775, you should restart the
    keybroker-server with the following command-line option to populate it
    with known-good RIM values:
    --reference-values <(echo '{ "reference-values": [ "Up9LS4jrkX002..." ] }')

This is fine for testing, but does not scale well. For one thing you may
not have access to a trusted machine to run the payload. Also, the RIM is
relatively unstable: it depends on the host features (eg. SVE vector
length), the VM configuration (eg. amount of RAM) and the images loaded
into the Realm. Since the DTB/ACPI tables are included in the
measurements, changing the number of CPUs or MMIO devices will also
produce a different RIM. Some VMMs even have unstable IRQ allocation.

To pre-calculate the RIM for a set of VM parameters, rather than running
the workload once you can use the realm-measurements tool [5]:

  realm-measurements --print-b64
    -c configs/qemu-max-8.2.conf -c configs/kvm.conf  # host caps
    -k <kernel> -i <initrd>                           # payload
    qemu <qemu command-line parameters>

  RIM: Up9LS4jrkX002...

Internally realm-measurements generates a DTB for the given machine
configuration and uses it to calculate the RIM. This means that QEMU must
be run with the same generated DTB, which can be obtained by running
realm-measurements with `--output-dtb qemu.dtb --no-measurements` on the
host. See patch 21, which enables loading this DTB.

I've also experimented with reproducing the DTB generated by QEMU,
from a template obtained with `-M dumpdtb=<tpl.dtb>` [6]. It's rather
fragile due to phandle allocation, property names and libfdt internals.
You can try this mode by passing `--input-dtb <tpl.dtb>`, in which case
there is no need to pass a DTB to QEMU. But this solution will probably
remain experimental.


An event log from the VMM
-------------------------

Reconstructing the RIM this way requires a strict specification of the VMM
behavior [7]. To relax this, the VMM could provide an event log,
describing the different operations that contributed to the RIM: Realm
parameters, images loaded into RAM, initial CPU registers. The Trusted
Computing Group (TCG) defines a log format that describes things measured
by a TPM. Since this format will probably be reused to describe images
measured into the REM, it would make sense to adopt it for the RIM as
well. UEFI normally creates this log in RAM and passes it to the OS via
firmware table (CCEL for ACPI, TBD [8] for device tree)

Patches 23-26 show how we could load such event log into Realm memory.
Something to improve is the image identifiers passed in the log, that
allow the verifier to locate the image in its store of known-good images.
At the moment we use a hash function for this, but it would be useful to
either let the host pass the pre-calculated hash, or we could extend RMM
to return the hashes that it already computes when measuring data
granules.

Using a modified keybroker-demo that supports the event log [10], you can
pass a list of known-good images loaded into the realm:

  sha512sum path/to/images/* > checksums.txt
  keybroker-server -e http://10.0.2.2 -vv --images checksums.txt

Now when receiving evidence, the server can reconstruct the RIM and REMs
by parsing the event log. To reduce bandwidth use, the server caches the
computed reference values, and only requires an event log when reference
values are absent.

Note that the PoC is incomplete, because it trusts the log too much when
constructing the RIM: although data loaded into the Realm is correctly
verified, some events aren't properly checked by the policy at the moment.
In particular the REC event (vCPU initial state) must have sane initial
registers (which can be predicted from the DTB, KERNEL and FIRMWARE log
events, so should be easy to fix). The kernel parameters, contained in the
DTB, will also need to be validated by the policy.

The server reconstructs the DTB using a few VM properties passed in the
log (number of CPUs, RAM size). Another possible extension is to send the
DTB/ACPI tables in the log, so the tool can verify their content rather
than generate them, but I'm not sure it's even worth attempting.


Loading IGVM payload 
--------------------

IGVM [9] packs the payload along with instructions for creating the VM,
into a file that is fed to QEMU. We'll likely want to support it on Arm in
order to load complex payloads like COCONUT-SVSM, but probably not for
lightweight container payloads where firmware would be unnecessary
overhead.

If the IGVM file describes all operations leading to a RIM, then a strict
VM specification isn't needed in this case either. However to get more
flexibility it may be useful to combine IGVM with an event log: the host
packs the IGVM file including an event log, and the relying party only
needs the event log to reconstruct the RIM, it doesn't need to upload a
pack for each different configuration.



[1] [PATCH v5] arm64: Support for Arm CCA in KVM
    https://lore.kernel.org/all/20241004152804.72508-1-steven.price@arm.com/

[2] [PATCH v2] arm: Run CCA VMs with KVM
    https://lore.kernel.org/all/20240419155709.318866-2-jean-philippe@linaro.org/

[3] [PATCH v7] arm64: Support for running as a guest in Arm CCA
    https://lore.kernel.org/all/172967739783.1412028.8494484908145931121.b4-ty@arm.com/

[4] Veraison keybroker demo
    https://github.com/veraison/keybroker-demo/

[5] Realm measurements tool
    https://github.com/veraison/cca-realm-measurements
    https://docs.rs/cca-realm-measurements/0.1.0/cca_realm_measurements/

[6] DTB modification and libfdt changes
    https://github.com/veraison/cca-realm-measurements/commit/4b7aa3cbd7ae7ce114726979367329f57b8ef2c6
    https://git.codelinaro.org/linaro/dcap/buildroot-external-cca/-/commit/28f4afa6120b467cadab9bc0af67e7bab239797b

[7] VM specification
    https://github.com/veraison/cca-realm-measurements/blob/main/docs/realm-vm.md

[8] Confidential computing event log for device-tree
    https://jpbrucker.net/git/linux/log/?h=cca/ccel-dt

[9] IGVM in QEMU, COCONUT-SVSM
    https://lore.kernel.org/qemu-devel/cover.1727341768.git.roy.hopkins@suse.com/
    https://github.com/coconut-svsm/svsm/blob/main/Documentation/docs/installation/INSTALL.md

[10] keybroker-demo with event log support
     https://github.com/jpbrucker/keybroker-demo/commits/event-log/

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Jean-Philippe Brucker (26):
  kvm: Merge kvm_check_extension() and kvm_vm_check_extension()
  target/arm: Add confidential guest support
  target/arm/kvm: Return immediately on error in kvm_arch_init()
  target/arm/kvm-rme: Initialize realm
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch VM as Realm if necessary
  hw/core/loader: Add ROM loader notifier
  target/arm/kvm-rme: Initialize Realm memory
  target/arm/kvm-rme: Add Realm Personalization Value parameter
  target/arm/kvm-rme: Add measurement algorithm property
  target/arm/cpu: Set number of breakpoints and watchpoints in KVM
  target/arm/cpu: Set number of PMU counters in KVM
  target/arm/cpu: Inform about reading confidential CPU registers
  hw/arm/virt: Add support for Arm RME
  hw/arm/virt: Disable DTB randomness for confidential VMs
  hw/arm/virt: Reserve one bit of guest-physical address for RME
  hw/arm/boot: Mark all guest memory as RIPAS_RAM.
  hw/arm/virt: Move virt_flash_create() to machvirt_init()
  hw/arm/virt: Use RAM instead of flash for confidential guest firmware
  hw/arm/boot: Load DTB as is for confidential VMs
  hw/arm/boot: Skip bootloader for confidential guests
  hw/tpm: Add TPM event log
  hw/core/loader: Add fields to RomLoaderNotify
  target/arm/kvm-rme: Add measurement log
  hw/arm/virt: Add measurement log for confidential boot

 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 qapi/qom.json                              |  40 +
 qapi/tpm.json                              |  14 +
 include/hw/arm/boot.h                      |  18 +
 include/hw/arm/virt.h                      |   3 +-
 include/hw/loader.h                        |  17 +
 include/hw/tpm/tpm_log.h                   |  89 +++
 include/sysemu/kvm.h                       |   2 -
 include/sysemu/kvm_int.h                   |   1 +
 target/arm/cpu.h                           |  10 +
 target/arm/kvm_arm.h                       |  98 +++
 accel/kvm/kvm-all.c                        |  41 +-
 hw/arm/boot.c                              | 115 ++-
 hw/arm/virt.c                              | 143 +++-
 hw/core/loader.c                           |  17 +
 hw/tpm/tpm_log.c                           | 325 ++++++++
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu64.c                         | 118 +++
 target/arm/kvm-rme.c                       | 843 +++++++++++++++++++++
 target/arm/kvm.c                           | 201 ++++-
 target/i386/kvm/kvm.c                      |   6 +-
 target/ppc/kvm.c                           |  36 +-
 hw/tpm/Kconfig                             |   4 +
 hw/tpm/meson.build                         |   1 +
 target/arm/Kconfig                         |   1 +
 target/arm/meson.build                     |   7 +-
 28 files changed, 2075 insertions(+), 91 deletions(-)
 create mode 100644 include/hw/tpm/tpm_log.h
 create mode 100644 hw/tpm/tpm_log.c
 create mode 100644 target/arm/kvm-rme.c

-- 
2.47.0


