Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DF9C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcCh-0005HE-AX; Sun, 16 Aug 2026 10:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCe-00052B-U7
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCd-0001o5-7c
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDmHKi3952772
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bDq8Q/JyB3UGBew5OiU+qn7XnjxMvl2xSHvHGXIdZVs=; b=iwv3ofs9daDkNHcY
 g1dhNcsEZ4QjABXtMeC5X0+b62ctPB8dDBeU8rPOiYI2xlkFQmin7U69HrGKJHly
 G0kMRCeOXqxoA2CMtEcDPZlJQpnGD/hou7XaOV8Kw8NB01fTg9c8uL8tfMiEo+L6
 SU2C3JhU/71MChVixqU4ejRgFgCUfxLNWgT8cOf4Hsx/zAGlRKl3WNPiHkwUqJ6M
 X8RQJWnIZIq6yt0BnnJWg80Pohr28cqlZp6/uHMCHqi5GaJSqQZyVD7PtFVDLSPe
 Vwbfbp7cSFWPNF7kgTj77ZtnEvFTHR0oheYrp97fLxOf7jg4MMVnBFPCIJffuAaI
 kc7grA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnumfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso46896141cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891869; x=1787496669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bDq8Q/JyB3UGBew5OiU+qn7XnjxMvl2xSHvHGXIdZVs=;
 b=U2snB6rFAbgrUcur55csfpEv+lIO2NM+3tO96Pb4dqUjG7PGhryZOtbmlGb6KElnv5
 GioKWgJar9dtq13N+LF77DkTMDM7hsyhf9cUn4KjzNrCmdDo+6AdTKGzoKcHyEBnx5h+
 Ha1SVmfv8FG8/6+kOXjUW6NRmfBkyQ9eVvNo3LsUYZ8z8mIggusYKgbNZwzPdcMrbuYw
 +YXdDiWrURbp1Ok40oNu/H7l0kWwJwLy/TDv5v2KdTMWVz+Yr3RbiFi4T/qE9tV/DHBZ
 J35TESqHhqtYAl6MTezH1/dnZXPCATqtPC1lsNHT4tjVq35k8+wQCgWxVX4JqUjn7aXM
 y0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891869; x=1787496669;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bDq8Q/JyB3UGBew5OiU+qn7XnjxMvl2xSHvHGXIdZVs=;
 b=en6wyZbrPW/ZQkn7lGyG53r5M/Tyh0sMjyIgTwcxz0ocsC8t43ZGfXSdg8/RcyvwwD
 /zBgSV/FOdLEZ12aM/gnuGAUWcgHoVaItu0VM5Qu6Ub/BR5ppw3apv0qzAOxrX2nQPQ1
 aYXG5F2nRErCfZZr6k1YWBS+zLS3TKSPU2ZonqdlAyD+Ln0JZJOvF/a3SQBeE/4LYvtj
 R0p6E3ctpw7zW0dagAZvy9ahu+nRVrOaFkSmFDD+puXNUFgZNuvVRgVv7RRgLOHXpaYo
 ZUNAWcYn3shvFBhaH+yX6HMQB7zUD2YFPhTNccZFRyOf5/0SUyps6be+i1JvuKHz1GNw
 bA4A==
X-Gm-Message-State: AOJu0Yy7IZdQFC1ZoSuKW4kOqW3L6xYRa8F9LJWLnasNXVKfKOnELbef
 lXyHKKelH+WHC0oX0ob+VkyfWym4LUDGnaxJ8EdVQa4pA35Bln9maIyHn7iGU+nR2GJM0Ht9KVV
 kBsqAEX8ksPcxaRItOML60DqPkVPF+uihtqXEh1X74mDazOJs2Vr4QtVUJmLYlLvE6A==
X-Gm-Gg: AR+sD13kCxq5CBarhGESG1xTKUJJYyPTnhRgMHSBqDS/DL5TSnQZbyyWDsGxYps/cXr
 RZvCgzpqwRV/HNkauajTxxF8ikg/nWN9lqNPHfvpnvTseHFI2pL2DHfL/IeJlo0xYoMq9Q0691I
 TnlWeRdx3Gw9Re0Zor0LNiAlSh1xyBh1ulGAYh6uXcFVH5chRE48sEvZOsCwLbckt0nv2pfAsjR
 YFTPEQmxJ7EKaE7oh6tOekV+LDxiID8Q8Ql1agPT/kLnuBtqlnaert9Mo4B/x+FrRfzXEYD0dGp
 I2r8YJAVS7pbED6+Zwnej0ykE40L4g+e44vNKQJr/bfPBNnr3DH6q2s2Mb1oh5XXS2Fkfaka9wu
 AU2EHGX74tk9I6Id6HOBTNSPzMd9tt4WkStMOerXKbg==
X-Received: by 2002:a05:622a:58c5:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-52d854b2a48mr216907421cf.32.1786891869526; 
 Sun, 16 Aug 2026 07:51:09 -0700 (PDT)
X-Received: by 2002:a05:622a:58c5:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-52d854b2a48mr216906921cf.32.1786891868999; 
 Sun, 16 Aug 2026 07:51:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999611bf65sm47839845e9.13.2026.08.16.07.51.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/56] hexagon: Remove unnecessary 'monitor/monitor.h' header
Date: Sun, 16 Aug 2026 16:45:35 +0200
Message-ID: <20260816144556.69009-37-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXx739x+BtVxAu
 cMBRSpfPnYVZ85V0PjJoBgF4u75iqRYttqL9ox199x5l49YM+fYPz0qvYRerW9udQZImm1Bco28
 ZooOJIK8oGwvZ6sDDXvzNx3kqglns5paPAe/0Jz71+VDA7URB5oT0nWzXYSnEPKkDk9vz+wRlGW
 mq4E2j80xDDdpFiBbJyoUyIvR35xng5alenDGPHHn6BXsWvxAUnrRpne7R86zyPlZJ8wP5mfqam
 xxbcMS1iTZ2p+Y25liS+QsQ5GZcB6pRTFx3fCdhxyqRbJJ4ZrZ+R8cxy0woJYbEU9nF7e+NyJ/n
 tt9YQQFbBPrBhx/ohCW5PnnAsnsThljfMN36Ly24u63pky4VC6zKZ0Q6rzuerlCJiyHAncsoxYI
 0mrPJra+9wlDy05x58XV3oLVnO+fWF3OFOca7IwMeQRGVLsPOkdxUoRZCWr6GTL/09dsk6yH1rr
 tOwGC6a5eczTfkw+NAQ==
X-Proofpoint-ORIG-GUID: 0mwTIqW25OK-k3vDigIZWWAXMH4553rH
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81ce5e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=-f94bmcIBZYFaPXTGXwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX54QIvtjR0Dw3
 NWa3aeLI5EyN/KKvDJxFvay4DqMaV7auWPv3tljx1rrG78VxAyYRXTzJbuooSGHqwXrB2T6Y75G
 QaNWs8rJbTwWOOkd5JMNaDWtItkfSIg=
X-Proofpoint-GUID: 0mwTIqW25OK-k3vDigIZWWAXMH4553rH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

The Monitor type is used in these 2 files, as a pointer.
Since the type is forward-declared in "qemu/typedefs.h",
which all source files include via "qemu/osdep.h", we do
not need to include it.

Do however include "exec/hwaddr.h" and "exec/mmu-access-type.h"
which declare the types used by hex_tlb_find_match prototype:

  extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
                                 MMUAccessType access_type, hwaddr *PA, int *prot,
                                 ^^^^^^^^^^^^^              ^^^^^^
                                 uint64_t *size, int32_t *excp, int mmu_idx);

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-2-philmd@oss.qualcomm.com>
---
 include/hw/hexagon/hexagon_tlb.h | 2 +-
 target/hexagon/hex_mmu.h         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
index 90d9ed84043..760dc1ea811 100644
--- a/include/hw/hexagon/hexagon_tlb.h
+++ b/include/hw/hexagon/hexagon_tlb.h
@@ -12,7 +12,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/mmu-access-type.h"
-#include "monitor/monitor.h"
+
 #define TYPE_HEXAGON_TLB "hexagon-tlb"
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
 
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
index 4f556c715a9..6aa450b9413 100644
--- a/target/hexagon/hex_mmu.h
+++ b/target/hexagon/hex_mmu.h
@@ -7,8 +7,9 @@
 #ifndef HEXAGON_MMU_H
 #define HEXAGON_MMU_H
 
+#include "exec/hwaddr.h"
+#include "exec/mmu-access-type.h"
 #include "cpu.h"
-#include "monitor/monitor.h"
 
 extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
 extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
-- 
2.53.0


