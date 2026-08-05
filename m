Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C313C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgJU-00009b-Fy; Wed, 05 Aug 2026 14:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIu-0008VN-9G
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIq-0007ea-IE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HS6Kc3888539
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zpTq8m8yans
 XiuzePHJBQKT4ihkudLV2rjyap1lEZfQ=; b=FfP94iKZKYomcRKfZancagW0xjU
 gU7yhJEx+eVtes6b4vnVmQ48XqyV2gfwp7S/geEB7d5gly5ZDAeGZzTNaxu9K3Yw
 Ox/DBb4fZV7D5sLnOysdHQd6Qm8QUunRtXTygqzs9FEih3WrAAc6nMyue1PuL3ft
 RSxA2a8CpJtWhHnAtixCpV/J4bgmkGEWjrTo4T69DiazX3nuI0XywixkznnWziOk
 +g7GMeh0a+m/27buZoPrVMsiv10h3KZ3UHx0cvaW77F4ScLlI7xSQurxYeT7FvJZ
 7A5ARfVS5ebjj2k3Lx+woUd6EJDGe8sLMZvDuLPRsE34z/OKnNg3sSwRv0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5sh5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:25:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso106774085a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954319; x=1786559119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zpTq8m8yansXiuzePHJBQKT4ihkudLV2rjyap1lEZfQ=;
 b=SXzWHXCh3fz8jQFVrbxYoUgWYZMcOq0pvFuLn/4iFrbWErIMZtuDsbbhqtxwyVo6Rh
 ePDt3NYo9VzoTJpmJJIODSIi89tvWwRIDq2myFm85LXcP1v2sCDBgWrx2XKRHBLpp1iQ
 P6C7v0h34bJJRupTjd6nATzbFbXSGGXQ60d3LKJgZGx/JFWBri9il4ImgxDgtgYt2HZC
 Sxahu8hiGa9GDPaAHhCfke4I/EV/g4nVq8ubnPf99F+NeNC9RbvScHrAN/6tooDb5BFX
 nrAHMn8IiW7t2C/mdCVUyRDFNi0fUAqlgB1Fg/8bB50BgF/tcU7qS3F2bneFhc6S3MW6
 NeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954319; x=1786559119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zpTq8m8yansXiuzePHJBQKT4ihkudLV2rjyap1lEZfQ=;
 b=DsqOgZiovvugKssRICrm5jt5aLsVIsXCxrdJxem3CpEp9A1/Vq439ibwU1rCPKyvWs
 HzfKg45/86xJXaEFh6OSlXxofAVQl2rNqcIEmlwaWrqBi7F0GjZ20Lvk1DTjVn4IdN7n
 WlkxH6Ntu+ojVUufC8dciRMP4VAbUhjUby5D2Au3H7J+NumDJwUsuRjkdEQeHwi3Ynod
 xYbJfMbKBEEMslOBked6hGV4WSM5cNB45DvrTMLfrFCk8O+ueW42aHQvy6GlWxKzTZ6G
 ZHSGrLRWVGw+Nmueydwox2pa59VnLTuEWLZ800x51OJWadIZMvx7KGRrySDMvEnC/QOo
 lyeg==
X-Gm-Message-State: AOJu0Yye5R1pyYV6hrUlWYTJQnrDRC2cyJduEyJSF/6wpIVUr1soelZq
 2z/AF0biWRH56ZcLv8b+WLVd0qmzhUxX1In04+FHOaiaH2SMO2+wIw3XZlokmCrZdmrFlgrj5tD
 yhTW7x32iNs3ZHC7O2Vyq4GW9K0qWEU42U2fV7RAltQ/x7fQyOYEOa2MoPAT6ACuihA==
X-Gm-Gg: AR+sD13c3hZdC41VGB8pQ/CyOD4FmTKTbxq0ECT9J/S448IGvozg5+APmhOelwWxIxJ
 zxIC0h8Ec2MqsPMaJjIKyYKDpJmEYsjHicxWVZ0EOh1z7eu06W//Jkq0gHjPZLV7cEBZVbxp+Kr
 ETgYquhnyDI1vcW4SqkB5YtjotfEieHBN4SRnPraa4tYbBCE/qD7iQq1z9YG5dXZrjP4UDQEPGf
 +CTexgdeeOVgi8QYzoTJiPZWmlOBHrtKFWGDdp4kiKQV7BDH5yUCot4RI3cgdzTaLUaJQi2Bzw7
 hOVBmpWxts20GkMvJF/jFsACwaudogBpBuF5YJNECjiyG30baaSLUKCI4EfIto08/kWmjqSERZq
 lPdLOfb6lKfFxIZp6YjcCuwt9cvoPhs7tTOpaNA==
X-Received: by 2002:a05:620a:2616:b0:92e:4927:1ff9 with SMTP id
 af79cd13be357-936491302dcmr860161885a.40.1785954318857; 
 Wed, 05 Aug 2026 11:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2616:b0:92e:4927:1ff9 with SMTP id
 af79cd13be357-936491302dcmr860150985a.40.1785954317968; 
 Wed, 05 Aug 2026 11:25:17 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a3fc901sm209387885a.6.2026.08.05.11.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:25:17 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/5] target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
Date: Wed,  5 Aug 2026 15:25:03 -0300
Message-ID: <20260805182506.2943757-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xea5Co55 c=1 sm=1 tr=0 ts=6a73800f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=MeNw4mndUgOD9sKrnOsA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 0DllCkLaz15FbG6IdDyHM2XdSVx0NFtk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfXy0NcTuKjrxqk
 XNN7f6q8ec7+Dgtv9IStqX/C/hWx2v1m4dGPSV/8PRNcaYG6dYF/SWHGGGcMPBTZNcNOzXDw5Kw
 vaNwy3ohff3pPieH/w7JQ37BvOE5vhnGb5s7PPk3x4MxBR1gFbZ5Ehno8IXQ/gR9oRX6pTeC+0J
 vKc+wLKCapvXEHIRLUQW0LaNiHxUG9lXqZ5bLx0QRJjTuAfZgxbSqV2bHUX/UsaRFdgFCQLx1WT
 BKB2uVAmDpFj9rdQH3Dc+K7KFOBW0DkDH4OCR2LizVatvWlTcyH//yeq3iUyuhW9t/It2k3wWvQ
 K004Mf3A7/ofHcIckRaQFg+9Cm5ODgHJ49H4B5NuQRs4Zh2kfivxBL4ed0s6FamV3xfUeko7ZSH
 OPSjpkTbNzD1lYJZyoKuAZs7MH/cwJ5kzoPNCC4DqF3bMWDnH2qff5SYozEPQzF0SLz34Af5JGa
 HaNZSFalRGb4VCsHM/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX0T13YN9iIsmQ
 gOt/r3khhLqPOFdgNoKgmbnhb+irVlwPeTbQhhYxcJpH9CcDG/KfvERWstAGmyXRooe4xQl4ydz
 aUxh6noWO9ZciXMqr6GnS0B7ywWy9kc=
X-Proofpoint-ORIG-GUID: 0DllCkLaz15FbG6IdDyHM2XdSVx0NFtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We need to set the 'pending' bit when 'count' reaches 0, clearing it right
after the trigger fires.

This is 1.0 exclusive behavior so no changes are needed when running Debug
0.13.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe70101..2191928761 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -77,6 +77,11 @@ static int access_size[SIZE_NUM] = {
     [6 ... 15] = -1,
 };
 
+static bool debug_trigger_version_1_0(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdtrig;
+}
+
 static inline target_ulong extract_trigger_type(CPURISCVState *env,
                                                 target_ulong tdata1)
 {
@@ -684,6 +689,17 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
                                    ITRIGGER_COUNT, value);
 }
 
+static inline void
+itrigger_set_pending(CPURISCVState *env, int index, int val)
+{
+    if (!debug_trigger_version_1_0(env)) {
+        return;
+    }
+
+    env->tdata1[index] = set_field(env->tdata1[index],
+                                   ITRIGGER_PENDING, val);
+}
+
 static bool check_itrigger_priv(CPURISCVState *env, int index)
 {
     target_ulong tdata1 = env->tdata1[index];
@@ -735,8 +751,25 @@ void helper_itrigger_match(CPURISCVState *env)
         }
         itrigger_set_count(env, i, count--);
         if (!count) {
+            /*
+             * From the 1.0 spec: "When pending is set, the trigger
+             * fires just before any further instructions are executed
+             * in a mode where the trigger is enabled. As the trigger
+             * fires, pending is cleared."
+             *
+             * And: "This bit becomes set when count is decremented
+             * from 1 to 0. It is cleared when the trigger fires,
+             * which will happen just before executing the next
+             * instruction in one of the enabled modes".
+             *
+             * Note that itrigger_set_pending() is a no-op if we're
+             * running debug 0.13.
+             */
+            itrigger_set_pending(env, i, 1);
+
             env->itrigger_enabled = riscv_itrigger_enabled(env);
             do_trigger_action(env, i);
+            itrigger_set_pending(env, i, 0);
         }
     }
 }
-- 
2.43.0


