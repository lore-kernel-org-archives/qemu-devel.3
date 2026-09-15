Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D573C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4I-00060x-Kh; Tue, 15 Sep 2026 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3x-0005wQ-KM
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3v-0003pW-HO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAfgg2836598
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +qVJQ/GUPjywBgxwOfRwjo+ZY6Han56403zjJbxAG3w=; b=Cj++1s3/K4XZ+1re
 TTfu2VdUPYgXtcKa37m7ICUbKW1lAL31KB2k0ZYkMaUfdbpegoWdrIW5VH8VA+YN
 WEg7yYB498eZ6OGOqB6+zxtJpcCvb+HDkf9WKfqb67XOwoNPdoyMeD8/iHTq6p68
 257cI+GSSUyTsM+aHv39iddIDVZna874XO0XCbMPHqzVdrhZZgCx7i5L1DZ/u8nm
 L8y9fZYU7jWFBebHfURpu1l2X/vZ+dswVEZoLUHkJ4RH3vkXOwmuRVozGuH1Uvbi
 9gw2HBTRis5Cs2pRIXZTdhj6PLUQUuoiFJfoNozIRrQmdWjLGhObI/97NEAHgtEo
 FHSsvg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq1qpaym3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39dc5d85a9cso3781949a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489872; x=1790094672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+qVJQ/GUPjywBgxwOfRwjo+ZY6Han56403zjJbxAG3w=;
 b=CEkl0SO52Lv1N3JUz0anaUXxRR/JAF5oIJzfVOGSF01G8FOdt1WeHISgWzoRQaU8Wq
 fONQzp+nlrPMUbnchg71iOaiKQ7bniC1kuICAi25o0mPIpAIf3BMmrQuGh4dyai8v+9q
 eyitWI6C/PVmMF6DKwlN6WcxKDh+hkWm3M26Co4DcQbUbaqxX2lwsZnJ9xjUPEZFU1Yt
 36MgqAfQDIXHSr2ctoglqQp+koZR+45IDsDB/YqieKCJAuvwdto4JMh28ptEUxNI8T3v
 X8o6YgqM8hCO6TL66VLwPid3W7Rz02qnBTOBCUWA5FLiSxwJcuyo7WQpDxyDOXAbC8Jr
 dmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489872; x=1790094672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+qVJQ/GUPjywBgxwOfRwjo+ZY6Han56403zjJbxAG3w=;
 b=gm+fSVzGF47g4HgqLN//RInrQbqC/TbrzQCW22K9ih/3B3tr2JM/XlFAs9IhU7DBrO
 ykWdcQRTnv37VJ7Scl3BEi/8JQm3oE5cAIWeugBafh1D73pCxeL24qMU+JVvMeOaZ/b1
 7pnCIIET8NwgKVUZfxTTWaWY51oFmI4t6wMZ5lTb1EbA9ji5M7Wa1CpLk/gIzk4VRDC3
 WkSFt/4Cce1s5jkJgJOAt93+RcjC5o3lB9epLZ+gu4YZNbJKxYmmjowMWukbYvUh70au
 WMbhwQ29psuIRGH0402jCsg6Sddc/k62cEZX6tZY0cTwRBVWuEZAzkFRXX2oUmlPB3qZ
 hS3A==
X-Gm-Message-State: AFuF++mcSjMXK8RcJK94/a4vO8HKSHYJRk5y8UE3FN86Y1Xi69EaYrYx
 5rDMLsiSdGWQh6aExhnN6WyE9eMTJpA5HkCSBZJLcwj5PllMj3yQUabiJabTyKg1rHWhX31NH0A
 DxvzbXCVM3Fxy4GyCGux9royunWht4wGxAPjvSb9A+eKDnWZyDiJV0ShUh0e5yccwTQ==
X-Gm-Gg: AYBFou1QifBJRwSiR/xci7PeCLNoUsx8o+WKHEpxJb8mSlnhSZVphYCWhF6UiFl1jx8
 61O0qWAVCLrlT3uDIpfTh/La0uicELiNnD+y++ReJ+xauyhjVM3dMnLTvMU2VwC6gBRasLRR5x8
 ZY4Nwz5ke+2K3Z/1OlEM6mtT9L66YHClEvlhUGv+zXxkyJgUScXtOI52t5heQEKkxY9rRxuugrQ
 YJjIPFzDmBriLRGEtSmJQ1nrdrYVYGn4E3A8cVfMNXoU2yrLio/MCr6jxDq03kX/BIPTPfV2wm2
 N/QRwIWQNvQjcDTi9iuuQBZHU9HK5tl0PtsBIMLlDbDpsu6Qm5uVfI1hPcaGjxoE+qD1gQZPT1F
 NYoRsq76TxObn6mdt5RdJOi+BKu1+P0enDKB+80flJEaMmLIv
X-Received: by 2002:a17:90a:6096:b0:39e:14db:437b with SMTP id
 98e67ed59e1d1-39e14db4706mr1392437a91.7.1789489872484; 
 Tue, 15 Sep 2026 09:31:12 -0700 (PDT)
X-Received: by 2002:a17:90a:6096:b0:39e:14db:437b with SMTP id
 98e67ed59e1d1-39e14db4706mr1392380a91.7.1789489871944; 
 Tue, 15 Sep 2026 09:31:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 08/17] tests/tcg/hexagon: add cond call, tstbit-jump,
 and endloop01 tests
Date: Tue, 15 Sep 2026 09:30:38 -0700
Message-Id: <20260915163047.4180600-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX4QoKACEiyHuh
 ap50Kgta7qwdYOgKOgI540cY8455txwXXaF1X1Oh8MYMLfEzECVGLyukF6QwuU52UupLmjH5mdt
 3bRnHse7PzVjzNZ7ZK6rgIBp+/W6aag=
X-Authority-Analysis: v=2.4 cv=I4Xw19gg c=1 sm=1 tr=0 ts=6aa972d1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=UPTrhlJ9XJtdYAbvsWkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: KVGcJYODv6f_kQpvLpN4z52MadEJx1Au
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfXw1DF7fcfEb9u
 KGIsm7Kvxg2IsZcesaFrSAgybZX84QzjYZgPAN+6I620gJOyZ22FUah8s1aKZWWHFQp1QdxHHS+
 sVYwz5F0XEpMB24BapOBDsETx11D08Asu63nkyUJTyoi29rMSbJAdJXSBsrL8e28veAijpZ8cyH
 a0+aKZXOy7uJhGKf8qWwn+9YA3xHYES2ELZDLFEE1zWhEP4Sr8G5jLmjdvzhJ/UKbMVY96WD9Od
 0ZebI6ogFZfXazcTjKkxHeQLgoSZbjaFYbM2DZ2TPIDGlYED9KRiQ9Ud2VBtzNmJgjnv45+cl7a
 6hnASmTD1O8zsz6rcF8Sg6Sak9tkBmaUSYe2d/aLBz7ZMArn890bbz+KHhDn9bxb1jJQ+AWWsrT
 nmeBotxwNzfmYU6q8oDiTzoQRtDpUaCLMgsM75yA+coVIvJwCWi0vqqTRr2zo8BCtHVkiXr2bgW
 v4zQny20e2ra1s7XUBQ==
X-Proofpoint-GUID: KVGcJYODv6f_kQpvLpN4z52MadEJx1Au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150239
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
aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggZTk1MDk2YzFhNDkuLjIw
OTRlZjNmNjVjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAorKysg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNzMsNiArNzMsNyBAQCB0ZXN0cyAr
PSB7CiAgICd0ZXN0X2NhbGwuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9jbG9i
YmVyLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfY21wLlMnOiB7J2NmbGFncyc6
IGFzbWZsYWdzfSwKKyAgJ3Rlc3RfY29uZF9icmFuY2guYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwK
ICAgJ3Rlc3RfZG90bmV3LlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfZXh0LlMn
OiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3RfZmlib25hY2NpLlMnOiB7J2NmbGFncyc6
IGFzbWZsYWdzfSwKLS0gCjIuMzQuMQoK

