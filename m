Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9737C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39u-00021M-5a; Sun, 28 Jun 2026 23:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39f-0001gE-6I
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39d-0006LW-Ft
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cvFv1494752
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=; b=LnbMyLz74kwb7Vhy
 CFww4cS3a2GImgE3jrVEm7MisBBSGbtqcVDylGHCT3iT6/xVI2DchlXM3RbyMWE5
 fOU/9bOZzEpwdQ1OHEeHva+6iU03S1/K91GisRTah9G9YalLzKC2xKODUXl5r96S
 sQM/ze9usr0T6jm0XvhaT4Mjp7DjraSa2XkhIhzvG58bpnRMcuMy6SHzDOT5yh/P
 9yKLJKW83dK4YCXQ2DBzIQZ4Oo4/H32wXEKlO8PEP3q348mJR7aY1Si+s1IUpI27
 /8kyEcoq8TvapU5p1+lwIvuGwKsxAtJK9IHvm/GP7ih5wh2za+9+nD0jJmZXYZqn
 Q0c6Kg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf47b5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:28 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so12014202c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705567; x=1783310367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=IQA7YmzKK8JiU1RsGI3uUQhEjR5QVfc3IFzCtpLmAarjuFiNytsRsLHUr2uZnDVpfx
 zG7I8oEGHFdkv4O2y/GHaWMg5QkxHAbgF0iP7xfFMlZBNAN21myFFXxV8EjImdrFUBMd
 WyliOFyqwriXGeW+2HYjoMnGnwnv/JTOjox4hbA1GFsxOKt8C0h4XUlYWtJ2cM0rDpxi
 IN+Ws3QTVVmRWBYhEjNwKSk9gGYO1Wh+l5yBli/htjcjveP593V/5NTUuiRJxPuXvIwA
 3Fo8jygs95GgdDKO8rtJ9/hbV0z1isaHT7SqwQwGZDPPDvhBe0ky2pKKBjW39SN5CGnm
 w0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705567; x=1783310367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=LSmtUsvXU/5VdyCivtY/JJ7WMQS10J7vbkkENpczQAwwDlTBDCr7onZG/JzB0ZaNRH
 MmDhOBJQZSLOhCmzBWyw6PaOgwVkruBHWK6qWT/gRy5jhcU4Ymdlb4DpubBeuJMZK0uw
 OqRKzMHDzuN9kLPTDJJ7OVVAIbBfGBdC6u8EprAsS4KmmMnXFUiVin1UH7kniyY813PY
 ce0k04a2F8tcQYtEEyQEtTob18h2tkvPajtWC0/CsBn1HCQiCfcHOjFpamJjsDKDuv7E
 kzzjjODXekC9j6HGstoTMVgpoZPCAG0Tu+gneL90zBQ7ZZFHBIEDPaVCSn+wZ/4Gnuxt
 KnzA==
X-Gm-Message-State: AOJu0YxRcbOS7goLkhlV3DmR17MJJizH+eF8mxKjqHlAV6+oyCsEKFlH
 L47ueCfXQR9eu+HMxOlzb2ZzkkYrnJspz0anJvCBYl+Tn97HDsgd+CCfY/HYHArt/msCBMvQ8G/
 lRhuF5apeM+/S2QozXENTPfmmlHQDglCZhk0oaBQH8+twd6HiP7OP9NhisDfbaJVm+w==
X-Gm-Gg: AfdE7cmqgzfVN2sV7Dxbu6zF1Gmg/c7EiZ9AQhf1KbtXIAMXrl8DlPp8kkxxq8s17kG
 lX8QxpegxDEIsG5QsAiy7oUwgTn99W3lDDrEa+m8Iy8cuLozs8rvUaNPS6zFGBvZJynyy3PnuNF
 P38ypiKSh3+KrQm14JjyCErHh1gz0IkgBHuxJLMeQoTuKcHCy61LaB7be1CcultDOpqKpgMDilQ
 RX2NMNyLHqTLcDfQiUSIjRkReWpOVv13mORq+U1+eK7PkZTxwuNzcFK2f3CoIyA6o+/gY5PSyku
 oSczGpRFMKGhVgPiktTi7Xc11Pa/tbhNn4XJFEwU+kfFNFYCfO4AybECXjnrbaISxB/16nbFlf0
 UWbBH2AF6bLUPL3L01sapjYWdToR/l6ovrXdh2qTcspkx1a/oGUNneEMa2/M=
X-Received: by 2002:a05:7022:ba5:b0:137:fad9:397c with SMTP id
 a92af1059eb24-139dbab9c93mr12646727c88.12.1782705567458; 
 Sun, 28 Jun 2026 20:59:27 -0700 (PDT)
X-Received: by 2002:a05:7022:ba5:b0:137:fad9:397c with SMTP id
 a92af1059eb24-139dbab9c93mr12646713c88.12.1782705566969; 
 Sun, 28 Jun 2026 20:59:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 31/77] target/hexagon: Add TCG overrides for rte, nmi
Date: Sun, 28 Jun 2026 20:57:44 -0700
Message-Id: <20260629035830.1520296-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwvC6fs9YtPv1
 KD0pAe4uchuDr5RyYz9Ut/dV+QQNJZFyZYaI9UvJrRXrwkqVwrhhb8UvRSW4PNsHiSrTrJPnL1v
 v1jRbhCDvpEfxdVMERfslJNMg+rOpUw=
X-Proofpoint-GUID: lfFFIbsjZ3Ksfum-OyAbzbVBn-MWhT0Y
X-Proofpoint-ORIG-GUID: lfFFIbsjZ3Ksfum-OyAbzbVBn-MWhT0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX1q76oNqzbuwa
 15E2FHpqRxjTapc/oyFnuTTAZ1N1N4O+QcJ2IktmHFaIYejFE2Er3XVpolLXyssgDhznzLxraDU
 GPd+5EKMzl12UG5JNJf4EVhk4Vr23/YwPuwPbW/81QLqHf1D3QWI+Qu+uQf3jXREAmGnQ9ufuoT
 ejBhpzKvr0ZiCH4EwGD5qiGE6dlJ/E8VT030XAr+voNw8pWzFt1QA79nHKOVjPVdQcSGjXoNgfH
 4w3zv064h5TT5UYO7/O3pzN3pYW2vSvqoR+YTc8RVDHYCMwuWVleF6GsrpHKXG0M3vCuPHbWrtj
 +AyQxavo4aj7nKIjQUaDzIHbGWFyhBH8MR5JNmFoc18rQTTp8VqLmIf/fvezlkXTnCXRdhdmYNc
 +USpnWX7lMAx5TWTgC+EKmxvKOnXd+mw/me2pB4YMK2LY964Y2BSyh5Yzpf8BGRJtqm3WLpUG0g
 4JxA34DPGxmKcJnquIQ==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41eda0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QG2uPxDT_WX1JUO730YA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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
aAppbmRleCA0ZGU0ZDUzODIzYS4uZThiYmVhZGZkZmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTIz
Niw0ICsyMzYsNyBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAoaGV4YWdvbl90bGJfZ2V0
X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKKy8qIE5NSSByb3V0aW5nIG5v
dCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBub3cgKi8KKyNkZWZpbmUg
ZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKaW5kZXggYzYyMGE1Yjg2MzYuLjJjZDdmNDhlYTJmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ4
MCw2ICsxNDgwLDEyIEBAIHZvaWQgSEVMUEVSKHNldHByaW8pKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB0aHJlYWQsIHVpbnQzMl90IHByaW8pCiAgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKIH0KIAorCit2b2lkIEhFTFBFUihwZW5kaW5nX2ludGVycnVwdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfaW50ZXJydXB0X3Vw
ZGF0ZShlbnYpOworfQogI2VuZGlmCiAKIAotLSAKMi4zNC4xCgo=

