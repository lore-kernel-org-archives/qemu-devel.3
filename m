Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D65DC624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LBq-0000x2-Sv; Tue, 01 Sep 2026 05:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBk-0000pp-EI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBi-0007d2-PT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179PfR1282911
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/YzYoACAzMQZT0mHSEMi7Bfq6APst8PG0qMwh1Z/kg=; b=RsyXXd0MD/AtLzaw
 KYvaeBf8SeyWKOPn+88xmJ8FnBpaJjXaKG4ba1n76hVRD29BXy/zyCYwc+RWEuNg
 GayZWbtFLJQWGm0djJJcFchCdrPS4SRgIvfd8TcyAnB4njopryeD43xzoB4h118I
 4ZeLcAGwDVQOVyWKUr6YfoHrBoN2VB0sX2d9HTDWbeKSCGThkPR/sEUisBTztika
 3XzHxkK2bCFawi1Ws2QQOhUYU0R3sN+cn7Rwdf6BJC3sqED5odM/vkpERyUqE3dA
 fBch0Sfjkw8QWfVJWqqB84BDWLyj9fwOn42rYgV/EoeDKxVoJRImwSSM9rEiwlHM
 /AyVPw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndx9vq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:53:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-933023a5980so945295385a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256433; x=1788861233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/YzYoACAzMQZT0mHSEMi7Bfq6APst8PG0qMwh1Z/kg=;
 b=WvJUk+K956MGCFFwNO+cwX24wZvjwURdQYWxtl8hyIhUKSJsS1I4Y1GbrmyfNSaoDd
 +zFgqxPJQ0rdnxI7V0/n7JfRs7Z49WldHAmmeo+jDzkEd9pn+R0rCcCGe/4s5Y7vsqkr
 BdwB8NsC/zDEF1BfRvEpDlFT21VOdyjO7ki0JnzVO3e4bhCorXQZxhGteRbJANcrksUw
 OwM2TvTmqzTazkTw/2QdCwajfLqysur4LfvZ8P5YtWcyHY0GyFmjiqU7AFl10l0A1x7b
 mx9TAo+nvlv/PKm76xE6R1w2b8h/S6FQHsKMlJfH7+aGgDrZtYsK3CWBy8am4dZmiCth
 FkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256433; x=1788861233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/YzYoACAzMQZT0mHSEMi7Bfq6APst8PG0qMwh1Z/kg=;
 b=m7g+c5eRp66ufH+YVN894Xbx6RMjc1g4LyN7zAmKU1IO0FD0Vp9YRXap9zyebwOruW
 Y24eUmWRgjTo6TcAQfHGDTxTAvf9RpTNuWV2k65sVEwtef4wEvgqQm9Njw3+aRgbivTe
 aXkdDhCB0+61GqowSmzsqy4SwwX0R82Tj40sKxkJsNgmnlZDvUpZn9V9YqzWg9rIZNmi
 5ruZXDteWkfFkVezuOQFvqplBawffdHVlaWSQIt+DkLfs7Ojb5Z+stxA4ylW+WTTHqv+
 b0qLYtrnQkLUlYBhADIzp0Fg9jEYpDa3rTURNoGOkDsXgAEUiv0sA8MqPqWNB9QmnENe
 GBSQ==
X-Gm-Message-State: AFuF++mlp9PSdoZavM1BWYXMzjcKVq+ltJW/sJ2IMAnhhQS+JF0fK+42
 Wg0Atl53oj75SLMDsQYWNO8aY3+njOIqJs5oq9gHTRJZLqDUF7rYnF8c/l+VLi5tbaWpNP+Xpvi
 75bIrvGQ0LcLXst+FSwf0rdkhm63B4BfJ2YH8P3pWXAhQan7BldBS41BQi+L7+F/RLg==
X-Gm-Gg: AR+sD10p5eAuPKrbAuYAcPf9SzLmhMCNo6ViYKRniB/DwYd8NnMR1VeNshQedKEi/iR
 ZvI+BXL9keeU3CQeIeAzYIrQ5iJjZZJR7+UEGR1cQL+D+FMHANhWSgrjLPJ36gKdZ6Nil4IblCp
 26y9+FRbPNZIRMha4m7wTR7g+Jb1+bkLlJnlUH77+E3tqe+tpqbnS3k9khTF+a7EzyUcjls/FvO
 cAKDQcWUnc3VFsTD+cc2SGKhyHzJMMQUhZx0cXFsM+Slp635UDm6RH/HUjxjvqnJM3FUrkCN7jI
 lGFRWwPyac6fA2ghtnhh5UZFheWReHd0apnXS6yT/a8A5MGRxPbTPSzIQvNhgbG3HdG/vSIHtj8
 qsBR2OYyPFkRUiJU2CYkcnW5qsd8AIOfLLONMvvOS
X-Received: by 2002:a05:620a:44c4:b0:933:a17:c0c4 with SMTP id
 af79cd13be357-9391378416emr3344181085a.9.1788256433005; 
 Tue, 01 Sep 2026 02:53:53 -0700 (PDT)
X-Received: by 2002:a05:620a:44c4:b0:933:a17:c0c4 with SMTP id
 af79cd13be357-9391378416emr3344178885a.9.1788256432597; 
 Tue, 01 Sep 2026 02:53:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c5790csm294645385e9.0.2026.09.01.02.53.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 11/21] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
Date: Tue,  1 Sep 2026 11:52:17 +0200
Message-ID: <20260901095229.72018-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5PwisF5febGUyBcmwswlgACvItf7fc1i
X-Proofpoint-ORIG-GUID: 5PwisF5febGUyBcmwswlgACvItf7fc1i
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX0sBMP/F6r1vy
 2h127+CEXObIZ2UQTWFGyrcME8KsvJxLCCtUBit/Qi/jLiRcGUbC+sl/gzAauX8VPO5TzhZq94E
 uvmTSTZlUmV0QqN8MzWRewWfD7f6Zlk=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96a0b1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=IBuu09U9_flyDEDmYOIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX4GokxkQR9Unr
 qmZq8azXMDzxOILzl6gwEoqU1IsTj9Vo0skPmRp7zbDjJ+cvAcQg37kh+w+HFBUv6daaAeY9Vtg
 rUeK+arndH5JEMD8E/WouRsc8JwekQS4fmCME/Z3H7rRbOzLnqxObGpB2/sEa1ZXf84DYznEIPl
 IG9W1TX8GCusG8/O/JJUsOLnflwy9UBaBI7JmVOtGGWnJj4s/ALlnA9gc9f3pm5+WMNppRRZgQr
 2DIzJoBrUFUAJjtFCznnpHQRu2CwoeKxFIbDgG7CaKSUJRISmDux64ocrB6ZHnvKh1wJnr96J0i
 NHs0F1InhGpBnZsvBMWCzzhjXXbU8f02EAlhixmelHP4Q6cYYADljWRFHhQRgGIshsmFZ6bI4V8
 QgiqHqXID2GBjYi7rw9Q4a+kiKhqZTXb/81WTAb2e0nhMip4p2tDS8HadsPApDdWs01dMA0s6Hy
 Ms541dIUCw+IgXJOxLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add the const qualifier to CPULoongArchState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h       | 6 +++---
 target/loongarch/internals.h | 2 +-
 target/loongarch/cpu.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 97db3b453fe..ad8e7497279 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -486,7 +486,7 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
-static inline CPUSysState *env_sys(CPULoongArchState *env)
+static inline CPUSysState *env_sys(const CPULoongArchState *env)
 {
     return env->sys_state;
 }
@@ -496,12 +496,12 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
-static inline bool is_la64(CPULoongArchState *env)
+static inline bool is_la64(const CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
 }
 
-static inline bool is_va32(CPULoongArchState *env)
+static inline bool is_va32(const CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 = !is_la64(env);
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 5e9a6c7bd65..a831507f439 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -39,7 +39,7 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7b601bd3728..3b3cbde882f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -96,7 +96,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 }
 
 /* Check if there is pending and not masked out interrupt */
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
-- 
2.53.0


