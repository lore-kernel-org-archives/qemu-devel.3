Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE66ACDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktR-0006jI-AI; Thu, 25 Jun 2026 10:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktO-0006iZ-R3
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktL-0008Tc-F1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvlt1754134
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=AuORlnyYTQ/YQCS8
 39jiNuNzbucg409N+pTzldAG+CexCBcAzGAtW29MlW3jznYb/7MR+n1B0BvRA26D
 k/FlOraRUhCKwVENmuAqii249wfMFfpc/eX8rGzBnw2/1hFtEU9SPmj2ASocXqn2
 RR1fYccPlUQt+5uZzxY8B+xrNssWSnbWyiDqmP+bnS0aOvGPhZhZCjNHdlKmas3L
 OR0symWQHIJH3Whbwchd1/AD1GjihDs53zNqR0vi6T8J3fZYECZg67Rv8K2N7fRG
 0s/VxHBPWZTC1um1TVK4GRIst4DkNq3MqH0Wjq67cVVO379HEDwb++i62TyE0oXo
 2rFJFg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q26u9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137e49e896aso929612c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397027; x=1783001827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=e5G2rFO8tp4GOqAcPVD99hqwnvpXF8oxs0DNZM1NqElr8m++Sk2KTaFmA/RDWXcTqU
 jucIcpsfXegCzHt0BqxWGlV75nuKQFacXbTLFd+0NjAes+lh9jbtCSccE9UnIyBu8b1S
 rLF8vdr3W3ojsvbdqB6jyMvjZ3ffgOcg4sI+R96sOhE1DpmqCSZmpc7cFkkHW1+Em68D
 JaXluT5WT7s33wSjeZZ3KYw8wSlS4xZmknMjFL3Eey4McZIgNPqAjwHAhbQyQRpAHczB
 k+jVP5kPO55auNGlU98TpfFbI5x+WsrI1tm0jd63dHjBdXwOGdGDeoqXj3gUpIK7UheF
 YykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397027; x=1783001827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=pViogyGW0myDhaFH/ipBhM6jGNpy3YybAtMvXYuqKKhniaHZBU0+hEEs2thcxU6njP
 DOX3ERKmVCNUCd4DY+O8EnhXGX2a9jxGMHrlCJGGO4SVISTUDM6+VCeT2m8/6tFQicbV
 W2LnxxIYeCjA++XD8tUH21eSH8TxjcaFeVXR1nI4xt/9jwcNAmEcWR78qhjXux+JRH+U
 mCMj7lml9MlY74NKbycG1Ia7vb7dbdrWOSxnjWtihvGtuEnBg8NIDzCdA7QduQv1LpIC
 sgogoX+R37AEPTTzfRRUjjyqobYFxnz61ULvbSnEZQOqCKY4BJ0gPZNIF6f0mMtDLVSO
 yDng==
X-Gm-Message-State: AOJu0YwDzgR2sfu6vnhzT8AaWYQti4VG4l9oZMBl+h0NoAiLv0rO0RGV
 hsT/pt9LJveXHj4v675r2iATroVtSZgZP0XwhtH6zhz7a+H6NEUhPOrvPdXXP/ez3vuHU0bZjoT
 FbPfFy5g9Ep9ZPv3e9mgRIFEMMbMSbxN07sfuKMT5/Ccf3KYEajood2eAGJvZVhBATA==
X-Gm-Gg: AfdE7ckQVY9NCHUVcp07xcnTBPYi5APZe2oBM/DKHoXnMCzmQNy8L/xwc6q4/4nq7hg
 OE2KpbVF+pYlSR5lHFD2TkCHwvvieT94vV9WI97DeqLl+lNbYcXF+dBlbYZLsQY/cE7TLQVNjUa
 Y6j6TP7TXZn3YUf71kZw8NdjoKXHyhs0XaancW3YH6ZMqFow685dXxbTi6206m0XcDXYK7SQXN8
 eXrc2icVuy2C4jpvYyXGHJSvSJFyeJihlb76YkpEbDIc6O8RSCmRbiI3G9mrBwvWi5i1TKooe+X
 a8+FoK8Quo9YIGmxQpe9HDqu4xOBssWeRj+Wyw6aevzwL4s71yKrVdo27Qg86pVU7Iv4LwfC8iW
 atni5F7sZ6YasBB8jINvWSSdfwRLQAcVb7XsyD9AqBzM85ZWzWR0HNoOOi/o=
X-Received: by 2002:a05:7022:61e:b0:138:59d:e1 with SMTP id
 a92af1059eb24-139c3d145c3mr10206849c88.24.1782397027251; 
 Thu, 25 Jun 2026 07:17:07 -0700 (PDT)
X-Received: by 2002:a05:7022:61e:b0:138:59d:e1 with SMTP id
 a92af1059eb24-139c3d145c3mr10206814c88.24.1782397026584; 
 Thu, 25 Jun 2026 07:17:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 14/76] target/hexagon: Add guest, system reg number state
Date: Thu, 25 Jun 2026 07:15:31 -0700
Message-Id: <20260625141633.449487-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: taXm4pZlb37UWlEMF6glGLHEktFDwukt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX6mE2vWiZeBU4
 4wBvJ+hHpapo8pkueX2wH64l4XBXu+f43Lm7SKyhBLX6Jwdcxf2g38FmuMBqP8QyOF7ZWbmzLlk
 9OAtLi1MSCzEHLn2BrnJYAWZ59kFvv0=
X-Proofpoint-GUID: taXm4pZlb37UWlEMF6glGLHEktFDwukt
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3864 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX1adtQxEaO25U
 Ba8wT4zFOCY0v7FwSX2Z8yYQmHwuGWGcxRTODkZmllh6HM1zZiWO9D65wuUUcTVGSMzHl/MvDea
 zO5U3gRdS7QojrY3EWGMt1cK3hsUR48JFvPyrOpEzYNf+FejeEwE/KTJ6CytHY3DJ4ZCCDgo5nU
 j8G7H2ZmGaJhuoL5Q91/IxNhwzFw6v6uiJKj38JyriWRWspiME++o1zEsXISdKuh2VtZHBcAdxV
 LF/1rZmXd8CTzkaI86n2+crY9ixkmgfGhJfVk/+ta/7g1b83mALX8pjUBS8j9bvK0v9W8bctCoz
 6vS4mfI2fWikcw4hquWiT1bMFfy5QFoITG+atdhsjtfG2+8YVRo8xYn/RZUwaDKcWUjsd3NQe1z
 fqUhyJzm83x5EHCr828xkdXo6MK9kBi5Q+rbObPJwd4k7JDU4f2884gwv8ez5aac4+E8ZjVqUb4
 Uq6VWDAHg5cEkK6Wovg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

