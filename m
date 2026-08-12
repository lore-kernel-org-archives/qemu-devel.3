Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CB3C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGKU-0006oD-34; Wed, 12 Aug 2026 17:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKR-0006hM-FO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKP-0007l6-BD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:17:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2QiC1165264
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BWohhf3UbnBtftxLdI+m/izlkbFDecQnJ0g0svmG1iM=; b=bc0cGnvaoHZXmquu
 EsV1nmkNI7rq6wa3Llwui1WNINiqTxviWaMKJLgG1GmYxRgR6W7jq5gHZzG4XkzO
 gDNjavMSOP0Rid0RgOEK8yblP5J/ayGoYyCA/RHNeOOPlZu9J5BaBnSb7fS8MoXc
 OPm47K17M4UKWg7QfVMmckiuNrifgGsur58qplWDfkNoUUYqLnXFmwErXkUi1+E+
 rc/bhpxpHMi22Tt1ZIDiCyvopouumW3EpMb3g1XK1E8s3ztLs/OClUp1kFNeyrDT
 6nHVSFSMbI0G4zVB+1Ew85d+TO1LVrI4RlnQatANAL7vSIgr7AcwFd6gThu9hLqM
 FHCK1w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk427t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283fa0656dso4292351cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569455; x=1787174255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BWohhf3UbnBtftxLdI+m/izlkbFDecQnJ0g0svmG1iM=;
 b=KYJoWio9uOHvXDOz2hA+Hj4THg5tE5MHa67a6YLlh0awZT6/6jzHQWuz0QpH9CWKii
 WDEIUG6TO3PLO9vx55EAFXab055fCJozfUdhicKrrEVnfB44HHwd247ecpCU6gtrbEDf
 5zMm1ZCSzEhJdtvs7I4D0u56pFkoK0Y5xqBIWzaZw0N5QdNFw5Gan8FCdM8q3gDf57//
 CxlA+4UW58VnpPfuTu14ra6MlvHDXonncQ2LQRtLM7OlRsaduyMCPOYJjBHT22TYN6gk
 WkvOZblEDZVEmnQUVIIdtJI4JL4vH6VCBUvIc/2K0jkWholIBTfOEY6HuBj/KsWGkL9W
 b85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569455; x=1787174255;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BWohhf3UbnBtftxLdI+m/izlkbFDecQnJ0g0svmG1iM=;
 b=mWrkZ1KEF21Tihdvh8xFIpln4m7ssxuF4blmmCCrLBmvJYX8/KyuShykLMTN35KKY/
 DFYt8uc/J/SAuzN9APeI56F43HHIfQ6U7ERJ39iK4vZ0vxRYK7ReglKrh9LgV5rdB6Jn
 U6q/AM+MmsWtv6S8wuX2H71rCt82pih3CXS+N8+CISB2LATGK0svY1qcIEwH2fwRag/I
 aa4qKhW6YSt6DMTuH6DzpV89vieANC5ELXnVkzJaIQBJ1IqbNCF9dEPcOWyZK9QR6P9L
 /iHC5MDTQAK9DJZpwZYabgIEm0fI+skU+XrjSdMbZ3oWCwnvMSfCWYmxCSzUxs8n67+b
 SOxA==
X-Gm-Message-State: AOJu0Yzi266FKjsFFElt06IDcROyysojPEYeEfl9yHFF21SWs5YM5HLE
 sxKrBzuBwXBg2CqUpX4RY5YWGVHUI5GNB07exWJ2uAq5C5JUGHpLpF3wEuwnotMqODo2UOmOI/D
 D51NHjK/PG4/9F8xhp6zRdO6PLmdyIwoYH2+WZ/SX2XjMQUQBWFgZskr1s0kfMWPV1Q==
X-Gm-Gg: AR+sD11/PbdXGo1l/Vx1OpHwIdJorf4OPmKPihwIGBqPCVk0P7rph3s0pp5HbnSzqmk
 ixe+LGmoqshVW4eT6xf40Hk/IRYEDukhSQxn8Hlmy7nLpVn0nSFUjEWaeGZSWmsju45a2emsN/p
 +jyud5bIYJREEkx/58DZKc2CvNRvOgeM3inE6B2igNszVhvTpNOgqC/g0JyCVjGjzdVyJcDyhwN
 kN6MGtVcHQS+iWRqDp6/JQ+gF5MZulWSUf7YORdg5i6RBre8AGlch5B8+ghysftAG0rD2rnLhVm
 DkQ9fEAjh+oobUicJQ3d4DtVvMcHKnmvPQV0kWBqaYmjOm1le5ZjETwJxUUSgXWnQfxvMB73sTJ
 k4B7UPj8AB5B4SVl3wjoRwfgx+HZIjt1oTsyO0vQjTQ==
X-Received: by 2002:a05:622a:5e88:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-52d74b47733mr6308511cf.11.1786569454813; 
 Wed, 12 Aug 2026 14:17:34 -0700 (PDT)
X-Received: by 2002:a05:622a:5e88:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-52d74b47733mr6308061cf.11.1786569454418; 
 Wed, 12 Aug 2026 14:17:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5c2308sm540004f8f.33.2026.08.12.14.17.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 03/23] tests/unit: Include 'qemu/main-loop.h' header in
 test-util-sockets.c
Date: Wed, 12 Aug 2026 23:16:47 +0200
Message-ID: <20260812211708.92824-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xu1dVZAR8G_og9qBGP_p__uFrdELBTuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX6r3/TWbT0QLv
 PHaYfB3Cwf7DRbTXP9BYMZC8q6HINdm+XwIUZbiSVnkrbGMHNGKn8c+XoEiFgGrmdiGpgNf1m94
 36lzcUzDeL2FNcxXAVJj1e3bjnjwiVh3ddwPCyM6fI5syOWKKT/lKbqtKgiOPPLvEklKtmrgV3d
 mvlHBta9Inj8/6eLhA5lBeqsV+yOjM8eapicQy1RbaE6aorlzSpEsSEGmj16M7Vh8q1AdDgPjS4
 rLSgjdw8AGCMGH3KFExX8sQsunvszHLFNT7iWG+6Ri/SOpjkbBNiCnQo4WEZ6kEYNbznhV+r78H
 5CcVJt3VbhDebqFNJPcwfXp7+RRsyJVaoComztLCeIhYgILKdRsyI6p2bpqoucnC0/BiP99QBmf
 5pXPLLnd0Ps1zMKIEiWpl7dWUnzbX/9a8U8cSdThtELa4GBXWHuGaiEiU3aQujHoYp2Ib1nRIwB
 kw3+KkYOGxbBOl1gQAw==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7ce2ef cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=hs6llZlkumWZFO0I0y4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX0JYY46UdulJW
 j0hl0SvZUeyUkEd6VDL1aaPedMjsaXBeym5IEixRg0KpKE9fLjbZMy7eu1ci71dQOu1BMAfBkMZ
 +kcl8UcqAeyhMAcMTaf+KJXTm2Isf+4=
X-Proofpoint-ORIG-GUID: xu1dVZAR8G_og9qBGP_p__uFrdELBTuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
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

test-util-sockets.c calls qemu_init_main_loop(), itself declared in
the "qemu/main-loop.h" header. Include the latter to avoid when
refactoring unrelated headers:

  ../tests/unit/test-util-sockets.c:553:5: error: call to undeclared function 'qemu_init_main_loop'
  553 |     qemu_init_main_loop(&error_abort);
      |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/unit/test-util-sockets.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ee66d727c38..ab3f39c3efb 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "socket-helpers.h"
-- 
2.53.0


