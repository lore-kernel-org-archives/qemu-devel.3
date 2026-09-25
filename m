Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D60AC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9J-0004vg-Vz; Thu, 24 Sep 2026 21:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v97-0004uM-68
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v94-0005rR-IH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kwIa313743
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FHgUE9UHf52eWjVI7SnuPy7sb5+fR7pXWNcnfZ/V5/0=; b=l1p3ODHO0iTkUlKG
 6F5ByEqMYNys3+oc8Q3VUwPmd4lhr1dUWsFAPD+7Nv+9IXyMq7ovn6TfSGDLVrBQ
 JbP4x0n1l0mBpT2lURFaqfkwYTxdFjIVkjyJth1lYGn57XyW4mQ+EtZ8+t3m7okk
 6JCXhuF07oPxbOI88AW4KNKf5ARZZlIwgbpfvPOkClrallEGrkAqEJsahgdOkOas
 TCvzGwuJi2I1ge4RhBz1ACM78QsH9HQVbcGLaemGbfA6LSkYI7MUa0z2BzGnN/yF
 ZyIpPVrwzg8uG1OzQTk3uhjzJRLaLtu3s9jch23gFFemaxViM5ULSrfCtxY8EwqG
 Fl4vPA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s93d78-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1392100eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301276; x=1790906076; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FHgUE9UHf52eWjVI7SnuPy7sb5+fR7pXWNcnfZ/V5/0=;
 b=juqHHIr5WAnMg3xub3rHkCqPv2EcNvBtnKRUtKth7wGwdTUxW2HCZ5Rsm4BuWNkIRq
 q1xfZf/a2FP0a7JbNMcwJSnBDfTPVbLmIgfkPIw2C9yD8JNLlBAJqDhbaTufWbdjN0/Y
 K0xoC3CCZF34QOG7fLTwdII/O0zueW2vm3KdgNMX6cRQ9ySGilTAvvGZ0MFay9QYJteD
 DOGCCiO4+dAwqVw0SMdudBO+hJ7MCwm95knIZpn2G83OsHp6rpA1siimGQFOQGDQBlE4
 OuBQEUEUYsgul3cWl01Pq8Um/4it6wJ/qhgsmxnKQtkSqqCPTzJuXbdE12+Pde4T7104
 MvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301276; x=1790906076;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FHgUE9UHf52eWjVI7SnuPy7sb5+fR7pXWNcnfZ/V5/0=;
 b=aZKtAyD7Aivmz0Fw1l18Fq1zePVeLRNwH6OBRLRAvUec5iAOThOE228BL4tw7Gg0++
 Jk8R6gZr0Zgo0DNmcG1bAh40lPHe1XW+YPaPA99GNvuBgYwliqSawdVFSr2IcJnIIkCz
 xT7XnQoXX0RhCOLpuQ/8ZPge9PgtsmmUAz0Lqnwxk+X4rhEBFTF46BUJwPHyO72X/F0s
 WTG4UGYWuFhHBFZ9WWdGqlwI+w5F6IAzMkUSR91ES/GhfidtxxBuCru3IKjFY7RZl8Xk
 25W9E0yhVblE98A29cMIFRR5btqJD+Nd3exrUHHWzTnpjsSTYhmYyYndiczkXOvBBL9j
 NSsw==
X-Gm-Message-State: AFuF++nUD4A2Wa2AJ3HNTDSI+89ymlcuZMC5xnv5aYjCIwAZd/fVDcDs
 AYas6fEIcI3Qj+3oBFjUpRM+l0AJwM2zwZLIYU+3RcBRqX8m88guX/0Jcj3L8iJlbBU2Mp+XEeZ
 jvjaA56TTRCjK7F/nwgdmJKFvrSR6mconS5PDTrj+A9my9lUvOjAnEvh0pR/v++9R+Q==
X-Gm-Gg: AYBFou3Sxk463Di3QfzoFfyE0V0qq6gzO3Y2APm+ZvHToDK1oP4UaZ0mStbfUWbCk6N
 6pJ18D0Gyt+Gih92fIzefmTIux+qkvZjhzb9cr0aAo9o8iHBr6sHJLm2/NwzRVMjryw0yyyseN/
 2HGA8vJxepEdP/f7pR6G0YMub5Str+IlD4Q+UkPSk7aXHgiZZcWElhpqJVNGJ9v7gvjt9SNEJ02
 YOhT+0OWe0FG+wxN9w4ZbhHA/mC9WC4VDeDUfVOKfSBpwOnm1mo5CmCTjZFxE9rlQ/iprSFOUnw
 UdTgB0NSU0JMYtmLKb8Yg5jT0ke/yjZUjnG95HNGvGAfl1ZFJVaAPTedWs5L83V+5ktKSGvmJEC
 pkrq+7daf/OOzsWH+GZf1uBV2fsGSNpkScibB1HdMehnVqL0=
X-Received: by 2002:a05:7300:cf90:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-34001f081bcmr3363999eec.15.1790301276180; 
 Thu, 24 Sep 2026 18:54:36 -0700 (PDT)
X-Received: by 2002:a05:7300:cf90:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-34001f081bcmr3363978eec.15.1790301275514; 
 Thu, 24 Sep 2026 18:54:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/40] Hexagon (target/hexagon) Check for GPR multiwrite in
 analyze_packet
Date: Thu, 24 Sep 2026 18:53:51 -0700
Message-Id: <20260925015429.2579174-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX2X82rwVO3XfM
 E5goR04L6oGYE+7dcQyV9ydxHtPEl38PwoU89CiQKDFZ631idJvwVIDrUm/beO3RCNuYFe+syDD
 NRcxjhsMwnp2lZHDtwjRbGfA+ldjrmF1p8EAuhHqNerrPM+eWMWhQ3+9+JJxG0Nnr3kIWUw9hPD
 Dye+6+23Jl4IG3UsjH1HsWxvITVtCS/awABKB90b8+3L98xQf+mxIlhrNIM4RrgV0fWokXMwTNy
 /1yPZxaIVUVXU9ush7ad34pskl9ugavSYKoVqosHLHMJKIa1hzUFzoOigE1/HyN+7eoqzZjZYbU
 HUveb9oKvy1SzsqXTP/acX/p8xn4fDNxpv1hzSYObIxMwzS/NcfS1nN73Z3aKdh/kkILvzb3JKl
 7xNWPW6O0N5OY71Y1dBFQJqEOhi1XX1RJGgZ2WPTT5DJBkW3F6aSw/otrn7KJX0cbCQZ+jC2TJC
 wSBMauYdm8ykIfv569g==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5d45d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rweD1h4czDRuSoyrQo4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXwBdxWYRovJDT
 8ZLH/dMKpPSacwdvnj7eg+4B61TZwPkp2XMBSqZBz5s+QW3hJ0Rhhaw0D+droYW8TBML7PdqAG1
 K9/WzWW9X5QzAeD0gi3vugzwwVKOzfk=
X-Proofpoint-ORIG-GUID: 4tNVOD9pFBa983dNWtHE_Sc-2Hbbltsc
X-Proofpoint-GUID: 4tNVOD9pFBa983dNWtHE_Sc-2Hbbltsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkZvciBub3cs
IGFzc2VydCB0aGUgbmV3IG1ldGhvZCBpcyBhIHN1cGVyc2V0IG9mIHRoZSBvbGQgbWV0aG9kCldl
J2xsIHJlbW92ZSB0aGUgb2xkIG1ldGhvZCBpbiBhIHN1YnNlcXVlbnQgcGF0Y2gKClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmggfCAgNiArKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZDg2MjgzODNmMWQu
Ljk2NGU2Y2UwYjc4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDEsNiArNDEsOCBAQCB0eXBlZGVmIHN0
cnVjdCBEaXNhc0NvbnRleHQgewogICAgIERFQ0xBUkVfQklUTUFQKHJlZ3Nfd3JpdHRlbiwgVE9U
QUxfUEVSX1RIUkVBRF9SRUdTKTsKICAgICBERUNMQVJFX0JJVE1BUChwcmVkaWNhdGVkX3JlZ3Ms
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYm9vbCBwa3RfZW5kc190YjsKKyAgICBERUNM
QVJFX0JJVE1BUChncHJfbXVsdGlfd3JpdGUsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAg
REVDTEFSRV9CSVRNQVAoZ3ByX3VuY29uZCwgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKTsKICAgICBi
b29sIGltcGxpY2l0X3Vzcl93cml0ZTsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGlu
dCBncmVnX2xvZ1tHUkVHX1dSSVRFU19NQVhdOwpAQCAtMTU3LDkgKzE1OSwxMyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgY3R4X2xvZ19yZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVt
LAogICAgICAgICAgICAgY3R4LT5yZWdfbG9nW2N0eC0+cmVnX2xvZ19pZHhdID0gcm51bTsKICAg
ICAgICAgICAgIGN0eC0+cmVnX2xvZ19pZHgrKzsKICAgICAgICAgICAgIHNldF9iaXQocm51bSwg
Y3R4LT5yZWdzX3dyaXR0ZW4pOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgc2V0X2Jp
dChybnVtLCBjdHgtPmdwcl9tdWx0aV93cml0ZSk7CiAgICAgICAgIH0KICAgICAgICAgaWYgKGlz
X3ByZWRpY2F0ZWQpIHsKICAgICAgICAgICAgIHNldF9iaXQocm51bSwgY3R4LT5wcmVkaWNhdGVk
X3JlZ3MpOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgc2V0X2JpdChybnVtLCBjdHgt
Pmdwcl91bmNvbmQpOwogICAgICAgICB9CiAgICAgfQogfQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCAyOWUw
MmQ4Y2M5ZS4uMGE3MjI0YThlMGYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC01NzksNiArNTc5LDggQEAg
c3RhdGljIHZvaWQgY2xlYXJfcGt0X2N0eChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBjdHgtPmdy
ZWdfbG9nX2lkeCA9IDA7CiAgICAgY3R4LT5zcmVnX2xvZ19pZHggPSAwOwogI2VuZGlmCisgICAg
Yml0bWFwX3plcm8oY3R4LT5ncHJfbXVsdGlfd3JpdGUsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7
CisgICAgYml0bWFwX3plcm8oY3R4LT5ncHJfdW5jb25kLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1Mp
OwogICAgIGN0eC0+cHJlZ19sb2dfaWR4ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPnByZWdz
X3dyaXR0ZW4sIE5VTV9QUkVHUyk7CiAgICAgY3R4LT5mdXR1cmVfdnJlZ3NfaWR4ID0gMDsKQEAg
LTYwNSw2ICs2MDcsMTkgQEAgc3RhdGljIHZvaWQgY2xlYXJfcGt0X2N0eChEaXNhc0NvbnRleHQg
KmN0eCkKICAgICB9CiB9CiAKK3N0YXRpYyBib29sIHBrdF9oYXNfd3JpdGVfY29uZmxpY3QoRGlz
YXNDb250ZXh0ICpjdHgpCit7CisgICAgREVDTEFSRV9CSVRNQVAoZ3ByX2NvbmZsaWN0LCBUT1RB
TF9QRVJfVEhSRUFEX1JFR1MpOworCisgICAgYml0bWFwX2FuZChncHJfY29uZmxpY3QsIGN0eC0+
Z3ByX211bHRpX3dyaXRlLCBjdHgtPmdwcl91bmNvbmQsCisgICAgICAgICAgICAgICBUT1RBTF9Q
RVJfVEhSRUFEX1JFR1MpOworICAgIGlmICghYml0bWFwX2VtcHR5KGdwcl9jb25mbGljdCwgVE9U
QUxfUEVSX1RIUkVBRF9SRUdTKSkgeworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisKKyAg
ICByZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyB2b2lkIGFuYWx5emVfcGFja2V0KERpc2FzQ29u
dGV4dCAqY3R4KQogewogICAgIGN0eC0+cmVhZF9hZnRlcl93cml0ZSA9IGZhbHNlOwpAQCAtMTIx
MCw3ICsxMjI1LDEzIEBAIHN0YXRpYyB2b2lkIGRlY29kZV9hbmRfdHJhbnNsYXRlX3BhY2tldChD
UFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIGNsZWFyX3Br
dF9jdHgoY3R4KTsKICAgICAgICAgYW5hbHl6ZV9wYWNrZXQoY3R4KTsKIAotICAgICAgICBpZiAo
Y3R4LT5wa3QucGt0X2hhc193cml0ZV9jb25mbGljdCkgeworICAgICAgICAvKgorICAgICAgICAg
KiBDaGVjayB0aGF0IHRoZSBuZXcgbWV0aG9kIGlzIGEgc3VwZXJzZXQgb2YgdGhlIG9sZCBtZXRo
b25kCisgICAgICAgICAqIFJlbW92ZSBpbiBhIGxhdGVyIHBhdGNoCisgICAgICAgICAqLworICAg
ICAgICBnX2Fzc2VydCghY3R4LT5wa3QucGt0X2hhc193cml0ZV9jb25mbGljdCB8fAorICAgICAg
ICAgICAgICAgICBwa3RfaGFzX3dyaXRlX2NvbmZsaWN0KGN0eCkpOworICAgICAgICBpZiAocGt0
X2hhc193cml0ZV9jb25mbGljdChjdHgpKSB7CiAgICAgICAgICAgICBnZW5fZXhjZXB0aW9uX2Rl
Y29kZV9mYWlsKGN0eCwgd29yZHNfcmVhZCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgSEVYX0NBVVNFX1JFR19XUklURV9DT05GTElDVCk7CiAgICAgICAgICAgICByZXR1
cm47Ci0tIAoyLjM0LjEKCg==

