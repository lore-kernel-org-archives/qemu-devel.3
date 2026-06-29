Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0185C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBna-0004bL-Pb; Mon, 29 Jun 2026 09:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnZ-0004aY-PZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnY-0003C5-AT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT2Pk2618764
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=; b=IK
 zQq1rx3SnGrj2WkBUHeWt4noSTe/720v0rNi5ofpwGSKuevU+oRIqLPLHbQwJxfU
 I2IxxZFcmzspmgDJiKe9g26Q1tUNj2CGjM0TJ96Rn4z/TzloI0+g/uvV1V6kUDeu
 fDC6oQxfm4SiGGCOppUlTO/i4zwM1OGfA9XIxs+8hS6eLw4FZOZGRrL7xAXfmPBh
 K+FxIPyjtDnwPmdz7gLiv+udCOT/eJWZuSCEkg5yPvOPhxDrs6UNK59PahaH55Fy
 T4zcnsN5EvSbkCwbCvCxWXLcO0BhGlbXHDfihaQULHX/gz6lK1NkxVeoFz3eXfSB
 WxXNBIgYo0O8jXrXt0gg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrr47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:05 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137f3465368so3923134c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738784; x=1783343584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=Yhsmua+5J2a1xGt7yugHdAEsnRb08AzJvChIlozO3u0GRDU9c3ASZsP2u2dydeYvF2
 bS9gEJG/IrGjqyxZw5BlPtforQRkgUb2ZRh18oY7LIPUYO1jT7HsxY7N/+x0yM1ACX60
 oVgn8584GmL13MDM1E0R9tjMWnqpeN9jJpobr9SyEA7GROWvLJ0V7KNBiVnvq4KhHhHy
 rsMY5pAWZJsGxW7j3AfQNoD7vOw4Nq7qqY0sXkh9yob4ryuuDqAPO7C8eejkMkUUP8SW
 cF7rvVEPe7n502YHjcvOWxuttmzapOVb7VBvjdUdLfQelWfnCsRpASBnLjnTD9+zfg4x
 0PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738784; x=1783343584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=G3fq6+jUyQ2bp5srkUGtqc/t39gOByRlHO+CF7c551AUVPtb/bgy3XcgTJaWxQJH+u
 LCzwnPc+bFvPfi/S20mkngMqGcLZ6ZLNwyQX/+5bGK1OmoLl1XhiWXKs5BPgdzQZqTPh
 8elj+GqbkgEXk5l0tVMPuffB2GA8afzwcwg/bynNgVTk2iP7kcWJIpEvNblxfheZc8ar
 L+5Wjduh68jeK9UbbMcU9c6V/OnGXWo90vZwydpZWUTW+yWzYV13VwCZa/TjS72j0VQc
 Ugp2xJSAgEF0uOTA/tzxohF+Cb/22ItieuSMTTforoCDZemkHoMt4BAntVC5Vn5p+4Oz
 XagQ==
X-Gm-Message-State: AOJu0Yw6DZ5CMWxtq+zHM9ghu89qyj5TLaPX5CtCZm4AdcGRvcrf+KMP
 IysQLkEFw9hc7n/m22e99COm6l3GhAiiv0fJa/oMNmHJPcyoMMky7IgJgsKv6uQ7+AsJe0RWZWk
 8uyvGJ9zsX4A6Tp1lRESpXlNLEWkS95JTSiGxwgwPNvs8HXrdVg9vdhEeaiuSDfGyww==
X-Gm-Gg: AfdE7cn2vdWChWSAya9uS6cQuD1nyZpb3f4xV84NuEukAcaP/uFyPNUy6p+HiN64gce
 RPJS3M4qK9hSLEWtvp4RmyT5NTdTI9EiKLw0LTLtKtKz9sMj40lSTD1sJ+lwG9wACrohktAtHyd
 r+rKedb9sb95tKAoFpWgfuUPJFdwthngcn2k+cHHyBVzyDWejQ+11balwGhdEgFKJdMeKMMIyrs
 VzUuEqpfcUQJDY6fhWmEoFfRvaDu8TzU+9vgzMyTa2yMkZoLG0y32JgLXWmlY3as6/hiyjEDt9m
 C7Hy2lmB8+eEsoO+z4b/ZHLU6XNJSGiYZ6Nk4Dmj6zJ1bIdoC+90URjWk9WgXM1s02TjGG9CGdt
 RR4jg1jJ6CX1CzELdqlyUh6fLuVeM4fWIs/zJy0/qm5DUu3wFMmRslX87nvg=
X-Received: by 2002:a05:7022:459c:b0:139:fc0a:f48f with SMTP id
 a92af1059eb24-139fc0b0622mr2910821c88.38.1782738784385; 
 Mon, 29 Jun 2026 06:13:04 -0700 (PDT)
X-Received: by 2002:a05:7022:459c:b0:139:fc0a:f48f with SMTP id
 a92af1059eb24-139fc0b0622mr2910803c88.38.1782738783831; 
 Mon, 29 Jun 2026 06:13:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 16/77] target/hexagon: Add TCG values for sreg, greg
Date: Mon, 29 Jun 2026 06:11:31 -0700
Message-Id: <20260629131232.2487780-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a426f61 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8kp5zrIFwsha1M26KQwA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cs_HGVPD29biufxnWgE9ljYMV7WwWL_8
X-Proofpoint-ORIG-GUID: cs_HGVPD29biufxnWgE9ljYMV7WwWL_8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8Chbeoc4JuQA
 /AfxStSaMQYHr4Xlihe/u/w3cZaNJnxcbDCn2t9Byu5J5zHvI+dEBselxIa7BXNYcXcnduU8aW9
 T5/PZKd/tFOx1/5IQoYpeSQhM8RBCjAy/LwH4yPII1iyy4M2cEWMQ+Gjbft1iRww1mCbta8rO9M
 /sOcAj9OC4MBGD+9axzvNkW2q6/HY0R+G4eSTqPcbfhmce5uDUhwGIwi+EqiyKdATWTykX0LB/A
 JJU04D90PEhvP/ERzdbBlrNnQFPI6lvYYVcddHtAc/+qT9dBFmZRZHz5RgOWWaMHCxQEL/oLNWK
 e7NAHpFrkxtD/UgxsxVR+W4IlOqc6YyNYFSPVfr6hb4JinwVArrvexHaWk5yCh+ViByg6wSLMDJ
 qhutdYGGJ9pgXbTLRpAN4NtiVujvwl+COkg9LoFsWVrKx9ldx5OM8C+ulmcjZ7cMynNWmTL/zyG
 stPF9rlVLGp8kGe1MxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX9WsOXwtdN5gR
 WkvmWaVBi21J+AqWGcYkCnLpbM1E35UKdhgKBf7BQd88+gZW70boYP7OB6H4CFw94w5clcJAtNb
 5rB3IRCujZMaKlMDkNEEt0aCeAMnGUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

