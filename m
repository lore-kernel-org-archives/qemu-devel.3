Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D3EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguV-0004vA-P2; Fri, 03 Jul 2026 12:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguR-0004t0-92
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguO-0007mH-Rd
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIspo364972
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YpvyPafEgMLcx7hXhSA7L2Lp32OYcohxo8F966bFstA=; b=hi1M9d0c61tQ+hDi
 Sqv2US5XDYmfaIpNlMmDkvTuC/KogiGbyOS9f/N3UKN0iR3qJZM9uc6sO2Uck/cr
 hpapNXx1dUhWND2GR4YJE6bQT8WhK8ARQDALGtO+txQSTTaireFjEHnhbM4f50M8
 Klv2jOlhBYD+G+LJ7fL9cSjEstJtUeEMqD3JryuK1esekSOTe0lryxVP2q8wgjpn
 Dw65rIIfAa/cGjHCeUef9JxG6yWXde+me9UrQ8AGHsHkentzjtxTXVo/35opTcE3
 +ixckPECVMD2KF8RYsCyHuGzpmSwfjVfuixMndQ6lxfi2yI+eS5ox+K93Z55CA4H
 nh8HnA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02abt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so8441685a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096710; x=1783701510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YpvyPafEgMLcx7hXhSA7L2Lp32OYcohxo8F966bFstA=;
 b=QbYzTgMlrwTTJRIdDu1G/yB8Rioyho0uf4MWUJeVYT9t/tBat/EpYQYN6bhUJEIvq6
 0dJQJ0+SY3K2S3AIXYZkWkqvBT/Ov7JBaMF6h5JVEsqjx5pzj7CYQzFu1ORHBNqINILl
 MSLUgCwzR8mqmbFaM0Dqom8MuUJAI6rDq27Iat9OAohv8caCskf4at+2+89gex9h6Rg4
 wRbM7wbck7BKfAutQ+zwSE4ki9nCPUchfg3h34P1yLCU/++IiPUSTYLosHoeXybfwcUA
 czH7TVuq6URPLNw4xjka/lquwaxv/Gcx0kRCSKSfc0TPHL4cgY/mXYuxwNa3Zwc7ZMZP
 7Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096710; x=1783701510;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YpvyPafEgMLcx7hXhSA7L2Lp32OYcohxo8F966bFstA=;
 b=jtKaVKeaiXvulpIuMXco4DitrhPOFOatBSOTEZsXjzJ2v50el95WbwYxBOgv4uch12
 mwXVjEItj+wsvnXpa7/BC5nbLFYx1eIWZBrJ9GoHwQfoGwDj01Aj/xpc0W1Rn3lYEgkn
 QYg6NxmpBLpWMWrzSYcev1Qpyu+a6xe4GY4dTlExpQhRSadKBU1GFNzvaVbGTSisTQRb
 FoNbtu0xA6v0ZZxRJXdnTLTOmc5jggxs9KTJs5OAZ3S7UT9EUcdCiCWHTmMfATWvam+7
 7Oo3LnzglD0VuBB1aSusHOXcofPtlwBzR5p8hjiiAJA9ro7q3chLKfKP3kjalrOrN8Fr
 XxLw==
X-Gm-Message-State: AOJu0Ywwc72lI5J7p9/Da0tMnoBkWRjRfOsF4zlKQkfAEG+t7Ija3pvJ
 pxAJAo9izELxvp4NfXeNOhIccsg/ZaRWvoz7LuHfzViMK9rVB959fODxYmHWe3kexahaHrJRxqT
 5rFv6nq7ssH/kOOMqU2ho6ATwmdewDi2oE6ZKBAGk7vE9BJNBHHsmiKwLd5l/jtMWbg==
X-Gm-Gg: AfdE7cklDxJFZ9HKmaSpaRk680dFFGZKKpp7EpzA35Qq+GVBf0KDmvVWercyCpOLBfF
 eVLj4eQwR7nZ9V1uSiPzgZ2LYIUInuydXsoQEb5ovTilL99CzCBtnwOMJW4Bz3dVlgZsf1yxaIU
 MF09vnPpng4MISK0p3ohwSY2+fVHDd955hT4zp8/eFyLJUGGfUE0erP9zb8L9SRsPC+ZkliXzH7
 5Tg/dNi7bdYxH8HVZRwFKG3bG+3RqOHmyQE6lmin3HSYPl58BQplp5ck4xCLpUJ4+vapbhipYcK
 jRNQaBP9I9UD9W9OoVyWr2oPEUE5+ZoRH6U6g3Kz0lsjHKU5zJYrCWi4s84ee4hbZUrmKljAAK4
 GcBiBY/6EMAsETxcbYiRT2YyRyRFHOF24zh3fBIQDf1/TwFdfdfQjzlHMQl0N6VNqnoOy
X-Received: by 2002:a05:620a:4624:b0:92e:68be:1c5 with SMTP id
 af79cd13be357-92e9a34e907mr29642585a.21.1783096710353; 
 Fri, 03 Jul 2026 09:38:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4624:b0:92e:68be:1c5 with SMTP id
 af79cd13be357-92e9a34e907mr29639085a.21.1783096709952; 
 Fri, 03 Jul 2026 09:38:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm178703075e9.0.2026.07.03.09.38.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 04/33] accel/hvf: Remove left-over comment
Date: Fri,  3 Jul 2026 18:37:27 +0200
Message-ID: <20260703163757.55500-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: e2FTjXDMgGMF5CzYSY3LSo4rJnowyz8U
X-Proofpoint-ORIG-GUID: e2FTjXDMgGMF5CzYSY3LSo4rJnowyz8U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXyrHzO8EmKHRe
 ULxgesn8/0YilYfstsO7oTgyZjbnQyGLedRFREP1pr5nwiWXrrujdZBgoAwIIKds7PZmDWBVtCh
 8QJR2rAejyHAQXlbDclsOu9x4g9HSQU=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47e587 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX+hHN66f1Mp+j
 zpiXtXCbO70A5epz/uZdhr39D43JyZcRiUe5x+Wt6AsqF7bMvdqtoYz+d6/iHuIB8F1KW96px4u
 sQjdUBWsgeU0FccK8jaumZX36lSQzsnKSYYp/E79T/NNIOO5VdIToZc6oUlU0PWfZdwN8frFWiB
 W7gwDAhS9pxTAKZp/9cEZ/RCZOkduX+BVkY6FnGa2DfJyVLL7AQfMimVWTN98jiLkg0+aWUONrD
 b6hk+EwX1Z3qK/+oLRd2PKCucu4KFF7dsjARZWfcfGKuQj07ldGyY2ou9MB8X+loDSvsdP2eBZ0
 Fuhw0A4tMHl9r0C2mCI8EgUifdsKSXvSZp/dCNKL/FfNOlJ62d1gKWNROA5x2sSm2xIlTa1f7wG
 Ebxl7m5SnFxIdnXqWH/w3M3YlS+CclJCJdrIlPfsjZdinrIj3LedECSvzWbX13GSFZDMPbGCXrI
 yGhQR9OVXCWkxcWC3YA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Missed in commit 6bf331164c5 ("accel/hvf: Drop hvf_slot and
hvf_find_overlap_slot").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..dd2b45b7cb5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -62,8 +62,6 @@
 
 HVFState *hvf_state;
 
-/* Memory slots */
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.53.0


