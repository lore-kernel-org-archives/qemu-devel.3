Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08ACC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QVq-0003dX-NJ; Wed, 23 Sep 2026 13:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVI-0003PG-4O
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVF-00010Z-FI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTh0l3938136
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yfNMtIQVH/g1hzhti934J8Nc6bZ3Ap2ifCd+bJEPDr0=; b=eK/WNOIR/wj63QFU
 Z65UluJyeKplPpSSde9H3q7bWyD/lSk9kfgth3H34M5M4gJtaoE5FYJ86IH0GoQZ
 LYqTAuJ/1csNE1Llkzpt53WUw+U3Cv117MVQcNyF+xaaTnuBpBycJqPJ33DKThmW
 r632nONfQB88qynArqWdpT+rYP6D9WGs/pO8MkYzTnaM1ZOtF12FvROP1JlpZ1k2
 yNuozuxSzaiDHT6Byqfx94Wl9RrF2ERUDxuBiPeyP79Hs6Sk3zatzCQM8yhZhV5E
 MhXf+HjmKRhJAIYn2rscv4L7fTcQS8vBzT0e1HlQM2ZTkgLpjf/mrzkOVsZO/Mh2
 /z5R5Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwma28r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c93c294214so501728e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183486; x=1790788286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yfNMtIQVH/g1hzhti934J8Nc6bZ3Ap2ifCd+bJEPDr0=;
 b=EO8ePoC2XFMuwGiStxiZmVJgm4Tu9tdpJQQTgOhhfyw5Hze0q16H9ttqKlr7nzV95/
 bPnlKA8C0V8hLXaAMpBILkFIDmIgjyon6DW9V2ZTaJPoGU4VHfMEEeeDdev5LQpMqJ1i
 LEGeuuXulreXRjsMIB+t9TF/LZIsjZYK5kBCDxF1FzGSOyZfCAclV9U4/UzdfPbtPxyR
 wLHp/tyYiNxLH5r6Sg8sVQ2njHJdgC73nNa3iYVlr7oMrL50N4rkzXZ4AdA+GMWCtCQv
 tqyaf8gwzLy8fHWBLOdoli1/oCZ8sOrFCiF1ckld8bCKYRP/VjXE5GusDaFdETZCBnud
 CFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183486; x=1790788286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yfNMtIQVH/g1hzhti934J8Nc6bZ3Ap2ifCd+bJEPDr0=;
 b=qsAWrEIRhSfC1RUas9phnSUAkWpQ/p1G7FgF52FYUz3NKHuTUu5qMmSrPuUEC7aBFW
 lht8A26BaYltnSYS1VCqVn3UO5XwH76lGL2ZmcriTun0c4/4ONeDRKfTW0j1WswI3xza
 7yx/wnJLnpTyn85BrmA21vVS6F+vnbODYgKlzW25AI+IJkR8CNUR19f3z7+yWpOupjta
 GaXTYofOVqaeHLE95XrFDfROs6vLP8MAEZYuB/2u9e95P4/1AmUgV63c8TfTjSKC7ZTm
 Q/nO5nLAqN5OFJ26UgBeT+TwN4z/SIt5evNUsYtxc2yGD3H+rYPO1C+d7tsBVpbBpog8
 tJeg==
X-Gm-Message-State: AFuF++nIlM/KFJjvgEmhUmVAucrWl32+pkyLaoEfabAfZzGHkKjXcHdl
 9ts6o1Nq/s3pg/5uLIYke+aPz378fE5thuV7SjLMfs2ILjTb/K9lnyqGI69+IzYtNdjeXQAgdNn
 OEvSkYd47ItswnoOIQ30Q6I5SKph4XfW0CfQ4SqZzhX/Llu8Coto1Zh8tBGQymzwYJLIK
X-Gm-Gg: AYBFou0n1xePMZFOzwYaYiq9PkOYAdysEQBO2mpqyRb27w1+5v134NV9flU9eiwZopO
 OUADXE1wMMSLtXgHJ43mzaURrIxXTBken2XjfC3uBfEbGUCTL9ThrOR3RMbTqpjKN6/gyJPLkTJ
 3ZiEQO5gRK1dLhIor2Ar9pN9Jvd0rZO267p3LTsja8Sq4U4b9Rp/vobb8KRaNnY/kD0xT/inZRm
 lYiMnGPmnwX8MQ5CQymmAB72pnLKR1Y+GivNgUJFuZLMCnS9pZ7Wch/fe1KTHWgxGOmcNylvPMN
 UxIV5b0rdCJM8as6VesIiZC/D3upQ3g+3muN0/qs/e5m/k4wOEJTEgS/TsJOPariuU+OxMh5xJP
 OE1WcwDXDousTCgGi/59+cbghkWDCtKQUThwfvBJO
X-Received: by 2002:a05:6102:e12:b0:7a1:f7d2:e845 with SMTP id
 ada2fe7eead31-7ac1d2d8af9mr3158159137.21.1790183486342; 
 Wed, 23 Sep 2026 10:11:26 -0700 (PDT)
X-Received: by 2002:a05:6102:e12:b0:7a1:f7d2:e845 with SMTP id
 ada2fe7eead31-7ac1d2d8af9mr3158143137.21.1790183485919; 
 Wed, 23 Sep 2026 10:11:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868886e45sm8575710f8f.31.2026.09.23.10.11.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:11:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 01/21] system: Document has_work() synchronization
 requirements
Date: Wed, 23 Sep 2026 19:10:55 +0200
Message-ID: <20260923171116.31276-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX32VD6qtL8ep5
 y+j3vOEyfNKHveYcKgehCFD/gdnfyxiHWPjzHN2Lc7dKEoGgAqV0Cj4fgIy87o1Agm3YQj++cFb
 FN6Kpi8dHdpVcq6UttSowNXQRi4Q4f4=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab4083f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XUsUnerbLd2lX0N3J0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AFyiQky01VoY5O2eq44nB_BXRp5cgpUX
X-Proofpoint-ORIG-GUID: AFyiQky01VoY5O2eq44nB_BXRp5cgpUX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX/oJV825b/QfS
 986gDUNzDAIT80E14anZ6ycZS5/Pa+RJbCeFlgPudECPpKvdXaBb2+H+u0Qw4rSj7Sf5aVuMEsR
 v+DyUvTc3s/GNZGHfytSUw00a0AMuitN0ae2U2Mh+eVSZrmmGOKqNJFhmG4SwX3fwHpe25eWhgi
 Mr+mYBCwcNlWMK2baDA4pzrHv7rC5uLFwCqNhSxcA7g3+jnk7Fu4BHoAprjhtQH3UvONoF0e8/M
 /29ixGl12zLJl2yltxXYH1cVPbnmTLa3Mu4xt3GQzchT+93rO2qW/deOvBuEKPx9HVAdArgHJp1
 mdJrQ+SWb8sBuFEkgpxVV3FcuQBmxEyAPs9olTYu0xneg7iJ7G6I+3u0oANNIQhzSsvDoZQOhXY
 vdBWx+V1pNjIjzzvUJjUyoqUXFudz9fCS2emvTqsamLI0LXpVm2ptKv6fhqPHdLF+bNXy1hWY6f
 DW7ugi7W8Xcnr8uHrHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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


