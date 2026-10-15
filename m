Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C5DCCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBU-0008OS-1O; Thu, 15 Oct 2026 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0008Li-OW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBD-0000Wx-BQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG5dGr3493204
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iIr2sa1p1zA5cr8gk03SmjGBCFyXulMDPbBBtnTd9Pk=; b=jUnG4LhLRqV3ZmmK
 EAJBB3KmqwMxPLYmlD1WM+cSWlQb+AN1mPi/B8m3OrCcopPkNQONSLVYgAdl0kjq
 druEHSOeWo4tcIDehklfUshEIHH/GeKYyST7/TgDlLxWCuKmqdHOUvcr3EG5y+LB
 F/fo5GeXHHW8JX/O8GN00GHccVkhUTfjx1JE63v58Dna5uzIuV7DnQPGXnrRhWiF
 5hRt9j1SWYHUoRl+BfHVgKBMbgs0VpHHmRD9Ja33rbFTMzUvf7dP8Xg5Kcj5tSgu
 gLAfzUX69W23IJ5LgS0M0fbQauyeOGGY4pCbfnyBVGJ780FDpE57f0Rj8tNWPCbz
 MLYnEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21wrs6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so15754758eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092707; x=1792697507; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iIr2sa1p1zA5cr8gk03SmjGBCFyXulMDPbBBtnTd9Pk=;
 b=Zenw2xjQ58hHE697cLNwXynmCdZoQCP3MdGgsTu+JKINUOhb7IRZSZFMlk64VvZLGS
 6L+zcr1m2XvTurBX//BKH88N4xQBnnabAc2IExquzALNv9Em15t7kvCLif3YleTXOM/I
 EKMsX99Dp8HRw+sMKGQjGRasTeLdS0PPpiCcsr2oP4a0k0T4vynFVBduPfbCNVe8GeJW
 EvzEdnKFJXAApc8axMUJakNenUQZ5PTNXhmZfyoev98pfa0ngIoEMb4CzSDg3qOc3XKn
 Z5APTm5xFJC2NsHCriE82InD8lglx+XPI2iC6V0Y4nVJ6xixuz+0f8S56Utmu4k3Vu8o
 sROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092707; x=1792697507;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iIr2sa1p1zA5cr8gk03SmjGBCFyXulMDPbBBtnTd9Pk=;
 b=EGHX1xPk5r6/IoUzZzvODLfD+XDSVR9RuKLSZ1K8HzQY5chm0bWEXPkVJkHKOYGZLK
 nJwZuiAYfabk4EXEyqHKeU0HHhtWogwzZtQG7MRgOYo/bSGbnjMRfEP3ucczNlbHTy43
 OHQdcwR5ClUyUJ82JRajdowwge9XcgKa2pUNRWsMenziJjloOLEZJ2eRLYGjtCrI/Brv
 z9JLccjiPrt+qhyuG0TRQWeFC+mXxHl0P5BhLLU9Fx4oMOrIWT7tEF0ewjzD8hhWquJW
 XyRnJNCl2BO8T3k0tDVdO+zp1AH/9lRYw0oTfcYB2aO3UHslvqs0LjS01BAySkMHtMFa
 Mpfg==
X-Gm-Message-State: AFq9FYIvjwiP9t+3KEH9ERWAGWHynpGx40/63RxmO9VDTUIsuF6W//kr
 6iowVsN2zyCjrVdWHhlE5TRVKQyKSJwoYd44MnXyTJ8SPkYimZs3IUH5b1t+n2qsiA011xmdA/z
 lgPmSXycYjeCdEbh+UBIgpRc3ijMKETtXMTrKM4pISf4S9+w8XBdNlzOrqW1VYXr76g==
X-Gm-Gg: AYBFou2F0eu4sstq1AjvTxPXfksSvgJ9xAusj8Ov/4417bZLU6xvlo5BWNIU7MuVA2G
 r+dhDJATEgXUifXbLdbCcjF6n4TyxtcwyIihYMyIYenitu4NCz4tlv1rcrREfRR7UQJkx0cUrIy
 WMD13GuTL3fsHxSnSGajspMGykSikw3s9IC+zp/dbMgj/lzH8v9n5DXEIIa7gBZ+HdSizTPlbgp
 2p+WJpe2TEDVxZlC3BfFr2SpuyGtkT+w2VIkoMQHEdUVJiEiTUuDQpgslSfX/l7wtxHItlWNAxh
 29ek5JwA9g7wYQFpVkqj+pjpqkpR3JdOHH6J+ozYIxmTcm1sJ5MriZWGnLIGuV2sGLr51HYxkUb
 w0c4F165PRVZ+qyebus4YHGpj6ZfFAvS/X6diujVW/LA9khBzRYfmlWVJNyK1
X-Received: by 2002:a05:7300:f496:b0:35e:56d2:8fd3 with SMTP id
 5a478bee46e88-35e56d29303mr6855206eec.31.1792092706497; 
 Thu, 15 Oct 2026 12:31:46 -0700 (PDT)
X-Received: by 2002:a05:7300:f496:b0:35e:56d2:8fd3 with SMTP id
 5a478bee46e88-35e56d29303mr6855157eec.31.1792092705814; 
 Thu, 15 Oct 2026 12:31:45 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/20] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Date: Thu, 15 Oct 2026 19:30:58 +0000
Message-ID: <20261015193112.145326-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MyLPaqdQiECcnhj4HQi6S6RxM2uTIbMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX69CCTGHXPglg
 DNXO/9Mlsz1VXCvHEOoDXpiLwqk4Ah4pjKhuH+TOpBWI6E6QLq2ke1H8OXvGdDYnaIFCtr/MklY
 yyGlIYGR8NekwX+k8Rm0oxnJs+wP9mUwUdikVCiq446Td51uRf2857pXQyaFvDS1G+zcLtLUElt
 1DvB4ZrNT6ifNlIx5sU9WBIPoHTGdFlP9ZABHGbH9HZiWRjT/3iiZxPUJ26yYM8065GEWCp4HI8
 EeInQzwra+pZSjladnANyRKfMK8o+85Q+0XIz9ZqPmADqO02GwDagZ5KwCc/Fz/2ARze+j/Gyj1
 JUAxmd3kSQJC1gqhrQKaxVsm5aThbNQJmWc0hzXJ9yW15tx81HFGIthGUEugzb91Sjutnr9uCeV
 ww5X0BiCxkc4U1SBZd5CwLGXeC0MlREW2z8t6sTNZJZPXIVpkMWJkFuz8f73lWeT/jrdW0TkpAn
 Yj0XbyN69ome/7sWoow==
X-Proofpoint-GUID: MyLPaqdQiECcnhj4HQi6S6RxM2uTIbMp
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad12a23 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xXatPaY6A71EF1Dc_LYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX/VCi8Z9tU4Fj
 IAwAkp7T/jorwCdjLZ0CO9qT6kTsTcT0szCD9B0XsauVg6precjtimTZ+pI1kt6fLV5xCKVpJvN
 kBO+VSgGjzyQvn/PnYYoBa9sHViv2hs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150077
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd8..00650a66dcb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
 {
     return env->misa_mxl;
 }
-- 
2.43.0


