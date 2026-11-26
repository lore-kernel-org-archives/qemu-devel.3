Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14845606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fvnXh6t8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q6C6mz+T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj4Y-00049X-Eh; Thu, 26 Nov 2026 18:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3m-0003Jv-1e
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3i-0001KD-VO
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:25 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwEEV061172
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4KD2plqSJwbII+rEv10JmyH9+3bp7hPLv8JsQLgPDI=; b=fvnXh6t8fKg10uMp
 uhpUEK42s9tN0jfD+yljsYo0q8OqH2WRpwpATrhpTGmH441J8uwLRAJQmXuJeVwy
 I6cAROWPsblqPZg6SX0yAN6adJUDDS00fzz6wDagPY8Fq700iWd1XuPuGJI0+J3y
 w8xEsA5jUfpzbpw4BDZMSzUzAe6PqcXq/Xm8CPeIRfMEOkbD7Zor0Y6Lwtsj8gAn
 ORisBlCXLt/D1Ga0JesdegnWhT7brQ6pNL/+qjHynbZnlrVF21bhTb68+dXmqzsg
 JLDP9XxLjiK9mz8suyMr2bOjFEC22WPjhGGURwAdJPKhikdt3oGMf7rciKAHJU+g
 sxcjyg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hrg6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:39:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-92109408212so149261166d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736350; x=1796341150; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T4KD2plqSJwbII+rEv10JmyH9+3bp7hPLv8JsQLgPDI=;
 b=Q6C6mz+TvrKGbHh3KrEN3QVoZ2r/cWi7V6Hnsk+i4mKKjyvzy+xKFOOkKAa5Vw8Gac
 W7T0gThBD3bzeXIovxFrxO7W7kSEj1hwMyQerZIKniDTdYZMSrNwERq853Rff9SwY+Ky
 n5OXMR6rLCHBx1DRhCKXk5GiI4eHyl1p8nArWgKv6d9IC7Zxog1u9JFYd2GJtQAxZAAy
 xTQvr3pApDv7Sd+mlbJQz9GXjIIujPiM+RKr4zNow1t4p5aKHMtTEW8BLrIRw9z4Ub69
 0YX2W2fzn8IsC6vtstrXqzhuJUJoXEMFq6Y5IAcpZizBJYQgGkhVS3UV0PsQyGpolr6j
 fZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736350; x=1796341150;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T4KD2plqSJwbII+rEv10JmyH9+3bp7hPLv8JsQLgPDI=;
 b=WaYTZdRkPFic4jgTgzzs+71/uo7pth7IH0OAQOw65odDSqnBf2xGvJbGopcp3wvtWn
 nrOgdlBSYsAAEoM6lAZXSWfPW3wiv6k2+nmUQRuXhBOzmIxg3zToF45mQ5vjgeh2Jlqu
 kfv1X2BF26g9wpUBItRQ1wxRMiHPX8em+QUx/NDt4jmOtnnnpauq+YaDBQ9YMPJqhZ94
 GYcNOTbnctV/r3U8GE6Chl16TPn7F+8XPN6OOiIy2l/ccrYIgpQC539g/2rIHpdHxIt1
 UTZfnkB/eHfHXipi7ZLYujR/ryVn0NexF6iNk7acSvBqQYeT6URcTCg2Ellpyt+ZOt/o
 Xdig==
X-Gm-Message-State: APuU4Z/I6tJId04UWjy7FH05pZNV0DQGh+HjurwkWFTMjR20RulCjjdG
 BPUlXi4DUsyZbwX4fPARMsfua4n8otR5Sq/pqA1OEeAR4Pcp2wql8pR/QjUJO+0387oJ0MT506G
 +RqMlEPSLB5HtzgdNd8esMa6Ybx4zmEQwEL1caQ74LeOmouVC3IoYYMiALU+oHMbEZg==
X-Gm-Gg: AZFdTZduTILbn8/D61Y4+Y5fHEK/W9zEs4UttIc00gX/yDO88X3VD0x69QUnO++MfPB
 Lk/LdDUBX/DSTvqqBVkIdIfFFfPUxlJ+wBtfyZSdrhBEK9s3tmMdhU0gAgSS+rWpLvJNBWQVzXw
 B+P5a80Knu1oXplYkgf9yWCGPG8fzkSpad2sCIPpnfqUYDgvgs7mXshd/IfeKCePRHRzD5qLydG
 zAxXs+4plTyJRV3hxHLnaSDr992vnXTOCzTIAlRgkCY74SFUqH6BMEGkoVogXkOpjVrGDEZK9vV
 82q7kYol9eO+ruImi7ZVjPJ1NplbVIQUDpCwD3DDNp6AlwcusRWMAj6V1ODpTRlHlSGswckEdeX
 wvukgbiybAezhG63QdHQ0oL9OTxXqpc/J5uBJidRT2IaWA9jh17vK54T36ez0sgwn8FIh+Ww61i
 gAjDM9I+ROlzpZHw==
X-Received: by 2002:a05:620a:4802:b0:93e:e425:22b3 with SMTP id
 af79cd13be357-949bab4cb4cmr4283451285a.82.1795736350488; 
 Thu, 26 Nov 2026 15:39:10 -0800 (PST)
X-Received: by 2002:a05:620a:4802:b0:93e:e425:22b3 with SMTP id
 af79cd13be357-949bab4cb4cmr4283448285a.82.1795736350051; 
 Thu, 26 Nov 2026 15:39:10 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm1000473335e9.14.2026.11.26.15.39.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:39:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 23/24] target/xtensa: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:36:01 +0100
Message-ID: <20261126233604.67722-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX/v8GST2aKrhE
 s26o8+TGvTzkTBg0IvvnAn4codySWmEHVBOFgg6yhdbHhWS2OBktMomb5YHantnvLK7IvFRMyK7
 bvICSX+qE+ZnnlnovRo0hVqbSyEnV88=
X-Proofpoint-GUID: kx9HKZFDci5Fz3_eOUepaWENqtaWrxX0
X-Proofpoint-ORIG-GUID: kx9HKZFDci5Fz3_eOUepaWENqtaWrxX0
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b08c31f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=IQlASl14wn8skyX-vSoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXyXQGSj4K4OlL
 nxBc/3W7P2NxMj3LslWK51LYfv0IQVEBMjNbHUlOHEiPpKWyDmkDJyqlp7E0vU6mco9dJEGP8Hg
 8V2tMrpbVCBwYsmK9qG+hTGVcn9P3hybyktQSMOtOGqVZS3685t6GwZquDCGh86lKQk50T7kcBu
 5XhDe5NKbvMBsJZCEBUpxS64nmTZz5poFXAerkjkmlXLlqs5nE3T80fJgPKHuxA3zR/+jXTZ/TG
 kFj2ItO+4YLZMz0Cf2sCa7YZ+4yUucXmK6VGFP8fAPyunWGPrLC3L+JCMFpPBzU6P4iucHH4+E4
 t/d+cARZ0vYDh1HGUVAkvr3XImIUdTB6pOmMDctFpbtDq4WBYHmpHzIZ2RYLkdrrCPziHCdPdNm
 pcAC0WC+QaFehryO8j5ZCNJIn06vb/4mC2qwtfW/zZu3ZwFchhDeKJhHhnH0zjUUVRgIRi1K38c
 SnzGe64ANLzbmDcpp4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/xtensa/cpu.c       | 2 +-
 target/xtensa/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c193396928f9..33054c81ca48 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -60,7 +60,7 @@ static vaddr xtensa_cpu_get_pc(CPUState *cs)
 static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
-    uint32_t flags = 0;
+    uint64_t flags = 0;
     uint64_t cs_base = 0;
 
     flags |= xtensa_get_ring(env);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 175fd4b5cfc2..57392ffd8319 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1121,7 +1121,7 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
                                          CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    uint32_t tb_flags = dc->base.tb->flags;
+    uint64_t tb_flags = dc->base.tb->flags;
 
     dc->config = cpu_env(cpu)->config;
     dc->pc = dc->base.pc_first;
-- 
2.55.0


