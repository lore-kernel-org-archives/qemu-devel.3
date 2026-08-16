Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FEEC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDl-0008JN-3m; Sun, 16 Aug 2026 10:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDj-0008DT-Da
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDh-0001yG-QZ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkreC2760527
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 thqyj3sMPrnVALSr8jLtNV2ILSSUcEatI3pY945uaJA=; b=TYr/dmsgZj+1R6Fe
 EvlouOMZQx4V1XkvAjldmaDYD7hb7CkSIFmJWk+O7LurDTyMK2BLU/Jld+6ikhtG
 /nVicMeW6Xl/qlS7jnUgjWaybgWYcHye9edz7VGPVapUHzBP3+/sUk+LzCTjsTLo
 MLyP8H9RoumfOQPajg2bCOjkc+tzCrzFSebYZRQ3UHvpN7sCEPOrPbzS8kb6Qu6v
 SB30eSkDVSQMLe1D2Zhq3gcINXoAFCgV9kOE8jHwasQS2j7VmLwDkqx7HP+yfQx5
 Mf+O1BIjJAo6t8DMO9LniNMpc3/1RZRBFgCqQEz1GJw0YnbfNKXxjbIdYIdKWZYy
 SL5uRw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkhaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52cd0374265so55869211cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891935; x=1787496735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=thqyj3sMPrnVALSr8jLtNV2ILSSUcEatI3pY945uaJA=;
 b=A9qKsIGdmDYoxlaF55L6YmTEzpmse7Piw3v2kTifY/AoS8ME7wdYsJBBVoiAL+sJ4R
 CneWwX5hisdpGcz2wmpP3nqK/bILrj1N1vJHrejfmmdHd12BYZtCnfIXFFLNitLYYXCg
 5TIG/LLDQGUMgkIzkzcn02z51ZbTPdifE2M/LBysfLImvSeWVaek3y7LFT7Z/oU73+yt
 FmN6D1YBC6ARaxrE8NNiRH9+DQdF5kOfJH5UuvYxksitUtWczeuAvwPcsC4kAhTkSTH7
 /bFfgmoZ7pRfbI3xZ+JDm2hcvh2y1XFu4G1HNberq+uXke4ytf3sUwYY2AqtFOeuXOVU
 HxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891935; x=1787496735;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=thqyj3sMPrnVALSr8jLtNV2ILSSUcEatI3pY945uaJA=;
 b=EydPuFN7yoySEAj0wsSub8q+1Our/fNdn+aWF2AyqeA5pD9gaVotM3UgitjDcc3LvD
 fSUDVFhtBnBNA7h9n9BAtDMlfh6Z+l5HD77KshP5dIQAC0oJubm73M0lm7KxsjW5khQE
 RrKPj6nK4ZnON2/SQN4a1uYQMPxIR5K33kCH2PPWNY+ITnuVsruHDAnQS+0jmU6ISCVI
 uoJC6Ut9Fd5hoCe2uDFwdaiVtoJsQsSWFYRikgUbHD2nVuFQubXkA5xr7FlwjXnVGSl/
 CwTm5AuADyWbHyw7g126TEJqP86gLMTTKfShOzirVOfuG39bgXyt9zVgAPbaCpfXgwyo
 1tBg==
X-Gm-Message-State: AOJu0YzTgdVFbFABU1m4upKGHkTSOXtMuGdC5cXMI4BuQx0Ube7B6dUh
 S7bfahLBI2ITyZMhcVPwNuZQr40f+yyyA3mi1FgNFBdvTgB7ztRgBvZIqLejg6qZfAuY4OhHVYr
 SUo/frxtyf8uG2hHLCYWFI7AP3nDuI7uuH2dvv9pHOC0r6UeTt7CtklE7lh0yqVcYCw==
X-Gm-Gg: AR+sD124DQqhL3z42yBNfKS1jDYGeY/JY6EeTOJQv74G5CDJFbN/bFMFc080Z8IHLK0
 Jjqe9ySpWFlPUtdi4l1uf2CFL90Cj4inGtybV6h5ht7lKObk9mgMMARGNXRnLB6x1UnoeXollxx
 Z4DasdTDtXQpC2oGDzZMawvm1wvSYspR81s1Iu1uQ8QNIEHFeI+FyVULfDrSESC/5oGj+eBox7n
 YxTQf7xcvbjOHSKl2cCaAooFauPPYxd49enSDEqkii9u8CJR6nQw74+RsvFHv5+ZQlVz+b78+aq
 ubMymWt9SQYeeYVQtZpSt6XsGQaX4gLF6EduCPrvJqPIrC69nYFdjYo2+XgcDlhsRl/rzR4JhEI
 c53hhSL37eB/phTiAQvKMyJy3sWAh1BGajcTIkA4NyQ==
X-Received: by 2002:a05:622a:244d:b0:52d:7b2a:93f with SMTP id
 d75a77b69052e-52d85374547mr208332681cf.3.1786891935397; 
 Sun, 16 Aug 2026 07:52:15 -0700 (PDT)
X-Received: by 2002:a05:622a:244d:b0:52d:7b2a:93f with SMTP id
 d75a77b69052e-52d85374547mr208332361cf.3.1786891934845; 
 Sun, 16 Aug 2026 07:52:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610966dsm76986135e9.5.2026.08.16.07.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/56] monitor: Include missing 'qemu/coroutine-core.h' header
Date: Sun, 16 Aug 2026 16:45:43 +0200
Message-ID: <20260816144556.69009-45-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OlWpu7VpaVE27l3k4NvXhFdoVA9Y8iXx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX0x6VBxJFSh80
 sc1qMZ1X5nukVSV+pe8rWP6DGHGj12lFisAntd6pqV10c9Gfb2SJwrV9Cbyr0i5chFkx2EFEuX3
 ObIBChRGkPH2tfodsb+py/X80autbWM=
X-Proofpoint-GUID: OlWpu7VpaVE27l3k4NvXhFdoVA9Y8iXx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX0GF2dg2wbW/V
 xzIw4ooV+3/5hPIIn0GR5e1t9iSSixUfdBzMB3qTe+V9I01WntsfXHeWLedF1H126GuK47q3+qB
 770DcGKHQzxp3Znaaq/6o54EZLAYxRqDFMNLVCli4aSChjoKzjvmuSHp9AR/8hSI6r8fJShtBXX
 /vHaVdJe2iPxQR4DaxYfUJEYQHSBZJ94s90zyG2BURo7ej+6BaV/nxyzXquenmzcTJxBuUymGB9
 uvKjQyh9Qotlr4v48p2gTfioM4/8RVYt+r9aXhAjKRTUYxlaAWkWzxrC0dTl+FCF73msq/5o6nr
 J4V77/jSO/mCM/wbrkvjIwtyOh8LWVZ1865D1YKiZIthg1X0ODX9ud72HvoLe8J7lx6eIUSnx6W
 NWg/zmSOPASZGczYTrQ2YJUgRfHAU34V3njU6PiETAwqJEFQozNH71+Z/s8wimbbMxY51EfUdBs
 5g0EWAyRDV81+JKDJsQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cea0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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

"monitor/monitor.h" declares monitor_set_cur() which use the
'Coroutine' type, itself declared in "qemu/coroutine-core.h".
Include the latter to avoid when refactoring unrelated headers:

  In file included from ../../target/sh4/monitor.c:26:
  qemu/include/monitor/monitor.h:32:26: error: unknown type name 'Coroutine'
     32 | Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
        |                          ^

Fixes: e69ee454b5f ("monitor: Make current monitor a per-coroutine property")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-10-philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 890497b0d22..efdd2165aa9 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -4,6 +4,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-emit-events.h"
+#include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
 #include "qom/object.h"
-- 
2.53.0


