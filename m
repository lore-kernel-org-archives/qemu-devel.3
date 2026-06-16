Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59242CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVrl-0005Hg-At; Tue, 16 Jun 2026 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVrk-0005GG-89
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:38:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVri-00066y-Gz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:38:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxaZt1934810
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0XprbqCatfhco4yfrQkeZDGGB8J/+T3og9nNuB+zmJs=; b=PJjtHOVnOB1EHHqS
 Rfzg0rSdC3zr1O9jTl/lP/xdh4FohF7s9ZrywugxqAzGcH+XMKji1quHZojHsjKg
 jipCCGixtA/IdzSJEfiOsbbJdusY5TP7JdJQf5W0bKpC3blgmD/U4y6Nu90FnTty
 AZKNT7qNxHad26L2Rskk9o1XGunLLWDwe1Oe/ceRTvLaI1wOXHisKKSJ5ys/le1M
 pnlVLnGuIMQd4kbfHN6YBWFTLEfS5A1G+joy68iZuIstQoQgQm8Hlj3ZuaI8fBhy
 NvUpzW3M5KY+hEZHV1yfPEJj38TDDU3xCu5LOeac/1w2/I2FCXYUu1BxU/heRup9
 MO/0lQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu3ct1swn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:38:12 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-964aa12039dso4983463241.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624292; x=1782229092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XprbqCatfhco4yfrQkeZDGGB8J/+T3og9nNuB+zmJs=;
 b=kDcILlbTFYU/lTX8sEZ1Nbst0EDyLISSZPDWj7yGQ8ryTB7TtePpHrxwMqlMCt4p0o
 xHf/q2FYv/Hko/Cwvz3xUEQZdJsFH0vjSIn6gmTa+wG3T80r1GDHXtxGNdVeZchjDGmf
 /+v+Icdo9BpJhExdW07OFCA9iJEdiFetVgfDp4ZMvkf1SpVpy4zykUderOyGo85rgBrO
 tSp6pzU17hZ05N7pWbXalsZSN9mD/Hx69AJ4yZRIqI5/YM4RKKsaLCsrdiQb+gUqU2fX
 lxYXQayDIIA1bvqJwpwiCrJzBceYv+GqHGYgJIWVEGcoU/M1C+vICJDS5tqVRtflR5AU
 +KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624292; x=1782229092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0XprbqCatfhco4yfrQkeZDGGB8J/+T3og9nNuB+zmJs=;
 b=LTTNcFN3J3dKTuj45nwhsaOM2umXTPfruRRlj4tVbyyxcDSK9nCNPIwe+GborbbWLU
 TsTYrMr+Y2kTyoqGNmEOMfUeRsQiaN5Zf3QbGFfYmNKPnQg8mgiCuzbwflfe3ItL9L2v
 8eydw05gYRquEG6etxgBhwibQwNrvS5dzdiry6jvo5luNeGn323eiUIxQLIvDtveq+Tu
 C+yf2EGmaLUMnnKL03YxoHa8EDVU18n9f8D2w/G5wQIGIOcoBBwlwjw+iCAoR2kmICMt
 KQwA1PPYAM7Ac2w4g4EpHoao0qjzigCquq6hbwDg7x2kx8xFAYwZzmXwmiDJc6685MGa
 5IyQ==
X-Gm-Message-State: AOJu0Yyt/sxJqaZIF/vxBemsqO4nX6SxekGChXfxuQSia+jKPHos246w
 12m/Qz8YL5AqMDb+7eGPIbVR4AtT5E5NI18mkAzxe5DpX58TZ1DWbSfxJdnNoQD57J2rBXNksTX
 1G80m6z/Sx+uWiHEn2HZ0VIFk4il7ANYnM5CZAEa+5BFHjmq08dELSSCaFRrWe6QqBQ==
X-Gm-Gg: Acq92OHRyS/oHLKXJCaJyujkHGL/fd/RkBLeqV2vchTPi4+1mAXzp0RHAOCRXWRWNiR
 RM8nO8/QkM9cx4xM3cRQSRHM+n7TVn25YgPG1xmAX8BIgg7fm4P4rjsGBKzq8E8CslTqETgd0Uw
 3vK+/K+TP49GM03T5k6L1qR+XjbJ8AJRISSdzYCWY6T+sakh2+/YfpGi1PDEw9IsJ9GupLJZupf
 3b924Z2y3gTwnDkEAfSkvUG9P7ESedA2iZyBnFREJgFXceb4dYt4kHOzKtedPkhiTgNtelEs4+z
 NQmmiTuyrkpVkRppYl0r6usfGGlzgaZaXEk13BeofAmPp95GbBr1pdUnPH5Nd7cSxrxE6KY1Rxi
 ClLFJbHzg1Mr9f6d0d5ocp5yiEEDQrptJCaPYS8rfIjlI3h9xxhyZl26941n4EncwSJpdC9wTFg
 Hsfds=
X-Received: by 2002:a05:6102:a53:b0:631:41f9:ffa2 with SMTP id
 ada2fe7eead31-722dacb12b6mr2519706137.29.1781624291699; 
 Tue, 16 Jun 2026 08:38:11 -0700 (PDT)
X-Received: by 2002:a05:6102:a53:b0:631:41f9:ffa2 with SMTP id
 ada2fe7eead31-722dacb12b6mr2519689137.29.1781624291245; 
 Tue, 16 Jun 2026 08:38:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3basm43081882f8f.12.2026.06.16.08.38.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:38:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 2/2] system/memory: Rename cpu_exec_init_all() ->
 machine_memory_init()
Date: Tue, 16 Jun 2026 17:37:54 +0200
Message-ID: <20260616153754.93545-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153754.93545-1-philmd@oss.qualcomm.com>
References: <20260616153754.93545-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a316de4 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4N88G4Qxp0CkUPUmdhAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: I22wKpnyBHTPEIvKwX8TuxB8vcfRsLP5
X-Proofpoint-ORIG-GUID: I22wKpnyBHTPEIvKwX8TuxB8vcfRsLP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX2N2Y23t8rN/6
 U6I3bz0wn6y9wchMrCKKoZvFTCBb5nL+9UGML3aSfsB9TsrXo2mQjYZTn0aq9G6n1dcLXKHqQL1
 BOO5Q0uZNwZfNloYTurcsPoh5LHtRc1tndG2PBo7j/Q5gf+PnzO3gDVYZF5EnaHKNWRJmmzY/0e
 JzTZ2FMEMvlwqXoNv4pgPxeouIBrFm853jFYY4f7oQimGULt9D+ePLSUu08QCfFJPAo4aTQLxB7
 AW/iRiQA+t7HxfgjObqreosVYj+5MCiniqD6UO/lCsXrHw2VPUdUJP43cKkvrBpxykU+pSj7REe
 C3qLxTMwl2ZyNI7r7+7l+pNvMvlXh1N4nbSfClfXhxoo37NNsVZr4EGObkuHpe1oA6Kk5QnrN5r
 4NLNw5F8QS6Brqz39xcutCuSt26i3IatmAH510+kutwUT9SRVRp134V7RCUYonDSSSq1RJmHzBV
 2jDdrt0LoQU+3xSSRYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX+OJyeKJqJMz9
 zGQQlJbAv7XDohj7sy5h/tD/eva7xphLv2tzV5MwvHKSPw26i1u/oslTZWDWK+OU7rmeKX+gdWz
 ENZpYm3iq4W4YzIX9fQHHpqoyeopqg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

cpu_exec_init_all() is system specific: it initializes globals
for the memory subsystem. Rename it as machine_memory_init()
and restrict its declaration to 'system/' namespace.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 1 -
 system/memory-internal.h  | 2 ++
 system/physmem.c          | 2 +-
 system/vl.c               | 3 ++-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6fe821b9a1d..883389b0abf 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -21,7 +21,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
diff --git a/system/memory-internal.h b/system/memory-internal.h
index c7573a68b5e..b2b9b5b0c5e 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -14,6 +14,8 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
+void machine_memory_init(void);
+
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
diff --git a/system/physmem.c b/system/physmem.c
index f91230eac42..5fc9f89607e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3600,7 +3600,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
     }
 }
 
-void cpu_exec_init_all(void)
+void machine_memory_init(void)
 {
     qemu_mutex_init(&ram_list.mutex);
     /* The data structures we set up here depend on knowing the page size,
diff --git a/system/vl.c b/system/vl.c
index dbdd4f22572..1c0da7df293 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -143,6 +143,7 @@
 #include "system/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
+#include "memory-internal.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -2217,7 +2218,7 @@ static void qemu_create_machine(QDict *qdict)
         }
     }
 
-    cpu_exec_init_all();
+    machine_memory_init();
 
     /*
      * Get the default machine options from the machine if it is not already
-- 
2.53.0


