Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3C3C282D4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNT-0002ug-K5; Sat, 01 Mar 2025 00:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNR-0002tw-Km
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNP-00087P-EU
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:05 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214wGvl020828
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tv3jNIYKEgXG8iOKgzInCFlE6eQ9Ks2Szt+E9ZTNF/g=; b=Z+aBl2RLVUlugwBt
 f1nmItTcOKFpOGQHzFYU6DusGHwM86MQEbcRfWVwRUntP2MIzJKoVSOMMgSEvkqK
 mh29NaCatGduJhJ55O8skSmG6tVqalhS1lliFSSjs9miOyX8QgwKfB2rOUooWfvU
 W9ugTzHX68fcx5odAbwDrmnJmAgm8YYDfMMm2limwWSRi8KxBkmqBcwFeCO3izMr
 t9sriSVhBf7CxZG1c1FIeOrDGfjynz1uwlj5v+lExfr0NIH04efpuUzpILIKoc/6
 sisTo/dmZgFOV1AdsUzm8KM0rGTiLczsrmx4RzAGSk1aXBWQSg/YasQl7GjO0vyB
 F2xTvw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hr65v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2feda472a6eso474972a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806821; x=1741411621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tv3jNIYKEgXG8iOKgzInCFlE6eQ9Ks2Szt+E9ZTNF/g=;
 b=g8lahoJ70F3qzSMDSQvloOGccL0XdE6A9+rcq6MbXSlng/oJ5/vfjujcOLpk0RrhXt
 TnUKeBFkoittZ5DGidjZHuChyy5Tnoyz3BZks/Prukk1/VADsYH0sac9hmB/A5ffsT0D
 3qgiiNRbNBMwWgQWzczUagVKN09dJ6LX0Qu5KZ17wDwoawBjJWUeBCTwKwH0NbTc2Xec
 goTko3wO+Y2qF9Snxv5zOvi66NWeXwsTUMtcH2XPK3tSV8PA5LVwic9cUslEA2Mo0Dnf
 Np6OLy6kdNjxYv7lMnAL2GDzohaLj2U6qcp7pSJJQlhjTJEnA+ujB5rTj4BnaRqFaIQH
 y2Bg==
X-Gm-Message-State: AOJu0YxFFcQNIn5b073qnIDoirXX1mzIjVwAljp6gqnlOSen4OvXVo38
 /5hRLRy7iOfzUGu5RAes+sd/NwH/MjxZ7EF9fH9wj34eEfER04/bXx+OYl9NGMzle1rOXPfOJI+
 uv9XHRv5qFLxDluzMW2V1tm6qbnpPWI2vGRX8Gc+M9wn5iJiSP4Q9p530mfipTA==
X-Gm-Gg: ASbGncsvigehkYp5YXDelSAD4U76ZH0e2IueakVyQTjwxJr66F6CZ+tMBKU7+XlvstB
 4CvUgHlLHL5A7g0lIWyH0BC7l4rXJwcGJJiVzZi/IdvKjAoQMTWTiWjY9gXKy5YyxE0UAX1SLId
 rTKfGhCyARsb9vPwBPqfegVJyOOytFBIYz+WPmdzIyAFUp5r3IAmra2vDIChTHbe29E76ldjork
 SfAt2LV14LPtEfnxXxj0PZdguwrkorrssqbRCAWibKWRHtGdz8Y764QG7VwGCyC9ZUrefnaYpR9
 XcH/udworxzGw0nCnskfDtXCljrA+rukJwcIaPJ33djj6hW4Wn5Lm+wboDU2nZb6
X-Received: by 2002:a17:90a:d40e:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2febab50df6mr10517817a91.11.1740806821165; 
 Fri, 28 Feb 2025 21:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHycISbYWsCroXXRO/5AvND+9gVdyDz1XYqqvMTCowiJk0zuJzma/dECJHJ2aTRaVKBbzg31A==
X-Received: by 2002:a17:90a:d40e:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2febab50df6mr10517791a91.11.1740806820790; 
 Fri, 28 Feb 2025 21:27:00 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:00 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 10/38] target/hexagon: Add TCG values for sreg, greg
Date: Fri, 28 Feb 2025 21:26:00 -0800
Message-Id: <20250301052628.1011210-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: PotdYOpFKVkP15CVNfBS-wOZKUJ_uamP
X-Proofpoint-ORIG-GUID: PotdYOpFKVkP15CVNfBS-wOZKUJ_uamP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=836 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggfCA3ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgNyAr
KysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmlu
ZGV4IDJiZDEyNTI5N2EuLmY2MTFjODU0ZGMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0yODAsNiArMjgw
LDEzIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJuIFRDR3YgaGV4
X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3RvcmVfc2l6ZVtW
U1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhd
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdiBoZXhfZ3JlZ1tOVU1fR1JF
R1NdOworZXh0ZXJuIFRDR3YgaGV4X3Rfc3JlZ1tOVU1fU1JFR1NdOworZXh0ZXJuIFRDR3ZfcHRy
IGhleF9nX3NyZWdfcHRyOworZXh0ZXJuIFRDR3YgaGV4X2dfc3JlZ1tOVU1fU1JFR1NdOworI2Vu
ZGlmCisKIAogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoRGlzYXNDb250ZXh0ICpjdHgs
IGludCBleGNwKTsKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCAyZTlhOTM0ZmM2Li43MWMxMzdiZTMwIDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYwpAQCAtNjEsNiArNjEsMTMgQEAgVENHdiBoZXhfdnN0b3JlX2FkZHJbVlNU
T1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3NpemVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhf
dnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
K1RDR3YgaGV4X2dyZWdbTlVNX0dSRUdTXTsKK1RDR3YgaGV4X3Rfc3JlZ1tOVU1fU1JFR1NdOwor
VENHdl9wdHIgaGV4X2dfc3JlZ19wdHI7CitUQ0d2IGhleF9nX3NyZWdbTlVNX1NSRUdTXTsKKyNl
bmRpZgorCiBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcHJlZG5hbWVzW10gPSB7
CiAgICJwMCIsICJwMSIsICJwMiIsICJwMyIKIH07Ci0tIAoyLjM0LjEKCg==

