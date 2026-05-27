Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7058CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 21:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSLpt-0006CZ-AF; Wed, 27 May 2026 17:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSLps-0006CN-ER
 for qemu-devel@nongnu.org; Wed, 27 May 2026 17:30:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSLpq-0005ml-Ma
 for qemu-devel@nongnu.org; Wed, 27 May 2026 17:30:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKm3wP2621904
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 21:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=CqB1xMbLKj7DQoKxOgwdUA8UzFCTd03gypt
 9mrTA3jo=; b=FlVjvZEiwIYs+mWOQoNYDa3ZOLwJTSJrgD26NYR/33z2DyNYegW
 jFvraLeMHm3Oale86aM79I9gVmL+qGoATM9SlOwHYjr50juiI69xnR47tWx/9epD
 h9vyq2ynX3ztx0kvCkSAmcoEXZO+/0/6LNc8dEEzfV9AkFrYePB9nH9pztcPBW0v
 HK+O7lYed1uYRoqU2OsBbOJBYWEKhpWcmTf3trC6mLf1Xdq/jtcLwMUPUiQSJuES
 wvIbCwfcvoevkP0p8pyHZ7ljJpXppat4KDdBB3oWc1WsydgtSjK0uOpGXwx4YR7Q
 ITj7j4/YL9j8pOpNAA9/zz7cA8t/ey1SyhQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yf05wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 21:30:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90fd6eeed3cso2667485085a.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779917440; x=1780522240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CqB1xMbLKj7DQoKxOgwdUA8UzFCTd03gypt9mrTA3jo=;
 b=U9pS8ES8JYEUsu6D13rV1U6rnk8j3FQPmEe8HYQcyJ8QAE8dU3fhJtiSuKZur2KtJ+
 U9uOnexpFxCiiFUSZsFnCHhrlF+KXlQbNLRisKCPdBmfFh+liyU3WKTuv8hJEns/nTgH
 NAvgyH/YeWaCUNekK705Gqkc7M5j1PIJhfuTCtfc/2a9YSu6kIm8WQCrJXmv4pg48lVp
 CPuvj6mMqSd8QRA+Iw7EE6VClA8u5K9/Tz9UwQIf3C/EaMB9al1p1IoqhVj/xpeL5ibd
 QmQVJo/GouIhC+8xE1p++NmJPZPELAsBTyoZWcpn8kVcX74h4iCpxakaGhuP99v/SRQI
 7DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779917440; x=1780522240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqB1xMbLKj7DQoKxOgwdUA8UzFCTd03gypt9mrTA3jo=;
 b=ihXWgDlhphwIFDe7TNi9cXfYpNMXkrm9Lh34zrxqK5YBXR94wmjTue0yhxasrDBcIR
 ZPIGY+Q35GkoJlKgUMuNexDImj1ZOY8HJoZC6/B9wtIZM/OGFH8T4yXjJhIf3qLOIYeB
 qaSNgHTTtHIu3NToQCcRj3e6zo0IgYkaW09RfpOPYG3IooIJ57YPUh95HKfCLACLTe5l
 wLLUy3OoOYPkcCeJ3bk7pxjVc8LAhWd56ktBsGXOQYqdFVK/wlZhMJgiojA09WeBMhDw
 k5XDQcOTx9nIuqoql7aHMv/yYff8vGWgpcVN7ORPSoTuag/olkjILF7aavk++d8llpVf
 kTEg==
X-Gm-Message-State: AOJu0YwpqPJlup+ntKUOtOQ4jy6jCGDxBoqjmeEJlTCJXyi6EqBCJa3Z
 ee7XjEqSoD19aMBnxjC2EdBEO9xEG76ZAkx4iuQB9/enbKUZx628okZI47/+fhOP/lVfR+xp+2/
 gTfUSma1Nt6PHC4tJ5l9L8TOuERxTsFUx0rFEoFd7IaX5+M1RuY/VQD2QYkHgZcLbzQ==
X-Gm-Gg: Acq92OFdlR0tYKtljYEu2uLWRNuh9A2RyKyMzokjW8+ELTPMmaKlHTk1XviVPqaerJB
 J3Qbv3HkQ4M5pxUuLcbr4IyWsp79UHyRfcRRRZs78Ll2lzHiMVa36yV269vLTYha+wkrBYLIxpn
 QSSn8K3Fdj8rpnXy1AKY1FFEv3nxhzhM/aPNqJ2r1obPnoog04IzyWARdFiJeJopYQdZaqJJxaN
 r5QoGRqK/HIq35WOAsjXLZbfr5YgDcZQJD9+LJj5QhHPdQvC4oZ0uHkWJDRJOCtvRyWVDjQ6oGH
 ClkwCQwCxz2JUssoKddQKZ7tDpcNL/nfOnTpE58TG9bCRNAVBDizxNcQGJoU6HdVGbeYNYdaPPp
 uSaLP67drQM9+7pbt2dkOE42saLzNl2B9jscZbQNGzuoeuZhnUBsVjbnasFBbnYgPl27+zg==
X-Received: by 2002:a05:620a:7106:b0:914:ec97:5457 with SMTP id
 af79cd13be357-914ec97563cmr1695067585a.46.1779917439724; 
 Wed, 27 May 2026 14:30:39 -0700 (PDT)
X-Received: by 2002:a05:620a:7106:b0:914:ec97:5457 with SMTP id
 af79cd13be357-914ec97563cmr1695062485a.46.1779917439353; 
 Wed, 27 May 2026 14:30:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86e8e1esm597003685a.7.2026.05.27.14.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 14:30:38 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/tcg: disable svnapot if satp_mode < sv39
Date: Wed, 27 May 2026 18:30:34 -0300
Message-ID: <20260527213034.2094103-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uxbBsiWI0dqHET0QCAVEtKjb1Sh2CZe0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIxNSBTYWx0ZWRfX6V4pc9Owqd05
 nVy2WKN0Ql6matYQ5np0m+SRitbdhgmosQjLaHcXcj43eeDxydbtHEKWGKgx/OW2+h4b8fNEj4O
 aLTWxfzH0kNltmRuTFpkdpxX4nM63Dki6txNTbYmdE25mwGYo1Ni8gXDNN48nBuTqT13StwsqVT
 SEUndtzWvias2drkWAPpIRcTGlkl+IMHJnGcyOSNHPT8KKm3Iky+C7n0nGjDmSF4sJCbdpsNtYm
 +q7KaIBEkw0OgG+/dcUHCGSUAhjCjFSWPNjYIzPa7auH+/zcLhfW2+Zb479Zl+x4IUjvDJVr0UE
 NHkmn/nzHaUJz6EO3Y828TuPAFIUMJDZaGR71zZe4Plc9vuMyzwyghkI9Frj7Y636NSggtAyXKn
 /cLNVmJ1emFcYScLrmZoObIAPKKC3ySTdZqv1qIyMU3MBiBt+u+tzOgqR/IMASejx95psFmFeQM
 r2BbvKwXFafO9ILYqow==
X-Proofpoint-ORIG-GUID: uxbBsiWI0dqHET0QCAVEtKjb1Sh2CZe0
X-Authority-Analysis: v=2.4 cv=G8gs1dk5 c=1 sm=1 tr=0 ts=6a176280 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=U5OZoxK2PpUL6kWutoIA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We did a recent change to disable svpbmt if satp_mode < sv39 that was
discovered via a gitlab report.

This time we don't have an opened bug but the problem is similar: RISC-V
privileged ISA, chapter '"Svnapot" Extension for NAPOT Translation
Contiguity, Version 1.0' states:

"The Svnapot extension depends on the Sv39 extension."

Do the same thing with svnapot, including the user warning in case we
try to enable it without the required satp_mode:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
     -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svnapot=on
qemu-system-riscv64: warning: svnapot requires at least satp sv39, current satp mode: none

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f8b2f04a94..c3006bccb7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -847,6 +847,16 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
                                      riscv_cpu_is_32bit(cpu)));
         }
     }
+
+    if (cpu->cfg.ext_svnapot && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
+        cpu->cfg.ext_svnapot = false;
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svnapot))) {
+            warn_report("svnapot requires at least satp sv39, "
+                        "current satp mode: %s",
+                        satp_mode_str(cpu->cfg.max_satp_mode,
+                                      riscv_cpu_is_32bit(cpu)));
+        }
+    }
 #endif
     /*
      * Disable isa extensions based on priv spec after we
-- 
2.43.0


