Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A9CFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaA-0001jU-PB; Tue, 10 Mar 2026 23:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa3-0001fL-Ew
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa0-0005FC-Hi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B39cES248940
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=; b=ZuJr0I/fNYYWZjcj
 lDZMf7xJuclO9kXx9OvYK8iSMcvJP5ivt7fT0XoSjNX0Tjx9BphsYjnAmzNYHAOB
 BWMPkXvC3zo9Mrs3dCeR041fdbI3d+X7vumx1Yys9hBY+hhR6EYGyKYc5OZhKjak
 KgriWPgxYOyYOuZEKEUNlFvSv8Hpjuni98341UzWBR9k0B4N+XQL72aORrDMdP2i
 2JXVidL1Jx/zi7FnaDB8fhhWSfm4Wx0yoWaNSB7PdnrvXyxMxNUGYfT/gYKsqCBf
 OK64bCvc/S9VhZdMwQ8WUtDHr7REHIttJwXakmuj10RTaVmPEDxN4M2Qh/r8DK4w
 leFEtQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11rb3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:51 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d74be44ccdso20894875a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200991; x=1773805791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=MOHOrDbOiL/SPzoG+lfzcvzCabrwNgbqamDsPBxv7peDsxTU23x2a7YTDHNRMdTNky
 7mQ8iNE6c15ULy/8+tN6jv0fCzNcMzPeJsisiWTeM+Rjnzl5jdIPG9HQj/h1CBorxtAU
 t35wZCBhQ8qszTzUDMOuNz2PGwio0DhRENKhXxmcAAyC4WoiGtocY8xo2YHey/bz2WsM
 Ef1AcNWH2NK3AFgHEaRm04cCkHtNpznRXLrhDDM8aYeB3A0cbkhzpRygPJkWWttP8SuH
 ozhkDzH8GaZw1A4ckZrGG+CiUMKhw7wYv7oRpSQl7ASYz+MnMcHHrgCYFotrtqn+c3N1
 pdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200991; x=1773805791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3X8bvXVW52I3fn1FyNjUiMXuaCQjKXZ/zTx+8O5PNqc=;
 b=KNYQkijgJos0sFJszcB2PtX/ZgS4/9+wQq5E0dvTnKfGt5UrkR1eU7RkwTejyOtmkZ
 xcETzYUtr2ocHL+1s7srdaDryb9u74Gz7kOwm6TMbue+Vcbiwns7DilzYo1h2qa9HtD+
 62Hk0k2qqAjT+Cfmiq9iggBcmE70VXlP3ZgHWgwe8t4Td5I6D7Lc1xZ7FZJhptUxHWsG
 lnhNZ4+DajknGJm5BdxLzn1II92av2uIOrIlPpAEhf13elGc6zPOBSr5BZPsZRkZSOrQ
 WSZaDAwVuSukEwSqNJ2K1GkoI9LSRvlZ3+loxH+xreTsDL34lj/2QIYLRJxJbnakLFBP
 4+lw==
X-Gm-Message-State: AOJu0YyLX8VcKjiipna3hcyrvpGZBqDwqqWf2CjQtLXuCHerh9PzIRLV
 tHYmpqSWge9dH53YsSiS1Lssk7M33dt1BHhdqarSAA6eHgFaBFMBOPSbKoS0PLVNPWZmzCqTg/g
 /Eu32XhgyG5esMD0yz4ut22O9Z/FSG33lKqOlVPVH7ya78dFXrs3I0/QtrOxjkSKr8w==
X-Gm-Gg: ATEYQzxtMOtpjjAHdb6HnR6AWPzii2tWFUxqdApXXy1v5+vv+FuBf0tjRk8D9KgB80S
 69mZStb37WsiFgBrpl+nlALOoG2rISa8Btgc3kwRsmRJptz7Pkr23+avTd9qGlLuDDOCJ9xSs0O
 +aehSoM4CvzdZZpysjjfnpimjnH3fQCWk0GKOCLEQMpL+tTHuYiITDvGObmq4uAgkyUUu9DksGC
 2uNwu2xm0SyGue/Rm5wMQ8F/N6XkiopNbTJR2WJoQIuHOxO2pp9bmNC8iaQ1pOdjXKb/2JK3fQY
 aDoBrK4KhIJuGLTmIBJiCN/Th7A39V990P6cx6ILEGa3Ezt8GNva8rOnB5zSiRBFpCrsnvw6e2Z
 B1iMvSxzXuD2hkwVWEUYeFv0zv6LNIpEk/Za7+UrkJ64vJsLVwSsupcAwWWcGyTnKaiE6jw==
X-Received: by 2002:a05:6830:398a:b0:7d7:5073:fc45 with SMTP id
 46e09a7af769-7d76a8b13c2mr911215a34.28.1773200990822; 
 Tue, 10 Mar 2026 20:49:50 -0700 (PDT)
X-Received: by 2002:a05:6830:398a:b0:7d7:5073:fc45 with SMTP id
 46e09a7af769-7d76a8b13c2mr911197a34.28.1773200990517; 
 Tue, 10 Mar 2026 20:49:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 18/35] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Tue, 10 Mar 2026 20:49:06 -0700
Message-Id: <20260311034923.1044737-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXwyiPw35Yohsu
 7lpdg1JHxYbj6/m0D/ORrE2T18YDIDUhMNo9pL9Ov8WWmxQm8CJQKiqeWgGVRlP7UicHGGzPJQA
 2nTHbY88XV5nxohFsmpXCU4e4JGOTghl4dtV0gXArY24tz2/9V+n/AQo6cIsbWr1HURu0R0751I
 unqRnd34uwEfIQzVJduUbILaZPOgQfwTjPiPPk2MXFJKiSkc7WiLlqohpDnVnkebNECcxHIY0n9
 Y1Iec1rwKooWmGicKxdJgd/otZ4OeCGpm7FLppUfdIoEK9Zc9j5X199TmQjA53mmIJD6excvb9d
 WJSSgd7vYgbP1J3N1f8pfnzBl4YQNZFOUGkjw86aan8rrfN2CUKbCvwuxbFzWbnrMNPL3udJ2R8
 +hJ4F30z0LkP2UkEFSVrNl+Oq7VVx7iqXCQCtywZDXyQvT/ppx49XiNVS1+hPtuACNbV1XeeGNK
 XeUus5m3N4l0VR8oMYQ==
X-Proofpoint-GUID: wgXDQ-BoyW-FrXWmzSXDlj4tfYwX0kIr
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0e65f cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wgXDQ-BoyW-FrXWmzSXDlj4tfYwX0kIr
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
cGVyLmMKaW5kZXggNTM4OThkYjgxNWIuLjM1OWJmMTJmMWYyIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3Myw2ICsxMzczLDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
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

