Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611FFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjht-0006UC-8s; Mon, 06 Jul 2026 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhp-0006Qz-Tw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjho-0007Ej-5y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxPb5369525
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cGnamiTRYUgEc4DFS7LafOuXM7GAB1v9CFpTervKBzo=; b=gXYPztZzM1jg3cia
 uzV4OMHVlGNaA74vsxfcYjFrMj3I8f7pk8NjEsMDh2tCDPBbuFdNC8v2FWqeP6ws
 NJlhWbd81Olu0J3ub4/NbHKMEkItujVMOA7RtNO6ma93U3LWVl3b5H/3rwNbH3of
 hN5bxGmlLLzp5FFChneNHJlH6jbFZPejA4zrO5/wFL5o5CXeCixkEpSIwls8yZY1
 1JTel77IK9WNYwStUXmtu3rhysUimShYpViVHjJLx5DECaNdmjOhsQIy5pb/s6Yk
 TopnmPYb016wYmvf5kQz94idGoRySC8yKlQgzpdtTGuUqwbw1WAALEE/mZ/rF6yw
 y9sNDQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99cdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:49:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so520888685a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345790; x=1783950590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cGnamiTRYUgEc4DFS7LafOuXM7GAB1v9CFpTervKBzo=;
 b=MCVLi+cbpAjhuWcvN6cfVGNqJeurTeCOAhnVgAXwiej0YDU7PT/6to4d7l3Rrpxiyu
 ljzkFH+DRlDqCvSQ8st7JSW8FWW1x7cCbOk+4+DEFByA8NNtQoGBDpy4PKJ4bggSyYyP
 HUHv1ytNFqJSpS2iTtU0kGo941pNlUloglpha26U44WFRBbRzb8y+CAE7rPJ/WGzc/IC
 MR2nvNO/loCJijmgl+xCZGsdkOSxNJgGoXRC/U4Ku6b9LaxOR2zRyTzITDBANew0dtu7
 5q3J/dUPcuJbszMKSamdj/CrncqFppSyphAclp11JlC31uktS/S6TCwsWmLiHF1wAXPk
 DBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345790; x=1783950590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cGnamiTRYUgEc4DFS7LafOuXM7GAB1v9CFpTervKBzo=;
 b=pk8oARIlaQDV1VlrBOPGsDH4iyDt43xzNrT0xnB0/J8kPAJX0yOH2BCjFT05o/03v/
 mImsYX9l9vYS9xPDpfL9AICRMIMPX4BdEnD5HmWfXjZFomsT96s+4RUS2MBNVc+e4mBD
 U+ia3YDUpkOmjV3rFD7rUgsnWsSoWvVisv17aXVfVPgGofz4C0DXJFznrumPCc7p73x2
 JYf8U+ONhs09ks6OCM0/SO951akap6+vHkgP5i23USZzGZMSc4PWxK3jgCYiLS2IukeW
 y5B6Kcg3s6lMfbpX1vWwzJyszDg/THn+YZbNDkGeOWLxTdlkhR+LYCZjb/LlWYN/otZJ
 SXsg==
X-Gm-Message-State: AOJu0Yy9J1IDYzuNCYTXMTs+3yaOnvF+ajNqSLQ8/y6kJuyAMZusVoEG
 FItIalsx7Q5Vt2HXdZ9GFttiByyiNAkUG/v+YqSdhHyQJefBB/VvY9MFJeD2t0xrlJHMrzjf3bH
 SFWn6PIsp0XTZM3U+/t4kElHDkG/5cvARMX7Z0MT9STYGZ7p8j1+YmaIFCkpq/lfGLw==
X-Gm-Gg: AfdE7clWEondB9HW5Hhqy5Vv1tfL82ataFMU+payLTY/T6m7YvhMcW7YU4tLz/DBtRu
 r0WBZkVVuZFPGuMIJB0x615Gx+NWqJRMP6gXDr4UtadLc3Q/gxsgTe8R/I8PUyKH1ieScs8ilwD
 BBXavJtZjQmMssdlIdBc/PEaDEcKaU++/8hQM3ijZnGLqZso2sjQrpzMmqg433gICt+TGzjhgOu
 JKIG9CnzcyZUQooMoezgvJelR98RfrdH497Iplo98OU1OQXsD6m/0VZFu+uO0x6CPpA+UGQThAs
 IlGWmgMzG7/ig7TiLUnDT6H0W6W6qhwZpYBp1IZZ2dsYhZHYUksJOm3LAGzbs/bttePiXgOt+kv
 vsZQZ8GehPCpyIHRYVItH8O+2N9qZJH04HBerJ0XDPnjDiESsf72n0131Zg==
X-Received: by 2002:a05:620a:170c:b0:915:abc4:b570 with SMTP id
 af79cd13be357-92ebb56a756mr83856485a.48.1783345790360; 
 Mon, 06 Jul 2026 06:49:50 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:abc4:b570 with SMTP id
 af79cd13be357-92ebb56a756mr83851185a.48.1783345789683; 
 Mon, 06 Jul 2026 06:49:49 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdabda3sm290309865e9.5.2026.07.06.06.49.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
Date: Mon,  6 Jul 2026 15:45:23 +0200
Message-ID: <20260706134527.84808-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tMQVnwqd_LzvWh-w6PuIYzIou_77C_gm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX3DjBC6k+vjPf
 S/LRv+8RhCRK+hDcCK1aVS7jBOWdlOTTlxy8O02ItKC7VjrRmJkZavIY0mrRfQ+vHct44UZ076A
 2WsKAtNyK7bXb7R3DZBKxtlu3jvwJtA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX7o7jGGQy8Jgs
 cQTrQHa1xhHiC4ILWtUcTSiWa3bM8nRgpjVPpHO1YqLjiV8DbtDfqQBkOWiphkRCJJg8xyTGhUV
 O3WnIZzZVe8rn3RFChgnGukFjlflLnfiWBKWqwem3gSFsX5h+TP+/Kq3n2NJ/5raUW+yiBVXQrx
 myFcu7nZOeNp7KPttl+JALJ0l4rH7/Ks4HfhNioDh4OmELireZN59LbMuCVuQM+qz8uBd3i7DHW
 FUmEde57BDgdOWJOeVxteDZsSsM1JX7UsmudCnoAbJh05M2PH5DaFQW7VBhO0E7kh+hdqZp0TSs
 3dQwIVd5vScuiwuwvNPrdmHDG4FClsFtKUTUxLc588g0rpgHppgqL1ykfTiN5Q0pO0MzlyNXHgK
 lc8+e4vEiOMhr10aEvK2TftJlq1CDHRarlz78rEZSJyeru5XBQrhFHusXDXtifZHfU1p3NSWq8e
 XI2MHx4Ih0mNFewpwEA==
X-Proofpoint-GUID: tMQVnwqd_LzvWh-w6PuIYzIou_77C_gm
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bb27f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=oIGtIzObNEvw8K7fi1sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-29-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 710da12b828..3ff6e6810e0 100644
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


