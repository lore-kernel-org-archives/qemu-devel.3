Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77434CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBsP-0000YR-Ey; Thu, 18 Jun 2026 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsN-0000J0-Fh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsL-00082T-OQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs9mR1536741
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 muQZUEU4AwcP5d/jGNIHPLOvcJ9pAvbWRhOS23Ih6B4=; b=j95WXtG08lZbwB3A
 f0CHgw6fyjzOdEopNigB10W6IYFdpL6l32ef9VsAedOD/Ut6yE5S8IiR2PF4bASL
 WzRpYiieUzXJW5tUg5p3anAc6TZ9KNB6Zl8eaLDgcbADxsMFD17qmdWlGC+DSQkY
 0cUWgTqKDez8qRYoxrFcLyxQnUy/3Ax7xfW2rOgFMpEbcYyPnsO3DbP4ZE4YChZO
 F1Ua6oScJ0KBYjryKVNAvuKXsix0ZlRZT5rY8VLCh42qGpIxNn56xsEJsit7RguY
 +tpOIhmTk26Fx/NEfrW6K2QOyq25eCA0sYtHMkHN+MjwrIPDKVjrSAjZySehXbcS
 ZVY73A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kkcsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915757be497so198680985a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785780; x=1782390580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=muQZUEU4AwcP5d/jGNIHPLOvcJ9pAvbWRhOS23Ih6B4=;
 b=cBCJejuShBX91c/jHwsMu0mRCOv3ZTx/LZ8P4o490gmbAg0h8foBrUPFGx959WGgsh
 DOcAGWP7yCF3m+PGze7fz9LZutp3sSJ9BdCqMY1pSXWVk3hvzvMsZsYFdfDy39gBVJfY
 B17FGvKaRBtMN3Sn3h7P4H7PgDejoP7zgzVaMJD9xvFfopfAbKd20D+HzJGT4/0AfcAh
 SvRW7w3sC8vnxfJ8KNwMYFoOofsXBE8kQAYkQml8c9dU9aUSd2V1vJSJwjo3p3In7JNr
 5DzE3+z5johvkFIzvgyLQsf5kTLOAxopGGaZwevot8lFH/yOuAwKi19Lk00TbgLYudfw
 45Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785780; x=1782390580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=muQZUEU4AwcP5d/jGNIHPLOvcJ9pAvbWRhOS23Ih6B4=;
 b=AUr6huqGenk58uPr6ypCDxXdcI7SdDDE9z3zhgjS5msTUa6Ergz8dSSBfURtqfIVLd
 6e+WEw7j1XHGLFq6WGCtT4qickifazz/w5h/7SpsT9wzfGK1RczAQgNtvhs/Q+uglXt/
 KfqBSnvzdB4l7+nSvKYtORkSjJ9yevtx3+yx0Pqp/HnOSJemGel57TD+/8HJH2LMRx14
 fslehDRirzTKYpEpVM7r9746gKEijkn/kWjjbxYiUvbRXzg/piAC7FRpYMC1tyuCXbUo
 TPSqtAwRa+84dgAi5uUI7jQVB2n9Xzen2rsQpVNPJ5P8FfwDmUPZLAZp4+qH965wO07p
 o6tw==
X-Gm-Message-State: AOJu0YyCC4MzMybog2fRouUKkAiNuWco7wwFEtsEiImR7TI/dal+ljtt
 ZXgyTnjZDHh3bADVSDE7ywKg/lqmCcfhY1cTL79HDmRqaj+8QsvyIwcYDPjAHWZicPbuOzn9z26
 lWfIE62Bg6M2yU+zDCqpado9bpwLgFgSM6SmwT277sgUEP6sX1MeFkhUaUUJqisMkiQ==
X-Gm-Gg: AfdE7cnugF00G9TXBSz/xTdS/oYPQIHo2cw5lxox5eddjsMw+U9fXQ1UqU0Td01FiVD
 3/tPkm9LwivPiVlWJxupQ22kU10fI+Ky1CMilB2ZP8Inj8audjpK+Xhq+cbyMzc5wKH6RaMVPIl
 QRpIh4Lshkl5ZA2oZoP3PV6ryjgUm8U2bqqENbt+5yAfbk5605eKgmQ56+ObJWT0lk1NvuCo7v0
 Br8yKUuY+//kCLi97wnBFqBjw2n4/D4d5dfD1wiAe8c2jpmN8KePBlRGWC4u1M0U0ZltjJ6tcq9
 3qSuJPEWWYD6cM8LJlje1tYOzEydEh8ZrvXc79TrD3Q9uflPDjRw6FAWuId2VhMM/XaZ4Iu6L/c
 /DN5VNIS35t2x+2Kg1rp4kCyHXmm0dYiv80+tEeAt6Cx+ikXvdsdwlEsH/yfSocG9Ps/e
X-Received: by 2002:a05:620a:4625:b0:919:a468:c85e with SMTP id
 af79cd13be357-91dbb9489b5mr1265355385a.37.1781785779900; 
 Thu, 18 Jun 2026 05:29:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4625:b0:919:a468:c85e with SMTP id
 af79cd13be357-91dbb9489b5mr1265350885a.37.1781785779456; 
 Thu, 18 Jun 2026 05:29:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97227sm247885305e9.13.2026.06.18.05.29.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/48] gdbstub/system: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Thu, 18 Jun 2026 14:27:47 +0200
Message-ID: <20260618122825.90331-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXyu7e0uNtDM+A
 lfoJwb4kn+Sl9AJEPBLeaytfAprQQuq+DZjZDV/ARhAKOSRIIronjDGKRfr34HxYxR8/nM5ynto
 O+QAFdZW9CvIjng7eZt5tjvFmoKiwZ9PTqseM9MSV75Wj1MpZuZLAWZmlLF7TS+e+YM7lroAt88
 awirvuRRkKc2spTWlOoeGr/J8a/7BNxnJnvJWDScaNCJG6Ebif5QLOh7fPu3XKUWaj5sO6mNC2V
 Jpcqs+B+6DLFXLju+KeBD/UlPvg3C9HZlMHMosLtNju/oUCelSYg4AolS/6VPffkOI/sU+6crII
 FJVnG3gSATtc5VMuoEDGyqOAaTq+aFkPrQlqJ462OtbKMOJBIN0lm8tB8UDeQ9Psygt930Ii/NR
 C16nlXkS3+OtOmRGrT2qJUW+dQbjIGi/nGii25Ut2fKWO361P+szKwZed2Q12IBNptmwauCalla
 GQZUdzvMH8UkLEBLmBQ==
X-Proofpoint-GUID: bUkK04qa2ttzbNJYmN89S8-PztE8bK5z
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33e4b4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bUkK04qa2ttzbNJYmN89S8-PztE8bK5z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX9c+jDsx3ezhU
 Rk1GK1fDvuzt32ZJ8sbtOVgYIhS76vXClXf4uwec3icGh60Vo3m0YuN4XKA25dwqj2y5L+fsrtS
 Cp1LZS09eM4HaWCnDQq09KYn6rSEt40=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace the two calls by a single
one to address_space_rw(). So far there is no logical change, but
stop ignoring these functions returned value and propagate it,
respecting the *memory_rw_debug() family error path. Thus this is
effectively a logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020839.19104-4-philmd@oss.qualcomm.com>
---
 gdbstub/system.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index e86c5870abc..2063b63b2f8 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -20,6 +20,7 @@
 #include "exec/hwaddr.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
+#include "system/address-spaces.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
@@ -453,12 +454,10 @@ int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
     if (phy_memory_mode) {
-        if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
-        } else {
-            cpu_physical_memory_read(addr, buf, len);
-        }
-        return 0;
+        MemTxResult res = address_space_rw(&address_space_memory, addr,
+                                           MEMTXATTRS_UNSPECIFIED, buf, len,
+                                           is_write);
+        return res == MEMTX_OK ? 0 : -1;
     }
 
     if (cpu->cc->memory_rw_debug) {
-- 
2.53.0


