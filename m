Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C3606AEEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ZedYKNYO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRH7b-0005gD-CS; Wed, 11 Nov 2026 17:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.conder@canonical.com>)
 id 1xRGsm-0006z2-F8
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 17:33:32 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.conder@canonical.com>)
 id 1xRGsj-00058P-Ta
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 17:33:32 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31BD33F131
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794436406;
 bh=PDUOFdNAopjaxt5y2kHoap7a7DbXn2qTLA+goI8zeas=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZedYKNYOm+rYdPndqnb3yg/YM6xNSdA6VyVhppbmAHLscxgNG5Q1zLSsoCHBPhvQb
 egYnwCZ3yUx05BIfqLM01iOCRyJFyIajOPhUO4o1TNtLdz2Vzd77By5cezDK7I3Vg/
 B6FnypiF6+x4EzQgbzPLlM/Ew7tJqGBUubnpUHzKN3T8Eo7P42aCgfsjwedaHSXkXR
 AqUCqqbpcJMoUl+pXGJUThqhFFf+msp1uBgZ8SME920VNy8oLsddLnfp+h/fgW2DXW
 enwBtW1Cbu9E1NzWOLRGI5WFJ9AO6YiGqOgsrtMk3Pl9LqWK3Tq76yFR6wVImW+Nbk
 rk3B60EflPUtJ+e4DbYdbrpJIsYiDum1jZdPN5nLC4YHIC5npNDlklSAk4Gzc+8yWe
 prmO3TAvu9cE8OvgMMkMmRox+dNNnmMr4s+YuDVu/AuOuDoQZx8Y/CEO8rCM0IA1/B
 D2fhFBUFz34E16cq1WhOEu6q5mJWH++cwCUqmxZuBxoamAF8yTLWo2DvDQsP2y7mlj
 SHgINIP5hBxEGjW6L4DMcHXnxPVZjZIXA8th+XhleYtNTdU2WhLnu8oXIBpFk07a5O
 nFZzQCJjBdoarbJ5f5G96YYpZ6TSrkFqWIzFs80Wxqsy+9lDi5xyEggMtyUCCzudMR
 RkoMB9VMJjQNK8xxXhYZ3frI=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea26178b32so2707275ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 14:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794436405; x=1795041205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDUOFdNAopjaxt5y2kHoap7a7DbXn2qTLA+goI8zeas=;
 b=w78kXEZTo1VD/6qaMjEgk9cbwFFbvYOHZQ/xmuysL2li9gqFlDwVZCYxgUeaKbrwvQ
 41TkhLnw0PAgRt+INISFZYzc49d28Nn3gaGnjLTnHYtgv8N7tq0NNO7RK7crSKb3FB+h
 GAFsvvfZ8g8JE9ZbY6x90SlLw6/JqOIRYNzj2OPq6fUnDwOkhF8nuFOo5CqIStumMZeZ
 kYw/an45ONsam4n+4AE2facd7IR2UiSz6YkDVaE3IXfa2tosEWNw/oqqF7yPXkYe14K1
 npYzyTPBiqB3XMHRhrHRIWPpuMIy+qtj2YYki0YtJGwXqpb1In6rGobN2ygrmOOkIgW7
 WzwQ==
X-Gm-Message-State: APuU4Z+GsEyLYfR+LFtnmzPWSElOhi1sOwaq7ZT2JJmT/qoMZCBB/qjf
 vbZAlhlvZYyNgAlefUEuivIDYjfDQ1geoVVVROw0gHqGt/YyVnIYXwTGu1F91ySPMxRY6NzSS2S
 /QtUbxT8qY5UkWbN3IA7hCQpH9+feVk+bMTutUDF4QXBw8RRN0aVhgnshCIh1AKalipROgG7rsm
 jS7001bVoylg==
X-Gm-Gg: AYBFou0gFdXnUTaB8A5pak4Es97AnwhD9arwhyAGHSg+tuX/Mdq4RKpbIbU+MLbhLvg
 KGX50Bf0fo5nRLOuIyEY+QC06vYFqZGz3XYnWvh0TdHKonsuKZmN0ENPCUrpl6XPb34j2Dzt7Lk
 EoRb2gYQFuWo+yxIaNI3jx+nnXi1NOeaLJh8t5bEts0jyQCcdZuT021kUSg4LhLXf1tMD3dyjta
 gRcLDhXGX9KYxypkIleRimcSNkJ7Ttav64M+SKCGKezb2Y8uG7xoEDe/3Dzd/nhSi75Y7oefnP2
 q/D6NLxyiBlVvFt7ax5PJoNIjfP3G4xJMLtVkKQ+GVs/RdhHp/+si0NLG2ALeqOW/EwOq1GDXq5
 PViovBUkQ54x4he6MCwX47wpsvKuVZoRT0txYOx3nxprwrve+Raas++P+lWRW3RdBvYY=
X-Received: by 2002:a17:903:120d:b0:2ed:29a5:782d with SMTP id
 d9443c01a7336-2edd7625ce9mr62898975ad.2.1794436404701; 
 Wed, 11 Nov 2026 14:33:24 -0800 (PST)
X-Received: by 2002:a17:903:120d:b0:2ed:29a5:782d with SMTP id
 d9443c01a7336-2edd7625ce9mr62898775ad.2.1794436404232; 
 Wed, 11 Nov 2026 14:33:24 -0800 (PST)
Received: from jeconder-p14s6.. ([101.98.128.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6e0c9cesm23950215ad.69.2026.11.11.14.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 14:33:23 -0800 (PST)
From: Jonathan Conder <jonathan.conder@canonical.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Conder <jonathan.conder@canonical.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] system/physmem: increase memfd-backed RAM alignment
Date: Thu, 12 Nov 2026 11:32:57 +1300
Message-ID: <20261111223257.86432-1-jonathan.conder@canonical.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=jonathan.conder@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Nov 2026 17:48:46 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a VM boot optimisation for Linux systems with transparent huge
pages enabled for shared memory. It shaves about 1.4s off a 13s boot.
For nested VMs it reduces a 22.5s boot by about 4.6s.

It applies to VMs using memory-backend-memfd, which LXD uses by default.
Other backends can already use huge pages [1], but the memfd backend
only will if allocations are aligned correctly. This patch fixes that.

A drawback is that pc-dimm devices need to have sizes compatible with
the new alignment. I could have limited the change to x86_64 + KVM only,
which is the only configuration I've tested. It's already enabled for
s390x + KVM. But I think any system can benefit from using huge pages.

Disclaimer: I found this issue with LLM assistance. It located the part
of the code responsible for alignment in the memfd backend, but I typed
out the change myself.

[1] https://linuxcontainers.org/incus/docs/main/explanation/performance_tuning/#virtual-machine-memory-allocation

Signed-off-by: Jonathan Conder <jonathan.conder@canonical.com>
---
Tested using the following script. It's AI-generated but I can vouch
that it does the right thing.

To run it, build QEMU, download a Debian image [2] and set
/sys/kernel/mm/transparent_hugepage/shmem_enabled to "advise." Any image
should work, provided you supply any flags it needs to boot properly.

I ran it 3 times per configuration. Results:

Before (bare metal):
boot: 13135ms 12918ms 13046ms
huge pages mapped: 0 0 0

After (bare metal):
boot: 11694ms 11647ms 11687ms
huge pages mapped: 264 269 265

Before (inside another VM):
boot: 22528ms 22232ms 22327ms
huge pages mapped: 0 0 0

After (inside another VM):
boot: 17498ms 17677ms 18085ms
huge pages mapped: 265 271 266

Reproducer:
#!/bin/bash
# Time how long a VM using memfd-backed RAM takes to boot.

set -eo pipefail

build=${1:-build}
image=${2:-debian-13-nocloud-amd64-20261103-2651.qcow2}

huge_pages_mapped() {
	awk '$1 == "thp_file_mapped" { print $2 }' /proc/vmstat
}

fifo=$(mktemp -u)
mkfifo "$fifo"
trap 'rm -f "$fifo"' EXIT

before=$(huge_pages_mapped)
start=$(date +%s%N)

"$build/qemu-system-x86_64" \
	-accel kvm -m 4G \
	-machine q35,memory-backend=ram \
	-object memory-backend-memfd,id=ram,size=4G \
	-nodefaults -display none -serial stdio -snapshot \
	-drive if=pflash,format=raw,file="$build/pc-bios/edk2-x86_64-code.fd" \
	-drive if=virtio,file="$image" \
	-smbios type=11,value=io.systemd.credential:firstboot.timezone=UTC \
	-smbios type=11,value=io.systemd.credential:passwd.hashed-password.root= \
	</dev/null >"$fifo" &
grep -a -q -m1 'Reached target .*graphical\.target' "$fifo"

end=$(date +%s%N)
after=$(huge_pages_mapped)

kill -KILL $!
wait $! 2>/dev/null || true

echo "boot: $(( (end - start) / 1000000 ))ms, huge pages mapped: $(( after - before ))"

[2] https://cloud.debian.org/images/cloud/trixie/20261103-2651/debian-13-nocloud-amd64-20261103-2651.qcow2

 system/physmem.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index a7300bb9d9..758469bb3a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1730,11 +1730,7 @@ static void *file_ram_alloc(RAMBlock *block,
         return NULL;
     }
     block->mr->align = MAX(block->page_size, block->mr->align);
-#if defined(__s390x__)
-    if (kvm_enabled()) {
-        block->mr->align = MAX(block->mr->align, QEMU_VMALLOC_ALIGN);
-    }
-#endif
+    block->mr->align = MAX(block->mr->align, QEMU_VMALLOC_ALIGN);
 
     if (memory < block->page_size) {
         error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be equal to "
-- 
2.43.0


