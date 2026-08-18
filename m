Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A90AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYU-00047H-FQ; Tue, 18 Aug 2026 15:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYC-0003kq-B3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYA-0000L2-Fs
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH6WB3003326
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wnPivJKcFz8
 beT3Njzq647EjYz0bhArjjueNm9Gx/Po=; b=DfuZyxhld1xzlZO2U/KIda5DHzu
 jAJZ4scM8aq1DHOCKG/Yr6J2WppCJSkIBFBVjAJNOQOwzQtYaNxmjehjlyT8I8Qq
 9rnkpph745BEnd033Shii0QmycFLL0MvAmjq1EYksvOy7r+egLquzq5w9RvOW8su
 8JbirnIeQM3rEYgw6VHzTzevtED3obrFAK0shSUTlAqPT1yglE3F+h4gN+d4PdU7
 U94dVXL/i7FWBNclExGShzrWFRB7I7KXR1m5j64D/g/ABIeWI9ZQIH26KSAf3eA0
 0IO3w16YtIVMkjTcmLVC6XBWJXz8v4tATwo4O+AUXkehkcgbp0dSMgucEeA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv4x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so114114a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081560; x=1787686360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wnPivJKcFz8beT3Njzq647EjYz0bhArjjueNm9Gx/Po=;
 b=j/r0APwPebmdLH7qmlR901kKknv0XfhkfXs6uvwuXPGwWY7P8X5t30WGIeQEoDPdGC
 6G5MbRFfRBKGqKC4O6esG8vRPOMQXVq5dTKekZHe+nknTUh7bWXaj8LPE4PHwDID9kyd
 2jXEtxEsrQEWc8AmIT4sKBVElQk15YT8guSsLHr8Zk9bDA1KtDPOWmcRvOcxY5W3MV5u
 SE5l+ONf75MJGhUASqp63kilwccy9JW+oYIGkocrsUrddigx14MhT4Hb8aldvDzJ2B6G
 S9yeQAaSiBaz0Z6/o3z12LHmF5nK98t0BPS5QKrSRBszSfLEaPTBY/HzaoFprSMG2rji
 pdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081560; x=1787686360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wnPivJKcFz8beT3Njzq647EjYz0bhArjjueNm9Gx/Po=;
 b=ij5LpR2Xzp1lylvGpKEtQvRDtw2Q+61qKm03i2RwvqSrKv2a4f8y8dQIwkH0c5rfGC
 LKbq1/3RuD2TcIVoOmmvWPoCnB/iz53rHV9QPVvv8odE11W1TdFfvJZS20GeeExKsJ0H
 Vl+6QqIYQtYQvbFlP41+bNOZ8Klrkzy3mP9ARry5xLoD972k+L6svl71//tDpc4DPXiG
 zuYTusfLezKtB8a/KvhhU36ZW2BjIgjAdFVf8LHd2HVnZPAmmrVGktn7kK/rztFxUnHg
 D/7c+gf5ilXd1T5ku3deIxME+ZVpMcVQ4I9gkMFT/lef3P3M+8HMM6WBlvEfoJ8IMrxD
 wDmQ==
X-Gm-Message-State: AOJu0Yyqn1FG0ZmQn/TMOm8Scx5Jckg7B7Q/12C99ltjj0iLRBtnkLNV
 Rh8ngUc87zoGC7U9zUHc0Lpfs5FtlaME08GCpeisH9QCp/j01x9rySF8Ak65kdJDu4hMxLA67L9
 W7De3tiQ9rAeUYMnbirZ9uRRVvJwTTYuY2aY/MsWmfhynHOdNrs5rq9EZunNIQ6w+Dw==
X-Gm-Gg: AR+sD13d5CgQli++peP+CUoRhTLMvFXk/LB0+BVxnNwyNGTXWXVELyBrzMA8hAgTScI
 WN1CASRzitotWi77mzhPLC7DhaXeLuay5XivthOqBBItLJ+FPjqCKQknhUQDnNdpigRE3l5cPyC
 Kyx/WzYWS0SwG+rM6GkRJCNB2MHbWlGFc65P/0Qa5mbOBJp+0MqRAfGGcJtpMl7Usi/MiEO0l0+
 c3NccXppdsjviUVsQlsLvRcmxqgxqBkT8B3TgBoX0XncFnd5aaiR/Tefku8NTx7n/eQy4TlmtkZ
 Cx8rVVVNzA7QjXZaQeB4LMjRLEdre82luQHaH635n2bm5n8nxGvPS/JKxOsjVWccza0r75vM8lL
 aehZJ3KYAjfSIukqavTczwALN+8HT53TtwTL4m4t2momm9kWI0thOQDp4Evc=
X-Received: by 2002:a17:90b:3bd0:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-3957b2001c8mr184175a91.3.1787081560054; 
 Tue, 18 Aug 2026 12:32:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3bd0:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-3957b2001c8mr184129a91.3.1787081559555; 
 Tue, 18 Aug 2026 12:32:39 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:39 -0700 (PDT)
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
Subject: [PATCH v7 094/104]
 tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be
 toolchain for xtensaeb
Date: Tue, 18 Aug 2026 19:22:58 +0000
Message-ID: <20260818192309.22169-95-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6s0CZ+2wxBdm
 4zwfCexJzex7dyzZZlA6wqzIpkzOkb/9yOtVf1TCFIn1+Nhfx17Xxr9UlfxEwIfI2aN05aKXGLP
 v3YlJNXTTSSEtzsWtTxiZn4wRBcbsOznulK2nU3rAXKywCixAJi4tZSHu+VbHzuAHvvswQmbaV4
 3NGOv0OaBAd6lBBhna9AOoj9Z2mDdolOFijvd2TZGiFmsHevp+ORF+VnqmBLGGZIzvys/FpMBC/
 wzehEAh9SqznbhzU/nfWDdjvQar1EsEJvm6BeAeuFfV8qlDdxB/UD383tcgzfIZNJiwD01yageJ
 tZV9T878EYff+BZr5fzbx9S3JUpeVVKzuxAHau70m1euFT7OFcXMD+hM72xlUWXQ2HT51w5L4V3
 PvO3fOn/Xgzfd71z28skuSVW5pXmfAHzU2d29R2zxY2wy74YXJ6jCsH8MBMFptMwOCWi0qoeO9c
 Tld4jW2oLkTl93rr/tA==
X-Proofpoint-GUID: 5ZTWTdeCkB1T8B0LF0v7VzD23cKZh5Ew
X-Proofpoint-ORIG-GUID: 5ZTWTdeCkB1T8B0LF0v7VzD23cKZh5Ew
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b358 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=wlx_lthn7XJiM5nFl28A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8QY9ihJS6byK
 X+TFiCr/IHYJoYd3BXReD7IUnVx4BeQyluzxMVjAUabs2vRXpsd2iabfBzzxn9W4LmlPymJ42y0
 jPhg0UuCEN9yjbeaNg0qFbXmy2431m4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d9130fc3378..0eb6d98cc75 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,7 +19,7 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400 test_kc705_be"
 ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
@@ -27,7 +27,7 @@ RUN for cpu in $CPU_LIST; do \
         | tar -xzC /opt; \
     done
 
-ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-test_kc705_be-elf/bin
 ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.43.0


