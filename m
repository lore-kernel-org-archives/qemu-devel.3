Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287D1C61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyShj-0003MT-A9; Mon, 24 Aug 2026 07:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShP-0002s0-GG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShL-0005IK-4D
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OA3EnR1630134
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=; b=T7IFdJBRS1/KpH2e
 O2dDJn4RX9gfoPCyhzvXpt5hZ3uZtGqCLAk1DZ1RikEcDJUAmScGBOL3d7iBr/aO
 AQFbH8zGmByAyQj1M2260FEB4EWnXuBdHPEH4FJ8zAABCsxYy2vbVpgzMpsInO+y
 i3xzNk+w9Pli+gFavgHJ6MDmH47focZ65JqsfR3yB+TEEI5SvpzbX4jynOHZUN+y
 SFStPy5EgyKoLzdbfpGFQR9RCtS7xcoW8ZGWwlkePigkGiLaJWoBCZKyz3cxbKNy
 A6Ek8gt/B4kXe9LqjgZdVDUc2n+9Tfl2znF9a55DyTsKAOChkOk6U05QEsV/X2qr
 o5kNow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv7881d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so27627231cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570307; x=1788175107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=aEtAJAoHxqwjpp2LQzDCi83clB9Hxm1S2ehJdaceG/82NWl+/yx7chuDI72NNLJVBF
 2adt/skKhebzXY41j00GErKWAdXLtrzEGiM9euLp8L79pz2J2X1zJfNU7MtL2Q0lTrj0
 +e4Ae/ae6npSutFpXumStEEYT5J8z21iT3PufX9Agqqp2tgR/XnTMy+1CSPV5BB3CUoJ
 YH+wSMMRvw0ZXsmJDIn1IVwPmiCtvBK/r/sP5AWPj2CXZaXh/1WangpSHIobFBkooDsb
 z47OTjGQ7XWgpzPCaKo4/ke47QkDq8uUHWReJ/Tjs95vOp7MOM4OIQqifAu3tUjT8xFv
 2YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570307; x=1788175107;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=PW+Ar2GBALh9dx94wv/lhQt6DrK43nxC+MfQyCWtm23JPMP/sKNpovlrU30Ri0NNV0
 c/b1B6WSQj6+DlX+iYhNc4WiQRSzcwmYjqo7idHgOv+6uNCWBNt2PsZMPd6uFwmUeGeK
 9mZ13Wby/C/LocC8nIoIzxCIkMhBJJcjtkquCcYldAM91sz1xirKhf2m+1qcb6tXrEdf
 Rjc+C5A0OGUBwyqbkCKO0q0dJx+EqrM62r52UMJbZLIlJ8a6EJHmvY9yl+45vV0yGyZz
 hoxsN1gvLI66eljMAQ8wFZYcnIf/DFdykXvdgQriKiAVK0zzpZ10GzxVHhE7Ivy1wq0w
 Hi2g==
X-Gm-Message-State: AFuF++nIb3gVMUcEvGfWzqHRHKXwxHSgggFPbl4mShBzRAH0eRWq8sbq
 +qwvLyNHmwszqwr6j52nQfZofAaB1XtqJrKNZh2ZuH2h38mNL8piHONggwYS72mo8ygBaj28NF8
 iJ0fvVlAXgT6LgwxE3F2XfuplfEFbEEAsgD64lLelJe8/t0ZgD12rxWSVzHLOElNGTw==
X-Gm-Gg: AR+sD13bmdRpIQMBWQ2NPAlQXWw5SIAW1jNltc+n6AIE4sZzCY45fffsK1Z3IuCk3iR
 A/EusF/vYkas8+UuOaT8uwZcQk4/o8O26kqtVn+CzSMwYYh4bMegw7kKQ05xsA07/AjQ/USM1vo
 4ln1aWaU6whYNZ+t33ZGAeC4Lch5o62K3vmYTumUFmEZ6b9Xwd5S4GfUqhkOrb6nTXBmuT+ez9/
 Dc2kFWhiqbvLVJMati2hDJXqjbA3mSvjXSf59+IVeRz660VNcBBmqEerjfHoz7zMSTWqYuQYN82
 tJRZeMs8wPsmXo3It/HkJoVayQf+ypZO4X+IWJT5g8toRTal6KLcgAWJTsPl2OS963ZLrK6JAOO
 tXY+aBwXzCUbfPqYeU8b222yjgBdsRBtaBnCaL93d1YfmvUUBEA==
X-Received: by 2002:a05:622a:1b8c:b0:52c:dffc:4645 with SMTP id
 d75a77b69052e-52df56ef07cmr245489341cf.7.1787570306604; 
 Mon, 24 Aug 2026 04:18:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8c:b0:52c:dffc:4645 with SMTP id
 d75a77b69052e-52df56ef07cmr245488731cf.7.1787570306041; 
 Mon, 24 Aug 2026 04:18:26 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496296b8bsm1120955966b.16.2026.08.24.04.18.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:18:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v4 07/20] target/avr: Constify CPUAVRState for some cpu_*()
 getters
Date: Mon, 24 Aug 2026 13:16:56 +0200
Message-ID: <20260824111711.26297-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c2883 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=064F3_fa85QpgnnSfTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX6MPSy4o5XuGl
 5KlLvDRdB1AlT+tgQ0OERV2BTJTNyWNd+vgVaS90JOwnF5gDg2xhqx6v6FzzFRdw7c085seWl90
 0oOw00ZtD4GMakg78gVMmJ3sqmhqGLg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXwrrf4zAfXy5B
 CMYQvhUm3RxnzErT1CN1FQyRnuFnSZeKgT0Z0ktZXeFVVNNNJ0kX50sdRFKmbhiMg2IVmsZOfu0
 dBXct6v1E2JiwiwqZ+yl4nwaQuRPpSFLJIox+xlWVXZFhcIe1+NhV8NgpLF3E3/9OgxvbJuy2Q9
 xuGfSjYII/88jBLxAIJVG9qwUJQOJAT7q+8l7BUZLjLPIJhft/SMgXlpJj0GvOO+Ct15o6QOFTi
 8gUmNvy/iEvGvaNSrfisbSBDXZwOgadgS2CqgNzmhHEL6Tezi2fulKuirkFl80IlS/tg3QnWDeY
 eOE6uoUo6W0jurngN2txVZGUXWYeR38rs8AqMEI5Xn5uXVQFA2ZSLTWRgcFzo7IXs+5H1Rp3OBO
 7KbW7WySDQQ1ex3pqa5QFnizmDvJ0thxRU9bMLUdGkLffJEqNQ3jBbVb0eNnjzpI6FkYvF/8JWz
 QiF5e8oVYMvQgebxY2g==
X-Proofpoint-ORIG-GUID: AD7zxOR7rtIXAKSRiBURvkUS0jyXdNyd
X-Proofpoint-GUID: AD7zxOR7rtIXAKSRiBURvkUS0jyXdNyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add the const qualifier to CPUAVRState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/avr/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a818db753b2..1e4e839bd83 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,7 +183,7 @@ int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
 vaddr avr_cpu_gdb_adjust_breakpoint(CPUState *cpu, vaddr addr);
 
-static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+static inline int avr_feature(const CPUAVRState *env, AVRFeature feature)
 {
     return (env->features & (1U << feature)) != 0;
 }
@@ -204,12 +204,12 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline int cpu_interrupts_enabled(CPUAVRState *env)
+static inline int cpu_interrupts_enabled(const CPUAVRState *env)
 {
     return env->sregI != 0;
 }
 
-static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+static inline uint8_t cpu_get_sreg(const CPUAVRState *env)
 {
     return (env->sregC) << 0
          | (env->sregZ) << 1
-- 
2.53.0


