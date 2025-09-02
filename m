Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB31ECA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzh-0006gu-Sk; Mon, 01 Sep 2025 23:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzb-0006ex-6a
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzU-0004QL-Pq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmGR012352
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +2e0u7c+q95xVLOhFkTBhlxiA5hudmlDKjB9H+F7IT4=; b=m2XhRdFgmUd2jRrV
 HPD7aVdA/4lia4CYvslUrY1RY8vnXb89UCmzo0pPbcUy3f7xGNI9ngGSDGZ4BdI3
 0sYY5Egp5XLPwOhWeReb3Zcc4D+h/janf9pVA0dI3Q1w2wnEp97ryCSsxj2AR/Vo
 95Fh6z9WTgZN3oUhIcqDqFG6q06thwhHFneT6gwgENuGifIozBvW0M0YcCQuf1oE
 XWulIqkLpj4YhnKFdSxA2ngL1g/kzKp+ConGDem4DcQXRv+2TTYrcfKgMbLpoWW5
 tTgJZ/pSHaS+rECqXvbqntp1vCIoB7OBkQq+3GDh4G2zQO0YYfaWt8s8nFvnSskO
 oXeYsg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4cf03610fdso5202685a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784846; x=1757389646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2e0u7c+q95xVLOhFkTBhlxiA5hudmlDKjB9H+F7IT4=;
 b=XzPBw4lfcZ7jFAndraXL1Gk357HsdLM719RKTeH13LqXHtcZO46E2bbEVQF+JUT/ct
 1l3fPa1FbnR4fZaaXkArMmahFuX5p2e8IOW1u9FDE/phSSxcHJx685dRhFjNjQEZnUob
 lD2xVAh7HSgFonWOXo0Q/g+P+MkBoB2+DaD7tBiY0J/5e5PIR7PSuIQ1glMD82X+sxJS
 OujeOWqK7QMY6xEXGMSfjL+tkRX/AO9oQcATSiyu3hDJBPrEKhDSfAgZ1DbzHZPSg9zd
 iu48wYWCjJzTPoebEkYmNUtJRi6mpG8I1JAo8Lm0VjeWKnEjpNpgyawdU09XIS+hXYBi
 f+hg==
X-Gm-Message-State: AOJu0Yz/poyaMyqeTSQ9GwWpY/SfkR+q3glRRj/ktun4adWns4DlBvlO
 +zoHr5MP6ZZgg/60EMNzcRawnZd3NJ1iG3taHVq9RhErHNBVpfxAF7EWE46CwZYOSoiz36QQIP4
 d38EKn+iwQUJpkYwoKHrK0ffqxWQlGMsSx1QrB8wBKWnz+Vx8ef69CN1JyapYJumlFRaa
X-Gm-Gg: ASbGncvuqsHUTUWYA1Bbh77Y3nVDfkERvcvLdAYhR0u8X+4UFD/T1FNxqTqjl9ZPVGg
 5F0WY7H/Zeypqm8GlruOhKxnsI4B/r7H+Q+p+k66syXHBRmSa0dFmj9PxUmN4yOHSGHFgc15ZJx
 HLxpkGRQNQuQtqHEos0FfumS5U30HNKcaz1Tyq06NTQZ1wxH1Swo5D6/Zxo2Zy6LAusq4UZnwBL
 hg4MmoZ5s8B7acmjaR5dCyrYoTKXYiz7CXIDVYrIaWxV8VZe74V8ck1IfpIGnjp2TnNFNWXmMGx
 erIRXuRaGcdotxQTRyJOzg6DCy2l+9NUEopPHzK32sXx3Z+p0mdO8AsO9Eranih3maw+Hi51c9G
 +4JEEO5bX5U6W
X-Received: by 2002:a05:6a20:3d85:b0:243:c6a1:7a24 with SMTP id
 adf61e73a8af0-243d6f85e08mr14558380637.58.1756784846358; 
 Mon, 01 Sep 2025 20:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF31nj++xU3f6V+3VaEK2uiCX7BG8uVFMKs2L8KKqbuoxoF4wvj5naBSK+GEYqterYPUyzEQ==
X-Received: by 2002:a05:6a20:3d85:b0:243:c6a1:7a24 with SMTP id
 adf61e73a8af0-243d6f85e08mr14558358637.58.1756784845934; 
 Mon, 01 Sep 2025 20:47:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 03/40] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon,  1 Sep 2025 20:46:38 -0700
Message-Id: <20250902034715.1947718-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX/eEC3o2LMWe6
 wyQ+dEVcQXm3NHTB4b6XhgkIrYloQ+UMdnNaA7p+wuddnC5M6IklpRz8NOH8ARDxo22ohOm3/yb
 LzmZe5/KPgzNt7T6jWKyZA6VjkQBbc4RIfDaeRwUiJjuTSpJA6UslR+CJVSVMXDAMFA9Tsq3tMt
 B79s7ERnrzkYHNV9xKRHuA8hb+qbLOS40/utirUc7csVPnf1sjQLKead55IYM5HwMuPvcww4kcd
 H5Ugx7ev7cKjp8YEXu1FxZxHS026wF8+cd43LkiPgpZdCuKU8L3spXkvuVBb+kkiAk/pGP26FOh
 HwIQPpQ7mKD3qjg1M7V/8VhtmTOpCbMeFfVBznGXJX87GvX1umgYPDDTAbIYjx3wvjjFOx9iTck
 bv/nP2AH
X-Proofpoint-ORIG-GUID: n6yTCdF27oT7WphbWlPnvUrlcmNUC7m_
X-Proofpoint-GUID: n6yTCdF27oT7WphbWlPnvUrlcmNUC7m_
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668cf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HN0uuiy-se_EESAQhN8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
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

The BADVA reg is referred to with the wrong identifier.  The
CAUSE reg field of SSR is not yet modeled, we will dump
the SSR in a subsequent commit.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a5a04173ab..a193acdbfc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -216,8 +216,7 @@ static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
     qemu_fprintf(f, "  cs0 = 0x00000000\n");
     qemu_fprintf(f, "  cs1 = 0x00000000\n");
 #else
-    print_reg(f, env, HEX_REG_CAUSE);
-    print_reg(f, env, HEX_REG_BADVA);
+    print_reg(f, env, HEX_SREG_BADVA);
     print_reg(f, env, HEX_REG_CS0);
     print_reg(f, env, HEX_REG_CS1);
 #endif
-- 
2.34.1


