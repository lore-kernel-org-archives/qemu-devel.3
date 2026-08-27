Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100AFC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFO-00076U-Tq; Thu, 27 Aug 2026 18:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFN-00075w-Hf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFL-00039p-Vl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLqT9795079
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=; b=FJIbDAGYl+T6191A
 OBhyEUoUK+6VFTGpok11fBTZkGMOLd7X/zbp6/Xk6mIpnVI2kHM+IDHq0rrHe5fo
 zMH1xWhHa/w3RY8s6m/bSXWzZ76FXJ9q3/X0wpo+lq7VZZaObyzi5jWq9HuMMmk/
 OJATceH450jBQUxaPjHdabOBDCrsaiO6kSYpFp+9bnCaW+JHNEHGt+q6TtEYdGIC
 XBupanE7BWM9SZWY6cG8GdC/wJhApIT4N/28iqlAGzj7BRq8/8PFwHHrlrEc5zMy
 7l5qIaV0bmSdd3bv/G7Kg8D5dutBhQ9kv0RoQKXIsyD7jE5VbdFT5RbgzsbZ7/uq
 0Pfz0w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjm49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-854f274dd69so750545b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868414; x=1788473214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=;
 b=CKzSLwAcbwIAWX/H84LTlRj04knvJ4y1hXkhff0PSyywg/Kwv9tw8OkL5KjzwR/7UT
 nnGX7Hx2f0JTI8upltV9HubXdLpyJ5Q0HzV3BykRk2SPDYB9K7COB+oEVfRKbkV848MV
 CQyaCvyeNyXgHvtLFLCCoi6v7wOEYYadJofkUx4pgBO5GTB0pOpSm5rszO2fFuMQ4aWA
 377TfZqEjdIMfwO3uWB3UtER/f8i5gRhy00NWSNaalTwnDlwN0Q7z51dXytubrD4V1CY
 5bdFckFE0HA8/ZC/hW6zROOAuUZGeW6K7siVn5c+GSj9AjrB4pFEf6BMPXMRa4poS1hY
 j02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868414; x=1788473214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=;
 b=VOTsKK0CdLauGQPrnXzS7yoAP5OOBDUo13tDPsINKI45w8iIIxYPO0egydFRGGZxA+
 sH852Y+Gz46RMOSCQ246SqT4MlvoPS3v58PSTIIB0EOi5N4GMJEicvSR0/LeaKmf8DOP
 g59dn8Yv8m7ehoTfw3bCsYrTvdfhaI6Aejg2hVZf+OBUOfpPxRC3GzDDGyDhehDhNbvP
 3pd67bTnk3w0gKmaWOnIj+ZrD8yGy6dY9ZBhIElyUal2Ptuo4fJbvtQIx/8blni6emYE
 SUgmEsdEpkxf20g9/leudp0GqNL3wQ2shAgfuSvn5E1nCGEVnyJiKM9eWnW0orW0kSS5
 EEiA==
X-Gm-Message-State: AFuF++lTgtzVqUuPmfTetQES8v67srxtsMVAXyusPI5Hv67hZgyVDB9r
 ET7cRRKNgBO+vcX0wbNXLtlUGlE+5680QQDV9Rh0GUaZbWK1zfqvaAJycx1LH2qNczlYpjD9Lwr
 vRc91R92WRNwbPJr0QD1iYN6DZ71RWDXJjXj8JGzIvw+eGmXIxxAhujuQliyiazpNxA==
X-Gm-Gg: AR+sD10c/qtFqcvgA/mvta3Xy8WoJ3SLVXtmzHEXmihoLTF44/0rbMOtnEozZGyP47h
 S38w3y8vr0ATLPBuXb763Ln4qQ0eQ9CLqdKvbyKSir8KgU5LkmaNOcbbhfL8hN5urHJwOd3Rsyk
 SU+loSh8apiZxVQvu6pMG2gtgESsz1b7VNe3GyBv4TG9ZqqFv0Funh+HJHI06DFIsUl7jNlSfbI
 ZhYgsKWv8Q5udZbP5h31qYa+LoRg6Mkh3X4GPZNR2opxUArpyErIhxRkpmVbRIPWUwxk3WKaBRR
 GOdkdp/JAn3dBCMkVmE8q5nrfbQCL8OHX89xFXYX4idiWJ6ybCuSeG/9O4/RWpWVW0DFV2hbDh7
 vRGBBRekSiuctm7xZDAJGogbJfjPqZM9D6bRT5XxvfMaomGQn2L2Xu2YwjfI=
X-Received: by 2002:a05:6a00:2384:b0:847:881c:7026 with SMTP id
 d2e1a72fcca58-856277dd32dmr4350631b3a.3.1787868413988; 
 Thu, 27 Aug 2026 15:06:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2384:b0:847:881c:7026 with SMTP id
 d2e1a72fcca58-856277dd32dmr4350568b3a.3.1787868413548; 
 Thu, 27 Aug 2026 15:06:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 003/105] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Thu, 27 Aug 2026 22:04:57 +0000
Message-ID: <20260827220641.84885-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3VBc1t23GsBS
 wHOgTad0Nos+nBU/bIxVmQJr66TxEdES1VD52caPUptSaGLLyvURl35+S6wqzePE0eT8omGeT7h
 tDfl4uYIm4siVUkrwIAzug8u7tJ46J4=
X-Proofpoint-GUID: ix_JhQmp_gQoa6i2xyPxQf8453a5us3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/felVIFGq59D
 fYLQnUMI6FgUgzPwUK82dQdPien6N2JuNgRqjSowpiTFkw7r9PAgOTaXm1lQlV3zmaHieD4HI26
 H9NMNddclnCB9OfUeW4RHW4XU67aU4zah2RpuFX6CgkMt5f9OUYalDT7bYq6xPf66RcEMXAZTyv
 QI187ojZoSLa4QxkF4XA2+hQC38CQuyn7pwMk8CjC1NZpQvBAW7MdWFyG3UdXtytSa3ciNl61Mn
 LVXhBR52mlI7l1E17phtyWQes8/BOP5VwPax2l9+Fs/bZ/XLEw49Yf6nWqTrNHFnX54w6au+cmo
 vYdqjEYTN1wAl+Fh1ZkAvpErICYb1GcQg1EmU+nGrkWTeHnUB3uP+syBftoIqRQOFYKo2DKM/D6
 u2E70vH6k1DZK+LygRZNSEYUg31FJ2um/5L0qFkSWwTnXYoTi9+9mPjpX7PGHqFWgPiO+Z/p3Kn
 050dBtetkrlLVMLw+DA==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b4ff cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=Fu-9CGv2gRfvjT4HfT8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ix_JhQmp_gQoa6i2xyPxQf8453a5us3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


