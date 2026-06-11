Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ABECD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjkn-0003tu-Oz; Thu, 11 Jun 2026 14:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkl-0003tB-TH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkk-00073K-Ff
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BHN5nO1258859
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F5p8riPWAs7blzyrkAgHjhK3P41QzqtTp9/afkPoAH8=; b=Gcrxa5MT03D/FwN/
 QNHmnl1lTZHNLmhjKGl+gS/cgfn8auTUCLDqxInhrg6OJ3G6/ly02A+xonOMz4x8
 8WsIY6z7KXttKC2L5fvHEULYU78UYSOg0xohN2p4umhcwhwv8vHgkIIjBMm9eGhS
 ad7fuxsxDEKDFlMZhA8apGpWcgDaRev5xB+1E8xfsk/THYt5KmxxpS13xWbv1Mkt
 jnhkK0PARd9n2jZvy+KhDJZs3aEDwVrbTVToat1e9t8puU0Lmrku+01QDuU9VYem
 9k6Eu5ZEEyMRNwow8EamqZgy6nvs+/eMlFzXjv2h2hyzMBUoL5vfts9s7VbY0XzQ
 lPk79A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbg77w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30762d67a64so352490eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201020; x=1781805820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5p8riPWAs7blzyrkAgHjhK3P41QzqtTp9/afkPoAH8=;
 b=I6eBGFTurFyxhDpIHN9T9nbMd2QENBOKWAutNpy41K9X+cQEj/d5+eRRqfxvJfRIzb
 n93a5h1bNPbt4CnLrScS8AywYZdlIW/x+8g/tSUOY/Jkzt988soUvWSDbHFTsuxkgLLS
 tNARLBzXPnh6qdSvmyCUL7dz5VPIPHtmyU/DX9duuJh10POlSpe8YeWPoZFtc/SQ8lxi
 MsM5Gf4wzfC9q4S/3up7a3qCoGw4DfEQrzHFRsSg/wL6FXFvfKfegTvjwqYYLDTsNv1P
 104QM8jVWcP7V0QpKtnZ8gFnzavTAYw824n9cyX9XCnKujyLdRZ++Il5f/XA9RFFrmla
 19fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201020; x=1781805820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F5p8riPWAs7blzyrkAgHjhK3P41QzqtTp9/afkPoAH8=;
 b=UQxXkIUQWVKk6hj9YDqbZLzdnUhye71LXn5/fjTQFghWrB9Jjn01X+jDUzfSXh1Wyf
 yFmx7h2GKQSnL3FxPn0ZQMPRrIJdZZ6NrkrBLlw2QttB+E3ryoJsDy34/8RQgEw9jUOV
 88ViyJaEbHXccpBBb64p4xPbbehthsteHiZqxiTAnwtUkMcZm19NOvyHRlaPPhQn8cOR
 wx60vchpI7cXs2cd6gDixeylLAflTuzZT0TY2I1TncuLPZBurV3+VZpQ2Vp0Yc/4nk5V
 5tB+HcurQKzVAJ7eAjZoa/4T74QH9WLhzdcobSes9gByhSUi46z56sCWH4nECKDf9THD
 Uupw==
X-Gm-Message-State: AOJu0YyE3cp9cbWCWQdwc/WwHkzs6SaZyZ4wKOnFcJMzThdgBKrdzdYk
 nN2BOy66KPEox5lz0IepF294aQb4LYREkBouTqX3IyHpu8dDttWlrMZb5eOuMjobMRtnbsoXIkh
 5XS4nFP2ux166RtfOee7wKdlVQ4tdFoTltO0oDoS0NeZfwBUqxXGBEBR7C7sIqBHp3oj0
X-Gm-Gg: Acq92OEyqNhI3yl6+0B2zUID0IhWu6S83AJTAsLl6DlnhtoAdoCgmfTqGzLcw9kHGPv
 w86sfCopCPiJ3nT9FJ3U6Wgls38FXSDkW39bpLGxCambUpH3IkBiNk7BbEUGD+MDQacU3wwCAPo
 KZMosokd59pPL0r1i1pregEaK5wiMBd2hmJtRLP+dsKenGSqQ/BqYKjJM4gjCBe9gbfebj1fUqc
 2eMBoP/RW5I92/aMmkHpp/fpDraMa3S5G7FTU+6N1L2xZbZ7m22T9qe1Cx2+vXiO6ygYx1h83Mg
 40iWBgg3M7oN3O/f8t00qiUCvbTP9Kg9q9mbrn41EetOGgtKH71S8jFOqxLnyHEPT3P+p9VQKOd
 EQupyfUjVc/U6H/LI8yymsVopIiG+yMj32iqgDID1I+d1jtXEHCt1MzpG/QYtmovRpYomFcbVvM
 gh1tmXHyEp
X-Received: by 2002:a05:7300:230c:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-3080478aa3dmr2799104eec.7.1781201020253; 
 Thu, 11 Jun 2026 11:03:40 -0700 (PDT)
X-Received: by 2002:a05:7300:230c:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-3080478aa3dmr2799065eec.7.1781201019650; 
 Thu, 11 Jun 2026 11:03:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db56asm1366845e9.7.2026.06.11.11.03.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:03:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] accel/kvm: Replace legacy cpu_physical_memory_write() call
Date: Thu, 11 Jun 2026 20:03:16 +0200
Message-ID: <20260611180320.30320-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611180320.30320-1-philmd@oss.qualcomm.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Pjlp70BmOim_v3nsifQyehScN2nUOIK
X-Proofpoint-ORIG-GUID: 2Pjlp70BmOim_v3nsifQyehScN2nUOIK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX9JyCaBWLR22e
 tkYlFKNvNM92o41qQL7fm5b2x99WP5/yIkb7BLGgM7UYzQDm+DyO2005NPoOYYNNxS/rqxhHIEo
 yPHTE25wamZ6GfdgDqIGcvgVJGhC0O0=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2af87d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=N3d6tThwYWHiyXLDwk8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX+kAaKQD526sf
 dvVV6XwijCMax0ATijUWUl0iHITQUQ2CpusvZHGddvbP7NWqAxS9YWTq+8u7R6dpZDGNb70RHKn
 CK30WGddBcyprUbYDcq5IMAcmwULgPqk4i1QzjGnn692hZXJVnv1fWfNBeDc5uWyIj89RqECQ6V
 Rz9wub4lEgczK/c9pn+TZEXMx+PMvB4YMFFKVzl6/SGNlRpmv5nBBV4awbDGZ5Xuu40oHpGml7W
 Y3shdR1AIp0S40ixSplE/24LBd8sg6eToK8M/lMuA/H9Rsg7GROuPRqhO1wouwSklOTcwulDbf6
 G/2X7QY5wwydZXNbgJmb/2SXCLlviP2tWBqhZujalUJgKYE/rchNjqMRQWrhxOJc5YpxUQd9SYJ
 325btmU2XN/TQ0Xb+OGlmB4Mpgltx81B5FPy2V/c7TrMd+iL6oAkbeJBx+/RVzJNuLh/YZFHquH
 PETOK7MJuKt6sLcAzhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110181
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
Cc: kvm@vger.kernel.org
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


