Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F8CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU4W-0001Ee-TJ; Mon, 11 May 2026 13:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU49-000101-Kq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU46-0007p7-6a
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso54015375e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519108; x=1779123908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F430KIL/wqQpCxSrWFTR0tJcFgbRfpXFB58q8W/ETdo=;
 b=uIx0875qiWYqNuPElM1i0vkhu9ywtLdtb+L1TOUMgJkEW5wGWeVLe+ab3RRAkCFZqk
 +TMvjKptFLXtzfszuKFRDjiAiKSc8CTdrrC+mobJJv8C5AgafkdahpB8mgjjvufe5bnm
 LzNZFcLHQDDmUtGZDuM+HeVA7b6ZlANCFbyXGdXEcUV+Af9yVA4EsVP7yyquUs/b2Iqs
 8Y7BMzrYMMF/voEEDFH5oS43r3ekypxnZZAMVu2a+kDBrQUDdCa0HTe1UzTrBj4ziX1c
 2WKIUX9b5xHi8TBiFEtML9RN2VK5CGQjSMrnBO8F90xucjf065GvF7F93pNd/Mw9Bs3B
 3RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519108; x=1779123908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F430KIL/wqQpCxSrWFTR0tJcFgbRfpXFB58q8W/ETdo=;
 b=rfoU76j6pctp8e5ZWVONXqxnQ8Xm8GLARkmGqoL7FD0BFIuebNkVhhclgR2OUz/BFv
 NPN1jSPv06V2Nw9Gxn16Vmp+32FzKzBkft4U6xdmMBHIk8VKKa3G0A7Oh9H5Qd3/YIAr
 K1mdCVmGb0N+fzjdul5oh/NA403jn5we8fS/CRDBaf0JiTaHrfsCn/wITri59gWNokEm
 VpjnedEMP1B4yz9WZ1393E42BJt5IjCuRsdkVS3ziEU4bIXqSPGRpnNCOZHCpaxZBsXm
 +r6/qd1XwZD82MRUMZuCO2k/9A9xBxzj3lAEBNc9ficAFLbC6uIh0dvBmqU2psuPPvZp
 upug==
X-Gm-Message-State: AOJu0Yzp0LMycyY/odNKKIHUB2nTk8f7LT2X/ftwTGVRh0ptVAsE2xs0
 8ImunXbwidlVQd38mlaSlaL6wdR9q1ek9aSjnmYftEZm+irz7tSGa/5Cg7PUH2N29xY=
X-Gm-Gg: Acq92OGa0Xd1I4m/QLpAa3rw8xsMTRyipe0kkVRJAOfRcIUJ9uAieJ95n1tj8RcqlPH
 ybR/I7prA85QbGABlVfJ6To0KyoFnBG55RQDr71GkZTqYXHnkfqU75ZWQUSlR64cuQlToYC5kjl
 xE1ZYQbW07gj7Fxpyq0VusQ2kwC3mKZjjRwWz0fsXzvvWrr3oT2k3SWIYNLL60eFv/jtHiX92Hb
 20gGiWNEen/N9LvNGqExEHvDIeNA7dIueAhGzNMhA44iUenGP3OYCbDFrY31B9EgJdcbNorlR1f
 Wm8h9BYxIsxQdUUjN4UQnokZII6Rv1AugWs9xzHzn92x+w2tlSdIHQlHOppFj4PnIdAc+r0fqxc
 yqH53unXYm+guxSH7txz1+6TiMc1k6bvEkzgn1Yy4+/Gk8OM+uSxjf0kTFgtXm7RCed2MIQfQIW
 r6du6uwWXnzTq/8dw1yQEJFO4=
X-Received: by 2002:a05:600c:a110:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-48e51f2e8a3mr362288435e9.14.1778519108159; 
 Mon, 11 May 2026 10:05:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fffba52sm225952765e9.3.2026.05.11.10.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D45460F46;
 Mon, 11 May 2026 18:05:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 09/10] .agents/skills: add qemu-issue-triage agent skill
Date: Mon, 11 May 2026 18:04:58 +0100
Message-ID: <20260511170500.124211-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

We might want to consider adding some common "issue smells" for common
problems in issues. For example triggering asserts that have been
added to the code and other such annoyances.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - fix a bunch of typos in SKILL
  - update evals
  - remove mentions of ECA
  - fix typo referencing old skill name
  - remove eca__spawn_agent reference
  - clean-up authentication handling
  - teach it about scoped labels
  - make less chatty in the comments
  - updated commit msg
  - suggest running things in parallel (use agents)
  - more pointers to incompleteness
v3
  - more imperative phrasing
v2
  - prefer sub-agent
  - mention parameters
  - don't be over eager to tag host or target for generic bugs
  - signoff comments as an agent on behalf of the user
  - detect patch available and apply appropriate tags
---
 .agents/skills/qemu-issue-triage/SKILL.md     | 112 +++++++++++++++
 .../qemu-issue-triage/assets/labels.txt       | 133 ++++++++++++++++++
 .../skills/qemu-issue-triage/evals/evals.json |  18 +++
 .../scripts/update_labels.sh                  |  16 +++
 AGENTS.md                                     |   1 +
 5 files changed, 280 insertions(+)
 create mode 100644 .agents/skills/qemu-issue-triage/SKILL.md
 create mode 100644 .agents/skills/qemu-issue-triage/assets/labels.txt
 create mode 100644 .agents/skills/qemu-issue-triage/evals/evals.json
 create mode 100755 .agents/skills/qemu-issue-triage/scripts/update_labels.sh

diff --git a/.agents/skills/qemu-issue-triage/SKILL.md b/.agents/skills/qemu-issue-triage/SKILL.md
new file mode 100644
index 00000000000..a0802e24dd3
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/SKILL.md
@@ -0,0 +1,112 @@
+---
+name: qemu-issue-triage
+description: Use this skill to triage and label GitLab issues for the QEMU project
+license: GPL-2.0-or-later
+---
+
+# Instructions
+
+This skill provides specialized instructions for triaging GitLab issues for the QEMU project.
+
+## Parameter Handling & Execution Strategy (CRITICAL)
+1. **Parameters**: If the user invokes this skill with multiple arguments or a list of IDs (e.g., `#3430, #3426`), treat each as an independent target.
+2. **Sub-Agent Mandate**: To prevent polluting the main conversation context, **you MUST ALWAYS spawn a sub-agent** to perform the actual triage.
+   - **Parallelization**: When multiple IDs are provided, spawn one sub-agent per issue in parallel to improve efficiency.
+   - Do NOT run `glab` commands or read the label cache directly in the main context.
+   - In the `task` parameter for the sub-agent, provide the target `<issue-id>` and explicitly instruct the sub-agent to follow the "Triage Workflow" and "Asset Management" rules defined below.
+   - Wait for the sub-agent to finish and simply report its summary to the user.
+
+## Goal
+Automate the initial triage of new bug reports and feature requests in the QEMU GitLab repository.
+
+## Prerequisites
+- `glab` CLI tool installed.
+- An authentication method: Use `glab auth status` to check. You can pass a token by using `env GITLAB_TOKEN=<token>` in front of commands if you have it.
+- Target Repo: Use `-R qemu-project/qemu` if not in a clone, or ensure the remote is set correctly.
+
+## Asset Management (Label Cache)
+This skill uses a cached list of labels to avoid unnecessary API calls and ensure consistent labeling.
+- **Cache Location:** `assets/labels.txt` relative to this skill.
+- **Updating the Cache:** If the user asks to update the labels, or if you suspect a label is missing, run the provided script:
+  ```bash
+  cd .agents/skills/qemu-issue-triage/scripts && ./update_labels.sh
+  ```
+- **Using the Cache:** Before applying labels, ALWAYS read `assets/labels.txt` (or use `grep` on it) to review the available labels and their descriptions. This ensures you use the exact spelling and understand the intent behind the label (e.g., `kind::Bug`, `Storage`). Do NOT guess label names.
+
+## Triage Workflow
+
+### 1. Information Gathering
+Fetch the issue details:
+```bash
+glab issue view <issue-id> -R qemu-project/qemu --comments
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
+**Workflow::Needs Info Triggers (CRITICAL):**
+Request more information and apply the `workflow::Needs Info` label if any of the following are true:
+- **Missing Command Line**: The full QEMU command line (`qemu-system-* ...`) used to reproduce the issue is missing.
+- **Old QEMU Version**: The reported version is older than the last two major releases. Ask the reporter to re-test with the current upstream master or the latest stable release.
+- **Distro Version**: The version string suggests a downstream/distro-specific package (e.g., contains suffixes like `.el9`, `.fc40`, `-ubuntu`, or long strings like `7.2.0-14.sc05...`). Ask the reporter to reproduce the issue using a clean build from the current upstream source to rule out distro-specific patches.
+
+**Actions:**
+- If information is missing based on the triggers above, add the `workflow::Needs Info` label and post a polite comment asking for the specific missing details. (Remember to sign the comment as "Issue Agent Bot on behalf of the user" per the Guidelines).
+- If the issue is well-defined and uses a recent upstream version, proceed to categorization.
+
+### 3. Categorization & Labelling
+Apply labels based on the issue content. **Crucially, consult `assets/labels.txt` to find the exact matching labels for the categories below.**
+
+#### Scoped Labels (Prefix::Label)
+QEMU uses scoped labels (e.g., `kind::Bug`, `workflow::Triaged`) to group related categories.
+- **Prefixes:** Common prefixes include `kind::`, `workflow::`, `Closed::`, `Audit Tooling::`, `GUI::`.
+- **Constraint:** Only one label from that scope can be active at a time. Applying a new scoped label of the same type (e.g `workflow::`) will remove the other.
+
+#### Kinds
+- `kind::Bug`: For unexpected behavior.
+- `kind::Feature Request`: For new functionality.
+- `kind::Task`: For research, investigations, and miscellaneous issues.
+
+#### Targets (target: *) and Hosts (host: *)
+Detect the guest architecture (`target: *`) or host environment (`host: *`).
+**IMPORTANT:** Be conservative when applying `target:` and `host:` labels. Many bugs (e.g., in generic devices like USB, PCI, or block controllers) apply to ANY guest that includes the device. The reproducer (like a `qtest` invocation) might just use a convenient target (e.g., `i386`) as an example. ONLY apply `target:` or `host:` labels if the bug is strictly architecture- or host-dependent (e.g., a bug in ARM CPU emulation, or a macOS-specific build failure).
+
+#### Accelerators (accel: *)
+Detect the accelerator mentioned (e.g., `accel: KVM`, `accel: TCG`, `accel: HVF`).
+
+#### Subsystems
+Identify the relevant subsystem (e.g., `Storage`, `Networking`, `device:virtio`, `Migration`).
+
+#### Testcases
+- If the issue provides a minimal C program, a shell script, or a specific disk image to reproduce the bug, apply the `TestCase` label.
+
+#### Patches and Fixes
+- If the issue description or comments contain a link to a patch on the mailing list (e.g., `lore.kernel.org`, `patchew.org`), or explicitly mention that a patch/fix has been submitted, apply the `workflow::Patch available` label.
+
+#### Workflow Management
+The `workflow::` labels track the lifecycle of an issue.
+- **Single Workflow Label:** An issue can only have one `workflow::` label at a time.
+- **Transitioning:** Adding a new workflow label will automatically remove the old one (e.g., adding `workflow::Patch available` will remove `workflow::Triaged`).
+
+#### Other comments
+- If other developers have commented see if those comments imply additional tags should be applied.
+
+### 4. Updating the Issue
+Apply the labels and optionally assign a priority if clear.
+**Transitioning Workflow Example:**
+```bash
+glab issue update <issue-id> -R qemu-project/qemu --label "workflow::Triaged,kind::Bug"
+```
+
+## Guidelines
+- Be polite and professional in comments.
+- **IMPORTANT:** Any comments added to the issue MUST include the phrase: "Issue Agent Bot on behalf of the user" (e.g., as a sign-off at the end of the message).
+- Avoid commenting unless additional information is needed, specifically a comment to acknowledge the report is superfluous.
+- Use `workflow::Triaged` once categorization is complete.
+- Avoid assigning issues to specific people unless they are explicitly mentioned or are the known maintainer for a very specific subsystem.
+- Use the `scripts/get_maintainer.pl` logic (via file paths mentioned in the issue) to identify potential subsystems.
diff --git a/.agents/skills/qemu-issue-triage/assets/labels.txt b/.agents/skills/qemu-issue-triage/assets/labels.txt
new file mode 100644
index 00000000000..12d3cc7e6f0
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/assets/labels.txt
@@ -0,0 +1,133 @@
+ACPI                            Power Management related (ACPI / SMBIOS / HEST / GHES)
+Audio                           Audio devices; both backend (host audio) and frontend (guest audio)
+Audit Tooling::AI               For bugs found with AI assisted tools such as Mythos and other similar things
+Audit Tooling::Fuzzer           Issues found via fuzzing. For security issues, please consult https://www.qemu.org/contribute/security-process/
+Audit Tooling::Other            Some unknown/unclassified type of audit tooling.
+Audit Tooling::Sanitizer        For issues found using sanitizers such as asan, lsan and tsan
+Audit Tooling::Static Analysis  Static analysis such as Coverity or more modern compilers.
+Bite Sized                      Candidates for first contributions; see also https://wiki.qemu.org/Contribute/BiteSizedTasks
+Build System                    configure, make, Meson, ninja, gcc, clang, ccache, etc.
+CI                              Continuous Integration; gitlab, patchew, etc.
+CLI                             Command Line Interface
+Chardev                         Character device backends and related issues
+Closed::Duplicate               There is already another ticket that is about the same issue
+Closed::Fixed                   The issue was fixed. Yay!
+Closed::Invalid                 This issue was not really a problem
+Closed::NotOurBug               This is a bug, but not a bug in QEMU. Please report it and/or include a link to the report.
+Closed::NotReproducible         This issue was not reproducible
+Closed::UnbackedFeature         Nobody was willing to work on this feature request
+Closed::WontFix                 The issue was acknowledged, but the fix would be too complex, too expensive, or would introduce other problems.
+Cryptography                    
+Documentation                   Sphinx documentation, man pages, the wiki, --help output, etc.
+GDB                             Issues relating to using GDB via the gdbstub
+GUI                             Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
+GUI::Cocoa                      Cocoa
+GUI::DBus                       DBus
+GUI::GTK                        GTK
+GUI::SDL                        SDL
+GUI::SPICE                      SPICE
+GUI::VNC                        
+Guest Agent                     Issues related to the qemu-guest-agent binary. https://wiki.qemu.org/Features/GuestAgent
+Hard                            
+Launchpad                       Issues migrated from Launchpad
+Migration                       
+Modules                         
+Networking                      
+Python                          Python library issues (./python/)
+QAPI/QMP                        QEMU API / QEMU Machine Protocol, HMP and CLI, etc.
+QOM                             QEMU Object Model
+Regression                      This is a regression from previously working behaviour
+Security                        This is a security issue - see https://www.qemu.org/docs/master/system/security.html for guidance
+Semihosting                     Semihosting calls provide a simple ABI for early bring-up of embedded devices, see https://www.qemu.org/docs/master/about/emulation.html#semihosting
+Softfloat                       QEMU's FPU emulation code (TCG only)
+Stable::can't fix               The bug was reported on a stable branch but the fix is too invasive for backporting
+Stable::obsolete                The bug was reported on a stable branch that is not maintained anymore
+Stable::to backport             The bug was reported on a stable branch and needs to be backported on the next release from the branch
+Storage                         Block subsystem, Storage devices, etc.
+TCG plugins                     Anything related to the TCG plugins feature
+TestCase                        The report includes a testcase
+Tests                           qtests, iotests, acceptance tests, VM tests, docker tests, and more. See https://www.qemu.org/docs/master/devel/testing/index.html
+USB                             
+VFIO                            
+accel: HAX                      Intel's Hardware Accelerated Execution Manager (HAXM)
+accel: HVF                      Apple Hypervisor Framework
+accel: KVM                      Linux Kernel-based Virtual Machine
+accel: TCG                      QEMU Tiny Code Generator
+accel: WHPX                     Microsoft Windows Hypervisor Platform (WHPX)
+accel: Xen                      Xen Hypervisor
+block:9p                        The 9p network file system
+block:NVMe                      
+block:curl                      
+block:nbd                       
+block:nfs                       Issues related to the NFS backend
+block:qcow2                     
+block:ssh                       
+block:vmdk                      
+bsd-user                        
+device: PCI                     
+device: TPM                     Trusted Platform Module (TPM) devices
+device: iommu                   
+device: mmio                    mmio and other directly emulated devices
+device:graphics                 Issues relating to display device emulation, or rendering in general. See also "GUI".
+device:input                    Keyboards, Mice, Touchscreens, HIDs, etc.
+device:iommu                    IOMMU and SMMU
+device:pflash                   Parallel NOR flashes emulation
+device:sdmmc                    SD or (e)MMC cards emulation
+device:virtio                   virtio-related issues. https://www.linux-kvm.org/page/Virtio
+device:watchdog                 
+efi                             EFI firmware related issues
+flaky-ci                        For test cases that are flaky when run under our CI
+gitlab                          
+guest: AIX                      
+guest: BSD                      Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
+guest: Linux                    Guest OS is Linux/Linux-based
+guest: Windows                  Microsoft Windows guest
+guest: macOS                    Apple macOS / Darwin as  guest OS
+guest: os2                      
+host: aarch64                   Bugs reproducible on AArch64 hosts
+host: arm                       Bugs reproducible on ARM hosts
+host: loongarch64               Bugs reproducible on LoongArch64 hosts.
+host: mips                      Bugs reproducible on MIPS hosts
+host: ppc                       Bugs reproducible on Power hosts
+host: riscv                     Bugs reproducible on RISC-V hosts
+host: s390                      Bugs reproducible on s390 hosts
+host: sparc64                   Bugs specific to Sparc64 hosts
+host: x86                       Bugs reproducible on x86 hosts
+host:32bit                      These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.
+hostos: BSD                     FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
+hostos: Linux                   Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
+hostos: Windows                 Microsoft Windows host OS
+hostos: macOS                   Apple macOS / Darwin as a host OS
+icount                          issues relating to icount, deterministic execution and record/replay functionality
+kind::Bug                       Bug or defect in functionality.
+kind::Feature Request           Feature request or new functionality.
+kind::Task                      Research, investigations, and miscellaneous issues.
+libvfio-user                    
+linux-user                      issues with QEMU's lightweight user-mode emulator
+qemu-img                        
+sysadmin                        Issues related to QEMU project infrastructure. You should probably also check on the projects IRC channel if the issue is urgent - https://www.qemu.org/support/
+target: alpha                   DEC Alpha [alpha]
+target: arm                     Arm AArch32 or AArch64 [arm, aarch64]
+target: avr                     Atmel AVR [avr]
+target: hexagon                 Qualcomm Hexagon [hexagon]
+target: hppa                    Hewlett-Packard Precision Architecture; HP/HP, PA-RISC [hppa]
+target: i386                    Intel/AMD x86 [i386, x86_64]
+target: loongarch               loongarch64 target architecture
+target: m68k                    Motorola 68000 [m68k]
+target: microblaze              Xilinx MicroBlaze [microblaze, microblazeel]
+target: mips                    MIPS [mips, mipsel, mips64, mips64el]
+target: nios2                   Altera Nios II [nios2]
+target: openrisc                OpenRISC [or1k]
+target: ppc                     IBM Power Architecture, PowerPC [ppc, ppc64, ppc64le]
+target: riscv                   RISC-V [riscv32, riscv64]
+target: rx                      Renesas RX [rx]
+target: s390x                   IBM Z, SystemZ, zSeries [s390x]
+target: sh4                     Renesas SuperH [sh4, sh4eb]
+target: sparc                   Sun Microsystems SPARC [sparc, sparc64]
+target: tricore                 Infineon TriCore [tricore]
+target: xtensa                  Tensilica Xtensa [xtensa, xtensaeb]
+workflow::Confirmed             Bugs that have been confirmed and reproduced.
+workflow::In Progress           Someone is working on this issue.
+workflow::Needs Info            Issue has insufficient information to verify.
+workflow::Patch available       A patch is available
+workflow::Triaged               Issue has been triaged and given a topic label.
diff --git a/.agents/skills/qemu-issue-triage/evals/evals.json b/.agents/skills/qemu-issue-triage/evals/evals.json
new file mode 100644
index 00000000000..572c0723fd4
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/evals/evals.json
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+{
+  "skill_name": "qemu-issue-triage",
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
diff --git a/.agents/skills/qemu-issue-triage/scripts/update_labels.sh b/.agents/skills/qemu-issue-triage/scripts/update_labels.sh
new file mode 100755
index 00000000000..1605eab4de5
--- /dev/null
+++ b/.agents/skills/qemu-issue-triage/scripts/update_labels.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+set -e
+
+if [ -z "$GITLAB_TOKEN" ]; then
+    echo "GITLAB_TOKEN is not set. Attempting to fetch via pass..."
+    export GITLAB_TOKEN=$(pass gitlab-api)
+fi
+
+echo "Fetching labels from qemu-project/qemu..."
+# Fetch labels using API and format as "Name        Description"
+glab api /projects/qemu-project%2Fqemu/labels --paginate | \
+    jq -r '.[] | [ .name, .description ] | @tsv' | \
+    column -t -s $'\t' > ../assets/labels.txt
+
+echo "Labels cached in assets/labels.txt"
diff --git a/AGENTS.md b/AGENTS.md
index ca292460403..6387d164816 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -30,6 +30,7 @@ You should use the following specialized skills for common tasks:
 - `qemu-code-reviewer`: For pulling and applying patch series from mailing lists.
 - `qemu-mail-thread`: For analyzing and parsing mailing list threads.
 - `qemu-issue-helper`: For fetching and summarising issue details from the bug tracker.
+- `qemu-issue-triage`: For helping triage issues in the bug tracker.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


