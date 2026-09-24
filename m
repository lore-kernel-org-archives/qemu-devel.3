Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED7CC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKj-0002bH-At; Thu, 24 Sep 2026 11:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKM-0002Hf-IA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKI-0000TA-9J
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OClKZ22224973
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hLmlzZJchkbDZhe/EIIO5QNMzFDuNzDtJp3BDnPJjYw=; b=ibLHnj7lYf46iLp5
 D1eIoZ2ZvPQ7xkoBrMWT431no9sdBL2c+8phhT8dBGkdz7MMpwqf8hAoExLkO6Bs
 E+wxZS92FN4Z+WNfc9skxsjDfmktnrt5ajIcdZQJX1htr5ZWqsSxdWQBCc0MlaQk
 vDYcwRmUXqUM3U1htOSxPKLGcOuH+cMSss+vnPXfNdjzTDZXL79KtlHrpS7saUkO
 aqxVDAXJkCi60eCxnf+SwWa3wP6fguTJt00A05aNVxY3IRh+E7l6El59ttldLmlH
 x+EK8Urr4WgwS0A4EFZP2RHdOn2OfNHxuo/CvvfFuuIBv81RO2N20ZWBj4btcnVS
 9SrDsA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4650nkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:31 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78a5a291af3so2014620137.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263531; x=1790868331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLmlzZJchkbDZhe/EIIO5QNMzFDuNzDtJp3BDnPJjYw=;
 b=fQp225ItQWc+MGoqfhYfvn3KmPp5y2Qct0hukP844UEqi7nNVmvh/TFc6yhI99zygO
 wnvXhHMud68Ox60YbvwwV2i1i0Jvtq4jJaWh061qXtRATidwr3a1TeOqb7dE1+dd87pk
 j6BbM+YtnG8AtLpRZ4zR7+Vlua+p3A3XOVVZ+5In4CbpEDKno3rxCpsd+O39ga7oVTWQ
 Cqp68wyb+gWLm/caYKrwwM321DpjaIJeOfy0Kxu5upGhLETg2OEC6OuIKCZ6BfrTTn9F
 I9x9/EwDTTltmj2msvDGAh1nDBOhkXeJiJWF4sf1LQBAEBZ3yZVDKWvGf9Fl0Drlayv4
 FS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263531; x=1790868331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hLmlzZJchkbDZhe/EIIO5QNMzFDuNzDtJp3BDnPJjYw=;
 b=Nsxv9cjJi6aKitjY7aetKXW+tiDlEbD8fGt4uCoOGC+ffWvRL/DJXn9sGubKl5GLk6
 4ToCJP9JgnK54FNysXnC0Mdx17SraVXpUBBz/0AcMMdClyUndAAFvoAwJAd35L4dcLIA
 uGvR9M4/h8ygeJxcxuzpEVnznE1YIs4FQRGyyMQMsTQza/j8XD3MVG0pRmQ7gtZZDih9
 RSb/kG3RnJZfphUg1NcH8PwEfw8FFD++PE1akJB/fnpJdnMe8vaHJc2jOD0v7Fibq+6E
 Z7TO2K3b/HB3iD+ORWYjdl7aKM00NxQYOvutSUQGuDT/58OKlN/V3V1TfQSIB/rIi2cm
 PBXQ==
X-Gm-Message-State: AFuF++kcZILHOyWlaK1qiKDY+R3N6d4LbKY0TtDjqBGwxe6gMTZM/Pgt
 tSFFWN+n0KiTRS5ADNG4YVHfU6BCKVYihyrVW7yvyCE9Q4vf4PVzVVQ3pA9+rBa9tCNvBexFHgl
 kquO8+JGgZQiO04O79DWh85JLjn5eHhyFZWm5HuUVZ5mUicYkASvxin+n71/Ph3fh6A==
X-Gm-Gg: AYBFou0SLYCMbEsMEiSQYJIKusi/jlweYPVBNbpQ3k1Sk2A4SL3wZ+DSnduc2DQ6P/x
 v35kRpVf4lYjmJR69A1MqOdnOs4HHcSNxi95MDpBh8w6tsGoy4emhJMLHgky2gfE8uCLwZ5sSAF
 v1qMQAe4Ei28nkkZXRN7+x2ML/lYXiQqkocHDXUpQ0hatm7TrVMfywDAzBdCG1I2qWFV37KqUTb
 NLOdr774byIByq6it07jJ3NSY5miCm+sUF47t9jtMBk6i2tgUmjEvgwHue7q3Rs58x4y2XSg2SA
 OmepWv4ZeaaruVmL9r+aTS/c9wb9bSmnPqN0MQf27jkkefe2lWunOQnUJwfPTOYb9Om/WrvJwZG
 w0dj+MjCZ1hKWXabNHR56Iqg4tl8kJpnu10SEKREB
X-Received: by 2002:a05:6102:3fac:b0:7a5:72f6:3a0b with SMTP id
 ada2fe7eead31-7af1ce9e845mr1578111137.14.1790263526041; 
 Thu, 24 Sep 2026 08:25:26 -0700 (PDT)
X-Received: by 2002:a05:6102:3fac:b0:7a5:72f6:3a0b with SMTP id
 ada2fe7eead31-7af1ce9e845mr1578088137.14.1790263525331; 
 Thu, 24 Sep 2026 08:25:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c267sm15341263f8f.16.2026.09.24.08.25.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] system: Document has_work() synchronization requirements
Date: Thu, 24 Sep 2026 17:23:43 +0200
Message-ID: <20260924152353.36209-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab540eb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XUsUnerbLd2lX0N3J0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1qpBPggjbZt_3peIgVtF-Iw-uBLh2Qe9
X-Proofpoint-GUID: 1qpBPggjbZt_3peIgVtF-Iw-uBLh2Qe9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX33JccSlfZibV
 8kZ/dhvnuQUO4LA+GtSy7xrgqFPKb+aZ9+dzJKrPLfFaTldjgCLtxX1Ytc9AjzU2QJ5lwAq6DxG
 a/dHgzOmBFjNPhpJMbFAzQO5hQJUD876hQr/HP2ewxIgREF+HnpJUQJOFXp/WvmNfS3cFYVnO8Y
 8RsxFBWHNvp688TKEgSAE8mI+TLWheiCZhhNi1YMmkElkB/mCQCmj3NcH4hpBV5d+tdCFO0a/nz
 fv8sGx0SiUfT3Eu1/uw9VkQU9ohhQQjPzWR0BupYERZ8rsTU6TwujKkIkDTr7IuczmdmJMK3tbi
 icPBwvbpLpp9BX0NMhObTSu7MTh0ec72kWKRQMvokq3O2dj7a+PCN8qXcn9aRE5muzLzsIuJhXX
 H/qibNoRa9Fv3NlkQBZfGuhaHHeFrR17DLSYg6hqo15NIc8pACu3QbdZIxHDm9+x3HjbaRKwj/i
 0cmHF/h3M+Yl9ekuU9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX0StLtBwqsUIh
 qgv1dHkBXhc0TXxLDmF/mDLcFXDvxdiX1eVxWAY6mHyC/dLWaBUlNkN2zaoaBrolKx7ShJZMPu7
 elCDLetMCydmelrupsrhlYuikiAg/TA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Document that has_work() may be called with or without the BQL.

Require implementations to remain idempotent and avoid consuming
work, and to synchronize state shared with other threads without
acquiring the BQL unconditionally.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260923171116.31276-2-philmd@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index e56eea18b78..d125540262d 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,8 +19,10 @@ typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
      *
-     * This function should be idempotent (i.e. not change state) as
-     * it will likely be queried multiple times before a CPU resumes.
+     * This callback may be called with or without the BQL.  It must be
+     * idempotent, must not consume work, and must not assume that the BQL
+     * is held or acquire it unconditionally.  State shared with other
+     * threads must use appropriate synchronization.
      */
     bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
     /**
-- 
2.53.0


