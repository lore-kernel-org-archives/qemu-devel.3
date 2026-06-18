Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8429CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBsO-0000RD-Em; Thu, 18 Jun 2026 08:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsK-000063-LJ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsH-0007xZ-37
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAtbI51516173
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QDc9G4NZI17oouZZZEjmqpXO6MXFyShzuSiHshpuPIE=; b=A6sRtPrzbMNIsyQN
 yexNfgYBwXjSPiumv7u8NwpStTs1Y8HlwpeuPs/KIRKGtzmRj1az4bTDmNWClMTF
 BTRQ3O0aBXsrslhPp11BH6VLV1dKaJsdMm7U/jaTC/ByAP2dIPKpjkc59ZkCqA3c
 px3X61xWURjKoaRs7Rv9G/xCl+n4kr5vUA8NmomDY/88dYGV/U1CAjw6GM7948Ql
 IvSZxhqmJd5trRrgynfv5sdfVcTnlOjs9V9gkP348T36sWTBUhQmXZr+IdYxrQKn
 VaXf5yltkIgikUAjUadPmBHeMCDgjQSd3Uom3PgxPFbQzj9PxmLst0TdKc1TTpiJ
 rgNG1w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a3aej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:33 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-966de053712so845717241.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785773; x=1782390573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QDc9G4NZI17oouZZZEjmqpXO6MXFyShzuSiHshpuPIE=;
 b=AfzeFgkDwiy05OL/Yvh57BGnUS09KdaSlzWKoywp94wYpVUwpTtEv6K4WY956Gg0DD
 eSiqgmKKCYDmz+dzdaYDBhRB58oaEsKD85tzvj+jp9TafsZmrX3iIIOUfK8TrqTcRPD7
 zNbE5mzEEA0O6wP/5BAqw9FCSLH7kY5uh731JYrfvcF1he/+poiJ6HShZcMOfofn4AiU
 ljGj+Pd2X/RJYt4dWcHqebMVolf4yDk7MwkLgrMI90msSW3NlboqX+jCBp3VJbehHg7q
 CrI0FrvM+9Clt4QqPgevS07ec3irOqT3q+U7swRouZZS/eq1jQoHtq7XBb+cRIpC1oaZ
 f+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785773; x=1782390573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QDc9G4NZI17oouZZZEjmqpXO6MXFyShzuSiHshpuPIE=;
 b=fYd9zD3pFxkghYvbMxmq7aSubvbMOcmOXnE/f2lBuqOuLeKiMjAJK0SyDDr9U1F81l
 gEV3HNclsIri9AtJb9o4d9wia9RK2kKOxor1qwC9NvOhLm6sACxZULbeEnIcOfMvfQMI
 sBOt1UuIIWtr+Aa1LHv/iW9tseUbDdlGCHkaqz2fwJ3Mp70NLI96t0N2BD8iVQEECD5i
 A1DjPNwVh7wyLubOgJzPtKLjl82C0B6bBl2MgjUn4gsMpVuaJd3Bhx2Cp7/YmFarDgSB
 ow7rzwrTrhD6yui2z8kFAQCx9JEKfbqobHXLYeT+2Nbi0xPP7h5DbE99CXdR9gHYqA2J
 H0yA==
X-Gm-Message-State: AOJu0YyNN8RsFF2ueVtY6bY2M3NsjaMXOZSN6G5669UU1Di1D/82GjrZ
 EJqxuWBmYjJMbho48xwmpb9hieZ1gcTh9FGJya2k+N8e70gSJMbN9LpyLqp1SLesZHxG9Xd66cg
 irrz4UDby/f6wCW5GyOJtJ50jpxMQjsgF+bOH9yAqDy/fpgrXtsLUs5BiSzRgfwbV0A==
X-Gm-Gg: AfdE7cldH+tucZ0RHYzVx7XzxHcUaKQJaSRxCU0gNh+pNmKoewf3+L8kcJzDxSCz8cO
 odVnKYZ9pTD5LtI6WKMXIX46LgMSaSipxAJvoKt0MWJ5521Iu37b3oNHirzZiQs0buRogyBqsmU
 d5dtgu228PmFYHZpfWPb+mDw6SzLM/VR0r+EE2otn1YzaoIuP1x5uQ8exoBk+EzulRXHFOY/i4C
 fKOcknnZp2+8ZUPUT2bptxdx9lCiLskNkG48QbnBWM5DrtcUP/fVMKD3HJB/NY3fNuoKMnTzRSj
 VgcPx/G253lIkyl5LXjQsxctG0yeHIykT7qsk9LcLJrNr+hLzEmkgoJDjzho5eUfnFtFZb3AEcF
 7MXXZzoqx0ie/EO/DO+y5jHcnNjDtRdH+rW5+cqIZjmElUOXEUklxN2eI73+QxJ7RWe+U
X-Received: by 2002:a05:6102:5a98:b0:727:fb8:f269 with SMTP id
 ada2fe7eead31-7270fb91f6dmr3371879137.22.1781785772817; 
 Thu, 18 Jun 2026 05:29:32 -0700 (PDT)
X-Received: by 2002:a05:6102:5a98:b0:727:fb8:f269 with SMTP id
 ada2fe7eead31-7270fb91f6dmr3371866137.22.1781785772414; 
 Thu, 18 Jun 2026 05:29:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b1083e3sm19742329f8f.20.2026.06.18.05.29.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/48] accel/kvm: Replace legacy cpu_physical_memory_write()
 call
Date: Thu, 18 Jun 2026 14:27:46 +0200
Message-ID: <20260618122825.90331-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33e4ad cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=N3d6tThwYWHiyXLDwk8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXw4CY4aD4KF9t
 1b7oqodKNuPJoLRq3KvANr5UqXxcGFLpa5RV3mE6NgDI+y0/Z28ui58Dy9hVD0TBWy8TklZ+ASD
 1BSwtJKfmaSN7V8lECCMSk5ZMXwxtA0=
X-Proofpoint-GUID: Pcf0L6lcHEH1Ya__1W6i8RY8cPTbnrTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX4y1HzL+JpkO8
 t5C6jiLQIRxqnyn0lJNBoc6Nv6AS1aD3xPM4u50SR+H6CsvKl/Ri0e2ygz7Bmlui+UOViMEpBGB
 IqXU0BzNDs3OXdfVxUztAvP0xjkNKGNru5rroFJo3sNRDB5JDQH30kv7pzfsaVFIZCZzGXQX1r0
 f6xliYdQOGg4SKq0Wu/HMT8Xu2hE0Go6w2ATFNKbEJXC3TEtcyFuTjCBBvbC81lJhmfWzz78hOt
 xVpZYlarZK25BT6CTTmy8HhbZUP0rXiIvxucZf3VS45Wtb4l6diQioammUJxAB5Yfi3bHVFq4ek
 aPEITadBFO2GnwENlSfUKbuUQDx7ZklXDJpGqHPCPvb++sAF2S+0SagL1VOWhP+r9LHU60kAaf6
 hyJbWfF4wiru+l0XVs+0sbRNeyBmf47vs0KhsB32KMtmAw7iKP4lqe0vNozmzcYkIMyNsfjfjr9
 SM6WR2CIX0dtlNlibtA==
X-Proofpoint-ORIG-GUID: Pcf0L6lcHEH1Ya__1W6i8RY8cPTbnrTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

cpu_physical_memory_write() is legacy (see commit b7ecba0f6f6),
replace it by address_space_write(). Both if() ladders only
differ in the address space argument: rework to have a single
address_space_write() call. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020839.19104-3-philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-all.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb240..f4f0e64fbd0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3178,16 +3178,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
         struct kvm_coalesced_mmio_ring *ring = s->coalesced_mmio_ring;
         while (ring->first != ring->last) {
             struct kvm_coalesced_mmio *ent;
+            const AddressSpace *as;
 
             ent = &ring->coalesced_mmio[ring->first];
-
-            if (ent->pio == 1) {
-                address_space_write(&address_space_io, ent->phys_addr,
-                                    MEMTXATTRS_UNSPECIFIED, ent->data,
-                                    ent->len);
-            } else {
-                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
-            }
+            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
+            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
+                                ent->data, ent->len);
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
-- 
2.53.0


