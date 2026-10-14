Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E0CCC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gI-000717-Lk; Wed, 14 Oct 2026 19:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gH-00070x-Dk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gF-0006S0-VS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ELoGHF152402
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Gu13DRETKgL
 9SxYFCDDDKAcpmoQd7w/9pW2GM4OsO9M=; b=iKNvkhjSCdVfI8oV0+pWQxekNKR
 wturvlhRsBZmH1hXVdqvrXL/xomIUH20wd5kPwQ3g23BqVIGrvj3cXbEtPpIRpIZ
 kCtDva9x5xzYN3p471XgRCY5O6LJecmJWRLybT6obPgzQ36ZtPKESYyjP6xxE02D
 o1XiayZFpiaxdWAQM5rFNrvDnQn3wCQRMAdpd9oQeZqg5BsLW7gUmQi+rdhaYJW5
 umjV8yUuj070fyTtcvJYgQS1AphsUr1J++XkeCcj6PFKpmSVz0BOoP7/k7sWCeQS
 zGNnabQy5ScUUy9cz4+j/QfSFVXRmbYFHBf60y+8K2Q1M0/7vu+va/1SdTw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aek3ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so2261769eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021592; x=1792626392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gu13DRETKgL9SxYFCDDDKAcpmoQd7w/9pW2GM4OsO9M=;
 b=C3AzzfotjQqDYg89tekhY9jFc3w6qr/AESNZQ2M6y1vqEiHdIBfDQvnfKSoWIHFfMr
 3dciy3+pPxm1LkDiwOaZf/KbpBcjWw8zyY62Zar/UHC1U61MT8xlBCACJKhwzRcL7K3K
 zko5wyUFn2+AxKUTdgUYh/aP4Ck+DWKIhb12xE/cfYwu4CC/yZvZdNFb/l8HEQyb2xFN
 P/znQx2J8MyM7Q1Bcc2/ANBwVTGR3iHJ0Q4YXXgyCWEYk8X9CI1W9lc67NTE1Wb4jnEH
 FrDAo5MclNezQ2xOBc0E5ZryPdMya788t1YEOpJRnUexEtj2oTAAYCXQDv5GSPkVZcvx
 Tm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021592; x=1792626392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gu13DRETKgL9SxYFCDDDKAcpmoQd7w/9pW2GM4OsO9M=;
 b=0X4emsj3GRP6WtskDE99qxGFfx4jxFUok1yF7lViuVQDWoON6Gwdz4/nxaOEnF67bU
 wWBB7F8KUNAJKtS1f1asCR0+YxWWFufyp7Zgb/ePkYwai6zWIGecn+3xztiqhXywHafk
 bcSTG1Ui/8Pa1j8LY6hh6+RrIUoYh67gIgIAJo0fIERxuLRu0YqYOhsEsfYQqV0WLcgv
 g42bYI1rpvC4HeDFUr51lbTeB597jbFxSefwAmxkjAsgaTz9oSOYRgno3v5SUcRtmekP
 Ks39Fulh3d3uNu1IL0jTvyAhqCh+iP4lATbqNmZYa3v25vos4x9ZOeAiuZceC2VIc2qR
 qdTQ==
X-Gm-Message-State: AFq9FYLtrsuJpqAzu4C0HvivEyqWNswktPrLSlYcTRnbHIj/pPcdF3xY
 gLXJAtVR9LEZ9aKgwdXc81nUtvDUEYEFxXAdFnIcgWtvLxxihwHRnv0p/sx/DTKvnDQRqAoxx+P
 rRgtFloIHextmp0A691VdZ310sDE3EIz4Pi35vr0Pp/15T5FpQI7RUzPEAQH71aKrGQ==
X-Gm-Gg: AYBFou2Z3WqcsveQciEWJ0QjtuUgPdgS1oi9ujSYK8jBbl+KcrYRA58O5rmLs3uGFeL
 p07LgP8S5dgNrcKNwPTjOXfV+QSWIvHu/UQscPsuminXm+lh5dxYcKeOuuafpPLTGiaWoP/gSHD
 epMKf8BqE47nl9uE3LnAAaVrUZhNw44g5rrOQIoBU0dBJeR6QW/9EdBW3pY3l9mSWcVhhyMF2HJ
 klU4RvlGt5qSHNJMi4nx4yW7WB4DGY5xQdVkp044a3QS24ktpOwmTOps4BUw0bWtBjYolU0Br0w
 Yv5NjCQhgcezpgsGdKJRReW8tYkc3avtl68WdY/1sNYIz4k6t0N5ReeqlIJj/HppUoAv1eNTNOW
 CgwiwrHvf2BVYbmV32qgLXXeAET8vx5CoHC9XK16ticyUUfnn2K+AQnKyhAYV
X-Received: by 2002:a05:7300:6d23:b0:35c:6ffd:e91b with SMTP id
 5a478bee46e88-35c6ffdf3b6mr11739651eec.40.1792021591883; 
 Wed, 14 Oct 2026 16:46:31 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:35c:6ffd:e91b with SMTP id
 5a478bee46e88-35c6ffdf3b6mr11739618eec.40.1792021591338; 
 Wed, 14 Oct 2026 16:46:31 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 12/19] target/arm: implement get_note_size dump op
Date: Wed, 14 Oct 2026 23:45:58 +0000
Message-ID: <20261014234605.209084-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: a_GyF06b__w1m-IBL3E-7KTorrvDXNP2
X-Proofpoint-GUID: a_GyF06b__w1m-IBL3E-7KTorrvDXNP2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXyq2X/7NcKAIw
 osd2FiJ9J0h1cgI8nsLx1pxaN/nJSMXBjqMlCTfqcw9FnNlx1Byr2JSSmTpGz8MmmqF4t92Og2R
 yj3HYKMwBooaCYkk7lia2sgiUF4bzH8=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6ad01458 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Xo5U2CUVsYYzsFFI_WYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX2gpoDR082N6w
 1/RjBg27ryJbSO0T8VMb8Wj+Vnxx7A9DQycqG6VDkZOY1CZ1CPqEn9aA4M4youWQBeeS7T8BE4P
 vjJh1bJRY/x2T9yA/YZxAdXHdlwpUd68oC6sJBRgK9+uzrTJd3aTcf+W4jrB864528SjoRvQ7I6
 be/Ao5mLpJQWrNSn6grEMgHOALMlg0dI/m11LZLjyVkbnTtc8L4tT+p8g6xxbFQ0870unTKJYzO
 bn6UAwKivM64lvWYnGikrQ7odfDwBZQVoRk7tOkpxTCaXjSd2nQT8tMe+vedF1lOfvTHATeS/LX
 pTK021QYI1psjn3LlrQ3oVaqI4fATWtT4rNGZRgzgLNCCXIILQUV2r0WmGk5sZlrGxAJdlVjAGa
 ifRn39mChxy5B8vOZ69Xa4hdtmY3l++A4dFzcImROGR+UHjnnYvUooD7qHcQecnfqLwqJU7bs3Y
 ExOhBAdqxVGvBH4vAJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index ac84d4ae252..3ca570c1c29 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -433,13 +433,10 @@ static int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-const DumpCPUOps arm_dump_ops = {
-    .get_dump_info = arm_get_dump_info,
-};
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                                 int nr_cpus)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
+    ARMCPU *cpu = ARM_CPU(cs);
     size_t note_size;
 
     if (class == ELFCLASS64) {
@@ -457,3 +454,13 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+const DumpCPUOps arm_dump_ops = {
+    .get_dump_info = arm_get_dump_info,
+    .get_note_size = arm_get_note_size,
+};
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
+}
-- 
2.43.0


