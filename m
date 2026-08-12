Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F419C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8ot-0007SS-MY; Wed, 12 Aug 2026 09:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lE-0003lG-Kv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8l7-0006Vb-FK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB46jk3265824
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fB3X5i66McZlK+dR+cm0eP6FmuNHMAXpD6GH/8ebx+Q=; b=MfZ44QJieVxispJM
 MRVVglEO9Q68Ya2m9+2TBQdAHfZ/OAD9lzubGsA2xphujiKhGbhHhCCt5KBiPsMa
 TW0OPiCVkIWgIOXBEOCU8gep/rpotrfmi3DxiefD50dYNJ6uloAdLhk/y1d4GhdN
 T1DMEYQX5TW46Rd9NU/jqRLrQ2+jEEHQIQnSMgjsOFSk3iLGLexYAA5oq67SIH7g
 4akivXEw2e5RTIwEVgfSvvRfTJNPMXCYeR+F4KjchQCI8DmSt6xK80kv5wb0BT4e
 rULnrgy+J/ZG7hqQSBIQgm25WOVgwh6pHPBU2/sxVrYbIEr27AHcxAxYEDMXbzpD
 cddfPw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrkxv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso9445281cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540353; x=1787145153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fB3X5i66McZlK+dR+cm0eP6FmuNHMAXpD6GH/8ebx+Q=;
 b=WL4+EAR4TODOFiYeTdqvyNyVGGKP5KISjnxPot0Srm6gnin+sBtiMvVZVjeW3l+5we
 3w4QLss5WnPRwJCF+HNuYgnRQNVHkk5rq161pvRWVO5aBCuKSayvJpYq9A3HgAw3NvYT
 bVcfJ8hXFoPRiSj/daz82u9kWGybb0QI3urbxm+jT4GfNxIAkMzlYDqEhtGDTAtYDtfl
 2m1YaXE0tAv8fc/4aL7gXPKeRRpJmEGAH3vrJ2yQRtAKMo/tzOsHRM8s8WkqgCFhwFbs
 6B+LyiWWDO2YkZd0pqY8I/JHy6xNh5lBdKvola3ZcpMnCgv5vvcgjhL3w20Y6RxanAv7
 cFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540353; x=1787145153;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fB3X5i66McZlK+dR+cm0eP6FmuNHMAXpD6GH/8ebx+Q=;
 b=g7CPZN7oUcZsRI3RQFTFNwIqduLOdnpCAhsw4lyXzVEWdyKMetcLY6+wZnB2ns9oKd
 NbyIa9MGra1so9HQ913dxNiqPBaflrboX8QckSL9hiApdQeL+TD5R7+BoTURlwlALvww
 Mf1X5GlDCH0Eq5QhQ0Lc/Q/smVlzORPNG/D7Rlipocp91s9mT3vCXPriAVk0azJHnPsW
 3HhUyxbKUz47CPmnmQZzxrFEGQV/syVKuKmCePNyE9V/ReAMTpBpBmfdV0zMKwDwqjne
 NfZT0imhz8BQxySM8Q21BKXNnwScev6dKMe71dE8nKWWjXt+23yrvp7C6GXnm/R/TERr
 mFCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDGt1UqVMyRq0PF5mNLPJ6J57xG+xztlf8lw3gVAgYK1J6aDtQTnr4fjFrWYrt/zXDvJIFT+eteyhA@nongnu.org
X-Gm-Message-State: AOJu0YwciBdY65Nzp2HZuv+Gs+z4u8yYTcDjv1bUgkIJ6QZkdQOMv61d
 KyPhTFbaM+gIfSEklAuKH6HXdeAq6v+cWe6I2AIMEZKsk71T8iFSgGrPm7oltJrr+XXTrayId6a
 7arkbYnkbwnpoF3QeIVK9ZFJ0+y6E3MRPSbIdscmVc1CmJ2p/l6oLojYkHIUk/g6ViA==
X-Gm-Gg: AR+sD11iPwwpj8fgtn1L0cWgpoaaUc+3jfwfxoltdhA3VRyjxCx+Zu75ju/ODxuqMMc
 85lqJTqzKA1AS4GJVVG5Tmu1hknJahD230L8ZyL8AwbdDFBJGEhYajcZOVC9zH7L2bcwKFUdBhN
 LA0CgzC3upj8pSspLzNwT0iKp4+asWuDSZaIEhtGpd90nUI/VJUKfuNi434ZS2faa0DH03o/I/a
 n2sOViZ3DngWllno3AqJ7ZedQ4SUsannIhTGsQWAM9CvS7nT0jKP81wbEsLfff/n7vdIvdCSCcw
 nhqmG+0dhjGBWXFNl5IMIyaIhz7K7EpB/Z07FbHxM3cia/zXXRVk5iM83VHPGcY/NaoJLRcSjmK
 vjMbqwGWuJ4MYb9SBKmJGZ+ALjyuTk2blp8Z3nEuAyw==
X-Received: by 2002:ac8:7d8d:0:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52d646b9ff2mr35513301cf.8.1786540353234; 
 Wed, 12 Aug 2026 06:12:33 -0700 (PDT)
X-Received: by 2002:ac8:7d8d:0:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52d646b9ff2mr35512761cf.8.1786540352710; 
 Wed, 12 Aug 2026 06:12:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c08982sm6595158f8f.14.2026.08.12.06.12.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 06/16] monitor: Include missing 'qemu/aio-wait.h' header
Date: Wed, 12 Aug 2026 15:11:37 +0200
Message-ID: <20260812131147.83188-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: N-porOeW8lwEqPeVIZN1B2SJ9h995pdw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX0O218636K3K7
 wJrd3OzmodFuZTIfR0NUFTo3SSufXeZYQ0fbFGmYdjkTVI4gufQDBv+kxTYhJxz5XdxYzU8nMiU
 4zQN3ptKgS51zlZxuDg853Dy1TyOULg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX7FgJCQpyjC3h
 DChuJfuoHgvVCD/9W813QrFjuAwHQY45Z4AFohPJOVQdW4MbwF5vg4r7iAM4ykD2k+goC1NCdFU
 UXTbS74ulDjhR4EeMWyRJlViOSF6jkopa/DSpdMVGPk3Uvak89VL2KeIWgAiJ+PAzoqO+W3IXfo
 ybxhYmpwO5brlaLR8/Xmf75X5px1PmQs3fYGUOt5GGPNNwJDVCvelU/NzYxYttQZZ0itsKM99B0
 R/fCM3Trrt+Tgc396N2YfqZOxSc69pMKvhj/JLON4twXJXiTjyPbh7Sa7l+LlyGPZnGH4/VX05H
 MLwFaKZOGPH5xfBdzp/GKF8eBfnQoMQjgqBIWuQt/ro2mjGz8LFRTDoeaBUUHwkKS8PuXsiqD2N
 qvWNkd9cGhz438R2/Lpa87k/neFKyfCYqoj2UTN3lJ/0AvpZn/+FLLvTlJcbngsLeGo/BnVFcft
 JRSoPfUlpZuN6IBP5Ww==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c7142 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xCX-Xho1F_OFkwux1AsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: N-porOeW8lwEqPeVIZN1B2SJ9h995pdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


