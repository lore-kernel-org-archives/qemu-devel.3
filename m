Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC229C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZem-0004G4-Dc; Tue, 28 Jul 2026 00:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZej-0004A2-EU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZeh-00018i-Tm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40eGZ1593385
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=; b=EvgDxsZCUpYyfSNc
 uGn8OBzA6f3A3cICWZkIQ1MP7jYqKEWw+c+JLRQehSmC2lQmk1wEOsdCTsd37+nj
 0DB0wDcMg64XLla7Km2fcq1HKOURueqBP2wQEqDLpoee3qY6m8RDUNz25+9gX4qO
 DjIRmqSlA20/yVp2T730lGBWHsHsMSVESqJdLUYWEF5WBHdeBcCu8MApG3YLw5jW
 rcRr1YK97S/thZ4gowCQHCytmjb1PnXNefV8Xd5+Smy8NtiNa1b/CCaxgbtQqzfH
 FEV2CE1Nvn17APuD/HonwUE6gA2B+rK+qdOvCmVa+cvyebt+C8q/4eXrQmSyD3BF
 oXNwCw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g3yp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab041eced3so4583511a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213782; x=1785818582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=;
 b=ZDj4tVDm9v7CIYYddszDBLUfkXJcGv0+Acyp8KzOAjnjmUuPh3xHa3VDhvmEzv/Yjn
 qBvST6zp9dxVDj1t3WeSShUE5vJlkgKni843YizpkfMUhPap1VrsHE3hDyh7SIDlZDaq
 i/s7eVxqK0GRZ4ZHtRdz6Wkel3n1A57LJzp7ywREmzGmjaw2/KqzLl3IEyBFdlKB5CmL
 LVByhRJMIrrgSHwZpYxYToEbPmjPcsyf9L0R9wK0EzfHvVwFwGLNv8thDKDQdFH6WBXZ
 e9CwwJOI7FcHDUgmST7x/glQK6dWI8uzAmq6VCIYX9Eyt4sIPXlaH8Ps3f9XBw8pvQ6a
 DzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213782; x=1785818582;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=;
 b=N9U1I1FYBaD7uaOA5Y2rimcy+6Ue2dygUWyHFXZNM2nTLPptAbTZA4DYMkwwEV10Yu
 cmvfSA+AHJ7ZUDah3NZtz2VbBBB4l5tK2JZh7O0U21xw/Vp085EFSZOZzl+5IJqiofEh
 lrZR3rp7DaCbNQsBHo+eImsjks7ZXS7qwyejWOd7bY5MIACgb6n4+2P4Q0X7cGN1kWH0
 gjOL1jcI1OVspaFNez0PBaPI/KlvA5lrkw1AUiLoLRRCQA5+oAzVje0x1hD69I6R+pcn
 /E3vtid47Ew6biE7o+V5axhxEHr30hE5uGF6aYro8WLhWC/tnGb5Gztgg1dllJBVDUB9
 ojbg==
X-Gm-Message-State: AOJu0YxJUd9XZbrY8AgpWw4f3rmljJPV6nE2fuoTABU5cgVA3dxVLsWk
 8C5/X4lpsTSh0DNUD8xmGs7Y1wJEJVFjgxqxVAAm6bU8Hk4kCiE+UoFr2UFAzucCxypquOzy7/h
 fcmKCYSVsDENlYvltp3ymvMk4m9Ovs0wkDbm49vBj9aGCg6797OiX5d4zWZ8jVaTNKg==
X-Gm-Gg: AR+sD102Qw4XO1At3Y8uMZkxRE1NL3YfpGAbdznhR0fpXHmU8/kr09UicP/JEU5N+B4
 4V/k+tJT+arvhNkvd/9yTS9Req7siEsSO3CKhkU0aTeUQjWKqDIHyIDZam44hPQKNjRpxfdvGsN
 DlViLAHykPRcS42yLYF2pshjRl3RrB9jX0jvr+JVMdkFmvERpjnFGBBcB35LvxN7k+aoYlh5UAr
 GVWXf8iS9gJ2Pu0t4fQFEMoSKK35c7oTVJDyPXvJ1mOYt0TvR9FMVuRcHJ9V3iWBHJz4S7gmyRU
 0ecKwP1LJ2zF3cA+DAumSPe8KRuVFC4V3fkPMz7fg0+OwvyEaPpPo3VQAcHcNhcXMrIyh9Jt+uD
 iE3QU+GH2JgG2oljhG72CflscfgXe3WBDcAbtU2KFmA5KXIE6cml6vh0b1Rl6AhdiGMKtWXs=
X-Received: by 2002:a05:6300:4096:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3c89caa13fcmr1176199637.0.1785213781626; 
 Mon, 27 Jul 2026 21:43:01 -0700 (PDT)
X-Received: by 2002:a05:6300:4096:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3c89caa13fcmr1176173637.0.1785213781273; 
 Mon, 27 Jul 2026 21:43:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 003/103] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Mon, 27 Jul 2026 21:41:07 -0700
Message-ID: <20260728044248.137626-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a683356 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Fu-9CGv2gRfvjT4HfT8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX/jCbkUZENe8E
 lg87+rdsKEYs4QvmuDKOKZW0nhzFD79QVc64ez7U2kebR5tiv8jATNi7SfYaD4uwAtB3xcMjKJX
 TezNVj0oA6A3iGR1MQOYjhO/wWBtLChPlOTVMzk2mF56pM7IksqXIuHcj6J1pYbkoBrgPk3m3q9
 shOoC+m5cJxIQ2y6mbJNb3i6Q+22GVD7KJI9bRxu2DtJDQqzurf8rkvu2QqjHOjGGEgy6+/Mn9L
 RBt324TdOZPO07SADOXfN2iZRC88B4zEkUQl/U8BADIEt8d35EP+obUvlnZvYFLOAlwC1YhP5cE
 911pridpX84VctRMUIOV3jDhKG1cZWurzGNpR4r+BPrPRtqVBat/Z0cgNExAJb1Nw7t847x0hX/
 Ue26I9M2x2ByHD0kh5McEcXuS3IpBxeD9fqu9su8IbChT/f2+CLOImpqEWj9Dc6FmGDwQ30Tt/X
 nr+wdHAomsMTcc0vjzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX1SYIzRbKTpWA
 NnFsgCM7b2WEf0dW4znoFQgEOwq+9bRhQRBD4u48jggzvDqt/8rXdV4Lhyxw4LpZMfOYPmgyL7S
 eZ+ujE+7Oce9+ykjcI+WIWJm6WiVgYw=
X-Proofpoint-GUID: sxq5q5k_5G1Xoe5zDBR4BhfBIMrTg4OS
X-Proofpoint-ORIG-GUID: sxq5q5k_5G1Xoe5zDBR4BhfBIMrTg4OS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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


