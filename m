Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47877CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNq-0002hq-Ll; Thu, 25 Jun 2026 10:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNg-0002gV-QV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNe-000091-S4
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k0tK1398063
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=; b=ih+ZnKQlmXYG6ocq
 34DNqXW0adE6Ma3IuP2Sh9aiUgM70vLHt2ULkqiOUPyoowGkl3PY4bbFOanyUWL0
 g8qbx/o8o2PGx+x/bSiRi0pFyRRF0WUcCEUVYhtDoAextdbK/JFf9tukAUyV+Rd3
 /Elm6X3QNI4MotW/TkW4Zf6XOSAOrGP3GspyjGOLfimA+LPN2s9r5F2bL72Mi55k
 WH0Ku3JXv9HrO+06zGyNqyy+ZCuQ7xr+Cv4PYibUAqUFx5Fmv5rcT5+97OAsBD+Z
 VVFTU/z1bl7FrqiGOB2I0BZV1mk5NT7Bs972pmkr7YkvA3YUDX4nd6ayXA/P4hmu
 htHdJw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uudjmqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcbb34e57so2846166eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398917; x=1783003717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=cwoFGZEsI9sowWG75YxZxHCzrPQyf8ejfleqO9HoR5lRpdn+ElxBxyNKk8cYGNy14+
 1hN6uYbXpb7udDATIQ4moBy8t62RfczUvNUcpJ4qf7d3/Vb7p6mXC0/44ICKRc0IvSj3
 4hSnO23nOwG+Lj4qV8lD35MXqFQtZfJqjLa0GBiSj3NFmm32CYel86MwJcIsvApeBYcG
 qkvHGklMfRiyIl0xNVUESM7eq23WBhe+u73CjY1IrCDngBNJsm97E85wVpZuVBIkVzyK
 069hsMzNZQf+dFqVdBonzCYz/pX/He0VjgtMhvriglE652tSBflCamUI2fxOmsxs/Cxh
 Wo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398917; x=1783003717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=mM/IrXSflsaIWw2FWuhOA0qvXI0GD3V5Ejm7OUDZsphqA5MMr3cWWif/XasOmKJDJ4
 5p9yMTPGpK22ZoHTLO44cPln/Qndv5lRk5JoJtLk2VO+tt7xrBobmvoVNLOZXr2EofE+
 pClNpN/FN1a+R0hyOnPvwjpZFORPCmsM4JkJaQNd3fLbDUkm3jvmcox59B9Vr5WtmlDX
 EXdRRaRipAgulf1oTdrWdT7dVcN5X19kKjGJowOKGTI65acVvjYI9aRIAb8VTt/yH3Wi
 sH7aDM+iVHrcinxaSCZfM2tKI4Q5bA0/7bquIujNoNb89rWz8D5rjcyEipRPDmZ+om+e
 l4mA==
X-Gm-Message-State: AOJu0Yw6yTpims67AoO2iCx4zOuUCBLufKny99kA+GDNTASAe9C3/2Cm
 oFEBnQh53cTmytX+KlLLzfLgBP5QaIY7xzr9nqtgT2xYTkDm/WbgLeBjaBoUcemsXSaKzQ8nKcU
 WrB+F/wcvrJIu4tiQhJTNynbpe5/TXO9HttGc5YtHDdrS7WGYjZQ1E+U5EYmSAV/yEw==
X-Gm-Gg: AfdE7clWsYakDvUjnmIoDjlAn/n6VXpDM8UOra9SfedDsjHEiIfGICFY92gMzb0xgvS
 r48cK7cXkPCLBnwtA4n8gzml1C4xt/gB9JdTJ7u+Ejv0Cg+naimMnnLRMT3JF5lbnPpdcsLLoXw
 jBOti9IEwO6ZyUqQAHbyhCLiYJ37fH4jfd4OkHH3wcBSk+Wka4T50t9ULnDLryhKrS3FeFNg/k4
 T5bXAkI+z1hMbtoW9KR19/BxdF7vYvA96G8VdCtIsvokSR/Pvvpqflsd+EhsfDWEX+v4vUzLfOW
 IleI7anmf56FTCwkjP0xjIVv63et9m/Vpg/Y6XOjyGy6jnznusShWQcVo8g+EYReRvwMwEB6XTt
 ztKy4yujKUp0/jd8Wujyqb88hlrg/n74y0QmQGzGpYQqT9DJMzd5Oa3RUiE4=
X-Received: by 2002:a05:7301:608:b0:304:ab8:f89a with SMTP id
 5a478bee46e88-30c84b21483mr3192411eec.1.1782398916821; 
 Thu, 25 Jun 2026 07:48:36 -0700 (PDT)
X-Received: by 2002:a05:7301:608:b0:304:ab8:f89a with SMTP id
 5a478bee46e88-30c84b21483mr3192384eec.1.1782398916286; 
 Thu, 25 Jun 2026 07:48:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 59/76] target/hexagon: Add pkt_ends_tb to translation
Date: Thu, 25 Jun 2026 07:16:16 -0700
Message-Id: <20260625141633.449487-60-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX1wS1DYBtSU+I
 xcibZTfK8mBesBcmLhIrpkKCt29htkDM1cKXuWV+y7VDybHm2IPNoVhlffZnoVMuXT1AKAuXjJP
 jFpWtNkKSn7SOEv0shkGDvyuR1dazS4=
X-Proofpoint-ORIG-GUID: pZCNLezKegmBvntXwbkrQQporH7DbrZt
X-Proofpoint-GUID: pZCNLezKegmBvntXwbkrQQporH7DbrZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXzvWINkNQPeeE
 oLrQmDNtbILFsGATqPi8Mh+loexBmGGelErLUNL94rh3JVMn3hMff2Y1w9HODyQyHx6pu0zNfNm
 b66sfu+MDet5Faw5RdATAlWL59S0iuc/sou9CxghV50h74oZUQIPT2cZjgmbp/7DeB+Gtik6mmZ
 L/7Y7Vl62kE77/pyBWS1jZeczGgM7WA4oRPMA2YOp5oT6PS6Oc20KvmuW5SUtIaJUvKWGchJWfo
 Hy0SfBIvypG0gIX3ZcLTX6O0RyJloNnItN7i2Ng5HMyFR83+eI62BJUb4bx+DCLN7c/42LNqV0r
 xyBLzNEd0TZnOTTRzsrFZ9s1hekZ492r/SIX1ZinyGe/ifprtcZ9aksG81FXeYGJ7gJCIYA7582
 ygHob4xDblQFfza2JZDIIhdPoppRWSfimXHABKuPC2xlgsoDp5hPFTIMkw06xwf/DHSJM1L3w2g
 iKT5pbafDCR9CsQkqlw==
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6a3d3fc5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PUAfe4L2FItr89aHCx8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgICAxIC0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTAyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTAwIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBmNzliZGVkZDdi
Ni4uZmVhODhjYjJkYjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04Niw3ICs4Niw2IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOwotICAgIGJvb2wgcGt0X2VuZHNf
dGI7CiAgICAgdWludDMyX3QgbnVtX2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCmluZGV4IGNlNWJiZTkyZDVkLi4zNWU5MDM2Mjg4MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTI3
MCw2ICsyNzAsMTYgQEAgc3RhdGljIGJvb2wgY2hlY2tfZm9yX2F0dHJpYihQYWNrZXQgKnBrdCwg
aW50IGF0dHJpYikKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBib29sIGNoZWNrX2Zv
cl9vcGNvZGUoUGFja2V0ICpwa3QsIHVpbnQxNl90IG9wY29kZSkKK3sKKyAgICBmb3IgKGludCBp
ID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKKyAgICAgICAgaWYgKHBrdC0+aW5zbltp
XS5vcGNvZGUgPT0gb3Bjb2RlKSB7CisgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAg
fQorICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyBib29sIG5lZWRfc2xvdF9j
YW5jZWxsZWQoUGFja2V0ICpwa3QpCiB7CiAgICAgLyogV2Ugb25seSBuZWVkIHNsb3RfY2FuY2Vs
bGVkIGZvciBjb25kaXRpb25hbCBzdG9yZSBpbnN0cnVjdGlvbnMgKi8KQEAgLTI4Myw2ICsyOTMs
OTAgQEAgc3RhdGljIGJvb2wgbmVlZF9zbG90X2NhbmNlbGxlZChQYWNrZXQgKnBrdCkKICAgICBy
ZXR1cm4gZmFsc2U7CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIGJvb2wg
c3JlZ193cml0ZV9lbmRzX3RiKGludCByZWdfbnVtKQoreworICAgIHJldHVybiByZWdfbnVtID09
IEhFWF9TUkVHX1NTUiB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NUSUQgfHwK
KyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19JTUFTSyB8fAorICAgICAgICAgICByZWdf
bnVtID09IEhFWF9TUkVHX0lQRU5EQUQgfHwKKyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JF
R19CRVNUV0FJVCB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NDSEVEQ0ZHOwor
fQorCitzdGF0aWMgYm9vbCBoYXNfc3JlZ193cml0ZV9lbmRzX3RiKFBhY2tldCBjb25zdCAqcGt0
KQoreworICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAg
ICAgICBJbnNuIGNvbnN0ICppbnNuID0gJnBrdC0+aW5zbltpXTsKKyAgICAgICAgdWludDE2X3Qg
b3Bjb2RlID0gaW5zbi0+b3Bjb2RlOworICAgICAgICBpZiAob3Bjb2RlID09IFkyX3RmcnNyY3Ip
IHsKKyAgICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc2luZ2xlIHNyZWcgKi8KKyAgICAgICAgICAg
IGludCByZWdfbnVtID0gaW5zbi0+cmVnbm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0
ZV9lbmRzX3RiKHJlZ19udW0pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAg
ICAgICAgICB9CisgICAgICAgIH0gZWxzZSBpZiAob3Bjb2RlID09IFk0X3RmcnNwY3ApIHsKKyAg
ICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc3JlZyBwYWlyICovCisgICAgICAgICAgICBpbnQgcmVn
X251bSA9IGluc24tPnJlZ25vWzBdOworICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190
YihyZWdfbnVtKSkgeworICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAg
fQorICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190YihyZWdfbnVtICsgMSkpIHsKKyAg
ICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAg
IH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisjZW5kaWYKKworc3RhdGljIGJvb2wgcGt0X2VuZHNf
dGIoUGFja2V0ICpwa3QpCit7CisgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKKyAgICAgICAg
cmV0dXJuIHRydWU7CisgICAgfQorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyogU3lz
dGVtIG1vZGUgaW5zdHJ1Y3Rpb25zIHRoYXQgZW5kIFRMQiAqLworICAgIGlmIChjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfc3dpKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
Y3N3aSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2NpYWQpIHx8CisgICAg
ICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9zaWFkKSB8fAorICAgICAgICBjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfd2FpdCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFky
X3Jlc3VtZSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lhc3NpZ253KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc2V0aW1hc2spIHx8CisgICAgICAg
IGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9ubWkpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNv
ZGUocGt0LCBZMl9zZXRwcmlvKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
c3RhcnQpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zdG9wKSB8fAorICAg
ICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfazBsb2NrKSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTJfazB1bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUo
cGt0LCBZMl90bGJsb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxi
dW5sb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfYnJlYWspIHx8Cisg
ICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9pc3luYykgfHwKKyAgICAgICAgY2hlY2tf
Zm9yX29wY29kZShwa3QsIFkyX3N5bmNodCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShw
a3QsIFkyX3RsYnApIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJ3KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTVfY3RsYncpIHx8CisgICAgICAgIGNo
ZWNrX2Zvcl9vcGNvZGUocGt0LCBZNV90bGJhc2lkaSkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7
CisgICAgfQorCisgICAgLyoKKyAgICAgKiBDaGVjayBmb3Igc3JlZyB3cml0ZXMgdGhhdCB3b3Vs
ZCBlbmQgdGhlIFRCCisgICAgICovCisgICAgaWYgKGNoZWNrX2Zvcl9hdHRyaWIocGt0LCBBX0lN
UExJQ0lUX1dSSVRFU19TU1IpKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBp
ZiAoaGFzX3NyZWdfd3JpdGVfZW5kc190Yihwa3QpKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyNlbmRpZgorICAgIHJldHVybiBmYWxzZTsKK30KKworCiBzdGF0aWMgYm9vbCBuZWVk
X25leHRfUEMoRGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgLyogQ2hlY2sgZm9yIGNvbmRpdGlv
bmFsIGNvbnRyb2wgZmxvdyBvciBIVyBsb29wIGVuZCAqLwpAQCAtNDM5LDcgKzUzMywxMSBAQCBz
dGF0aWMgdm9pZCBhbmFseXplX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIAogc3RhdGljIHZv
aWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIHsKLSAgICB0YXJnZXRfdWxv
bmcgbmV4dF9QQyA9IGN0eC0+YmFzZS5wY19uZXh0ICsgY3R4LT5wa3QuZW5jb2RfcGt0X3NpemVf
aW5fYnl0ZXM7CisgICAgUGFja2V0ICpwa3QgPSAmY3R4LT5wa3Q7CisgICAgdGFyZ2V0X3Vsb25n
IG5leHRfUEMgPSAoY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2swbG9jaykgfHwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxibG9jaykpID8K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCA6CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNlLnBjX25leHQgKyBwa3QtPmVuY29k
X3BrdF9zaXplX2luX2J5dGVzOwogICAgIGludCBpOwogCiAgICAgLyogQ2xlYXIgb3V0IHRoZSBk
aXNhc3NlbWJseSBjb250ZXh0ICovCkBAIC05NDQsNyArMTA0Miw3IEBAIHN0YXRpYyB2b2lkIGdl
bl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPnBrdC52aGlz
dF9pbnNuLT5nZW5lcmF0ZShjdHgpOwogICAgIH0KIAotICAgIGlmIChjdHgtPnBrdC5wa3RfaGFz
X2NvZikgeworICAgIGlmIChwa3RfZW5kc190YigmY3R4LT5wa3QpIHx8IGN0eC0+YmFzZS5pc19q
bXAgPT0gRElTQVNfTk9SRVRVUk4pIHsKICAgICAgICAgZ2VuX2VuZF90YihjdHgpOwogICAgIH0K
IH0KLS0gCjIuMzQuMQoK

