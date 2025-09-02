Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C689ACA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0c-0007Za-Dj; Mon, 01 Sep 2025 23:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0I-00076T-Du
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0F-0004Wz-P0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S590017641
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dq7Pvl10wCwRyK9sdJHD9Wb7UyXKC5GpORHBUvDauTA=; b=RIj5FXe9IrABmo5H
 EVXGKmcoKwmGTWyyZLhQkn2MnCjXUIlpTy3Y7YFaRwQYF7IZFG1E8Jk1h107u/7o
 9YJa8g5GecmzgpzMRKjuNeVAVseqbwgKQ+O+1a5F9wVrKZbVPWiLzUhht9nrHouK
 hwINBnHWLYdR0d5TawK44D4NI+W8pTknw4/I/HXy3X/fNdM8CZPJIp1vbswoEr78
 Z+WMJptcGugu1vaTnM3KQsJzOdqex7eIDgtjR3052LS/QnLMSbDvPLI7B802PNzD
 7cZkGkAztaMLmUsldYQgpvMvzbVK1gRoI9iorxgg0mPPnw/QA7QWVnMSfmE0SVxF
 IXWExQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x872-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4c229e2a42so3573488a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784883; x=1757389683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dq7Pvl10wCwRyK9sdJHD9Wb7UyXKC5GpORHBUvDauTA=;
 b=jeB0YtzcZRn+6wCgkvp3pt6mWTjko8vY/VAzl6YoS0v4JO02MHwUKbwK4jRjWcWh7B
 ynHXtepvJ3cbUJdYjduQSKH7Kzouo5GsIo5vdjVkILisF2ja7cLMZOuBeQsHtfJE4jAP
 LGGByCOILlmynz5gXf+qolIaL8MZMaBZlOhf42xdu037pAayeKUlecB7JjlfLC86uCVd
 Ct7ic29WlKbVfZ3J54M5CEGsajQ21htDcnWV5jMml153TUlEXHasBPw/PH5xI8NS07yg
 vQ7xBFELUuE3uK0NxQeAd3BkLc8JdMAQHF688b9gytph5wvM0IYn8GDnndN5WuKz886V
 DEKg==
X-Gm-Message-State: AOJu0YzyirUFrz0dtLrQh9ZtP9KSujt2usoiwtVczDkzHFp29Eu3CCGc
 b5TSo+D9Q3SnLmDY6aT00XA/itXgpnZgBkXS4OQmfnpiOqK6xuKCju1cS6LZdNtm4x0HBd4hqiA
 xPqnBdzEy3ewVhSw1QJhJKtJMlVTIjrpqMvQ3qDhPBPqhMG7XmjXIRgcqD5QQ5UEwRz+2
X-Gm-Gg: ASbGncuZuF6DLzj35q1XosO6eottERNQlbdELjFn/BB2XP+hl8RmcmmElEZoEiEET25
 fUArCLQ7KT9eNeVfdYnP2xHMTCyorQRvkxLiNlemK76BKGKg54qaGN6sqqkxk0PvQ6D7empgt05
 TkxB2YS1IvtAioi594frRm5dKWh99XwMzRFl9W5hGF+vk4ITBMqcUV2HNnelhwUIl6NrndP5z3Q
 3nsg32BQVXwTTF/VSgaLeOuEDFnDOfCfPqkU5st9WmYZaQdD97zKd+mt6bYtVjrXd5ktCCgRKFV
 hXl+Tchbyb+mXwzwuKzNelF5uQeSqz+ovkFvNY/vweOU8D9dfRHEIjvIT5Mqb1YSTgli87g2++Q
 LKMXcjgwlWfT6
X-Received: by 2002:a05:6a20:430f:b0:243:78a:8278 with SMTP id
 adf61e73a8af0-243d6f4c627mr14216750637.48.1756784883371; 
 Mon, 01 Sep 2025 20:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfDepMI8I9k/ZkHHaZ8jEoqPuEzurBb4c+SBfJCgrw4sGMUXTb34B8LJiM/dKh2Fm+50iLWQ==
X-Received: by 2002:a05:6a20:430f:b0:243:78a:8278 with SMTP id
 adf61e73a8af0-243d6f4c627mr14216719637.48.1756784882917; 
 Mon, 01 Sep 2025 20:48:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 35/40] target/hexagon: Add stubs for modify_ssr/get_exe_mode
Date: Mon,  1 Sep 2025 20:47:10 -0700
Message-Id: <20250902034715.1947718-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UvWg2FiQ1lddmT_4CxxzxV3aYQ8m154t
X-Proofpoint-ORIG-GUID: UvWg2FiQ1lddmT_4CxxzxV3aYQ8m154t
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b668f4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Q6B7wG7KZsRQN32SAGcA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX+bR4kw8gOO1Y
 d6AO+iCUlk/iL5HR7mJbAjvTFxfX5VqWn1sLg1e69ijcEJy353ai7PaZGmrsZnjsDeQuzbIWjID
 rbQ2zYyTtuRg1pVBYo848hfINnn1+7jqasH18QmgWnIr2fU8DLRcKlwcKcRg4TABWOeiEGjIT3t
 HxliqZRnateWVwWZvXgyhZTEmot0Co9M56ac2bLngT6xvs/W+e8VWsCobx30QCz7x1EGIuyRYB6
 QjpFkIEyJYhAICSacb4lP+EB77AT2S58xmhw9tcriwDqGsztKyyzDNMLJMXfjjVXBU8X6BtbkD3
 fpsgJ/M8lFJdLTzWsUFLGaIwXGlq3lTxFuLkvGD8Ag3Fr+lHIYTn0kIrFjFgczail8msysYaLTb
 jXiD75Fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h | 2 ++
 target/hexagon/cpu_helper.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index 5f5f15149a..e0c0c037a6 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -14,6 +14,8 @@ uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env);
 void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t);
 void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
+void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
+int get_exe_mode(CPUHexagonState *env);
 
 static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 4b8697de65..bc51714406 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -71,5 +71,13 @@ void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
     g_assert_not_reached();
 }
 
+void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
+{
+    g_assert_not_reached();
+}
 
+int get_exe_mode(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
 #endif
-- 
2.34.1


