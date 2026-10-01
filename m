Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1EACA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxm-00084e-Ly; Thu, 01 Oct 2026 13:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxN-0007x0-FJ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxK-0001jJ-8B
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsfiO3512258
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WxF55/sCOHsd+0vAIB7dmscSDt6MW/6QGKXrqZamoHs=; b=Du+9SG8+tVGb4I25
 8ViW6EQDVAKXYISOYYf0YWYUj9Yc9YO5DwnrAeaF+t302/brKB6Tskxi1d8VAsYk
 60whXO8dwFV/eEAgs2IML7dDGrr3f5usryXzsm78XhwB76Jo00HV+WRz26FKEqsa
 FgM/GgkvhELG1FWao7bBRdL7pLWL5x1OYw3wPmjdDFbbK247j4Mnc7eA2KmQxrh8
 tB4fs+SBfVS5MWD3PBpLFJ0vzkn6JJ1tWQ4oa1CnRgxDhQN6Pz8CBY3bUKHCiJtU
 GflFzvm/plM1HJ7N0qyL8u11tX8TS0yOX8iL/OOSrqIcHkCShQSSl+4/Nhb0scjp
 rDRo3A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1quk9e0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:29 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14383177746so15718980c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877148; x=1791481948; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WxF55/sCOHsd+0vAIB7dmscSDt6MW/6QGKXrqZamoHs=;
 b=eYWrjefoWsEu/BQ17fL0N6sI+Z2iX3ldDF6d9Rj5D+qwHOFr1/kOjsQ4SwC4BM6BWM
 XcxeJ+eRdk1Ro2Mcv3WNj6t48ftVQbexJDXfdO3Z0Up8bmcej8kZvXeYjAt5icGzPvW4
 EKmVePedW99kNhkqeJSN8wDjwkJLuJWeo7ZnjlWepy5TvYkcPe+YFPQWTRYgVipmzkkl
 dI+6W+K5g0TjoSl/WKoYxVYHMQmxryIpp2P/EI8PtcUvJ6v2iPuC6TXc11nAS/aSS9Ok
 2BOFmWRV+56B5TjvyCiUqBUktdV+CS8wXp8OdwbB8wS4x+hb8GM70DhYlM0gv0WcVNvW
 RcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877148; x=1791481948;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WxF55/sCOHsd+0vAIB7dmscSDt6MW/6QGKXrqZamoHs=;
 b=uXdNZTPQAbVHbIsNmJwqnbCOgFb8dw+4Ln9ZS7M5TMgIpA8/EzFAIbSkJT4Xes+DaH
 IkTBPXW76NwxI9y2sHvHOgcUmqbmpSRMFhCaDdpP7Dg5PDnaeWYvsM4/lRdYwKYjv0jM
 J25Lwf0ZoWgLjS6ww8l8eEtDdyyPdmaIpWh0JUOmy0YIQQ7RrGSnAxU/8CoB5Nw8K3qC
 6VGh7jLWNsRSgD7aHE2G0T19rgEA3eOSnzFYLiJZz2GnDnG8lBT8/O4ZG9ZE2yuz6qhE
 HvHK8wVeOUUY3QkongNHSvqauVMHeW0CgHWqUN8UwYaJp2jIbHDcn44mO64hHdVYY8SR
 zSoA==
X-Gm-Message-State: AFuF++lDnfY8wePx8ekNw/PgJZWibRLX6WSs2GwYebp/NuQTuJIOaI4m
 TsDdSDpGTonsSk8HYL8eNkknflFARBEZMxYqEvZ6H0qe5VPNgofQ2XE7qpqubd+OMZ1utgMc+/Z
 eiLOeAq9AXSnGf50K/zXaCh786LLnw0L9tX4wSKJcDRr1rnUlANHB6/MQzt2fNOlTww==
X-Gm-Gg: AYBFou0xIMtylH670DUKZxG8pUaQ0or4WUFWUYQb921E5XQHIC4IWZ2dWoUORQn8HWw
 /Y5+7Px3cd4tk3X8QT5Qi3bLZlDeim5gyQuAAA0Xq0LXJqiqauFQVKuJffK3WGxVXySIqSVzzxJ
 CoBuOLEdp1pSFQ5xrNvRzWQwwPH4824JrDRxRvRG0slJtMhaQ7Mdpf5JY+e26JHaWAluf4Danae
 0zdEUeXG1u5AmCcMq0CGquuM9HpAyhXp1NY8J7jDecWx+Mm3XVtpTRym9jV/guUzYJmrN5fbC+1
 sxcln9c6yb7tmfz2gEi0j2HWe/YaJj7CZzH1bsVQbJPM23NhhMsJ3I+R3iGv4q5Bchh8Zz34aEM
 VK53DAaJSFoTAt6LVi+KSImApTnQnkQk/nkUT7n/0wDz6JbZWA9qmB8GpjaqfSCsmZ4CmER0=
X-Received: by 2002:a05:701b:42c1:20b0:148:340f:59f8 with SMTP id
 a92af1059eb24-14d3641df34mr6328454c88.29.1790877148044; 
 Thu, 01 Oct 2026 10:52:28 -0700 (PDT)
X-Received: by 2002:a05:701b:42c1:20b0:148:340f:59f8 with SMTP id
 a92af1059eb24-14d3641df34mr6328381c88.29.1790877146997; 
 Thu, 01 Oct 2026 10:52:26 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/27] tests/tcg/mips/user/isa/r5900: add README
Date: Thu,  1 Oct 2026 17:51:43 +0000
Message-ID: <20261001175203.8673-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX/bP8SWPOVRQj
 Us/wcj+faYyNRi2o7kIwPMvqN5zSGUHt48myTgW+GrdGqRxpe0SpIfdOoMHzF4GM+twcoSa05Y6
 t53XFRoWZPJY7UU8+vpIXeCsdWg4+Tg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxpqiKyD7Nv2r
 Hjp87a9Er0IiCkHz9JnGD5qRxmiElyWt4M+GEGiEUkgxlG2g8HInxjiZ++FYKiYmZiFu28Y02eo
 /+642A8YMsgMvizTQONGGKhbMKL7V6C+zeyAmKrAxGIlw6R/yfXrp1tf6FczgOYV7ymtlQFxsFX
 0e2h0FT5yzZXPaaK7Y0E2lJsl6nxRtmdKL8+XRhK7Uki5tqXZfZJB3Fe6QyzRSbozv99LVCNKjS
 1NS0VVlK8ijVobqnI9AWvI8W0XRAO+xoDjHAR/4syTLqSc6p3TlntaHGzdlc+OugmDLj69fWLEu
 qgiKpB14Dfk4De7YYpqsg7TkyWev1PRxdcIutFYjK96+mGC7BGVZN6Kzzy5xgGbtAomI3LoAPtd
 r7yIxZ1McerBcvw3CRhhNBhegd1HUVqOt/vf1QF6IYFY4BihwIll3SNH9OrAIpAsR/bm5Iv5dl3
 T1DuMKyGd2248IJYV9A==
X-Proofpoint-GUID: oFss6erCvWKHG0NMDdiC4YNN0OQkKiIA
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abe9ddd cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: oFss6erCvWKHG0NMDdiC4YNN0OQkKiIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Those tests are dead code at the moment. We can keep them around here,
but at least let's document what it is and why we can't run them.

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-8-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/r5900/README | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/r5900/README

diff --git a/tests/tcg/mips/user/isa/r5900/README b/tests/tcg/mips/user/isa/r5900/README
new file mode 100644
index 00000000000..18ecfc3bd0a
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/README
@@ -0,0 +1,6 @@
+This test suite can't be run at the moment. We don't have a qemu target for this
+architecture, which has single-float arithmetic, and custom 128-bit registers.
+Also, a specific toolchain has to be compiled for it.
+
+We keep the tests here in case someone is interested one day to resurrect this
+architecture.
-- 
2.43.0


