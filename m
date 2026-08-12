Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74E8C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGL7-0007g4-3X; Wed, 12 Aug 2026 17:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGL3-0007au-Ij
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGL1-0007n6-DR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2ODV1165237
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4jylwJEiWHamFPUImIEYllM79mPGNpY0k9FcLmQlC3c=; b=SanvVAi8p/MGR/ey
 uLAjV90H6uWfrlVr+aPKzH4G3Nc9EHi6m9ztD0mqMuYgSnvfbhGmmqEFrbV9gfBh
 JfLj0RoXblxN8/4/+dnAbqroe/FVfCZeykgVoClYRDzDPkigC61DYfg1woDGjlbv
 oIs5RA/cS1sKmzylTB3L9jkaVp4WHRzwtI6+dDsvV+SzN9MKbdvlyC+LO2svM8s6
 vyNoHUfQjH8oTelbjVOEVcMGgOFysunnqwuxtECmG4fRxjzGqKOqFy6bx3eOayWB
 jjE02ZAou9nsd0bUXEiCkt80SWJ3boTG03IolKakPSDBKu2v31Yre+/eqTlv3N/G
 dDjORA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk427uy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d30035dso12853941cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569493; x=1787174293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4jylwJEiWHamFPUImIEYllM79mPGNpY0k9FcLmQlC3c=;
 b=Osx1c3lJXgTOP4eyOEDc/AWjUGUNMaSmpSPpTwzZFACtIoO12GKYKT6aFuf0GOzjxm
 7cPQlTq7Iz7hSz1rhoDPaeZVpGh9YdpwwKm8HyasjzotW63ABKZfDaVfiFsHahUUiPcM
 takBN1xdNE+ONlCQEx2FiO8QR5CHeErE2dxlni9jg2bpbpSToBJqiyzXlYTLOZlr8b5E
 nN/qXbLt+lg0V6KvFQLsyL/CP7a0KxR9oukop1YAHwaumwoCq6IdVKhGMROZXfNHmu5j
 D+1z8vGUxkiNEFq20yxQQn9W8+07kjM/4sIBebTChnGJtNK2n/qLreAFv1zDmCnuI+EI
 zLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569493; x=1787174293;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4jylwJEiWHamFPUImIEYllM79mPGNpY0k9FcLmQlC3c=;
 b=XRDefUNlXfz0Srh6Yz7OuBGqLKtlsWRKih8a4sDFhtQK20l5PaCI0Eglt/oRzfIbwM
 W/f2rgJ6jvry5pBETWgWy3dkDG9fIJRXHPM0yFvBPUg2cPug5EpUaMPNoQgoFKZBi0Pp
 gMzsbysLloFdM/I5FCi9jL0hhg7ZAM5zYDqAeNugB86IitP/iGqq0V1IO3q5YH9hyL8p
 79AXsv+4H4WXTEbjp7rZKp54Eb83KDYl/MkmIypUUpjxREaqJZNaFQjTfgYh/apRup92
 d4r7ITDmOLMcRbv781EOir7/6ue3v8KAIhUbjuw3mtmAyrpo3jc0dSob9NzhbEwfPBw9
 qmiQ==
X-Gm-Message-State: AOJu0Yzm2dVfcoDap197rx18tb3b7S19IqCjNB6SiSgi+hjlKzT5p3Ce
 eL9QdcIb8ZhWeF30+FlDO1AxpDZViNgcD2r64mkTmaJzW8o7GuwcrPWnLOH9L/FUBThnwTtijIv
 X06kDz153sEPb3sAnIFh3Bk2/YZFuqYTo/U6wzWxQ7YtU685SNRavKByG2HLT9UIgWA==
X-Gm-Gg: AR+sD11iLmAGNBC8EiSM+DShxm3ZAGi+47vwDZpgwNw3idrgbUZHGQx3vGp7XcZg7sq
 55wvIKP5SpQ1mefNlbi43bo2b0CnuJiJ3Eh6oVa6AVNp0aq0uwo5BgMJznqkp6RReTnI8LFag4T
 +gsfsu7/CoWkaPhvnoWfXhMyUklleAcBODsKGvETOtleu0OYPgenwMc+T5m5Wo4i3hA48Keo1TL
 hc8IjR/awsvbgXAcELCt1d3mW9fmTYDDsXw3Z7uxRpJ+m5W2rIF/+wzq50KRsEDlcQZxrE/ZpP+
 njw7EewT7bmx1egVUNzWdHj1TTmbaeQ9086bseQMPwvnOlUcPV3mli1MeZfJr+FnKWXm3mBIAC0
 oPmmdSvqm511hB0Pw6HAMuKcsR6eR6a4zgHrmmwExWg==
X-Received: by 2002:a05:622a:58c5:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-52d73d93652mr11324701cf.28.1786569492782; 
 Wed, 12 Aug 2026 14:18:12 -0700 (PDT)
X-Received: by 2002:a05:622a:58c5:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-52d73d93652mr11324231cf.28.1786569492345; 
 Wed, 12 Aug 2026 14:18:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569325sm595083f8f.14.2026.08.12.14.18.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 08/23] monitor: Include missing 'qemu/lockable.h' header
Date: Wed, 12 Aug 2026 23:16:52 +0200
Message-ID: <20260812211708.92824-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NJgqIa8eMeN3GDMumEr8c3ZAjQeJTEnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXxgNN8hJAcaNu
 dixh2pipuAGcoRJ+BntAssF53H9cZ2eIvwBfWx0do+xlo4uN0JbSJt6JLr0lTXV4RwQcVjnQRPK
 SIsyuTu7wGyXyr4JazlF8cR5KCsxxyJRKJwKYGKw21Gs5TfKcoRMPZe8CwzXSzm16cSWQxOGKYL
 VKSosyLAJ7m/bV8yYeJcakdc1cf5OnXd4avBWfA2bQvNLsGguK7fbQu/1HEwzgHy1mBQPCIX66O
 FvR0gMciOBXntiEqOu7MeGVj/NDZnGvIqkU9nVUa4bNDQZCtc9p9MNKQt0L16wRved30g33sz4u
 P54g2HtCnmE+jvgAUsnveO/Ufsgpq60DlGg5cR52JRbhWLKW71Q9fofTIANEQBuDOUoQWTbsO2S
 pNLl0UTy+HeMjQA33pVYoLr750ewvMt5sP9TGJPuk68ogc5xKT4eXbFrfACPKuISk1qC9qQ7RaN
 TMTfVFtcFkHrGcD7BOA==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7ce315 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_5bDPQybseJbp6lUwYQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX+cEuvQ481cJ/
 d4fPEY6SpKfTvLdCAEDr9r/lylzlugG6t6rX9K+iAA92ozHEJZSqPI135VT8c+kfTZjAThrwiZl
 H/w+di/GHu0OkaiK43hH4/Xs5/vx28E=
X-Proofpoint-ORIG-GUID: NJgqIa8eMeN3GDMumEr8c3ZAjQeJTEnv
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

Files in monitor/ use the QEMU_LOCK_GUARD() macros, which
are declared in "qemu/lockable.h". Include the latter to
avoid when refactoring unrelated headers:

  ../monitor/fds.c:146:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    146 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/monitor.c:176:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    176 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/qmp.c:164:5: error: call to undeclared function 'WITH_QEMU_LOCK_GUARD'
    164 |     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
        |     ^

Fixes: 0210c3b39be ("monitor: Use LOCK_GUARD macros")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/fds.c     | 1 +
 monitor/monitor.c | 1 +
 monitor/qmp.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/monitor/fds.c b/monitor/fds.c
index cc35d2ec334..abe5f13487d 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/lockable.h"
 #include "system/runstate.h"
 
 /* file descriptors passed via SCM_RIGHTS */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c75ae815343..6af09f2f6ea 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -32,6 +32,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/aio-wait.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
 #include "trace.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6ae1098d39f..aec03157750 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/aio-wait.h"
+#include "qemu/lockable.h"
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-- 
2.53.0


