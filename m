Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E74C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a1R-0002wo-J4; Fri, 04 Sep 2026 15:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1Q-0002w6-NO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1P-0007ix-4I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HIFBB016111
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 19:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vl6d4L1i+c4
 sykN/zuTBI4TPp/Bc6S5aA+qfuafTrM8=; b=luYsX21+cFWZk6kce4Dgie7CupF
 PFl6D41LUaTJLtVV3km8eQx+O0tWqZ3uV64Asx6nXjhkWxaG36U7JIF+uQisdak3
 Vv/rZSMLT/zoS7kg5OyAWOVMB+gtMsjQRPZ1IAUHMbfivogh5ffPYyduNsdNIf+z
 ytMG3p3R1/vi2xomiPlFcWChLOkzmRM/0vS4NMWFQ53ytUGCGdXN979uXSzJWheS
 kSEcRce11BBqJpp2DZT0SVvrWKUuUgmvVmdnEuLcsYoztR75V3BU2yqkQeGbI6WT
 +nJNIWGHEh8Q8YFhL/AFl447VtUs+7P1tbIBjphynfrJf/UU/UJ4SoW93bg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd3yjx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 19:56:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e53b8a302so258651185a.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788551781; x=1789156581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vl6d4L1i+c4sykN/zuTBI4TPp/Bc6S5aA+qfuafTrM8=;
 b=RtsnDEwe5tuZwnxGlOtQGL2t3JdmqvnB+Vn7jnVOhwZzvfe183DywUCTPALCoZ7VFG
 9O9YZFnrPmn+wW6dJUAoaPFkQa3lqTND+PyKrFyI2xSKxZ1t/8zkpr9FtupmNk9g2UOk
 7nXB2bhzLTBfvCxwuYQqOAFmKpVfBwS5BvEWTlUCvJE9ivgKWG4zOjjC8qgpB772yV4o
 J4ss3rvxyeQgjGEfqECqUiRejquqcMg9Bqq/RfCWEmHe3Dx0HReqtKapmGpN/rokYvQ5
 kC5hK0Ci13ouWDqwLmORdHaeN8kVwD88cZ0bFnDwzAPxbb4b6IUtKrzIEw594eOY8ga6
 fmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788551781; x=1789156581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vl6d4L1i+c4sykN/zuTBI4TPp/Bc6S5aA+qfuafTrM8=;
 b=lkE5NQsAA+1SNrCxPrdH+gMBffTtKy7jzImBoarbTpLe0JhcSHqkjJg+CBhdv4nOrR
 IslQeDqtyJYwOeYSrkuwl1f8TpqlcXUDPpyaAf4we7OOtYsSlRWRzSXNH5EuNOm8IqZj
 4ouCNCpvk7nQloB6xEkvpE/VehaxSQ5IWMJKcfvDM8D2x96AhzA2lKKkfA4URCCXUGsY
 f6wBG0aMPosLZHwCsItN/RftKRAKZ50fjkpCmOWdQqkT30DwNXq18DzOYCFyFE2DUqlX
 OdQbzFbJf04cIvwRq6qQFpW2XlaOKGpyntkBMdcapGu+N21YKSPgW73jXf7u1kDuYys3
 BzMA==
X-Gm-Message-State: AFuF++l6d9OillGEghZRccRtz+WPp8oJUPbzbr7KtxxlBR5J7InYRQ77
 lKc04bqE3qpY3BGAbHiX8Ki1p85n7doG1YOo9YunCdBu95XSeppJjjjAdRw4Iuxr6haKdlWo4kJ
 DEP7gh+XSmx0wBlbRLVDGptyaSqFrSO1kmu95IyDEKsTNSTDBhZhGUiI6FHm1QGpLew==
X-Gm-Gg: AYBFou3VYdqmYRczq6sKUmhx8/MHy3dy3Y7x19JgwDz4mI88NpGVZdnFC7PvYJvYcoC
 hNh5ITU+wrvfcs4RIE8APrc4ucX8VJ1/d04bykA/Bzyb/DsLDHReyaT7s/WWT7ZlAkiWCQE5r/7
 TuXx19zpgtzlCFDFzBlQWoF51FJ6JY5SlGWhNocZ71uOnW7DBxD7X1tF/maWZStJBayCifIDuPc
 NkLX6TaTbyVFVaTImO+bf16Ivs4dNAh5NGwD/WaKmLip39j2jT2tGkn2iAEhZmKrrLtAMYOzrxK
 6qhkbrFyM3VXtRZBIN7B7LQV6GXpAigUsMOUpMjYTmzBH7YP+OT/yL/V+unQlbkZNZosZQcEcD0
 f1u41mmeNG6S9P9cdth/Ib9AnqFFOhvqIw26I
X-Received: by 2002:a05:620a:1a03:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-9398013bb1emr837588885a.0.1788551781262; 
 Fri, 04 Sep 2026 12:56:21 -0700 (PDT)
X-Received: by 2002:a05:620a:1a03:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-9398013bb1emr837585785a.0.1788551780838; 
 Fri, 04 Sep 2026 12:56:20 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406871b6sm29117736d6.32.2026.09.04.12.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:56:20 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v10 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Fri,  4 Sep 2026 16:56:06 -0300
Message-ID: <20260904195610.964829-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sWApv1_8U1oOvh80h_uRKm85jLARwkiL
X-Proofpoint-ORIG-GUID: sWApv1_8U1oOvh80h_uRKm85jLARwkiL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfX+ojGIcIVDt/d
 EAyhZVyEQH5AMUJWOKMtLJXz7EQzIq0pWN3JIJV0SUzB0zA1D6r5AJ4SkueottIawEALJ9Ik/05
 EIpwzhZ4ep2kc8M4uQROIANhiRn4MGw=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9b2266 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfXzy34qSDB4Gy/
 Bv0KVxzsP8Vtnze9SMZfZVdSarNMVcQ3hJPBC7XGGEz0y7L0bdO16P6XemWYLf/pT/Emj0AS1i/
 eCYSvucvkk4rJht+aAS3XKlq72OOt6hH+Ysh2AawHpI3Q7+rcNakhntvBdk3yNg/U+ixoR1l4Ln
 ia2NUo3puca51dFmcGWUR7Qb0fjmDB78Te4wIrkyGQfn3ROHtlqc36I+HIL8wCste+RChzNrtSp
 QYLMC0RHv2Di/n5WyYB4u8Pq9dnojn35VfFzif2XDDf/U2VNjl+5rLhGNndDntXdoLMO4rXzvao
 jA8pTaNNP+MLwIGDhM2aJ8vCMvS9beJsr1UVCNX/sxQj9gluakJrFFwRWRcuCT5vqoKtRIRr9x4
 +M8dGCGPg5stoS109uFoO8VZdEuGe/6y675IDwaGMiy6VNDK58S3T4vUqIESa7u+8yJYZh5yIbe
 u6h0F7MEnvNjjWVTc3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 652311ddef..185474a8cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3096,7 +3096,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


