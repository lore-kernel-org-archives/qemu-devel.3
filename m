Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2753BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgxO-0005Da-VH; Fri, 03 Jul 2026 12:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxN-0005B6-6Y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxK-0001gZ-NR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:41:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIe6s493435
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nKWbeV6dy1QzTcg2r2krTsk35PC3Q8z5Zx1L07HjdlQ=; b=Xt0+zM6rd/z86fTx
 pD5BI31ktDWQTGKGTsF9jXYsJkGi2oB5CgqZoYkUKEaxBcDGzmw25RonK72I5BSV
 A+8vUlbqkCtu1g2C2b6JytDM3jkJagYV+IXLcxJUVlxZdGyZ4aIzKZA9x9cDkQGR
 kjyZGIzrTbxyLoPyV1fADhRmDzSCE7uiFpyHKDBSX92CCQP2VGfXvYiruYJXXBSd
 9/8vKVeqmdMfTmBG4yccGaeaVKxSrj0ZxoA28yEMPd5By0bZ7qnGIJpRda/Jea0S
 zykNApze6MRsQi3MGoxgIlegf7sVFjmIWL6izK4bVHWsZ4ryWpSzMqcSGFACLCMH
 ZVay5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u320k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so74197085a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096882; x=1783701682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKWbeV6dy1QzTcg2r2krTsk35PC3Q8z5Zx1L07HjdlQ=;
 b=Hx5Mn9hhRCyhcdjo3Q1oOZsnr8z7PPtBPLRBd/ZCxAs48nTUMqrSql9Dd1T2PcXWde
 cxXDHOi2s8bwGOwgOtVAhzdDntNPTaRR7RJxz6zTooZfDpTT8EBfFEumnmYv74XoEHZD
 nECm87ecb+dKEmXXVCfYFHqJYC6LSmyK4xOCC7ipesd/xWxO1/Gte7fwYaUZDZLjwRNl
 ARRBluaC4OVCmKkxI8dD5V0AxqFyBTXbIXL3r93pQ3MYyFI8aF+SKLtA2FX02GyT4wR5
 chLoi0GaGqPuOsOU10aYcRxOejTUTaGIgioVgNKLtYWyjWHSrt1n8oUYE3Vbjys3Gx0K
 j0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096882; x=1783701682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nKWbeV6dy1QzTcg2r2krTsk35PC3Q8z5Zx1L07HjdlQ=;
 b=sO4ZpSvGCbZ03v7tlWI++VZGX7FqnKVUZW9Q4Yk0nI+DKRFzM5IzCPW2r1NCJimRJz
 Ub8k3kxaAYMXE3mBTwGypPU4GfLsKjzSyyWOgq19XsVhEz/fipnzvFL/MJQlqx7x9/kz
 TarYKmfL8rcY4uopr8UmNfiOfQhDqa9UlcPRjtOOTwA76kWvn4F2veJ0aBBCRiTHComS
 H3EmCvtpSOQiprZEPyyj8zSomuK/cPOvz3A+NqZmaxleRS0BCV7FxsHMjd+a93R5Kfsq
 6J7CrgMW22w/wdWHnhm0gBHZfT6jwXuUULgqTbhMoU/bmUQep8KPWVX0asmhsjjuPyhW
 b9Ow==
X-Gm-Message-State: AOJu0YwL2WXqAeKkZ/AdgCHq92T+/3+e4EAmlKYs0mXBTWlTetkzbHX9
 TbW1iF75GznUvqO8uJ18HS9lTd1kE7+J8yPDnQfFhwotUljjxWgvkuLYKeGz4R0wc5YC93cArll
 3RexmBCayJsh2cVfZZz1HnkqrEry8anIQiDD/zrMVhXHDFU179YgmCTF6jp0++g1wpA==
X-Gm-Gg: AfdE7cmq7pknl46MrPoanc2KOpFbceYMf08vzQ23Cuf/X72OBDHKe3GGIOtWjZEhalv
 j8AGRRw6dE/X67q+HBebYMqW1veMS9iW4YysKIb2ucSUeXjOJ3pn1JPcAoCEgPoYSK2Xt5KPsTX
 saGZFUT3IF5Ux+pIYzDVHe3lVvEarxoC9fv0gKXT7Yfs82mLJ2YUCgvHQmPWPDiE+Utd/5awiab
 YnNMZC+ym8TI5yQsslN8UABo1uBhCwK8QUxmW84RRLtPlemDoGzhvcd1udjv5xO27RJpcsAxytQ
 jnM3yQdJg/7sYzRs6Gscq27WWrNIyPcp5/MAiWXu4Od/UflQ8BB1/U05nPesLowA9D4AQZaA+NC
 6NY22oXouaMIyX1c6T5Ye7ShW8OhoMMDq6CwtPGNSkF+V7O299X2KIQwnlebrQrUiyYJc
X-Received: by 2002:a05:620a:2725:b0:92b:67e6:8ac0 with SMTP id
 af79cd13be357-92e9a55d8b0mr21734785a.74.1783096881522; 
 Fri, 03 Jul 2026 09:41:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:92b:67e6:8ac0 with SMTP id
 af79cd13be357-92e9a55d8b0mr21731285a.74.1783096881108; 
 Fri, 03 Jul 2026 09:41:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21543sm479637f8f.35.2026.07.03.09.41.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:20 -0700 (PDT)
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
Subject: [PATCH v2 27/33] target/ppc: Ensure TCG is used in ppc_update_daw()
Date: Fri,  3 Jul 2026 18:37:50 +0200
Message-ID: <20260703163757.55500-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7Wq1JZGjyal_CQf9GienCsJYiODstNK6
X-Proofpoint-ORIG-GUID: 7Wq1JZGjyal_CQf9GienCsJYiODstNK6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXycARF3tFFuao
 sQnyLrAZSnGxnTBCM3dvdGabHQxmfhPOKyxqdH5W5tq6/3BgtOuaPjKUpx89YsYYZ+9IW/8ugH5
 MxGHiEA/MBOjKZVnB775c41/Ga0Dbo4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX9i5/5d6+AJsG
 iF1tMWpKI9leTAdTjHs416ry3XKDU/z5D/2WsJxhnQSQ8RViCW2j5/cFOQd6K8C1zf60w1V1o2J
 8xfjNm+dx6/gjWDAMqSN3WgbB+RuNilltTWUQ+J7tfIU+BQe5fD4RDXx35rzEYpsm02q/iLeQlA
 gBCQLPAEbvW/7FXuuiy21LPKcYqySahGYdbgX10sGIllDIhdsVmFG9MLPCzQ14RCNBEIzkum0yf
 UxLqfMowEiYZc4PYJXU3kZIMoTZVRGW5dEjlWbu8TNEs6Q9rt4hXYl+J4X7O1qhyAm+rtaz0ayg
 +gOqZ/hsbc96b4yS0Ko7U0F6PzXeM4HbmhUVIPSDXWbWWzdFcPlZ+UxK41jUld0sbVhrIhBxSfw
 yL25lJeYk4oq//vTdmRdeV5zrZfRId71YvxNVt7LVentbA/phqedsD+ihmnBUoH2H9ELW30+//3
 xrDWNspo5yQ1l8RzjGg==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47e632 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030164
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

Per commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug
facility for v2.07S"), only TCG is implemented:

    ISA v2.07S introduced the watchpoint facility based on the DAWR0
    and DAWRX0 SPRs. Implement this in TCG.
                     ^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/ppc/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 913920d55b8..36e1209119d 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -147,6 +147,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     vaddr len;
     BreakpointFlags flags;
 
+    assert(tcg_enabled());
+
     if (env->dawr_watchpoint[rid]) {
         cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
         env->dawr_watchpoint[rid] = NULL;
-- 
2.53.0


