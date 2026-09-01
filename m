Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFF3C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LCk-0003nI-Us; Tue, 01 Sep 2026 05:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCi-0003T9-1h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCg-0007lk-IB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68178omm2973865
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HEBSDWkPfatOfZfORlKDlW+OAil/75LNccJZJS9x74U=; b=SzRmXOx28ijPgP9M
 vDPr64c0DLwjSimH5wVXhn0yvCc8pypaTNrDq85B2mxGVHhNXND9wgDD2e7BouEI
 O4Xh9H+HXMTPXTRBdnmdws4amGzRqp0FF2ALHnPKU+6uA3b0xGV3Ue0DQjf+B76U
 8ojoiwR0tqqLqlm6rSu2J4kie1ANNgHCUi3Dj2DrwF+LwAzAVlsdtdin8lkaSgiH
 WnO5tbfZ3Iikd+aQSLbEfGpKnozFjgVjH56FFJ3JlWHaWjJG4/07gYZl1kwXcE2c
 Qy/779oTR5jyN/AiUAiZfVpcN56MTUAx9Fk3nTmkOgFiXxogDuAT7zpoF0t4WQb8
 E0t+wg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu0ubq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so728527585a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256492; x=1788861292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HEBSDWkPfatOfZfORlKDlW+OAil/75LNccJZJS9x74U=;
 b=AnABgcd/tdj7qyUBA+xTWCOuXIDjyShOqmrn7CM/cixf9W3jmXq82xJbrQJtKQOvh5
 YnimMPnA7P6YmBgqrzjDQa0RdmMy5QaIngX+odho8jo0baTJvlhlfMBAfWgK2FDHw7Z9
 y4RlPFETJFAAaM0FtiW3LEoqi0N9q5gjo8K6foPTWMgci+Oze4waLw8pEnQfppXs577M
 IVAi1ETkWGaYLt1R1t+gk7WdVsVnYinMPAGNSU3/Ue22D+0rcHRmz186YcRbSeheXoFq
 NGfNrqzL6jEuSz3vU+uDoETo7mZQpm4Hz/5vo60VKOI7uv8R6dNEW7UVuY2pP+Kl47nL
 f81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256492; x=1788861292;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEBSDWkPfatOfZfORlKDlW+OAil/75LNccJZJS9x74U=;
 b=neg/i8kG7I37LehPei3YTnZEIpeNW5OL92JOR+fMoib2Q53Q/puQFvFJGLuo57CrBd
 D5DTuaTXZmn6mRmxmgFiwX3Gg0NafX0NEbTd627xEU9mAzufi3+F3m4a06mKALSjirNT
 /DsmjvlRhPQlrzWIajtgWoPlPgRsDlpfcXmNar3cv3xeXyfkbYRS3NoekA611Xra8N6Q
 JDnJ7rTNrEQ6xW9dbAQY4Oi4J+FxUYkPU1nCxCoLAC+iN8MrIyk1SgPusWCblVjiZkkD
 wh3Cl16i31/nDB31FMDhcZ2VNdlYA+8v89fuLbAKKstOf/X6XDmpx2dhRpIAYMbOCYBc
 0T5w==
X-Gm-Message-State: AFuF++mT5mFgt1953zfxQsFuJ/z0lcwy77K2XOxn7fvuIDodfm8fcQXe
 zEISrCci1TZhh8v9uvBLtC1ygDvWoNtznyLx3gDweTi88VYyKnM2Jn1QRHnXlHjBtCXR1SGlBaB
 1Tt+68tG2ha3LJFrK5kSPuwQtah4sNgrUycd6hLzntjSph0z6GlKuqThubG7uWYViGQ==
X-Gm-Gg: AR+sD13rGkbARqBZz55FUKS4hZmOts5bHsnGqWLi7RmZwr6tcJOA+vwl/L69D4DNbdy
 aM9vFYw2jAKJ/K40+Nr2FwykXmRSCpRhgyzsa3InI5FGRq3ANo5mASd6oOVUQVHqy6uMu62teXk
 cEkxZLl+CXqI8+txKUIUzGmj5eVdsC3RWi/ffuaKnpCoNxt12SfLbPhFXPYjdo7Ejtv6Ou2LAqh
 XaLvOHTu/rTZ/O8vkILflzoOFq1k8RCLTciKOgIuypOUJ7PrhLtrrkkua4hU1RrqV4/Zjd4Eqnf
 kiEWj8g5tJEsudsFK1khiB9Ss0nymtUx8ueTU4GaYq08YE2OQbOKwJhDGiCrBH5MwQlGJc1bpxn
 I/U/0vQ7hhDiIsTpcJVUBZd6Z9fG2pW61k7ou412G
X-Received: by 2002:a05:620a:3196:b0:936:e938:b07a with SMTP id
 af79cd13be357-93947f3fd16mr921357785a.8.1788256491940; 
 Tue, 01 Sep 2026 02:54:51 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:936:e938:b07a with SMTP id
 af79cd13be357-93947f3fd16mr921353485a.8.1788256491334; 
 Tue, 01 Sep 2026 02:54:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d78a0bsm3860498f8f.28.2026.09.01.02.54.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:54:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v5 19/21] target/xtensa: Constify CPUXtensaState in
 xtensa_replicate_windowstart()
Date: Tue,  1 Sep 2026 11:52:25 +0200
Message-ID: <20260901095229.72018-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXz+8gOo2Irg7X
 wyb/GBrpGWO5Te4p7eeXVQe+MGMWFXlmPKGMPIw3Yw8pXzGwmH/QxZx7GitpS3fsExefi1QLj5S
 lrJ7V0rLaIuBkMKDPHNY/cJT4MdH3Odn9HIcusrf5JZmWdczXLSL/IRQps+560s4bNX2G8W+AZm
 sh3dLwzAP3sf6CCQQ8/8b81MrRf1hDoGyeaVc3qDOupUoUsnpsj4ZVbztV0cs7DtXeKq/XeYzvA
 BwhHbRm/Alwlmf4OMHwnbZzHIkrzrivniu4qj9Pi6YEU+9qeoVfHDkhCNmg1KYD+TcvTbqcuJ6g
 skNo81QFkzuGhLnPmV2hcsBsRTyGbHNEE9Cw+5HQW8hVRNNPt/V8xX5bPagJ/UCj/mBZhqc7Rzk
 D1192OmnDmuI+ogMsggxHeYfVaAcMEyK4t4CoZOkxYU7AfqzP93MaVbG9FuIV1JhCKYcmgcd8cO
 u1k0OCE3YK9tSmlzgWw==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a96a0ed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WyWAz_IcRkS63iEfKG0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXzmO/MBc1GUUH
 RxgZEPNAfpzUta0i8Pcm+zJm79g91aJIKG/TN4igcsg6R08wOoIkfJibJc53BuO//tT8Awwj0ym
 ZImZUNctMzuVZ2gwM06GbX4etlnKS+k=
X-Proofpoint-ORIG-GUID: 68e8hqabWHX3vcEQWmDSZR8f0itSCkyk
X-Proofpoint-GUID: 68e8hqabWHX3vcEQWmDSZR8f0itSCkyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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

Add the const qualifier to CPUXtensaState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1ba..49d6ad9083d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -708,7 +708,7 @@ void xtensa_set_abi_call0(void);
 bool xtensa_abi_call0(void);
 #endif
 
-static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
+static inline uint32_t xtensa_replicate_windowstart(const CPUXtensaState *env)
 {
     return env->sregs[WINDOW_START] |
         (env->sregs[WINDOW_START] << env->config->nareg / 4);
-- 
2.53.0


