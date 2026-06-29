Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA9C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39T-0001cM-Hx; Sun, 28 Jun 2026 23:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39R-0001bs-Ri
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39Q-0006GQ-C2
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cfc21545108
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=; b=BsVdPdHxZ19Jvnx1
 Aj1Kik6eXLLOZWYcZbmoaaAwYgO95C/hCKyScw5m0koNYcVO0x6xcz5ZBcs434pc
 jVCfeXKR2a4gZuQo0aw6wPHBL/2jD7H6QefsDsizjTJe/MJhxh0nasL60Y9TeyZX
 RC9M1qBExKUZkgxOcoEJ28Di28GtMvMEfFkX3e2VRNnrgXeI+JL5ktHHo2jZyBZC
 r640ccPsPmYyf8etSNVtdVD4I2VjVrDOul0NZqI1hZthRQedVh4cvmIWJ0LOKP1C
 YdthNJJqHZUJB0BTe+m9mGnrPxAC1o5Cs//RCdP0C+26jNXKG6+bd5qfhfyAmT5u
 ef2qfA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27084b01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so11594475c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705554; x=1783310354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=QR3qWvMtnk6sO7sOQjG2nfDG+1Eb7WeEt/KWxF1Zx563+z0fGEy4kPyrrHyiWxJQU9
 CMm97rnO9KVpX3Apf5PlkpjLcLKvriR9ngbCQ6ScYn/NE6r81VQmvypj/Iz2Vwzw/yXW
 HkAiolwtxucGNcnrz+M4J24RSj4Kw8+Amqfa2p4Kvggz3IyJg0vWxqss9GXOWXkc6i6e
 6gRazae3ADcz/pOSm9Xqzmia15DvmDM3iEUoUXdVXAj/zkx75pYIe/AOKT/6H7tkDgw4
 wQV84SvDmE/T270YKryhmhi21kfbrL2c0qFnpqR01mzhircoCr9sXZUByIdLLPbgSE23
 jD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705554; x=1783310354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=bGCbz8ll63I2YNnoFbs7UzDB4HJ8/sK4EcfWhRSECvI5tZjzpIKIXdZCOxx+/36/9H
 mrFWuM8DK62NGu8HI1tN74Ixb2bARY9eqpi2FPTUEZ5TGA88qM+0w0Lr7ltPkgxaKJf9
 N93rmpNl0yxM0rdI9Dy+QKYWif4teKXgbVbIbCAjZ2fY7PsBmIdir5UVhtkH5/EOMe23
 4LTG54WqtD5OwGjyngrlCB4a4Wjdxv01snONI8k2yCJ5pwXte+RKbObBSzsbI24Y1WK1
 CDJCuCzj6SrIzNdwvbxFu6RT4nSuf8WUHmY1ZtUqzUbJyKYBjD1Eba1mLXUrCjKvBPVf
 dmgg==
X-Gm-Message-State: AOJu0Yza8caaFKvoW0+IZOL7KxuVal8hE2VkBM/7vZr2acaxitN5mrK+
 ilhdkJB/aNS78vNLtC/EhPj60aBUMlBXiKjvQZzGrbjjaC+kh8cGbh6SB+UXjsrc+OeIPVGCXyy
 /KV8a4OMBSODs0F8VxpTdGvJ/lefzw6RugQqj9rYHCj2Sgez7hQsBj26xpHKenOcqag==
X-Gm-Gg: AfdE7cnDn8MSDvG3ZoiNS1L48cG+HEnvOTrUHjRcbKDy/JJTz/4dg1U5zWv4CmhSEb9
 QJ+94M5eSCrHl0mA2gR7czF3wuaABcmKi4TJ2NGwEXZy0zkK/MDsAvhJk7XP4pxHl9diDgPhdrb
 lZDvL/eOt+PVeohLxQ2Hzi5At3HJYHUHGOQF1mF5ZAyCxl/1f7nKqlbawupcEKyoynXRQmT4hbA
 NbVBINzUqFk88fbAk9ln3hru5I3RMbXTET4RPhhBu0EESQ8m8HXBEhrfx4dneBLsUYMMj+ljRcf
 5JTML+O5ZWvdzoo0Cm6jvoOrwWyE3VUHd8t9yq782FroHc88iTTtYthaG+JaNzA5LTtGNmkB1F9
 8Fv2J9cSplQxVJ+wXAtHiAVXz3sl7dfwEgTE3FAG7HQKLkZiO4IxD8NI5nEk=
X-Received: by 2002:a05:7022:ebc4:b0:139:7bac:db41 with SMTP id
 a92af1059eb24-139dbb49566mr12193794c88.28.1782705553755; 
 Sun, 28 Jun 2026 20:59:13 -0700 (PDT)
X-Received: by 2002:a05:7022:ebc4:b0:139:7bac:db41 with SMTP id
 a92af1059eb24-139dbb49566mr12193787c88.28.1782705553265; 
 Sun, 28 Jun 2026 20:59:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 21/77] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Sun, 28 Jun 2026 20:57:34 -0700
Message-Id: <20260629035830.1520296-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41ed92 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX/L9aSB8neaVX
 C7A+i82+HQXybeWd9LtyvHcZYNn533Ua4Dj9V51YCRKs8AOoaiV3jUU5PulD2c+7mAHcLhWNSxj
 dywGa6O+ewDMOOKfqYftacGdsh16K9GjDtrQJb7Fv8auloCxo5T1yGBheJjY9fe/2tatj3RNEFF
 jCOE2PAZ0ZIr1WuFhhzWEhy11f+/LJOL+J/jtjTN57MozJHyeMCvJrP9g1rAjGvmu0BiQ6CBIE6
 7k7CNcf1I7QpYkTgSZHbDguPW2lvT+xEpU3okagZJyjN3CV76zPumMyGRFABHYOg4fUnbsbfPPs
 W4ke2hnDVh/dFQbDBZonE6YHp9JaXXT+Iif7upuoBmuS2rvnRsyWWaMJaUDfNf5OmOOwj/gjkrF
 h1REr+peuKRnGOJ2RPYT/dyyREyK8FUW0kWwPBKThlbISCROEA6wZEjHBZeQ64QxoaIkWzo3jni
 YlFZ+8WTux1HtpUcz/Q==
X-Proofpoint-ORIG-GUID: 20Mf2uTTsL3xJXHKvluOeQGCKGDjsff9
X-Proofpoint-GUID: 20Mf2uTTsL3xJXHKvluOeQGCKGDjsff9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXybrWk55VdoXB
 cW5OGC1UasuZeJTLzpuChCp4Te/5UAQQKb85pX6qkFCFfKUCD4el5WEvQJs6hiaEgC4sR+PUUpM
 X1M6VR0rceDpf635DF7+jR2B3Ss5NXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDggKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaAppbmRleCA2NDQ1NjgyMmJjMS4uMjhiOWI1OWUwZjIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBA
IC0xMDcsMyArMTA3LDExIEBAIERFRl9IRUxQRVJfNChwcm9iZV9ub3NodWZfbG9hZCwgdm9pZCwg
ZW52LCBpMzIsIGludCwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfc3RvcmVf
czAsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQs
IGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9p
ZCwgZW52LCBpbnQpCisKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBF
Ul8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzcmVnX3JlYWRfcGFp
ciwgaTY0LCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCisjZW5kaWYKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNWI5YzI2NmQwMmYuLmNkMzI0YzE5YTlkIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3NCw2ICsxMzc0LDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3ZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50
NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVM
UEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFk
X3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUg
cmVmZXJlbmNlZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUg
d2FybiguLi4pIC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

