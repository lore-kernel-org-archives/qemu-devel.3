Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A02CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI17-0000uu-0O; Mon, 01 Sep 2025 23:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI14-0000ng-5B
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI10-0004ak-G5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SAR5015364
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oP3PwixBRp5+Ncf9k6j0WiZ9Mu+hYW7a6RQHe+/NuDE=; b=o4Ep1ZDQkcsAWHOs
 bdhCHtbiGCERAGZMszlv5mtK4tqCz+v7F0HHCEJCRUaxctLujmES0zBCZp6BLGg3
 C6xaUTnOKRjpfA9JS+eUqN4Lzz8/bwreNgq7Cz/mBpkx4QbegvQOedy/WOALXYsk
 e1Pc0WaSxjhxtxkar1h0invtCmErzqcQPVRAhrPXhdC2igFpDaOuewI/G8bnGTPV
 JEPEL0FvoT2CdX2VsHj2Qk42R7G+o2D3WhMSxzyTX27DnCgH45MeMBQnovLr/4s2
 D+zjQ4rQSvkOX8BI06dCue38WCPugKXPTz+FUD5Hk2/QHH193rU8idQt0TVm1qx9
 lrbKQw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329745d6b89so4037857a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784935; x=1757389735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oP3PwixBRp5+Ncf9k6j0WiZ9Mu+hYW7a6RQHe+/NuDE=;
 b=Do75TmPc1oPbKG/TLTX9+JVXN7D5TYbqVihdohuWrp9LcIqPO7qyggIAHdFwxlAD0k
 HFJUR03Cb5KJJXqfyLyTXuttQ1LNILO4wL/apDcl2FlhgWeaQFjXw/G2Wf2XN4H8jyvh
 pIEkTEb0o/Y7D15Gq4BCggmJ6EMjFoPqF6YJei9B2RRTnEkj3Zvt8ifkksZ2OFzz48b9
 uajyTDtf/+MvlCMg7vdEZPP1lZquyUOuaXoIdALbEA69pHWdb9NSaTHp2p/zY6z/339q
 U3HbNQGz+8Jk0IhYHSWjjZ9XGYGTLhAj7BF49IhoPqywz3RCu17/TyEKwKozfU+sY2lq
 Zrmw==
X-Gm-Message-State: AOJu0YwTbk/bPmOyALb69zWrO/MC/24mOsTlAb7MFe7Bmh4badUpiE4K
 nFaJ107gTt24aQbg9DvxGUQZCfu48H3aa8L/shguGGHhO9+y2YPQrsWK0Fh8D+oj8/7Uzlnie2A
 AB9QdvtzumN3vgD1HutXaAuiHDZGRp8rXdDSUPlpAvlcT0x0+/tLOkKtxHkMMrwjnvibl
X-Gm-Gg: ASbGncsqB/rUQhuMH1Cor6K9wXnsDnxpMnLuX+MvPEBA7Ebmc9I+K9TjLDVY46iBoem
 Rt62YcyLcc+jW0k8dGQNX+kKr83fPPp8tT9nrY3/EU8bD2H3unTelLXk7STmOVnpcmQrNTwRIk/
 5wQj018LpvPizE71bXMqj4D0LGNi+Wted43dEyNWcDV5PlzS1UAtzq+Z+ooo+D3gJC59TnmppV7
 ld199VYJ3zPOYPN15Km9nSg/qyQJIJimhbNbDLXPl10iI6KtzfubVxsEmuUmb5L097/emRaP9c0
 YorIeFKob6N/nIpIm1al/SfWMX4Pf0CGftEO5qcTpU4ye3x3vvO6iV2MV+3H6qSRpWBSkx6/Q61
 nJ1iFznVTWHk+
X-Received: by 2002:a17:90b:4c42:b0:329:e3a8:add6 with SMTP id
 98e67ed59e1d1-329e3a8b022mr913391a91.2.1756784935222; 
 Mon, 01 Sep 2025 20:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYfaEUg6Qw7a9evmFFjevomQ4OTIVQXnOshylKFVXiJIQRFmSZc1vz9Wo81EaiMj5zmX74cQ==
X-Received: by 2002:a17:90b:4c42:b0:329:e3a8:add6 with SMTP id
 98e67ed59e1d1-329e3a8b022mr913364a91.2.1756784934693; 
 Mon, 01 Sep 2025 20:48:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 02/39] target/hexagon: Implement {c,}swi helpers
Date: Mon,  1 Sep 2025 20:48:10 -0700
Message-Id: <20250902034847.1948010-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xi6-vduLACwTcs3MmeWskwWCh053AV-3
X-Proofpoint-ORIG-GUID: Xi6-vduLACwTcs3MmeWskwWCh053AV-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX2KzugGgeO2ha
 1wEPDCuezEYOjijtWVPHzbzh5w5uwfT3Mm+YJxQTAYwIZoprWypu4G5/4rF8ElCekieiaJhtgR5
 Ip5ye2YQbRyVf+Tt3VQqjBp8TPgaakIDFd4LMJswWwKA7XtrWsVZaxYZBeDexz8PfwOE+kmQvq2
 76BRGcuGpkS6mIKHZkfuctcT0r3VHivybyyKbXhl7xKNfJZRLWEsvfuqkNX9DXsU8FuQ4M5RwAy
 +CzlT3PFBE27+2CnRrHbQklob2EMsbjdcVII+x/jS+7VXQgLgfDdKTV82M0UMDwQFXbrsl9ggCW
 NhGgTIoFbmjWzjFwlc/sNWvvxJzdMaSoBu78k0ONX4X8t/QYVQbBaEbM4JaWoi7WVFWZiHe9AMn
 MdLe2k/U
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66928 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

{c,}swi are the "software interrupt"/"Cancel pending interrupts" instructions.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index c38107d5a8..875935b903 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "cpu.h"
+#include "exec/cpu-interrupt.h"
 #include "internal.h"
 #include "macros.h"
 #include "sys_macros.h"
@@ -1388,12 +1389,14 @@ void HELPER(siad)(CPUHexagonState *env, uint32_t mask)
 
 void HELPER(swi)(CPUHexagonState *env, uint32_t mask)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    hex_raise_interrupts(env, mask, CPU_INTERRUPT_SWI);
 }
 
 void HELPER(cswi)(CPUHexagonState *env, uint32_t mask)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    hex_clear_interrupts(env, mask, CPU_INTERRUPT_SWI);
 }
 
 void HELPER(iassignw)(CPUHexagonState *env, uint32_t src)
-- 
2.34.1


