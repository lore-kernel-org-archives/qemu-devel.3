Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C677CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBuX-000538-06; Thu, 18 Jun 2026 08:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuV-00051N-LB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuU-0000xA-2o
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArhCN2611760
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gkBD2YCCxoHay6OYcmuXR+L+LWtB3tbSLQVDSyTyi1M=; b=ILjmQzKpi4vwswZf
 LuTMIxt4aPZoYmmpxcPMHHXCMMinZ0WkSloSYvkFEOFIgJsA4WOcmDM9kPS9wlS1
 5pIjdq2Kj4SGKLie3eGdrNdN7WoQDxJAz3RliMWxUjqxqfeOA/F15ybeTWcejEdv
 HBT/p8VmV4IGGM+rXWZmQ2zX63bBrkGOS115TnMZyuJbc6NzG6jhCfOAam44kyGp
 TB81EnNCsF7Dgu7D2ixIw4bbihDYIvytAZRBEhPgqAjTZ8d+3WkFO6OhoYB1BovA
 xlIsMl2Iq9YHb+O5R61kyemRrOBh6priqNlo/4YcVD9izzTmOhdMCUkxT0VP+Hyz
 HBCfHQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmupu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:52 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6d439842bso1263418a34.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785912; x=1782390712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gkBD2YCCxoHay6OYcmuXR+L+LWtB3tbSLQVDSyTyi1M=;
 b=XEYTUXmb/1B6cebnz+7x+EkGmYY/QSo+rx9PicIJ1aYn3Ndw2AEguFjtiMTTOBiXu2
 zEEhsSpvAN9eVbLluC96YexnvM1JsH7TSo8yW0+2l1qWUGfsxKiyS5VJ0NuJJ+TgOK9U
 VTxOiH1VvtP6GeBM4zZzmEfA73NRhobufeutcWdRW80S7hWoL2R8teNLwVvbJi40Sw3G
 LW7MHoDso+Beq6O/HDOtnJjpIXUN5yKr+kvPIkg41cT4JFmqWJdn6U/+ESLkmZ/sNhwI
 bqcOBHzr2pgzmOqLzoq9yiwepWK0cKBhK4YS7x+B/n4XUxp/c993/msW7VpPMSGsuhLr
 MRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785912; x=1782390712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gkBD2YCCxoHay6OYcmuXR+L+LWtB3tbSLQVDSyTyi1M=;
 b=QRglSfvABgOReQVhpcn//nHHAxtluzRkA4VOqFNCA8hkjU7MPTYRJ6iWIw0obxrqPU
 ypO0l7T1igkh3sxoUOxBuDaBP6QAkUgigrX2HVaOc881bDAAuduIYfqzQNEHo/NRmde8
 o0oxMuEyWBCQ2RJJkfz5kV1x/zYHXon9PqB6Zppv1Syv5JTY6N2XLOe5upBdnRV70P7P
 2lr5I0bx8JN90dBBRgeXNK8ij7lS+le6M7BdozS3P1TkajEQ5Qk5p3ExcAgmnGJdhpYu
 a+Q8KEtoxuBnswrYqtxh55k1l2nZFiRwqOAcSkII1cyVS4lbegrmw7Z/keHJgrUNGEX5
 mLLQ==
X-Gm-Message-State: AOJu0Yzij/KLfiHF33ubBgISq/6P5EbRLCOqEQcwtDF5WSOIR+sLdj/U
 kJDz395LeAd8bzyfXiolE13EE0e38jzmyjopd6jVCb5DotImhQC5+MP/4pbSw2mB98XlHs2fmUm
 mPCTLjiTnQeOa2MLzlkcfBoW8SHTOCwXAPF9oACCxaxjzOGmP13W9+3PacI8KZv7HGA==
X-Gm-Gg: Acq92OGmpqRRxVo/khUc1XaJ7//UOpMT6kCn8420pRpJuprX7gOy9P2bPTSJ5Z+6hfu
 fuzLJZ/baTlQV5uLoHuE5iprsSPx3qF24biyJu1MUQzp5YTTkMXuLBFoXsy2cvm+1Lpz2AtuwxF
 G1DHX/rZe4ORzRUl7UxgDgp53FFX1HJOR8nHNAijoY+bPZLktrkPHTrQntytu1/PBx6SOSCgL6B
 9YUI41+/zByk30BTMv70Nq92x0OOeceZ+LHBOv7QYXX4B71diydsJrl4UvNIEMUzFe1aV8GtC2V
 uAErB1bB4MZPAmWD2szSRQoNJdX8X6EVrPt/4ehRVJ6IznICN+F64/i/cWHe9Dr5zXoFDZetaJe
 WQ9UFtIUyjwL/DMkpkmRMxymjtL2gWDVubHA6JrYhsbY0IvlgVnojbiEsTy+lvFvhBWZa
X-Received: by 2002:a05:6830:6186:b0:7dc:c749:ade3 with SMTP id
 46e09a7af769-7e90b2f1b25mr6914279a34.3.1781785911800; 
 Thu, 18 Jun 2026 05:31:51 -0700 (PDT)
X-Received: by 2002:a05:6830:6186:b0:7dc:c749:ade3 with SMTP id
 46e09a7af769-7e90b2f1b25mr6914231a34.3.1781785911236; 
 Thu, 18 Jun 2026 05:31:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm64391330f8f.37.2026.06.18.05.31.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/48] accel/tcg: remove duplicate include
Date: Thu, 18 Jun 2026 14:28:05 +0200
Message-ID: <20260618122825.90331-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5tXmwCUn2lnn-vzGXOlGTVU9IomC6HZZ
X-Proofpoint-GUID: 5tXmwCUn2lnn-vzGXOlGTVU9IomC6HZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX2DpDGk2Oq6dY
 QaxS5TKSDIBvybzCjMbJWq5uJcHA4g5D2xYFxF6/Bxbw7JhSTQ37ZPB22AVFYyZYGXRz2+DFf2L
 JC5eiMXIlbviyKj+D9BY+YgRuZdOuUOuVBvjBzbG75/M0BUy77BDG1NoKmOxchuV7yHnrX1ZZNq
 BWN4e9nl/hfJfU9GYa5h5W+QBwxohwjfct+4799j5vgm++3wuXe7VKSWej9L47Wp1p2tJ8NterR
 IfsaT4AsFTCUcnk7+053cAGot5opntiosN3Yl+2sq7NXmiKGwLEjFYECq3VNUM4Ag9ctc/m7uqZ
 aSRTrfyPR0GW16b2RIlKm86UTb0aiLSZhEBOfJf/f3Uqm5EtlDx1Mfr4F7bZE7TpNL90QxN6a9P
 OQPoN0hbF53UHITirQbF7rQQMbw8ZCZe57BnFGFiD2iZGQflkkrpj1sJp7comMeFOUCYOjOHZT9
 YzHRWaA7VAF6xLxrtBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX9CHpdQLcNB28
 2YjmmG/lmuXe1RulXGxrgFXdfD0wcm43i8IrpMlVf8r2sbNcEmbIqybEuywTF9m8aT48blvpp66
 N6BlpuoAUYFJoizLABVHYM78YfaSk/g=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33e538 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

tb-internal.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20251126214322.64855-1-osama.abdelkader@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cputlb.c        | 1 -
 accel/tcg/tb-maint.c      | 1 -
 accel/tcg/translate-all.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d6115bbb0a4..b4239ed5be2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -44,7 +44,6 @@
 #include "tb-internal.h"
 #include "trace.h"
 #include "tb-hash.h"
-#include "tb-internal.h"
 #include "tlb-bounds.h"
 #include "internal-common.h"
 #ifdef CONFIG_PLUGIN
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0c7ac5a72c0..7a29a349110 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -32,7 +32,6 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "tb-internal.h"
 #include "internal-common.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 05d9ce512a4..5235c73bc26 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -33,7 +33,6 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "tb-internal.h"
 #include "internal-common.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
-- 
2.53.0


