Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C544C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGKE-0006aP-UO; Wed, 12 Aug 2026 17:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKB-0006a7-U8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKA-0007kN-A6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2bn84038352
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wuO9FuvuiLBW9iBaej8zk2gCJXMV7JJPaKuAA2JzHl4=; b=BagT2OOKWsVvb54n
 O6Jf89698PgWotI/UFSUXgtmak1ThDbbwpGFfhvkUkzmXVBfcpoUW3AJtQdKyQ7C
 ERLise4ux/OvD7FdtkcZ9hinq/dn7YoY3bx/R32e0Iil18vdnK9v//dpp6k084Ji
 1EBaMQT7gox9Hmj84oqOy9rh7y1fZUY8iZ8+/5n3oQ34TLcVMUrAOQMpSteCoLwr
 pK4iPMRShhyGWFfrIQ/iBKE4jqhEIcbC1znTQocE8SauXr//cMBdGtZYSLVLmcvk
 UHd8rb032km5hEqTKsxNhQoq6JkuA86WcY/7tUkFV2EMWMFneXVBoq9o7nDKkYI9
 OEY21A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mndbfk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bff5c7035so124671cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569439; x=1787174239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wuO9FuvuiLBW9iBaej8zk2gCJXMV7JJPaKuAA2JzHl4=;
 b=ARB17XjNUv59H4ZEw7UCSoN/cssyFe4Ug1RuKhwZo45aEJzFYbpCDD/P5r4KEYKlJU
 CNWT7VXSY+kGyRBR3zZhdsVtaYvPACMBv1jJFmLgwzgO8GmZS9c23iYg1DxRmqOfw91R
 4mPHbwOMcE/q3P0HnDnTd/AnYzt/0l0Y2zv88cS26bbhoDhv68RM56I5PEWGogaboY6t
 JUTxtArpTMGYjDWZNoVSKaFXD+UxwYAI6A3jK1BPiZP6N9ccK8HYf165NzvzcaZ/el4s
 sNnx3/8Dj0v3xtwQfSbER6jmQ5S9Ti9iTCGN88OLq14j+2f7XpAEfPM3f3x1QYDeKs5i
 +jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569439; x=1787174239;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wuO9FuvuiLBW9iBaej8zk2gCJXMV7JJPaKuAA2JzHl4=;
 b=VriUVDdL70p3/G7zCaq9TByFawgclwQIqg8L9Pu2gq7XiRjBxHJRblxTegQblQJYpG
 BmNHzsVQnl595wDJEGtPpAgwI/jJKJ96gJBZ0YsyM86O4BAZX72dg00CjRmhZ9oSwvU7
 QZRsspkCx63TP4cc7oV9PLsdshqh+jOz57d0uOyY7qwMV/Ko6CMrE44ydTGhuaC6t2Rn
 CKm7A6iHCIxg9WbnmeW6XpgATgv7f3uiXyMfmCxxKn+EzvV4XLhu9f3jmA9r8fx728hO
 lQJotJp4o/tqdYMNnXUpvgSLUA6Ghh/HPgsfXJOIdcqTBNFCviOKhrM1QoQ+OvE6YC/f
 4foA==
X-Gm-Message-State: AOJu0YxMl5pFKSgaaGrJ6nEm1hQuyT2DgpI07LgUDKS2oMKQcrUzQRVr
 xzA7iStsakk7EeiewyuZ6HWAOXoCIuaqk2/X0y9t1vind2Sah9f02JISvLyPoqCoI0bLLQrJfQz
 y/hyuA/D6T4i9lKuClD98Ek9Edv2V/QnZv7+JwAuJazEUYRFZ0wqQoW/wgg6QlkQN/w==
X-Gm-Gg: AR+sD13bB2SRBoAaD0puv2W1Jgxcqm/qRJHz/Xvc43yOcTKhmXu8R/R6zoIc9FUdIzo
 mXlUVew0gTzPdUxKCaBoQcqk3Ip0UYkDAteK/b+JdFsqgckasXo83yhN6fKm+geN0+rJiAEYtjz
 8bB8nLvIPIONilr32KUTGw1qxAAWkvvQjJw11jcQqcjT8Trr+t4U/1zx4xNCofQAjtuXb8M6E3z
 Nk2ktha3mIaEmrVHbk23PIsmbcAL1ppkrckqK8Oi3ktgwJhxVECsP2K3hqTksnngd9wbW7Gn6H8
 Tsh0LMkeVaiLWfvkDFRiTIPaO+uKBkj3S5vLTeZQ4eIq5D03pzyTt+mWnT5NlH/4A4VE2KiftIY
 ZCqaZczsK4Bl9v1t/DoUtmlqkavuNtewWJrwD19Px7g==
X-Received: by 2002:a05:622a:4c0c:b0:51c:849b:86b with SMTP id
 d75a77b69052e-52d73e744cdmr11824341cf.43.1786569439064; 
 Wed, 12 Aug 2026 14:17:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0c:b0:51c:849b:86b with SMTP id
 d75a77b69052e-52d73e744cdmr11823711cf.43.1786569438672; 
 Wed, 12 Aug 2026 14:17:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af441sm705721f8f.22.2026.08.12.14.17.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 01/23] hexagon: Remove unnecessary 'monitor/monitor.h'
 header
Date: Wed, 12 Aug 2026 23:16:45 +0200
Message-ID: <20260812211708.92824-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXxqOGDqD1cBCV
 xUelYegyDRJEMZcYWhTER1z+nIWk8VZYz7ojYsQMbthFwNY6sHTtY9t+NGeRVDBq6+u2K7ew4kQ
 H5cw6JsiQ1yKH3g1FUFbRkw0IIUKt8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX73mSvkQE/XoB
 AfemXXQuoauBNexY0TmYn3QHQjsIPcnuD48NSbnV/7oos48L3PulBKL+ArgnS4DWSVcss8koARK
 WyIGqc69iMkkSLSuOtYtsi1JoyrLoqlwmdPTlhSODoqf31Tz+cBr8moU+JTnQYvRQ3goa5i/9wi
 7xIuzeCFN+7a3MJPsQtNnGMsn4/0s4Wun23Pd9+D+BZJUrfP4NDuCd3dMqnwE7RJN3fqa+w4xos
 8yPoFAxgEk/zpnk7d3f42NBe6kBIM/eGRYyeLQpWrPCPrEDnPHU5v55mt9nyOoaJLAi4gt6hRWH
 hbfD6uvM1isc6c+KZFUsilECLGji0j2e7pSbYtkPvfZyFdyzsWzzdLR61IilwJT7QT54eea8vKu
 9iqy/qrpa9zYFA5yINlIK9ZFpAr8umhDDU/6TlUzWLtC6//LSozwoZ9IyumD3hML65xJhVGk8wt
 pE9cqAa98MpdjZk72qg==
X-Proofpoint-GUID: qb4aEVQO0R_EGoHYiexv0wIQObIaBR9K
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7ce2e0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=-f94bmcIBZYFaPXTGXwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: qb4aEVQO0R_EGoHYiexv0wIQObIaBR9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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


