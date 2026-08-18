Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7FFC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQ8-0007y6-Nz; Tue, 18 Aug 2026 15:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQ3-0007rR-OS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQ1-0006it-Kj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9ot1454260
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=C0SE2MqZdLO
 cMyJ/+fOvrVYbFaQ0Fy5Z0F0GlxKyni0=; b=D4tNO/HnOvakSVTIDBYK491gOSo
 ZP+zDCJnWl5FTb3FOU8oj1h5qVz6TNxJnEFaNRTvgSeqYwkFaO8YwYMu9IZqmPB1
 2LNyOx1hqFtoAokvoSH4xkzsbskjZoVTqsTkouDfgq5bKQNQ1qbi6BnmVqlc06PA
 4Co0R8gwk1jx7LQlp5E99aHWDtZH2sA5Mc+9vd8jVX7O4yOjS7PluTCM9X8z42ye
 i7DElOxaKTz3XDicft28G2ZArFG2TSuL5E+UBvOwwePxlZKqofdomHIxFtcsKTm0
 jgkyg7Dv/VM++SpQuPKBC4I2DoBhifd17dMQSKAkFM3HAAaDxXKBrIhYe4Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1ue0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbbb9c9bfc3so82490a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081045; x=1787685845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0SE2MqZdLOcMyJ/+fOvrVYbFaQ0Fy5Z0F0GlxKyni0=;
 b=kEB6eSGmpPOCQFIXZg4/53fRNSQZiaazOskDTE4MYRp91TbqTFY9dnX/EiuLJrR4oo
 4qWWU2XQ6UbCY8f/7ntjRw6ICN5VScm5xMnImU+91lPe9UlbhBoEnW5W1bLhI/M2Rd83
 hnJEk2yr45ydlUPyLQg6lRoHOgvZ0aEoYRzSDOB7Pz7yKs/GVJptbyK2Y3bviYydhFVl
 VvKupJxfp8ANXLSNMGTfzjR2th33GeTQtezJSNIlWuCcTpVY6X7Sh1FR8ftexRHEWq74
 Wk1Z1S3NbgROW0VX2hTZ38c6vxavJoQYgYWkVWQDdgoJ4lbnQn8i87fd2Ow9sfEaKWNB
 eoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081045; x=1787685845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C0SE2MqZdLOcMyJ/+fOvrVYbFaQ0Fy5Z0F0GlxKyni0=;
 b=MGzYf7BmyL3th91SVUlm+O3vXwkHcX69MV/msyfOswZavwuApWR7AxMwqpMXcVRnzY
 oGdjQGYBpKi3si6wj5WEjnv7z0NAudCX8WNIPOObpD4Fi//42a+uo5KcB/WhPlwWokx4
 MfNr/0SheqFi8azWnfSjk8aGhH98b0hU+AaGMbtAlAxbAzYwA257XSnjKOi1YB5sVhTJ
 2sZdd0wgNLf1lehuvZ7xJSRc0fhfnE7AeNpMQw0fxgvaF3DvJPCTeqAQ6Fagzqleh38K
 O+kNhYiD0Gtrr4lm0LfKqj4Xa7HdgNVKF5Uf7B8x57+SBH6e0AvxvDHRoQP/S4tzexjt
 MMjA==
X-Gm-Message-State: AOJu0YwdCRkO7lajYXb8WBgfYoe42+b54BjH4mhfHzqvXZNUHN88GcEy
 IrORNckcRkP/6Znlb5/rQ1BmWHfc6YQ02UGmbV+NPjcf2t5TMy2ULIQv8InSWhNxHR9i6U2TEMl
 klxPcAqmfVe5oaQjUM2+EJMANkbXj6BizMFOqsYWyV9xys5C3YS0J7oN3ZLz15aVvZA==
X-Gm-Gg: AR+sD12FLdzdnpqIljcmkkUpnDYgKYsuBajr/E2ZOYlCUD85N6tDO/QpuQf8qCTX6qh
 DFNAaqdOgXbcXlMrluB+36w+g2bY3P0JTKG9ft7g9mGFF1jW9DaTejvXyWBANYWmmrlLgKoXZCz
 wYy4LqAI/oIQGXYar91khFTbTXhXWL0gQTjed1bbHRfn6cfnjRgo8Itaob5JdbYh1PUL1Zydr+c
 0hmuM+Sx6f5O82mI1hcrpFQ1ggX7n6LrcMtIo3KOE59FqVCfzF0kwxatVyeYsFxy2jcdnyc1blD
 Bwo2/IFDax7VjrFpDj0Zh1wkU5kh5xYbEu3SbfHvSpwqxP28V4W2QxQ8Rp4GvmwLVEQlgTL2w9q
 KO2Zv6c2Di8OORVM5EEgXcND8eDw4kAY6i217J0fpgeo869O65AEbPVF8164=
X-Received: by 2002:a05:6a20:cd96:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3ccfef7af73mr164830637.12.1787081045233; 
 Tue, 18 Aug 2026 12:24:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:cd96:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3ccfef7af73mr164758637.12.1787081044816; 
 Tue, 18 Aug 2026 12:24:04 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
Date: Tue, 18 Aug 2026 19:21:57 +0000
Message-ID: <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9eBsb453RJid
 sm3YadTBgVo1DjJ/zg8NbvBLUfpKE6Xg+ZVbCu+rXx/mnc70zriqH1mQuSljYwVUGZ6MwFd4Dh2
 oxshaBXGvzlxHdl0LIKhR/fQ7m0O99k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+b5TYhL8UAwJ
 Os6wUCb21p6eBq7yc/+Yj+UqxiFhpNZFuBy8Bg+UyXMtVEUJOsle/pR9L87QvJThAFOCI6O6KE5
 CRMuk++jJtrD7JGsVIHNSDk6KwMW3rXpYPrjTl+Zp4plhYeG8yFPQmy5QqrDUtoPoeYR/gXWdol
 KTnxqoaOP0XtW8OG9JZgjJsZXRhImMBL/bNfWqkbTJUV7+BKU1YqeupYfz4+S21K2MvKEedHZp2
 LxEWBKU5frHwLRt9L4K0NytqhX1lreGlx23KiGk60CDzhT5BWl1myicsynxWimHRpOHEhG9yghS
 3GqNq6C5ojhXlB66jHqyTTmDvmkiu8Sh61p7tentOaZ0fJ/KzqbXQ1ImBuSKMhK6qX2MgBXY7b8
 UNCr8awK60Mss/8mDTFl1AKEnN7GEreg+N7HPFlZNSpzG27oXjPAir07cTZkvt1B9d736hJvcpO
 tv+uv11nVCtx56luNQg==
X-Proofpoint-ORIG-GUID: QMJyzrl_IQLBxPxJjI9AC5VPlHAQ6Q-F
X-Proofpoint-GUID: QMJyzrl_IQLBxPxJjI9AC5VPlHAQ6Q-F
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b156 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=bQBZ4AfKrqIn4QZ8WyYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

In the next commits, we'll port each architecture from Makefile to
meson, and it's easier to review those changes if we remove Makefiles
step by step.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/Makefile.target | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 1b83824ff4e..836fccaca23 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -105,7 +105,9 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # $(TARGET_NAME)/Makefile.target to include the common parent
 # architecture in its VPATH. However some targets are so minimal we
 # can't even build the multiarch tests.
-ifneq ($(filter $(TARGET_NAME),aarch64_be),)
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target),)
+# skip user tests if Makefile.target is not present
+else ifneq ($(filter $(TARGET_NAME),aarch64_be),)
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
@@ -135,7 +137,11 @@ ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
 endif
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target),)
+# skip system tests if Makefile.target is not present
+else
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
+endif
 
 endif
 
-- 
2.43.0


