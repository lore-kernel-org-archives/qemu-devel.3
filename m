Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B76AC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ0y-0004qg-Hn; Fri, 10 Jul 2026 17:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0x-0004qS-Jn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0w-0003Nd-5v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3on81648751
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=; b=GtQZeN6l8WZSzHwx
 nxa4l50YfSfuKvNuKBRcxmqxKKKcvKl2GXwN0UKQKYzXYjjvbmN7Wg7xLDxr2Nl/
 bJ4XoutWMJPDP5a4uoGSpisiRcexCrVk5k9feBg1otzgTRD6RV1xQC1LjaRpetAp
 FlIAQ2nvSYTdofN6EjCYAwOgoVgBiWOjPysYGVjzbOW5rVHgAIPOApvJkr/RqiMz
 YsFpeuHRTXxZJi5flOcRP9LCG9HP7GgtGy369nbnwbiLgSE/QO3CabfbrNt5G5EK
 IBWa8C6sbOHXa5H0lwqUO4aSmjaqFk208/TiSv1ixzudFrDzcMGkDIVZtYX/3ddp
 vmoOGA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhd0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88ab059052so1315071a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719844; x=1784324644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=;
 b=CdI++GGUXbjw82Rv/Xuo0O+jFeXwxxJ91FOmm7ZQZSJKCwzBWPkSFqpYLB8NYkmewN
 5gsE53tqI6dgGQhDtEpuZwPIOzK7YOOQ9Mh2de0Rx1cJK4Svsjv/fMVP5nxgjIkYuCo6
 aqxJXzFN3gx9fwOrjZ1aLdv4WuGRbw7S/nHhAjHeXwifwrwn0hsAGyIyaGsZzHAfPVXy
 HA9GZPu91FMz8eY7fdRMZG8le/qKekj6A9aySIJ84H77bi0I6A86iJeBmF5/KuhTwrGy
 QTJwf1Wi/zNyyemT63F3owqAd4BWBVjr+QCcvYFjfbszN7I4TxKGc7p9Lz02icOSaXen
 ua5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719844; x=1784324644;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=;
 b=mcP9ZeLW4MrUuX6fpDK75Gw53TjKmvyjQ1fDWhBV7ylrKlNpbZ4E8jB6kWPbXYUs7Q
 MDKqqI9a7YY+arhYd3Gz/GYAdcMQFPtbIq6xaF5Lox0fqslXc3eWaatsXlWwLKlZmtg0
 D6XNQw7dpO0lpIQJoB4eln1DSbBR0zQuiC14sCjiEnkBQlAh6XHEwGZwsdI88/Wu6K1Q
 Wq8QGCTFP7CTMS20seYM96Cvkg8Qa7HpDTlsKnVhM5vx3opsn0yHV1q/6Z8HaMG9ob8/
 cyujY9gV78fxia44dg5wz3L8v0GH7YA5iMKTTI66fJVRhc6ge5qauq3EGmXzeYcHQxG7
 ezMw==
X-Gm-Message-State: AOJu0Yya/5uT7eFClALlLw8I70qZ/xOwwPwQvwPlRIuC0B820UHwLHv5
 j3aByp87F8GwO8ZeoQKjBCO8TFmaXydY/7lHIf8s9C0gL+ju/mHJledp903CyCuCLPuymESn97s
 X/hPI7iMHClZ0SZAa1rKr4Iy7WyaogmmEjdn01JBkDYdjeqA5qm6qLiqyaDpOMmdvfw==
X-Gm-Gg: AfdE7cm8q683SQvaWlJhg0KeaGm8nFJigYj+E6E0b7LUyrwqK8haNSeu6iOEB2gVlz0
 7MXtl07Jdh7z1C4w9JoaTKfFF2L0oqxK44aZWkJybKTpe5f0OtkSG2ruSh/PePBjmh/dqnVlmak
 P8b/RbpAhYSlRq3b3samsLjVIsArjY+fID6JtXJhyg2XrHmsl7bjtkeBI8WIU06zpedALan2KIe
 TgIezH509tWqV7+rzhiOPaWzuZ3eezohWbP3EEEOBaV69owIvpg3hSOWPdRHhITy/OAfI0Xm/UX
 qHA6XBqbvDLwvTwiitlIV9qg47lQCEjQcXEQAV/SsTR51WZ1EqUW754geoUo06hMT6xrrCqwTmY
 p+y+OG2L5lMUrNDuRMKGFdaTCKtp5La7y+70NXJek63aDmXjjG8r01w5JADWW2KfmOOIxkt6zQN
 Z1Q5kAeg==
X-Received: by 2002:a05:6300:6708:b0:3b5:445c:e483 with SMTP id
 adf61e73a8af0-3c0f085cde5mr6139732637.3.1783719844219; 
 Fri, 10 Jul 2026 14:44:04 -0700 (PDT)
X-Received: by 2002:a05:6300:6708:b0:3b5:445c:e483 with SMTP id
 adf61e73a8af0-3c0f085cde5mr6139695637.3.1783719843702; 
 Fri, 10 Jul 2026 14:44:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 03/98] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Fri, 10 Jul 2026 14:42:07 -0700
Message-ID: <20260710214343.2065491-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5167a5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Fu-9CGv2gRfvjT4HfT8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: UgeeNOxk0SDqvhOkXjLd4EMZUNuPOoG9
X-Proofpoint-GUID: UgeeNOxk0SDqvhOkXjLd4EMZUNuPOoG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXwrtVRNe1cfPW
 Forjzf4RGdoK9jW+s9wVw8iY8SOJeLLbtqYST5wC6KWmed6KHQ0WAsGojszU0pLumxACPBCrsxT
 k9bfKKU5PyYxzqVxAAKyu4gc+kKFMDLOSR7ThogI0eAseW3vf+xsSTP4t3EpjsKm9dyG14TtNeb
 mOdqgp+vGsYWPaxof9zu0/a8S1CaGV9bcg29un2IDMvkriJS5ZLC9wOEGXy0/Ge1EC6GqoAZL4c
 DWTcW1Rr/7ecWZo3ApVAmr2XfgqraPA4PtnySwOG74Z87XDENs7WPp+AXEN7nGP3Fv8aWPqdKWJ
 fyprCrhq8pUpOgY7+6AadmD5BEP43eYbikZEJTgmfmkQ07pnq2pS0PXVVuXDCWm9C1NIaY8pzLY
 yg09AaBBReV9M4UGHqWnRCaztSywTBNG7DW4OSuK4m44a2MD41pNoqVVyTWj9wgQ2QJeiTMf5DT
 8fQ5RuA0ZeB1GWoanzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX2iPyIoMGVfVZ
 7r1iMu/vQGB6qLpvll/+edUdAZce8lQIo1DaqrsL54SLeviqRimRB9gJl/pzG1pq77FPbIbJ6bh
 B4pw3bP+KR76F2RY5QSmGTpNCR0I1FI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target                             | 2 +-
 .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 9bcbbb11286..35050acedc9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,7 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
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


