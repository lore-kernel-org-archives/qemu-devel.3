Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49362FD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa9-0001iB-1p; Tue, 10 Mar 2026 23:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa1-0001es-Il
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZz-0005F5-Mf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2KjCu248813
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HzQWIkE9oS6tKwnbTfs8hmdlmjhd3dapnKsFKVGwGsM=; b=pYiU2XImAs7ghYDf
 uWqOUBrkmwv+nGyhRBCueu+KnHnxLRNC0lRb8wsoAb2U6DG5+mvf6u5TS5+8Z/dq
 Gc0O3ueovgSnhOPnqeCUCNrG+/LcEBSKFDuqdhbpmZjDkSdg+LlEoIGQnyIpbvNh
 zEENx+tSSBCkclL1pp0pZkIVqOBfLOc3skpEbZvGtbFO0BjcK5qFV59Bc4jCSd3h
 Jk/QrBcHDtaxjXTs7EiBl3MmMXDmV+jCh7ERprghpn8Kievq/SWd4cSNgnP1m44o
 uKTEQ69B2zBC9MNbqHz6QojA5IlLeThbpPO5YKEjqT0QubiFqH5KrEMn6i1kmq0L
 XPAUHQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11raw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:50 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d7510702e6so19076590a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200990; x=1773805790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzQWIkE9oS6tKwnbTfs8hmdlmjhd3dapnKsFKVGwGsM=;
 b=TFZanNMpcZuGyyeNWSANadHP7DbV7THEWTeGVjpzr3x/TDHMxMT7PVSzYMyticMa4C
 KQ3Ds4X/P2OUeoVtipQ5qkPhggvPBUdMDQQjDFtdRAOA9fwhyozqwlov5Epz7D0dRbU2
 /ZxDA+3FUKhQk6whUbGWM9XDBhh83G88aH8ui28khqZVemVCs5fMewhnymNgNN4TIH6d
 XfqpZw10ZzJyONMak82Fk+Du3Fd+SxjveMzATgVfRopB2sAg7221TUduabFlmiEy5lJG
 pBgWASiRB6kNRRpE8bVyj0tdXantEio75P3MS4A6VH3qRynF13R1FU2avoO4/AA9ne3q
 xazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200990; x=1773805790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HzQWIkE9oS6tKwnbTfs8hmdlmjhd3dapnKsFKVGwGsM=;
 b=B/ZzD8zXC1cgOgbh7QINipQJPK6iUz+cXhfZ7PWEZ2FGLR2gY+G5PBDudQWhVB6SWG
 gc+xKVNP0ywc3is4WaNhEfM+g+jJakdWho1+DWzOIo7eEf7GklX5FMq76Yn2MEiBa3XZ
 zpw+yq5SqfBGTAc+Oa8+R3rIzK0XHFmt2xorKHCal76duFpo/hZ9NN9cTyc7mzRsQDTl
 dz1VMXneMQzWUnCCRm6C0m/lyefc1qiuvRhua+LSxCnwJrz+htd0pNdoyEQGJVfxQ+Sv
 mX9JkS5A5q+jc4+9ak+pMMzDHJ/kNR51R0y4pG5QJYIZRCIcj4dtUp3cc2QfHyOR+W7n
 QXZQ==
X-Gm-Message-State: AOJu0YyP1EmZ0UT6TyK6vMO+dXTtHedV3SOul655sfCMSYjssA2Xjs3O
 nhkq3nHSarkZwbCdkvGoaoiXsxKKDOj3jYh+Y2r0we5/RTTJS5awynNS4WUfh2viKirjfLDLgB+
 j1CjHCCr98KKj80MLBJ+CpJQWrHILQ+dVULG5gi4pzJzK4uuQe74nmXrr1ZuyZBx9JQ==
X-Gm-Gg: ATEYQzyUM+FpdY5FFJ6axPjvYBQW9WGyE4t6P9mjDygWnW7/G8RRAvSa02EmZQtNjSN
 Onx7bJe10LIoo5eZs6dcWKxjmrxL9nI1wJ4t3Ni+4k6SIulkYcASi1U/4dR6nERzm0pAENlYlKj
 maSHRea25U9eoFOjzIgq0cutD3peyKtUZeADUPN3Xi/l1r43ONudB4vj2E5R3HQ7XQ1LqqOgrfy
 wDXeMlMawg0rdFD5Vc0yvONP3PaXNVI55VHbAAECeaA3dZC/UIVRl+BWAMeLxFgQ2T4GIGIhIZj
 DjBviY62tSWiPHKNs4Xgnpyl8OQtNq0Hy3TKZGtJ+ZhyYyLXHb290lvJXt9v6sLQBZHoXihRd7B
 cBde3tMSo8eWM32ikjXgCCloV/ftlyqSLb3j9f7cs2d6rHSQxFe/JXEzPD1ckOkRp3zdw+A==
X-Received: by 2002:a05:6830:6601:b0:7d5:96e7:1509 with SMTP id
 46e09a7af769-7d76a844436mr813860a34.21.1773200989776; 
 Tue, 10 Mar 2026 20:49:49 -0700 (PDT)
X-Received: by 2002:a05:6830:6601:b0:7d5:96e7:1509 with SMTP id
 46e09a7af769-7d76a844436mr813848a34.21.1773200989352; 
 Tue, 10 Mar 2026 20:49:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 17/35] target/hexagon: Add handlers for guest/sysreg r/w
Date: Tue, 10 Mar 2026 20:49:05 -0700
Message-Id: <20260311034923.1044737-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX+vUgrsVDWbwc
 ClSBMZo0xGexLaJoMgMlW5YwRpP3Wux5B6DjUIiThm74QY829hpOx5MpjLv6Ly0d47Pu7U/5xqp
 z4dSoH6rq6PPlBZmWxceLgtl9Q1xbPok+h2axe24G68JBt7OvDVRCdgVnOVR2k/dd/CoB8a76yo
 bEWYhFKgIQAIKAhbBKlSL264kFVhPm31UKlDKaYElJ/L78HbMGNsLR2NUSDsy4oGyWLs1k6nnGI
 FozuZs0ghzgeLgt0pgvGlgRR4nCdnE8j5LjP+DN/gckOFtN1Lfd0JTMbnMafk8tktWVuLFSbHCy
 P0iFbAmd/AedpxfPG6sCASR5AHTSsG9PcuSc4hHOBPGW+jqwQDckxYSSwpw07QJyvHdxMhdBNDe
 sU6FQcsT20paQPNt2AQnLM3HciBfAxSQEvvNv3jjfHfx4V6VaAscdEbpuNZ3vM2mvq9Q7M77yVu
 INnET2EAejTq1Jf4hwA==
X-Proofpoint-GUID: dWlzEamBjZEovrUk_zklHfdv6d5DKjDb
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0e65e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dWlzEamBjZEovrUk_zklHfdv6d5DKjDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGlzIGNvbW1pdCBwcm92aWRl
cyBoYW5kbGVycyB0byBnZW5lcmF0ZSBUQ0cgZm9yIGd1ZXN0IGFuZCBzeXN0ZW0KcmVnaXN0ZXIg
cmVhZHMgYW5kIHdyaXRlcy4gIFRoZXkgd2lsbCBiZSBsZXZlcmFnZWQgYnkgYSBmdXR1cmUgY29t
bWl0LgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDE0NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQ3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dl
bnB0ci5jCmluZGV4IDllYjIxZGE2ZjNlLi4yMzEwYjlhZWMzYSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTIzLDYg
KzIzLDcgQEAKICNpbmNsdWRlICJleGVjL2hlbHBlci1nZW4uaCIKICNpbmNsdWRlICJpbnNuLmgi
CiAjaW5jbHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRl
ICJ0cmFuc2xhdGUuaCIKICNkZWZpbmUgUUVNVV9HRU5FUkFURSAgICAgICAvKiBVc2VkIGludGVy
bmFsbHkgYnkgbWFjcm9zLmggKi8KICNpbmNsdWRlICJtYWNyb3MuaCIKQEAgLTEyMCw2ICsxMjEs
MTUyIEBAIFRDR3YgZ2V0X3Jlc3VsdF9wcmVkKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcG51bSkK
ICAgICB9CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorR19HTlVDX1VOVVNFRAorc3Rh
dGljIGJvb2wgZ3JlZ193cml0YWJsZShpbnQgcm51bSwgYm9vbCBwYWlyKQoreworICAgIGlmIChw
YWlyKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAgIHJl
dHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLAor
ICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdpc3Rl
ciBwYWlyIEclZDolZFxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAg
fSBlbHNlIHsKKyAgICAgICAgaWYgKHJudW0gPD0gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAg
IHJldHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdp
c3RlciBHJWRcbiIsIHJudW0pOworICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKK0dfR05V
Q19VTlVTRUQKK3N0YXRpYyB2b2lkIGNoZWNrX2dyZWdfaW1wbChpbnQgcm51bSwgYm9vbCBwYWly
KQoreworICAgIGlmIChwYWlyICYmICghZ3JlZ19pbXBsZW1lbnRlZChybnVtKSB8fCAhZ3JlZ19p
bXBsZW1lbnRlZChybnVtICsgMSkpKSB7CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBndWVzdCByZWdpc3RlciBwYWlyIEclZDolZCBp
cyB1bmltcGxlbWVudGVkIG9yICIKKyAgICAgICAgICAgICAgICAicmVzZXJ2ZWQuIFJlYWQgd2ls
bCB5aWVsZCAwLlxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAgfSBl
bHNlIGlmICghcGFpciAmJiAhZ3JlZ19pbXBsZW1lbnRlZChybnVtKSkgeworICAgICAgICBxZW11
X2xvZ19tYXNrKExPR19VTklNUCwKKyAgICAgICAgICAgICAgICAiV2FybmluZzogZ3Vlc3QgcmVn
aXN0ZXIgRyVkIGlzIHVuaW1wbGVtZW50ZWQgb3IgcmVzZXJ2ZWQuIgorICAgICAgICAgICAgICAg
ICIgUmVhZCB3aWxsIHlpZWxkIDAuXG4iLCBybnVtKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVT
RUQKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fbG9nX2dyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpj
dHgsIGludCBybnVtLCBUQ0d2X2kzMiB2YWwpCit7CisgICAgdGNnX2dlbl9tb3ZfaTMyKGN0eC0+
Z3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2
b2lkIGdlbl9sb2dfZ3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwg
VENHdl9pNjQgdmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigp
OworCisgICAgLyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIs
IHZhbCk7CisgICAgZ2VuX2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAg
LyogSGlnaCB3b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOwor
ICAgIGdlbl9sb2dfZ3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK3N0YXRp
YyBjb25zdCB1aW50MzJfdCBzcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10gPSB7CisgICAgW0hF
WF9TUkVHX1NUSURdID0gMHhmZjAwZmYwMCwKKyAgICBbSEVYX1NSRUdfRUxSXSA9IDB4MDAwMDAw
MDMsCisgICAgW0hFWF9TUkVHX1NTUl0gPSAweDAwMDA4MDAwLAorICAgIFtIRVhfU1JFR19DQ1Jd
ID0gMHgxMGUwZmYyNCwKKyAgICBbSEVYX1NSRUdfSFRJRF0gPSBJTU1VVEFCTEUsCisgICAgW0hF
WF9TUkVHX0lNQVNLXSA9IDB4ZmZmZjAwMDAsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gMHgwMDAw
MDBmZiwKK307CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9sb2dfc3JlZ193cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0sIFRDR3ZfaTMyIHZhbCkKK3sKKyAgICBjb25z
dCB1aW50MzJfdCByZWdfbWFzayA9IHNyZWdfaW1tdXRfbWFza3Nbcm51bV07CisKKyAgICBpZiAo
cmVnX21hc2sgIT0gSU1NVVRBQkxFKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX1NSRUdfR0xC
X1NUQVJUKSB7CisgICAgICAgICAgICBnZW5fbWFza2VkX3JlZ193cml0ZSh2YWwsIGhleF90X3Ny
ZWdbcm51bV0sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIHRjZ19nZW5fbW92X2kzMihjdHgtPnRf
c3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAg
ICBnZW5faGVscGVyX3NyZWdfd3JpdGVfbWFza2VkKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIo
cm51bSksIHZhbCk7CisgICAgICAgIH0KKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRp
YyB2b2lkIGdlbl9sb2dfc3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51
bSwgVENHdl9pNjQgdmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kz
MigpOworCisgICAgLyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFs
MzIsIHZhbCk7CisgICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisg
ICAgLyogSGlnaCB3b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwp
OworICAgIGdlbl9sb2dfc3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK0df
R05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX3NyZWcoVENHdl9pMzIgZHN0LCBpbnQg
cmVnX251bSkKK3sKKyAgICBpZiAocmVnX251bSA+PSBIRVhfU1JFR19HTEJfU1RBUlQgfHwgcmVn
X251bSA9PSBIRVhfU1JFR19CQURWQSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChk
c3QsIHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOworICAgIH0gZWxzZSB7Cisg
ICAgICAgIHRjZ19nZW5fbW92X2kzMihkc3QsIGhleF90X3NyZWdbcmVnX251bV0pOworICAgIH0K
K30KKworR19HTlVDX1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZ19wYWlyKFRDR3Zf
aTY0IGRzdCwgaW50IHJlZ19udW0pCit7CisgICAgaWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJf
U1RBUlQpIHsKKyAgICAgICAgaWYgKHJlZ19udW0gKyAxID09IEhFWF9TUkVHX0JBRFZBKSB7Cisg
ICAgICAgICAgICBUQ0d2X2kzMiBiYWR2YSA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICAgICAg
ICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkKGJhZHZhLCB0Y2dfZW52LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19CQURWQSkpOworICAg
ICAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2NChkc3QsIGhleF90X3NyZWdbcmVnX251bV0s
IGJhZHZhKTsKKyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHRjZ19nZW5fY29uY2F0X2kz
Ml9pNjQoZHN0LCBoZXhfdF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGhleF90X3NyZWdbcmVnX251bSArIDFdKTsKKyAgICAgICAgfQorICAg
IH0gZWxzZSB7CisgICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkX3BhaXIoZHN0LCB0Y2dfZW52
LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQK
K3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sK
KyAgICBpZiAocmVnX251bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICB0Y2dfZ2VuX21vdl9p
MzIoZHN0LCBoZXhfZ3JlZ1tyZWdfbnVtXSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgZ2VuX2hl
bHBlcl9ncmVnX3JlYWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsK
KyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWdfcGFp
cihUQ0d2X2k2NCBkc3QsIGludCByZWdfbnVtKQoreworICAgIGlmIChyZWdfbnVtID09IEhFWF9H
UkVHX0cwIHx8IHJlZ19udW0gPT0gSEVYX0dSRUdfRzIpIHsKKyAgICAgICAgdGNnX2dlbl9jb25j
YXRfaTMyX2k2NChkc3QsIGhleF9ncmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaGV4X2dyZWdbcmVnX251bSArIDFdKTsKKyAgICB9IGVsc2UgeworICAg
ICAgICBnZW5faGVscGVyX2dyZWdfcmVhZF9wYWlyKGRzdCwgdGNnX2VudiwgdGNnX2NvbnN0YW50
X2kzMihyZWdfbnVtKSk7CisgICAgfQorfQorI2VuZGlmCisKKwogdm9pZCBnZW5fcHJlZF93cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKQogewogICAgIFRDR3YgcHJl
ZCA9IGdldF9yZXN1bHRfcHJlZChjdHgsIHBudW0pOwotLSAKMi4zNC4xCgo=

