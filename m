Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C2CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiC2-0002D5-50; Fri, 19 Jun 2026 19:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC0-0002BC-PF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBy-0001do-UT
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYdkF1287187
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=; b=FyqKh2s0aRdSt1Tq
 DU9Ali2K1nucuvwA4Hj9mtBr1KjuJvRMAcDP7kVV6TVVyyw0U0giJrdtiA5vQiCo
 iLHwJzNP9rH9b6VXR2c+fiOoybBCfoDhBANwNgb2GvDZmN6nanVk/YDA9tSM4lTR
 Rlv3KX8jDmw6K/Wnx+9j2S6JD0UwLz/BlzNLafsupJWlGhTydQqLfGydSwy1sfED
 MDVt/GGD4wztJHzV3Z7Wds4PMtZUkdjkiAe8plMVHSkyr6sr2yMOxZhgz6rOgxr7
 KG/Sw7fyQ1JAqfcq3t5uIj5NmVujIG6pNnvfhmmeBYhFUhBCl1E427Rihoy8XU5v
 M9Q/vg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72k82d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1370417c0bfso1904589c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909995; x=1782514795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=EA2dWGPocDvSbEwxAtLH1J3TAZ/i6s78IXLN5VpWk0N7Mv4iYYm8BXCU34ROFedhSt
 6Zypob580E4NmziJw+T4pEss8jneEVy8BO99tyuu0+TCCcFAaOyIFTL6lh6ffrjvBctd
 rYhyKjqVqmDo5wwur3fmcOzraMOvPcGpOJxIkxRimNqlibomuWUhxt4z0rBnWyvgF366
 +yxo4xU4uK9BqGOSjUaPZFNh6ueQsPDI0iA19I8htjhCRgfrpiD+rC+KSJ3a8cBAqQgw
 wmti/n61F1w1vMgb6Uk5FXeIge+gOrlykibEeORj9xwv96d4PIT++q09+kc0HlUJEpbP
 7O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909995; x=1782514795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=gvsqjkkJkevHbeyH4WDGE6fbl+XelKfvKDxYGi/w9wCGM0smgIYd80xnki6ZpOQtFi
 N0RiJkaGd16SoSkqFlEGca8onpiT+hjJU213dgcd5sfLKCHDRpzlpt0o/zIJQWacCo9T
 iq5JtmdMD4giSTgdmI5KRLMvfoSeYmb6jSc0sZRlSImEj5+sXr/7a/yIBNQsCQJiQ1m6
 Qqu1XJ+R/Er6Mt+MLymicHCuHkkkd0Do98nWBRde/o2JafB2MqrnSGLM6vO8l3MNLyWK
 8op7JJFGqHCOeKUZHBCW206vTYK8tMa4E0fsznmuZU1lH/NOZe1F4lQ3rRGZuNawomAY
 c1VQ==
X-Gm-Message-State: AOJu0Yyc4S8OvZxjsKUEgfmebPWKwzhMECkWUE4dt68kUHWG1kO0d/Xf
 O/6vCsQ4DTpKqMpeRE3ibAJ02IHwVe2Zoaf922YvPIwdXGEHNDg5Nze5v5ZZrIMWSgxdM2M3mJh
 pHHF3G935+3uny2NDK6Lk4EafqBsR6/2ySgtXywmkmqK7c2uPj3J8KwyvsS4qNNECDQ==
X-Gm-Gg: AfdE7cmUZi7qXbmBEHZim0c9nPUdXYRjsSxs6uDl9o/nQgRP9VyX1ixp2C9nKvASQb5
 J+2+5KlnfrBDl49aRDpvBfU0OJ2S5wi8/lP5PoHXTpj45POelUjv6gXSicsj7nZ/xmRUv3yysCi
 xXy3Yk3p0HWPHGPEfb5R5hbNmpYX1pQaWPKoEIlflPO7ZVfkaqfuhoLD7ssWyIAPkiMmqiCeZ08
 XIo+stqjKiMM4cNJml6Gx+65DBdY/lA7NbEfADneuwUh/HxsXGOzgCQb9MRWq8T9xaupV+qE+Ch
 3u5vP0um0zQM0v4CnCUnCkMxfh6i/TDIIx3Qdan6aL37QQjY+YMwrMruqtfeapG9kxbibhBMBXx
 /UU9t3HOvJsH+DqDupnyTIGdsoTGXbQ3AvQFAGiMctgczNBFe7zkN5nL9i1w=
X-Received: by 2002:a05:7022:49d:b0:139:85c2:d7bc with SMTP id
 a92af1059eb24-139a3047c50mr2559252c88.6.1781909994836; 
 Fri, 19 Jun 2026 15:59:54 -0700 (PDT)
X-Received: by 2002:a05:7022:49d:b0:139:85c2:d7bc with SMTP id
 a92af1059eb24-139a3047c50mr2559240c88.6.1781909994297; 
 Fri, 19 Jun 2026 15:59:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 27/74] target/hexagon: Add TCG overrides for rte, nmi
Date: Fri, 19 Jun 2026 15:58:24 -0700
Message-Id: <20260619225911.159473-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX6xI9+1psWjty
 e5LH95FJGKnLyNSSPQRxqiJyBfnrE+/WKmDbG843/nuf2S80LiLEvUgZaOoQbwVPTcdAyXLYbEV
 TFxGP1UwR7jngVAwi625QrB2Prt1Jva8OFcGZyPH0zdAH6lmUbBQtI9azBBZR4M/t3LJXwtdoBM
 GDe4Klvn2+OASOZH3fqyueiNkE8Oz4SOS0SZH8k/3tAAXVpEo9tu/GqM/b0Jjq9me7p3NzknZlq
 HjfEH2NxwUNgRiwAPrz97HeQedFW2bJa5JtO/QEYrfQeaQ0K1h9GpnhBGhvqmfbTkwUsg9xxwxN
 mwY8k8Z9CtfVUD+TJfSqGPtJRibDfskbrGVNFQjGWoCXFuTpDq+CxevBlvCtgzzezjp7J4cRbhU
 dhjoPWQbCCo8P4vSTjScjpKmuB806bMVRYIhr5EeraCBLI+w8DmVoKhZkFEBPE0d0ETNn7jrbq+
 4v65fF1Nb4tlVfV6Ocw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXyiHNQlfcWJyR
 xARGJD4B2jnATt//m9+IVwDp5hoD2RnZXzYmvn+QwzvHO3GTeZj2BpOUX21Y8ZJN48dDSG08qAL
 IGEI/4wBtjttjAJTc+QGA26AeOjsuIg=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35c9eb cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QG2uPxDT_WX1JUO730YA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0JEmp3fU_KRLkf8siI7EdcltektiOp-_
X-Proofpoint-GUID: 0JEmp3fU_KRLkf8siI7EdcltektiOp-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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

