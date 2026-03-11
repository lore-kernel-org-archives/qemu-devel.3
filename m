Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CACAFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsL-0000tl-8s; Wed, 11 Mar 2026 00:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsI-0000s0-NO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsH-000070-2Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3Ewii248694
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O+dN2kXGoqOjKdDS99ZaXiN2+W4RtMQds+MjbkmGJ74=; b=CBuqDjKwp9Ym5VG9
 LAgXBS7dPftF4r1UrpcAnGZRMoAyivyzXfSjPpncrTW6a+YXKSLoFYFkW02CU/Pb
 QDOJxp6PfKJyT4f4Mo38GsrwdlbhpX1gdk4tfiMZ9rx6uMohOecg8ADS+76YELwR
 rWAwf6L+y8wNh8ThW42oUjeB+grVvjEWD+Xy1lfzjWKTFEMK8kAf+KxSpIx1UfiQ
 h8eZEhDiZ95Mv7bXzMeocS/O9vcHAI2otWWZMfYg48kyZK8Bxskn6B1mSXQj4C2D
 8+nOdiOP8Asq4xYzZEb+/LgmStuj0IR7qqLFiJlPRGq6UY3csdaH0UhTiQnn2rQz
 3wrX8g==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11swx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:44 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-466fca9c6ebso26154691b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202123; x=1773806923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+dN2kXGoqOjKdDS99ZaXiN2+W4RtMQds+MjbkmGJ74=;
 b=hKb5FB8X1cODQ0fAMJKWi0JbSwB9LQkWtkKclM0AyoXk9K+5i+9Q97mhzs5fQmBhg7
 yISdj2YFAuS4mLGr4gASCfeUaQRZlyWR/KyBaG6W/Xbequ7l6F7BlNwimjuZDsxtOa6r
 0CrBgqk731JDlxdE6B87Ou/1WRHrhs4WMtqHg2L4dsu0pT4jCvF90C7BtwZnRSdQtz/Q
 SgE1+wZiVF75/bnEoRsI93UXeZS6PcAP5sekYNamX+3P70H02v29EpGNKaeY/1mw2/B2
 Nx4lEsD0t3p0bL50diFSTnCEj0eZZUN1XkwAheUVCsyCmi2+68x/bL8cOxa8YHyUY92N
 A8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202123; x=1773806923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+dN2kXGoqOjKdDS99ZaXiN2+W4RtMQds+MjbkmGJ74=;
 b=avZFcby9LNZrLL83n7xC1h66YsIeNl8qgPCdIiaan29p+xBVAATrMvJDq2QNEBCJCp
 nQwTbom855VtgT+uLYwnHGI9ImLdPV4exNfn33IpU46dhi3Wxk/pTxbH3sbRrbyAr8ys
 ZTPS3GNOv1g6YlJjUDNYs1sWPjSmdLIBKqKnV+brTIM90meBtHycY2g9cyjwBDR8kRD3
 6vxQR7rO5Zbb/x0QoLL9DszaLUuM4LU72fL1pC9W4J3nR+SDMCDYT1T1R2Q7HWGTw4gw
 lBqkVC4uCqOBQJpUv3ByBqveynnNJsGhVEcB/RWq43swkA3b7V2W0hN0VNNWfbvjgUFu
 9tcg==
X-Gm-Message-State: AOJu0Yy3137MqA8bzKTdiiLDt+iJ6lrKGI9XaQK1AKheDuZHTYLoaT9D
 x19+baiFDBYDsz5pwwUA4kj3fkqZNQjqvPNLzEBndKdMh8nGI9AUH+lEmpLDW7FNtLwKl+gWaEV
 KyObLw4ewh9cuJOaR23Ez9e57jXPXU9ONzKNPwaAONd3sNOVpthFBWiFCu03RxGhB8g==
X-Gm-Gg: ATEYQzybXVn1DQnH7IkV4gaVZDs1EFRV91VUcfikBeDPU8Ckqy6HRQ5fwcmfSewQp66
 NrNgTtbLk27kUaXyXvSP0EbnIwECxJyHQzf8cqIkNHmja1SSbrHrySeEsQdUd517koGzOzPpVE9
 8JHWpJTDHtoUuWQ4d7/afwTdSUujxYqykyuj4YjkEfiHB7FiEmT6MDvr7G+BoHs2RFMhGLqpGHr
 cCkZz/khM45Ddg0pxmqTuI7KobQR9Wim+CGZ7cFVmPU5OcGjoSVsw4vzUkZV+3MIWmhgU2J0Qxo
 ptEV1IEOU3vRyBNaA4MKN+jgxezXsb3kBxZj09g8uPvnyZja81bxvoBBmbS4CKGJ2/b2vw4h7I1
 qohp5QdsnpV38MQPIrHn+6Y1+qUs04QgU9lseFRWznHbPt1ntbh2cTJR0FCprysMJmxAA1Q==
X-Received: by 2002:a05:6808:1815:b0:45e:dbf9:61c7 with SMTP id
 5614622812f47-467335b64c5mr875816b6e.46.1773202123348; 
 Tue, 10 Mar 2026 21:08:43 -0700 (PDT)
X-Received: by 2002:a05:6808:1815:b0:45e:dbf9:61c7 with SMTP id
 5614622812f47-467335b64c5mr875804b6e.46.1773202122931; 
 Tue, 10 Mar 2026 21:08:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 27/32] target/hexagon: Add TLB, k0 {un,}lock
Date: Tue, 10 Mar 2026 21:07:53 -0700
Message-Id: <20260311040758.1068731-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX0RpdmOHGkhCp
 Y0uhWEhgIf/f0GbdwPXYtxMCVxGJgX9Mw97FJHQrwSwjEY9UhNT308+1YpcJpPA2fEvLVWLnh5l
 WI+DX4eu2VTt6ZJX34Gays2i3MpxS95Yk1eZ4K9vLfuhJaasovjOVTdV2DUVprHhWD+n7IBJWnZ
 yhvM6yAO+5sSkX6Itx3IHX4faI0jBVXLorAAbSWcqw+4JvgLHCPwPjHUVS2QDIZqCqZMKViZsgS
 o3PyVY5UEncpE5875DVHb97FLP2kn7uwUg5YH7sfLiaxLfEzXSBaRg/ZQinELSNZolyxWAtGnko
 qxIJopcc0lkAHBaM/lhEYW4rspdGFdoCWllzXisPDfw7K3zTo8xgy1mPhMlIPWkY3oV4YXAGUtY
 sB+rODC4sqX3WENo4TGmqx5XRgW04u9n3oJLCtRFxSQk1Gp+vp/eztW7UTbXkpaW5Y3G/Lheq3x
 boMVknHCgI7cSt01tUQ==
X-Proofpoint-GUID: RCo4sQYzzORK1RoJAoBcobwUcOwveq2w
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0eacc cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5qM_0fsqfvQKBOMFAjMA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: RCo4sQYzzORK1RoJAoBcobwUcOwveq2w
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
c3lzX21hY3Jvcy5oIHwgICAzICsKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICB8IDExNyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTIw
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgg
Yi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKaW5kZXggY2JjODU3ZmEyZjUuLjM3YWFlNzFh
ZGNlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKKysrIGIvdGFyZ2V0
L2hleGFnb24vc3lzX21hY3Jvcy5oCkBAIC0xNDYsNiArMTQ2LDkgQEAKICNkZWZpbmUgZlNFVF9U
TEJfTE9DSygpICAgICAgIGhleF90bGJfbG9jayhlbnYpOwogI2RlZmluZSBmQ0xFQVJfVExCX0xP
Q0soKSAgICAgaGV4X3RsYl91bmxvY2soZW52KTsKIAorI2RlZmluZSBmU0VUX0swX0xPQ0soKSAg
ICAgICAgaGV4X2swX2xvY2soZW52KTsKKyNkZWZpbmUgZkNMRUFSX0swX0xPQ0soKSAgICAgIGhl
eF9rMF91bmxvY2soZW52KTsKKwogI2RlZmluZSBmVExCX0lEWE1BU0soSU5ERVgpIFwKICAgICAo
KElOREVYKSAmIChmUE9XMl9ST1VORFVQKCBcCiAgICAgICAgIGZDQVNUNHUoaGV4YWdvbl90bGJf
Z2V0X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpKSAtIDEpKQpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YwppbmRleCAxYWRlNjZkZjlkNC4uODk3MTJiZjhlMDkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0zNiw2
ICszNiw5IEBACiAjaW5jbHVkZSAiY3B1X2hlbHBlci5oIgogI2luY2x1ZGUgInRyYW5zbGF0ZS5o
IgogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5oIgorI2luY2x1ZGUgImhleF9tbXUuaCIKKyNpbmNsdWRlICJody9oZXhhZ29u
L2hleGFnb25fdGxiLmgiCiAjaW5jbHVkZSAiaGV4X2ludGVycnVwdHMuaCIKICNpbmNsdWRlICJo
ZXhzd2kuaCIKICNlbmRpZgpAQCAtMTIzMiw2ICsxMjM1LDEyMCBAQCB2b2lkIEhFTFBFUihtb2Rp
Znlfc3NyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQp
CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcs
IG9sZCk7CiB9CisKK3N0YXRpYyB2b2lkIGhleF9rMF9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52
KQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7CisgICAgQ1BVU3Rh
dGUgKmNzID0gZW52X2NwdShlbnYpOworICAgIHRhcmdldF91bG9uZyBzeXNjZmc7CisKKyAgICBC
UUxfTE9DS19HVUFSRCgpOworICAgIGdfYXNzZXJ0KChlbnYtPmswX2xvY2tfY291bnQgPT0gMCkg
fHwgKGVudi0+azBfbG9ja19jb3VudCA9PSAxKSk7CisKKyAgICBzeXNjZmcgPSBjcHUtPmdsb2Jh
bHJlZ3MgPworICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywg
SEVYX1NSRUdfU1lTQ0ZHLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhy
ZWFkSWQpIDogMDsKKyAgICBpZiAoR0VUX1NZU0NGR19GSUVMRChTWVNDRkdfSzBMT0NLLCBzeXNj
ZmcpKSB7CisgICAgICAgIGlmIChlbnYtPmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfUVVFVUVE
KSB7CisgICAgICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKKyAgICAgICAgICAgIGVudi0+azBf
bG9ja19jb3VudCsrOworICAgICAgICAgICAgZW52LT5rMF9sb2NrX3N0YXRlID0gSEVYX0xPQ0tf
T1dORVI7CisgICAgICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKGVudiwgU1lTQ0ZHX0swTE9DSywg
MSk7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICAgICAgaWYgKGVudi0+azBf
bG9ja19zdGF0ZSA9PSBIRVhfTE9DS19PV05FUikgeworICAgICAgICAgICAgcWVtdV9sb2dfbWFz
ayhMT0dfR1VFU1RfRVJST1IsCisgICAgICAgICAgICAgICAgICAgICAgICAgICJEb3VibGUgazBs
b2NrIGF0IFBDOiAweCV4LCB0aHJlYWQgbWF5IGhhbmdcbiIsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVudi0+bmV4dF9QQyk7CisgICAgICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKKyAg
ICAgICAgICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CisgICAgICAg
ICAgICBjcHVfbG9vcF9leGl0KGNzKTsKKyAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQor
ICAgICAgICBlbnYtPmswX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19XQUlUSU5HOworICAgICAgICBj
cHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOworICAgICAgICBjcHVfbG9vcF9l
eGl0KGNzKTsKKyAgICB9IGVsc2UgeworICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKKyAgICAg
ICAgZW52LT5rMF9sb2NrX2NvdW50Kys7CisgICAgICAgIGVudi0+azBfbG9ja19zdGF0ZSA9IEhF
WF9MT0NLX09XTkVSOworICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKGVudiwgU1lTQ0ZHX0swTE9D
SywgMSk7CisgICAgfQorfQorCitzdGF0aWMgdm9pZCBoZXhfazBfdW5sb2NrKENQVUhleGFnb25T
dGF0ZSAqZW52KQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7Cisg
ICAgdW5zaWduZWQgaW50IHRoaXNfdGhyZWFkSWQgPSBlbnYtPnRocmVhZElkOworICAgIENQVUhl
eGFnb25TdGF0ZSAqdW5sb2NrX3RocmVhZCA9IE5VTEw7CisgICAgQ1BVU3RhdGUgKmNzOworICAg
IHRhcmdldF91bG9uZyBzeXNjZmc7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAgIGdfYXNz
ZXJ0KChlbnYtPmswX2xvY2tfY291bnQgPT0gMCkgfHwgKGVudi0+azBfbG9ja19jb3VudCA9PSAx
KSk7CisKKyAgICAvKiBOb3RoaW5nIHRvIGRvIGlmIHRoZSBrMCBpc24ndCBsb2NrZWQgYnkgdGhp
cyB0aHJlYWQgKi8KKyAgICBzeXNjZmcgPSBjcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBoZXhh
Z29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfU1lTQ0ZHLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpIDogMDsKKyAgICBpZiAo
KEdFVF9TWVNDRkdfRklFTEQoU1lTQ0ZHX0swTE9DSywgc3lzY2ZnKSA9PSAwKSB8fAorICAgICAg
ICAoZW52LT5rMF9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX09XTkVSKSkgeworICAgICAgICBxZW11
X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKKyAgICAgICAgICAgICAgICAgICAgICAidGhyZWFk
ICVkIGF0dGVtcHRlZCB0byB1bmxvY2sgazAgd2l0aG91dCBoYXZpbmcgdGhlICIKKyAgICAgICAg
ICAgICAgICAgICAgICAibG9jaywgazBfbG9jayBzdGF0ZSA9ICVkLCBzeXNjZmc6azAgPSAlZFxu
IiwKKyAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkLCBlbnYtPmswX2xvY2tfc3Rh
dGUsCisgICAgICAgICAgICAgICAgICAgICAgR0VUX1NZU0NGR19GSUVMRChTWVNDRkdfSzBMT0NL
LCBzeXNjZmcpKTsKKyAgICAgICAgZ19hc3NlcnQoZW52LT5rMF9sb2NrX3N0YXRlICE9IEhFWF9M
T0NLX1dBSVRJTkcpOworICAgICAgICByZXR1cm47CisgICAgfQorCisgICAgZW52LT5rMF9sb2Nr
X2NvdW50LS07CisgICAgZW52LT5rMF9sb2NrX3N0YXRlID0gSEVYX0xPQ0tfVU5MT0NLRUQ7Cisg
ICAgU0VUX1NZU0NGR19GSUVMRChlbnYsIFNZU0NGR19LMExPQ0ssIDApOworCisgICAgLyogTG9v
ayBmb3IgYSB0aHJlYWQgdG8gdW5sb2NrICovCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAg
ICAgQ1BVSGV4YWdvblN0YXRlICp0aHJlYWQgPSBjcHVfZW52KGNzKTsKKworICAgICAgICAvKgor
ICAgICAgICAgKiBUaGUgaGFyZHdhcmUgaW1wbGVtZW50cyByb3VuZC1yb2JpbiBmYWlybmVzcywg
c28gd2UgbG9vayBmb3IgdGhyZWFkcworICAgICAgICAgKiBzdGFydGluZyBhdCBlbnYtPnRocmVh
ZElkICsgMSBhbmQgaW5jcmVtZW50aW5nIG1vZHVsbyB0aGUgbnVtYmVyIG9mCisgICAgICAgICAq
IHRocmVhZHMuCisgICAgICAgICAqCisgICAgICAgICAqIFRvIGltcGxlbWVudCB0aGlzLCB3ZSBj
aGVjayBpZiB0aHJlYWQgaXMgYSBlYXJsaWVyIGluIHRoZSBtb2R1bG8KKyAgICAgICAgICogc2Vx
dWVuY2UgdGhhbiB1bmxvY2tfdGhyZWFkLgorICAgICAgICAgKiAgICAgaWYgdW5sb2NrIHRocmVh
ZCBpcyBoaWdoZXIgdGhhbiB0aGlzIHRocmVhZAorICAgICAgICAgKiAgICAgICAgIHRocmVhZCBt
dXN0IGJlIGJldHdlZW4gdGhpcyB0aHJlYWQgYW5kIHVubG9ja190aHJlYWQKKyAgICAgICAgICog
ICAgIGVsc2UKKyAgICAgICAgICogICAgICAgICB0aHJlYWQgaGlnaGVyIHRoYW4gdGhpcyB0aHJl
YWQgaXMgYWhlYWQgb2YgdW5sb2NrX3RocmVhZAorICAgICAgICAgKiAgICAgICAgIHRocmVhZCBt
dXN0IGJlIGxvd2VyIHRoZW4gdW5sb2NrIHRocmVhZAorICAgICAgICAgKi8KKyAgICAgICAgaWYg
KHRocmVhZC0+azBfbG9ja19zdGF0ZSA9PSBIRVhfTE9DS19XQUlUSU5HKSB7CisgICAgICAgICAg
ICBpZiAoIXVubG9ja190aHJlYWQpIHsKKyAgICAgICAgICAgICAgICB1bmxvY2tfdGhyZWFkID0g
dGhyZWFkOworICAgICAgICAgICAgfSBlbHNlIGlmICh1bmxvY2tfdGhyZWFkLT50aHJlYWRJZCA+
IHRoaXNfdGhyZWFkSWQpIHsKKyAgICAgICAgICAgICAgICBpZiAodGhpc190aHJlYWRJZCA8IHRo
cmVhZC0+dGhyZWFkSWQgJiYKKyAgICAgICAgICAgICAgICAgICAgdGhyZWFkLT50aHJlYWRJZCA8
IHVubG9ja190aHJlYWQtPnRocmVhZElkKSB7CisgICAgICAgICAgICAgICAgICAgIHVubG9ja190
aHJlYWQgPSB0aHJlYWQ7CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgfSBlbHNlIHsK
KyAgICAgICAgICAgICAgICBpZiAodGhyZWFkLT50aHJlYWRJZCA+IHRoaXNfdGhyZWFkSWQpIHsK
KyAgICAgICAgICAgICAgICAgICAgdW5sb2NrX3RocmVhZCA9IHRocmVhZDsKKyAgICAgICAgICAg
ICAgICB9CisgICAgICAgICAgICAgICAgaWYgKHRocmVhZC0+dGhyZWFkSWQgPCB1bmxvY2tfdGhy
ZWFkLT50aHJlYWRJZCkgeworICAgICAgICAgICAgICAgICAgICB1bmxvY2tfdGhyZWFkID0gdGhy
ZWFkOworICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAgIH0K
KyAgICBpZiAodW5sb2NrX3RocmVhZCkgeworICAgICAgICBjcyA9IGVudl9jcHUodW5sb2NrX3Ro
cmVhZCk7CisgICAgICAgIHVubG9ja190aHJlYWQtPmswX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19R
VUVVRUQ7CisgICAgICAgIFNFVF9TWVNDRkdfRklFTEQodW5sb2NrX3RocmVhZCwgU1lTQ0ZHX0sw
TE9DSywgMSk7CisgICAgICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSzBfVU5M
T0NLKTsKKyAgICB9CisKK30KICNlbmRpZgogCiAKLS0gCjIuMzQuMQoK

