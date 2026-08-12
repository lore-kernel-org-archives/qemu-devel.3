Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA590C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGL0-0007Rp-M6; Wed, 12 Aug 2026 17:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKw-000796-FT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKu-0007me-KE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2EZh641781
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wj/hXbyDREedb9rtIp3sbKuyoyc96OWYmMM1MuRH8o0=; b=Oe77hhXeYnUoHw9A
 Z10Pb6reiwg5hq3iH2vvX0tuiST2RJc/GNk+3RIhsb/1QCFNw5PhY2pBixs+smy1
 l5XiMrttEbv4UyxY1BYfo0JtudyEV6aiaMsBfXFojPYjOgePB+6ykbWL3zehK6C+
 8C3P13B28VXduBtgE3L4Ggb07SWbc/WaVlFLYSwFfq0ZRyvz40n5PVQP5w+0KwJ/
 FoC5ep2dPQDkcyR6U7OUQtDo7NrmWdrVHr6fv4NH2K484c/7gLUFtAQw9vX3ZllV
 DzGLS8UKDixA+dsCdr6fvP2se3ISaxtWi6z9L5V7EKcWY4tK5DyxSdl2keHKebRd
 Mbd/4A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0wt8rrjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso23930971cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569486; x=1787174286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wj/hXbyDREedb9rtIp3sbKuyoyc96OWYmMM1MuRH8o0=;
 b=QR/Yjjr4ATeRLcs+Tldl6o4TouIJu/Q6sYbsFqtqvEP+kBDTlIQzE+dGHaK8VDig4K
 ZN29qq5fxQboZTYeA7gUbAUX5/DCT6XJ03oPAA1UCjbIgnB90muIE7gRLxq5QKGMdzwU
 4J+S7i0OaSSBS5DPTIvI51UC0/TxIcSQ5uHv4TqK69xu1IVlH4Fp28xmqQnkU4XZWfIh
 6L3yXWyfJ5blle8RUC/SuGMq8b8bqPY/vQBI5RfkJVz+NrERMo7pOSpDCZGH2ESJVDqN
 vqD6l80aIesmpVEsGwmqt5VR4fKGi5Cjtby3CCmOB4C5kWFjhrYf/d2P39+/AV7fSfSl
 x/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569486; x=1787174286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wj/hXbyDREedb9rtIp3sbKuyoyc96OWYmMM1MuRH8o0=;
 b=j4otxHgQjtgwELszINCN8F1zhJ24UCqTk4tJdAKZD6MCvV0sQ6WREIYs7SGgpd5QFb
 bfkZZa242RBT4j1iL8dBneY9UbcuS+eXMhSV90qhQWUw75bdWBvIV637+B4qjTKIQlD9
 cVfj2/DDcfvSBbXbp57xGu/55K7sDpCJgaH+XBLe9QhNxRFxzCEMDZOmfyFdo/6NOtWP
 U/t8/mBoVFI9oDoMvp8K/QMqPdt29haDcXtBCCbgzudnlPNzH91OESHfF1IgIkREFD9Z
 Y1cmoDDkrOJoFZahyFouyudUEz54bgFsYI/EbhTOvr3/wxRnNMmCPRKBUc2zGAeVEYbL
 GY3Q==
X-Gm-Message-State: AOJu0YyxQFOYeKG9FsGtu2MKCM4u5WmlUbY0dgOk1Wocj6SMQHFC9nzz
 Bl/Zpf14y/SSSW2GF955wGg2GLlS+SOo0L1YKiItWenICf7XzjkrIjNSOdPUTRrNAF8QJXuVFwj
 oOxEzYxCApYEGFfMZq991AJMGqQEyB5caJIwAbXE0aY/V07nKFB+BgOGVjN/3q588wQ==
X-Gm-Gg: AR+sD12Fb+0CBplZXVLwPGEP73lSl3h9Cu9VAR88wJnVSLH57cDDHvDdsbmFReLlWtm
 7Ajr7qT85s214u0ls4W2OmHEc3r9zYWXS/1fmWSlMlKdCIRLlE4xYz31SNs2kTqfg+2OHfBeMVk
 8bId+q7jygmQxH7QCzgW/GNhTAFoCL70rj0xWajdsC8hUH2RTDbrls8pABq+rQKdiDd9ERhnq3u
 MxQviMD5IA9uZjNAI2pLTA6eHAOnyGvxMYbISf1wT+GKyROwLHOZ10FX3svY3Z+xomQzjdYfQ8G
 61KeM9LeuIgfaaRBJ0GYuZ4ePoUOuobeQdsjtE7DNbKIIqIjAsmIcrKFQb8uYxMJdnQFh5uNkKP
 QV6UwniglSkLR67WyZ9y8/eHeojPfu8ul0HUk40ElNg==
X-Received: by 2002:a05:622a:428d:b0:517:5bc1:e1f5 with SMTP id
 d75a77b69052e-52d73a95758mr15908031cf.0.1786569486220; 
 Wed, 12 Aug 2026 14:18:06 -0700 (PDT)
X-Received: by 2002:a05:622a:428d:b0:517:5bc1:e1f5 with SMTP id
 d75a77b69052e-52d73a95758mr15906111cf.0.1786569484901; 
 Wed, 12 Aug 2026 14:18:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e4435bsm5414455e9.3.2026.08.12.14.18.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 07/23] monitor: Include missing 'qemu/aio-wait.h' header
Date: Wed, 12 Aug 2026 23:16:51 +0200
Message-ID: <20260812211708.92824-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLqvDxGx c=1 sm=1 tr=0 ts=6a7ce30f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX9XroaT8BsBaP
 CQiuKHcXTDNhsGoJasJrfYwHWP8AikyKnq5kpnNc20Gn3gTR4RUZygHFadhj3H1iljx75RK1HJw
 O2EmiaKNfHLiIupQCza1Kl8f5NX0jUQtSCko6FwDJ5V3471jOiPHL6i/cgM2aGGoNXOGQEWs0sD
 TzYQQ2si2uCyiRFzM3MZPYZqVI+bkZRWFrboGT8aZvBlb0NTSedKoXVI6Io06wukd1/xVjGGx1v
 R2AR7g9BG4wogArFH3UcMccJYwOGP9n9goVqWc5ebh7Ce/0SQSGBltGFcDrJ3MjG8wwYlThMjEh
 hlVf2QrhQ7x/nU/40GgY/NEL1yNQjePIYMcbOmtd6hLEoMKnHwq7fbpksK5xaRFSAd+lcsN2Vec
 NZT2s89SBG4lFpaHY+CQXwJDdjqb97Gwk4jaKrAazlrvloWl1CI+NwE2PqqPq8CTOn+jfDRtSQu
 4l6FqGpyOQhSfvmlIvg==
X-Proofpoint-ORIG-GUID: thqL_DeuhL2WMCqJ3oo1fDE6ZyVM4LgT
X-Proofpoint-GUID: thqL_DeuhL2WMCqJ3oo1fDE6ZyVM4LgT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXw1lEBezpQ/wb
 VHUAtrZd3AJbw+2Pjozs1LaLwOnHaowzlt1XNh8QzCAK2X4cK0lhUfmuU9mlEBP/uSTCWN4yv3L
 sq4C+hnWtRAywuLlpO910pA6gPeNtm0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120171
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

Both monitor.c and qmp.c use types / methods declared in
"qemu/aio-wait.h". Include the latter to avoid the following
errors when refactoring unrelated headers:

  ../monitor/monitor.c:648:5: error: call to undeclared function 'AIO_WAIT_WHILE_UNLOCKED'
    648 |     AIO_WAIT_WHILE_UNLOCKED(NULL,
        |     ^
  ../monitor/qmp.c:792:9: error: call to undeclared function 'aio_wait_bh_oneshot'
    792 |         aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
        |         ^

Fixes: 9ce44e2ce26 ("qmp: Move dispatcher to a coroutine")
Fixes: a5df506e129 ("monitor: implement support for deleting QMP objects")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor.c | 1 +
 monitor/qmp.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index ed195fd97bb..c75ae815343 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-visit-control.h"
 #include "qobject/qdict.h"
 #include "qom/object_interfaces.h"
+#include "qemu/aio-wait.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 338d37cb7e5..6ae1098d39f 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/aio-wait.h"
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-- 
2.53.0


