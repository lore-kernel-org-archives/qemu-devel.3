Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECE5CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCR-0003EI-Tr; Fri, 19 Jun 2026 19:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCH-0002iR-8U
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCE-0001tL-2k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY2Ja2933379
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=; b=aAe6zb+JUQd1igbA
 p8yc8782F2V+hBzW5/6TIqOZvEQljZXd40vwiAfk1lPoEVtiZCa0W5Ic9KEvRVsL
 oj31sC4WSRdzf8xG573tycGs123nzwX0oVS674zH9cKWwaFXtEGDsVZQsELcxjkm
 PwOAeYCNIL/C+EfyIuifr78mfbDGliyMpQOGxT1QAu932akuyxNMsk0h5xw9rDdm
 AOjLHKzkcqB8i7p5AEUqfCiVZnVykWf1W9lAll1eEFP5P/XCZrJDs5d3BtnA/P46
 MFcmajqWiFmQnRK1I3qvhqm3RXI5nUOxmAlsFi/tvXf5P/yfBKEbUGTPwFmVj1SJ
 FaulGw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qsa2x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4610330eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910010; x=1782514810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=UwiB68rxbSssmT3ERQpq241rmL7/mKJXTjtpnKacaqEpNEcHdhwSm2Nj+tzZUtxGow
 0uwBDpy5CCNEtC6axsYZqDgPj6aLBGiLoX4ikX8Flkf7pom+Snw365fPwbWoL9gov2It
 QW9OvYrs6gdRcZz1ickMqj08ew5yvH3T/Pto4QNTlH36fQhihYqVr8WIkzEisDWab3zF
 1N0vfQuG3RJZEdVEVSD+BXKUWO9NhVbl6I2C0rKwZPtymY3Wgw06PzmlJjjo9GKYQ4nH
 syOow2QPEGVr+IInhvUuyR8NJJFnJwQXoJRvAu06AvmKk8heS/ddu/AuofmgAkZtIOjp
 ibeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910010; x=1782514810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=nYlEGB1Hf6CBeBEH3zjN8sIUCB3aIs05G9Hf6n45cMWMuCU5pgCDwobD1gi7ByYuj2
 reMf60yNoLKm1Nt6dlui8abAjjCXOfb0V5t4KXjL3nvKKDcMtNo75a5Qvs8k0cT/f2aj
 SSbDODuv2xUGkIK7mV7EgdL1d72PTMjAx2JPtVTHWH5ZUW+zAHGRlnKNXKGbpfiQ/uC0
 P+rKHJpvwdsGqu9mk+LkdFmARP4WT+OXCCy/hndAWb2SBbtlkQNW8GWdILUuhad3R03O
 nJjuRhlYOfGaLJpb+Wb39zEgBLVObRlbt37P4ZX3n/UWNialJRDBdm0eeVdts64hp8sr
 e9+A==
X-Gm-Message-State: AOJu0YyA/fbRt4R1p1V1nWe1CfVhp6lIef9851+J60clswPXD7ZDg4cR
 r4aYZq+TVfrd9Xy0FptByPxw3e6UUEyMv1BURby8crUWYMdjq2+uIQd7qkDdzFnmEDG6xXINE8+
 RNXLorHqUqeZm3Fz1y6flUHLCGY1AqRFP4iLBX/eej3jXBrpyAwhmNDLQoTN2VrPJiA==
X-Gm-Gg: AfdE7cnoOqr5EBmgi5f8m2nfam9+TSPdngfa7RpRTQG9+8BqDIDOgWkPq241oVtDmJW
 wW711+cU2HCH/+v2v9XPrmwmVm8cm+IsGBR6YZfpn62weK2OAQtzmVGAcMQUf5PLB1s44v33prG
 GTKhTVmMVqKD5uwd6dm59ePEdIsspWaFISbUri64bndz6yjAzmP76Tryrtzm5eJQk6WnGf2YHV7
 TuHbOKb6k0BOUbK4X2R6VD4Cg4WD/mu9UlX99DQsma6s/jiMnm0cRv2AWPPAdnxMp/qnKPw5Z4V
 /DmKUq3Mo7VSxJf8sPzTQIOfEP8cwBaS1ESn8b1NaY/XazlKYLGLTudOfguc+DRb8I3libp6Ftq
 LItlYwBKjuUZmuxiH0vYFDDPMuFBoKCLBnPXyTvYvt4Pe04QSoduAFH5YeSg=
X-Received: by 2002:a05:7300:5b95:b0:304:7a67:6104 with SMTP id
 5a478bee46e88-30c0ceaa96emr2242130eec.7.1781910009644; 
 Fri, 19 Jun 2026 16:00:09 -0700 (PDT)
X-Received: by 2002:a05:7300:5b95:b0:304:7a67:6104 with SMTP id
 5a478bee46e88-30c0ceaa96emr2242106eec.7.1781910009080; 
 Fri, 19 Jun 2026 16:00:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.16.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:00:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 38/74] target/hexagon: Implement iassign{r,w} helpers
Date: Fri, 19 Jun 2026 15:58:35 -0700
Message-Id: <20260619225911.159473-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX9LgmmNYxDp2J
 rhaWnfpUbdK6DVf03up150Mn2zQQpzVJySC7W2xfcH4cETUgMNKG6D+tVA8V1Y+eAoLHzjQi2Vb
 KalWhvE87nxjUSDLx6iuZacoop7YRQ0ot0WvsijG9SzlzfCKxl5452OAajO0nuuhMtVhtKyuoGT
 MYQeV99ZcpfMo2wV4zpcGfF02lE2oS+rPBHP39j2hJvGimdCLW8HJMXWWdpL6hdpvElgLgO/qjn
 qEaE6EcNl7OLSIOkTJgJYx/nMRtNNysDI0HEI3mymf0h4i5ZDFbhUltfjIP142iwIdxGBB6MDp3
 pPyzDuFZBJlSqx6e329sG6PTPCCxuf+InVN97wBtyVQSZ68tiWdLOmrj9mMe55OOob1a/IDzAsR
 TGr3GfLqFZYcpIOtqeiTJr+IHKiXnzwEDcRwXtwErtMRBo9XZP9GmRx77qHIK1WwhpTyXj/Ezfe
 cDlZJWeyz1eCLvorN7w==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35c9fa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JNWpdfNh3sQa7MEFPLFilhBg253XWsfL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX3y0SAlLVRLIC
 tmn8zHEU6T60ilhKnMBlnZP+1/LW7xX5cjr9xs0sO20GM0BMScWoCa84tHLXzsM+5jD3eEWiRw/
 bOGvH/JZ+WktM+mXlQu22A4C70xoS4E=
X-Proofpoint-GUID: JNWpdfNh3sQa7MEFPLFilhBg253XWsfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDc4Mjc2OTZjNmIyLi42ZjAxZjNiOTFk
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTcsMTIgKzE0MTcsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

