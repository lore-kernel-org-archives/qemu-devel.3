Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF9510F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYD6-0001aR-Jg; Wed, 08 Apr 2026 15:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYCb-0001Rk-RY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:04:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP7-0005cO-37
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J857s3362755
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sW27XZh/polIRJ6zGlVRtPePAkF7zmzsx2Pd7RqkvxI=; b=OTU2X7M6vdsdAb4p
 NpF5DjBsV9BchO9kVrXnjwdB6jOruQREy3OxsQ5aA05RufiRAtZrDWlNPeihdesz
 TQAbHmmaGORU0ioZQd1q4nMoJHyHfsMoj4FaZ1P/Y0lu/Vn0GbWDSiMGhpLcx5gN
 uneKnPDh6SKH+FR7NGiQevLj70Zj4mw4RjqcGChIMEbLzrgTtVns2TDZGE0Yben6
 lQpKm9GXChAlXeW2/XmiHQ8tqSe9/WyGU/I4jHJfSnP0mow/7U+7LTfHTvdmTthc
 eDwhzgiSEjH7Fwt3pFAYYCyeZWOAHBuE0v2kCgP2SjEtcsDiVtX4Y373kBkTeqCD
 cZ+Lwg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tkheyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:35 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so1093532c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622035; x=1776226835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW27XZh/polIRJ6zGlVRtPePAkF7zmzsx2Pd7RqkvxI=;
 b=VJFjKyqb7Y/W+nDYdPKw9wOkUzqKkdEATzRCpdFblJYA8tVmbQk8mC7O3DkEEtQdnz
 jVDcpzX7+E4C6POw4PZPrC2NWTvZfpnpAUlGOTVGJGbqxbPCQM9WLMhII+KxfU/X+p3f
 2tZZhLLXdDXarhd9bidSxS+vtD+s7598gyh/c0fdWhCd/qjs7oDomEVyyckrN3NjVgwE
 SzkQMTOcyW3DUbq0GEVgoX7p/Feo83/Z3rrQBLukmd1lcHIVL3DIgur47p1jOjeioi9D
 sUBUsPj8SScl6D+EPjlqla3QvEqn0UBB98/b7JrmKOUl0oNCL+gxnHvr9H7XqbWtWVcu
 hAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622035; x=1776226835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sW27XZh/polIRJ6zGlVRtPePAkF7zmzsx2Pd7RqkvxI=;
 b=G1tuLrTR5V2+E7GPRITmLE7GVFUPLkJWkTta5U9pn8v8dhKnF2t0iF1MyZOiuihAtk
 QF6wUI9tt5CwOju+rB/doyb56PfTfVb/BPY67c9uJLPrkgvVsBWcL/ZkV2pgZHRGMXoH
 exPN6I+caOYWcPgT75dNKJfWzmLaEcyYgLl2oQpkjaVRftszeQuESLtl2FNKgUHETm2r
 UJpE55PSYCBVaR67jHGjladRaWzxCuOU3Knfnzwk9dMi9LuhjALdbL3X10xPAb7RPoEN
 pelfvpLcldPnSlDUFLYt4kzHM6CkZ0oGaUTYN+/F1d4oKHQHxFTRMb6AYv63HiBZANKX
 sCiw==
X-Gm-Message-State: AOJu0YzLMAMPwS4VcH9IIaZcqSVGA+6n04GJWC8rOv7QxxrvXPMIHqnN
 NWYSMfGhSTHTfp28hLTZ6T1n2QVH6PgzBVjCHnq2S1+p77/5y0tCPjk3RthftvSEKUz/k06vnGW
 7APw7wfoZLbNqG0iGZZjzhY5Drw3hdqaR85B5G6rtLaiQ8kgCfC/MCbPb+tus0Q3Bdg==
X-Gm-Gg: AeBDiesmie3hZvctH+XRW8+pOUvZttaUMnBChiiwEg8Imchcm+FEvVuRWBq14iaFytF
 meuixtQWm4AuZpvA6MogWZKxLJtLjbxBCCHj8Cw9skD7WSGJsKvGTCDMSz3eMzjzi9LRNl/0vA5
 cgM0u9tvn2joKFoZjppDMVpuFTfCu84w1JZ9L0GACqJygTEI0nt0eZzh7QLYFymwgol6Acg+Qbb
 kenzcOfoo41wKSWiqieEXYYeb4FZPIkiakQuxWw9C7t3IPKFELus3FL0t3da1vsEW0b2HnFevvE
 IG13TtLNo+zoliRRS/CZv7HH8H6AoRkGMyVogoOWc/VAkUJnhehNMkc40q1/OPQlYG42vZiAasY
 l1i7MCLWORVdun7Pq9C3x0xcdFR7BvqyDxQEBdMt4EZg9p7QEeV9E4raywdsppzGh2tAYOA==
X-Received: by 2002:a05:7022:6997:b0:128:d7a7:526b with SMTP id
 a92af1059eb24-12bfb745137mr11122791c88.22.1775622034686; 
 Tue, 07 Apr 2026 21:20:34 -0700 (PDT)
X-Received: by 2002:a05:7022:6997:b0:128:d7a7:526b with SMTP id
 a92af1059eb24-12bfb745137mr11122773c88.22.1775622034098; 
 Tue, 07 Apr 2026 21:20:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 25/28] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Tue,  7 Apr 2026 21:19:50 -0700
Message-Id: <20260408041953.1899532-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=drPrzVg4 c=1 sm=1 tr=0 ts=69d5d793 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: T-_7nGHyZGK8A0L1vZyMuks5KqE9m3HX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX/gXQ7huijtTv
 zZy8i12L9AGR/sMVodYIhsr6PXhcSLeMJlAKImgUW8Rjh/qA2XvnNcoe2dpoCmf5vTMfZLCDiGd
 b6F1/kVBqtkC9xRg3IDUuVxYSLn9+7bTytLu5mYI8dFFYJrK+re/1IJmqiS7F7QxCSTfQgJ3WCT
 8SwfB08TJdlo1nw/qLlzC91ap+5Y/EmA4bqyCdfqcmXspxBCvvUJ+BPMXoh8AtRKKHERjjvpq6D
 v504xWj0km+Y0qkp8PWOWWDsRIxnRssRGq0nZkGD+k9PTf0p7OxgJa7M4HQ2/hT/nAu8yEWFhVV
 R/GLI0S/avjNS7WyDaBWhJDIDTfSdurPxZHwPwWgEnjhNeydWIU+RYuUqkZhNQ0iJpcMttK1DCU
 OlhWQgukptvlq7fUo+8pPsBkclIkhTp0+KWsWNpa4wxBekN0Lmkp/Ueh3FR6fHKko0CwadcRK4R
 TydSlu1WW9CVsGQ5BBQ==
X-Proofpoint-GUID: T-_7nGHyZGK8A0L1vZyMuks5KqE9m3HX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICB8ICA3IC0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTAgKysrKy0t
LS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAyMSArKysrKysrKysrKysrKysrLS0t
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oCmluZGV4IDg2ZDc0ZWQyNTljLi5hMjhhZjBjMjQ1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM0
OSwxMyArMTM0OSw2IEBACiAjZGVmaW5lIGZHRU5fVENHX1MyX3N0b3Jld19ybF9zdF92aShTSE9S
VENPREUpICAgICAgICAgIFNIT1JUQ09ERQogI2RlZmluZSBmR0VOX1RDR19TNF9zdG9yZWRfcmxf
c3RfdmkoU0hPUlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKIAotI2RlZmluZSBmR0VOX1RDR19K
Ml90cmFwMChTSE9SVENPREUpIFwKLSAgICBkbyB7IFwKLSAgICAgICAgdWlWID0gdWlWOyBcCi0g
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC0+cGMp
OyBcCi0gICAgICAgIFRDR3YgZXhjcCA9IHRjZ19jb25zdGFudF90bChIRVhfRVZFTlRfVFJBUDAp
OyBcCi0gICAgICAgIGdlbl9oZWxwZXJfcmFpc2VfZXhjZXB0aW9uKHRjZ19lbnYsIGV4Y3ApOyBc
Ci0gICAgfSB3aGlsZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIGZHRU5fVENHX0EyX25vcChTSE9S
VENPREUpIGRvIHsgfSB3aGlsZSAoMCkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBl
ci5oIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKaW5kZXggMTdlNzRiMTJmM2MuLmE4OTc1OGI1
ZGY1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaApAQCAtMTgsNyArMTgsNyBAQAogI2luY2x1ZGUgImludGVybmFsLmgiCiAj
aW5jbHVkZSAiaGVscGVyX3Byb3Rvc19nZW5lcmF0ZWQuaC5pbmMiCiAKLURFRl9IRUxQRVJfRkxB
R1NfMihyYWlzZV9leGNlcHRpb24sIFRDR19DQUxMX05PX1JFVFVSTiwgbm9yZXR1cm4sIGVudiwg
aTMyKQorREVGX0hFTFBFUl9GTEFHU18zKHJhaXNlX2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVU
VVJOLCBub3JldHVybiwgZW52LCBpMzIsIGkzMikKIERFRl9IRUxQRVJfMihjb21taXRfc3RvcmUs
IHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8zKGdhdGhlcl9zdG9yZSwgdm9pZCwgZW52LCBp
MzIsIGludCkKIERFRl9IRUxQRVJfMShjb21taXRfaHZ4X3N0b3Jlcywgdm9pZCwgZW52KQpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYwppbmRleCBhZWVhNDcxNTM3Mi4uYzRhZDYwMTU2ODkgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBA
IC02NSwxNSArNjUsMTMgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9u
X2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50cHRyX3QgcGMpCiB7Ci0gICAgQ1BVU3RhdGUgKmNz
ID0gZW52X2NwdShlbnYpOwotICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogJWRc
biIsIF9fZnVuY19fLCBleGNlcHRpb24pOwotICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNl
cHRpb247Ci0gICAgY3B1X2xvb3BfZXhpdF9yZXN0b3JlKGNzLCBwYyk7CisgICAgZG9fcmFpc2Vf
ZXhjZXB0aW9uKGVudiwgZXhjZXB0aW9uLCBwYywgMCk7CiB9CiAKLUdfTk9SRVRVUk4gdm9pZCBI
RUxQRVIocmFpc2VfZXhjZXB0aW9uKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgZXhj
cCkKK0dfTk9SRVRVUk4gdm9pZCBIRUxQRVIocmFpc2VfZXhjZXB0aW9uKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgZXhjcCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCBQQykKIHsKLSAgICBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIo
ZW52LCBleGNwLCAwKTsKKyAgICBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoZW52LCBleGNw
LCBQQyk7CiB9CiAKIHZvaWQgbG9nX3N0b3JlMzIoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdl
dF91bG9uZyBhZGRyLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCAzODcyMWQ3NDAwNy4uYWU5ODBjMDg3ZjAg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5jCkBAIC0xMjYsMTIgKzEyNiwxOSBAQCBpbnRwdHJfdCBjdHhfdG1wX3Zy
ZWdfb2ZmKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcmVnbnVtLAogICAgIHJldHVybiBvZmZzZXQ7
CiB9CiAKLXN0YXRpYyB2b2lkIGdlbl9leGNlcHRpb25fcmF3KGludCBleGNwKQorc3RhdGljIHZv
aWQgZ2VuX2V4Y2VwdGlvbihpbnQgZXhjcCwgdWludDMyX3QgUEMpCiB7Ci0gICAgZ2VuX2hlbHBl
cl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihleGNwKSk7CisgICAg
Z2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihleGNw
KSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Y2dfY29uc3RhbnRfaTMyKFBDKSk7
CiB9CiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIGlubGluZSB2b2lkIGdlbl9w
cmVjaXNlX2V4Y2VwdGlvbihpbnQgZXhjcCwgdWludDMyX3QgUEMpCit7CisgICAgdGNnX2dlbl9t
b3ZpX2kzMihoZXhfY2F1c2VfY29kZSwgZXhjcCk7CisgICAgZ2VuX2V4Y2VwdGlvbihIRVhfRVZF
TlRfUFJFQ0lTRSwgUEMpOworfQorCiBzdGF0aWMgdm9pZCBnZW5fcGN5Y2xlX2NvdW50ZXJzKERp
c2FzQ29udGV4dCAqY3R4KQogewogICAgIGlmIChjdHgtPnBjeWNsZV9lbmFibGVkKSB7CkBAIC0x
NDAsNiArMTQ3LDcgQEAgc3RhdGljIHZvaWQgZ2VuX3BjeWNsZV9jb3VudGVycyhEaXNhc0NvbnRl
eHQgKmN0eCkKIH0KICNlbmRpZgogCisKIHN0YXRpYyB2b2lkIGdlbl9leGVjX2NvdW50ZXJzKERp
c2FzQ29udGV4dCAqY3R4KQogewogICAgIHRjZ19nZW5fYWRkaV90bChoZXhfZ3ByW0hFWF9SRUdf
UUVNVV9QS1RfQ05UXSwKQEAgLTIxMyw4ICsyMjEsMTEgQEAgc3RhdGljIHZvaWQgZ2VuX2VuZF90
YihEaXNhc0NvbnRleHQgKmN0eCkKIHZvaWQgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKERpc2Fz
Q29udGV4dCAqY3R4LCBpbnQgZXhjcCkKIHsKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwot
ICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPm5leHRfUEMpOwot
ICAgIGdlbl9leGNlcHRpb25fcmF3KGV4Y3ApOworI2lmZGVmIENPTkZJR19VU0VSX09OTFkKKyAg
ICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGN0eC0+cGt0LT5wYyk7CisjZWxzZQorICAgIGdlbl9wcmVj
aXNlX2V4Y2VwdGlvbihleGNwLCBjdHgtPnBrdC0+cGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNl
LmlzX2ptcCA9IERJU0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjgsNyArMjM5LDcgQEAgc3RhdGlj
IHZvaWQgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53
b3JkcywgaW50IGV4Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19n
ZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0
aW9uX3JhdyhleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0
eC0+YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9
IGZhaWxfcGM7CiB9Ci0tIAoyLjM0LjEKCg==

