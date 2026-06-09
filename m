Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E94CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4Ii-0006bY-DQ; Tue, 09 Jun 2026 17:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Ih-0006am-LK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:47:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4If-00080d-3L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:47:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4u291642727
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NQGx8ik/rN/
 9k/6iuHX9tczpRuYOFPsL5ev4lzvGTZU=; b=SpF1uXtixaos77o/B4zeBF7UTql
 pbHYGsNXA2NNRp2yFReXqpkJ1+xBMULLYhF9t6p9JHZYPearuvxJZHdlAtp4bpZO
 GRYa52eUFZZbPAak1NJetPeqLFRdvVvJkdEMGhpQSSrJxj36p5QVJbTBpXHl7pCi
 0cKjTtngUPD7VUZfL/OKRjH3hDEv+mpxKjAw/l6T/xbxRKH6CDA5XryPj9PFyFHt
 qWPxOZA/u73/6UULbMyYNE/QcM+stOyTRpF9ubCZgIoxI2hfgooOfeMR+R66KtO5
 UlrKH5NyjtMpIAe+df25t5W0VT/lQEdiXfhntcP1uQ+dN/ANTi2cPhC10hg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0suvt1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:47:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304c652be4eso4534960eec.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041675; x=1781646475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQGx8ik/rN/9k/6iuHX9tczpRuYOFPsL5ev4lzvGTZU=;
 b=b8vDGNVytJb6edIFu+RmbW7BdjIki9Bc26n9q2BTbLGFPtQIEQVuaOAdrxyPpW2bn9
 Y0meVmSjydqMJUhVVD+p19gpOuHrV51ToZqT0OymScP/PH95fNKMuoGy9D196ZRuzK5I
 apJ0buO+MBFtH9LfJjWTsPMJdKV/KksFm19Df1KbU3JweU9eiyaj9OjwOJAXPITZX/nK
 ZdNPbROI68WYHD8y8l97+F0kGDUhXI5+v5YieSLh5Dp05TZCid6txjWK7x4N5+sG8UBS
 CcitHGk3fNOGuqsEgkDmQbRlHvO0F/F8DeMBSy9AdLnFkbHJL4DhwvzoXqxUy7Nxb2lc
 LPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041675; x=1781646475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQGx8ik/rN/9k/6iuHX9tczpRuYOFPsL5ev4lzvGTZU=;
 b=GQLMFOYRH2cYvh1JNYnfF8Aou+R+U8QbFInfgdxTsrBeQgMTlE+LQoiWYgFeVjZ+z6
 KNre3ELGEVfue7Ps4jhI1tdO/h2Tw9/s/k2AaXOj0aDbVMvNP9UZm/lWd20eMPv0YHct
 g/Rkx2cpbHVAM7csQKwOM7pWXy0QRIyBI6ZcCZrf8hC9+fGEc3ngbg63cw0jkk3aJS6w
 fXBqQ8Aaa+gzL4Z8tpjCg6ZXbv+5ZjoN77nBDbdCg5Yc1SNysT6u5p9ClbqDLclm6Ti/
 qSaTTlRxZEHHlSDg9p7SFqJZOCK6Raamga8Y6EMPHd9d0YHj4VB4myVVdj8mmi9ryWkT
 otMw==
X-Gm-Message-State: AOJu0YwURfi2v80PHUDjMgXv57/PuUj+mQ/9+50ILkuoxhHLKHdCuaun
 IOfpn0aP3im2P2nJFSB8EBTCN3v2R1p75zHKcYJr1h9XLdNCNbvvLfSicNcnyjqTtx/uuQ7rqwO
 WEjG/xWNhvFMwPpbunp36DKsgUhf/skw2njSjFHvrAXcHMoAVkrT06CLUUX3ZwrYbtyIe
X-Gm-Gg: Acq92OGba27FJkAPnvtYFbw8gs6rIQd6zH5HUP5OW7/dH2XM5wRUjeWP8jM/wNSNlDv
 ywfz9EYzIizUFQzi/zA/Y6hcu3WU71V0/hbuJcm4dQoWAl6uDw1SUwdSB4sjP54lj6WpemFmBPP
 vzkIVVweClbXEwXR4ngJ7yMPSIKrRerCPluOlIKrnGdHkBRRipCjqaK4Fhl0n1LVCPF1oqlx4WF
 67M+a+110WfRkCTd41wHkmtp1Nu/JtMUT3cb7DR/Gze2tWqdyfCYYUDzKxCo4nidFHnZqbS99yI
 V7lCMt3/cO4zTd8vZsE6MJEroWOGhj39UK9A81ylteTIRRvhEqz79EpYv44uuhY10YRkIC0BCxJ
 NQvaMVYJT7JMEBpShrRj37hvtrfF6uPdBNlVp3AOQyAh1P5jb4wOnwOErc9rDIJvgEvM3z8jy4F
 6bhTauJoR1qyjawBGm
X-Received: by 2002:a05:7022:10c:b0:133:54fb:6848 with SMTP id
 a92af1059eb24-13807d1396bmr10772503c88.5.1781041674829; 
 Tue, 09 Jun 2026 14:47:54 -0700 (PDT)
X-Received: by 2002:a05:7022:10c:b0:133:54fb:6848 with SMTP id
 a92af1059eb24-13807d1396bmr10772486c88.5.1781041674331; 
 Tue, 09 Jun 2026 14:47:54 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:47:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 03/27] tests/tcg/multiarch/plugin: rename check-plugin-output
 to regex-compare
Date: Tue,  9 Jun 2026 14:47:21 -0700
Message-ID: <20260609214745.772536-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfX36AEobJe1Ehf
 wTUmZs04HEb45DXE6e5kB8fI8W7AUJqJn7DRVm7u+uxc7G6NqRcAaxB0YNPowPyQshkUHSMSQag
 Wa4wBlieGjdlFq8UqUUTlUdnq7WXO0ps9U2LgnHZDoc0OsTSqzSVzPfvknmug0ut2WTSMfvXlgu
 KwjpgZNolD8NH8FHkS2hHqIDalTaGYZVRY0kIlYc1/I8fdYJgyKSOTmCRAnFydwTzmSg78VWyVA
 b59k1K7qYap8TXUa2o/x5+FGo0c6x8NHHccV/NggdiAN4Sa9epVDTIC54wNiiIehvA9g5LPYMEZ
 a1R/tcVamsTgFn8PDmr1BHdzTQA9glvvAYBob0VNCsl8g65vn/bZZIKwkvl1BvJnlfEkSFAnYov
 c8pVY8tMD5YdS0IvhqsgYwMLwOVgttqbIKfVmHqpRkvE2ew6c/Voxv5ErvZbmEHwdBNZrJc4wqn
 4ChJbeJT5+b0vLl3qmQ==
X-Proofpoint-ORIG-GUID: MTsTY-CD694gSfdGkMkdFd3JkNW0j5yk
X-Proofpoint-GUID: MTsTY-CD694gSfdGkMkdFd3JkNW0j5yk
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a288a0b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KOwsCq-n9oHDdLkyY2IA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090204
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

We'll reuse this name later in the series, so change existing script.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target                             | 2 +-
 .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f46983cc76e..6907c2830aa 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -211,7 +211,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/regex-compare.sh
similarity index 100%
rename from tests/tcg/multiarch/plugin/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/regex-compare.sh
-- 
2.43.0


