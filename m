Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78F606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KmseiR88;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZUN3QzKs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9OZ-0000Oc-9g; Wed, 25 Nov 2026 04:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9OH-0000Mc-Pq
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9OD-0002Oz-SJ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:34:11 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP68TuC2629330
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tq7m8GgsrZaxy2p2SyW9nvqXr8lJDtZUV1HZqUs5VCU=; b=KmseiR88Z1MV5dC+
 wHjSFxhXx5sglb74MbIQuFeKMOIGCfdecu+3WHOXu1bbkg31WMrr4deWzgMqEl1U
 xdY6nFUFAs7dpP0ONQgoDxGmPai+RrOLQ6Ecc0yKzBeqU6EDYWa+HvXCzcskkz4q
 yiM2JtahE5iEoyjPXq4LpeVeBLaqPNhFitdf66EBnRsykk5D1qoGXwuak+fZO1Kh
 qRMbSdZRypjwuO1Q6eL/XTHn6PQfn5xLluFc38W/K838zG0Z+y6G0MShcNDd2rnv
 GKgcXmwJyf04gyXHa1T4f8GVBvMdqTdmkRgOHBAoLf2uhPddZvEQAJcr8CDasEyk
 phBgOw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydbf4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:34:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-946038e22f5so149290685a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795599247; x=1796204047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tq7m8GgsrZaxy2p2SyW9nvqXr8lJDtZUV1HZqUs5VCU=;
 b=ZUN3QzKskQ6IEZhtOPNA63BsXl7lAvRE4gRKbTy/jNQ5TmnC6zsthR9pQwMAjBttxV
 KyRPiaCiRUxgfaFpqyJBWGj0vJ3fxhxZPV37CCdSivw0kZSnxbc7xoug/KJGI8pUABtQ
 f/212+LAqQvc5UWJfSx7HfdoRpzyjQiCQx0UH7Z9pw8X27YdLaZQPhlAOiac778z3gft
 wRQ093HazUYbLwLSuUdMMckYMprr5Uaj/T0AG0qKVH02lv8lGWV7WMntyGOcCZlxTcKv
 jfe010qh+xFsaNXPtrNgOSIQNuhwVHdFwiOU4ETH+A3PRZ+14GD6WLlNu2Pb2pxMI9bj
 LaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795599247; x=1796204047;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tq7m8GgsrZaxy2p2SyW9nvqXr8lJDtZUV1HZqUs5VCU=;
 b=2AlGVQuMMt61wxqiO8B1sd/GPMf0F2Deq4rjtV54lmcA4gTLRANtEn1BiXKEYQ3oY0
 gYiQhLvrzFlslcE1Qeh4eV4GlYyH7XxR3dDHgk+FKMCkazlc0T9oHs5xs+RPJ18c4/Nb
 OlA7r9PXXzgtjKBBKl76DIKZYyAsHQ84cZD6vlwsWfny5H20TorNk9Hdi9FNwBcn6nFv
 bqUpWlC2SGrDwA/auyhlChjP+eQevi2qBk6dvd/FhCrfha4a4tSBqEkL3M3FlovFWwJR
 K0AlqF2aAv9jDIs0AS7oaM3NgTr0dgBkFXDj36uM5cxqlQaJq7C3Rk1k/yex12gUXHtb
 jQKA==
X-Gm-Message-State: APuU4Z+PpRBl9BAIqNoiU3Cle1EceN4oOl/ylAEGei+oguhTDGuK3kL7
 +F+wab8Md31ZhmirvdIsozQONV32aMV7vS9xd21+lzZk/J25Jcvh8QncvoWLk9JqwZBJqUNd0D6
 hAZfJsnRZn4DoJCtOWCl2Wved+5r/EDtI5D6p0NxrwixHXUdp/khg5R3J5YpLetaeYxcm
X-Gm-Gg: AZFdTZfaw2mCwzxcLkxV0YXa8rJg1dCsRTYTe/3dEFM5mdEmn84G0XzgmvfOQum3+AD
 hsMp3TnTZzk1eLs0nOUBOZKn0Ov6oqOeEp4S4JzPnUx414X8L8xrRG5JdCnZtmelt8h3dGdhlSD
 sI8Q+Whh/t4esmSe4UtDaO37OrkljgOHFqPATtaYelqLX/+KR/5/7qxteynxOGIYjh//O+y7eWf
 mHWqa0Yg6BvvRwJg7UWy49w6KbkJCZBTTcyXcXxghld/xGD+mKR6603VEdO6TNNYJgcJ3Q/IL2Q
 4w+/MNG/zyJF3GiBHiL867I/xhjheB19gerKB6v5rb9GqIgBHT126wuCd/uwUGQ2zKVSVrO2dpc
 fOFuFkaV+4Lt7FO5H60Y2qhuL7X26sXC0oBtR1HFfJrURoGqHTXfFkKJeBCPH9UuMaYPy3xi7tc
 usKSD7GFUbNxz+FA==
X-Received: by 2002:a05:620a:19a2:b0:93f:5f83:2ca3 with SMTP id
 af79cd13be357-949bab4704emr2839759885a.54.1795599246706; 
 Wed, 25 Nov 2026 01:34:06 -0800 (PST)
X-Received: by 2002:a05:620a:19a2:b0:93f:5f83:2ca3 with SMTP id
 af79cd13be357-949bab4704emr2839756785a.54.1795599246279; 
 Wed, 25 Nov 2026 01:34:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm32607909f8f.6.2026.11.25.01.34.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:34:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2? v2 2/3] system/memory: Return early if ROM device
 mode is unchanged
Date: Wed, 25 Nov 2026 10:33:48 +0100
Message-ID: <20261125093349.97805-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125093349.97805-1-philmd@oss.qualcomm.com>
References: <20261125093349.97805-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfXzsc0CyX+kZB6
 y3RRCb9eQuWkpaqYHGUuGTNqR8+VzCtlW8gAkRXLkqXN4lfedowkNfSkBLeJfkRZc5HjjmHfYE3
 IdIVFWFwY6MOp2XHlCR4SUpaOkgi2wc=
X-Proofpoint-ORIG-GUID: j5bdZ_Tb6zB1RdvKcvHDH6jvBqAlvusQ
X-Proofpoint-GUID: j5bdZ_Tb6zB1RdvKcvHDH6jvBqAlvusQ
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b06ab8f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1CFXEIgG3j1LX4AiYtgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX5D89n0H4w1hI
 2JJpdWct10cxgTsaLh9QCjtwqBwUGlLnk2T6PgMnYJ60ARpvuZhJ4y+6tNWcAEKvTzGFLQSKlnD
 GQV9nCPQbZZ4wUNg+7FQ6hlcalj07yPMANGdPiffam/9VAXhuh8ivImppRRUplgMglTc7RIpsd/
 v8+tnMBF7pZcZ74IRuBa3cwilQO8vUR2DI06ilK8K4DH4nSpUmzD+/j9MvjiFfOX/w8zxcPnyic
 VGpfnYS6ofEZ+sZXF76I7z4xxsKzJl7o+r0yTwUwFHnYxIlnejbsYpg9T9pA+XCFZPAdK+y72UE
 VRr53e3TV1PQJyCg9rS6GsRzLAPF5S0t5g7fi0WEAoHKlz/OuMJVqgWzet3YZqv34fuCun7Sutp
 jLKtsizHiyuLht1KRn49gYH1y3RLolMkGzvD3Q0UVobwIv51aXfw3RwlnU1GGEgftz8K6R21tyt
 Py11CAUXuSjurkCBuUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250037
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Restructure memory_region_rom_device_set_romd() to return early,
easing review of the next commit. No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 56c5dd6c8abd..2e3ce773ce97 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2251,12 +2251,13 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)
 
 void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
 {
-    if (mr->romd_mode != romd_mode) {
-        memory_region_transaction_begin();
-        mr->romd_mode = romd_mode;
-        memory_region_update_pending |= mr->enabled;
-        memory_region_transaction_commit();
+    if (mr->romd_mode == romd_mode) {
+        return;
     }
+    memory_region_transaction_begin();
+    mr->romd_mode = romd_mode;
+    memory_region_update_pending |= mr->enabled;
+    memory_region_transaction_commit();
 }
 
 void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
-- 
2.55.0


