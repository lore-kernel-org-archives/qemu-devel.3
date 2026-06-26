Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E28C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG8z-0003Lh-MI; Fri, 26 Jun 2026 19:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8x-0003Iu-HC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8v-0003wR-BQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMx73E2792994
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cTSlRALNr4rPZrn2Zl2p3/8Gk82HMVzh0DgJ+f8dr4Y=; b=dyjfpbwFASLxwCsI
 QN/w5+uP9BUzJz3gaeGqEHDxlbgnmPyOKIjWJmnzciYN7KiGuj8hHLE8lC0gd6Tu
 m2j3uLxuOenUUp8mRWPe6YBy2kU51V1XqmbGEf4goDPdV2iK3FwzriiFoT/Smqvl
 td2YJST/WHfj+TZkGRKXtTQ+tjkW+b5WUKMTyk5uXS6ZNQ1ggnV4uJo1TA0t02oy
 E0TO0CV5qkbXt2dF/ZrlH2EAX9Ti7G3RjftiPFkSsv7MaLxrIS/BnsLe4rr75ltQ
 gaw/slX0XxOqGDpJpfnpvTzADlGxpP81CSWUxDYhxp7MBI/kfyAhhYu00IYhDMzX
 IlfiMg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1tc3hyrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca1f74cacso1162885eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517167; x=1783121967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTSlRALNr4rPZrn2Zl2p3/8Gk82HMVzh0DgJ+f8dr4Y=;
 b=SsmFExdktmCa1balnohgHB7Io6ab2PwNOQ6f0XlX/rLMKAHtEc0NfIFiQAITfJW7Lb
 pCkO28zjtIgCearIC+sTr1kAx4mH5/b0tfvfZExhhO6zDHnuAyx9mjFmFQh9UEL+nfhR
 y071TZ+fHoilae3KJ6RFOcxzok/UfLN9fXYg8KEpbC7Cg24wAonv4rJEWEHiWvm7IVXp
 jnMWsqChgyLbYbTAfPerelJSY5Az9j2nu746vYNQXvge+RDc8L4Vwr00DVkLP/H2X9MB
 2clw8wQ0riaVlB7OdE95VooKdnWaQFYJ0cBpqC0On4MArp+RQc0qdoI8xUQ1N/lxlODG
 5kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517167; x=1783121967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTSlRALNr4rPZrn2Zl2p3/8Gk82HMVzh0DgJ+f8dr4Y=;
 b=mAcIaRWHFmLuWha88eLbxe3KLP9NRoJ0WzHyXAhHgPcc+dtKwzDobCcmiCJmLH3VNg
 /8zm95ZcbWevtSINoCiQf05kVuVuRPCgUyCrwt1EkG6iajih2IQs9S8JSpbEKGIfM1Ax
 g1wCi6J3zNsqMiKel7fTACdING2MNKbSiJsIdFrZ+t4Ih49eCf0/4AIwVJCNGmIlfmAL
 QIOBKsr6jMVEzFC8ehMyj24DPV1nniYlwC3wFPpwiEnc/QLNQKmWoVyd0e7Z9IWztd4t
 z8NBrblHLIoK+oFEL7zfJtyNPGr13ROpredlaZnAs0HIR0AKPKwHBqygPIdROfxDVBtq
 XOtA==
X-Gm-Message-State: AOJu0Yw7flr8pHAlE+NRBcX0zQe3yg2se1MOyl8C8eREGbGf93XLbbQ0
 TnXagWFCunuRC+oho4FoSjneC02Mef00cXRTrh9EE1YQfUucB0BDDRg6VJr+Fu3baxBmeJXPK9+
 BrzhVr75FWkM0hl+QOFlkZrh4QPmmLMeuP++q3iAaDeGEJoVL7Zr7ZZToZ6x5IoIuOA==
X-Gm-Gg: AfdE7cm1OUb0Qiu11v7PML+/cZvP3UjreRDGa9/JaKWe8hqMI0WtpbMDfoE8YJ5wa/w
 OoonsbyIcI+ijVSxIUGo2OAr5ApPL1ELWjb0oMxfRlMDY+LIxpluyUV4HBReDwlQhffdrYVS7PA
 8cCNilR9P+899XRlMDTiVhuF96RwqObROyNMMOM8bmDfscM3AkfRgs6iXqPWz2e0TX7PyZd1tfi
 AeHNefO0Ej6i2OpFYiLklHnkthhK8X1Kyhg0lWJV2F1vYd039YrTiVS+7CmvYW/Q5peRwBmcHOc
 icPU9PLD6jxbESuqvqhGWsk4xh3TEfii6zyt6y6K8+LjhBWofsSwtA8zYsW+Anc//QUrQxSNeoU
 EsOETT1DZvD/Df2BEX20V4LsjYdJJngQ7w8RYAWmdIyodi8OPwS6gFpVRGgI3shBU3LGuFqFfw6
 1kRqSp/A==
X-Received: by 2002:a05:7300:324e:b0:30b:c4e3:8235 with SMTP id
 5a478bee46e88-30c84d9f7afmr5952758eec.27.1782517167362; 
 Fri, 26 Jun 2026 16:39:27 -0700 (PDT)
X-Received: by 2002:a05:7300:324e:b0:30b:c4e3:8235 with SMTP id
 5a478bee46e88-30c84d9f7afmr5952738eec.27.1782517166843; 
 Fri, 26 Jun 2026 16:39:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 03/37] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Fri, 26 Jun 2026 16:38:44 -0700
Message-ID: <20260626233918.158740-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1jq0uple90m6_63Wd4KH2Vh4aRvdWOIm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX61pEuv05RFRj
 D/9Ru/zUcglU2P0CDHen7e6/VTdMFb/yxE53NQyDTnR0qkRXjK2UnS+vY1CKbF/5f6U+dcTZSRN
 ouEzfoTNcGbznACCdptxRN1dP1ogkCM=
X-Proofpoint-ORIG-GUID: 1jq0uple90m6_63Wd4KH2Vh4aRvdWOIm
X-Authority-Analysis: v=2.4 cv=T4m8ifKQ c=1 sm=1 tr=0 ts=6a3f0db0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KOwsCq-n9oHDdLkyY2IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/p1u04C7mNUe
 hYAfdwFMYCOlUgpsxbWpFDitIc5gUnSVGvVfrw6+GZtrFF3xXFN5DLGMW39eWdHUhaDvRXgSqhd
 CuGn7wC9RlHl64VnDPIdsmoz/QQ5RC+tG0tf7b8ruNH4ZvApmosa1fz8fzPtsw6X4vbrCctPnlU
 SC89MHH1kTBXYKXVCLUOLXGKStBz03KMIAiBuM8EgpQwIlOnjp8mne/0a9ysVDt8a3nCdFsRORI
 atHCd76NQNX+JsB4hiFYkQYbyc5woB6SYCDjT3tllU3j8ulTCc+rZeiAH3FxoUfr4nQqWp3oFKN
 gXKgxIuc6l/hIrKV/kZkmwm/MDifXsfXsKpeLkZ0Hgd7mhJoHfsagXIJQmstG7N0z222I5nrPMB
 Du6K2T87oujgimtfyX40UHX0HfdWHpG6qoSIzlfkwA3Fu11xxoYi72qO5cvkpugnQsFoMnJPq+o
 e/5q80lTVJMAHsUhoHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
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

We'll reuse this name later in the series, so change existing script.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


