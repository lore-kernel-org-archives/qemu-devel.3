Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC330CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYSWk-0001ay-Jp; Sat, 13 Jun 2026 13:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSWi-0001ac-Gc
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:52:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSWh-0001QI-0A
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:52:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DFClpp3125327
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RJX4gaIJ647Q/seQvGYx5bjkcSPLY7cILaScJOCZLnM=; b=SCt2ChaiM2dHUs+c
 ZO7j3HLVhdtPpUFlMD3JN0/q0bba6a3C9FjAzUilu4IoG8v5GZ1EDGfpI9TveAbl
 EBk+3cd/xyzUGLHdBrdrWPgBcRvFbMY3QQKB3modneVMDmZf167na6UTQvyky4uH
 C+CBRNVdI8H3j9dTo5x28YRIsxe3UQJFnr8y5MN9hs5oq4k2ddG2K7H1aOJOYi96
 iQLX/dKTOU/luGzqzlXq5Zyu6CyCf6BFpJY0vJr4vOi6NSgiIx2RI/dBO4oGkU4W
 gXLkGv75tp3a699I6NZRd4Ftf5BVQq/nVGXQQaOHYixGViJCjq+/9cBEFq7u+CD5
 pL3LFw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery951p94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:52:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso343366685a.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781373129; x=1781977929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJX4gaIJ647Q/seQvGYx5bjkcSPLY7cILaScJOCZLnM=;
 b=EkGaiDG10yNpdUboweBYlMXeYSYyqKZmlZR56gpsrmokemGuVkjD5uZ9xGRWRJPvgK
 rsQuxoPgo6rlZ5P/aki2rbVdnBBB6UoTiI9vACdHOreZNYckCqms8I7z1lHQU47iJum9
 /w8PYGbZ4UV7yHJDvWTUWJGD5BeWxd3i2AKEhUMjxHVuRuq2hhv9gJYeOvlFQr9jUoqQ
 ljFGg2SnPJjzyfQG7UYFKfN+BKgtNV4Xvakbzz1xcqO+zKWo1gevXRbABFkU2AkgtncG
 IzmxOWYpm1hsQjmBLRgMvxCnYldf3OfsHM5pMurBWT589xHqcXQJBx4wqPzV5ksT8FY/
 0Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373129; x=1781977929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJX4gaIJ647Q/seQvGYx5bjkcSPLY7cILaScJOCZLnM=;
 b=qanO87ggQSENwlfmyPXv1uTJN0gRsRI4WU0F6M4uqnGFVnHQ000Xf03gOpNfa0pBhh
 EG0G79FC52YA82O9myA830vzMRdH5jCaPTGqAIXcs87fN/L2LVKJ0xZqKyC0P/BuYmwi
 V7GpyTNJc5VE4pEwNidbItzQAQFqccYLDrtKXDSK1Id9J2/w1y6RLbzyHqiuSFjigODi
 nsZ/UdveJw1hQHsYYkyLxnJnaHN6irHrVUef1KNvHucxfUUTo3/TI1v2L8JL148BIPeX
 p0apOfVMJXYjgcnnOrSLWgopSYPEFkBxrjYWl32UdK6R3MMQrJZTv/Q1z56cCIlOOYar
 FhCA==
X-Gm-Message-State: AOJu0YxLUikVQvrjENxoJjB++U06UVDs5flIHvzZxO600x3Hhs7TpxYO
 XC0fS5WmJegKPtH9WsMZkxgIcSGAo7ms78Pns3pCJnU31lVwBZ0FNuqNkngBP6QEbxTpDDCa44O
 C0+xSKyZtkCJdhvJjdSOHyAq0YVwuQzIWnxyGs2J503A9MCESEqzxmtz+XmBQ+8ADqw==
X-Gm-Gg: Acq92OErd5P75p21NS/Rcy/TpekXAxKaeZuLnmFbgjCn7HHgcnHuPwQywRrDdkhgAFE
 l53KBzya2qTeClaTCvPejscOCFwvpegRTFCUu0pcy84RyYAewP4dmHFDapTjN9uYMoXj7p0Rubc
 4zUXHyxnJiIqGJtbOGxeBik6UDPFMyt/cCcFiiFiN4vhxluJldlUHRIjMwrHNbGk2c4IdeiESRX
 CEPV6J34HOeEAaGgYe1qoVc5njbKToKAQoAIdbocbGGATG1HMk9pVitw0BNrE5SbszyTMrBvpFh
 FXmx0ZiBRBf3vzgSzIPKRMBHOFzcgPV3k7GlupfHF/zMaaad0CvQz1rFHZDMtQwMkZG05jeabBY
 YQMz5GURVfxo8iBnnvkFnlDLnsarnEQDZbjUO2uIL6HhfOgB/Y7zl6kwRQxz3tjTwsFbjyBZ2hq
 fD81USjNDy
X-Received: by 2002:a05:620a:2406:10b0:915:7e22:6f1f with SMTP id
 af79cd13be357-9161bc23806mr879617785a.22.1781373129213; 
 Sat, 13 Jun 2026 10:52:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2406:10b0:915:7e22:6f1f with SMTP id
 af79cd13be357-9161bc23806mr879615485a.22.1781373128770; 
 Sat, 13 Jun 2026 10:52:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cd6c2sm17546743f8f.30.2026.06.13.10.52.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 13 Jun 2026 10:52:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] qom/object: Remove pre-C11 check
Date: Sat, 13 Jun 2026 19:51:51 +0200
Message-ID: <20260613175151.1357-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260613175151.1357-1-philmd@oss.qualcomm.com>
References: <20260613175151.1357-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M3h_Qs4LReN9kWIptDi485GPTwNHeniw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE4NiBTYWx0ZWRfX0XKPw/H9xNGX
 AQWzoJ/yD1oLlttQtbvf60eNONA2rIJBlld/gIl2GfzuTR52b7b0iRqLKZbxAYoomIeoc9UyGoO
 3dyElQ7ofq7DMJ+H0zvA8lXJ6dQc6Ag=
X-Proofpoint-GUID: M3h_Qs4LReN9kWIptDi485GPTwNHeniw
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2d98c9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1Y-dVNoqs5V1GzGJ_nYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE4NiBTYWx0ZWRfX7WhZV3+4vwnQ
 VC29MygCk7IDlLhEnN/o+UxAf4D5G2N8F/8ixib1iQ5XOitgkh4KuiSaT0XQQAyuZRmySDNwJxg
 o4eBFXGWGEgK6DevxyGw76IBCVCNPTic3bg7R9gmJwOsYv6jU0LW+gZiLG79+mhssTBZhtCHptS
 Tw3vYp//E0dztdynLUxwo7LKZQsttUdoEJbSeGD0uJMpAMUrnoI5t6J/tVo6ISIzZVqAaqStIo2
 C6SA1xU1VFP9dWD309/6+YxqGwp577322Fkf/mfJRx7zg6O/jg0H1VJ+L6oyd5gwEVhxfw+f5kf
 iQBajI9F8YjJuDLUhleyR4zfIZJVSZT71uv0gIHqMVSvcvWxijWtVH277cukPyU2GgRjAstqk1B
 gllOSWOOuTWszIRVoYdLRMovRuF4QuYu4mez6yy+msh9pNssj/K0BJ6FcID0Cy1Ed3T8opMkCj9
 VZEZLW+3LPv6g+/9Z0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130186
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

We mandate a compiler supporting C11 since 2021-06-15 in
commit d22797ce36a ("configure: Use -std=gnu11"), thus the
max_align_t type definition exists. Remove what is now dead
code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qom/object.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c1..f79b2cf3618 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -675,18 +675,6 @@ static void object_finalize(void *data)
     }
 }
 
-/* Find the minimum alignment guaranteed by the system malloc. */
-#if __STDC_VERSION__ >= 201112L
-typedef max_align_t qemu_max_align_t;
-#else
-typedef union {
-    long l;
-    void *p;
-    double d;
-    long double ld;
-} qemu_max_align_t;
-#endif
-
 static Object *object_new_with_type(Type type)
 {
     Object *obj;
@@ -703,7 +691,7 @@ static Object *object_new_with_type(Type type)
      * Do not use qemu_memalign unless required.  Depending on the
      * implementation, extra alignment implies extra overhead.
      */
-    if (likely(align <= __alignof__(qemu_max_align_t))) {
+    if (likely(align <= __alignof__(max_align_t))) {
         obj = g_malloc(size);
         obj_free = g_free;
     } else {
-- 
2.53.0


