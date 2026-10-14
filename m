Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF49CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ab-0001Mb-01; Wed, 14 Oct 2026 17:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AX-0001LR-Ge
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AW-0000hD-1z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbELH301147
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n6iwn0RVSBt1UI+L9sH8dEvRd/busJPAgCkh2EUMJb0=; b=lptPvSRDCFHoo/q1
 8hL/WGZ1tnD6Vej+P/6ik/HA/OoLM+xG8EGlauxl9jKi7TIfq4klAJKMmGQyptrz
 nYyqyMhFpjjsY73nmRcI6aPJjRzb+eePuVEs8EXvqOcE0rGQsphb/wVCfrX43zY7
 oOMnX4LohMP3hwtRxF5oGa5p9dyjiJP3lti6OXvWAZR5qtR5jc02zkTBGXjm+O16
 Ovs7ncW4WUvbP0IEBuTyKUyERybJJEQPE4+aseMm6WXsTpFEqcfOhvnWLvdqjso1
 OyxIGjiQRLjsXGU2zmUdVEnxlMocoa7gHYyrBJBTK7tTYi++TB0L2dyYO29Ybn87
 zi3awA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623gq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4454403eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011946; x=1792616746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n6iwn0RVSBt1UI+L9sH8dEvRd/busJPAgCkh2EUMJb0=;
 b=a8fLbtyF03BU5J129qpu7KvugW4sow6+LQpajMWj5BFbfPjs7/iQ70UaL00kHgsulm
 DuG1JgkDaOWLhUUOK2t8Saj32YUzBg9GeaOnwMt8kUYBI84BYMHI8OjW/ANyA8Yae6dQ
 z6nifVMLhtPJSpBIc4zNQAOjlxq702+b30661iklZBT1pWlUKWXLRVAlLMTrhrMuFyos
 pUNq1baELHAVvBlZfEITiyOIMLT1j89Gvk/IALLemjHx/QJnWyVeFXVcv7XPyAOQ8cAa
 7eWH2X6NARLwvmokjHu81lsA1EqfWZQ1h1JEvdwL4voSgARLcGuJVNZxYWMJLhHfg3n1
 ytgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011946; x=1792616746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n6iwn0RVSBt1UI+L9sH8dEvRd/busJPAgCkh2EUMJb0=;
 b=AWvcz9GXkF+7DXXAS6lbAuxrSsw6IDb7oLJuljFCR/aNe/oh7d93CuGQusJ3dZFyD3
 VvhnixmQMEOCLRJFcCjQ3dfKnxcdzYfE7Me2i0ritMCIAFN8HYSkKO+1JHP9XjBoskvu
 oLVhNm8XLNcYAFjO7QNX7tKrr0NqKvQLV2iSFt3TFnVCQUlvO1zqNomIc1doVg+934G/
 2jYrU8dmJw2HpkhZh1pHjOmTQO4Mqb4U8ajzaxk2aYyeorVL8uMwEjdFnn+nXgqhus/9
 qSeGWq7WOzKllkdodiKkjGCHhO+Vl3gWb2FkcQlveVX7fM0Tguhom0r59twFCCHIyn7J
 pnQg==
X-Gm-Message-State: AFq9FYLdIIzNPo+Wqv2UwlS+VcQI73OYcPz3pbcNyyp95sNuF+aZJ+cT
 o4euWT7ddjbPbq93SzNBbTk+YQU8o3lewonhfwnfWG++S9LC6Xugeirea3ywo/4Oig+v8dz5Snu
 tJg+YnvR9+ExxhIjPxVRJgjk3jDiSi1seklVajacbrggF0ntdwHIpZBBI6FWZ6qra/g==
X-Gm-Gg: AYBFou3fDCJCtnCKdQw7aGID7bcimAqTq48pL7iYrqTlgwbniJm8AucdMpgV2UQCDhj
 qWAsUyjdGN/U/mefabHJ0VkTs5AP9YmVSUB+aYqosBW7JdtXDHVvTQnnNqdvo8D8z9c4NYSuxcb
 KX4765scx7efHDsyz+X4Cw0h4qpduH0v1thNCWflPhMBxM9zgzS38NbBz5m13crb8M8Z3L1X+Kb
 JWIK0m4Fzqzo8Q1DQ8CYXIxhzwgS9+0V12hEZ17Q8sfL0ZSvQ2GneP+dFWbHfEFfFr6QhF6aAfb
 BqI/6YR+XZDW90/aqIXiQvpedB2OdcVrmxfOawEPHNOgYstiGsahOBjMTklGg0CRdTiDioorxzq
 GSrPYf588+KMsoTQaCoB0RMlmT/iTjx/azadJzqUOKEGdJQB3GRxGlC4bS3G7
X-Received: by 2002:a05:7301:618f:10b0:359:8492:20ff with SMTP id
 5a478bee46e88-35984922299mr16963067eec.12.1792011945675; 
 Wed, 14 Oct 2026 14:05:45 -0700 (PDT)
X-Received: by 2002:a05:7301:618f:10b0:359:8492:20ff with SMTP id
 5a478bee46e88-35984922299mr16963041eec.12.1792011945076; 
 Wed, 14 Oct 2026 14:05:45 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 02/12] target-info: add target_hexagon
Date: Wed, 14 Oct 2026 21:05:16 +0000
Message-ID: <20261014210526.104215-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xuKTd2usDzrpTLBn7jEGNm08qptJvhlr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXyfAqzE+EROls
 H/ejXehsnGSb2kvX28wvPIpL8n1S6svzzgvBWfeAK7lTKrJch+DPoNQrRHIL5mnYDvn6o05pNoU
 z2R/p8WhKwVzQQc/zA7/FF3y3SwzZqUGK0Sly4IfR9A3pdVimuRM8LZRYQy3nFmnxvLajaitm+U
 5CQDPkYBsNHR0GOanHzIlSjAHun1Bijw0CaAClzltY396jagiN397a1V5Zhs+bzVyjTKOTHE5RH
 QQ6pb+yBAiniGKsj7qvJYGlU5PYxiTuMh5Tal4VbhVeZhemLZZ4HIErIhExufcu3DltOGdRS2kJ
 brK7KVeUHJFhX7UMG/I6Y4I4scgINHR6lrp8IQ33Bf+I8E1GyFHZe8oQ1yZF87hFmhPIjtfD4KX
 ex9WAbLKooSuAo49W+lonWeSi3oO4wxOOih9gnYoU6XCNrWaOhmz48cvGUhaOm6x7RiYKdBoB03
 7Ek687aO5S6SpW8v9MQ==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfeeaa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=oeoYDfJPrL2azRNJ8Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXzHOKBVM8UFH4
 6RF1SuRAYkhkbK12/O97xEwuuLSLNV72E8Md2O6IJFpJe3Fu+3F3nm4zt0EAqA6qk16IL921oeD
 Ko8RhQuva5yoNNy/zyJJiUo6ZHL6ToA=
X-Proofpoint-GUID: xuKTd2usDzrpTLBn7jEGNm08qptJvhlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index adda363ac39..862097c6c63 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -70,6 +70,13 @@ bool target_aarch64(void);
  */
 bool target_m68k(void);
 
+/**
+ * target_hexagon:
+ *
+ * Returns whether the target architecture is Hexagon.
+ */
+bool target_hexagon(void);
+
 /**
  * target_or1k:
  *
diff --git a/target-info.c b/target-info.c
index 6b365113955..254530d8ea5 100644
--- a/target-info.c
+++ b/target-info.c
@@ -68,6 +68,11 @@ bool target_m68k(void)
     return target_arch() == SYS_EMU_TARGET_M68K;
 }
 
+bool target_hexagon(void)
+{
+    return target_arch() == SYS_EMU_TARGET_HEXAGON;
+}
+
 bool target_or1k(void)
 {
     return target_arch() == SYS_EMU_TARGET_OR1K;
-- 
2.43.0


