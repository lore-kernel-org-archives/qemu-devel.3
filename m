Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A15CDB476
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkO9-00011b-8b; Mon, 22 Jun 2026 15:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkO1-0000uI-0t
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNz-0001sC-I1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVj5F2691547
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JbEUpwiuB5S
 /wePK+7Qm68r9sNPteyFV0cyQLCteb8Q=; b=cSMRv2F8jOiIQGO0M6t8xR//LrP
 BM218BInjKRISejJosKQAhFoDf8p4Asjq//Bmnpwp7fHoFcm3nyo8tptcrv85oio
 O3nPC/VCG9MmBQebJgU1Kf+UgT56sd8hBLjjc/dQOw8da9sMdxjIFhkSf7x/CHIr
 Inw/TU/OaAFAJU21KdHpZlZYumfc6tFIix8Cn92mjnZu0ocG9H3F7z4V3cRRPrpb
 wTb7aLMKc7tYQHL7Togc9pO2UD2TszLg7Er0NZClGHvBEGKSGSKO12r6Vv3VLpgb
 GpD3AyCNRth4d27WG9V87qp+lA2lleBzrSs2rbgQFORpmuTVJVmnoAkfADQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn1d3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso869108785a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156755; x=1782761555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbEUpwiuB5S/wePK+7Qm68r9sNPteyFV0cyQLCteb8Q=;
 b=G70NYg2Suve8nWnOiflMQqaDr/aw4mAi+8pykfERfI2MrOcUYWQg+dsnUovQsnt45Q
 HPfWNGc/sWuNqg7vCjctmtJVZEXfJGEWRu52LGzxsjGn9HYFgla2hep+dUDoVnTRqpnG
 /fBw5ajbF3llKKvdcj79Iy1IAjd9tQqyFF/L67x7rz26Dtjl2d/GahgwVqJ9ck1nf4sl
 ieUe2INnTpgO30V0uC02/jAtmOoRqns26XUviVmz3bL4ILY91oue3D4lo18/Ojvt8/Vv
 pPXYwqyqGaad4D7JiFh1ui5ezLBfdA0xs1aXnSZG6TBtQWZnW30hMR8uTfsoTEn6jZUP
 CWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156755; x=1782761555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JbEUpwiuB5S/wePK+7Qm68r9sNPteyFV0cyQLCteb8Q=;
 b=rf1ByWGEeUNucPx87ezMoz3z36seuhEERfUATj6JPLpNu/3jipesSN7qzMetfirRmy
 KcVBThRuSQPHbMHhjzniMQpLFK5Aa1uH2lktEZk7bg8U5VjbnU2+lq8RAfG9KNZjkk1c
 dgO53JRcxM+3EL/gQLTem+28lftQw8bZZ4GeSkyps9/UvNnoMb6BZMyG5wEKs2WnhxRu
 Mi3dF9g3ssu7j7MCcT8mOn4kaOf/ppBlNGi9/l1Tob6uYxUfUfqz+z2uAGrCNlKAJrJ4
 eYpg105hHS5PKyOgC6ae2WCJQ6K3VqTV2S6Xf77ucZhtog0U1Zfeym1nehlusMmGn6jz
 XB+g==
X-Gm-Message-State: AOJu0Yz/SXp8Soj0fV+eeHkUMUxrT0ErnQ3zg3JPUsNp5CbOVlqn/a9i
 53iIo+AKz293th1bnIxjtJ5ZwKGfrUUiCl2NyLBuS5ERCHOZWTy6R4jgfNg+HJkI7rDr9ONITG4
 oJ++MyADIBQ1ZX6wpBblKQLHlOB9TYdNrnCiFtg7MqUP3z2G+HXgIZqiQrcqeE5VfzQ==
X-Gm-Gg: AfdE7cm9PBgO72iWEW0UQpOM4VQMSiZyqONBUu0YW3FDBI7MQ7Dr7toaXvO4f1Tf0MW
 VYDIwj2FlQgzZj4JNzFP5sd9xZhUzY48pgVaviv2HsMSnuDB3GPafErp7j1A0nU5GCR26dpD5kV
 fskK2sG3a/N1tGqWDkDjP1sNf/bq0MiKwkoVZULbkFAByWWy4Ci4vTgNn9xmRwdiJah7Y/upraq
 whQBxCNdOtVRrUoUcfycai+5C4AFkIK3R32aktCvlKego5DvIKYGbgEO80tQPS8RzCju+CftMQq
 KgXZanw2TDkS7xsRocbMMcvEx9Pe7Msk1fhWW+iL1zWa2x/S+7locnMR9HCP1MGH61L+yk5l/Kf
 8LYU49mVH59gJSYGjnJiX2ejJxuufYvePNYLzo9z3iejmAg==
X-Received: by 2002:a05:620a:bca:b0:916:421:4626 with SMTP id
 af79cd13be357-920d403aaa8mr2328061885a.37.1782156755054; 
 Mon, 22 Jun 2026 12:32:35 -0700 (PDT)
X-Received: by 2002:a05:620a:bca:b0:916:421:4626 with SMTP id
 af79cd13be357-920d403aaa8mr2328055285a.37.1782156754406; 
 Mon, 22 Jun 2026 12:32:34 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:33 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 15/24] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
Date: Mon, 22 Jun 2026 16:31:31 -0300
Message-ID: <20260622193141.1449724-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5lLSYij8NcBMpYD2WXBVqYNoUzHQx3u6
X-Proofpoint-ORIG-GUID: 5lLSYij8NcBMpYD2WXBVqYNoUzHQx3u6
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a398dd4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=n_Gjmr79VRyvsDPUZ2MA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX5uojDAEUPArc
 2lNfRXESA/H8zqywOsIl+TF9AM5pHdr2MP/6ClNPQQmu7KYRkBBuU2mYEZAHoAaBqfunsXY4tdX
 +L/r5rrki2+tIYmiqOJR3AQhqXwacXg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX2cZmGhM6Twvq
 28CSa3ZMfW/KL1CTrqQzB/J7+YlXs+o1WVmpajPAia6G9oVpBOu3tjHg5PgDS6MBd9AM+u2cQdn
 o90ZOPGXwRtVIwMGM/Su4AW8XJV0CsDHAmwJHEnS4Tukgc8YFm+Ft0Zp7nK5R+xblcN2GgWDukD
 ZLb6Lp15pOCM2qSV4nhevwsjX7gVtHBXAU1f51lmK5mcUhcCJ+SKlgCrczh6r+O/W9K6L1Dqu22
 9W/MQtDcth6H6BvPi5wmgVYJKJVeI584IyfNF++poFIbdU5CtnuOunfMwjxx4AUUQI69uOvyrfI
 AXH+UMDIWyq4ED4P+JJtwI0fzH8cWXk7/0m8JwEactWxdDaCWzIzKo23EBh5iElXU9gvNXyw7Ff
 vYbe5Dezp72rRcTs0fiuGUuLMsiIZM9uVtR4okFx+uIeRx9ykoydLDUQ8ZfUwT/Q6nw5vYuFBuQ
 VLjhWxIzE6TvlLe68JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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

riscv_dump_csr() is a TCG only function but we'll have to implement it
at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
ifdef while making a note that this function is unimplemented in KVM.

The csr_ops array is also TCG specific, thus the for loop inside
dump_state that iterates it is also TCG only business.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2b1fbe4b0b..9c1b55c3c1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -605,8 +605,10 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
+/* Note: this function needs a KVM implementation.  */
 static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
 {
+#ifdef CONFIG_TCG
     target_ulong val = 0;
     RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
 
@@ -618,6 +620,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
         qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
+#endif
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -655,7 +658,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 #endif
     qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
 
-- 
2.43.0


