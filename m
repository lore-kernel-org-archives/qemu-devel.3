Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A6BCD3423
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 16:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIrC4-0003lo-7s; Fri, 01 May 2026 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIrC3-0003lg-C2
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:58:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIrC0-0003VQ-H7
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:58:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso17015345e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777654698; x=1778259498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oV2QZ7/jd++vLEfKAaRLE7cy1/EHfv2o0zQvoTndAIU=;
 b=eLLTykfsiNebTS9ZbdtnECYFl5q72179EY436uDFblZ7gnOozvp/R/xUrwz+Y9EnHP
 BIACGg0wQ/k9j9bnO96bJyfMwOblYWolBgdoBgr/dzM9WVfpLUyoUs1LZQnIkev4FoSH
 LG7Tvlfsg4PcT3e9gD7gnvbHweaQ5o+KSKsXnzqKfraYjU9SOuIb+RZqZxHTWTp8oyGR
 WGUX2kBOlBoal/Kr+chmJMOkPCwqgD4LtLkdnfIgpa80ndjcegSrvqKQNACfthFPHPeA
 u0R0jdK0jA8/ChUb3+aM8pWmFALADK8SGDdbYXhP49GjxHcmuY0Aw+4Pe5K6uoE4Ikgh
 Znag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777654698; x=1778259498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oV2QZ7/jd++vLEfKAaRLE7cy1/EHfv2o0zQvoTndAIU=;
 b=FDgrFv+0idgZVy9iMYJ8I00JyQk1v5RGJn2wGdIaAwet7Fq5ACG+CG1Ws4RoSS34aM
 ACuEnV1y67YBWQk4s9VfdLAWFr2WNj5SRku6j4SDXxjtX/0ImeSbRA2eN1Ttgyk4EL4S
 2zLWX5B8rbOqSDp78AlH/wep1fhrlHysqqzqSZW9KatvbTDtYPQHRSgkKKjdIieVk4zq
 v6LW+OTmlgodzmF6KvrW+0yYACcsPyZPoBc+utN90Lo0A0vO1sYRJKj6CllsGFZ0e0Em
 8VJgsx0TKRB2mEHSC+p3rFx4OUUZmxk0wIQEPSbZhqfNYa4Doqgc7nXrnp7cOoC7Fiar
 Ny6A==
X-Gm-Message-State: AOJu0YxMOARVVi5EMsuaoZbwDmQVKIrdcueo/IsXDYLS6ofQOoeF/8U6
 TeiTJqNeGYtXKoCIFCgCOAtZU8H55WqUWn6uDS0IeAErMgbPPhHRoFNJOdjH3vexsn0M1lZrJjE
 QmfdjGQ+AQko9
X-Gm-Gg: AeBDievYjiFip7COSWckRXuUb9P0UFqhLD+l9bqw4pdsMabikNnbR0LGGVs5lERSIft
 YBzarKVu6PEDH7avaKtKk51hp/aAzU8XeySEZoX9uo5vx82GatZ/spQ0MSy21cpml1cvZwQHP0B
 zQcuq95UV6YRRKvFYAzFmHz2lmN102qB05/G2AxucP13VcFgXlOc0l4TJNhOFOFQDE4CMZ6uWEU
 Msc/6dNVcyB14y8Nixswse6c8MsfNL4GJ5GI431wJMNC6jO4tPCOkh13Jg+OxC5ickmoUjm5ZKZ
 g5idjUcrAS9RnrrTi4X7SaMzqTVpzPEiWko3AC3BhVTlcH6Am3nQLMdo5JE1A0SXebblsbAUzEp
 Rw7+NR+YpQLYnOMH8YZMMv3vuYSlkuGCT28ZzSeS5oe+z7NkKEl0CQeRTm6RayQa/HqplabbBb2
 /8+UZDEcxi1VVVGn4bWoIwUVJ245V5pxLDKQ==
X-Received: by 2002:a05:6000:61e:b0:44a:ef8c:de18 with SMTP id
 ffacd0b85a97d-44bb63f53b5mr423231f8f.25.1777654697881; 
 Fri, 01 May 2026 09:58:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981defbfsm6115788f8f.17.2026.05.01.09.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:58:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E7875F8FC;
 Fri, 01 May 2026 17:58:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2] .eca: add an issue triager agent skill
Date: Fri,  1 May 2026 17:58:12 +0100
Message-ID: <20260501165812.2212713-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

While triaging the issue tracker I wondered if this would be a
suitable job for an AI agent. Unfortunately the OSS program doesn't
give any credits to run agents in gitlab. However I do have access to
models from my editor and ECA so I built one and tested it on a few
issues.

Obviously this can't apply as is because it probably encodes too much
of my local setup (using pass for API keys) and uses the ECA as my
preferred coding agent. I assume at some point there will be agreement
between all the agents where skill live.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - prefer sub-agent
  - mention parameters
  - don't be over eager to tag host or target for generic bugs
  - signoff comments as an agent on behalf of the user
  - detect patch available and apply appropriate tags
---
 .eca/skills/issue-triager/SKILL.md            |  90 ++++++++++++
 .eca/skills/issue-triager/assets/labels.txt   | 132 ++++++++++++++++++
 .eca/skills/issue-triager/evals/evals.json    |  17 +++
 .../issue-triager/scripts/update_labels.sh    |  13 ++
 4 files changed, 252 insertions(+)
 create mode 100644 .eca/skills/issue-triager/SKILL.md
 create mode 100644 .eca/skills/issue-triager/assets/labels.txt
 create mode 100644 .eca/skills/issue-triager/evals/evals.json
 create mode 100755 .eca/skills/issue-triager/scripts/update_labels.sh

diff --git a/.eca/skills/issue-triager/SKILL.md b/.eca/skills/issue-triager/SKILL.md
new file mode 100644
index 00000000000..2bc8e00d7c6
--- /dev/null
+++ b/.eca/skills/issue-triager/SKILL.md
@@ -0,0 +1,90 @@
+---
+name: issue-triager
+description: can help triaging GitLab issues for the QEMU project
+---
+
+# Instructions
+
+This skill provides specialized instructions for triaging GitLab issues for the QEMU project.
+
+## Parameter Handling & Execution Strategy (CRITICAL)
+1. **Parameters**: If the user invokes this skill with an argument (e.g., `/issue-triager 3463`), treat that argument as the target `<issue-id>`.
+2. **Sub-Agent Mandate**: To prevent polluting the main conversation context, **you MUST ALWAYS spawn a sub-agent** to perform the actual triage. 
+   - Do NOT run `glab` commands or read the label cache directly in the main context.
+   - Use the `eca__spawn_agent` tool (agent: `general`, activity: `Triaging issue <id>`).
+   - In the `task` parameter for the sub-agent, provide the target `<issue-id>` and explicitly instruct the sub-agent to follow the "Triage Workflow" and "Asset Management" rules defined below.
+   - Wait for the sub-agent to finish and simply report its summary to the user.
+
+## Goal
+Automate the initial triage of new bug reports and feature requests in the QEMU GitLab repository.
+
+## Prerequisites
+- `glab` CLI tool installed.
+- GitLab API Token: Use `env GITLAB_TOKEN=$(pass gitlab-api)` for all `glab` commands.
+- Target Repo: Use `-R qemu-project/qemu` if not in a clone, or ensure the remote is set correctly.
+
+## Asset Management (Label Cache)
+This skill uses a cached list of labels to avoid unnecessary API calls and ensure consistent labeling.
+- **Cache Location:** `assets/labels.txt` relative to this skill.
+- **Updating the Cache:** If the user asks to update the labels, or if you suspect a label is missing, run the provided script:
+  ```bash
+  cd .eca/skills/issue-triager/scripts && ./update_labels.sh
+  ```
+- **Using the Cache:** Before applying labels, ALWAYS read `assets/labels.txt` (or use `grep` on it) to review the available labels and their descriptions. This ensures you use the exact spelling and understand the intent behind the label (e.g., `kind::Bug`, `subsystem::block`). Do NOT guess label names.
+
+## Triage Workflow
+
+### 1. Information Gathering
+Fetch the issue details:
+```bash
+env GITLAB_TOKEN=$(pass gitlab-api) glab issue view <issue-id> -R qemu-project/qemu --comments
+```
+
+### 2. Evaluate Completeness
+Analyze the issue against the bug template requirements:
+- **Host Arch/OS**: Is the host environment specified?
+- **Guest Arch/OS**: Is the guest environment specified?
+- **QEMU Version**: Is the version mentioned?
+- **Reproduction Steps**: Are there clear steps to reproduce?
+- **Expected vs Actual**: Is the bug clearly described?
+
+**Actions:**
+- If critical information is missing (especially repro steps), add the `Workflow::Needs Info` label and post a polite comment asking for the missing details. (Remember to sign the comment as "ECA Issue Agent on behalf of the user" per the Guidelines).
+- If the issue is well-defined, proceed to categorization.
+
+### 3. Categorization & Labeling
+Apply labels based on the issue content. **Crucially, consult `assets/labels.txt` to find the exact matching labels for the categories below.**
+
+#### Kinds
+- `kind::Bug`: For unexpected behavior.
+- `kind::Feature Request`: For new functionality.
+- `kind::Cleanup`: For code refactoring or style issues.
+
+#### Targets (target:*) and Hosts (host:*)
+Detect the guest architecture (`target:*`) or host environment (`host:*`).
+**IMPORTANT:** Be conservative when applying `target:` and `host:` labels. Many bugs (e.g., in generic devices like USB, PCI, or block controllers) apply to ANY guest that includes the device. The reproducer (like a `qtest` invocation) might just use a convenient target (e.g., `i386`) as an example. ONLY apply `target:` or `host:` labels if the bug is strictly architecture- or host-dependent (e.g., a bug in ARM CPU emulation, or a macOS-specific build failure).
+
+#### Accelerators (accel:*)
+Detect the accelerator mentioned (e.g., `accel:kvm`, `accel:tcg`, `accel:hvf`).
+
+#### Subsystems (subsystem:*)
+Identify the relevant subsystem (e.g., `subsystem:block`, `subsystem:net`, `subsystem:virtio`, `subsystem:migration`).
+
+#### Testcases
+- If the issue provides a minimal C program, a shell script, or a specific disk image to reproduce the bug, apply the `Testcase` label.
+
+#### Patches and Fixes
+- If the issue description or comments contain a link to a patch on the mailing list (e.g., `lore.kernel.org`, `patchew.org`), or explicitly mention that a patch/fix has been submitted, apply the `workflow::Patch available` label.
+
+### 4. Updating the Issue
+Apply the labels and optionally assign a priority if clear:
+```bash
+env GITLAB_TOKEN=$(pass gitlab-api) glab issue update <issue-id> -R qemu-project/qemu --label "kind::Bug,target:arm,Workflow::Triaged"
+```
+
+## Guidelines
+- Be polite and professional in comments.
+- **IMPORTANT:** Any comments added to the issue MUST include the phrase: "ECA Issue Agent on behalf of the user" (e.g., as a sign-off at the end of the message).
+- Use `Workflow::Triaged` once categorization is complete.
+- Avoid assigning issues to specific people unless they are explicitly mentioned or are the known maintainer for a very specific subsystem.
+- Use the `scripts/get_maintainer.pl` logic (via file paths mentioned in the issue) to identify potential subsystems.
diff --git a/.eca/skills/issue-triager/assets/labels.txt b/.eca/skills/issue-triager/assets/labels.txt
new file mode 100644
index 00000000000..5fe8c28deac
--- /dev/null
+++ b/.eca/skills/issue-triager/assets/labels.txt
@@ -0,0 +1,132 @@
+ACPI                       Power Management related (ACPI / SMBIOS / HEST / GHES)
+Audio                      Audio devices; both backend (host audio) and frontend (guest audio)
+Audit Tooling              A group for bugs and issues found via automated tooling such as fuzzing, sanitizers or AI
+Audit Tooling::AI          For bugs found with AI assisted tools such as Mythos and other similar things
+Audit Tooling::Fuzzer      Issues found via fuzzing. For security issues, please consult https://www.qemu.org/contribute/security-process/
+Audit Tooling::Sanitizer   For issues found using sanitizers such as asan, lsan and tsan
+Bite Sized                 Candidates for first contributions; see also https://wiki.qemu.org/Contribute/BiteSizedTasks
+Build System               configure, make, Meson, ninja, gcc, clang, ccache, etc.
+CI                         Continuous Integration; gitlab, travis, patchew, etc.
+CLI                        Command Line Interface
+Chardev                    Character device backends and related issues
+Closed::Duplicate          There is already another ticket that is about the same issue
+Closed::Fixed              The issue was fixed. Yay!
+Closed::Invalid            This issue was not really a problem
+Closed::NotOurBug          This is a bug, but not a bug in QEMU. Please report it and/or include a link to the report.
+Closed::NotReproducible    This issue was not reproducible
+Closed::UnbackedFeature    Nobody was willing to work on this feature request
+Closed::WontFix            The issue was acknowledged, but the fix would be too complex, too expensive, or would introduce other problems.
+Cryptography               
+Documentation              Sphinx documentation, man pages, the wiki, --help output, etc.
+GDB                        Issues relating to using GDB via the gdbstub
+GUI                        Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
+GUI::Cocoa                 Cocoa
+GUI::DBus                  DBus
+GUI::GTK                   
+GUI::SDL                   SDL
+GUI::SPICE                 SPICE
+GUI::VNC                   
+Guest Agent                Issues related to the qemu-guest-agent binary. https://wiki.qemu.org/Features/GuestAgent
+Hard                       
+Launchpad                  Issues migrated from Launchpad
+Migration                  
+Modules                    
+Networking                 
+Python                     Python library issues (./python/)
+QAPI/QMP                   QEMU API / QEMU Machine Protocol, HMP and CLI, etc.
+QOM                        QEMU Object Model
+Regression                 
+Security                   
+Semihosting                Semihosting calls provide a simple ABI for early bring-up of embedded devices and provide a way to output to the console and do basic file i/o while being debugged
+Softfloat                  QEMU's FPU emulation code (TCG only)
+Stable::can't fix          The bug was reported on a stable branch but the fix is too invasive for backporting
+Stable::obsolete           The bug was reported on a stable branch that is not maintained anymore
+Stable::to backport        The bug was reported on a stable branch and needs to be backported on the next release from the branch
+Storage                    Block subsystem, Storage devices, etc.
+TCG plugins                Anything related to the TCG plugins feature
+TestCase                   The report includes a testcase
+Tests                      qtests, iotests, acceptance tests, VM tests, docker tests, and more.
+USB                        
+VFIO                       
+accel: HAX                 Intel's Hardware Accelerated Execution Manager (HAXM)
+accel: HVF                 Apple Hypervisor Framework
+accel: KVM                 Linux Kernel-based Virtual Machine
+accel: TCG                 QEMU Tiny Code Generator
+accel: WHPX                Microsoft Windows Hypervisor Platform (WHPX)
+accel: Xen                 Xen Hypervisor
+block:9p                   The 9p network file system
+block:NVMe                 
+block:curl                 
+block:nbd                  
+block:nfs                  Issues related to the NFS backend
+block:qcow2                
+block:ssh                  
+block:vmdk                 
+bsd-user                   
+device: PCI                
+device: TPM                Trusted Platform Module (TPM) devices
+device:graphics            Issues relating to display device emulation, or rendering in general. See also "GUI".
+device:input               Keyboards, Mice, Touchscreens, HIDs, etc.
+device:iommu               IOMMU and SMMU
+device:pflash              Parallel NOR flashes emulation
+device:sdmmc               SD or (e)MMC cards emulation
+device:virtio              virtio-related issues. https://www.linux-kvm.org/page/Virtio
+device:watchdog            
+efi                        EFI firmware related issues
+flaky-ci                   For test cases that are flaky when run under our CI
+gitlab                     
+guest: AIX                 
+guest: BSD                 Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
+guest: Linux               Guest OS is Linux/Linux-based
+guest: Windows             Microsoft Windows guest
+guest: macOS               Apple macOS / Darwin as  guest OS
+guest: os2                 
+host: aarch64              Bugs reproducible on AArch64 hosts
+host: arm                  Bugs reproducible on ARM hosts
+host: loongarch64          Bugs reproducible on LoongArch64 hosts.
+host: mips                 Bugs reproducible on MIPS hosts
+host: ppc                  Bugs reproducible on Power hosts
+host: riscv                Bugs reproducible on RISC-V hosts
+host: s390                 Bugs reproducible on s390 hosts
+host: sparc64              Bugs specific to Sparc64 hosts
+host: x86                  Bugs reproducible on x86 hosts
+host:32bit                 These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.
+hostos: BSD                FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
+hostos: Linux              Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
+hostos: Windows            Microsoft Windows host OS
+hostos: macOS              Apple macOS / Darwin as a host OS
+icount                     issues relating to icount, deterministic execution and record/replay functionality
+kind: Not user visible     
+kind::Bug                  Bug or defect in functionality.
+kind::Feature Request      Feature request or new functionality.
+kind::Task                 Research, investigations, and miscellaneous issues.
+libvfio-user               
+linux-user                 
+qemu-img                   
+spice                      
+sysadmin                   
+target: alpha              DEC Alpha [alpha]
+target: arm                Arm AArch32 or AArch64 [arm, aarch64]
+target: avr                Atmel AVR [avr]
+target: hexagon            Qualcomm Hexagon [hexagon]
+target: hppa               Hewlett-Packard Precision Architecture; HP/HP, PA-RISC [hppa]
+target: i386               Intel/AMD x86 [i386, x86_64]
+target: loongarch          loongarch64 target architecture
+target: m68k               Motorola 68000 [m68k]
+target: microblaze         Xilinx MicroBlaze [microblaze, microblazeel]
+target: mips               MIPS [mips, mipsel, mips64, mips64el]
+target: nios2              Altera Nios II [nios2]
+target: openrisc           OpenRISC [or1k]
+target: ppc                IBM Power Architecture, PowerPC [ppc, ppc64, ppc64le]
+target: riscv              RISC-V [riscv32, riscv64]
+target: rx                 Renesas RX [rx]
+target: s390x              IBM Z, SystemZ, zSeries [s390x]
+target: sh4                Renesas SuperH [sh4, sh4eb]
+target: sparc              Sun Microsystems SPARC [sparc, sparc64]
+target: tricore            Infineon TriCore [tricore]
+target: xtensa             Tensilica Xtensa [xtensa, xtensaeb]
+workflow::Confirmed        Bugs that have been confirmed and reproduced.
+workflow::In Progress      Someone is working on this issue.
+workflow::Needs Info       Issue has insufficient information to verify.
+workflow::Patch available  A patch is available
+workflow::Triaged          Issue has been triaged and given a topic label.
diff --git a/.eca/skills/issue-triager/evals/evals.json b/.eca/skills/issue-triager/evals/evals.json
new file mode 100644
index 00000000000..4cf60b60259
--- /dev/null
+++ b/.eca/skills/issue-triager/evals/evals.json
@@ -0,0 +1,17 @@
+{
+  "skill_name": "issue-triager",
+  "evals": [
+    {
+      "id": 1,
+      "prompt": "Update the cached list of GitLab labels for the QEMU project.",
+      "expected_output": "The skill should fetch the latest labels from GitLab and save them to the skill's assets directory.",
+      "files": []
+    },
+    {
+      "id": 2,
+      "prompt": "Triage issue #1234. Assume the user provided clear steps but no subsystem label is obvious.",
+      "expected_output": "The skill should read the cached label list (not fetch from GitLab) and apply relevant kind/target labels.",
+      "files": []
+    }
+  ]
+}
\ No newline at end of file
diff --git a/.eca/skills/issue-triager/scripts/update_labels.sh b/.eca/skills/issue-triager/scripts/update_labels.sh
new file mode 100755
index 00000000000..550df07ff6b
--- /dev/null
+++ b/.eca/skills/issue-triager/scripts/update_labels.sh
@@ -0,0 +1,13 @@
+#!/usr/bin/env bash
+set -e
+
+if [ -z "$GITLAB_TOKEN" ]; then
+    echo "GITLAB_TOKEN is not set. Attempting to fetch via pass..."
+    export GITLAB_TOKEN=$(pass gitlab-api)
+fi
+
+echo "Fetching labels from qemu-project/qemu..."
+# Fetch labels using API and format as "Name        Description"
+glab api /projects/qemu-project%2Fqemu/labels --paginate | jq -r '.[] | [ .name, .description ] | @tsv' | column -t -s $'\t' > ../assets/labels.txt
+
+echo "Labels cached in assets/labels.txt"
-- 
2.47.3


