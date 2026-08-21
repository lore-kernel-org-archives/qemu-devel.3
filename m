Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB09C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMpn-0004ae-RL; Fri, 21 Aug 2026 06:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpm-0004Ul-82
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpk-0003RF-ML
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9M0I9789894
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHmqw3PgQrwhWNplvoktCYvtMz6v2lpYN+dpIY29gRk=; b=JDyumpIwhNzQujzx
 ps3fMra6aEtLBDdaqG89S6bysNNpqWpw3vkie3lB39j4Vn3rRBlf72YDDhqtumy0
 k+c4f/9YXa8BgACsLDUYe+thEe8v+TArOtox63lNjJJhtn3J55PAEQifkiTx4QhB
 K09zHP1pIHd3DOQnbo0CtoozfqfQMX5VKRrtoZQv0h4c6G5Vk6bCWXmbcxJqeYqy
 R1kGDXZCA1blxgfmj2IvF8RDCoW1fgZkeg0OXDFPwaZQzWeCj2SkpkaHM++NbaXw
 fFXuJlSzVPSYr7GB4R9VaHwQVJ62+PZbQ6pGLqlCnSeUsVFJkQ3RGYFEevQ70Epn
 MfHgqw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebusjhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so10937011cf.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309437; x=1787914237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uHmqw3PgQrwhWNplvoktCYvtMz6v2lpYN+dpIY29gRk=;
 b=jf9wQiVqP8Wo2HAIXplJA2+QKS5+HDRL6tWVXIkUFGfEDa+CiMn+3v40BSPVmlCLck
 jhjwtOVoL0u4U5wc/razhzGdduNve0OSyGMOChwEoQfz0W1KRIebHEyGCcn1IsdDyOUS
 s2pgfVIJ98hjRSyfeUzZDFy9AIhxe1X8J1bGlMC67BCOEWsxGqn2jWXwulaQ7XESDfNm
 zMS9f4LiFO7oLa9DkHHhoR1tmVH8jaFq2ueJxbSbYpK3OIRN3Q/kvvBiEpy1wWaMIt7g
 W56TzVh6cgYdDatakYnQa0jbdrAShWR+QJCWVeidTPe7DkCtI6/lFhAIVIk97p/R1rqm
 ajag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309437; x=1787914237;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHmqw3PgQrwhWNplvoktCYvtMz6v2lpYN+dpIY29gRk=;
 b=V89WjUCL2acRoLCqHbhKuIYMfbBbLqcYiJoL0xxLvITTKugvqcCQ3iSHxX69Ss1Lry
 CLilOSEI8quaWJ32v1Www1vIyMCfHnIQ0Hw8U4lwphFJqr+lVn39PNDLkd7GlnVdE8Qu
 kaEahkohszKSn41HdEvdqEiASdlephQOlEoU4cEGwzyUAoWVYSiCnYnpdSOPD4dxXaZu
 7Qk5r2jxhJ39sQ/MqGQFKnu1+CiHp7ZN6yVi1IfB0Ed/bovZhK+pQNUI9tn3Jtlo6Wet
 uTj4wiCvl8SwnOX94hP07d8/4ebQhNl94iVTUhe4sSRZr6JeoA7uHiwa1H31Ji4uqwo8
 LuhA==
X-Gm-Message-State: AOJu0YyE7cguwWkVlSE4I5DApSqvuYJkOcGDhQ5Z0fiBDe4gG6bh8qE8
 HN3bKVEZOxEl87Tzox2NGQA98bknZwifanTwrUBAtIJ2vzc1NPRgLv3jK+cq5yeLhr+AGDiS8jK
 kMIvQ2/jdb4uLBzXHLxTBiFkqRZbAISxJOA3wUZn37VYpvsdyFx8vr9BR79RsQnG6LGCg
X-Gm-Gg: AR+sD10Cy/HMbzwvlJ/vZ7Iu3/2G4XQ+w6XSpN/LD+9wt40AchrH/9DptHe2zXtGjA/
 HWyXEd0ji2ydlBqFfMXMldakmDngjuQVZ7qkiingI78tKPDo2Lq9837Vz4jRlOJc2+MzWEphjqQ
 UfVB8UQprAFcZjNdMxUTpKS9kCQEnB0KOyqsiqktW8JyHRBbTqdgthnYBf7AVhEschVTiBcYYlw
 KWz64FblWe2w0Tp2EiCei03ZC1ATSQzXK5FX1vxLv5/zg45KAN8J71L0qngoNjvYYXTy2LVrLw7
 l510Iw6/6opZNB8V8YX0at2tv8gcZyvzZH2746GHc1xZtgEWurcgVk37u8dkX+gzJsHauWLiykP
 H+XEYNlMIBFGV2+W37u5TMxKoDrq3glVpeyfpq8AbCA==
X-Received: by 2002:a05:622a:1e15:b0:52d:99e8:46b7 with SMTP id
 d75a77b69052e-52df59fbb41mr44399341cf.22.1787309437133; 
 Fri, 21 Aug 2026 03:50:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1e15:b0:52d:99e8:46b7 with SMTP id
 d75a77b69052e-52df59fbb41mr44399021cf.22.1787309436788; 
 Fri, 21 Aug 2026 03:50:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b9b6ff25sm14514575e9.2.2026.08.21.03.50.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:50:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 06/15] target/hexagon: Constify CPUHexagonState in
 hexagon_thread_is_enabled()
Date: Fri, 21 Aug 2026 12:49:40 +0200
Message-ID: <20260821104950.32108-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wWYAZ9MeqfgHB12gl4pUXsUmkYGououM
X-Proofpoint-ORIG-GUID: wWYAZ9MeqfgHB12gl4pUXsUmkYGououM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX9hc8cvWpMS6/
 tQVrg+o75RG1vWtHhavJ0/KGbOmFQLygzqooWATHfplYodoHfIPGADDK92wI829Dpn2oxyFAD+a
 nIZzM6ZfiPmfHwHhTPGe95qEG3a3vg4=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a882d7d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=8cuzm4DnCyvNWT4wVyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX2Yp6TlPNw6S+
 eiAUOx8kDcFbc0qwnHfyY+VyEUtAXdvtQmbZMRbXfRnOjSt23CS+bElfTR4ed981gi/UW2N/jd0
 uzNeZfouUOUvk6qS8iLU5fmsIacCiH6F0PrL3NaOfDsgyWhdcUgM2c+LB0rc1qhsGdCU0c8Omhq
 ouItSXqc3V9ISy3vTI1vxPl1JelzwOsSFrmiwihktrIsURPTQNfJ2VRk0fvR7d7qtvtJQoRpEgA
 POyIIQodaBpuGv8Oc9lI88pGGfUkRzmyFIzHazrdfOzdKyvTUpFPwBX6UKXaunIEYVnvYNO9b5C
 wiWG76OswiR7waHlvpj+xfL6sPnUDRhYcBQBZa1hIXar5jtJxIqID6iTjpH55tS1kc9bkGqUb/R
 6T0ndUjG9mxLczvxOLwsyKqsyhfneIuRiHfCVj9fZ8VfvqswqVPjlJrHVHW2LhjVYEZ93Sw0xr6
 s0NXz4XhK6m30YVdnPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

@env argument is accessed without modification in
hexagon_thread_is_enabled(), qualify it as const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h | 2 +-
 target/hexagon/cpu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index c50fbb3f72a..e4f120eda17 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -216,7 +216,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
  * @return true if the @a thread_env hardware thread is
  * not stopped.
  */
-bool hexagon_thread_is_enabled(CPUHexagonState *thread_env);
+bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
 void hexagon_cpu_soft_reset(CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 9765716b516..4cc6bd67c28 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -345,9 +345,9 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-bool hexagon_thread_is_enabled(CPUHexagonState *env)
+bool hexagon_thread_is_enabled(const CPUHexagonState *env)
 {
-    HexagonCPU *cpu = env_archcpu(env);
+    const HexagonCPU *cpu = env_archcpu(env);
     uint32_t modectl;
     uint32_t thread_enabled_mask;
     bool E_bit;
-- 
2.53.0


