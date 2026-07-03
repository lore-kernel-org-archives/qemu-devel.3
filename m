Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5779CC44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiJ8-0004LW-6Y; Fri, 03 Jul 2026 14:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiI7-0001zI-8J
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiI5-0002PP-9j
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Himdr678671
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GSjWbCL/dirhcrj5dWYYaOR2XqQ0JWP1BRKckTfPwSk=; b=ptB4JPBGjPRj05+S
 4CJrgBvDKddJtlTk4Rj15aKNgQSkhBA/JybGTzJ/yOhbzF+hPtuFyo+896Pjw7JI
 Tj2xIr3pEoevRaPvNUKnOAlO7IWueqN5zIcd0VHjd1GYgaaXMR6zI8SxE288JHJo
 SXDaOulqxibsxX6cXGJC6A+URmYCGs3DdMpLqSxdfrci7lDGt4bDBm50i8kAS/IZ
 EYjqZafb+fuTFXMmN0kEIYjQ4j2nvQBfrvufMBqXv+GlRCrT5BcVO4kijKh3yw07
 pbh5HKEf/jRy6sR1TrjhzrFXkfWHTnBbLP0GgeA0YjMC2bDw5JFQgBbJ41iOf6KC
 FSLY0g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u3293q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so11023101cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783102011; x=1783706811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSjWbCL/dirhcrj5dWYYaOR2XqQ0JWP1BRKckTfPwSk=;
 b=QkYjXJcVaScVHTaX5JGiUYCAO+pFeTAXLsUXaNlp8qyDXlPXvuRvZChmCH/MJ5+xA3
 MQ3ywbKO3/jhI5Jl8pwF6coBWhCFLplmQJY78OzBxX46UU+iQnLSJgxFKffCMxA6hWua
 jt8uAPMPXvFhKjgNo/NBaVQpmksUgFuKBM7ROtt6A1JsDqS9sMse9x+Ggte5dyMAXm0s
 LddNTDTnuPFZFHjEeApMKTQeSGhm1wLNC6DMWGkiKZgeEVz0b6DYgOPArgeX+6hV4MoU
 hz8CL6oMuEcdmXKYFUhm36/VnOo9drPqjVQjUJY45YSmdJu4ExUI1peu9JwRwUQWSpQF
 mfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783102011; x=1783706811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GSjWbCL/dirhcrj5dWYYaOR2XqQ0JWP1BRKckTfPwSk=;
 b=qZippzMVFZhjWH8GcO2VI3tbETRBflk1vccpcvi9HTDYK4Jd8mYV/A4RYgbQ+fL1FG
 D++a4PdgBiM4Ry0mw/ORNB2rtDRz9tKYyR8D345/kLkSMMcqvOmKFCl4L0tioLg+ztS1
 WvcRLqVs9tKbZhEHjt4l60s1wXlfCp88c2L6xeqkKLUXSVX09PgSmyEPEu/5g+AVOZW8
 MyUTYyD+ACGPkuj5bumw5EHdQEM+RKmEkwTvDdCxHo37YsuHRNhh18pcXEKZT0myGqSz
 iCuXschN/nz0GMnWl8XvLM/evJpYgc/QSdgklOQFifagyLG5+Nq4sW6ccDGGTufi4TG5
 edkw==
X-Gm-Message-State: AOJu0YzsEEYpEagFVFRT6Ybm2IV5ASjgvqGTYYPiufCn58m49zyz5G6z
 l/E42uWc0HbBiCcbWe9TdXAbFUuiVslFJwz4YlTTwj/WKyf7kN9W/wx4BN2nhhoBKOA/cN3Cx63
 wO5GAskFVZsrPpbHFxNWQ6BNIDCgmgaerd+BQ4uAdm2/5EfFzvAVIFGF2qPGv4jPU4Q==
X-Gm-Gg: AfdE7cl5PKoS7e2fbsSJrb291Cddvi5xu9joShE0cY8ZsmnU6msIHv2ZuLP4N4FvAF+
 PEnnES5qtBjwObCjBWrrPENku6yAbbltKizJ9oewCi7uWyg7/g49ttE9deFReYj/AZcWhVlsiks
 Wis3NPTnoEdJMX3KVsAJjlHsPUraneXLrgQFJMsQ8G3Q1zfXcMy2LAC6ExeE7k0fORX3pxg01ol
 IF5pwUWC6Gnf0DYIvxUxNAm2p/xdPP8P0eTWMnvaUIIfyR18IpbIO0IljXyzWx911wkHUUg1u0f
 G01Z4rBHQxdQDPvVdwz6ObAEo4pRjVzperPDQozPMNT03R8X7WXeBYdx7jISGBKWaf+asV/Lwlf
 I8yXv0BHBvS9EmRmGEhyPbTjTIVNx5SX9WDRjsqOKpXVwfw==
X-Received: by 2002:a05:622a:408a:b0:51b:3e56:6407 with SMTP id
 d75a77b69052e-51c4c32a935mr10577581cf.54.1783102011216; 
 Fri, 03 Jul 2026 11:06:51 -0700 (PDT)
X-Received: by 2002:a05:622a:408a:b0:51b:3e56:6407 with SMTP id
 d75a77b69052e-51c4c32a935mr10576831cf.54.1783102010656; 
 Fri, 03 Jul 2026 11:06:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:49 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 22/24] target/riscv: move riscv_cpu_set_geilen() to
 riscv-imsic
Date: Fri,  3 Jul 2026 15:05:34 -0300
Message-ID: <20260703180538.3346781-23-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tBhAk208SNKkXf7aBuN05M87YbhGQplh
X-Proofpoint-ORIG-GUID: tBhAk208SNKkXf7aBuN05M87YbhGQplh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX7SpZ63Z8h0v/
 tormM45W4fjf2pfTAt7SjGa1xmuG8+NCoP0KXqhUKlilwwcjinOLP9fvYlghg9tDVnXUQnATHq8
 /MIZkI2n7OgmqcYTtbMkszhXWF5Vpao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXwVqRdrRfrKER
 gaKkorYo6nCeVMIJALMb/56wzVw48r+tg0eR2YqjwdU4vTEdQomsNZY2TUx0sdPkotuIvVjJYVg
 8A7fUMIvS2JxdZSEbjcOEa81ftbNxZhCTlvq5e8lfb/ojkUaO3X7OBaJoLsWLOkiauOmwhm8ui4
 /CNzID9Hv7A2j4nHGSejy2MS1Zu7wg3Q+N8oMx1d6PDbJJirt2ViTvqY+JrHY3ta2Mq5EZyy8Yc
 r4xc38YPAF+IocBHKw6eAZxqiwnRJXlraqyApFmBSagDIOr5RiVM8LNOsegdWIAGR6nPGOpGHde
 Pgx3/TJol1it+cnUcZPVcqkadERxJ0WNtwhb7H52UGVTqocw8qNIO35yyfknYVDQOZ1utHy919b
 I633PHnlUthhyE/9nuLyx1v2yRtxqzZmrXXHG7eOJDpDkmUOfGyxMVWj3+DCCt99FEYqWRFabCQ
 d/kQBEkLQllasjhLz/g==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47fa3c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Lr_FLp39YrF5VQqdKKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
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

riscv_imsic.c is the only caller.  Having it sitting in the TCG only
cpu_helper.c gets in the way of --disable-tcg for no good reason.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/riscv_imsic.c         | 13 +++++++++++++
 target/riscv/cpu.h            |  1 -
 target/riscv/tcg/cpu_helper.c | 13 -------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7e5b5349ba..ebb55191c7 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -46,6 +46,19 @@
 #define IMSIC_EISTATE_ENPEND           (IMSIC_EISTATE_ENABLED | \
                                         IMSIC_EISTATE_PENDING)
 
+static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    if (geilen > (TARGET_LONG_BITS - 1)) {
+        return;
+    }
+
+    env->geilen = geilen;
+}
+
 static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
 {
     uint32_t i, max_irq, base;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7618110412..7a4d8abe07 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6b39152ee2..71a96a20ef 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,19 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return;
-    }
-
-    if (geilen > (TARGET_LONG_BITS - 1)) {
-        return;
-    }
-
-    env->geilen = geilen;
-}
-
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.43.0


