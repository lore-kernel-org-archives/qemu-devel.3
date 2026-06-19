Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9055DCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifR-0003rS-Ik; Fri, 19 Jun 2026 19:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifP-0003qQ-Oc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifO-0007QR-4D
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYSNI1337254
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=; b=KJHYCLU4Qnu5DmbH
 hYWdQYYldNGouXMlYLDCJml2ty6ZWtrw0OWqqp7xtB+Ogtc1WGBsihaqBhLEvSim
 dixyIrte0jHn/PE8LhVKmi2goYOo1LPVFmlL+UKMz94voMCJ9EUezQXucKEa4bhJ
 jK+69tafglOiCHdAfuG9Md040Ccb8R8YBSfu7QmSPlgyllqwrLvjeuT542dSc0Tc
 pnJh2cMiPr2YR/jasgLTHHl8GlaqAGOxdhnofOeHRdQHqiYIkeV6ZPMqN+dhrh0r
 mI6TC//TynWyvCLijfPBzXhtOg/aPEcUjJAt84LPlfiKyJpzhNoIz/5vFDW5nSUG
 kaTmQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67579u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bfe262ef0so1143391eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911828; x=1782516628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=FeYCQdp5ABhkv6XnnsMriJtcKYMUh/A/z9/m0vJDrzyiffyO/X0Wbp9gKovCO66Bsz
 allErlOgtG0H0iPmJmn/4OHrvDLMh1ESl4HGjo6IjWDIy0sfg78QW06Z3Cug6RMb9cVd
 3Djgf132Gid21qjADiu6p+aKGbgj4N/uJ2qF9x0HjlyiJFYpLsdvDfKZiEtlOISlP4S3
 mTYOMga6NLVVlANsBfpKgXIWDZhpdD0jG0jlKilDvSfJHS+b65bb7ZPA/EU/fztFjKTf
 Btr1uMqutfzjkjU+gybETWj4CHz5ZLyifaiukhmirSPsHgPPWRnH6gCR2luS1K+YCaJb
 ZPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911828; x=1782516628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvcaRvjzOPnVsLj+Umjxfrn/9XQNcxuKMqpMR7fRmpk=;
 b=jyGpNAoVYSRnarV4o1iLWx0AWbg4rVSNuiFUW90maU3BA1Ae27vJSXYcdqIoyHA3c2
 wULs9ErAlHpnIqqvCukZZgyYGGz3gHAibA8g+n1nVAkq2Q+f5fL90s2uDeSX2ktUC7Ok
 V35TDK/fOXlIYKm1HUape+YbJjlXbrxKb0aPhytvVNyePcuytgBn5UhRl1zRnPu5+iRR
 X1agcW+77X0VZazb0G/URIfE+hLzWu2MhRQH2CvdzU1aE9HT+VYnTvtFGrQLojdtsr8J
 ewWq/TkHqyPPDOhLRDXa3FRsI2ZL337ilz61gXB8fW78caJnTtjjuuaFxuv0IzdkzAgK
 /N2g==
X-Gm-Message-State: AOJu0Yz6K6jiehX6fTM1sCGlgxoNA62KsoAqDhPoCXQxlHQOoxPl4O/o
 HxsFTWoV/mfw2/YIXWtDRWxeXn6HxF93SUNjSNXmWkVVn5I+MEC/SzO/R7/MX7nhpR3KhSQsDFo
 cVIMESsuXAac+3t5np3L24CV2KgYrKerlIbAeg3AYsMBvUTgnrbtUtqof0Eau4NFspw==
X-Gm-Gg: AfdE7clUlHSDdb23HdmkjKTA68Tx7ZU7uxGfSIhfyOnf6R7fn7czsIrJf7l8+wjZAKA
 5nyqdt3nQ21/lIPc4M3Y6Gq3bpOUfjHGyS1bpyHQu9mUxHklimAICcHYUOU12XJAcria59aODNO
 /Qf/VLbyppcxY6Kpz4Aek/IxiI8AwR5QKfo2NZtm0l22jxHLq2JBmxgu8c8qJguTT0X2BTt5KeA
 KOnmY0AC+nfTk2VJuhecEEtyZr/ecRKoBO/C0wtNwwQWoyuJeou+w79JjKwXXzoqMtGBSU1CHRX
 LoWbaDMNsmP1N78L1EF0wl5IIODzHcH4OgCo8au+oSbfZVRvGN6o6YZ3vVZgv1FY8j0BRscwbuE
 eSivMyC3BXsbeIUPOJGK7++v2VA/LTAoSvDIDW8ob+X6/l+yMfaRv0SVA+H0=
X-Received: by 2002:a05:7300:80c6:b0:30b:ec2c:26d5 with SMTP id
 5a478bee46e88-30c079d08d0mr3362114eec.15.1781911827949; 
 Fri, 19 Jun 2026 16:30:27 -0700 (PDT)
X-Received: by 2002:a05:7300:80c6:b0:30b:ec2c:26d5 with SMTP id
 5a478bee46e88-30c079d08d0mr3362101eec.15.1781911827453; 
 Fri, 19 Jun 2026 16:30:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 50/74] target/hexagon: Implement hexagon_resume_threads()
Date: Fri, 19 Jun 2026 15:58:47 -0700
Message-Id: <20260619225911.159473-51-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 1hNJ9BKOVeYr559eSELOKbxZH3ydArrI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX0K3DiyX9ToY5
 I1EwyH8N6M32/wH3PF5fa2qL+mRMIS27DQJFmNvmlPoXfIohrv39DC0NZaLRk67b+cU51nCFJUh
 a090o1+WJ9D54PIxEIDv9uCjeKyl8YFz/HpqUE18AjcrpIoU7X9b3G2KJPe19HK0fSXjTmGa4gd
 +/BDia8sIYknRfL+xsnPB72xoQBVGs8ITz8RlDuuVMN3BehTnLSwVXBjm4ftA4cuwpej/2CvT9X
 q+yBqtIJ/Eyp3e2a4FFkrXPIsIf/xIzE/bm8PT13S+VTP3UE5SQX/3XEtXlshuXbWnQu2FwcbQ6
 pdx99nfCBf+gJJtluOfEa1tS/XgNc6ZeYK7+IAe9+K5/PL0XWI+q8QsYRlQ71GPKEtZ8rfv7Bvv
 L+Te7JbhrLJsAVagclg3s27YfWOBzh0BcXwASXwW1yiy3z/VSOXUdioGbbFGaoZSUQMB/1erFo7
 0ysCwp/X+GNNXg1fbTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX9KgBw4Zml/B/
 QCZG4FfJT+Sdpjesn6I8F9zZIZeiILApZqM7ftBEVQdltiFNQpnRNBrOIThz9vu3V0+jSHMmTvP
 4ghck4X/4lC89ENHeGRhJuTb7xR2gsA=
X-Proofpoint-GUID: 1hNJ9BKOVeYr559eSELOKbxZH3ydArrI
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d114 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggOTJkNGJi
OTcxMjkuLjZhOTVhNmJjNWIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTIsNiArNTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRkMzE5
YTI2MzdmLi4zNGM1NWI1NjBjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDEsNyArMTYwMSw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

