Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3220C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9a-00059m-M4; Thu, 24 Sep 2026 21:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9W-00050p-Kk
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9U-00065G-KR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1lQCP3753101
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZmTWwZziOYKDbt2ajhZeMa2nbLon8EGk5fjBjl75l0Q=; b=TMG2xOEoobG2ukVa
 ZJhUmH/rfb/BKgEAxsxM4H+a6X26aVqrAzhWqyxPuf5Ea39r/8hhysIEFhSAHaWP
 jIHF5DtRjUeqIz3D5r0R6pB1cUATDBGGFltqLHqemtPHLsd6QrGUlOPK+3k284Z2
 CQEnIYQd7Fr/hOnzBdo9qpl/iCAm51kuXpJGj0NuEZP+S1yDgFx8Sk3ukvEYcLVR
 cC05x6QT7bo7FqXlSwJO86MMwDciXJnxaRUnu4I1vDtwExO1hb0fytW+I/Y9HTtZ
 2hORT30mIlUCMkFuXlNYj3MHPbp61UkfvxUgf9MK+K1vRxpkqrzQuNVcOJEgXLyW
 ANYGug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8tcnj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33310847fcaso651620eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301303; x=1790906103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZmTWwZziOYKDbt2ajhZeMa2nbLon8EGk5fjBjl75l0Q=;
 b=hr9Rijrw+76+1VyzuNo3NREzHcoDSLuyMkMxVKdIY+FzVxC9jzKk7LjGFJ+yStj+zP
 2w/QSHo85UaNUHwu2tQNvuQ7yFgViLbt7Ekzzu1BN1Wy+q9MSESSerf+CBJLNOKzVgqC
 3jstJ0TWosPda2cjrMAov9IDZRz+RN8U7qZAnDzflBpfmbv7G37cGQwGHO3GCQrtaJTT
 wpEHIE6v3h1fnEtcl7RxtsBjWfo4E7OgOzllilS9Gl0k93F0thkCOK1V4SKGVn0Kouvp
 Jl0N2U1CQ0LkfG1L0MHeZwQjhGlTKD4RqyWIV0rxMwtY+aKkge7n3+g15GP9HZbTZOBi
 FLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301303; x=1790906103;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZmTWwZziOYKDbt2ajhZeMa2nbLon8EGk5fjBjl75l0Q=;
 b=SJUDItAj8BM4ybOjobETDO6aFXbyZT+fU9cQMoXRKo5vgNbrMincAkgICmTXBXC0Bi
 drWUepfctZJCbpzhr9S7idhQswh5B6jy2pCovPt43ifJ4zuCWYLde6FQZ7gEzFqcowb+
 DBP57B9Cdo+UxJtFd6KPWBlUFYAnA6XGcfUO0Zu7fHqvl9oP6NHhI5jELbLkJYBd3iyU
 cPasixaseM18IpCt+mANIBpDZHdCnPRwSQ2YzA7dQFIFR6uyD5n5a7s/JvYa6mGMAZuI
 yK/pFqqBU5k+dJXE6PutCbnvL6VH4wY6gZsPkZ1YkDn751hLknlIcUIQxD+QElD/XgCn
 qJEQ==
X-Gm-Message-State: AFuF++m3kJwfRNSTWHW+cAzT/HDQSM8lG6gRXJ+94ZrnYN1d8DTh2UPs
 hkJ11XxxAds8GfdxPEIhorUK12naiDLKZz5HwE+XM7lhR3wfxTUFfhbXlrPAnBbGq4RRxaI9IuF
 fXZKC2dkrhhtik8YVnKU4PMY3xx2zyMIUuX5NbEaj1/bSX9TQpsi6NWPIGvA6Y6PUfA==
X-Gm-Gg: AYBFou1hdKkPx1ip1ahFG0koOrTZJmHcmiLLkofiZ5SxrnMTbVIHOCPy0UQNCoMczj0
 SItDnY0G6FaT2jZoDhh7HSaIDNdqfBD1xC7bm5i3la8Melpzx3Kxp9q4mbt4yc5rCNS7EZEDcMr
 STWIQC5ydI6GaqUJzSkz17mIxQPI/oXbQZbm35hwVr1G5ruMvuhM+J+auNCWGg5Mgl4KPGixXFs
 N6TX42Th8D3yxzX5BTdM0n58nGyD9Uj205t+JGh4GaHFY3VWYczzuDuEKVFbtcuZ5RbA2w+vlvj
 qfqDPdJBckytMqAgUhphoEJYH/yzNPXQFJqDWq9mw8AvKuLu9thkp8zZe2VfooqZDHY3znxf1mB
 hym5IxRtnvFvDTZ/XhhXQ4jxEuG0PVQ1Dgwcow7cdCnDP+ak=
X-Received: by 2002:a05:7301:4307:b0:328:3542:b73e with SMTP id
 5a478bee46e88-341978b5979mr307241eec.15.1790301302397; 
 Thu, 24 Sep 2026 18:55:02 -0700 (PDT)
X-Received: by 2002:a05:7301:4307:b0:328:3542:b73e with SMTP id
 5a478bee46e88-341978b5979mr307225eec.15.1790301301739; 
 Thu, 24 Sep 2026 18:55:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 18/40] tests/tcg/hexagon: add cond call, tstbit-jump,
 and endloop01 tests
Date: Thu, 24 Sep 2026 18:54:07 -0700
Message-Id: <20260925015429.2579174-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX7CSE14gICcwY
 vixDY9gb5uI0wI4RBXQ4VOd3TWcD40L3vai5v152v2YM9pyxRCG6wwQVEGOWHIsIjPW7RFq0DjM
 hRwAt1UEQYS+PnZpRJ/gOx5ebiNvIGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX/yVmsodm+tD9
 mBi2lOjHqIoYuq8B6Tvpbm8PJ6pEP4Zpge+a6RjorF+N0U3HgqjHfS5T7s4HrPhIVcujizUH/HL
 +JVIaPhUGAmPX890xoYfkZ6ETyuBzvDwr689sHhv4afUOuEhF54vodphJid/t0JtPPEDFbDN4ov
 9QA8vNsGGuujevN7guapqqWBfItWDAnP9QowXCIWe+l6kNXnJJKEKsG6CmTlBoRg7MzUDCvtTk2
 kmdvnb+txjly6gTd4ojDIzdi7mbcyLgQi1Pl0OHQBu1D5CmxFYLDk5P3tXXurJqOK0ERivsE1CR
 oSCrsVUSXgMD8XLqO1eW4/YRoe70yf+H5QhDEwzCUQy4qW5dOdp/gQD+cKcdULuTEwd9AsV43r6
 4HsO5QQjyJq8m2ehDWxyqfdk0D2EuHEO0rAsfCx1yoXrTtUzlyqJugAwdkwen6rY+sGl7OqTjHc
 awAqNUmnS41JkY53mwQ==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab5d477 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=UPTrhlJ9XJtdYAbvsWkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: eM4vnWMXYZwQiLVUr5rnKhnbEtI-BQhL
X-Proofpoint-ORIG-GUID: eM4vnWMXYZwQiLVUr5rnKhnbEtI-BQhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

VGVzdCBjb25kaXRpb25hbCBjYWxsciwgY29tcG91bmQgdHN0Yml0MC1hbmQtanVtcCBpbnN0cnVj
dGlvbnMgYW5kCmVuZGxvb3AwMS4gIFRoZXNlIGV4ZXJjaXNlIHByZXZpb3VzbHkgdW5jb3ZlcmVk
IGJyYW5jaCBwYXRocyBpbiB0cmFuc2xhdGUuYy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4
YWdvbi90ZXN0X2NvbmRfYnJhbmNoLmMgfCAxNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiB0ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgfCAgIDEgKwogMiBmaWxlcyBj
aGFuZ2VkLCAxNjMgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9o
ZXhhZ29uL3Rlc3RfY29uZF9icmFuY2guYwoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29u
L3Rlc3RfY29uZF9icmFuY2guYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfY29uZF9icmFuY2gu
YwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNzNiZThmYmI0M2MKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2NvbmRfYnJhbmNoLmMKQEAg
LTAsMCArMSwxNjIgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2ll
cywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworLyoKKyAqIFRlc3QgY29uZGl0aW9uYWwgY2Fs
bHMsIGNvbXBvdW5kIHRlc3RiaXQwLWFuZC1qdW1wIGluc3RydWN0aW9ucywKKyAqIGFuZCBlbmRs
b29wMDEgKGR1YWwgaGFyZHdhcmUgbG9vcCBlbmQpLgorICovCisKKyNpbmNsdWRlIDxzdGRpby5o
PgorI2luY2x1ZGUgPHN0ZGludC5oPgorCitpbnQgZXJyOworCisjaW5jbHVkZSAiaGV4X3Rlc3Qu
aCIKKworLyogVGFyZ2V0IGZ1bmN0aW9uIGZvciBjb25kaXRpb25hbCBjYWxscyAqLworc3RhdGlj
IGludCBjYWxsX3RhcmdldF92YWw7CisKK19fYXR0cmlidXRlX18oKG5vaW5saW5lKSkKK3N0YXRp
YyB2b2lkIGNhbGxfdGFyZ2V0KHZvaWQpCit7CisgICAgY2FsbF90YXJnZXRfdmFsID0gNDI7Cit9
CisKKy8qCisgKiBUZXN0IGNvbmRpdGlvbmFsIGNhbGw6IGlmIChQdSkgY2FsbHIgUnMgLyBpZiAo
IVB1KSBjYWxsciBScworICovCitzdGF0aWMgdm9pZCBjaGVja19jb25kX2NhbGwodm9pZCkKK3sK
KyAgICB2b2lkICgqZm4pKHZvaWQpID0gY2FsbF90YXJnZXQ7CisKKyAgICAvKgorICAgICAqIGNh
bGxyIGNsb2JiZXJzIGFsbCBjYWxsZXItc2F2ZWQgcmVnaXN0ZXJzLgorICAgICAqIEhleGFnb24g
Y2FsbGVyLXNhdmVkOiByMC1yNSwgcjE0LXIxNSwgcjI4LCBwMC1wMy4KKyAgICAgKi8KKworICAg
IC8qIGlmIChwMCkgY2FsbHIgUnMgLS0gcHJlZGljYXRlIHRydWUgKi8KKyAgICBjYWxsX3Rhcmdl
dF92YWwgPSAwOworICAgIGFzbSB2b2xhdGlsZSgicDAgPSBjbXAuZXEoJVtvbmVdLCAlW29uZV0p
XG5cdCIgIC8qIHAwID0gdHJ1ZSAqLworICAgICAgICAgICAgICAgICAiaWYgKHAwKSBjYWxsciAl
W2ZuXVxuXHQiCisgICAgICAgICAgICAgICAgIDoKKyAgICAgICAgICAgICAgICAgOiBbb25lXSAi
ciIoMSksIFtmbl0gInIiKGZuKQorICAgICAgICAgICAgICAgICA6ICJyMCIsICJyMSIsICJyMiIs
ICJyMyIsICJyNCIsICJyNSIsCisgICAgICAgICAgICAgICAgICAgInIxNCIsICJyMTUiLCAicjI4
IiwgInIzMSIsCisgICAgICAgICAgICAgICAgICAgInAwIiwgInAxIiwgInAyIiwgInAzIiwgIm1l
bW9yeSIpOworICAgIGNoZWNrMzIoY2FsbF90YXJnZXRfdmFsLCA0Mik7CisKKyAgICAvKiBpZiAo
IXAwKSBjYWxsciBScyAtLSBwcmVkaWNhdGUgdHJ1ZSwgc28gIXAwIGlzIGZhbHNlICovCisgICAg
Y2FsbF90YXJnZXRfdmFsID0gMDsKKyAgICBhc20gdm9sYXRpbGUoInAwID0gY21wLmVxKCVbb25l
XSwgJVtvbmVdKVxuXHQiICAvKiBwMCA9IHRydWUgKi8KKyAgICAgICAgICAgICAgICAgImlmICgh
cDApIGNhbGxyICVbZm5dXG5cdCIKKyAgICAgICAgICAgICAgICAgOgorICAgICAgICAgICAgICAg
ICA6IFtvbmVdICJyIigxKSwgW2ZuXSAiciIoZm4pCisgICAgICAgICAgICAgICAgIDogInIwIiwg
InIxIiwgInIyIiwgInIzIiwgInI0IiwgInI1IiwKKyAgICAgICAgICAgICAgICAgICAicjE0Iiwg
InIxNSIsICJyMjgiLCAicjMxIiwKKyAgICAgICAgICAgICAgICAgICAicDAiLCAicDEiLCAicDIi
LCAicDMiLCAibWVtb3J5Iik7CisgICAgY2hlY2szMihjYWxsX3RhcmdldF92YWwsIDApOworCisg
ICAgLyogaWYgKCFwMCkgY2FsbHIgUnMgLS0gcHJlZGljYXRlIGZhbHNlLCBzbyAhcDAgaXMgdHJ1
ZSAqLworICAgIGNhbGxfdGFyZ2V0X3ZhbCA9IDA7CisgICAgYXNtIHZvbGF0aWxlKCJwMCA9IGNt
cC5lcSglW2FdLCAlW2JdKVxuXHQiICAvKiBwMCA9IGZhbHNlICgxICE9IDIpICovCisgICAgICAg
ICAgICAgICAgICJpZiAoIXAwKSBjYWxsciAlW2ZuXVxuXHQiCisgICAgICAgICAgICAgICAgIDoK
KyAgICAgICAgICAgICAgICAgOiBbYV0gInIiKDEpLCBbYl0gInIiKDIpLCBbZm5dICJyIihmbikK
KyAgICAgICAgICAgICAgICAgOiAicjAiLCAicjEiLCAicjIiLCAicjMiLCAicjQiLCAicjUiLAor
ICAgICAgICAgICAgICAgICAgICJyMTQiLCAicjE1IiwgInIyOCIsICJyMzEiLAorICAgICAgICAg
ICAgICAgICAgICJwMCIsICJwMSIsICJwMiIsICJwMyIsICJtZW1vcnkiKTsKKyAgICBjaGVjazMy
KGNhbGxfdGFyZ2V0X3ZhbCwgNDIpOworfQorCisvKgorICogVGVzdCBjb21wb3VuZCB0ZXN0Yml0
MC1hbmQtanVtcC4KKyAqIHAwID0gdHN0Yml0KFJzLCAjMCk7IGlmIChbIV1wMC5uZXcpIGp1bXA6
dC9udCB0YXJnZXQKKyAqLworc3RhdGljIHZvaWQgY2hlY2tfdHN0Yml0MF9qdW1wKHZvaWQpCit7
CisgICAgdWludDMyX3QgcmVzdWx0OworCisgICAgLyogUnMgaGFzIGJpdDAgPSAxLCB0ZXN0ICJp
ZiAocDAubmV3KSBqdW1wIiAtPiBzaG91bGQganVtcCAqLworICAgIHJlc3VsdCA9IDA7CisgICAg
YXNtIHZvbGF0aWxlKAorICAgICAgICAie1xuXHQiCisgICAgICAgICIgICAgcDAgPSB0c3RiaXQo
JVt2YWxdLCAjMClcblx0IgorICAgICAgICAiICAgIGlmIChwMC5uZXcpIGp1bXA6dCAxZlxuXHQi
CisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgIiVbcmVzXSA9ICMwXG5cdCIKKyAgICAgICAgImp1
bXAgMmZcblx0IgorICAgICAgICAiMTpcblx0IgorICAgICAgICAiJVtyZXNdID0gIzFcblx0Igor
ICAgICAgICAiMjpcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAgICA6
IFt2YWxdICJyIigweDUpICAvKiBiaXQgMCBpcyBzZXQgKi8KKyAgICAgICAgOiAicDAiKTsKKyAg
ICBjaGVjazMyKHJlc3VsdCwgMSk7CisKKyAgICAvKiBScyBoYXMgYml0MCA9IDAsIHRlc3QgImlm
IChwMC5uZXcpIGp1bXAiIC0+IHNob3VsZCBOT1QganVtcCAqLworICAgIHJlc3VsdCA9IDA7Cisg
ICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAie1xuXHQiCisgICAgICAgICIgICAgcDAgPSB0c3Ri
aXQoJVt2YWxdLCAjMClcblx0IgorICAgICAgICAiICAgIGlmIChwMC5uZXcpIGp1bXA6dCAxZlxu
XHQiCisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgIiVbcmVzXSA9ICMwXG5cdCIKKyAgICAgICAg
Imp1bXAgMmZcblx0IgorICAgICAgICAiMTpcblx0IgorICAgICAgICAiJVtyZXNdID0gIzFcblx0
IgorICAgICAgICAiMjpcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAg
ICA6IFt2YWxdICJyIigweDQpICAvKiBiaXQgMCBpcyBjbGVhciAqLworICAgICAgICA6ICJwMCIp
OworICAgIGNoZWNrMzIocmVzdWx0LCAwKTsKKworICAgIC8qIFJzIGhhcyBiaXQwID0gMCwgdGVz
dCAiaWYgKCFwMC5uZXcpIGp1bXAiIC0+IHNob3VsZCBqdW1wICovCisgICAgcmVzdWx0ID0gMDsK
KyAgICBhc20gdm9sYXRpbGUoCisgICAgICAgICJ7XG5cdCIKKyAgICAgICAgIiAgICBwMCA9IHRz
dGJpdCglW3ZhbF0sICMwKVxuXHQiCisgICAgICAgICIgICAgaWYgKCFwMC5uZXcpIGp1bXA6dCAx
ZlxuXHQiCisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgIiVbcmVzXSA9ICMwXG5cdCIKKyAgICAg
ICAgImp1bXAgMmZcblx0IgorICAgICAgICAiMTpcblx0IgorICAgICAgICAiJVtyZXNdID0gIzFc
blx0IgorICAgICAgICAiMjpcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAg
ICAgICA6IFt2YWxdICJyIigweDQpICAvKiBiaXQgMCBpcyBjbGVhciAqLworICAgICAgICA6ICJw
MCIpOworICAgIGNoZWNrMzIocmVzdWx0LCAxKTsKK30KKworLyoKKyAqIFRlc3QgZW5kbG9vcDAx
OiBhIHBhY2tldCB0aGF0IHRlcm1pbmF0ZXMgYm90aCBsb29wMCBhbmQgbG9vcDEuCisgKiBPdXRl
ciBsb29wIHJ1bnMgMyBpdGVyYXRpb25zLCBpbm5lciBsb29wIHJ1bnMgNC4KKyAqLworc3RhdGlj
IHZvaWQgY2hlY2tfZW5kbG9vcDAxKHZvaWQpCit7CisgICAgdWludDMyX3QgY291bnQ7CisKKyAg
ICBhc20gdm9sYXRpbGUoCisgICAgICAgICIlW2NudF0gPSAjMFxuXHQiCisgICAgICAgICJsb29w
MSgxZiwgIzMpXG5cdCIgICAgLyogb3V0ZXIgbG9vcDogMyBpdGVyYXRpb25zICovCisgICAgICAg
ICIxOlxuXHQiCisgICAgICAgICJsb29wMCgyZiwgIzQpXG5cdCIgICAgLyogaW5uZXIgbG9vcDog
NCBpdGVyYXRpb25zICovCisgICAgICAgICIyOlxuXHQiCisgICAgICAgICJ7ICVbY250XSA9IGFk
ZCglW2NudF0sICMxKSB9OmVuZGxvb3AwMVxuXHQiCisgICAgICAgIDogW2NudF0gIj1yIihjb3Vu
dCkpOworCisgICAgLyogMyBvdXRlciAqIDQgaW5uZXIgPSAxMiB0b3RhbCBpdGVyYXRpb25zICov
CisgICAgY2hlY2szMihjb3VudCwgMTIpOworfQorCitpbnQgbWFpbih2b2lkKQoreworICAgIGNo
ZWNrX2NvbmRfY2FsbCgpOworICAgIGNoZWNrX3RzdGJpdDBfanVtcCgpOworICAgIGNoZWNrX2Vu
ZGxvb3AwMSgpOworCisgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOworICAgIHJldHVy
biBlcnIgPyAxIDogMDsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1
aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggNjkzNWQwMjgwMmIuLjYw
NzRlNTZmNmQ2IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAorKysg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNzMsNiArNzMsNyBAQCB0ZXN0cyAr
PSB7CiAgICd0ZXN0X2NhbGwuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9jbG9i
YmVyLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfY21wLlMnOiB7J2NmbGFncyc6
IGFzbWZsYWdzfSwKKyAgJ3Rlc3RfY29uZF9icmFuY2guYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwK
ICAgJ3Rlc3RfZG90bmV3LlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfZXh0LlMn
OiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfZmlib25hY2NpLlMnOiB7J2NmbGFncyc6
IGFzbWZsYWdzfSwKLS0gCjIuMzQuMQoK

