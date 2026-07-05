Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5711BC43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrA-0004rE-VW; Sun, 05 Jul 2026 17:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUr8-0004md-Vn
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUr7-0008Pt-D2
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LSl8J2779466
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1x7QSxrq42ew5YZruERIhg8L4kv2+83eMIh0NOzptfw=; b=ks5I3CwIs3W9lqlC
 mGOKtwIq1Y4KPr+zaPrn6NR4jwcH/gBi613pzrwOfpFAimE5ZOtLRrGRYlbDy+YE
 C3oiEpnPDRsP8EA8oscKz4pxqFchWmseByGUfXAraOBfwk0BoKmmufTkoiwYKgdt
 Tya4vZES2ZVZ5PNs/lIR+FUj6ItlVNiOAWpok7Xsq9Td15vkDVTZfSgU+KDE4msA
 ZfFBPqPceyVtbimmlDZQz6c9DyNv1ZvAS9oWViWCkZTzbPERBRHA0sS2hG2UAtEu
 aRkmDjIe4GLsrGHeGprL38RSnusF5Rh/DsC9gI7+cFUejvjFu0edqWQHqce1NK9a
 RfRa8w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh3k6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so261536985a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288698; x=1783893498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1x7QSxrq42ew5YZruERIhg8L4kv2+83eMIh0NOzptfw=;
 b=EV22zYLf9eN22yln/kCT+d/xuWasqWu7PR3daO4aMb4K/evoMJDp4t6ollvcUl2Wja
 Nixw8j3ZGRlMNaeRz14IHwtrSKA3J0OHS5Uw9b7T7FPg6NNDuysVnwJHLUJsFGj0ESQm
 0jDBmtTKhgFSUy4eqbQN/VGeqB5IalTBYlz3p3/uvdxAM6+F+RSKlnKliwJTVntIeAXK
 gOjuIahzN7fPLzH/D07SYID6rlGjjf+UtZE/a97dcW6o4oL4w/DjbWKti1qJ4uSuYKow
 2kqe8u9fhXvVtt1sNreG1/8Kvs18+z1Bh9+voa2SnM0i4vdbi6sbFvfnruNjOA3wFnsE
 WJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288698; x=1783893498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1x7QSxrq42ew5YZruERIhg8L4kv2+83eMIh0NOzptfw=;
 b=rdoYKl2ADJRXEpb2Q55ygGxd4lGY7f/6sJBZ3Q8W3+dRwBeXgwaS05qcw2qjKCtOR4
 sjoc7/ucIuyL+d/u1f4C/LzQRcQcLJk3KL+gSsU0lt9uCzKs5Tl8BVWAnCeJyKXcKBGn
 /1bVGEXAjaNugJqth74f9Vq375eEPUOdWaJfBOcfYhQHTUkOs0HhmElasooCgQt04MyB
 OJHnZCpFca2qZm0fmnaZw0zKhWTYnlckJjyBrBxz42cWhRySBOy8lQ0BQ/KNpqCZZC0Y
 xRAk3ksoaVBpR7nUdsBCB3zZDBEvYm5vZay24aRsTBw1xQGHkmvrXji55uDMivUNR1Sb
 1x9A==
X-Gm-Message-State: AOJu0YytEEGf2k4DbzblgQMgUNB0pmGLFc55IyuRMUZSL6pGHy8/jo1C
 C2iH+M/nuP7V6FbIFtUvptJrDBhSzsPunVuNt9RJk/o3vqIpEgOA8HG8SuG9D3OGSwl7BByBd8M
 mXIhxciCjt2SO7nj4iEo3TgvYlgkw593K1zmu6mggypCYSDnwp7JmmfdX9odHlOFZFw==
X-Gm-Gg: AfdE7ckn7PnU3ucwRWt3PW+XYSBRsOK/POwiOY7zVqfPE0b9rUALhdQrrD4tdgVH+sP
 uxua0Kh0n0kZAkQVXPKRLIKIIgfBYuChFDNHp50A4F5wCsdhOuUZBsGVv1W24dqfBnjbyoQFNgd
 zuY4EHKaZNhjNj1977Y8ttYRkIXUgTeiqnBLqQU4VxClWdnmDiOv3CehVZj+ljvw4VkH38yU6SX
 kKp8qW0YDzGXryT3ZNo+KWY6tG6cPy1aCrBMn8uSz+7yf6Bh8aPakx8Qvjku4e1baYNBy4dhubo
 iZEjUvPi3kfJZNLGP4rSEzczk6LAzAM212iCPkuCTnnD2K18i0TDlCj1M0D69XuV/wZoCR1j/qV
 ElKJWy7oCTNHcPQlvfT+cfbUT4dlykM6+5dJwZ2bxDBrEttGse8df3g==
X-Received: by 2002:a05:620a:29d2:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-92e9a35a422mr1067136685a.12.1783288697862; 
 Sun, 05 Jul 2026 14:58:17 -0700 (PDT)
X-Received: by 2002:a05:620a:29d2:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-92e9a35a422mr1067135385a.12.1783288697456; 
 Sun, 05 Jul 2026 14:58:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cfb6f199sm205985145e9.3.2026.07.05.14.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 06/32] gdbstub: Add trace event for STEP packet handler
Date: Sun,  5 Jul 2026 23:57:02 +0200
Message-ID: <20260705215729.62196-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4ad37a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX8U1tuLA/rV74
 X0PHBNln1DDhdtwo9wPJFBWSosnZlpTDgRY8gw2jlU4VYNjClwV0156EYxV/4xXR/gYMM4SV+9D
 i2s/EIFhWjINQWEMTp0vTbkw5yJmiCRYoNRiq0yb62jqdxa3qP/SOOS3Agp9qKyEY4djd6azOgZ
 o7sUtsi/HoGepKRjORhRHGAmRXIm+A72cf6W4eJHCLthuwXIIEhWfHgBiXGsokZioGLk0hslc9X
 rLAj8UYCi2zdkNP0/4lETDNgsIwSuAQpa5Ywzo8DzxBQ1FmldjWYs//xUuzrvma6YbxsQmXUU1c
 f52VXqoFracVy9aYNYPbv54u9ae2+7jPBJ8g0pb3c+cKE6HYqnVElBVG2NQwjHXFd+CTNLINlRU
 K77f3nxQhMgRjJ/nlH5QB0lfC2KnwaPVyZTfL6UfbHelx7XzxBRbZX1h/vnGeGKFtoVoaGtls4H
 7X/To/Z2H+q43I6niBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfXzrQxW+VdBgIz
 lUDPXXnkTSnmQPDUAuHJ5NDPVr6LUVSoR5A2oOjNaqSIf3HH5gnNf9g04khXlOxq0QopO5iL0A5
 8tAwsTBhjuGMc/Oj100m6pB0rtctJ/U=
X-Proofpoint-ORIG-GUID: tCnKqK1r_9fs9TxpPs-ZyoJagBqXYDIK
X-Proofpoint-GUID: tCnKqK1r_9fs9TxpPs-ZyoJagBqXYDIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 26366acb674..246e7746300 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1369,6 +1369,7 @@ static void handle_step(GArray *params, void *user_ctx)
         gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
     }
 
+    trace_gdbstub_op_stepping(gdbserver_state.c_cpu->cpu_index);
     cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
     gdb_continue();
 }
-- 
2.53.0


