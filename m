Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B50EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQir-000192-Nm; Fri, 06 Feb 2026 13:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voQim-000185-Dk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:38:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voQik-0008Cm-QL
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:38:24 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 616H6ukm3924160
 for <qemu-devel@nongnu.org>; Fri, 6 Feb 2026 18:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FVUCfL6u37nXDZoSXZx34B
 FH4iGibiqE4eEpcVX/o0M=; b=GHHJ9k7CKTC/B6LrCwDE8kXxJhJhM/bG95KcEw
 kwgs/5KjAQwwc4kBkHHFHPZ1TXnZcdp97vl13pG36h8mJG13vV9soTzzxKwhrjbz
 GZm6/raXO6QmoTQZy98ju2DPep8WCuoEyrkOCad6aaLa46vnjqqcSJi/3Rsm4iaR
 tNuP249bYLOykLDdReJ5k2lj7Q5waW1/oy5B72zhhQrTCWbpkiESGpE5Ni/Q9piD
 Ci1D4at6B6ahQ+8UdYDFeR6OAGvGvMx1nHyJdh2eFmqZ67DLh1PqdY2J2HJ7s9ah
 2dcFoZSIz+UuQcOGA5qw+YlO+eqMs4h3KK+Y1FNvev6X/lhA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5mdur95t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 18:38:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b831ff242eso1487129eec.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770403097; x=1771007897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FVUCfL6u37nXDZoSXZx34BFH4iGibiqE4eEpcVX/o0M=;
 b=KILOgNyyQOLgdaNJWjFCBqt5qIvaGqvpt0l8Y+s/8iT4y4OrlRFaIJjVHrfi7xJgHN
 Y+J6XnKTP8K7Ou8fy3x7fCnxJ1OlhLtMOucD4SsndmwBaJDZVt5CZ0STky55+MvdN3Gh
 EnVKc2ymzyw/4JzL5CBpy5Mlhx86kU5MZDlqOfLk32fEiZKvQ/aqkBp20fLLThl11kon
 J8ZBu9Vnr7LxTmf0E42gPOEG3Y/4XQz4THgC3iFp0uI4zYXL5xzHVuA/I6+9M5mt0tFG
 LodV1gppkORnAu4D/jFtphaaMlD1z6q/CCO6ExjO/COyU9BgSgsF3ehc9cIIwEG6h6xw
 XMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770403097; x=1771007897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVUCfL6u37nXDZoSXZx34BFH4iGibiqE4eEpcVX/o0M=;
 b=rWngyqM9nM1qYgkHcHAHKxqq5cw2au5WGZvIDZok6gCrVsbeFBgNBQ7rPJJnF3sXs5
 0qqvwhss7Fv0UIYMg+CRuNhDk9y6DRCr8rSnuokE4CUQMYuj+GObXE3MnVUyRBrNvUuK
 80nN2j/64M9jZEDQ+k2g2zKO9UzqwtfWmDgkDKCefA6oftBxSuF62aDWai3dVsGv6s3K
 S1AUq9oJ95k1koyVYXgktVgIS+KZmIlQ3w2S4X+aQJmyt1+BcGaig4AeYNXIgZRbKIJJ
 auB9Vd9D5adQUi0cUpf+IhYKYGR9fUsrhzBggjfqtkyOJ1R7sL97VArmAChxvE3AJmiY
 1Ijg==
X-Gm-Message-State: AOJu0YwFFGsmTXDhXol3pWa/n1m/7UfTxICje4lpAKnqa5RWkIXXRcW4
 2TZoI/5K1wXtnLzzZ6Vgu8aSfNx8NGpv4MtM2wpBUvln8eda1ca9mI+ggZzeyjpXe8LMmNQr1fN
 /dvX0uxwNLEN1tQEYrr5EdOeJExL0nLFDIRoL1l4Q0p0TvZOAa5C3WvZMSyza60eZeg==
X-Gm-Gg: AZuq6aLGxYpl0dJOXAtqrsParzQQJJQ6vIkz0OanT9+ADxfX6tAEgoVoFOnErf4BUao
 I+wV+tj8De0gJdJPBSeUP+HLWJu0pF/E4p371VuuXyCUsLhbZxrkQBYWt1mXC4r+Q3pGeKT4iuP
 kgMaObuHelDOS83csN6iq0BRq8KkM9fOyvzrkA++D5Ub937+cWXhMOVy4kNXPXm6WhWLaDALcuC
 e5/US6c8ICgFj2+If3jVhxKeSuvUD70SmhG3pMT0Agtj7tQSHyMzJfhdZEluCrzfX19MhE0/O2P
 gHdyQiQEfiCqWSHr8qN9yk2lSlLlLEkjTFCpWTDvWoWusm/ivQa1HBQvI05RtBH0yft8cSXeUkD
 83gdAeUQjDj2uELDF6qLpco2ujgvOoeluUpA75BJPPmfK/0ty3cdwVwpkGQ==
X-Received: by 2002:a05:7300:148d:b0:2ab:9d23:f0b1 with SMTP id
 5a478bee46e88-2b845c43f75mr2975380eec.13.1770403096627; 
 Fri, 06 Feb 2026 10:38:16 -0800 (PST)
X-Received: by 2002:a05:7300:148d:b0:2ab:9d23:f0b1 with SMTP id
 5a478bee46e88-2b845c43f75mr2975363eec.13.1770403096119; 
 Fri, 06 Feb 2026 10:38:16 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c3c846sm2270605eec.16.2026.02.06.10.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:38:15 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH 0/3] Handle some invalid encodings
Date: Fri,  6 Feb 2026 10:38:10 -0800
Message-Id: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: zcuSAPwJNykeWDBUTsG63D-oXCfdtX9o
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=6986351a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Fo4zGsZOXeOtLA1AfZ0A:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: zcuSAPwJNykeWDBUTsG63D-oXCfdtX9o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzNyBTYWx0ZWRfXxwa3Qbb5dSQy
 hH3BITXOHbv/jHodzEbxmVrp8EdyVdF0BL08kU39HIao2YfXtCHiI05rDeIviLJaGIVQ3d/9Ch6
 rvo32yBVIs1MK6avelrCgs2a2/nlhbWKcnTgWP2R93VXLwFvU0gbnhf9rX9KbMu1uvD88zxw9hY
 KWIL7AbAoAbjDBWUu0kJguOTUyOI7ByILCm/4U8vWEhAbzorp1Zw85+0anEFoByoIbGYckK37IA
 6sDelg7PFCh9ZLq0Zr1ArIaDqTkNkes3VhNL8k/kEpQ/AlKDPkaxZ/pC00e+nFcozzi354C+Rjn
 37dMoVy2GcgXI8qFg/5oMBZBWhNTeQ0qCKFhFw45f48Y9rh/NI8lhRTZ/71Jif7uN8ZLGoWxn8v
 7jQZ4yuqQwp8vUfNOZWICSiyWKhw8AekIYMx4MM535gv2uDcIaq8CU2P51A4cK1vjB9OtkK5IJG
 kzvSyWVE9eGOHt06Z7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060137
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Rml4IHRoZSBpc3N1ZXMgcmVwb3J0ZWQgYnkgQWxleCBSw7hubmUgUGV0ZXJzZW4gY2F1c2luZyB6
aWcgdGVzdCBzdWl0ZQpmYWlsdXJlcy4gIFRoZSAweDAgY2FzZSBpcyBhIGNvbmZsaWN0aW5nICJt
dWx0aXBsZSByZWdpc3RlciB3cml0ZSIgLSB0aGUKaGFuZGxlciBoZXJlIHdpbGwgY292ZXIgZHVw
bGV4ZXMgYnV0IG5vdCB0aGUgbW9yZSBnZW5lcmFsIGNhc2Ugb2YgbXVsdGlwbGUKcmVnaXN0ZXIg
d3JpdGVzLiAgSSdsbCBpbmNsdWRlIHRoYXQgaW4gYSBzdWJzZXF1ZW50IHBhdGNoc2V0LgoKQnJp
YW4gQ2FpbiAoMyk6CiAgdGFyZ2V0L2hleGFnb246IEZpeCBpbnZhbGlkIGR1cGxleCBkZWNvZGlu
ZwogIHRhcmdldC9oZXhhZ29uOiBSZWplY3QgZHVwbGV4IGVuY29kaW5ncyB3aXRoIGR1cGxpY2F0
ZSBkZXN0IHJlZ2lzdGVycwogIHRhcmdldC9oZXhhZ29uOiBSZXR1cm4gZGVjb2RlIGZhaWx1cmUg
Zm9yIGludmFsaWQgbm9uLWR1cGxleCBlbmNvZGluZ3MKCiBsaW51eC11c2VyL2hleGFnb24vY3B1
X2xvb3AuYyAgICAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAg
ICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyAgICAgICAgICAgfCAxOCArKysrKysrKysrKysrKysrLS0KIHRlc3RzL3RjZy9o
ZXhhZ29uL2ludmFsaWQtZHVwbGV4LmMgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZHVwcy5jICAgICB8IDIzICsrKysrKysrKysr
KysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMgfCAyMCAr
KysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0ICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0KIDcgZmlsZXMgY2hhbmdlZCwgMTM4IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hl
eGFnb24vaW52YWxpZC1kdXBsZXguYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhh
Z29uL2ludmFsaWQtZHVwcy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24v
aW52YWxpZC1lbmNvZGluZy5jCgotLSAKMi4zNC4xCgo=

