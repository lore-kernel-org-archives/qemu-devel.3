Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE64F417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv8-0001h3-CJ; Mon, 09 Mar 2026 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv4-0001UY-2z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv1-0005KA-Vx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629DqkEF4143734
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HCTGOKXs1fYSZixnoMaJMXvytawJB9bQ+ItN/EAPNM4=; b=X5x6c0f2z1UZtllF
 2x0jxXbHZJ7s/XlkQTvF5o9Fp4XgLZFLidVoR61D0nm7xghPcaz2b3tt5XlpUg8Y
 2HbbprlhDCPWiHSGN683wiruE6svAwr4AkeVKcp4r3xU8O6qEEY0yMhVQlfe2vXO
 NBse2HjMQTGoD7dvwOj2JV0XQc7usMa5iIG2HJeUWSEpWTdn6LB4LWPRnkWZhDhU
 mUrcLR1aDvGu8BLBYreGhCkfdi5DZb0x8KpirAgOkCmumMEGiB4KUFFf1UuZOsVg
 TmVgf7lWxzjjD5ykrszTJVkdAkqgqOacC2kdGZ0GQ9+7tIZnW1OIwgBAewv1bNTa
 N9FiJQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crd6fdr8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdff07d8f4so12962746eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067744; x=1773672544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCTGOKXs1fYSZixnoMaJMXvytawJB9bQ+ItN/EAPNM4=;
 b=igZ5MJskdEH0BEASpqKcJX72oM4ErzdXlXD0EMmt5sIX+Ch/iQlcus2Lncsg9oEIS+
 t+TeEy+a/qeoltKhNec8zA4wsKaTIb4MTM0FYDFKySMZSd1D5jNjbjfStjTesTwzQXLp
 jR5XBtovizSBxzTra/WBZwyzl5HQ+z+aDVupW9uv7gqGrOYv82zaQmaLUXUIRJGu7uFu
 qZENEXxyurAdpP9RhWR2Rd3L5pQD713L+mZaTcgbWzzSADoIdllzfLujf353ujBTuvXE
 iVW1CVCTSJ1FjHxzwKxjW+O7sdiRThxbAUkeV5J3Je8pi4botoIHMUkncrwNI+DcxAKQ
 PBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067744; x=1773672544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HCTGOKXs1fYSZixnoMaJMXvytawJB9bQ+ItN/EAPNM4=;
 b=Mt10cF86LcejAt7FqIjkgWq7Js02NsrIxKTVM7F/aStSN9X+za4yO6NpBSTHLwVmcD
 thhYjLwhGsKiZCAn9hA9U1NzqWWyaOgOlfCgZ+z4D8hNQBvyxrMFAZQKiUh7ZYhtteBb
 /QJT4RT6bwxhMXXnX0qqKJIXS3squkUrgGPynnYrK02sCM5hleRgpeyO1zsAgXxNOReN
 5haz6GpYsnWn8J/zyKmxKfJHn+5iVObQONur9PTidNbp61sHSGPFWvOjHyYbiwbOEOih
 VFjCsX15l7BctbTMhJ85U2+KJtWiUYHga+ruqwgtiVs5RGhMTH8wGpveQWKLyKaLDX6/
 0D/Q==
X-Gm-Message-State: AOJu0Yza7E+AQC9I/TzdX0hf5DQRnikAsepUfIPvHDu+S9UKiHESgHPC
 Qtu8a0iXZ+bpWbEUPGdaEpFkvEFihhFFXMBlmLL++DOkqzR3xCbgPZoJFcIHHNGiMA+y1gZ5676
 DHlOtpR7/fapMQ3kb057PnUtN7bTaM1jq6NhBZndawF7KYO62BLnw1FfGSlt1G97l0A==
X-Gm-Gg: ATEYQzzBiqZrcOv45RPxEzC4aChRhWFeJWJIm2uVPhS9KP/nrR5UfcqA2OfQVtOdRqW
 RktSyji3NXTebKfnGeW9+gqDEzdT3WVVAPOOS4QezNfFOQ+pn7KIiUtEF+OV3AZCILatzPVf/FZ
 3cHcYGZZsN6zxn9rMVAYlVXE2OsVhebSsPiPG9uB5H+2rAZAC3oKsMbBzKItYsKpPyb94tBvePt
 qCtbKm7BXT3Q75f1TBAHG5NuW53HYyUSNZEXiyqKFHedAN/6KzTxmHsNCqjSlFpiROEKI1wdJfr
 SSqL170g+SMHA5hajxZo26FzWVBJlSxwX4FDYz/YBPG5YKFH1cSXrmD0BdVyjfwYswdQGAgd6xN
 ShWvfI6clf2mxzHTe2UcbCkcg00H4N1Gz+X3Y6lDh71zUqEthu3s0RaDxd5WG06ywFto2KA==
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id
 5a478bee46e88-2be4dfd0b09mr4281522eec.8.1773067743592; 
 Mon, 09 Mar 2026 07:49:03 -0700 (PDT)
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id
 5a478bee46e88-2be4dfd0b09mr4281505eec.8.1773067742945; 
 Mon, 09 Mar 2026 07:49:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:49:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 33/35] target/hexagon: Add clear_wait_mode() definition
Date: Mon,  9 Mar 2026 07:48:20 -0700
Message-Id: <20260309144822.877695-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l-qHQDYWbNX6Wi7E3mspI8jNlEtiUsr6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXydbSKGFteVEH
 O2WsBE+GB36E9o1IdVOngkUmK7R3Hwg5/71bwfDZpMrl4NxEU9Rou4wI/EsIuOz3qmVpJMJadN6
 e2e6450STAuXMyCJu6AvVPdlQsF61n7+Fonvj475PlTkAzndnRB5MTZhgsdub5vBKyw0/VqbAa7
 37aAAECNdKmlh1gxh4wNYDKotUxsXW5BkPEheyy/DmP9D6lhYFPGwrSvDVoSzwvdkwKcEX/WE9C
 aJjQvvnHM1i0suvaj9+Sqob9p3jMWHcB/j7w3QmPhE+6gc4eH1tzKR7R47C7DA3LFaSFStRT1A6
 l+apz5lKUvOd+l3egADCLrC6cn5xfBRDDXuOHnpsp12v+6If2bCTRSimYmrbyVA/YDypDhkXlvS
 mjZDWbUfLoh/X7P96bWvPmg8VOhb9/uuWmlrmNOb+SYsRVYSW+qWgB0Aen29+ZhMVpaa7uBGqLM
 OeAD0CueoDEya9ZF5ng==
X-Proofpoint-GUID: l-qHQDYWbNX6Wi7E3mspI8jNlEtiUsr6
X-Authority-Analysis: v=2.4 cv=RP++3oi+ c=1 sm=1 tr=0 ts=69aedde0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=InO9qlFFT13rIqmD9gwA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
 target/hexagon/cpu_helper.h |  1 +
 target/hexagon/cpu_helper.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index 18300657f3d..d15385daf83 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -16,5 +16,6 @@ void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
 int get_exe_mode(CPUHexagonState *env);
+void clear_wait_mode(CPUHexagonState *env);
 
 #endif
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index b6a8bd35309..6fbf5fc8e2f 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -64,6 +64,21 @@ void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
     g_assert_not_reached();
 }
 
+void clear_wait_mode(CPUHexagonState *env)
+{
+    g_assert(bql_locked());
+
+    HexagonCPU *cpu = env_archcpu(env);
+    if (cpu->globalregs) {
+        const uint32_t modectl =
+            hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
+                                   env->threadId);
+        uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
+        thread_wait_mask &= ~(0x1 << env->threadId);
+        SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
+    }
+}
+
 int get_exe_mode(CPUHexagonState *env)
 {
     g_assert_not_reached();
-- 
2.34.1


