Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EE9C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMqx-0006b6-0Y; Fri, 21 Aug 2026 06:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqu-0006Mn-DE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:52:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqp-0003jD-3q
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:52:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MGlJ2325341
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=; b=LZMRBur2BnzdxrxY
 WQ/HJ3LO1jCULINRSgYOR8F8XzeLbvRpc6icFlkKM8qyHtST9VvaUNehZE6tbzTk
 Lsxn6lIIr2YW//SzudAjFITBT/HadmKvuoSX4mlCwyf2CN1AXG7f3QtjG41W+o4D
 5kdSfP/nXYGdB99JEvRxtIrKUSkBmlHMa2VrpdD0KUEnHPqC0mwJczAVCT+GrGMX
 JBwfS3ON0HNfjw9rvnh5b6Bccm5NPAjiQkAcFlHjvG/uJ3+iCvsnzj7w1UyLxL35
 Ud2SRu8Yg+x4mQOgJO+yN6aC2Jc+8Ks/B86qGO9x/s0gYk7vt9BIJwkMzQgQxfdd
 nOusGA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdf15nh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso17905646d6.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309499; x=1787914299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=;
 b=aeyMzOggJjSCRTuzlO0gwKh98hSDDbx5uXG3j/CgGJENp5N1bDLC7lKmkoGt2PiyjY
 Ivutkcy2dN9LV1NiKhEoQVMeTyf6IT/aPmMk6HtJzu93bg33wiOskDwKudH5cbID3gNa
 9pc+FOOG9HNUMkwPRydv2XJXOENmEKxK0BS9WIIMv8N6LcN/j/vj6w0Eu0Mi+9v7fsq5
 UpIr92GbYn/kRpVnEy7czgs6HaCczfPffqwt/THo+mdar5pms2jj3rHgqMy26zkSfqVV
 jxHDCeU5C/jX8Rmrk09ATmz6N/Cr2T2GkvraTcwHseEC4QgjD3vF/ZR30nMglGs4+JeZ
 JMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309499; x=1787914299;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=;
 b=GGyKYfdNpbywXmq7EG9/Gb/tTmMi6ehNIpmG0nJWRQKQdyIJH9MbkX8jcNUqvUwYpN
 oEvtDO2K28RNdu1lhixZVPGUj4bG9m7qCzuHZSZpXZ8xOLKRqKnLgemWkoBPTOQIMH2C
 PAdkeK/TWI6LSeLyJ89rzBHSGCkOJqooFGDPhf4iHxESKJUfLNxhlaoqZlC23mflQLYq
 W019Ag1Lu9bnIA6pgFkQx1CKXBDod+4V+oijsxVNTVc/nb8uuCZx6aY+KcqnKh2taRmV
 wO2rvc/RyngOFV90JvKm/L6BHl6WSfjoqX6IHLulRLaBoFVdBheob7DIXIbBoKjUubGe
 eabg==
X-Gm-Message-State: AOJu0Ywj/zod4dsELB3QZr/ct5OTcRAzNFPDvNYvsyLEmpGVSizRRHrK
 kv15LTQNoaUm+pH7TKOYHBbt5mIdHvpmg9qpmISG0JGRUTycoxr028z+fCrKWScFyY0R0nAjcXg
 +NeGYs3X3ZCnOGCAhpxGDr/Fr0ixwS/1TmzLY1vJg1kO+l+UYQbnsnVprvf4PcwNCaskm
X-Gm-Gg: AR+sD11JKsr8mGBxim4bmvzhDBMDDmdo4VDvxTA2i48r5pUTypfD901camKWFS+ZJSu
 gYSR1y/83cMsE5iuTF5GGy9DcdVnrD9kTbTpeku+bb4J3ZtGG/cOvBIZfhA3lvGQH9MTSxzWkwR
 V+5dGjyBiN0UUtA9rSFsjexgnL8c+bcH9PuvwqMGaPNm2FHsPaLNkdg7KbwY3gTArFYd4HXRYSW
 Om2WxSyku/JGUGll7DFkf80eqKmgI4NCguqxeveL4cV2seDxZ+1UyvFHoQl159vpm5eU67f/1NS
 mxH1VO1icYgNuMAX5oEe0oZS6VVOuk0UNxqiQSrnJK9imnA8hD2SHFD3RzsUCtAJRYKTO0TU9sE
 R/2SLaSv34ySp6+GJZdc6Nt8fXpo8K0x+QrjdjJ56FA==
X-Received: by 2002:a05:622a:144c:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-52df565f835mr43052651cf.9.1787309499289; 
 Fri, 21 Aug 2026 03:51:39 -0700 (PDT)
X-Received: by 2002:a05:622a:144c:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-52df565f835mr43038381cf.9.1787309474684; 
 Fri, 21 Aug 2026 03:51:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b9a89572sm16631315e9.0.2026.08.21.03.51.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:51:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v3 11/15] target/riscv: Constify @iprio argument in
 riscv_cpu_pending_to_irq()
Date: Fri, 21 Aug 2026 12:49:45 +0200
Message-ID: <20260821104950.32108-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CsqPtH4D c=1 sm=1 tr=0 ts=6a882dbb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX9DdkMqTbclnl
 SRm8Pw6gijRAVsUtXV+0hvf5lqEtxkZ2HdFN5lwUz6wVTyvYII0t3FqhdTGplbdpRNq2J1/GXYu
 uTbhl4nqTG689n6vTHuxVOVflfJTiRNHnaHNOJA/Cn/mUPShrr46xhBbGOZFYomhfdgeLK2iVJr
 la5qerPfjUFKuv2zrQ+ro7HgsTAigC0VCvgV6gFi3S4utiggbSqCQlAFja8G1cuQ5wlI477d6QQ
 o7Gz23+oUvRTuvQav0I03jU+rwGPV0AL3Ut0TVSvZNHe3MjiUQYCgiLbLve9k+33ILTk1196ay8
 dLCMz0nkXsknyZv8EOlpJntvCZfqEIx53j55jWDIT0eIZTkUJwIYgcliEKjpPACFlOKAzCZX4oP
 qBCZqYWKELtUJ57IA7A41HjijRhZ8GiejikY0s20IzWb0yfpgp8OAKZ+wRgA1Vy+eiNxQin5mPL
 qL5/Bmc6FqeyezrO6DA==
X-Proofpoint-ORIG-GUID: icF0a6V87_sl8FH3jY39H_NSgwUGDmLC
X-Proofpoint-GUID: icF0a6V87_sl8FH3jY39H_NSgwUGDmLC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX575iIiVsT+SM
 80melgVoxNKQu7FzRoKwI0hkBXB8d74XHrLeumla/6UnBZWtUPkSrMONu5jtwRUL503y4cgzdxs
 +NbzCl/86lz4HjP8GC2+i9r1aw7qdmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

@iprio[] is an array only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 376cff656fa..bb4c8563554 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -642,7 +642,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio);
+                             uint64_t pending, const uint8_t *iprio);
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7bf098319f8..858fbf865fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -866,7 +866,7 @@ uint8_t riscv_cpu_default_priority(int irq)
 
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio)
+                             uint64_t pending, const uint8_t *iprio)
 {
     int irq, best_irq = RISCV_EXCP_NONE;
     unsigned int prio, best_prio = UINT_MAX;
-- 
2.53.0


