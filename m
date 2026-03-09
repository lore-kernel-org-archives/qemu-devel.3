Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4940F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv0-0001GU-Vl; Mon, 09 Mar 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbus-00010P-Bn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuq-0005HJ-OI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629C5dBt526831
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OTsjkE6PyCjrcq7r6k4/OGN1PB8LtUmEB75qaHHtKx4=; b=GNyIvlK9mK3XhGKw
 L0BDhZz3ag0N+bMAkX/4517MDEriR8qSyJlXxbVvVb2ZrLb3lBLIVkqtb67IHu13
 YvwslJSKW2atVjZim0fiAeEgCMaJQl3C5YVDLjI0LMJFMie7Lxd3gJewtQL7NL/g
 IYP6hYec5UE06xDLqeN5CsH5DM6YYX4R10QPdy7N4DS1rKEj3ZNJdVtWclMSX2lS
 jzSqfORc4w1de/OFWLjA1XpIRiWhirzhGksBZRBpYmhZ8ogZJGgN/94kh79Rm7fX
 dVa33Vk9xLg8kCZj42JJYXJT4lqWmNDb42vSYB50B9LoVmAzw/ZBQ3EJsg9t+GEt
 nmhu2Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cswwkgg64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4833778eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067733; x=1773672533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTsjkE6PyCjrcq7r6k4/OGN1PB8LtUmEB75qaHHtKx4=;
 b=UWTzDo+10NuKsvKsMMAmiVYyawXydnunY7TdSWHL/Jm/4HulGzXLJsxCP8760WVX28
 OUIBYr5kpbwv3jVyCtY/i9biCgjDUXFKomaMNzCcorDkMpW9eER4NDSykw7AqJdMpjLI
 PdG0K6Ert9SYP7SC/oHRPFX8lQllUUXusR66eLh6pt7Fwhouu/hfm/opxCGy48DnfQsb
 4h5BpGLxNwztllX8oO499bIx3apM7+LP1f6NP+eVS/eWuBkPoVdt2j/VAghCRJYPWnHs
 xp9JiiMHfz36CkgHdhPQ+g5corJvq15SEqWrU69k5aj6niDm4lmYoNc3+hRLVhBGVuCP
 bdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067733; x=1773672533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTsjkE6PyCjrcq7r6k4/OGN1PB8LtUmEB75qaHHtKx4=;
 b=StHr6HXu3aPW/VC8iwHtvP3/PZsDgnw8HY8V0cxshAqy3U2md7kB3D8QIvq6q/JmUx
 8Id8pleiPI6sYIgHGKvrWLN13WiE4nl/6DZ3uLqHV5nSDhIXu076NllkQYd+WQ79hBtm
 0n0lFN4C6Ndtv872Iyke5R/GTRpT15Vu9YWNz0crmNIyvj18mLNiHjiRQcVQV5I4Gbuc
 Zvs2a0ZD/Le9GHUaL2UjyBtgWKDVbqyUmU8yFRGw1vvOi3ygWZXmOujnhyFpVUoyP5z/
 VnLeFmkcpGXJA8JFIuBdgjAbmrJ0ilKQVQSOhmbTjlMyJ7caj1uLFE9hk4bllAHjwdlc
 Hewg==
X-Gm-Message-State: AOJu0Yxlrbup5/4BFgpyuwAmKr0UhPZxHDfoSQlkjjt5eQcmgvcO5JDW
 emFmR/s6xDRqkPu7I8KY3xcYLqpOwoegnyBLn0HiCKQ1zLVW+XnPr9elxFHwjHCWrxevGMZXeU1
 CtQ0UdcaUt5SLyunftBHgKQLmRNwOaFTG2a4z0KTCktHAuZSlzmgUU/LoWPqYtpSoRw==
X-Gm-Gg: ATEYQzw001ICgJkTuPVCNKo4DQKQ8a4Sq6z+tZjQfsQuccFmxgvOkDgyoRsNR8w7uao
 CCz57HNzz0x0owgQBTSchT5+u6mtfa3zLkUM3OPr+t0uB18axyg58AqGNU5nCLNedJZ4xo+qGSl
 d+Dj/bJqVAKH2iaQ3cVj3DONxYNXNemUI5asSR+B9bIEKPy9w3Gm3MGO8pP38jTDilWr+ecoTWv
 cBCJmKty+iQYI6zH4Li7/9PyOXhDuOnZGc7C2aa/sJS+kdQNa4eqJQHe9iLmwkd/XuAJLZljmqv
 uu7MYHsQA4i8i/1d3kjpxxjp+zypp5wNZJRpKzo6Hek7gDylWTuM6liR5VC+F0TJqbCVaYrUcj/
 d8JIY/R6Ffpnhi8OOafPwNck0Tyl7evl1CgZNiylnX79qF5+XJo+QfWhN3reNr/hHGwnJ5g==
X-Received: by 2002:a05:7301:4186:b0:2b7:c285:837d with SMTP id
 5a478bee46e88-2be4e56e840mr3684149eec.4.1773067732617; 
 Mon, 09 Mar 2026 07:48:52 -0700 (PDT)
X-Received: by 2002:a05:7301:4186:b0:2b7:c285:837d with SMTP id
 5a478bee46e88-2be4e56e840mr3684124eec.4.1773067731930; 
 Mon, 09 Mar 2026 07:48:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 22/35] target/hexagon: Implement do_raise_exception()
Date: Mon,  9 Mar 2026 07:48:09 -0700
Message-Id: <20260309144822.877695-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=69aeddd5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hK29HtBGQMdOITfcgGsA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sRaym8mzpdJ9NR87fzkFKw-ELGyeMP4C
X-Proofpoint-GUID: sRaym8mzpdJ9NR87fzkFKw-ELGyeMP4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX4klLT/6wtqPU
 irIMjbl1Ikx+FWWo1VDMV2NSyog+VQL4GDPNeaeMbgGD1IDX0C4dxRccqtj9MH/PVdHfaFPwq61
 kO10EgN2VunmZLrHRWLC2rdYIeX9BPNVWIkHBKOo+2W3zZJ550q5pSdjfEf6zVc378WSfQTIZc6
 S612aGyy7pnHUJMBFGTCo//jvS/fQngxxIBdL3IjN/sW2CTNLZI4PgkAv5GDhIEXxeYEcLO2vc3
 Z4hIpEUyFqsgUbiS4kW8VZY/Pu1sXH2OIu9aA4G16A8Qh2M1N3w0mLH3AbHuDWkM5buexrs7c+4
 IVKQcdFwnzGmmj9jvXLYUXHgjiw0QAatSxoUVp004j+rGgbKk/DAJtbzwCXdrEu6tto2uTKQDx3
 evQS9vKhWyPbbXQnP869afKmxF9rKAhSUo2iB+YlAeNMNZ3JpVCpnnGmfvmvsB1BH0hZvwU3LIA
 dLTDRczVDTtZ9bIglWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/internal.h  |  5 +++++
 target/hexagon/op_helper.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index cd06ff41d4f..33d73ed18d1 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -31,6 +31,11 @@ void hexagon_debug(CPUHexagonState *env);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 
+void G_NORETURN do_raise_exception(CPUHexagonState *env,
+        uint32_t exception,
+        uint32_t PC,
+        uintptr_t retaddr);
+
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_hexagon_cpu;
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 4db38d8eff2..eaefddef15c 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -37,6 +37,20 @@
 #define SF_MANTBITS    23
 
 /* Exceptions processing helpers */
+G_NORETURN
+void do_raise_exception(CPUHexagonState *env, uint32_t exception,
+                        uint32_t PC, uintptr_t retaddr)
+{
+    CPUState *cs = env_cpu(env);
+    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" PRIx32 "\n",
+                  __func__, exception, PC);
+    ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);
+
+    env->gpr[HEX_REG_PC] = PC;
+    cs->exception_index = exception;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
                                             uintptr_t pc)
-- 
2.34.1


