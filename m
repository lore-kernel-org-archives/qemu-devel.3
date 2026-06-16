Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190AFCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJEa-0001R7-BR; Mon, 15 Jun 2026 22:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEY-0001Oy-9w
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:08:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEW-0000ud-Op
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:08:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xhuw2271132
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D6MWjv/UtEmpMINSmfERjVJsupO3jbP2ABdaviJ4bUU=; b=drBtns2qdwRIwINR
 CsPCsLG4381V2eemuP7l32V0emt99keJA7Yeke6xP9tlduwXQjgaeVJLDSEtnQ7/
 de+487FMXDQBuNjWl8wfoEAMvcRpuu5CwKRiIr0Llz4d8jjBJUv9v0onYKoYr2T+
 D7CoKRLyq2cIhC26cwdpYlToDaUcyBZX2UiHujsPtOjeWAH58nT4Aa2LJ+nz7IUx
 iYqkwsPh5GCIEwF5nEWR0j5i75Itnsppw+Q+8QJz8tiuVfmWzHKmB79AoF7LZeUX
 wLKVpvVXYwXToR145whyN6rygN83KcrnKtkay3+vO7Y5evBVdNs5y+TruVYUFbZd
 ojhXGg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteguv5hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:08:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9156ceb551eso619029585a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575735; x=1782180535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6MWjv/UtEmpMINSmfERjVJsupO3jbP2ABdaviJ4bUU=;
 b=MLfOs5aDzG3BJqiMejYDe7QOL3RC+7/MsuXMVjBNqesKAmtZhMbi1wsETiANu46b4q
 59HLc0UYfIVv8Ap0IYoRPalz5s8C9arl4Sv5DdDLfQQN23C9RMfx9ZPbwIaa7/40jbFn
 EGzBzyMwRs7d2gTi3J/yH8Es8dY/Yc3lopB5QpolmXsO5ih5kaQV3EBP+DJF2xPfN+UQ
 c33WRfJNtvqIEvz/Ch2ggYxTrDHHMTNvo3eOJUTIIWnryJfTU8DivaOYH4NK11mlt4oy
 S8SF3s8QOZFSKJYcis3fwaeHm+hG1/YGaMy0BawYJRAQam7x2edxapQHdMBSdAmuYipM
 zZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575735; x=1782180535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D6MWjv/UtEmpMINSmfERjVJsupO3jbP2ABdaviJ4bUU=;
 b=PRTAUByDSsHQLQBkYjspjrs1THZD48yCdB66p+OfGdAQcp+ZMmiYD4O6oD+3Hea58J
 VHj9XO6oLHjWPUh+r+rkjseQQyBjwSgCxMHq2I54DiksY6idnMT107b8sS7BoU1qvSb3
 JlaYNKGcUwjVYYreYk2cIf+XC0DDOpW5BT22Li/zS2GhlIGAB02HJOk4yCypeAnY9Mob
 cVWvWz8EfOMlRFkRpEDM0oBU0R2MafeKp3MfIJRtKracbC5pf/xvXHmEJOu1JChmiuvN
 F4zTpepkwZecyqM4qWr3uFjoOF+1xIueF/KfyycXc2do+NJWv1MO1X+CFiTApsykP8hs
 uT6Q==
X-Gm-Message-State: AOJu0Yx4RB/fd/DNjiFD6B17UD9h03FERmRwnAb8u/UGiV6EFEuNWjR+
 +GZ3YCILuKEShkkYcZ9cmlE7ST/3sbHOrSWM51CQAPGK3BGlQ+5VE75g1uF7I8FLF4mGs0/M7rk
 6riAVJZQEOHEQo5g86doS2mq12XA2Z56lVzGdBdlOfpcN2U+wohTN2E/KfLXgMH1VhA==
X-Gm-Gg: Acq92OH8mObsqVA0dj49qRJ4JZ0lLbWd1CNsyFFQeQi8j/q1JcA6i3IwkfOdkLHW3MI
 gRPrM+7FDywKXZ6rU4H55/RDDQTbTyFgM3wEKY8aprNtWTTaoQ7ADxuNRR/wjkDzhKHEC4vtINv
 LpSnWckOHL7xTZ18JPorDRUupyzIHRUDR3uZMVQ2p0YAMyux/f5jf5chPDx5hpZfnN+CD8X1evg
 o45AldCj1MD8ndp0d5zW7a5tsWqyjAg8voZS/ePPvWRR8QH2b7rcWy1Dbe9D+D1SVgKxdD3rchW
 LtYLBVzwlO3VJt4f4DOA3U6WSqEqIVE8sQCsvCo9oyx2VVL098+o6kr76lC9QmcSpUUjjqsasVc
 uV4kXanxuubyLJKZQSga4vNUR0VW9LhwoEAmynsLqgV4PaVOauA3/o3GkA3Biswm2P8B2Qe98zP
 cBNr4=
X-Received: by 2002:a05:620a:25ca:b0:915:9531:f6da with SMTP id
 af79cd13be357-91c23c7c291mr380894385a.3.1781575734959; 
 Mon, 15 Jun 2026 19:08:54 -0700 (PDT)
X-Received: by 2002:a05:620a:25ca:b0:915:9531:f6da with SMTP id
 af79cd13be357-91c23c7c291mr380891785a.3.1781575734518; 
 Mon, 15 Jun 2026 19:08:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c5266sm45944324f8f.29.2026.06.15.19.08.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:08:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/6] accel/kvm: Replace legacy cpu_physical_memory_write()
 call
Date: Tue, 16 Jun 2026 04:08:35 +0200
Message-ID: <20260616020839.19104-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020839.19104-1-philmd@oss.qualcomm.com>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX12OqpY4jmumF
 +v/Xsf+dzVyH2/3fZVfP/LuCE6b2k5ADUWnZ4r1WYELt1aLAnYqVrRQE/eZ5p16bzzttvFDcsQV
 tRNvGmbys09U1i4fICHqWFZCucqFQ33kQWFIZqTn5IxQDzWWtXb6GB6GOEzUaKGLyx4WM5y6VU6
 BSNEBBXz647t5Jg31FnMolzfsUnk6cRD9J2LYy3Kg+eq72d2pumwwz6wojkZCTixplhqcAt5nOz
 22enmGI8i0R7smM+UsSth0LL9oFYiYGkqql5rNEjptgsVeQgoZEDPK+deYbpH5Zp1hazj5M6L5t
 HADUkGQBj7SONkBktzrE6nBV9tIUk/E/u+dJ7W2TlFSfIbc2X0Ftx2XbeLS7Wdb+TnwpD5wzIOW
 nbyX81OSyE3YAnSWxSwtOcHIcW8LfWeejPR+wgrW68g4+bSRvAV+F0EQNAvPDstSQcwdsrmkUjy
 dZKcJGLDoku+bc/QIjQ==
X-Proofpoint-ORIG-GUID: Dt-C4Mn05HVDxmIEsQUaTEyLv9NDzKyA
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30b037 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=N3d6tThwYWHiyXLDwk8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX59/0kr9C19Zs
 Fc7Pb4WRybU0PDX57WVpKIACHBjx6D5badhimGVWQtXs4E8ewU5FvGf/FOPeurjfRHeoKB2XHEn
 5dydLdKkpAAg6fSJdEg/nGJAKLAv3Tc=
X-Proofpoint-GUID: Dt-C4Mn05HVDxmIEsQUaTEyLv9NDzKyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160018
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


