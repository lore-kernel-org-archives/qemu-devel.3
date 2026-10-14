Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4416CC6B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ad-0001O0-VZ; Wed, 14 Oct 2026 17:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ab-0001N1-Ll
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Aa-0000hn-1h
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZsif3469372
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Yhbs7RSZPZm
 rFDFuTRuA2WW+s+zuTfDP6sQuBxV31z8=; b=cm75Luu83h1nKzYKytqdKU0H1HC
 lc9l1X2p7XFPA+x3sU7lRJFOcR1TIlY/P6kzBFhXoPwuNJTvfotUSUh8rpMXfmDP
 nJi6PEHmfDMwNTg1JjakugrRblwc12IvCy7YZ3npA3hENaWwHtjGI9fABRexRkV2
 eSdUIt6d5lkil9gsZzakLtO6IZenbSpLdze28ir9ENIn3oRuy+pjZ80UhM6AUxjz
 BH2FfxRCiugO0bgJYOD2Ky1uiFDU7KKTnAFUcmilcnSmbgJTZ61LcvUFtPlxPTUH
 sM61ZVGM2ulVPjbDx2zUql5bBh8JovnAr0VIQ6AMz8URa4EiorOwSAFUYUA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78ymf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2087813eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011950; x=1792616750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yhbs7RSZPZmrFDFuTRuA2WW+s+zuTfDP6sQuBxV31z8=;
 b=KbXiReLVIjegirG4DCT1NRbB4TT3CQ1/ZS10XM9tjy3HgIRrL7C+FjGhEwXHIQYspN
 Hs2xNE7XcfdDuhe5Cb0aDBui0XcToQ+HFFwbA4aXdGEoR7TiW1/JKwM0NWTN0NxDyYSn
 Vw8iote+jgHlQOqodhzwFdUeLscXCYcotXnl7ob0h3Rbo6K3B5cCuO03kYDk3iW6gQvO
 NAoMrxv4j/dKBd5qBaUEoe731DrP3c0driVIjyovdwphcwXbB9yr3FxlbwAo3PowK0Kt
 2hLkf0WRLwuIy1Bzry3UGY5cSGK2m0tHdAi2HwQOdb9CHi5Bnqx79OXmYF1RpboBrvIr
 lXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011950; x=1792616750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yhbs7RSZPZmrFDFuTRuA2WW+s+zuTfDP6sQuBxV31z8=;
 b=oMyeu2BJs9FGAFzWG7fMnlaY2bgUHfetfGtZpeRE9epoFw6cagRq05lEDVYNldNqXb
 tu2ApC50HORZfl1CCL0XiqchFkgW2gRh/jbbQU5VslVEyy6y81sA1JlVIf4C/TG/XCwq
 EAiZ3PYnNkRWBU/LlynmIo7bDoh+wey8XeHqyRLnr8ers1diAsWZrnquG0hbf++/pdSd
 WZcJHPAJ9wiqs6G892C61GvKXn+THd3ehlEMMNcv0u0bLKlTqGO2yAhLz3KVdMWL84lw
 NGhxgmixkEnqi5WlGt9bM85ulde12HC2oqfKr1Asl1uLRRh+qA4QCDtNLbx3foi2frPy
 NpJw==
X-Gm-Message-State: AFq9FYKXI52eyxSLf8YBhcqqENkGv6N/y0lmlkWG+4B7BrLXDRIYIsuG
 GJdf+4191iRw56wb5lKyCX89ulJ2lag4pCrhimrTyS4i2xC0boiGKicDtuDnxfJUyyKg019ThjS
 wSV4BPUlL/Ym0y/EJnvQKHMINVPhCqX0pygzGA2Oyb0MimC56J4S6yGAnDvnhNV9lag==
X-Gm-Gg: AYBFou1FnXPt+ZVmEq/BsceXFz/HsJY1q0ZZmQ0tPJSMV43HZAOs6Jg1L4k51j0ypNw
 QqzRiXbixpQS7zb9F5r1DLZ0zvS6rLzzkI4Lg6mWEOF5OgWghbuBQ2P5ty2nHWO04RqzaiQovVe
 ZiUg5EC1vFdeRzOGIZRw55hBYV5WocfGkN/BQln7+4A6mezMCtCd7Edo5twQC3v2VZsKTuv8hUB
 K4FvVpi67naXp6M6sC1CzprBvSK8NIJJXVmBWgxeEQtX2BDstuaw7/CVBe8GjZiSFAnjc724KIQ
 7PA8S0HILkXFhtYedr150rCO34EllIBQJrH7s19Q0I7bHdDuin7RXQNbue2aRSHuoadrroCuV+9
 s3FXK894PeRw636RIl+YsGqWcMrstDhutxtbIzTJ4beJmkU6ztpKbdoHnD3i8
X-Received: by 2002:a05:7301:4e88:b0:35a:efce:6190 with SMTP id
 5a478bee46e88-35aefce65c3mr16883745eec.28.1792011949680; 
 Wed, 14 Oct 2026 14:05:49 -0700 (PDT)
X-Received: by 2002:a05:7301:4e88:b0:35a:efce:6190 with SMTP id
 5a478bee46e88-35aefce65c3mr16883704eec.28.1792011948907; 
 Wed, 14 Oct 2026 14:05:48 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 05/12] semihosting: declare semihosting cpu ops
Date: Wed, 14 Oct 2026 21:05:19 +0000
Message-ID: <20261014210526.104215-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfeeae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=b0EguDeq3ost1Em-0lQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: fUnjnBoP7pZzwYJ09ldkQPsqJBNDljgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX9ASj0o0G3UIP
 4gOSdMBgsLgB57nYuIMn4hb7rKhCGR+o/4SEc4gmtbkVt6lb1Z8LrwRFsWCVhjMZfyp6zCXgeLc
 /Fg+ZVdBTQ7JD9OyY3z747DysQ0dNFpRC5btwm0S8/rhZnkBBWDbiaiKGH4iVuFrdsjiRF5Z/UQ
 e98gCd2yLN2RGPlUsAMfkdI7+Jcgv28+3br21WISZHHu6MfP8pJZcXlaDYJ3K40W1k9fHtvjZxe
 o+RDAONWvtdThVBf5cH+z1HUL9HmL28naWieGfADj1s72ZVoe6sruUfB4/H94l/vNOFePRpErJi
 CzRmXxbDLfAZ+Os1aciHUk73o/coY2dYC17lCe3vyABq0uYjURb3xgzWg2Mqi8wNIaToPVaMxi0
 wlzgqDbZERaTUq8myt6N2CxX6jleTrvdnwzD+PqSrH2uaSOd/yXchVAuEF62s4FWaL4qqRlSWQK
 bq0D3ZEZifNXMUaOiPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX4yLw5aY30Ew/
 snetFwoFX1G27UtNCd/srB4AO94zX9Vbdenc+exqzodQXtCubF2RZoE1BVPKa9xpxsQiw1/Ns1g
 yoPmzJ5UF3nl2NIMrEH1IVLhxq+Fx7o=
X-Proofpoint-ORIG-GUID: fUnjnBoP7pZzwYJ09ldkQPsqJBNDljgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This allows a specific target to declare its implementation of
semihosting.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h             |  6 ++++++
 include/semihosting/common-semi.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 76801444a16..456154df6f6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -98,6 +98,9 @@ struct AccelCPUClass;
 /* see sysemu-cpu-ops.h */
 struct SysemuCPUOps;
 
+/* see semihosting/common-semi.h */
+struct SemihostingCPUOps;
+
 /**
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
@@ -186,6 +189,9 @@ struct CPUClass {
 #ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+
+    /* when target does not implement semihosting, this pointer is NULL */
+    const struct SemihostingCPUOps *semi_ops;
 #endif
 
     /*
diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 1e7699d7bbd..f0f8185d8e6 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,6 +34,23 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+typedef struct SemihostingCPUOps {
+    /* Return argument @argno */
+    uint64_t (*arg)(const CPUState *cs, int argno);
+    /* Set return value for semihosting call */
+    void (*set_ret)(CPUState *cs, uint64_t ret);
+    /* Set an error for a semihosting call */
+    void (*set_err)(CPUState *cs, int err);
+    /* True if the guest is using the 64-bit semihosting ABI */
+    bool (*is_64bit)(const CPUState *cs);
+    /* True if SYS_EXIT takes an extended parameter block */
+    bool (*sys_exit_is_extended)(const CPUState *cs);
+    /* Return lowest address until which stack can grow */
+    uint64_t (*stack_bottom)(const CPUState *cs);
+    /* True if SYS_SYNCCACHE is implemented */
+    bool (*has_synccache)(const CPUState *cs);
+} SemihostingCPUOps;
+
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
-- 
2.43.0


