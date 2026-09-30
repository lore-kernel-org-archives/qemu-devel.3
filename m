Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF81CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByNM-0006KD-AI; Wed, 30 Sep 2026 13:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByMy-00064h-Ql
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByMx-0000pP-6j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfAjb643915
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VLVXmNhi+na25vh7Z7IIMAPP2/NgNIO3GRC5DFZ+geE=; b=MbeV/XYxAGFROPH/
 uiecAT97UlJclMy4SItx3k/FnonzupJhCMzLiOpvncO9LuUXDQ9QALw4cdZo1ksQ
 MjsOLXeojvSQdCDGOq856W6dXloGQK360O+dTbTSapUvzyW/vq+cnqqD10B0/xGx
 Y1Kd6CZh+HTSzPJKqrKAtN4MuT/wFJ3tsMr7kSTcwvWXubVEtnslcnxan+DhexE9
 iGkiu38VucGS5D5VOQPjy0YaiyB4HfgUqI6Ol5OAklsovNWMzFMCRuR77dyyqrkf
 s8TnRG+tluldulR0KrI+v3U3FJM3G1IUDpam12KFS1CBUM8S8pFEXyA81YOw3a1j
 WtdzBA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20u5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939f3426a7cso1248519785a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790325; x=1791395125; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VLVXmNhi+na25vh7Z7IIMAPP2/NgNIO3GRC5DFZ+geE=;
 b=XMrcstxuDpbCYVDPF9jA6QLM6WPJd3CQtUCPZ/TgjXeH/9jEOU2ga64EpBtf4vMQt7
 eevNuxf2mq+tMViO6MyDgAk0XoNkoYwiUjhHZeMBAE4JkV2Zwt6hJlm4kjQUHe76fbAE
 gW1krNazY6jaSO4OcP2oKyrUCQL3jCuqTTe6mEzVO8XP7qStR6JMGUY/4fqdLOsFNfDu
 K2NGFoUOwMMaGqUZStrbMxHI0/dkaj07ue+ghObP6z0bWlqX2+IOh/Cmpmni9qI76Xb5
 Q78MI89Ww2J68TIHWFiJyCTOI9/yc+fcIlfRZE4og3dGwxoSd2WpaBamcvZwE1NofOgZ
 nGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790325; x=1791395125;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLVXmNhi+na25vh7Z7IIMAPP2/NgNIO3GRC5DFZ+geE=;
 b=Ogcx0hKEdNBsXX3SdUGuaEXdifRPCzv8GMrkRTtgXlVD0TeZrhHpMCXcodJJqFuycm
 SvzaSiozxBfAlnAIsuaWqir17LFUEgfDG847je/XzMcAzsxyU/N6RV1yqZwqVsmny6a/
 QLI4t6PgHByFvLEgRdcm8a1QY1unlFDYBFbloygjXMAM2azIZYx6AsGPfmSYcUbqEvaD
 Co2Az+tbpDjvoA9WRepMcm064W4BZtsKp8Ghuvqs1r52G+y5tumORHU01YCjZO43024S
 LnRVriNBycdim+aTNJILp/oNteJs4TzMlBiFxyBCxVP5hrEO2hMd5jYEeYX6CNN1/+e4
 kECg==
X-Gm-Message-State: AFuF++k19Yzsm6O1BJdVMV/zZOSMsQFogAJ+LOrpFN89domXfMFOYCOw
 6Af5+u+GuHxdjAAOkr3XYzrzd7oKY+dOytLW3/AT0zlVEHOsh0iDbjYlcOc3QNSGGq7oUDjmJXJ
 8DX93A0GiJkNNtvzX/NLU4kjrGtjX6r/E64jGS5iGvwK2pvuZuXCFsCkbJcpHz3eoCw==
X-Gm-Gg: AYBFou0684TckIBKSrFJF24OTmlIOL9WKOg+Vewt5xbdQJYlxO/5IHeh5EdgtpctONG
 KSE78c1rk2yJHYVfWcupFwyECztlF4UgR1YCu37dnLL68DtnsAeZ3HaFRMVuWqBtatQ8t1gWyAS
 m1D3Dr9/re8zUzOTqsfR/9q1efKSAjgz883BfdlsDapPh9yx0Kb3c2Ie7lJgkQuvZ0Sp4nsoowp
 LDeAQxID1DWcZyF0KtALhyKxE1NI5iDRwsE84EJJaDIdeS6bLp5AbKz6Fl8A7nw/AxTOMhCcvE2
 csjSbaxmQgmFddSD5eeCxXApXbC/xgEnRu+KTVkHfnDxgaQKvdsaaOhHmRmn0ofyCaoVnS+lNe0
 p1myIt8WIzw3b176+YHxlCYVS4S1z8qcwiSG2x5wh
X-Received: by 2002:a05:620a:454b:b0:939:b099:d52f with SMTP id
 af79cd13be357-93ca9650a87mr392452785a.20.1790790325219; 
 Wed, 30 Sep 2026 10:45:25 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:939:b099:d52f with SMTP id
 af79cd13be357-93ca9650a87mr392446385a.20.1790790324631; 
 Wed, 30 Sep 2026 10:45:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692b5d7sm600467f8f.28.2026.09.30.10.45.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:45:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 2/7] target/riscv: Document kvm_riscv_set_irq()
Date: Wed, 30 Sep 2026 19:45:02 +0200
Message-ID: <20260930174508.81497-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd4ab6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7UhsabeAiQZP5p8CUgUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX8zMyLYxTtfan
 nKeHOcH/P9maHoqRqdNKS1XZXjlES1ZX353XwHEFE1zgzVcfKxAAe1xo8ynYTN03fChFFwJv5t7
 1c91RxoAfWywIgYRslsalQ0WsF5Wii4=
X-Proofpoint-GUID: yo0p9sqDcMwgffb1yyfXMlMQz5sT-SSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX4Pjk06uY8/LV
 pStW9I7wNevi2wnWDXiHn3LB8MEykwpGGMFv1U6dulmvzTzZC4sDfgNsZxzyZpWYs8a5+ZbfBD3
 TKRt6u/6s48hxmLbJ1ZTbHrz2Gzb1kvO44WAmB4d1RaYrxVKWhDr3FDJRfDsKUdWvf7yPu+nI1W
 oB9e+rhhPzsZ0QGJhzCLkKJ1SGYYn+wNi+1MQPKVQxJ8CBKv6SubomWn/UrrJ3R0vWWNEW3U7vZ
 LynmYUgUaCHhiK0Z7u2ci/Rg6QzKvo8oUlDt5vGatjM6aiGpu6gd0GKF5GgAv+54Dr2s+TyC+Kw
 ebvxckXlOyKY81FyCnR9OH4FIViLs+PASaqPijLOynhd05474+t7fjyMK4KWx5pJ2NHgK2mG5p6
 HFsaQqfx2NhI9GzTMH2VGh6W3f3frF2wgw7eDjo8dY8ktUtZEORVKCEACbmKy6pQhjUwufGjHS7
 Q9BBsd36FLc9sHxwCJQ==
X-Proofpoint-ORIG-GUID: yo0p9sqDcMwgffb1yyfXMlMQz5sT-SSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070
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

Describe the supported interrupt and the effect of @level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/kvm/kvm_riscv.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 61eaa12443e..7317255cba2 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -22,6 +22,12 @@
 #include "target/riscv/cpu-qom.h"
 
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
+/**
+ * kvm_riscv_set_irq:
+ * @cpu: RISC-V CPU
+ * @irq: Interrupt to set or clear (only %IRQ_S_EXT is supported).
+ * @level: %0 to clear the interrupt, non-zero to set it.
+ */
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
-- 
2.55.0


