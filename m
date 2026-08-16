Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496B7C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcD5-0006Kl-Iu; Sun, 16 Aug 2026 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcD2-00065R-8i
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCy-0001rw-4N
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkru12397994
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gcl6rv59wL2a5Pj2S3JnwebJsocFhTOupkiou2n0Akg=; b=Cvwtv2dLtEgs7dd5
 Z5d4WCSVMrSEGHNw01PFwjb+s8YIxyQyqMBfU32nxV1oB5z5G1YBMDhcbP2h/NEW
 fS5xf5K1wMoah+Sxsk7lpO02vfD1Q0u2JLSbDtiY83i9iSTEiTy6fFKgs77FMJAD
 PCfIlEcywqn/qXh50szn5Mwygg/L5qC62PGSHp0OPjjOuIWpZG1jfJAmG3KxImEw
 BRH+1JaVON6imdI4rU0+1zH22iuyzidQhir83v/BaFrXT7QTVl8K5OhTSawLTlNe
 yi+y+48ZRj54QuZVBl5WiPZox/dIn/lSYn8H3v9AynY0ONt12z8GSYVKO+eGJkU9
 iAYClw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3nuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d33c89a29so32286121cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891890; x=1787496690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gcl6rv59wL2a5Pj2S3JnwebJsocFhTOupkiou2n0Akg=;
 b=UNo57UsHYyUMneQ6QgFkt+5SushH+ArP3kqHT7NpUQaJ7oDMmJMqr7WU57Y2v++492
 EM1kLkSbzJ/1QenyF8QgImiBHQpZE7LbIz1NDo2WSaIcC+xfnfRpentOSO4fa2EtbLWn
 OReapjL8yobNoA1wypF66wdHgDCAadjQwzJZIO+dYXBi+DDZBSB0SkRIiXfYejpm4v9t
 7KJlaEmwdVwhGdSBSzlCdszgtCvg8Daexk/nNQPLSllbhcUn47PD9A6kIPulwqRFrruG
 GIgamABm5r9dWiKsSLAwbgkweqlDWyz7L+SrW8MhvyaJCz273JDAJdDKSQueVKNiD4Vr
 /8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891890; x=1787496690;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gcl6rv59wL2a5Pj2S3JnwebJsocFhTOupkiou2n0Akg=;
 b=KdJ0fz+MxmPpEYR121F9nOcsP5eUurU7mWzk2vh/13AEx3h/HEI+TmmhW99wq3dRxD
 8xItNqLP64doh7EF//RWyd+wQolYemTGFrCnSBqwMbXbORvPP5JqG/BvdAWAlZAI1vLW
 MFWXde9v0r0lphYajXb1wgDDJsI6+RlYYPOZtUi+bLYNMzlgQfLuw4xWVyPeSebQO7oj
 2h+RUzutqLP2eZygHqPE23Mr5m2EKCnJvt1Z+8BkwIEZmrwqUkWbkaNYs1sYyfBvod8z
 1sQKtRrGcIS4KESftVejMIVrteU3rZn15qqM034Mx8RHzpGl32KwjLHiVnph5avMHsUN
 cMSQ==
X-Gm-Message-State: AOJu0YzhpXNSSAp7+VC8wY0qCrSY7SZrmhGgedkZV+FnUFZ8OZbZK+hN
 iutd0UGGZjYpgoUt0kD4GGZuaMDFn3L6U5pJsKD2c0bROqOR/gK89sGjx6ozbOFQ5urGs++t7RZ
 nIOCc+vmyo4N0ZnB1IulynUKZRlp/SoSEl3Pce+0BTS7iPgMwOJ5k5OnbRPSvwtgR4g==
X-Gm-Gg: AR+sD13nfjwO+0bjX05OjHfziDqn+iJTt3T1z/JM+pVB3ihSWyka+gOOOYSSMOXsozK
 TBFrMaxN3BpOIelTu+Yt+43nHDzbrIAiuprow469FSWesC6AkMI0GUj6UkEEqK1ogL4UpIATTYt
 ZUlkO2gjnvLlLW8+i5faOQSfWjol9OPFIjikJRnQYiweg7OqrD9hOQw2AWbEWt5eh1xCbOC88MP
 TVPu9LIHvrZPQ5n6A4JjLqzruVldYcXdb9Gd82NvXAlYDD2Z3aR1M7r/pAig/HrhHSfX/7hk6Pe
 +CqDdASaZzohzyECT+o5a0qDpR0J7PYKwz5wvWfSEYld9p1/37EpzpYoRVA9PmIHdQsIzT12kdf
 sulFeeAdLnpEmdvrYjUrlmbBz2EDM6fjtr7HlochwVg==
X-Received: by 2002:ac8:59cc:0:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-52d85477a33mr201306441cf.29.1786891890512; 
 Sun, 16 Aug 2026 07:51:30 -0700 (PDT)
X-Received: by 2002:ac8:59cc:0:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-52d85477a33mr201306071cf.29.1786891890105; 
 Sun, 16 Aug 2026 07:51:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ed6dsm79667885e9.8.2026.08.16.07.51.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/56] tests/unit: Include 'qemu/main-loop.h' header in
 test-util-sockets.c
Date: Sun, 16 Aug 2026 16:45:37 +0200
Message-ID: <20260816144556.69009-39-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXxDxEXwjZifLS
 QugQi6vKWvQc0fEuZfOwN7FuJR9pG8f3UmKlJcZuNYxxSl9ao2sRJ/phJi2gy+2D3HR4vEMwEhl
 bCnaH2i1VG4Bplp9J6V0UQKqP4YYIvGtig++UlEMvRK5nhb2ewm9s5uon2v6m0BiBrdSLJwG8+A
 HUVKpQ8GixIi+8Yzln8zK6eXMiBNTFuK6HpifhqTnZTmMWCgSIYsJ71BkPrVoRFX4q5zET92ifH
 ds/NeEcsgPluEaVHHAztQKauut/uCBkU4pnF/nIpXfu0NEewfVGY0KI1k9Bz9i9OMjCHa4+RNHI
 2WkQ5uL7kTZgsImaa8IhYd8TQfwxU4vLCuIFZXKdsN29HRDgX06jJI0tn59YfgW0NBnvQCrH+Mq
 Ry/B9djWK5yIEy8xF9UL7vIJ16QK4+hO6t3Komx4+DBytK2qKBmQOyu4Kv5BifAhQ7JneZ6O1ub
 7MO2gidRpgmKG/epqog==
X-Proofpoint-ORIG-GUID: lmBgpHPT7OwyiQ1iZaTgQ8mA9I-yl3al
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXyJj1ADzutJ1A
 0OM41kFspgxRVkRsU17Wht31yRzkZp0/WORqeStt8oFyvq30cR/Dq3HKoEClg8VzVBjM04bwKE/
 8dANNlxisiqJxEteFIxKagrIpu9xZuw=
X-Proofpoint-GUID: lmBgpHPT7OwyiQ1iZaTgQ8mA9I-yl3al
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a81ce73 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=hs6llZlkumWZFO0I0y4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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

test-util-sockets.c calls qemu_init_main_loop(), itself declared in
the "qemu/main-loop.h" header. Include the latter to avoid when
refactoring unrelated headers:

  ../tests/unit/test-util-sockets.c:553:5: error: call to undeclared function 'qemu_init_main_loop'
  553 |     qemu_init_main_loop(&error_abort);
      |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-4-philmd@oss.qualcomm.com>
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


