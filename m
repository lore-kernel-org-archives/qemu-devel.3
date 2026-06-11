Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B89CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjlR-0004Iu-Cu; Thu, 11 Jun 2026 14:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjlO-00046C-RF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:04:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjlJ-0007Bh-7Y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:04:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BH9hhI1140985
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +AW/jx7t8c+PuA8BsJNAckFG54269Tp8rvJGVEwGHVs=; b=N6hXpK2eVN+ke0NP
 6Qw2MYH6ciRjCuW/8t4TTC+uB6qfMTEJEIDA+qwslwsMZPpqUtFJw9mA0fJSg6FR
 hDAKq0f3EQl/CDmwAhJjLLPmBe5pg0ZevS4pcphrQlvp21Fc4u8461iAkA7fn10m
 ZXbFlxnCqL7sdLDwj0+tCbHxFwMEjwZQd/utFzAoeISorskdIh66JHg+/iX4iEK0
 gbVA49X+8AJf6H8BhaYtd/YrK/w6/IxI5MO2tb3tf95GwoyepRk8twN8fdpkn+vC
 qPbm+bzM3idY4SRnAlOrTWf0hqhu7VjlaHZAqKQvdojyUJQ2rRtFHDnjEP2gVGs3
 IRVVVw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er16587m8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:04:15 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e74781faaaso285892a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201054; x=1781805854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AW/jx7t8c+PuA8BsJNAckFG54269Tp8rvJGVEwGHVs=;
 b=TC5+Q4IVPB8Xx5wa7hGAVJcunpdMV2F2R4u0eY6Pj60anC5wl7AVEM5hbUsNcrEiEE
 wcUAiUULH9PF2HYTJBXV1Wqgr4jf59PqWZiqbnG05fMoG4gTSZOc0j9rsWYM9AEN+1/m
 JXemN05VPJ22cw+T/ie6oXiLKyaKghV9uX6RRSJRSunSAFUe7uje9OKVFrc0HvcHng9M
 MdCtkoBazM/R0pk0yhxqS1xcF6CiPb/XQ6gVOxXqmNqtQVCKHRz4A2ytHCpkquNIo0Ct
 I5zC8y+PRbjXVYx0rjln+5SNBSLyda3mYla2rg65R/AEI5Pe7TheJZ9gnrq9BrHsoGRj
 TYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201054; x=1781805854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AW/jx7t8c+PuA8BsJNAckFG54269Tp8rvJGVEwGHVs=;
 b=LT50910E5gFgGJ9zO323V2o1a7MrP2R3xiP8kjTUOFknVo39LdcoxZCHGjuKuCsPxD
 +j/ZwFR9Um/CSt28DJqj7QLf8AQdKB0ftoPfBq46enTm7O53m+ymIFxQRDZWlQ6HHDay
 oJkFhwnyxg5ReTgG4Y2MqXpWIQpFhmUmuvsAs3inzWv6ThAIUOAu6uiOl3vy+bcpOqNv
 /TPW/1G2MSvpJ1Lg2Qs0ToLjdB6R7PGgKb8aOJPyutk4bZiMwwGLHkHG6xoYC06fF7/C
 8Uy1IwUsxVE6Jad3+jbudAtr6c0x+Xmb7JiMtbBuWup51bv4QW/YaVOyt74Re6G0lk6u
 RHkA==
X-Gm-Message-State: AOJu0Yxd2rfysv7qXLSGWovFTl1zVnsKdF4k28QApw09FeeV4YC+NQ3x
 A8nAjhxeog9yGBITEataOq83cuiK7kr6pEbzWA3exE21KhSD5WbZTaPRpHCxFBQqgA/b5dlf3On
 /x+fBz5EcOjN+E0Qk4Uj6AjByMYdUiztLTAVktG+zGqrUGB/P3+BiVenysG2fndsVTb7/
X-Gm-Gg: Acq92OHZLirYf+MqweDAEXSJZc6xnbr87QLti2nTYniQF5dZY0QYdEp3sf/epqaO9Ao
 +LmByuvbfeSkqWCV2ijaOgRwe7OZW0xD5a7n5xMKMEffiiOllAOU5zVOv7fe8Ii5amZ2tPPQal9
 Xehof8NrXObmuwbs2weBuZ7P7w2HgMchHRVYGvMyLiZxJLYfbpMRR9Al5Ncij2GxOKzMZR72w0Y
 93qFvh4vLsuF8ChyGzhb4TUEnDaKsJIsWRJLyZIJRSHC+eKoSaJndUP7EHUKm07Odl61hwwJAnS
 CbqMizmfSHvM3VX5MH/x2ayYNsU9xL3+Xhi/6qs/cT9xIRk0WdU0X46d6KsW6mbybVngyAryVFm
 0fdrJ4XETEjksvT4aDSqLr4MqKAaeFmYDiZBM21fkhYd08limRqJhkb/oohcoXTuIZ0mg0vz71Y
 wNTuNa3jFd
X-Received: by 2002:a05:6830:828e:b0:7e6:50c0:87a6 with SMTP id
 46e09a7af769-7e7733bf143mr3152055a34.8.1781201051074; 
 Thu, 11 Jun 2026 11:04:11 -0700 (PDT)
X-Received: by 2002:a05:6830:828e:b0:7e6:50c0:87a6 with SMTP id
 46e09a7af769-7e7733bf143mr3151957a34.8.1781201049817; 
 Thu, 11 Jun 2026 11:04:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0d0947sm722458f8f.16.2026.06.11.11.04.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:04:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 6/6] system: Move cpu_physical_memory_*() declarations to
 'system/physmem.h'
Date: Thu, 11 Jun 2026 20:03:20 +0200
Message-ID: <20260611180320.30320-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611180320.30320-1-philmd@oss.qualcomm.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX9xFguQGNdnVZ
 8cUCvCTofolV64YTpoF8c08OSZiu3WbdYjr8OsZ3XCk3Xu4NacbZVgN3HaLJ7/V0IkgjBLgsO0H
 JhHTBhLWix12qTMfsZ9nO+akFAZWOQ180VSbtkk8ZsJQvX5fZ+0tNAvvH1AQj/LmEqvIwNhlGDb
 2GNjDwcQ1dJaCkcdLJdiheyVaviTvm2zM31jYkZXU0kAeQW7AERKbzmkeWvpY5hUcVKCYPQLDpB
 Rdt0UHBbjFAa6+qz5JIzpFyirc3KeiZw+as0C9pGo35+vtWIypmj+1srALhPTDoay1XkVc/XpmR
 yRmUQ7xMQyAPi8+cj2AubYLxuZhmRFgzabc+gRb5UqCxT5fFZ6kPI6xXMLiGKkzcGtS6v3h2B8d
 iaunHwG4/cdW2FAeAOl+GMeQVj2RaK6l/HT4u+8soJjQQWpcyHICpaHV9Id5KjvPsTRqBUIjRfq
 IQr8J6eboryquZpJQlA==
X-Authority-Analysis: v=2.4 cv=LNpWhpW9 c=1 sm=1 tr=0 ts=6a2af89f cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=c3IAZYmd8EhmzQh91DwA:9 a=ebjwetguR2LeTod0:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: yP4UJSdoaE7ygrVJGNMN90SmbNdFFALt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX9s9om7C6dEBW
 hjaguYlY42ogJ886XT89QjEI3leBoKa1WnlGPQzGoJSa69gGhwJPeKt3GTz26H58h73qHw5+H4X
 vGRrVxxt78fR9KlJPHTIBtOU9M+I4i8=
X-Proofpoint-GUID: yP4UJSdoaE7ygrVJGNMN90SmbNdFFALt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The following cpu_physical_memory_*() methods do not involve any
vCPU but only access physical memory:

 - cpu_physical_memory_read()
 - cpu_physical_memory_write()
 - cpu_physical_memory_map()
 - cpu_physical_memory_unmap()

Rename them removing the 'cpu_' prefix, and move then to the
"system/physmem.h" header with the other methods involved in
global physical address space.

Mechanical change using sed, then adding missing headers manually.

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/devel/loads-stores.rst            |  8 ++---
 scripts/coccinelle/exec_rw_const.cocci | 16 ++++-----
 hw/xtensa/bootparam.h                  |  6 ++--
 include/exec/cpu-common.h              | 49 -------------------------
 include/system/physmem.h               | 50 ++++++++++++++++++++++++++
 dump/dump.c                            |  3 +-
 dump/win_dump-x86.c                    |  5 +--
 hw/acpi/ghes.c                         | 24 ++++++-------
 hw/acpi/nvdimm.c                       | 13 +++----
 hw/acpi/vmgenid.c                      |  3 +-
 hw/audio/marvell_88w8618.c             |  3 +-
 hw/char/riscv_htif.c                   |  5 +--
 hw/display/exynos4210_fimd.c           |  7 ++--
 hw/display/omap_lcdc.c                 |  5 +--
 hw/display/ramfb.c                     |  7 ++--
 hw/dma/i8257.c                         |  9 ++---
 hw/dma/omap_dma.c                      |  6 ++--
 hw/dma/rc4030.c                        |  3 +-
 hw/dma/sifive_pdma.c                   |  9 ++---
 hw/hyperv/hyperv.c                     | 25 ++++++-------
 hw/hyperv/syndbg.c                     | 13 +++----
 hw/hyperv/vmbus.c                      |  9 ++---
 hw/i386/kvm/clock.c                    |  3 +-
 hw/i386/vapic.c                        | 21 +++++------
 hw/intc/apic.c                         |  3 +-
 hw/intc/xive2.c                        |  3 +-
 hw/m68k/next-cube.c                    |  3 +-
 hw/microblaze/boot.c                   |  3 +-
 hw/misc/pc-testdev.c                   |  5 +--
 hw/net/fsl_etsec/rings.c               | 13 +++----
 hw/net/mcf_fec.c                       | 11 +++---
 hw/net/opencores_eth.c                 |  9 ++---
 hw/nvram/spapr_nvram.c                 |  9 ++---
 hw/ppc/amigaone.c                      |  5 +--
 hw/ppc/e500.c                          |  3 +-
 hw/ppc/pegasos.c                       | 11 +++---
 hw/ppc/pnv.c                           |  5 +--
 hw/ppc/ppc440_uc.c                     |  9 ++---
 hw/ppc/spapr.c                         |  3 +-
 hw/ppc/spapr_drc.c                     |  3 +-
 hw/ppc/spapr_events.c                  |  9 ++---
 hw/ppc/spapr_hcall.c                   | 17 ++++-----
 hw/ppc/spapr_rtas.c                    |  5 +--
 hw/ppc/spapr_tpm_proxy.c               |  5 +--
 hw/ppc/virtex_ml507.c                  |  3 +-
 hw/s390x/css.c                         |  5 +--
 hw/s390x/ipl.c                         |  9 ++---
 hw/s390x/s390-pci-bus.c                |  5 +--
 hw/s390x/virtio-ccw.c                  |  5 +--
 hw/scsi/vmw_pvscsi.c                   | 12 +++----
 hw/xen/xen_pt_graphics.c               |  4 +--
 hw/xtensa/xtfpga.c                     |  5 +--
 system/cpus.c                          |  3 +-
 system/physmem.c                       | 12 +++----
 54 files changed, 270 insertions(+), 229 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index f2c66e44454..3aeb8bbe8ba 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -439,7 +439,7 @@ Regexes for git grep:
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
 
-``cpu_physical_memory_*``
+``physical_memory_*``
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 These are convenience functions which are identical to
@@ -455,12 +455,12 @@ users are hardware device models. For new code they are better avoided:
   rather than using the system address space
 * some machines do not use this global address space at all
 
-``cpu_physical_memory_read``
+``physical_memory_read``
 
-``cpu_physical_memory_write``
+``physical_memory_write``
 
 Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\)\>``
+ - ``\<physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 4c02c94e04e..6d16db6aa4e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,11 +21,11 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_map(E1, E2, 0)
-+ cpu_physical_memory_map(E1, E2, false)
+- physical_memory_map(E1, E2, 0)
++ physical_memory_map(E1, E2, false)
 |
-- cpu_physical_memory_map(E1, E2, 1)
-+ cpu_physical_memory_map(E1, E2, true)
+- physical_memory_map(E1, E2, 1)
++ physical_memory_map(E1, E2, true)
 )
 
 // Use address_space_write instead of casting to non-const
@@ -74,11 +74,11 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_read(E1, (T *)(E2), E3)
-+ cpu_physical_memory_read(E1, E2, E3)
+- physical_memory_read(E1, (T *)(E2), E3)
++ physical_memory_read(E1, E2, E3)
 |
-- cpu_physical_memory_write(E1, (T *)(E2), E3)
-+ cpu_physical_memory_write(E1, E2, E3)
+- physical_memory_write(E1, (T *)(E2), E3)
++ physical_memory_write(E1, E2, E3)
 |
 
 - dma_memory_read(E1, E2, (T *)(E3), E4)
diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index 4418c78d5bb..1eb741c909d 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -1,8 +1,8 @@
 #ifndef HW_XTENSA_BOOTPARAM_H
 #define HW_XTENSA_BOOTPARAM_H
 
-#include "exec/cpu-common.h"
 #include "exec/tswap.h"
+#include "system/physmem.h"
 
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
 #define BP_TAG_INITRD           0x1002  /* ramdisk addr and size (bp_meminfo) */
@@ -41,9 +41,9 @@ static inline ram_addr_t put_tag(ram_addr_t addr, uint16_t tag,
         .size = tswap16((size + 3) & ~3),
     };
 
-    cpu_physical_memory_write(addr, &bp_tag, sizeof(bp_tag));
+    physical_memory_write(addr, &bp_tag, sizeof(bp_tag));
     addr += sizeof(bp_tag);
-    cpu_physical_memory_write(addr, data, size);
+    physical_memory_write(addr, data, size);
     addr += (size + 3) & ~3;
 
     return addr;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 271736dc53e..24e3eb500bb 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -64,55 +64,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_destroy_address_spaces(CPUState *cpu);
 
-/**
- * cpu_physical_memory_read: Read from the legacy global address space.
- *
- * This function access the legacy global #address_space_memory address
- * space and does not say whether the operation succeeded or failed.
- *
- * @addr: address within the legacy global address space
- * @buf: buffer with the data transferred
- * @len: length of the data transferred
- */
-void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
-/**
- * cpu_physical_memory_write: Write to the legacy global address space.
- *
- * This function access the legacy global #address_space_memory address
- * space and does not say whether the operation succeeded or failed.
- *
- * @addr: address within the legacy global address space
- * @buf: buffer with the data transferred
- * @len: the number of bytes to write
- */
-void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
-/**
- * cpu_physical_memory_map: Map guest physical memory region into host virtual
- *                          address.
- *
- * Map a memory region into the legacy global #address_space_memory address
- * space. May return %NULL and set *@plen to zero(0), if resources needed to
- * perform the mapping are exhausted.
- *
- * @addr: address within that address space
- * @len: pointer to length of buffer; updated on return
- * @is_write: whether the translation operation is for write
- */
-void *cpu_physical_memory_map(hwaddr addr,
-                              hwaddr *plen,
-                              bool is_write);
-/**
- * cpu_physical_memory_unmap: Unmaps a memory region previously mapped by
- *                            cpu_physical_memory_map()
- *
- * @buffer: host pointer as returned by cpu_physical_memory_map()
- * @len: buffer length as returned by cpu_physical_memory_map()
- * @is_write: whether the translation operation is for write
- * @access_len: amount of data actually transferred
- */
-void cpu_physical_memory_unmap(void *buffer, hwaddr len,
-                               bool is_write, hwaddr access_len);
-
 /* vl.c */
 void list_cpus(void);
 
diff --git a/include/system/physmem.h b/include/system/physmem.h
index da91b77bd9b..204dddcb8b2 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -11,6 +11,56 @@
 #include "exec/hwaddr.h"
 #include "system/ramlist.h"
 
+/**
+ * physical_memory_map: Map guest physical memory region into host virtual
+ *                      address.
+ *
+ * Map a memory region into the legacy global #address_space_memory address
+ * space. May return %NULL and set *@plen to zero(0), if resources needed to
+ * perform the mapping are exhausted.
+ *
+ * @addr: address within that address space
+ * @len: pointer to length of buffer; updated on return
+ * @is_write: whether the translation operation is for write
+ */
+void *physical_memory_map(hwaddr addr, hwaddr *plen, bool is_write);
+
+/**
+ * physical_memory_unmap: Unmaps a memory region previously mapped by
+ *                        physical_memory_map()
+ *
+ * @buffer: host pointer as returned by physical_memory_map()
+ * @len: buffer length as returned by physical_memory_map()
+ * @is_write: whether the translation operation is for write
+ * @access_len: amount of data actually transferred
+ */
+void physical_memory_unmap(void *buffer, hwaddr len,
+                           bool is_write, hwaddr access_len);
+
+/**
+ * physical_memory_read: Read from the legacy global address space.
+ *
+ * This function access the legacy global #address_space_memory address
+ * space and does not say whether the operation succeeded or failed.
+ *
+ * @addr: address within the legacy global address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+void physical_memory_read(hwaddr addr, void *buf, hwaddr len);
+
+/**
+ * physical_memory_write: Write to the legacy global address space.
+ *
+ * This function access the legacy global #address_space_memory address
+ * space and does not say whether the operation succeeded or failed.
+ *
+ * @addr: address within the legacy global address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
+void physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
+
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
diff --git a/dump/dump.c b/dump/dump.c
index 1f216e74f5f..eb2ee1c10df 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -21,6 +21,7 @@
 #include "system/dump.h"
 #include "system/runstate.h"
 #include "system/cpus.h"
+#include "system/physmem.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
 #include "qapi/qapi-events-dump.h"
@@ -1892,7 +1893,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
             warn_report("guest note format is unsupported: %" PRIu16, guest_format);
         } else {
             s->guest_note = g_malloc(size + 1); /* +1 for adding \0 */
-            cpu_physical_memory_read(addr, s->guest_note, size);
+            physical_memory_read(addr, s->guest_note, size);
 
             get_note_sizes(s, s->guest_note, NULL, &name_size, &desc_size);
             s->guest_note_size = ELF_NOTE_SIZE(note_head_size, name_size,
diff --git a/dump/win_dump-x86.c b/dump/win_dump-x86.c
index d893dea7f19..8848c8bfca3 100644
--- a/dump/win_dump-x86.c
+++ b/dump/win_dump-x86.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "system/dump.h"
+#include "system/physmem.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
@@ -55,7 +56,7 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
     while (size) {
         len = size;
 
-        buf = cpu_physical_memory_map(addr, &len, false);
+        buf = physical_memory_map(addr, &len, false);
         if (!buf) {
             error_setg(errp, "win-dump: failed to map physical range"
                              " 0x%016" PRIx64 "-0x%016" PRIx64, addr, addr + size - 1);
@@ -64,7 +65,7 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
 
         l = qemu_write_full(fd, buf, len);
         eno = errno;
-        cpu_physical_memory_unmap(buf, addr, false, len);
+        physical_memory_unmap(buf, addr, false, len);
         if (l != len) {
             error_setg_errno(errp, eno, "win-dump: failed to save memory");
             return 0;
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index c42f1721c42..b2d5e349932 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -28,6 +28,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
 #include "exec/cpu-common.h"
+#include "system/physmem.h"
 
 #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
 #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
@@ -432,9 +433,7 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
      * the source ID, as it is stored inside the HEST table.
      */
 
-    cpu_physical_memory_read(ghes_addr, cper_addr,
-                             sizeof(*cper_addr));
-
+    physical_memory_read(ghes_addr, cper_addr, sizeof(*cper_addr));
     *cper_addr = le64_to_cpu(*cper_addr);
 
     /*
@@ -456,8 +455,7 @@ static bool get_ghes_source_offsets(uint16_t source_id,
 
     hest_addr += ACPI_DESC_HEADER_OFFSET;
 
-    cpu_physical_memory_read(hest_addr, &num_sources,
-                             sizeof(num_sources));
+    physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
     num_sources = le32_to_cpu(num_sources);
 
     err_source_entry = hest_addr + sizeof(num_sources);
@@ -469,7 +467,7 @@ static bool get_ghes_source_offsets(uint16_t source_id,
         uint64_t addr = err_source_entry;
         uint16_t type, src_id;
 
-        cpu_physical_memory_read(addr, &type, sizeof(type));
+        physical_memory_read(addr, &type, sizeof(type));
         type = le16_to_cpu(type);
 
         /* For now, we only know the size of GHESv2 table */
@@ -480,7 +478,7 @@ static bool get_ghes_source_offsets(uint16_t source_id,
 
         /* Compare CPER source ID at the GHESv2 structure */
         addr += sizeof(type);
-        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
+        physical_memory_read(addr, &src_id, sizeof(src_id));
         if (le16_to_cpu(src_id) == source_id) {
             break;
         }
@@ -496,17 +494,17 @@ static bool get_ghes_source_offsets(uint16_t source_id,
     hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
                           GAS_ADDR_OFFSET;
 
-    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+    physical_memory_read(hest_err_block_addr, &error_block_addr,
                              sizeof(error_block_addr));
     error_block_addr = le64_to_cpu(error_block_addr);
 
-    cpu_physical_memory_read(error_block_addr, cper_addr,
+    physical_memory_read(error_block_addr, cper_addr,
                              sizeof(*cper_addr));
     *cper_addr = le64_to_cpu(*cper_addr);
 
     hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
                          GAS_ADDR_OFFSET;
-    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
+    physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
                              sizeof(*read_ack_start_addr));
     *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
 
@@ -535,7 +533,7 @@ bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
             return false;
     }
 
-    cpu_physical_memory_read(read_ack_register_addr,
+    physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
     /* zero means OSPM does not acknowledge the error */
@@ -551,11 +549,11 @@ bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
      * Clear the Read Ack Register, OSPM will write 1 to this register when
      * it acknowledges the error.
      */
-    cpu_physical_memory_write(read_ack_register_addr,
+    physical_memory_write(read_ack_register_addr,
                               &read_ack_register, sizeof(uint64_t));
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(cper_addr, cper, len);
+    physical_memory_write(cper_addr, cper, len);
 
     notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
 
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index eb4b4770765..703e854951e 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -35,6 +35,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
+#include "system/physmem.h"
 #include "trace.h"
 #include "exec/cpu-common.h"
 
@@ -515,7 +516,7 @@ nvdimm_dsm_function0(uint32_t supported_func, hwaddr dsm_mem_addr)
         .len = cpu_to_le32(sizeof(func0)),
         .supported_func = cpu_to_le32(supported_func),
     };
-    cpu_physical_memory_write(dsm_mem_addr, &func0, sizeof(func0));
+    physical_memory_write(dsm_mem_addr, &func0, sizeof(func0));
 }
 
 static void
@@ -525,7 +526,7 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
         .len = cpu_to_le32(sizeof(out)),
         .func_ret_status = cpu_to_le32(func_ret_status),
     };
-    cpu_physical_memory_write(dsm_mem_addr, &out, sizeof(out));
+    physical_memory_write(dsm_mem_addr, &out, sizeof(out));
 }
 
 #define NVDIMM_DSM_RET_STATUS_SUCCESS        0 /* Success */
@@ -580,7 +581,7 @@ exit:
     read_fit_out->func_ret_status = cpu_to_le32(func_ret_status);
     memcpy(read_fit_out->fit, fit->data + read_fit->offset, read_len);
 
-    cpu_physical_memory_write(dsm_mem_addr, read_fit_out, size);
+    physical_memory_write(dsm_mem_addr, read_fit_out, size);
 
     g_free(read_fit_out);
 }
@@ -666,7 +667,7 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
     label_size_out.label_size = cpu_to_le32(label_size);
     label_size_out.max_xfer = cpu_to_le32(mxfer);
 
-    cpu_physical_memory_write(dsm_mem_addr, &label_size_out,
+    physical_memory_write(dsm_mem_addr, &label_size_out,
                               sizeof(label_size_out));
 }
 
@@ -735,7 +736,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     nvc->read_label_data(nvdimm, get_label_data_out->out_buf,
                          get_label_data->length, get_label_data->offset);
 
-    cpu_physical_memory_write(dsm_mem_addr, get_label_data_out, size);
+    physical_memory_write(dsm_mem_addr, get_label_data_out, size);
     g_free(get_label_data_out);
 }
 
@@ -845,7 +846,7 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
      * this by copying DSM memory to QEMU local memory.
      */
     in = g_new(NvdimmDsmIn, 1);
-    cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
+    physical_memory_read(dsm_mem_addr, in, sizeof(*in));
 
     in->revision = le32_to_cpu(in->revision);
     in->function = le32_to_cpu(in->function);
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 70ad029057b..27cc0128d11 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "exec/cpu-common.h"
 
@@ -156,7 +157,7 @@ static void vmgenid_update_guest(VmGenIdState *vms)
              * in order to implement the "OVMF SDT Header probe suppressor"
              * see docs/specs/vmgenid.rst for more details.
              */
-            cpu_physical_memory_write(vmgenid_addr, guid_le.data,
+            physical_memory_write(vmgenid_addr, guid_le.data,
                                       sizeof(guid_le.data));
             /* Send _GPE.E05 event */
             acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 4ad4a220a98..061d076dade 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "system/physmem.h"
 
 #define MP_AUDIO_SIZE           0x00001000
 
@@ -87,7 +88,7 @@ static void mv88w8618_audio_callback(void *opaque, int free_out, int free_in)
     if (block_size > 4096) {
         return;
     }
-    cpu_physical_memory_read(s->target_buffer + s->play_pos, buf, block_size);
+    physical_memory_read(s->target_buffer + s->play_pos, buf, block_size);
     mem_buffer = buf;
     if (s->playback_mode & MP_AUDIO_16BIT_SAMPLE) {
         if (s->playback_mode & MP_AUDIO_MONO) {
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index a53d2ace020..488f938d98d 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
 #include "system/dma.h"
+#include "system/physmem.h"
 #include "system/runstate.h"
 #include "exec/cpu-common.h"
 #include "trace.h"
@@ -209,12 +210,12 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                 return;
             } else {
                 uint64_t syscall[8];
-                cpu_physical_memory_read(payload, syscall, sizeof(syscall));
+                physical_memory_read(payload, syscall, sizeof(syscall));
                 if (le64_to_cpu(syscall[0]) == PK_SYS_WRITE &&
                     le64_to_cpu(syscall[1]) == HTIF_DEV_CONSOLE &&
                     le64_to_cpu(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
-                    cpu_physical_memory_read(le64_to_cpu(syscall[2]), &ch, 1);
+                    physical_memory_read(le64_to_cpu(syscall[2]), &ch, 1);
                     /*
                      * XXX this blocks entire thread. Rewrite to use
                      * qemu_chr_fe_write and background I/O callbacks
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index e715183ad54..7507e4fd3ca 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -28,6 +28,7 @@
 #include "hw/core/sysbus.h"
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
+#include "system/physmem.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
@@ -1076,7 +1077,7 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
     }
 
     if (w->host_fb_addr) {
-        cpu_physical_memory_unmap(w->host_fb_addr, w->fb_len, 0, 0);
+        physical_memory_unmap(w->host_fb_addr, w->fb_len, 0, 0);
         w->host_fb_addr = NULL;
         w->fb_len = 0;
     }
@@ -1115,7 +1116,7 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
         goto error_return;
     }
 
-    w->host_fb_addr = cpu_physical_memory_map(fb_start_addr, &fb_mapped_len,
+    w->host_fb_addr = physical_memory_map(fb_start_addr, &fb_mapped_len,
                                               false);
     if (!w->host_fb_addr) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -1127,7 +1128,7 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "FIMD: Window %u mapped framebuffer length is less than "
                       "expected\n", win);
-        cpu_physical_memory_unmap(w->host_fb_addr, fb_mapped_len, 0, 0);
+        physical_memory_unmap(w->host_fb_addr, fb_mapped_len, 0, 0);
         goto error_return;
     }
     memory_region_set_log(w->mem_section.mr, true, DIRTY_MEMORY_VGA);
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 2a8d5ffdd57..b88ea5f2f19 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -24,6 +24,7 @@
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "exec/cpu-common.h"
+#include "system/physmem.h"
 
 struct omap_lcd_panel_s {
     MemoryRegion *sysmem;
@@ -217,7 +218,7 @@ static bool omap_update_display(void *opaque)
 
     frame_offset = 0;
     if (omap_lcd->plm != 2) {
-        cpu_physical_memory_read(
+        physical_memory_read(
                 omap_lcd->dma->phys_framebuffer[omap_lcd->dma->current_frame],
                 omap_lcd->palette, 0x200);
         switch (omap_lcd->palette[0] >> 12 & 7) {
@@ -371,7 +372,7 @@ static void omap_lcd_update(struct omap_lcd_panel_s *s) {
     s->dma->phys_framebuffer[1] = s->dma->src_f2_top;
 
     if (s->plm != 2 && !s->palette_done) {
-        cpu_physical_memory_read(
+        physical_memory_read(
                             s->dma->phys_framebuffer[s->dma->current_frame],
                             s->palette, 0x200);
         s->palette_done = 1;
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 7a88f934e11..f477bdcc218 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -17,6 +17,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "exec/cpu-common.h"
 
@@ -42,7 +43,7 @@ static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
     void *data = pixman_image_get_data(image);
     uint32_t size = pixman_image_get_stride(image) *
         pixman_image_get_height(image);
-    cpu_physical_memory_unmap(data, size, 0, 0);
+    physical_memory_unmap(data, size, 0, 0);
 }
 
 static DisplaySurface *ramfb_create_display_surface(int width, int height,
@@ -64,9 +65,9 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
     }
 
     mapsize = size = stride * (height - 1) + linesize;
-    data = cpu_physical_memory_map(addr, &mapsize, false);
+    data = physical_memory_map(addr, &mapsize, false);
     if (size != mapsize) {
-        cpu_physical_memory_unmap(data, mapsize, 0, 0);
+        physical_memory_unmap(data, mapsize, 0, 0);
         return NULL;
     }
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 3637d8f82d7..d2e495638cb 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -28,6 +28,7 @@
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
 #include "exec/cpu-common.h"
+#include "system/physmem.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -414,7 +415,7 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
         int i;
         uint8_t *p = buf;
 
-        cpu_physical_memory_read (addr - pos - len, buf, len);
+        physical_memory_read (addr - pos - len, buf, len);
         /* What about 16bit transfers? */
         for (i = 0; i < len >> 1; i++) {
             uint8_t b = p[len - i - 1];
@@ -422,7 +423,7 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
         }
     }
     else
-        cpu_physical_memory_read (addr + pos, buf, len);
+        physical_memory_read (addr + pos, buf, len);
 
     return len;
 }
@@ -442,7 +443,7 @@ static int i8257_dma_write_memory(IsaDma *obj, int nchan, void *buf, int pos,
         int i;
         uint8_t *p = buf;
 
-        cpu_physical_memory_write (addr - pos - len, buf, len);
+        physical_memory_write (addr - pos - len, buf, len);
         /* What about 16bit transfers? */
         for (i = 0; i < len; i++) {
             uint8_t b = p[len - i - 1];
@@ -450,7 +451,7 @@ static int i8257_dma_write_memory(IsaDma *obj, int nchan, void *buf, int pos,
         }
     }
     else
-        cpu_physical_memory_write (addr + pos, buf, len);
+        physical_memory_write (addr + pos, buf, len);
 
     return len;
 }
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 668fc490548..77f14414989 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -23,7 +23,7 @@
 #include "hw/arm/omap.h"
 #include "hw/core/irq.h"
 #include "hw/arm/soc_dma.h"
-#include "exec/cpu-common.h"
+#include "system/physmem.h"
 
 struct omap_dma_channel_s {
     /* transfer data */
@@ -348,12 +348,12 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
         /* Transfer a single element */
         /* FIXME: check the endianness */
         if (!ch->constant_fill)
-            cpu_physical_memory_read(a->src, value, ch->data_type);
+            physical_memory_read(a->src, value, ch->data_type);
         else
             *(uint32_t *) value = ch->color;
 
         if (!ch->transparent_copy || *(uint32_t *) value != ch->color)
-            cpu_physical_memory_write(a->dest, value, ch->data_type);
+            physical_memory_write(a->dest, value, ch->data_type);
 
         a->src += a->elem_delta[0];
         a->dest += a->elem_delta[1];
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 159d0173913..546ff67908a 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -34,6 +34,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/address-spaces.h"
+#include "system/physmem.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -303,7 +304,7 @@ static void rc4030_write(void *opaque, hwaddr addr, uint64_t data,
         if (s->cache_ltag == 0x80000001 && s->cache_bmask == 0xf0f0f0f) {
             hwaddr dest = s->cache_ptag & ~0x1;
             dest += (s->cache_maint & 0x3) << 3;
-            cpu_physical_memory_write(dest, &val, 4);
+            physical_memory_write(dest, &val, 4);
         }
         break;
     /* Remote Speed Registers */
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 7b22e514923..c4d2c77beac 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -30,6 +30,7 @@
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
+#include "system/physmem.h"
 #include "hw/dma/sifive_pdma.h"
 
 #define DMA_CONTROL         0x000
@@ -121,16 +122,16 @@ static void sifive_pdma_run(SiFivePDMAState *s, int ch)
     s->chan[ch].exec_src = src;
 
     for (n = 0; n < bytes / size; n++) {
-        cpu_physical_memory_read(s->chan[ch].exec_src, buf, size);
-        cpu_physical_memory_write(s->chan[ch].exec_dst, buf, size);
+        physical_memory_read(s->chan[ch].exec_src, buf, size);
+        physical_memory_write(s->chan[ch].exec_dst, buf, size);
         s->chan[ch].exec_src += size;
         s->chan[ch].exec_dst += size;
         s->chan[ch].exec_bytes -= size;
     }
 
     if (remainder) {
-        cpu_physical_memory_read(s->chan[ch].exec_src, buf, remainder);
-        cpu_physical_memory_write(s->chan[ch].exec_dst, buf, remainder);
+        physical_memory_read(s->chan[ch].exec_src, buf, remainder);
+        physical_memory_write(s->chan[ch].exec_dst, buf, remainder);
         s->chan[ch].exec_src += remainder;
         s->chan[ch].exec_dst += remainder;
         s->chan[ch].exec_bytes -= remainder;
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index a854a4927a0..4d900327857 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -17,6 +17,7 @@
 #include "exec/cpu-common.h"
 #include "linux/kvm.h"
 #include "system/kvm.h"
+#include "system/physmem.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
@@ -622,7 +623,7 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
     }
 
     len = sizeof(*msg);
-    msg = cpu_physical_memory_map(param, &len, 0);
+    msg = physical_memory_map(param, &len, 0);
     if (len < sizeof(*msg)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto unmap;
@@ -643,7 +644,7 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
     }
 
 unmap:
-    cpu_physical_memory_unmap(msg, len, 0, 0);
+    physical_memory_unmap(msg, len, 0, 0);
     return ret;
 }
 
@@ -766,7 +767,7 @@ uint16_t hyperv_hcall_reset_dbg_session(uint64_t outgpa)
     }
 
     len = sizeof(*reset_dbg_session);
-    reset_dbg_session = cpu_physical_memory_map(outgpa, &len, 1);
+    reset_dbg_session = physical_memory_map(outgpa, &len, 1);
     if (!reset_dbg_session || len < sizeof(*reset_dbg_session)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
@@ -789,7 +790,7 @@ uint16_t hyperv_hcall_reset_dbg_session(uint64_t outgpa)
            sizeof(reset_dbg_session->target_mac));
 cleanup:
     if (reset_dbg_session) {
-        cpu_physical_memory_unmap(reset_dbg_session,
+        physical_memory_unmap(reset_dbg_session,
                                   sizeof(*reset_dbg_session), 1, len);
     }
 
@@ -811,14 +812,14 @@ uint16_t hyperv_hcall_retreive_dbg_data(uint64_t ingpa, uint64_t outgpa,
     }
 
     in_len = sizeof(*debug_data_in);
-    debug_data_in = cpu_physical_memory_map(ingpa, &in_len, 0);
+    debug_data_in = physical_memory_map(ingpa, &in_len, 0);
     if (!debug_data_in || in_len < sizeof(*debug_data_in)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
     }
 
     out_len = sizeof(*debug_data_out);
-    debug_data_out = cpu_physical_memory_map(outgpa, &out_len, 1);
+    debug_data_out = physical_memory_map(outgpa, &out_len, 1);
     if (!debug_data_out || out_len < sizeof(*debug_data_out)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
@@ -844,12 +845,12 @@ uint16_t hyperv_hcall_retreive_dbg_data(uint64_t ingpa, uint64_t outgpa,
         debug_data_in->count - msg.u.recv.retrieved_count;
 cleanup:
     if (debug_data_out) {
-        cpu_physical_memory_unmap(debug_data_out, sizeof(*debug_data_out), 1,
+        physical_memory_unmap(debug_data_out, sizeof(*debug_data_out), 1,
                                   out_len);
     }
 
     if (debug_data_in) {
-        cpu_physical_memory_unmap(debug_data_in, sizeof(*debug_data_in), 0,
+        physical_memory_unmap(debug_data_in, sizeof(*debug_data_in), 0,
                                   in_len);
     }
 
@@ -870,7 +871,7 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast)
     }
 
     in_len = sizeof(*post_data_in);
-    post_data_in = cpu_physical_memory_map(ingpa, &in_len, 0);
+    post_data_in = physical_memory_map(ingpa, &in_len, 0);
     if (!post_data_in || in_len < sizeof(*post_data_in)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
@@ -882,7 +883,7 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast)
     }
 
     out_len = sizeof(*post_data_out);
-    post_data_out = cpu_physical_memory_map(outgpa, &out_len, 1);
+    post_data_out = physical_memory_map(outgpa, &out_len, 1);
     if (!post_data_out || out_len < sizeof(*post_data_out)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
@@ -902,12 +903,12 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast)
                                          HV_STATUS_SUCCESS;
 cleanup:
     if (post_data_out) {
-        cpu_physical_memory_unmap(post_data_out,
+        physical_memory_unmap(post_data_out,
                                   sizeof(*post_data_out), 1, out_len);
     }
 
     if (post_data_in) {
-        cpu_physical_memory_unmap(post_data_in,
+        physical_memory_unmap(post_data_in,
                                   sizeof(*post_data_in), 0, in_len);
     }
 
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 10171b19e8f..e0057bb3990 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -20,6 +20,7 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/hyperv/hyperv-proto.h"
 #include "exec/cpu-common.h"
+#include "system/physmem.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "net/checksum.h"
@@ -62,10 +63,10 @@ static void set_pending_state(HvSynDbg *syndbg, bool has_pending)
     }
 
     out_len = 1;
-    out_data = cpu_physical_memory_map(syndbg->pending_page_gpa, &out_len, 1);
+    out_data = physical_memory_map(syndbg->pending_page_gpa, &out_len, 1);
     if (out_data) {
         *(uint8_t *)out_data = !!has_pending;
-        cpu_physical_memory_unmap(out_data, out_len, 1, out_len);
+        physical_memory_unmap(out_data, out_len, 1, out_len);
     }
 }
 
@@ -110,7 +111,7 @@ static uint16_t handle_send_msg(HvSynDbg *syndbg, uint64_t ingpa,
     int sent_count;
 
     data_len = count;
-    debug_data = cpu_physical_memory_map(ingpa, &data_len, 0);
+    debug_data = physical_memory_map(ingpa, &data_len, 0);
     if (!debug_data || data_len < count) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
@@ -135,7 +136,7 @@ static uint16_t handle_send_msg(HvSynDbg *syndbg, uint64_t ingpa,
     ret = HV_STATUS_SUCCESS;
 cleanup:
     if (debug_data) {
-        cpu_physical_memory_unmap(debug_data, count, 0, data_len);
+        physical_memory_unmap(debug_data, count, 0, data_len);
     }
 
     return ret;
@@ -224,7 +225,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
         out_len += UDP_PKT_HEADER_SIZE;
     }
     out_requested_len = out_len;
-    out_data = cpu_physical_memory_map(outgpa, &out_len, 1);
+    out_data = physical_memory_map(outgpa, &out_len, 1);
     ret = HV_STATUS_INSUFFICIENT_MEMORY;
     if (!out_data || out_len < out_requested_len) {
         goto cleanup_out_data;
@@ -243,7 +244,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
 
 cleanup_out_data:
     if (out_data) {
-        cpu_physical_memory_unmap(out_data, out_len, 1, out_len);
+        physical_memory_unmap(out_data, out_len, 1, out_len);
     }
     return ret;
 }
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index dcfce700052..c5259d1a764 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -21,6 +21,7 @@
 #include "hw/core/sysbus.h"
 #include "exec/cpu-common.h"
 #include "system/kvm.h"
+#include "system/physmem.h"
 #include "trace.h"
 
 enum {
@@ -750,7 +751,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
         return hyperv_set_event_flag(chan->notify_route, chan->id);
     }
 
-    int_map = cpu_physical_memory_map(addr, &len, 1);
+    int_map = physical_memory_map(addr, &len, 1);
     if (len != TARGET_PAGE_SIZE / 2) {
         res = -ENXIO;
         goto unmap;
@@ -764,7 +765,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
     }
 
 unmap:
-    cpu_physical_memory_unmap(int_map, len, 1, dirty);
+    physical_memory_unmap(int_map, len, 1, dirty);
     return res;
 }
 
@@ -2249,7 +2250,7 @@ static void vmbus_signal_event(EventNotifier *e)
 
     addr = vmbus->int_page_gpa + TARGET_PAGE_SIZE / 2;
     len = TARGET_PAGE_SIZE / 2;
-    int_map = cpu_physical_memory_map(addr, &len, 1);
+    int_map = physical_memory_map(addr, &len, 1);
     if (len != TARGET_PAGE_SIZE / 2) {
         goto unmap;
     }
@@ -2265,7 +2266,7 @@ static void vmbus_signal_event(EventNotifier *e)
     }
 
 unmap:
-    cpu_physical_memory_unmap(int_map, len, 1, is_dirty);
+    physical_memory_unmap(int_map, len, 1, is_dirty);
 }
 
 static void vmbus_dev_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 7d167c8b006..e3dad136d31 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -19,6 +19,7 @@
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "system/hw_accel.h"
+#include "system/physmem.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "hw/core/sysbus.h"
@@ -85,7 +86,7 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
     }
 
     kvmclock_struct_pa = env->system_time_msr & ~1ULL;
-    cpu_physical_memory_read(kvmclock_struct_pa, &time, sizeof(time));
+    physical_memory_read(kvmclock_struct_pa, &time, sizeof(time));
 
     assert(time.tsc_timestamp <= migration_tsc);
     delta = migration_tsc - time.tsc_timestamp;
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 781bf2a7fa5..8dd9188d96f 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -19,6 +19,7 @@
 #include "system/whpx.h"
 #include "system/runstate.h"
 #include "system/address-spaces.h"
+#include "system/physmem.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/boards.h"
@@ -138,13 +139,13 @@ static const TPRInstruction tpr_instr[] = {
 
 static void read_guest_rom_state(VAPICROMState *s)
 {
-    cpu_physical_memory_read(s->rom_state_paddr, &s->rom_state,
+    physical_memory_read(s->rom_state_paddr, &s->rom_state,
                              sizeof(GuestROMState));
 }
 
 static void write_guest_rom_state(VAPICROMState *s)
 {
-    cpu_physical_memory_write(s->rom_state_paddr, &s->rom_state,
+    physical_memory_write(s->rom_state_paddr, &s->rom_state,
                               sizeof(GuestROMState));
 }
 
@@ -327,14 +328,14 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
     for (pos = le32_to_cpu(s->rom_state.fixup_start);
          pos < le32_to_cpu(s->rom_state.fixup_end);
          pos += 4) {
-        cpu_physical_memory_read(paddr + pos - s->rom_state.vaddr,
+        physical_memory_read(paddr + pos - s->rom_state.vaddr,
                                  &offset, sizeof(offset));
         offset = le32_to_cpu(offset);
-        cpu_physical_memory_read(paddr + offset, &patch, sizeof(patch));
+        physical_memory_read(paddr + offset, &patch, sizeof(patch));
         patch = le32_to_cpu(patch);
         patch += rom_state_vaddr - le32_to_cpu(s->rom_state.vaddr);
         patch = cpu_to_le32(patch);
-        cpu_physical_memory_write(paddr + offset, &patch, sizeof(patch));
+        physical_memory_write(paddr + offset, &patch, sizeof(patch));
     }
     read_guest_rom_state(s);
     s->vapic_paddr = paddr + le32_to_cpu(s->rom_state.vapic_vaddr) -
@@ -378,7 +379,7 @@ static int vapic_enable(VAPICROMState *s, X86CPU *cpu)
     }
     vapic_paddr = s->vapic_paddr +
         (((hwaddr)cpu_number) << VAPIC_CPU_SHIFT);
-    cpu_physical_memory_write(vapic_paddr + offsetof(VAPICState, enabled),
+    physical_memory_write(vapic_paddr + offsetof(VAPICState, enabled),
                               &enabled, sizeof(enabled));
     apic_enable_vapic(cpu->apic_state, vapic_paddr);
 
@@ -549,7 +550,7 @@ static int patch_hypercalls(VAPICROMState *s)
     uint8_t *rom;
 
     rom = g_malloc(s->rom_size);
-    cpu_physical_memory_read(rom_paddr, rom, s->rom_size);
+    physical_memory_read(rom_paddr, rom, s->rom_size);
 
     for (pos = 0; pos < s->rom_size - sizeof(vmcall_pattern); pos++) {
         if (kvm_enabled() && kvm_irqchip_in_kernel()) {
@@ -565,7 +566,7 @@ static int patch_hypercalls(VAPICROMState *s)
         }
         if (memcmp(rom + pos, pattern, 7) == 0 &&
             (rom[pos + 7] == alternates[0] || rom[pos + 7] == alternates[1])) {
-            cpu_physical_memory_write(rom_paddr + pos + 5, patch, 3);
+            physical_memory_write(rom_paddr + pos + 5, patch, 3);
             /*
              * Don't flush the tb here. Under ordinary conditions, the patched
              * calls are miles away from the current IP. Under malicious
@@ -755,7 +756,7 @@ static void do_vapic_enable(CPUState *cs, run_on_cpu_data data)
     X86CPU *cpu = X86_CPU(cs);
 
     static const uint8_t enabled = 1;
-    cpu_physical_memory_write(s->vapic_paddr + offsetof(VAPICState, enabled),
+    physical_memory_write(s->vapic_paddr + offsetof(VAPICState, enabled),
                               &enabled, sizeof(enabled));
     apic_enable_vapic(cpu->apic_state, s->vapic_paddr);
     s->state = VAPIC_ACTIVE;
@@ -776,7 +777,7 @@ static void vapic_vm_state_change(void *opaque, bool running, RunState state)
             run_on_cpu(first_cpu, do_vapic_enable, RUN_ON_CPU_HOST_PTR(s));
         } else {
             zero = g_malloc0(s->rom_state.vapic_size);
-            cpu_physical_memory_write(s->vapic_paddr, zero,
+            physical_memory_write(s->vapic_paddr, zero,
                                       s->rom_state.vapic_size);
             g_free(zero);
         }
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 0e8932005fa..74e25c60a80 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -28,6 +28,7 @@
 #include "qemu/host-utils.h"
 #include "system/kvm.h"
 #include "system/mshv.h"
+#include "system/physmem.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "exec/cpu-common.h"
@@ -107,7 +108,7 @@ static void apic_sync_vapic(APICCommonState *s, int sync_type)
         return;
     }
     if (sync_type & SYNC_FROM_VAPIC) {
-        cpu_physical_memory_read(s->vapic_paddr, &vapic_state,
+        physical_memory_read(s->vapic_paddr, &vapic_state,
                                  sizeof(vapic_state));
         s->tpr = vapic_state.tpr;
     }
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index d353391208e..5def5a6b733 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -13,6 +13,7 @@
 #include "target/ppc/cpu.h"
 #include "system/cpus.h"
 #include "system/dma.h"
+#include "system/physmem.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
@@ -1170,7 +1171,7 @@ static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
         report_data[0] = (rd >> 8) & 0xff;
         report_data[1] = rd & 0xff;
     }
-    cpu_physical_memory_write(phys_addr, report_data, REPORT_LINE_GEN1_SIZE);
+    physical_memory_write(phys_addr, report_data, REPORT_LINE_GEN1_SIZE);
 }
 
 void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 4bfe5bcf569..9a0a57c0cc4 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -14,6 +14,7 @@
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
+#include "system/physmem.h"
 #include "system/system.h"
 #include "system/qtest.h"
 #include "hw/core/irq.h"
@@ -585,7 +586,7 @@ static void nextdma_write(void *opaque, uint8_t *buf, int size, int type)
         base_addr = next_state->dma[type].next_initbuf;
     }
 
-    cpu_physical_memory_write(base_addr, buf, size);
+    physical_memory_write(base_addr, buf, size);
 
     next_state->dma[type].next_initbuf = 0;
 
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index a93b68e1e48..c9c813d0d8b 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -32,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "system/device_tree.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "exec/cpu-common.h"
 #include "hw/core/boards.h"
@@ -106,7 +107,7 @@ static int microblaze_load_dtb(hwaddr addr,
                               initrd_end);
     }
 
-    cpu_physical_memory_write(addr, fdt, fdt_size);
+    physical_memory_write(addr, fdt, fdt_size);
     g_free(fdt);
     return fdt_size;
 }
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 228012e772f..7f2753320fa 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -40,6 +40,7 @@
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "exec/cpu-common.h"
+#include "system/physmem.h"
 #include "qom/object.h"
 
 #define IOMEM_LEN    0x10000
@@ -126,7 +127,7 @@ static void test_flush_page_write(void *opaque, hwaddr addr, uint64_t data,
                             unsigned len)
 {
     hwaddr page = 4096;
-    void *a = cpu_physical_memory_map(data & ~0xffful, &page, false);
+    void *a = physical_memory_map(data & ~0xffful, &page, false);
 
     /* We might not be able to get the full page, only mprotect what we actually
        have mapped */
@@ -134,7 +135,7 @@ static void test_flush_page_write(void *opaque, hwaddr addr, uint64_t data,
     mprotect(a, page, PROT_NONE);
     mprotect(a, page, PROT_READ|PROT_WRITE);
 #endif
-    cpu_physical_memory_unmap(a, page, 0, 0);
+    physical_memory_unmap(a, page, 0, 0);
 }
 
 static const MemoryRegionOps test_flush_ops = {
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 22660c32b84..6d2bf71b52f 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "etsec.h"
 #include "registers.h"
+#include "system/physmem.h"
 #include "exec/cpu-common.h"
 
 /* #define ETSEC_RING_DEBUG */
@@ -111,7 +112,7 @@ static void read_buffer_descriptor(eTSEC         *etsec,
     assert(bd != NULL);
 
     RING_DEBUG("READ Buffer Descriptor @ 0x" HWADDR_FMT_plx"\n", addr);
-    cpu_physical_memory_read(addr,
+    physical_memory_read(addr,
                              bd,
                              sizeof(eTSEC_rxtx_bd));
 
@@ -143,7 +144,7 @@ static void write_buffer_descriptor(eTSEC         *etsec,
     }
 
     RING_DEBUG("Write Buffer Descriptor @ 0x" HWADDR_FMT_plx"\n", addr);
-    cpu_physical_memory_write(addr,
+    physical_memory_write(addr,
                               bd,
                               sizeof(eTSEC_rxtx_bd));
 }
@@ -240,7 +241,7 @@ static void process_tx_bd(eTSEC         *etsec,
     etsec->tx_buffer = g_realloc(etsec->tx_buffer,
                                     etsec->tx_buffer_len + bd->length);
     tmp_buff = etsec->tx_buffer + etsec->tx_buffer_len;
-    cpu_physical_memory_read(bd->bufptr + tbdbth, tmp_buff, bd->length);
+    physical_memory_read(bd->bufptr + tbdbth, tmp_buff, bd->length);
 
     /* Update buffer length */
     etsec->tx_buffer_len += bd->length;
@@ -401,7 +402,7 @@ static void fill_rx_bd(eTSEC          *etsec,
     /* This operation will only write FCB */
     if (etsec->rx_fcb_size != 0) {
 
-        cpu_physical_memory_write(bufptr, etsec->rx_fcb, etsec->rx_fcb_size);
+        physical_memory_write(bufptr, etsec->rx_fcb, etsec->rx_fcb_size);
 
         bufptr             += etsec->rx_fcb_size;
         bd->length         += etsec->rx_fcb_size;
@@ -417,7 +418,7 @@ static void fill_rx_bd(eTSEC          *etsec,
 
     /* This operation can only write packet data and no padding */
     if (to_write > 0) {
-        cpu_physical_memory_write(bufptr, *buf, to_write);
+        physical_memory_write(bufptr, *buf, to_write);
 
         *buf   += to_write;
         bufptr += to_write;
@@ -439,7 +440,7 @@ static void fill_rx_bd(eTSEC          *etsec,
             etsec->rx_padding -= rem;
             *size             -= rem;
             bd->length        += rem;
-            cpu_physical_memory_write(bufptr, padd, rem);
+            physical_memory_write(bufptr, padd, rem);
         }
     }
 }
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 79a5c4385c6..9df359eae87 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "system/physmem.h"
 #include "hw/core/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
@@ -175,7 +176,7 @@ typedef struct {
 
 static void mcf_fec_read_bd(mcf_fec_bd *bd, uint32_t addr)
 {
-    cpu_physical_memory_read(addr, bd, sizeof(*bd));
+    physical_memory_read(addr, bd, sizeof(*bd));
     be16_to_cpus(&bd->flags);
     be16_to_cpus(&bd->length);
     be32_to_cpus(&bd->data);
@@ -187,7 +188,7 @@ static void mcf_fec_write_bd(mcf_fec_bd *bd, uint32_t addr)
     tmp.flags = cpu_to_be16(bd->flags);
     tmp.length = cpu_to_be16(bd->length);
     tmp.data = cpu_to_be32(bd->data);
-    cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
+    physical_memory_write(addr, &tmp, sizeof(tmp));
 }
 
 static void mcf_fec_update(mcf_fec_state *s)
@@ -260,7 +261,7 @@ static void mcf_fec_do_tx(mcf_fec_state *s)
             len = FEC_MAX_FRAME_SIZE - frame_size;
             s->eir |= FEC_INT_BABT;
         }
-        cpu_physical_memory_read(bd.data, ptr, len);
+        physical_memory_read(bd.data, ptr, len);
         ptr += len;
         frame_size += len;
         if (bd.flags & FEC_BD_L) {
@@ -596,10 +597,10 @@ static ssize_t mcf_fec_receive(NetClientState *nc, const uint8_t *buf, size_t si
         if (size < 4)
             buf_len += size - 4;
         buf_addr = bd.data;
-        cpu_physical_memory_write(buf_addr, buf, buf_len);
+        physical_memory_write(buf_addr, buf, buf_len);
         buf += buf_len;
         if (size < 4) {
-            cpu_physical_memory_write(buf_addr + buf_len, crc_ptr, 4 - size);
+            physical_memory_write(buf_addr + buf_len, crc_ptr, 4 - size);
             crc_ptr += 4 - size;
         }
         bd.flags &= ~FEC_BD_E;
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index a25f8eccff3..5a07bcde09d 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -32,6 +32,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/physmem.h"
 #include "hw/core/irq.h"
 #include "hw/net/mii.h"
 #include "hw/core/qdev-properties.h"
@@ -431,7 +432,7 @@ static ssize_t open_eth_receive(NetClientState *nc,
         }
 #endif
 
-        cpu_physical_memory_write(desc->buf_ptr, buf, copy_size);
+        physical_memory_write(desc->buf_ptr, buf, copy_size);
 
         if (GET_REGBIT(s, MODER, PAD) && copy_size < minfl) {
             if (minfl - copy_size > fcsl) {
@@ -443,7 +444,7 @@ static ssize_t open_eth_receive(NetClientState *nc,
                 size_t zero_sz = minfl - copy_size < sizeof(zero) ?
                     minfl - copy_size : sizeof(zero);
 
-                cpu_physical_memory_write(desc->buf_ptr + copy_size,
+                physical_memory_write(desc->buf_ptr + copy_size,
                         zero, zero_sz);
                 copy_size += zero_sz;
             }
@@ -453,7 +454,7 @@ static ssize_t open_eth_receive(NetClientState *nc,
          * Don't do it if the frame is cut at the MAXFL or padded with 4 or
          * more bytes to the MINFL.
          */
-        cpu_physical_memory_write(desc->buf_ptr + copy_size, zero, fcsl);
+        physical_memory_write(desc->buf_ptr + copy_size, zero, fcsl);
         copy_size += fcsl;
 
         SET_FIELD(desc->len_flags, RXD_LEN, copy_size);
@@ -509,7 +510,7 @@ static void open_eth_start_xmit(OpenEthState *s, desc *tx)
     if (len > tx_len) {
         len = tx_len;
     }
-    cpu_physical_memory_read(tx->buf_ptr, buf, len);
+    physical_memory_read(tx->buf_ptr, buf, len);
     if (tx_len > len) {
         memset(buf + len, 0, tx_len - len);
     }
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 3af7e6ecbec..b0f9fe8633f 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -30,6 +30,7 @@
 
 #include "system/block-backend.h"
 #include "system/device_tree.h"
+#include "system/physmem.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "migration/vmstate.h"
@@ -89,9 +90,9 @@ static void rtas_nvram_fetch(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     assert(nvram->buf);
 
-    membuf = cpu_physical_memory_map(buffer, &len, true);
+    membuf = physical_memory_map(buffer, &len, true);
     memcpy(membuf, nvram->buf + offset, len);
-    cpu_physical_memory_unmap(membuf, len, 1, len);
+    physical_memory_unmap(membuf, len, 1, len);
 
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     rtas_st(rets, 1, len);
@@ -127,7 +128,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return;
     }
 
-    membuf = cpu_physical_memory_map(buffer, &len, false);
+    membuf = physical_memory_map(buffer, &len, false);
 
     ret = 0;
     if (nvram->blk) {
@@ -137,7 +138,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
     assert(nvram->buf);
     memcpy(nvram->buf + offset, membuf, len);
 
-    cpu_physical_memory_unmap(membuf, len, 0, len);
+    physical_memory_unmap(membuf, len, 0, len);
 
     rtas_st(rets, 0, (ret < 0) ? RTAS_OUT_HW_ERROR : RTAS_OUT_SUCCESS);
     rtas_st(rets, 1, (ret < 0) ? 0 : len);
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 9fba5ca03a6..2e94e80b569 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -22,6 +22,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "exec/cpu-common.h"
 #include "system/block-backend.h"
+#include "system/physmem.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "kvm_ppc.h"
@@ -231,7 +232,7 @@ static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
     bd->bi_busfreq =    cpu_to_be32(BUS_FREQ_HZ);
     bd->bi_baudrate =   cpu_to_be32(115200);
 
-    cpu_physical_memory_write(addr, bd, sizeof(*bd));
+    physical_memory_write(addr, bd, sizeof(*bd));
 }
 
 static void amigaone_cpu_reset(void *opaque)
@@ -386,7 +387,7 @@ static void amigaone_init(MachineState *machine)
         size_t len = strlen(machine->kernel_cmdline);
 
         loadaddr = bi->bd_info + 1 * MiB;
-        cpu_physical_memory_write(loadaddr, machine->kernel_cmdline, len + 1);
+        physical_memory_write(loadaddr, machine->kernel_cmdline, len + 1);
         bi->cmdline_start = loadaddr;
         bi->cmdline_end = loadaddr + len + 1; /* including terminating '\0' */
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 5be2f2095f6..1876882a040 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -29,6 +29,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/pci/pci.h"
 #include "system/block-backend-io.h"
+#include "system/physmem.h"
 #include "system/system.h"
 #include "system/kvm.h"
 #include "system/reset.h"
@@ -661,7 +662,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
 
 done:
     if (!dry_run) {
-        cpu_physical_memory_write(addr, fdt, fdt_size);
+        physical_memory_write(addr, fdt, fdt_size);
 
         /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
         g_free(machine->fdt);
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index ac9fc5a6542..9d7e279123b 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -21,6 +21,7 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/core/qdev-properties.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/qtest.h"
@@ -314,22 +315,22 @@ static void pegasos_init(MachineState *machine)
 
 static void pegasos_superio_write(uint8_t addr, uint8_t val)
 {
-    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
-    cpu_physical_memory_write(0xfe0003f1, &val, 1);
+    physical_memory_write(0xfe0003f0, &addr, 1);
+    physical_memory_write(0xfe0003f1, &val, 1);
 }
 
 static void pegasos1_pci_config_write(PegasosMachineState *pm, int bus,
                                       uint32_t addr, uint32_t len, uint32_t val)
 {
     addr |= BIT(31);
-    cpu_physical_memory_write(0xfec00cf8, &addr, 4);
-    cpu_physical_memory_write(0xfee00cfc, &val, len);
+    physical_memory_write(0xfec00cf8, &addr, 4);
+    physical_memory_write(0xfee00cfc, &val, len);
 }
 
 static void pegasos1_chipset_reset(PegasosMachineState *pm)
 {
     uint8_t elcr = 0x2e;
-    cpu_physical_memory_write(0xfe0004d1, &elcr, sizeof(elcr));
+    physical_memory_write(0xfe0004d1, &elcr, sizeof(elcr));
 
     pegasos1_pci_config_write(pm, 0, PCI_COMMAND, 2, PCI_COMMAND_IO |
                               PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8df697da94c..62812f22f8c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -25,6 +25,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "system/physmem.h"
 #include "system/qtest.h"
 #include "system/system.h"
 #include "system/numa.h"
@@ -843,11 +844,11 @@ static void pnv_reset(MachineState *machine, ResetType type)
             .thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState)),
         };
 
-        cpu_physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
+        physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
                 sizeof(proc_area));
     }
 
-    cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
+    physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
     /* Free previous device tree set by pnv_init/reset/machine_init_done */
     g_free(machine->fdt);
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 634046506e8..016c756c19e 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -18,6 +18,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "exec/cpu-common.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "target/ppc/cpu.h"
 #include "ppc440.h"
@@ -606,9 +607,9 @@ static void dcr_write_dma(void *opaque, int dcrn, uint32_t val)
                     width = 1 << ((val & DMA0_CR_PW) >> 25);
                     xferlen = count * width;
                     wlen = rlen = xferlen;
-                    rptr = cpu_physical_memory_map(dma->ch[chnl].sa, &rlen,
+                    rptr = physical_memory_map(dma->ch[chnl].sa, &rlen,
                                                    false);
-                    wptr = cpu_physical_memory_map(dma->ch[chnl].da, &wlen,
+                    wptr = physical_memory_map(dma->ch[chnl].da, &wlen,
                                                    true);
                     if (rptr && rlen == xferlen && wptr && wlen == xferlen) {
                         if (!(val & DMA0_CR_DEC) &&
@@ -631,10 +632,10 @@ static void dcr_write_dma(void *opaque, int dcrn, uint32_t val)
                         }
                     }
                     if (wptr) {
-                        cpu_physical_memory_unmap(wptr, wlen, 1, didx);
+                        physical_memory_unmap(wptr, wlen, 1, didx);
                     }
                     if (rptr) {
-                        cpu_physical_memory_unmap(rptr, rlen, 0, sidx);
+                        physical_memory_unmap(rptr, rlen, 0, sidx);
                     }
                 }
             }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f0e99bb5be7..b79828b4e90 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -38,6 +38,7 @@
 #include "system/system.h"
 #include "system/hostmem.h"
 #include "system/numa.h"
+#include "system/physmem.h"
 #include "system/tcg.h"
 #include "system/qtest.h"
 #include "system/reset.h"
@@ -1858,7 +1859,7 @@ static void spapr_machine_reset(MachineState *machine, ResetType type)
 
         spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
                                   0, fdt_addr, 0);
-        cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
+        physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
     }
 
     g_free(spapr->fdt_blob);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 9bc65c760ea..5c2150b71c8 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -25,6 +25,7 @@
 #include "hw/ppc/spapr_nvdimm.h"
 #include "exec/cpu-common.h"
 #include "system/device_tree.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "trace.h"
 
@@ -1150,7 +1151,7 @@ out:
 static void configure_connector_st(target_ulong addr, target_ulong offset,
                                    const void *buf, size_t len)
 {
-    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
+    physical_memory_write(ppc64_phys_to_real(addr + offset),
                               buf, MIN(len, CC_WA_LEN - offset));
 }
 
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ab23e3f477b..eb4d360122a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "system/device_tree.h"
+#include "system/physmem.h"
 #include "system/runstate.h"
 
 #include "hw/ppc/fdt.h"
@@ -855,9 +856,9 @@ static void spapr_mce_dispatch_elog(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
     stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
                 env->gpr[3]);
-    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
+    physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
                               sizeof(env->gpr[3]), &log, sizeof(log));
-    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
+    physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
                               sizeof(env->gpr[3]) + sizeof(log), ext_elog,
                               sizeof(*ext_elog));
     g_free(ext_elog);
@@ -964,8 +965,8 @@ static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     header.summary = cpu_to_be32(event->summary);
     header.extended_length = cpu_to_be32(event->extended_length);
-    cpu_physical_memory_write(buf, &header, sizeof(header));
-    cpu_physical_memory_write(buf + sizeof(header), event->extended_log,
+    physical_memory_write(buf, &header, sizeof(header));
+    physical_memory_write(buf + sizeof(header), event->extended_log,
                               event->extended_length);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     g_free(event->extended_log);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 60ba215e861..23bcd788daf 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -2,6 +2,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "system/hw_accel.h"
+#include "system/physmem.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "qemu/log.h"
@@ -273,7 +274,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!is_ram_address(spapr, dst) || (dst & ~TARGET_PAGE_MASK) != 0) {
         return H_PARAMETER;
     }
-    pdst = cpu_physical_memory_map(dst, &len, true);
+    pdst = physical_memory_map(dst, &len, true);
     if (!pdst || len != TARGET_PAGE_SIZE) {
         return H_PARAMETER;
     }
@@ -284,13 +285,13 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
             ret = H_PARAMETER;
             goto unmap_out;
         }
-        psrc = cpu_physical_memory_map(src, &len, false);
+        psrc = physical_memory_map(src, &len, false);
         if (!psrc || len != TARGET_PAGE_SIZE) {
             ret = H_PARAMETER;
             goto unmap_out;
         }
         memcpy(pdst, psrc, len);
-        cpu_physical_memory_unmap(psrc, len, 0, len);
+        physical_memory_unmap(psrc, len, 0, len);
     } else if (flags & H_ZERO_PAGE) {
         memset(pdst, 0, len);          /* Just clear the destination page */
     }
@@ -309,7 +310,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
 unmap_out:
-    cpu_physical_memory_unmap(pdst, TARGET_PAGE_SIZE, 1, len);
+    physical_memory_unmap(pdst, TARGET_PAGE_SIZE, 1, len);
     return ret;
 }
 
@@ -1382,8 +1383,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
         spapr->fdt_initial_size = spapr->fdt_size;
 
-        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
-        cpu_physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
+        physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
+        physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
                                   spapr->fdt_size);
         trace_spapr_cas_continue(spapr->fdt_size + sizeof(hdr));
     }
@@ -1487,7 +1488,7 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     unsigned cb;
     void *fdt;
 
-    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
+    physical_memory_read(dt, &hdr, sizeof(hdr));
     cb = fdt32_to_cpu(hdr.totalsize);
 
     /* Check that the fdt did not grow out of proportion */
@@ -1498,7 +1499,7 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     fdt = g_malloc0(cb);
-    cpu_physical_memory_read(dt, fdt, cb);
+    physical_memory_read(dt, fdt, cb);
 
     /* Check the fdt consistency */
     if (fdt_check_full(fdt, cb)) {
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0871425237e..328fc27c400 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -32,6 +32,7 @@
 #include "system/device_tree.h"
 #include "system/cpus.h"
 #include "system/hw_accel.h"
+#include "system/physmem.h"
 #include "system/runstate.h"
 #include "system/qtest.h"
 #include "kvm_ppc.h"
@@ -279,7 +280,7 @@ static inline int sysparm_st(target_ulong addr, target_ulong len,
         return RTAS_OUT_SYSPARM_PARAM_ERROR;
     }
     stw_be_phys(&address_space_memory, phys, vallen);
-    cpu_physical_memory_write(phys + 2, val, MIN(len - 2, vallen));
+    physical_memory_write(phys + 2, val, MIN(len - 2, vallen));
     return RTAS_OUT_SUCCESS;
 }
 
@@ -441,7 +442,7 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
         return trigger_fadump_boot(spapr, rets);
     }
 
-    cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
+    physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
     msg[sizeof(msg) - 1] = 0;
 
     error_report("OS terminated: %s", msg);
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 361a3dc817d..19889e80bc1 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "hw/ppc/spapr.h"
 #include "hw/core/qdev-properties.h"
@@ -69,7 +70,7 @@ static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
         }
     }
 
-    cpu_physical_memory_read(data_in, buf_in, data_in_size);
+    physical_memory_read(data_in, buf_in, data_in_size);
 
     do {
         ret = write(tpm_proxy->host_fd, buf_in, data_in_size);
@@ -94,7 +95,7 @@ static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
         return H_RESOURCE;
     }
 
-    cpu_physical_memory_write(data_out, buf_out, ret);
+    physical_memory_write(data_out, buf_out, ret);
     args[0] = ret;
 
     return H_SUCCESS;
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index d10d9135890..09686360e16 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/block/flash.h"
+#include "system/physmem.h"
 #include "system/system.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
@@ -174,7 +175,7 @@ static int xilinx_load_device_tree(MachineState *machine,
                                 machine->kernel_cmdline);
     if (r < 0)
         fprintf(stderr, "couldn't set /chosen/bootargs\n");
-    cpu_physical_memory_write(addr, fdt, fdt_size);
+    physical_memory_write(addr, fdt, fdt_size);
 
     /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
     machine->fdt = fdt;
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index ecd28fed5c3..96d5378f3c1 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -15,6 +15,7 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
+#include "system/physmem.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/css.h"
@@ -755,13 +756,13 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
     CCW1 ret;
 
     if (fmt1) {
-        cpu_physical_memory_read(addr, &tmp1, sizeof(tmp1));
+        physical_memory_read(addr, &tmp1, sizeof(tmp1));
         ret.cmd_code = tmp1.cmd_code;
         ret.flags = tmp1.flags;
         ret.count = be16_to_cpu(tmp1.count);
         ret.cda = be32_to_cpu(tmp1.cda);
     } else {
-        cpu_physical_memory_read(addr, &tmp0, sizeof(tmp0));
+        physical_memory_read(addr, &tmp0, sizeof(tmp0));
         if ((tmp0.cmd_code & 0x0f) == CCW_CMD_TIC) {
             ret.cmd_code = CCW_CMD_TIC;
             ret.flags = 0;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 1babcd2b7dd..fa50749a7d3 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
@@ -431,7 +432,7 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
     uint64_t len = sizeof(IplParameterBlock) * count;
     uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
 
-    cpu_physical_memory_write(chain_addr, iplb_chain, len);
+    physical_memory_write(chain_addr, iplb_chain, len);
     return chain_addr;
 }
 
@@ -722,13 +723,13 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     uint8_t *addr;
     uint64_t len = 4096;
 
-    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
+    addr = physical_memory_map(cpu->env.psa, &len, true);
     if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
         error_report("Cannot set QEMU IPL parameters");
         return;
     }
     memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
-    cpu_physical_memory_unmap(addr, len, 1, len);
+    physical_memory_unmap(addr, len, 1, len);
 }
 
 int s390_ipl_prepare_pv_header(struct S390PVResponse *pv_resp, Error **errp)
@@ -738,7 +739,7 @@ int s390_ipl_prepare_pv_header(struct S390PVResponse *pv_resp, Error **errp)
     void *hdr = g_malloc(ipib_pv->pv_header_len);
     int rc;
 
-    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
+    physical_memory_read(ipib_pv->pv_header_addr, hdr,
                              ipib_pv->pv_header_len);
     rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len,
                                pv_resp, errp);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eb2b6185db0..eff980fdfe9 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -28,6 +28,7 @@
 #include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 
@@ -668,7 +669,7 @@ static bool set_ind_bit_atomic(uint64_t ind_loc, uint8_t to_be_set)
     /* avoid  multiple fetches */
     uint8_t volatile *ind_addr;
 
-    ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
+    ind_addr = physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
         return false;
@@ -678,7 +679,7 @@ static bool set_ind_bit_atomic(uint64_t ind_loc, uint8_t to_be_set)
         expected = actual;
         actual = qatomic_cmpxchg(ind_addr, expected, expected | to_be_set);
     } while (actual != expected);
-    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
+    physical_memory_unmap((void *)ind_addr, len, 1, len);
 
     return (actual & to_be_set) ? false : true;
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index ba55bf4fe97..80e00edce0d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/kvm.h"
+#include "system/physmem.h"
 #include "net/net.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
@@ -834,7 +835,7 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
     /* avoid  multiple fetches */
     uint8_t volatile *ind_addr;
 
-    ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
+    ind_addr = physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         error_report("%s(%x.%x.%04x): unable to access indicator",
                      __func__, sch->cssid, sch->ssid, sch->schid);
@@ -846,7 +847,7 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
         actual = qatomic_cmpxchg(ind_addr, expected, expected | to_be_set);
     } while (actual != expected);
     trace_virtio_ccw_set_ind(ind_loc, actual, actual | to_be_set);
-    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
+    physical_memory_unmap((void *)ind_addr, len, 1, len);
 
     return actual;
 }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 11ae6b9b747..4398aa54990 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -34,7 +34,7 @@
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
-#include "exec/cpu-common.h"
+#include "system/physmem.h"
 #include "vmw_pvscsi.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -395,7 +395,7 @@ pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
 
     cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
     trace_pvscsi_cmp_ring_put(cmp_descr_pa);
-    cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
+    physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
 }
 
 static void
@@ -405,7 +405,7 @@ pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMsgDesc *msg_desc)
 
     msg_descr_pa = pvscsi_ring_pop_msg_descr(&s->rings);
     trace_pvscsi_msg_ring_put(msg_descr_pa);
-    cpu_physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
+    physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
 }
 
 static void
@@ -480,7 +480,7 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
 {
     struct PVSCSISGElement elem;
 
-    cpu_physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
+    physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
     if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) != 0) {
         /*
             * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
@@ -501,7 +501,7 @@ pvscsi_write_sense(PVSCSIRequest *r, uint8_t *sense, int len)
 {
     r->cmp.senseLen = MIN(r->req.senseLen, len);
     r->sense_key = sense[(sense[0] & 2) ? 1 : 2];
-    cpu_physical_memory_write(r->req.senseAddr, sense, r->cmp.senseLen);
+    physical_memory_write(r->req.senseAddr, sense, r->cmp.senseLen);
 }
 
 static void
@@ -758,7 +758,7 @@ pvscsi_process_io(PVSCSIState *s)
         smp_rmb();
 
         trace_pvscsi_process_io(next_descr_pa);
-        cpu_physical_memory_read(next_descr_pa, &descr, sizeof(descr));
+        physical_memory_read(next_descr_pa, &descr, sizeof(descr));
         pvscsi_process_request_descriptor(s, &descr);
     }
 
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 445f33e1726..7df93445002 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -5,8 +5,8 @@
 #include "qapi/error.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
-#include "exec/cpu-common.h"
 #include "xen-host-pci-device.h"
+#include "system/physmem.h"
 
 static unsigned long igd_guest_opregion;
 static unsigned long igd_host_opregion;
@@ -223,7 +223,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
     }
 
     /* Currently we fixed this address as a primary for legacy BIOS. */
-    cpu_physical_memory_write(0xc0000, bios, bios_size);
+    physical_memory_write(0xc0000, bios, bios_size);
 }
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 33a2d9485cf..8f85fc8ddb4 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties.h"
 #include "elf.h"
 #include "system/memory.h"
+#include "system/physmem.h"
 #include "exec/tswap.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
@@ -370,7 +371,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 exit(EXIT_FAILURE);
             }
 
-            cpu_physical_memory_write(cur_lowmem, fdt, fdt_size);
+            physical_memory_write(cur_lowmem, fdt, fdt_size);
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_FDT,
                                  sizeof(dtb_addr), &dtb_addr);
             cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
@@ -449,7 +450,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
             memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
             memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
-            cpu_physical_memory_write(env->pc, boot, boot_sz);
+            physical_memory_write(env->pc, boot, boot_sz);
         }
     } else {
         if (flash) {
diff --git a/system/cpus.c b/system/cpus.c
index bded87feb1c..73baa75e846 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -40,6 +40,7 @@
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "hw/core/nmi.h"
+#include "system/physmem.h"
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "system/cpu-timers.h"
@@ -897,7 +898,7 @@ void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
         l = sizeof(buf);
         if (l > size)
             l = size;
-        cpu_physical_memory_read(addr, buf, l);
+        physical_memory_read(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
             error_setg(errp, "writing memory to '%s' failed",
                        filename);
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf875736..637bd9f4f6d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3476,13 +3476,13 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
+void physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
     address_space_read(&address_space_memory, addr,
                        MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
-void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
+void physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 {
     address_space_write(&address_space_memory, addr,
                         MEMTXATTRS_UNSPECIFIED, buf, len);
@@ -3806,16 +3806,14 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
     address_space_notify_map_clients(as);
 }
 
-void *cpu_physical_memory_map(hwaddr addr,
-                              hwaddr *plen,
-                              bool is_write)
+void *physical_memory_map(hwaddr addr, hwaddr *plen, bool is_write)
 {
     return address_space_map(&address_space_memory, addr, plen, is_write,
                              MEMTXATTRS_UNSPECIFIED);
 }
 
-void cpu_physical_memory_unmap(void *buffer, hwaddr len,
-                               bool is_write, hwaddr access_len)
+void physical_memory_unmap(void *buffer, hwaddr len,
+                           bool is_write, hwaddr access_len)
 {
     return address_space_unmap(&address_space_memory, buffer, len, is_write, access_len);
 }
-- 
2.53.0


