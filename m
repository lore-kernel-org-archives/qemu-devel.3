Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F0C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7zw-0006JF-2C; Wed, 12 Aug 2026 08:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zu-0006EY-5p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:23:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zr-0001ju-Vj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:23:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4HbD569236
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0K59RZPEvdTZnclxJKg+xf1CCEDRT+nQLEi2vTumsU0=; b=TA52QmPul2vnmp+a
 8gYRyy77IAaQWfaiOlPnQFoj7eETOL+J8+6D2ECSiNtNsRYeEjhNzn+EAhJ16N/+
 TL4XqgNCuDyhEMPioaiPbZmDXGVpmTPYhGWQ53eIj3px/4xU5XGZ2Rbmw30HrjAB
 wPZ6jWvDUktFm67jUiCuY6xsBMmadPRe5IM2sSzLd/tLIEI663K7ku8oDm97M7fk
 z6aQ5GnIMlGhy2Lj3eJwjZNXcwZKiV7t8LVq8a3VvZZx55ssJsPh5+GmXr0+T82H
 AHKW9pSwMjFfUe/MTSuFfqg+RO8J5ZMU2wZUBUlzQf7weLPrZCBv3iQnvH26i3Ik
 SlQWPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut8qdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso7526821cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537429; x=1787142229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0K59RZPEvdTZnclxJKg+xf1CCEDRT+nQLEi2vTumsU0=;
 b=HE0arvrXUk91I2rnVZQLle3z4b4PDxrQWTHAfu71ZsBxTsz46MSnhThr+87hnRebyJ
 cSOw+daJAH/Ac2XYAmK7mENh1eMOFmztqPpiHXzUn/C7Z7vdg7SyjULfxWagSFxGxg56
 JV+h2N7xz0pccLJ2piZa6buh0ReImWhjnYqD+vr/0Li1UvIIqkz8DMvToQenaH0qFNI4
 G1lzX5ghqugnTvYil2Rn6gzYna+r6bHzWNIGjH60vZvQOdBSPD2tjd6Uex/hW/Y94Qi7
 Vp6og+t9LgybVZvkeRVCBYOvXk+G5oFTC1IfCluNvnzNkYGOkSqZAKeXGJP1wJbpCsoK
 diSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537429; x=1787142229;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0K59RZPEvdTZnclxJKg+xf1CCEDRT+nQLEi2vTumsU0=;
 b=cw/GFMcH0CFrXqdGkqupH4BSuxDdCcgAIQ84hbiOUo7PKwi+7nOguORWMyzJEocwZs
 fKLTNoBUYpjGh0t4mSaRoudPxOgF9H6JvaYEeiqbH1RRUI2EeuslI/YKfqaSDl1q3mnf
 IUhylje04z64L9NiZ4Qu000ZCnB5eQAH0jngFBdfYAnggQAWVCONNZCM4MiFultmO2+P
 126ao/pR9J9hOe57V5rV+106/mjBCSv0L/58DXtSTtVf39WNAMns4OpcEs0he/EirMGj
 BByeWH3rPXMbQCr5sh2QaATL0NXSJKqVz41H4brVQI0GGOPUuhy461TM4Fqb7UIOcBGG
 gBlw==
X-Gm-Message-State: AOJu0YyusFOIDningUYBiYXNJlb0fReOpY8SPg5CxzXHQJKJIjYCG4Jr
 pghcE6nuox7mkihnpuuW/e/zVz6FrkAkAvgDp6fum6J5wSKIvvJwz0F4gCiBprN4aP9BoH9Q8OF
 7i3kp9dijnf2TwE2HrSvu+ehXbuUnPwj9X/MD+bA/mx58fb1UQuo93e7/IMv84OWnvg==
X-Gm-Gg: AR+sD1011MXEGB/4vqO7586uuoV6jrykl/nW0HhRIzP2ARLABHD7yxtuhhZfnGjgNxi
 C3AWKKMQ1YifHCFnxCV7TZGpuqhZgy6+a+Yz2Dg5hztKhfQLYC/w667ioP4VnGUvZugjtSRm+fo
 vRH7oTSqA3oA7MCDa5lulIPqFRS6MlBG6alxWfIMNEBZq231Odd2pfrI+m6XUHh+7J49/cXcrMA
 My/hxqKdONosB6fPVOpi6VLn+NAQ5s/Hu/o1IiWcXQMuQ8iWZdzeJVhSS0NWUAMSRq7zqTCW+23
 ln6aF3o/efPeAfsirmkcbURD1cMwrjFgZbVtXwD8L2Utt5j3RZYugd0Ulv1vtXat88VfTsxYVBZ
 7CSNsyMp9nrd09fYRcbFxRozUYsld30Tg29iApFD+GA==
X-Received: by 2002:ac8:7d87:0:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52d646c66c0mr33263971cf.8.1786537429589; 
 Wed, 12 Aug 2026 05:23:49 -0700 (PDT)
X-Received: by 2002:ac8:7d87:0:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52d646c66c0mr33263671cf.8.1786537429163; 
 Wed, 12 Aug 2026 05:23:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997b238a9asm45132505e9.3.2026.08.12.05.23.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:23:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 02/14] tests/unit: Include 'qemu/main-loop.h' header in
 test-util-sockets.c
Date: Wed, 12 Aug 2026 14:23:19 +0200
Message-ID: <20260812122332.72975-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX0c+26VjwWTuj
 1Q9abQFM6pY9ISEnvjaYfAHdn0rTzLYfDmnQbp4GaA/8WcTdJPEvjayiTa0iH45mtZGnQ5sBpmt
 00kPKZpERuv1VTvfB5tI/JR0ar5TIIc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX0pglf9EcTpQp
 VsFfcqn+7RLO8U/E1pfaEl9IEu1nmZeaGx2a/9n0cGOJg9u2qIn32log2qx4gmwX5yR7MI69TIA
 NijljbaqJet476IvSrZFZgA4L4FBArpSQCSj0BWwr1RmDh2tRo7Vb9g5MUmy5bN0xgOkzXW4Uz0
 G4GYl2AH3ZQMw5p+QURCchSRY0iVhzMmB6xx2RqcZUB/BnMQRjFWGpf/NtpcBJEFUuf1zxKRiB9
 PhfYk9eiiYwATvhtp2aUl/fSlUMJU1Yg7/o8vbRTmbWoE7oWj7XNuQ0nclAiZ4CTEYhq8qzlybp
 mp9ZNOPhwb+TNjq2lhGOxcz2pJv6chAi2mDP+fxmvLam96fD+gjzIIfjfJvP0qWw11eq37Ne6uC
 w1+FQTzwL6ihdD13IRbzU2cewB7rP8x8Sxymf7uIioma4Q0FSKAPNvBkUrzvBqNk4zztoarWITK
 6KA0op6XX2opFoY+4PQ==
X-Proofpoint-ORIG-GUID: U9JJjT23NyycHt8iRDJxgRmJ4Qx55oA7
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c65d6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=qNk81O5wtt-6jPY9Lu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: U9JJjT23NyycHt8iRDJxgRmJ4Qx55oA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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


