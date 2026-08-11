Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAECC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJq-00083s-NO; Tue, 11 Aug 2026 14:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJh-0007aX-Nz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:35:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJd-0002ae-KR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:35:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGOKeI859118
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VrfE7e/OO/Q4kyhaEr9Sc92fr3TG41A1jbOfCVVmhYI=; b=DelrVk38tz8OQPkw
 hIN3iyMJZdKKV4ZWDO0CiO/L1/LbBKFv3Sf7C6UY/5BD0eL4wwZh0giVIWDp0y+I
 v3cvo48k2KycEaELWYAYJ+9fKMaHNpq6DZsWgkNJobqvgNZ6ojHCsBmukNDDUg1U
 /W4+CzW9BC27JUxo6PVWHqLdnSsrd72U3+mgM1upUe7jS6r7bQ6DCzihZRFXW8mw
 dOP8xWO+vvq4ANVT4j+RpHHuJD+xeWkhliWxOjsVWXlvNiYuld//00U734LQCUzR
 wRQJFZ4uW+wtoQMGd/oc+eyatJaas7/GpQWb12tpAMIEnlMdynXxFwKyh7gVOQnM
 xZaMDg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mhgy3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so3356061cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473298; x=1787078098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VrfE7e/OO/Q4kyhaEr9Sc92fr3TG41A1jbOfCVVmhYI=;
 b=BTftGAjZvfbz4vKev8AzS/pD41gt6YZhCO/vPG4W0tkmUvuA1uZ5RTpEBn7mlYdWoP
 NsfvkSp+1v2nPnWTMEBablxaAgVLFBdMjzkM/jjkp+ldCTMWcAoy6G4BvrJ7K0EoKctr
 VUCSerOXbIV/xggbquM7x58U28j4VeZinjt93zOpjER4o6G8hRZC6RIhoCVtcq5hWzyH
 fWF0XGIBFwL0IPCK9aUJRGekt1cJZbICL17MEugp/FyGEA2ZHoCXJfYwXnTlZfT5Ys6d
 e9G9CVeRzkK+pbSY7l6N2w+8PTOvp4zcLRlnppvHD6a8v2diD6dck2WzWW3kUVOjm6zu
 pqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473298; x=1787078098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VrfE7e/OO/Q4kyhaEr9Sc92fr3TG41A1jbOfCVVmhYI=;
 b=d6yg0V42tmeoX2z1d62sA1hnaj/n0l5ii+pGVJjA96fQtPzq4zc9im2Vo/OrCf4rrv
 5CLSpDXxqObd0m0IPxtiGhINb8cGFf3sQdTtPqXaQ8qaaz2HzUn4h5QQpRVXp2pKiNWM
 INtudkF8agX5R+sIXMkGfqSqAKMVM5nas0PLI+O2aV8Uk0HTDW/VfMqY1Aqv9T+ODvPH
 dWkmmG1QloCI87WJGDpwAK8EzTRaTMS8pbIK111INQn3e7zkpjFfWTkUjh0hnYMRptA5
 onYzq2EtFxBgwedIeOKQd00qUuNJNmNvxjO9sgz7gNBkXz8M7sqQ0zk+lQNVoph2zbMD
 a3gw==
X-Gm-Message-State: AOJu0Yxz52fj/ev/e1IV2Fg8jge4hq3nyUbrx5HoToGevBeQqMcrRdJ3
 2IUlm4TsHJotHv0grdt1SbbzdACc/NhIItN99amXJSZBfDtW26vNv7bWCTCy8jJORvFleKbre4D
 dBmTNB9DTMby+AfLkrFU3NahO/y7vtbpMP0EsuSBoVwBxNDijmU0Jnf8PPBoykblpAw==
X-Gm-Gg: AR+sD12Li91CI23l6/ien+ub1N3Nz4ODZVMUha5+mApeyRv0gE1fEVVd7JHZG/AXHaE
 hngcomws4j68ZFFf3GXCISdboj/s8QTjIndAnldHaZCXk39B8mZIFW2ssXdRsORX8qfrtRF24nE
 HUNh4PQkSmKoxTCXeZe6iPXve4lu25YovYZaohyHW7mM4EEzxngV+bBGPKiasx7mx8PZtJYKunu
 7YoRd6N0TSAuudbgLPBXeOEcFrMfY4lHF0JrkSDy0zBYDLDkiMrhSM5x8+mb7W0P2rHuXLRPTZT
 30qPipvWLCL+hFqQHIhbQufQrbFp+7L7anL6OjtRg6N/D2Kj7vUV9A4IjBo+dtzbKa/QOi7xg+t
 cXYQjWWQB3sUVDyrFy116v5h/lUOfXnof9ul0T1VjZw==
X-Received: by 2002:ac8:5d06:0:b0:51c:1ff:2512 with SMTP id
 d75a77b69052e-52d58670614mr49692361cf.33.1786473297909; 
 Tue, 11 Aug 2026 11:34:57 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:1ff:2512 with SMTP id
 d75a77b69052e-52d58670614mr49691831cf.33.1786473297432; 
 Tue, 11 Aug 2026 11:34:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e675sm344795f8f.23.2026.08.11.11.34.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:34:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 6/8] hw/cpu: Rename cpu_exec_unrealizefn() ->
 cpu_common_unrealize()
Date: Tue, 11 Aug 2026 20:34:08 +0200
Message-ID: <20260811183410.22428-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mj-Jije3o4QbToBXIxcLANqypi1trQEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX/zzuf7HJp1lQ
 6AB0rmwYYQAIjoT8CjT9p/i297hig4p4+HkVCkAr54K50hq+VCKSA8HeZ3Sj++1IlzARBP9DmSp
 +TJjMhX7jTOowSEvUMCyAF1T2T1CIThp5HHdfApJKfNC02zzJJB5X1g9+ZIR9pslIJMc2udckaH
 Tb0ZWab/fY4uWDvdVoHjB/bYJC/u7pgi1Wpp0aYcQVTiiVlh8q5Ko3rSuH3pTrTGHw++X3PL7Pg
 lYHa2ckD474B9vzWNvxOj+jmqEVvSlJsG+gXuKzrH7FIG9U38KuyVaJ7T2mwAKP8tHszsAJygKe
 cGDi8uuxuW8SPTB1tVjBKNnSAH9E8mhf+1fsbd3+fxOItSCRQO3G0h1oxxM5AzKcmAlNpYv7shn
 hnVhP7N2tkUxjlPEmxN03TSGBP7al3XuN+Wi7hGfnbB4WMlkaO05H8Zh3/afZCWrypRo+wuEnAS
 PxQE/scZ8aG6Fh6XA1A==
X-Proofpoint-ORIG-GUID: Mj-Jije3o4QbToBXIxcLANqypi1trQEc
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b6b52 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=--_MrfCweEvJdlqdJWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX8Gsf2oLWldys
 0118OWk+IfGXOrTPU0gAgIyogYVpmRyJe5HhgefXlUwhIxJ7ABei5vTOKJLSCQELxqhRsBlzGRC
 qyVi94hW/dzl+jSC1L8YMLg040CXHfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155
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

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 4 +++-
 hw/core/cpu-common.c  | 4 ++--
 target/ppc/cpu_init.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7b7cf330cde..81af7b9ee1a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1180,7 +1180,9 @@ void qemu_process_cpu_events(CPUState *cpu);
 
 /** cpu_common_realize: CPU DeviceRealize common handler */
 bool cpu_common_realize(CPUState *cpu, Error **errp);
-void cpu_exec_unrealizefn(CPUState *cpu);
+/** cpu_common_realize: CPU DeviceUnrealize common handler */
+void cpu_common_unrealize(CPUState *cpu);
+
 void cpu_exec_reset_hold(CPUState *cpu);
 
 extern const VMStateDescription vmstate_cpu_common;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 732e32fade2..59cd489b713 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -284,10 +284,10 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 #endif
 
     /* NOTE: latest generic point before the cpu is fully unrealized */
-    cpu_exec_unrealizefn(cpu);
+    cpu_common_unrealize(cpu);
 }
 
-void cpu_exec_unrealizefn(CPUState *cpu)
+void cpu_common_unrealize(CPUState *cpu)
 {
     cpu_vmstate_unregister(cpu);
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b07e9c3ff9c..e3a1075aad3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6956,7 +6956,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     return;
 
 unrealize:
-    cpu_exec_unrealizefn(cs);
+    cpu_common_unrealize(cs);
 }
 
 static void ppc_cpu_unrealize(DeviceState *dev)
-- 
2.53.0


