Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE8DC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegaC-0007Rj-UL; Tue, 30 Jun 2026 18:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegY7-0003Y9-BC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegY4-00045W-Gj
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDdmK2920073
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0S5PYbuGLEoeTum/9hNHbmqOND4X4rpTeIikmvtXeY=; b=Fi9G2opCj14StcVv
 fHGtxanLPSvMP9t+qVIjDSpr/kCZq16BwgDKmj7JU0WuD+ern+v3fbbNgwhRo4xV
 WwHzf6MJAq0rlbs+6j6A+x90fhrFvh6jVkphXpxXvh2AAMsdaElY0LDpigYaVAzz
 EQ5qbM7TBeqCSdNkKivyqK7dd70olJaBRlf9MbJCVjKXjz2CYqUUz0UDQeVIzXWO
 5Fjp/fyhM+tfn8QsSMg8scws1yA+K7LF8ijBHD4UNat8Kb9MsaUHmxUHNex9sbeA
 n28PEWkhgP0MTw3wYRbWZQfv/YjV3RbIlPEchMQABKlmtsBupYThZsiImawCp2Dc
 PV+IEA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8ufm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:05 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bd797e447cso5841455e0c.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856985; x=1783461785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0S5PYbuGLEoeTum/9hNHbmqOND4X4rpTeIikmvtXeY=;
 b=CNEuo3dtMmJptHvBwawmndMarMHEo304OB9N8Mu7rTiXeAQPnJ6jUPQZ9lv2HnQgod
 Lhrw6ejkpuiYfNQ9yEqHYo0XffrhwL7vUd5MirHTBSyoD21TxuFaSMnf8euE1NPIIDbB
 F81dK0e4goHjSnnttsuwb/B3o3tAWDVxupF0hko/EHh4Q4y4qZPWwbUOPKYHIJT1JoNB
 pYmco//FpG+1IlbcpeIkuePqR+VlP8yUK6aDIwuaZRhKYTonpJcAQHAQ2cwIPQ5TvdVD
 a+GGAIBqPU2kAnl1TSN1N2yzaoIjmj5r/yNbZSx5rwRzea064Mi62SLz/B7bD8Sjy7JU
 cSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856985; x=1783461785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V0S5PYbuGLEoeTum/9hNHbmqOND4X4rpTeIikmvtXeY=;
 b=gUb7GEGhDQSZGrHa/v660WmY1bWtDujDD/jKY9gD4J48Jv6LQM6scllpTRGgIgzU92
 xHi0rnyuqdIXZfaX5HQs3hnB2qa6xTV8BJRVTvx9mFZkhzggTt39REV7GA3TEQNCZsKv
 kr8ud7iQF68VBDaMiH5kwbB9G5KkZiQnoZt1vQttJ8AtNNWOT3VCjCUNHn5xq0ojwHW6
 jUTkCEscUCsBpMyP+Vh7sn6gZfRJQ0A6GmyZSebY8TlnJDUuBYDs3RNPNiSYT1rzqdad
 /5XTDF0gn6rD3V++Kx7fhkeGyO+Mks3D+eYcfquJ+zQhSmkIpZ59teKwbJi5pFYvKT2t
 YKqQ==
X-Gm-Message-State: AOJu0YwiA5o+ny6BFGhpYPSOrrghDNyx/ScKBa4SyL9xqCxAW7HVD9ao
 /yp+lHsn7FweMur8zitaeKYc0XrekOWgiL7FWxDXr2vL6q1Wt61hpLHnFZ5UT8wG1Syv2YlsyLN
 Yr3xEV2D48WfN9f03av73UMx5Gox6IsM5Bi25kCz9e+w9l//50e/xg1wG0tXgdSJfrw==
X-Gm-Gg: AfdE7cnhb8BAZPEv+gXVbg6NOUQQz922RKnAJubUbuZbQMAMqI/lIvSCZS5sQt+C/xP
 z12tT6DJxIr2fygxOmFR48/2lzlxKlns3DA0hlg24RDn3MjQkFKAgoaPkBb6vVLkgVDevi3SC+E
 2K7ndPssaUrA994Fkh+BTlUHi317hR0/sLLXzPZzSPo9AN67iEGgCwFWGByLYK44fFBwBM/ra1V
 +MLjrmQBiDA6U57kcfDrYPvUcfTi611KYP86b10lTPCTh00EzD28Ky3Xc+32lVeKAJ7VIEjlxoJ
 EMWrFcUOovyCDEs3VZZtara8kgvXB542s68g77pl6wArage3Bv1y8XBd2coOlMqZT+j2LrDzfF2
 L3fT5jBugMBB9ws37HKXyX6a491ZIS8DNaFXjSiYY+5rLbhbn5Mvm5ujcC/1xn0SHcOAt
X-Received: by 2002:a05:6122:6161:b0:59e:f727:4bb4 with SMTP id
 71dfb90a1353d-5bdbebd1b66mr2662310e0c.1.1782856985080; 
 Tue, 30 Jun 2026 15:03:05 -0700 (PDT)
X-Received: by 2002:a05:6122:6161:b0:59e:f727:4bb4 with SMTP id
 71dfb90a1353d-5bdbebd1b66mr2662274e0c.1.1782856984628; 
 Tue, 30 Jun 2026 15:03:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4c7f90sm24212925e9.2.2026.06.30.15.03.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:03:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 16/33] accel/kvm: Hold gdbstub_sstep_flags in KVMState
Date: Wed,  1 Jul 2026 00:00:43 +0200
Message-ID: <20260630220100.1289-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U2CHxaVRZNvulAL3N4dEBvuG8cofMbw-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX7GSm/+lQaQBP
 aS8N1e0WEC0SZe7KtXmWJEEnZavBzQv47JrfVUS1HEM6FUFSfLTophSAtR9Rw+rZVquEI4J4o1L
 7dmc/LBrDl1fdMn1Pdncgxer/Lockns=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a443d19 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=SyX2bNzGUzkgapdpcZcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: U2CHxaVRZNvulAL3N4dEBvuG8cofMbw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX0pkVD9WXC4da
 1hponIkLB5Jj90/cFYYlGYNb566z5tGb65XnANZwFy3+Bc0HdsBxapWHgZfexYRzuTzqI87yu5O
 Cke2xpg7ZgpnARfYKwRQVbg+uPs/lY4AB+xZs4raZPbijZx62rqHSkufANfFFnM+V8mNKMiXjSi
 4aWlO0Gqq9VmhKqZbZh5r+qOmj7jDzsTTcbKu/eHze1n3UgzGauNWX4dQctxBZEt/BAGCAJ9IAq
 fswqnCgfHESiPLHOLs2tJ2rkwN18YQD+nAc46Xbt8z5m3PTrG2NIOW7aOBh7JS5JXh6y6Vh/yiT
 M+Q6SbPRGLmY5XE2RZkLZ3lJCVPGim0fWKSC4euoHkwGHD7m9rlpLvlaJ3SvzHQGW5beVyxCva0
 1n2FgKc9mGsCe8z2CKYo5KInhorS1u1eZmNCIVo/JQj3+kbxglIkGtB9LkDzD/Gvvkx2cx3c4lo
 GVsVNgSVLU5fpyM5neQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prefer to store per-accelerator variables in the per-accelerator
state, rather than as static variables. This is a good practice
to allow concurrent accelerators in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/kvm_int.h | 1 +
 accel/kvm/kvm-all.c      | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 49e90cc0235..062759eaa01 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -114,6 +114,7 @@ struct KVMState
     bool coalesced_flush_in_progress;
     int vcpu_events;
     bool have_guest_supported;
+    int gdbstub_sstep_flags;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 80d8ef1a974..76c9ae6d4d4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
-static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
@@ -3036,20 +3035,20 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-    kvm_sstep_flags = 0;
+    s->gdbstub_sstep_flags = 0;
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     s->have_guest_supported =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 
     if (s->have_guest_supported) {
-        kvm_sstep_flags = SSTEP_ENABLE;
+        s->gdbstub_sstep_flags = SSTEP_ENABLE;
 
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
-            kvm_sstep_flags |= SSTEP_NOIRQ;
+            s->gdbstub_sstep_flags |= SSTEP_NOIRQ;
         }
     }
 #endif
-- 
2.53.0


