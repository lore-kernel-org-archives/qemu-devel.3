Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5323ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzO-00082p-AR; Thu, 11 Jun 2026 01:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzM-00081K-27
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzK-0000xD-CX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GBG93815511
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3j1pq7Y3MWW6cQeLmhsvKKEhb6nTXwLdgXxb29a2vnc=; b=os8ngVD9OUWvpJrT
 0FTeP8f7r5xBMnOtEy4wvEwlcvelohQNqv+X3+1kV2FqP8SDzGDDUycTBkXnVvJR
 Jry7Nn3f2dtEB3BlbGh1raqReBtiyarCncaGe4dVP9u2njiLJAgQF1XwxRlvvK9b
 LsLQKBuGGl+NpMAsqCGLUD6mGX/k5bomyW6RKmFn/RcbepbhXzXljlF942f4gpdJ
 kGbde6kJXMXyhTZOyAjYqM5GVXJoiElPKObL6jbWoaVJZU6v1GawLXebgQ79muGu
 VfKDmaMtUkiNDK/uXOIC1/0Hlj/ljQqtebpkTv0zw9rwytaVAUacOO2z+GPsQtbw
 fBEXLw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1rrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307fd7138b1so985171eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155786; x=1781760586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j1pq7Y3MWW6cQeLmhsvKKEhb6nTXwLdgXxb29a2vnc=;
 b=A6NpU82k2lV64xlKz9x2U0ITHyW3cK4XTnEUmraWGXy2ZEpdS4nQubBXuBcauukbQT
 pwc8Cg2L43cn5doyeUoxG4CmQHA5orhRCGoZMxJ/1Xa1x/pNSM56Rb34AF3Lw6kty8al
 L6iPcPJnNBgBzcTRT3cohI9KSdsXt2XCQBOAtw4csutP5gAGkQUbJl8n0mqlQXBJ1tDt
 JV31WdMSulzwJrS9Oowy9PvkR/VANywrIWsQhCCKrkqMHjlTogOgeWtwZhPypwbKUn67
 DY25TTHrQMXQRUaxQba+ggacyV3ynPRFgXnyPuVlJffoFuwRkYHpLFBMl2KpezbWRkB0
 suFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155786; x=1781760586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3j1pq7Y3MWW6cQeLmhsvKKEhb6nTXwLdgXxb29a2vnc=;
 b=o0PA7ssubhvVxBwEL6045sJ70DNs4S3L3R2WC6sN1mG5bocQqM+I10z9+tEr79+uVA
 WSbGio6nG4VzjIlwgvy9uvxGuDAXWParlVT7Jv7FfhtTE6r1K2XHsVbSp/WkymIpR4tF
 usXEt3su3We6tTvLs4AR8WWHjx/M5m9ysjqKYwZVwJbhnJg7toM8Kjs6yqx/ehbZ1EJv
 8lu8UkOKjeHkZSRXJjPinlE3O0oG7DrMtO9OH/5v0gqYrkz1LdSAxFktKvaPwt2SzElH
 8oL354bwVG2LNzlVjmBh7d7OM+/+dJyU7BMMoPf4Q3mvsyynsDRxbSME8R3zWud+nXR2
 culQ==
X-Gm-Message-State: AOJu0YwTrEPvb0K+nke7FnN2y/Cm5yLHE8d+Rh2+8EM7hUwV7qOERxLi
 wwD7CZDJ5EbBm9GfGOx5h/446xrXTSnkEAH58solFW3IBxhAK1J4v90Phl6msAkeaQo5f6Z+iaN
 kA2DjStzya90OixDB9Uq4lsBLtPvVqW9IXXQ7FeElVkYH8Rc9ee8W7ASZM2S0ADIUrA==
X-Gm-Gg: Acq92OHxAPEKdLzX9pj/2K3ARfR5OXvnxkzDQeSeKiJW+5H6wE/HfrZ4nsQ5UOjuEV4
 HHpNJA0s2aEUZyYyBz+ggxyUTTjln0cTyAKR3OW04NpeHkCsyckYdE6KRRv/vLN2DcyXhvz32EL
 EtIJ0Drbw0jWIH6IUYTSbgoVQTzFGTMTRMQnx+69mbo1t/JDoOvtVDXp+MsLrLMkluJ9KQgCq9X
 OT5CepmlOZy6QELtUoJkvpSPIy/nlPYsrMlF9pzW2VyhMR5LB0tQ7PFm/TAhiiy5f7tcLOGMniD
 pUwTWAzItbTr1q6jnsj2JBMfcgEyPU/lyHEU6Mp4gpYw5nFV1EkYVQ6j41otOugQ6RHP6/JdyTc
 hLvBsqMeUiPhFjdENintwCWp9Qkdlzd1jfVkJnlX6eJy/EW7hAA09UozJIu0JZzFt4XPDAXfSLi
 g5pC3H
X-Received: by 2002:a05:7300:df44:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-30804b75d7emr1045252eec.33.1781155785937; 
 Wed, 10 Jun 2026 22:29:45 -0700 (PDT)
X-Received: by 2002:a05:7300:df44:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-30804b75d7emr1045213eec.33.1781155785019; 
 Wed, 10 Jun 2026 22:29:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add TCG overrides for rte, nmi
Date: Wed, 10 Jun 2026 22:28:48 -0700
Message-Id: <20260611052857.3911981-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: k7Adq1k73l7plN3MS1S7UNqcAWcSWpXk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX3n7tQgYIPC9x
 kNGpAp22cbIgOkkmCICNG5NihITN8JCoyaE2fFNPn6D76AUbRXrOKLnPXfb3xPW0DeSEAPsUzhM
 /q/Es9tk3lkj5g4SR9keghJQn901m5w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX3tOJ0CQ01kS6
 7QPxKEsXJOzWmLn3SXhiKI53heb6473xWvv5KLRJN7/A5EYial+EXHi+CQYfIFDIsNenc1pzde9
 X021mUyYFYHspy7/XT1nQspR2/nVKARQ/Jhs05vsxVZsuSuP71XEKBAu0X6o9lnM/HV8fQDhsIp
 P9dEf8RfEamWdEujR562sMPAuHVKt1NJQQHFaofnvdAWViL/vt1XgjFMhMGFUztrDO0oWSpDXl2
 HIsRBGQIcfP2NJZGoNNz3k9YO9J2LYfs+n9Lepvo7kMXLXLTB+tkjumwcuVrn9llMBiQLOIUAZj
 A6QGqo1v3Kzw01UG9vtE+yAzqUhP4mczIV9vN+sKbaKpZhboRjN5vNv8Fjlf9y/rFI+ASxOjqiQ
 Wjj702l/dla7hDzm1DZpfJG0PmsHYOd4RwOpefAz3tG0wyynvziiSXFdpQSF7hYxcKy84TRcrDX
 rt4ij7VMil1lO63ZFfg==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a47cb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QG2uPxDT_WX1JUO730YA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: k7Adq1k73l7plN3MS1S7UNqcAWcSWpXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxNiArKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIu
aCAgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggIHwgIDMgKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgIDYgKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5
cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA4NjUwZjY0YTZkNC4uMjY0
ZWEwMjc1MmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaApAQCAtOTUsNCArOTUsMjAgQEAKICAgICAgICAg
Z2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCiAgICAgfSB3aGlsZSAoMCkKIAorLyoKKyAqIHJ0
ZSAocmV0dXJuIGZyb20gZXhjZXB0aW9uKQorICogICAgIENsZWFyIHRoZSBFWCBiaXQgaW4gU1NS
CisgKiAgICAgSnVtcCB0byBFTFIKKyAqLworI2RlZmluZSBmR0VOX1RDR19KMl9ydGUoU0hPUlRD
T0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3ZfaTMyIG5ld19zc3IgPSB0Y2dfdGVtcF9u
ZXdfaTMyKCk7IFwKKyAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKG5ld19zc3IsIGhleF90X3Ny
ZWdbSEVYX1NSRUdfU1NSXSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0
YW50X3RsKDApLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tT
U1JfRVhdLm9mZnNldCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2lu
Zm9bU1NSX0VYXS53aWR0aCk7IFwKKyAgICAgICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgSEVY
X1NSRUdfU1NSLCBuZXdfc3NyKTsgXAorICAgICAgICBnZW5fanVtcHIoY3R4LCBoZXhfdF9zcmVn
W0hFWF9TUkVHX0VMUl0pOyBcCisgICAgfSB3aGlsZSAoMCkKKwogI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4
IDY4MmYwYzZjMjZlLi4wZWMzYTA5OWNiNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyNyw0ICsxMjcsNyBAQCBE
RUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8xKHN0b3AsIHZv
aWQsIGVudikKIERFRl9IRUxQRVJfMih3YWl0LCB2b2lkLCBlbnYsIGkzMikKIERFRl9IRUxQRVJf
MihyZXN1bWUsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHJlc2NoZWQsIHZvaWQsIGVu
dikKK0RFRl9IRUxQRVJfMyhtb2RpZnlfc3NyLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hF
TFBFUl8xKHBlbmRpbmdfaW50ZXJydXB0LCB2b2lkLCBlbnYpCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3Mu
aAppbmRleCBmNDk3ZDU1YmI4MS4uMDlkNzhiMDAyZTYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTIz
NCw0ICsyMzQsNyBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAoaGV4YWdvbl90bGJfZ2V0
X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKKy8qIE5NSSByb3V0aW5nIG5v
dCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBub3cgKi8KKyNkZWZpbmUg
ZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKaW5kZXggZGEwMGRmZDY1YzMuLjgyZDAxNjE5NmRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ3
OSw2ICsxNDc5LDEyIEBAIHZvaWQgSEVMUEVSKHNldHByaW8pKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB0aHJlYWQsIHVpbnQzMl90IHByaW8pCiAgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKIH0KIAorCit2b2lkIEhFTFBFUihwZW5kaW5nX2ludGVycnVwdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfaW50ZXJydXB0X3Vw
ZGF0ZShlbnYpOworfQogI2VuZGlmCiAKIAotLSAKMi4zNC4xCgo=

