Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9765AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjeh-0006ee-0Y; Mon, 06 Jul 2026 09:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeJ-0006P9-Aj
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeH-0006FD-K6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax9Cd391072
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 prUV9jPrIyyxVkROHeQLYlkopX77R4wBHak5R4ybLUs=; b=fnfSQ0GJa01GAeh9
 2pHl2c46hY7mkMT2LEbS2dy1Ou7yZSvocXbszmYiIf72ei5snDsHzvhsrGKoZFeT
 x/gxAMGfk/qbCPjXJoskxx5s6uOYuhuTOTintRaBvVQBwiAxh6YCfLLBVzcyHg6o
 DjVWmvBWojpa68/dPNMvlNENwWhiMJwul90w/B/kV6tDtEVyFudtRP2Mv4L4/Vsl
 3fDsJHjtaT5C2N/IaTILcclF2ZSKWb8GWF8fkg0TWOrMDjHKA3+o7liGd1359VQ4
 RxbOwCZhzFQjsI46KWjBRDK08ayTwRiDwvphpuX9P83nDZce2qiEfg5G1fjq5oEP
 K8royw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs16n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92d1cae5740so350898385a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345570; x=1783950370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=prUV9jPrIyyxVkROHeQLYlkopX77R4wBHak5R4ybLUs=;
 b=iBwSxXm468YlRLHNvHWTZpmyUt15nDFJ3GQdjIpsco+IKtr1waA2mEG7k0syP9Z/hw
 y+WgsugoFDum1EfCtADBq3N2NOYtijUGC+Ce6QDQ+ibKVPRXy6bgNN4ECNwsBtRMByfc
 1YgOKo1Lst8Bgb9v3QkwZKWxQyiICtkSvrBs/GqmXZGIPFYI7kHm/KDTw2E/IjG1/B77
 yOnyANjmWq8DUebuNQVJ75w2FsyX5qRxNbKE6pAJ/Rcc5M7Rfp3wlX5BBBeogKjMeGzh
 /9gSs/v1Rld2YgLX0fZiK89HJ4YxHOzWven16Nlm83jG3gqFi92JxmqfeV4+11bnb8ON
 +g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345570; x=1783950370;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=prUV9jPrIyyxVkROHeQLYlkopX77R4wBHak5R4ybLUs=;
 b=Plpa3rSVmwoQTI/chEiQXGaGkkoSLUTJA5CS7PeCxkAgumEkyPDMhCq88uoH+PQZe3
 gXN+0HHbx3EXe0cP3ycNEEXPWnpdYTS89zzeCMn3BXuiuFxwsR0uY3D5waUm6jDzZwlR
 0mlpnezB5172HsUSjH4EIXkw2jUJMDyAgQ/SGh9luSSkZXPSfdOO73q7S9eaYmXrK8u5
 0s37yXKKUeEdc00ijwhiaqKfT7C4oAiaXhjgaya0qcGQRYTzbn55/FnQLKUqtdIAF/No
 neJKcJZdB2h0L64MxyzdRFeEiBI0D93jtfyDLrqRvfMeWEfhbnD1E4xi/4zKcksGbPKW
 uzcA==
X-Gm-Message-State: AOJu0YyDktXcys1d3mQzilK+Qh0hl5qhxqsGd+QjzCLKy6PmWjV6ArIS
 5OZE+8kd6hvO3MO7Th4m6SEFb25U1gq+7KR8UexSxv5OssKGvXiRJO4MLCZd7vITNLQNiFOXAe6
 Q8nZCkzD0gIvuHFO3lOQpHIWQ4IUdq+4UMwmcyj0WGL+pzx+viYxfgfEdxIMKKNIg2A==
X-Gm-Gg: AfdE7ckwbxTr7WlhJ3QAXRdBYErwVtgJiC0uTIdd3byz9G7mNDa3R4HGzJ/IXJ0Moqm
 k38tLBtPLyOA/IYy+QVrDzw2sTZM8+Gq0IPltBsDxdn6uVmtrQoTXaRfyu9HSOPwMhDY8cID6rw
 FEK6gaW2lQ4AkF3qNJyODh0cFRV2TQp5isVXl+HaxuVnHn4igCxThNOII8fDM6QuZ2AwFUCiZiF
 Dl2n3TMG/OFYjxVhosXxVOk0Z9IPThpvGR/kvfdJTqO15+LozTcSXWR5GXBbjVksTm5Dv+nfGHH
 bRf9UQBnPr1nIlEJEV344FuRhDi/olGDVUSWJvAleyqlAox0m7RW0Ce5KCQKONad+6n2U+i+v6f
 TPnAkJpWH+iUApS42mB2UKDjB7vGE1ZzveVDrbGO3FrPnOGCHRno4ILHAMg==
X-Received: by 2002:a05:620a:17a4:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-92ebb5df141mr85059185a.36.1783345569936; 
 Mon, 06 Jul 2026 06:46:09 -0700 (PDT)
X-Received: by 2002:a05:620a:17a4:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-92ebb5df141mr85055585a.36.1783345569365; 
 Mon, 06 Jul 2026 06:46:09 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bfba1sm425277175e9.15.2026.07.06.06.46.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:46:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] accel/hvf: Remove left-over comment
Date: Mon,  6 Jul 2026 15:44:59 +0200
Message-ID: <20260706134527.84808-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v8NKPDbz-xUryx1nr0cFZg-ckyhXH85O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXywOv0mlshalG
 p7D8bkZQGp/jV6DgbD4l+zc056Q1PSxzhyZkovw+K34z4alhFPcH1POezUzfP10iG8Mmilaqg4w
 lsC8o5TFwMnUFmvf1Lliu188doPy5QV8lmI/17cV+X6TytiljW9tFdO+vmnkl8jtg41JxKX3Cnj
 gpmfCw3QpsF7STSsXon4zr6ieXESSmaxC5r6P42n2AMyMsXOeb07AtOmAV503CAP3tz5PRLj2wR
 BT5QgDsYtn5uTpFEaQYV+gL55wKKpAa8os6g3mlciNI8neQdmVeoxb+qkdqTPtWGFIMhmG4EUYi
 LQcRBNVSIfglEYVVIRozE5L77M9OsS1wWbJv01Wxv4+kvuXH6ReAd54rOo0S0QzPdtIc4uZQL15
 tbCrIL9//gwo3C0yRKDYg3HotlbDosqw0p1nabUisYovqc7zSLhfseONaMPdP3x8CX5231i3k0F
 3wFm04BuojqP1OmszzA==
X-Proofpoint-ORIG-GUID: v8NKPDbz-xUryx1nr0cFZg-ckyhXH85O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX89YCZnCt9zH8
 tgj065G29Skwfg4O33pKAbf/ZMspX5SMYIxH6saOTJwmKHj9FDEv/aFCNaBFh4lSkP9WqlZ4nLb
 +6EA7GONqEZ77jhrt+piq/xJ6ARXfEI=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb1a3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

Missed in commit 6bf331164c5 ("accel/hvf: Drop hvf_slot and
hvf_find_overlap_slot").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-5-philmd@oss.qualcomm.com>
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


