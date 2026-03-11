Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F210BFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsK-0000sO-7N; Wed, 11 Mar 2026 00:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As9-0000oO-RR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As8-00004s-6A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3T2Lc248937
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hn1uuV0u3zdovXdnF0cgPTU9OgrIWILHugDCx9Chq2Y=; b=Gh+M5p1rVtyFW012
 TeNkyIBaI+l+/3Tnghj/dXKZMCKtGRFq28zekgUh/guse1uKBVI90Xn/mt7KSUrH
 Ff0LaV88TCVE0ogCtvvfztzRS8lhoRDG7dK+DGZBm7Kfgmgb0zw4AQupUX7j3tbe
 yTNqwHyN8nkQ4aG4PPnNxJ/e+YwmgbxNEvrR/0A/YJl6DejT7Qhez+i06YdZ20qr
 HskqGi9IyVZ6J3AVGCzqmamkfnQ68/27GiQExjC+MMCE5/jcSUrSiRRZgBYrJ6GS
 XAIQaKZi8Q0iXI8vVt3WI8Jt0Scid4M8jEuUr4vXJ//xR6VsvuM8YangABvJ3L0B
 X4FjyQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11swm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:35 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-417393f319fso19128721fac.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202114; x=1773806914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn1uuV0u3zdovXdnF0cgPTU9OgrIWILHugDCx9Chq2Y=;
 b=JfQanwh8oKayoYzEeFubdLTGCloJBVTTb5ZhR/QGQ3LkCYb0NvA+iKnu2/uSXFIMUV
 ROYyWqoH4WirhjqZfpQnQuL8JbvW7Ca42yU6McTI5QI4pSeO75gFeBT/7viheVwDcWcR
 3fwgtku1n5WVM7KbOxIPrqjizoyfATJEnOKQ78DWnqnrASsP//nB8i+2OfFNoIqjCrTw
 A4s6CR2+JhOFYr7gxISCVoTYYkKyMJueZObaAzJZKN3i/fS6n55ar3/NHadl1cgVpbb8
 Seui9vddQbOTQ7mGeR3bC3hoA11nd4vrumzprTJZfUtrn8yx78ljbO45xppoJsQrObKX
 YHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202114; x=1773806914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hn1uuV0u3zdovXdnF0cgPTU9OgrIWILHugDCx9Chq2Y=;
 b=ZGSbaA2j5bj+/9yK5MjewEyd6vqLpWkMCq270x0oNnij7+CdzjQ+KXS2eXXdX9Y4zJ
 g2aZ0WDdwLFHX9YFZnoo+HjTBPijVUexV9+6dux5LLoKyTNeR4vlMIuu1lQL1cJI4x87
 KaX4E1r/NUaXfJk+71o0T1WIvAypbQRJx3050AqI+Z3fDD7UhSwNBjWISfxa3E3qmXui
 +13zEjFnxE6erJNDDpddF/HepwguiPuOkM4FvaBS7aimGaBxmEnnljPww+rVWzCUDTNl
 4vnA3v1rfMTAtwBK4YfWPte1nfP7zE6oXmyP5eAA0ZS2j33C4i6Ap6Ds7Ymd8fvY3Cn6
 cI0A==
X-Gm-Message-State: AOJu0Yz1BG/sXKydsSdzs+3hJymDjnBVLVRbnK9J95c0fshW5xs8+i1c
 O6O2VSNH/rynAeGtLXmjEd5vvLfT8URTJdnU9HnyMEck27NKryfV3hu6wm8XGrexiuzFNhTHdZm
 NauexSXav25GCkFb/6VNpRZQxjKUU1Y80EI8vQlDxyQNE0aUe+uPa73IcoVN2wtxftA==
X-Gm-Gg: ATEYQzxslnrzJmw3VyrFzrNOO7FR5jTHTXSBz/BxG9xYz4T2Tk0O75ZvcVYBJudQ731
 zw4oJTEnHweQBcuWxmENccRynCcAM4h56NDfu7M3osGu3CT9w/PJCI3OVOjSJaA5XPBco7dc/rq
 cw8ahVu9cUcE7R4dMd9eVOd9cRJezW/wdlyjiBiiGAVJh7HpeXmveI9f95YE1w5UDVVzQ00Rfhi
 YPdtvUxmX3RSkaLUAg3djRDKzCc0p0Rzh+4nph2ilykvwTc06vRYPdhUBFoL6fBBJcTtYTLu0rY
 D9mO8MYS8gTcriMgBLs93AETomakFcXA8AKqb0jPQ00hRBKl/OqlLrNkc62QwEbTPJxfUnrSNLt
 KeCOS4z9mBMr8aAQ333HHUSv+YGUA4ZhkZ+omcOqkN/l1EGBxrjil9A5/6RmcPxIhYL1aJQ==
X-Received: by 2002:a05:6870:a90c:b0:3ec:57f7:fa5a with SMTP id
 586e51a60fabf-4177ccd9f72mr764796fac.50.1773202114331; 
 Tue, 10 Mar 2026 21:08:34 -0700 (PDT)
X-Received: by 2002:a05:6870:a90c:b0:3ec:57f7:fa5a with SMTP id
 586e51a60fabf-4177ccd9f72mr764788fac.50.1773202113995; 
 Tue, 10 Mar 2026 21:08:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 20/32] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Tue, 10 Mar 2026 21:07:46 -0700
Message-Id: <20260311040758.1068731-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXw3Y6jSJyKywb
 fOjNfgsdfZADe3CHe0eJPCI2/zKgUVcLppbZDfWXFCDeYqFcO9Yev4dVohOeaY+S7EWSErH/fVe
 Wzi4YZT4/bw2k0NDnFMRbJxEQ6tRPSk4jl4Z1S/6StbyQh63VTXo5Tcn8llkdobEmOhm62zMjIU
 4vMfiZC8MsVpf94UrnuxgfEKS5z993BT5pvozy3URYYfUZ4ggeD2/steO9+YBtzldfpdoFwOSef
 CXWrA9eDSUPqD+6lq30xJb/fYwIY3yXgueTeE2lUZzTqgE/yeqARvKJffQcnr2jAxyK/7Gs2HtF
 CQovtvk2oVcfTEr+cA4fN5WzmVTy33jyGCBSbGLj0XWJ9stjn166s2zF2qjk8hB6MqYorGV/evw
 V/KE0w4w6f+aIdiXsuRtB3jd3QqjX9EujjALH3dRAK6+DHdFbGr/ryMpdwolq2cKcbVWQH2Jqge
 fL2c4mctu5xIJVZ4qYA==
X-Proofpoint-GUID: AA9xzcvAEqiIdIyPgVgsaJd8V11CZPMq
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0eac3 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=kXroxUfw0iMe_INEunMA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AA9xzcvAEqiIdIyPgVgsaJd8V11CZPMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICB8IDIyICsrKysr
KysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCBkYzk5YjRjMjk0Yi4uN2Q3Y2Y1OGFjYzggMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9jcHVfaGVscGVyLmgKQEAgLTE1LDYgKzE1LDcgQEAgdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5
Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50NjRfdCk7CiB2b2lkIGhleGFnb25f
c2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCk7
CiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUg
KmVudiwgdWludDMyX3QpOwogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKTsKK2ludCBnZXRfY3B1X21vZGUoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogaW50IGdldF9leGVfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVu
dik7CiB2b2lkIGNsZWFyX3dhaXRfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiB2b2lkIGhl
eGFnb25fc3NyX3NldF9jYXVzZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgY2F1c2Up
OwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUu
YwppbmRleCA2ODQ5ZGM3OTY2Yi4uY2VjMDZkYWVkNzMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC00NDksNiArNDQ5LDI4IEBA
IHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3Ig
KiplcnJwKQogCiBzdGF0aWMgaW50IGhleGFnb25fY3B1X21tdV9pbmRleChDUFVTdGF0ZSAqY3Ms
IGJvb2wgaWZldGNoKQogeworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgQlFMX0xPQ0tf
R1VBUkQoKTsKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworICAgIEhl
eGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICBpZiAoY3B1LT5nbG9iYWxyZWdz
KSB7CisgICAgICAgIHVpbnQzMl90IHN5c2NmZyA9CisgICAgICAgICAgICBoZXhhZ29uX2dsb2Jh
bHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfU1lTQ0ZHLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgdWludDhfdCBt
bXVlbiA9IEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX01NVUVOLCBzeXNjZmcpOworICAgICAgICBp
ZiAoIW1tdWVuKSB7CisgICAgICAgICAgICByZXR1cm4gTU1VX0tFUk5FTF9JRFg7CisgICAgICAg
IH0KKyAgICB9CisKKyAgICBpbnQgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBp
ZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1N
VV9LRVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dV
RVNUKSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAg
ICAgcmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGRjYjA3Mjgz
NDk0Li4wNTIxYzAxYzg0YyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMzAyLDMgKzMwMiw0NyBAQCB2
b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAg
ICBTSFVURE9XTl9DQVVTRV9HVUVTVF9TSFVURE9XTiwgZ2V0X3RocmVhZDBfcjIoKSk7CiAgICAg
fQogfQorCitzdGF0aWMgaW50IHN5c19pbl9tb25pdG9yX21vZGVfc3NyKHVpbnQzMl90IHNzcikK
K3sKKyAgICBpZiAoKEdFVF9TU1JfRklFTEQoU1NSX0VYLCBzc3IpICE9IDApIHx8CisgICAgICAg
ICgoR0VUX1NTUl9GSUVMRChTU1JfRVgsIHNzcikgPT0gMCkgJiYKKyAgICAgICAgIChHRVRfU1NS
X0ZJRUxEKFNTUl9VTSwgc3NyKSA9PSAwKSkpIHsKKyAgICAgICAgcmV0dXJuIDE7CisgICAgfQor
ICAgIHJldHVybiAwOworfQorCitzdGF0aWMgaW50IHN5c19pbl9ndWVzdF9tb2RlX3Nzcih1aW50
MzJfdCBzc3IpCit7CisgICAgaWYgKChHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgc3NyKSA9PSAwKSAm
JgorICAgICAgICAoR0VUX1NTUl9GSUVMRChTU1JfVU0sIHNzcikgIT0gMCkgJiYKKyAgICAgICAg
KEdFVF9TU1JfRklFTEQoU1NSX0dNLCBzc3IpICE9IDApKSB7CisgICAgICAgIHJldHVybiAxOwor
ICAgIH0KKyAgICByZXR1cm4gMDsKK30KKworc3RhdGljIGludCBzeXNfaW5fdXNlcl9tb2RlX3Nz
cih1aW50MzJfdCBzc3IpCit7CisgICAgaWYgKChHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgc3NyKSA9
PSAwKSAmJgorICAgICAgICAoR0VUX1NTUl9GSUVMRChTU1JfVU0sIHNzcikgIT0gMCkgJiYKKyAg
ICAgICAgKEdFVF9TU1JfRklFTEQoU1NSX0dNLCBzc3IpID09IDApKSB7CisgICAgICAgIHJldHVy
biAxOworICAgIH0KKyAgICByZXR1cm4gMDsKK30KKworaW50IGdldF9jcHVfbW9kZShDUFVIZXhh
Z29uU3RhdGUgKmVudikKK3sKKyAgICB1aW50MzJfdCBzc3IgPSBlbnYtPnRfc3JlZ1tIRVhfU1JF
R19TU1JdOworCisgICAgaWYgKHN5c19pbl9tb25pdG9yX21vZGVfc3NyKHNzcikpIHsKKyAgICAg
ICAgcmV0dXJuIEhFWF9DUFVfTU9ERV9NT05JVE9SOworICAgIH0gZWxzZSBpZiAoc3lzX2luX2d1
ZXN0X21vZGVfc3NyKHNzcikpIHsKKyAgICAgICAgcmV0dXJuIEhFWF9DUFVfTU9ERV9HVUVTVDsK
KyAgICB9IGVsc2UgaWYgKHN5c19pbl91c2VyX21vZGVfc3NyKHNzcikpIHsKKyAgICAgICAgcmV0
dXJuIEhFWF9DUFVfTU9ERV9VU0VSOworICAgIH0KKyAgICByZXR1cm4gSEVYX0NQVV9NT0RFX01P
TklUT1I7Cit9Ci0tIAoyLjM0LjEKCg==

