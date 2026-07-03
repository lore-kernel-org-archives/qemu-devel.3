Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB5C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiIU-0002lz-7x; Fri, 03 Jul 2026 14:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHv-0001mD-H3
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHr-0002Ls-Dz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Hibmi494915
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3BK6l7CNgDvswOy1LpRrU+K+UWVw7uqj4vj9ahAbVOU=; b=g4Y3P3CadbpzHLzM
 jJk1TWEegdSCQKvPKsBwy/eoOjZ/gmTzxRj+SuOa2SFLSXNzI3DlMcs0p5oLgXMS
 CoWZ1CDlf+ODEFXCnjLnW18afRS4jNgxJ8nPbP3FR2h0ti44bBFzdpDayKOz1VnA
 ev9xwxpJhGthBJoBgxzlXvOoxR/JAKdUatEK1efa57qAfrfUBwhC8SjF04XTMv/+
 aVy+y96VC/eOtjBrzY4XGt3T35+nV6TNcX2le1/lryUCibgkPv80RCkIzsPZglh7
 NCVM8FNcyYQyCmJKCEb/XQXpRcaedmBAvqZm5dL16ThS0hz9+YNwpfO5GxK43EEV
 ldXSIQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyta42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so19573931cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101999; x=1783706799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BK6l7CNgDvswOy1LpRrU+K+UWVw7uqj4vj9ahAbVOU=;
 b=UUk+YyFsPKJFL2WugJDKi7GiagPIWw4q8cjLavlPXgMG9QXxnM3OJGfLZiu1eV+F4a
 qixSUjuXXecVcj8YdIGI8752fTTbaQCkLXc1fWT/VmgHXDk1NZJ6wYlaQteBp8AtY05g
 OduJtg2ampK2Oabkq35cwUcikveq/JKyxtgaowu+n+fmPV6JX7Fzih13nC3cipiV8Sbl
 ox2StREG5TFsnhMrUw12G+xNSVpIA+ew3IEYGYPmfvFzfwtqkBB5w09jOcRRA2GU91lh
 va8mm/TQwNIu5vo6PdvTFVtlfm7Oiwd9nizBdupvOsvOh36z7mJYfDhQoKy9rdh8RPAV
 ECVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101999; x=1783706799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3BK6l7CNgDvswOy1LpRrU+K+UWVw7uqj4vj9ahAbVOU=;
 b=N63a+4sX76S1Ck2mibrOmwq4QnaKBjoxUEoZzQbIdhsfU2SSY3TZZsFgg7MuLiALW4
 Ae+2wc0tmgIG5ZMOX4Cmje2jld+KBb4oE5BtYjnpOQW/JwTnr7jRT9HRZKg8XfVDqMKS
 9vLvPg7z1zQ8ReK+VXkG/Q9bHWxxTM5/PBOhFXjytcH3/OkHzuPknULb4m8fCiAywQx/
 R8RnxrQvkj9lzFogAXkR47zkFCHENr13SadAoatghcP/6oqLPhgoW6XBziyIUm1MY3R5
 ALyFuoT34lS/hRc54s+5J6LACR9H7kSWAmf+RmOf0mIv0c5OMzg9IHN84qEILRyFRi6r
 pJww==
X-Gm-Message-State: AOJu0Yy/LWrDNdhF268atkNmTq6Rgp9I6qYXy9j08zKK0l/ya8EYeWCs
 Zamb2CXpQUSmb6FCBrJl73VPgaR0WSOan/HiDRqaZKwREJ6flDkGnM3HUsFLqUf/Y6czqpI9T1K
 dxM8K3glvqTwo415ACw+9cka/QHfz0BdTO6CXCSQ1CPr+DAnUr5nYv5NZmZEvSx8unA==
X-Gm-Gg: AfdE7cn+BQtNCV/h89z2qa6PGQx5S85mP+pol1BBnqr1AFAXofcLJJVUMuVlWeSPT5f
 LRPgMaCRMvfk07aL2X9RFE99+c5T0PeHfu/3NsGCiQrncJC/MQAtcYZFt7hqxMaWVLYbFA41t4r
 rhvU91GlWIHvQwd+ueIPJSElBWBL98YzBCchr4pvlzXcOSb26pQuEqjK2D98GLl2MsmOAcoxpsX
 0R4Acqj7pyIwGk3AtDWBicxGelm2fINkihumoK5fpp0LapDNcRAFql11ctImHm1FkM0QuNjSMDm
 +N2guPY3G7oiU69/2VA8mT64REsy5V7tvsL0bSRSfxPyx+J7+N2R30bpZaewbnVipKeVBaEqbYs
 YWnQN5S2ZpkaYTgzNLf3KMZdQJQF8ss5zts7dEHP3JkGvqA==
X-Received: by 2002:a05:622a:40c7:b0:51c:c97:f3b2 with SMTP id
 d75a77b69052e-51c4c3edccemr8479621cf.64.1783101998758; 
 Fri, 03 Jul 2026 11:06:38 -0700 (PDT)
X-Received: by 2002:a05:622a:40c7:b0:51c:c97:f3b2 with SMTP id
 d75a77b69052e-51c4c3edccemr8478921cf.64.1783101998234; 
 Fri, 03 Jul 2026 11:06:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:36 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 18/24] hw/riscv/riscv_hart.c isolate tcg only bits
Date: Fri,  3 Jul 2026 15:05:30 -0300
Message-ID: <20260703180538.3346781-19-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX38KbRg+RlVYb
 4gEdoe5N6GXdNO6yywNqefcwgodCm3ar9s6v6Sv4sHA/ocZlp0s4L61Zh8vDdqU4DL0uANv3by1
 Dti4iolhYMDoumxAupSEAXmOBWVMQr7nplAU1aS8NpNJt7yuAXBtTnqSsstPwMjlPNFN0H8p5uZ
 fg1WEUsUfNXQroJlXQLGYlRsvu+9iLpxp0hG1iCSpl6HVFN0jCPCqF2QUlDTC9jCUBJrCIxXx63
 MO8GmdxFXwoI3nvQo6vCthlyBgbHuFeTtI6hkntVKmFSKoN/FVnxOstJefR+EbYJBiZeFsgJUgp
 tAPcCOjtWQ1y3iPRU3503EOt0mOo6xAK+3VW7XPUITNFovAwidUz6ZVZhKif9znCPtNfF1rOC5a
 +aKkpnQ0ZGFaYqU0ErlwJ8W3Lw/5mByz+ZWjpB7iL1Q0bAgRLl34+QUPsnm4/6C1aWlP8t+PrA8
 AD6g/5jMt0EEW6dqj+A==
X-Proofpoint-GUID: mBgHjwOI9QUEGJWJo_1jKwiH88ij2oAu
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47fa2f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=0nQI16K_ZF54athspwIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: mBgHjwOI9QUEGJWJo_1jKwiH88ij2oAu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX8tmC6sU3MkNS
 RlyTYaZ99GyNE7J00TnOWoxFy1nE5KFx53k9VmKAgfBn7qcMi1Ci7dQsoNWrbzE0wZoufzUYppk
 kVv4ByRB+6HMFCUSfYkl/7xJu0Yhnp4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

riscv_cpu_register_csr_qtest_callback(), vcsr_call() and
csr_qtest_callback() are all TCG only and are not available in
--disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/riscv_hart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index d1c7188369..747754be61 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -61,7 +61,7 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
@@ -151,8 +151,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
-#ifndef CONFIG_USER_ONLY
-    riscv_cpu_register_csr_qtest_callback();
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    if (qtest_enabled()) {
+        riscv_cpu_register_csr_qtest_callback();
+    }
 #endif
 
     for (n = 0; n < s->num_harts; n++) {
-- 
2.43.0


