Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBCDC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbj-0002oB-9R; Tue, 30 Jun 2026 18:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZX-0005ev-66
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZR-0004YP-SQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDdvX2920081
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pmpe5noT2zIMs8ZNURW+LbS8ZHdMJGt1/AKVCXiYfoM=; b=oTo3GrZ8YyIWOaJ3
 Yy4eWtmWao4AwPyqtq3HnXwNr8bDWd+cATViCXXHrplEHxQrrK94Rso9mSwKf3Dh
 AfO1gDBS2aCICHWAEZ7Sgzk3qvLgjls73BpglerOvwIidUkQ4PJcGtTNBbjTIN2t
 qp3dSRs3M+qOmv0JHfOEpSjUG960w9B1kTdGil5tCqoHr+6/C9GV8ROL3Me8JLVa
 BHh1atLWUWl9E1l4KwHZGpmDsGfzYPV4mKzLEM5QmhlNkTt3hJ0Qit1gpDHe/888
 SZMmIaoeioLI2Yx3nRwWg797yeyBDFETb1GeJaNe3eEhwe5urunxwd0u6bO67cRU
 V0LKUQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8umx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92b4b575561so282355985a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857074; x=1783461874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmpe5noT2zIMs8ZNURW+LbS8ZHdMJGt1/AKVCXiYfoM=;
 b=ADeMWOnrShxinugwC74b5CcmyIDkRHupZkes2LK/N/j7H05ZGTFh/D5Ogp8dLZv1l9
 aNzoMeSpo3Mxz0lHJavXu4ApypBouttvJJll0w+Xgoc2WrKsnWqG6QTo5pchpQwhGzH+
 YL9O4Ex4Y9VV/VYogdCM5osjJZFuIB9lNSNJGGEbFtZ6ZbEAXYL0gNGkBZ3bLJZjosDB
 P8cEZQ5hKBxf+lz0tB8OD2hMDxUSBEP1BapEN+62jup5K0el9EuppFf0/T9cyDBJgUqg
 5sZuA9ZMc+b50PANwqLn2J5hImJb8S1sBy5SSqPYUCVBisLK3lHMkzlNh7+5w97S/MGt
 M3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857074; x=1783461874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmpe5noT2zIMs8ZNURW+LbS8ZHdMJGt1/AKVCXiYfoM=;
 b=Bn+gN8IQghdoWkRUMTfDN19uW/6fo+f7RUeVkxgI4TeZnDdokYIH7IXndxm0W3GdWs
 EOWxnLo7C+UeXuK+IiKvkVIM3CNL9Ve3W2mA89bPkI6KlrkpWXeK+/yGuB47vhsyDED0
 So50uip5PXfh9i2fVFmTaZDc7pT5+cnLhCwgQLfzL02CDGaASw2ftDr9XfLpLp3sSkLi
 QGs7iYHQb0wuPXljNv219+nRXP06td6NkAXsWwMPVPMvXi8Pjfvvp5ji14yMaiF6CLnD
 1IQmu6+qFUo/oXxKdlQ3FjtHuWlRkGKMJcnYSPSxO5j/2eVk11y0ZKRQRuKJAS6HGymp
 727A==
X-Gm-Message-State: AOJu0YwRfO1H/fnUbiUuekNCkpNxHvfdyY+cDlMeFFeiT3KnYIEB3dL+
 +fBG5bTkDFcOOOd3o3WhOkf87RynaDQDZ71WsKgz+cPx3r1NlYg1K0oeoSZYs43HP6P3+We1Nc2
 46LuLz+U4Nvr99JzbdgnjOgRTzQZDT5qSKeVUgKY8QrRHcIDPX1RHucZUi6e+JemNDw==
X-Gm-Gg: AfdE7cm+lfIGp4jFvO8M5oDP4BT4HBhD/Fyyvdb8UI74aUbVUZQD5PcKrr9+5wbS93P
 vtu+9ee/87T+38mKlkaLkwf9fsDm76fF5YEgZwxrKd9Ngz4S7FmaBV+v6hTlQnwljD/SIDtRUl9
 0wu2JJdmeBIasRjEb4sML7GtrYCj4bFTIKNbGAtgx2ueeIg6az0Fl/dse9ApD3o7II61GpmsP6C
 gmct9c67xz0X6lamf3oFdWyMGXgv/O6INknocRpSyWoE/zLKI1FjUpO8lRRucGv5c66vs9AcvaE
 a4i5qmuZs2PtuoNpkAMQvIHGyjerZqB/Z1PHFM26AqWW9M814l1OD2ZIX3RLr9V1FWEKA6J1SnF
 TXKkCQJe8D9Th2HXuEk7Y6anMwoJfeWJJuAtQUu2QFhaRGMDbp9zzG7ZN+JwZibVXJ5M1
X-Received: by 2002:a05:620a:8086:b0:915:fc16:2ae0 with SMTP id
 af79cd13be357-92e697b4331mr475141685a.25.1782857074111; 
 Tue, 30 Jun 2026 15:04:34 -0700 (PDT)
X-Received: by 2002:a05:620a:8086:b0:915:fc16:2ae0 with SMTP id
 af79cd13be357-92e697b4331mr475134685a.25.1782857073517; 
 Tue, 30 Jun 2026 15:04:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566c0deacsm12130253f8f.26.2026.06.30.15.04.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 28/33] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
Date: Wed,  1 Jul 2026 00:00:55 +0200
Message-ID: <20260630220100.1289-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1hTvduxTicv3eM9Hwe2kzbPbWOIIJiIC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXw40yy68d4BoU
 CFvE0rIRO3TkXRa8LeMxLztfUemqgEA87xKRKMSsvDdh4A6SWN8m0CD1alnOa5yh6dW+IX/7VOv
 Gxz23wA7udrt9hL184WXn3UsZPENKvg=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a443d72 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=oIGtIzObNEvw8K7fi1sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 1hTvduxTicv3eM9Hwe2kzbPbWOIIJiIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX+rSQZYpYEvz8
 8UJIWD1+iWsDN52oWqPASMPrv2T8kyPFdgWrmMdfFnw90WPGL/3LYVfS7VmfyitbsnwEPgvEqAW
 yZos9vlxbq98TrDLt/Bf/NDSt37MGMFdTLMND9rkcN1iaOl7Iq4bhnUmLbB3DJsM1MzxbkJDAk/
 1GTPpaPsnquqGQYJYthoDIVPcNHQaXv7xJB3GC7ZwF4jMte8X12CM0Yajtr+hq5ZAO8aV2axGbs
 QbySo7GItYjC42BCRIedXLzRkj38d5kIrKBywyTtp2IKoSjpV4DE/YKA9mAko3GekA6W/fL6rJN
 Fi/OWIg05uCVIsd6/Xhkdg6lcqmyJogWct7ko5cFPGblGJOYmQDvNEtNRhI0krVJQz76mU1KLvP
 fAbB4InpaW2+I4FVnuioKNgF1tB/GpRuAX1Nu9y0meVtTWhWWCHG+ErSHnEagvwsjO4jjn7ylsw
 b2ebQDUwuuq17M/453A==
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

Commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug facility
for v2.07S") also implemented TCGCPUOps::debug_check_watchpoint for
PPC: make the comment generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f64d94b2b50..568d82cdd32 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -250,14 +250,13 @@ struct TCGCPUOps {
                                            int mmu_idx, uintptr_t retaddr);
 
     /**
-     * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
+     * @adjust_watchpoint_address: hack for cpu_check_watchpoint (used by ARM)
      */
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
 
     /**
      * @debug_check_watchpoint: return true if the architectural
-     * watchpoint whose address has matched should really fire, used by ARM
-     * and RISC-V
+     * watchpoint whose address has matched should really fire.
      */
     bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
 
-- 
2.53.0


