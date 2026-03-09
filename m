Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F77F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbur-0000yG-Jb; Mon, 09 Mar 2026 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuN-0000p7-Vp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuL-0005DH-6n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Dr5U04027525
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=XUc/9310lU5Nj4SSMxJD5uCW0KDRlaZRQ0efIQjhj24=; b=db
 2K1e+OFOTig+al8oXSNstY1TAi7kAmrATgso9QxwcgUHLarYiXzUdI2lxdJa87s0
 mJvSaqpXP+aaNm/l3PsqW83fAtGAhwnjw5yhxM8bElGJbj23PIb2CBqSnG/oCO1t
 XJl8kzlXZez/+90OqVd5kFqlL7fRRExGSzBKzA8yk12gezbU0WL926/M5HcHNcrD
 +U5x+Vx5+TMl512+1kZ5J+IDAEGrAd7GmYrxtLXVpkDYQNSJEbXFB1G635osauk7
 a7rXZ8EqdLHTUA7sCZV1FPRfwFobsHBqwHfchkSh6CZqb8mktBrZRHYm/1HP9S54
 /cV5HwUjKdqdoIjridZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy06gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be21f89332so7079842eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067711; x=1773672511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUc/9310lU5Nj4SSMxJD5uCW0KDRlaZRQ0efIQjhj24=;
 b=UH+dByjMvjiEQxMTHPOgJsvB+xrj3gY2IFsFXCfXe15l6kDN+etz1zN/+G0gRPlTpT
 vopegz5tUzhnKN9GIThFYU+/PYm7jl8UIyPGfS4KNtFNGrZkdMZ2K+DaCEL9kTccDmIV
 d1ODARCf7Jt0S0qFmcUuSkELiV9HDSXyHByYz6TkGnUmbNY5KXeGGIeg3VOOP7Ul/ddV
 wU9wey6CDIY8Y7gcrZQs0yd6HZYOFcm7P/4Mz1MW83PPy0bnewrHK2yxzFGcVz3yBG04
 5yXg9l5ec1kOH06a6tN6Y4KTCe6c+vD9AFwiZ8gosIwIzn1BB3xHzvrc4cliDNp1aQKa
 W6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067711; x=1773672511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XUc/9310lU5Nj4SSMxJD5uCW0KDRlaZRQ0efIQjhj24=;
 b=sAf3EGJuEsPzbdQjgXdAfHUnddANjue0yEtrkvyjb2F5/F7iBfsKtWqiEH/RrbjqLM
 6ihDFq+SwiYBcdTzaBhoKg4Xe33J9mMxwj3gHyC5XnZE76ktA1KU05tv98v6zI3oVAMZ
 zlVrUmTNu/pcDbniqw8vfDBGPkJyAOnkd4qCLAOeib72M23ixVTvCtM3YXM8eb4OnOX5
 wejKQpGFBVv0eqe/fw2eaLeC5ONDr8Ffv7iHpxhq3hHo/6GL/WKTbx8VaaTUaVNoFPP1
 iEB0pbU6Gl9Z7gj9UDs9hKl7FUUQumfE8/VS3R6n3FLX0WkAJqln2ZC0SqTsT8cexrI/
 Nq6w==
X-Gm-Message-State: AOJu0YxPbCQwbqa8HC/4ToYjwkWKygom8PcMExW1EZCS79QlP8UgAM9M
 L4x8eRqZu3XdLDn27OxjHl6Msd++R5knZYk4PQfeNZVu2AUKqRb5FU3zdM5d8rxP9SU6J28Y6MY
 fO62Y3NhZCBG+FDeDOt79wL8XrFnIihKzshBxCQON18gFzdr4q2YychlIy9EVUZgyaQ==
X-Gm-Gg: ATEYQzy1gHalb+3O81MsTgCZnZHTwEiL9nEivGPrx4tFEVOP+9uJ1eOIXAQ4Sq98JZD
 n2IsVSEgA+4FCrEnHxOdF6h9p4BHPh2n/Tj0A32m2LWH5oLABCOxPQk3u6vPkC2n11kSQ4RAbHY
 eZJz610ZlOdBhJ8euUqykIZ0Ksu9vjoV86T7OnhLlVD8QbZr71shgBtnAdW/+7IGTnomqhO5c9/
 OF7iT9on2LPcn1qs/DITp/pgxtv16W4iMfqAS4jCDvEfJN4w+KbbAMDuKkcy/v8HBCIf5Xj/Gyg
 uHphOYOe/d/v777Ejcwfgr2XpAILE5QDtFMqwrC/aMmTlEJT4geN/eoLEHehFwyIv5mkhBWDLka
 y/dKdOfEaAUtvZqb+xKXta8CTuSKBt7rZvcFYBrx+MGkcpjJP+mqD0lVeI+Sij3hXeStEFQ==
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id
 5a478bee46e88-2be4dfd0b09mr4280864eec.8.1773067710890; 
 Mon, 09 Mar 2026 07:48:30 -0700 (PDT)
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id
 5a478bee46e88-2be4dfd0b09mr4280851eec.8.1773067710375; 
 Mon, 09 Mar 2026 07:48:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 03/35] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon,  9 Mar 2026 07:47:50 -0700
Message-Id: <20260309144822.877695-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXzXewdSbU7rP0
 TLZrt1OK+tRlbxd+VC9prxLk45gJJrevs4/4iXRJlwVV/HjdMpTyG+xDKxjcCB+ylQaDtzs7j8B
 HYa+woq2Y1DeWbE0gIuY6xgj8dkknsT4JGBCK4p4VBBfaHx/rRWevcbrc2ehkA52b9GnV/t/Rc/
 h1+yWnv0Fo7ciABXBCczeBtuFUq/+SKC8pRb/adm8KNELvv/JdeJUXNzv/+bwr3yYMqmkbQw5nL
 o/dlNBzUQFdRtPXBZkh5qgyec/bIirUbtrzIsjyqMN1ucIbXKBpcJar8H4t8NxqR6edO1dvprTZ
 HWVaGUHlEmu7Nq+BnqMT3eIg7/YM1lPvBZg+qnI9tAAoBJfab9wHK3FGwFz+JpdThAaYoCiLe2B
 nW0Kd9XYxqoC9yeSLiHdcixrHl1k+mpZ2cxhj6McB8jeBhK3OoCZPSfD+cOcM0wdyOul25MmR6b
 8KB48HYVYNsmsKnfL+Q==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69aeddbf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=gBvMSl3gaBqW46z-JGgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1d06DPNiLO6oFb_3d-Gt734OTkwkuF2F
X-Proofpoint-ORIG-GUID: 1d06DPNiLO6oFb_3d-Gt734OTkwkuF2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
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

The BADVA reg is referred to with the wrong identifier.  The
CAUSE reg field of SSR is not yet modeled, we will dump
the SSR in a subsequent commit.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 58a22ee41f2..e61ac10fbf3 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -117,6 +117,14 @@ static void print_reg(FILE *f, CPUHexagonState *env, int regnum)
                  hexagon_regnames[regnum], value);
 }
 
+#ifndef CONFIG_USER_ONLY
+static void print_t_sreg(FILE *f, const CPUHexagonState *env, int regnum)
+{
+    qemu_fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
+                 hexagon_sregnames[regnum], env->t_sreg[regnum]);
+}
+#endif
+
 static void print_vreg(FILE *f, CPUHexagonState *env, int regnum,
                        bool skip_if_zero)
 {
@@ -216,8 +224,7 @@ static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
     qemu_fprintf(f, "  cs0 = 0x00000000\n");
     qemu_fprintf(f, "  cs1 = 0x00000000\n");
 #else
-    print_reg(f, env, HEX_REG_CAUSE);
-    print_reg(f, env, HEX_REG_BADVA);
+    print_t_sreg(f, env, HEX_SREG_BADVA);
     print_reg(f, env, HEX_REG_CS0);
     print_reg(f, env, HEX_REG_CS1);
 #endif
-- 
2.34.1


