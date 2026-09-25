Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC33C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9P-0004y6-RP; Thu, 24 Sep 2026 21:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9L-0004wL-Ni
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9J-0005sw-Tm
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kWZi706017
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MsGK1FQdBkrAAwju1mSsIVKbpL08+6oolGLOYSaXNlw=; b=XwXYv7Q0w3HszPS2
 rUp0EicMSLxcw1J8C8rH1VVGJxboI4gkWnn6cKon7Kvv0gncgKCFFGG8rCLohJXi
 IjE5oSE1xw+uoayYmv1ysH08le6HeabkihpsKhgI3oqzulrwNONuTDwLu+PVzbTW
 keqIMF1bxemDBQKgxPhtQJHP6bko5ak2sZbSZDi1BdsrXjjMrYNf2mo1EsYxtnEa
 mgI4/iVuQrVNd6fiBFc8MUvihoXBtGnbXunrINaFfC5l4geaiAaBlra2SXxga1D5
 Fbh9X0ngti7yE6fMDwi351Lkr3Fms8ioO5DxcdUaZoeeTw7qNzRLJgCK/foK0plg
 XQsrIQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce78h9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14318be7d79so555824c88.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301292; x=1790906092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MsGK1FQdBkrAAwju1mSsIVKbpL08+6oolGLOYSaXNlw=;
 b=UzJVJ9W8o35ekcM2jLGh2KbwI7vEs0juwcWXnvEzq0PfWwwVCjhGzqIaG5Szq/eEEY
 BwR3bTX8konpUJct8ShtOUUNkkf0FpbRD///w4YuVwyOGqO5VUSju6Jzj2f3GmixuYyi
 6S8byveK4Gw8L25JA9NpkMQ5tQT46K94PX9mZbIBizy3qQtlqq7fTiSvuZKsuTBKr8zt
 hD1BzYE1pkK5S1mCbg15/11ezn5rWWXKg2V3u1lYo0KHr7bqmfMgnt7bBcxI146LTVZP
 Tg3NJRLVtFnB4S3R3/FEhTMHbb362G7LJ84pEcWc9djLDpgczLqi5zEnxTta1TBLck1/
 b+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301292; x=1790906092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MsGK1FQdBkrAAwju1mSsIVKbpL08+6oolGLOYSaXNlw=;
 b=IiCpiK17oHFpNbCu/A7Y2ENZQiWNTDqTmLevtUofMUr6SkhSjIQ8SXc2+9FeyVSwyb
 p86vX4ittfp2nu8D3To5e4Og4i1YkLu7qmE5e3XmQ34uUYCAIeE+2PrBq/VS1cWkOuds
 VRp8uWVk+TyEHkJlb1y43ANaYcngj3N3eFM2xMQa4T1w9l2E0Do0pkWu6bOqnwC733/Z
 az6uybwWUnHJDvuoQsTu1jVOCg7WyDfImFXbQoTAUJepL1NBBRCS1nO7C9ZRbrVDJvvo
 banAgpS7+AEPDAtiMo3TA7PtTfRHGP8bAvpg2N0/VScaBde6ON/JysqplqSwEZGNdmnt
 QMBg==
X-Gm-Message-State: AFuF++n+ejMzVk/mkInG+swAgx9PV4bLjh0zJq4caKRQJylwYCHHAdVY
 H9wcGTh9q4GT81g/Lx2i2BISNfD8jed9HK/MFmcqlZr6RNJQFibkKWwKCW6Z09UerDQypqKwNe1
 S8Wy1Fuqrjv5ZVvyX/2tH+obdMnNTCjco5zqy+TLf5K+Og4gKuWKX5pGuiPgLc2oQBQ==
X-Gm-Gg: AYBFou3yr3XAfQcd31SCaSRue4ukBCf0Hdoyln8lQfC+S+gIxQbClQdS8XJbEZyb70V
 phmmoz2mHIRyS8Dq/UOmYUAsz2nfUhf5qLJkRRBnNSLuEH+BL41/+Dqq4cZSyexg/YYGIdZS1at
 fQFW4QjOm00Ty1KF+dir+axeN2008/0KysWDG42W3n1Px5IQRB3eHMZAVVuH0/8qQviFxvwN6WQ
 Gon9lPzJjIFVFk2knCVCd1bp+J96CnbidiggWUd74hadsOdfWRbsw8J9OxRv+qFIFT2PrbhwGd9
 Ou0jIvGeJF/hlSuLHGT7AcfBCbxksa0jeGQxK1sGAH4qS5NzLkeU+KaqsqjEDSc3lH4KaGBG7IK
 miqIxUWbNRyS3aH/ITlumz40zLVhE4JTChq3/OaXlcCWPQLM=
X-Received: by 2002:a05:7022:b058:20b0:130:7246:10aa with SMTP id
 a92af1059eb24-1450404d324mr3148957c88.12.1790301290714; 
 Thu, 24 Sep 2026 18:54:50 -0700 (PDT)
X-Received: by 2002:a05:7022:b058:20b0:130:7246:10aa with SMTP id
 a92af1059eb24-1450404d324mr3148922c88.12.1790301289180; 
 Thu, 24 Sep 2026 18:54:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/40] Hexagon (target/hexagon) Check for sreg multiwrite in
 analyze_packet
Date: Thu, 24 Sep 2026 18:53:58 -0700
Message-Id: <20260925015429.2579174-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: grjTOOS5A0x4NQHQrFG-dR3q2oM9yeDT
X-Proofpoint-ORIG-GUID: grjTOOS5A0x4NQHQrFG-dR3q2oM9yeDT
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5d46c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WlL1PF4r9FF6NL-e66oA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX7nCmvZfwd9un
 V98LGk0OJkDr8bs7/l9XJ7NzXknOzN/ljSybzaxdRjl1xDs6OGgpDLN6gRERuXZIqsYUN295QpQ
 +7MEsx+zFjF0qS3u7HmsavcTZtlssicpY0AfAJu3TWQQxxbTqDmyauUiQ+b8p9PB/4qHrn6Xhm7
 n1ib30c6IaX6aHaLuIybYz5dpk3dar+0+qa2yR6FrrLoGU27WmmiZwglFO/T7lUSOG56qwyDydX
 zGTtROeLfgpy590tuaqhEk36UexoaSNQA9e1B+ly0Uea/XCo1YaCSqJGOyGG1Daroo+aszCKsIj
 TbAMsE9xAIkN7jwNnV6uYzLvzDtDxUe33DxvEuH7abuoDU+u2Hx5wn0hJazhhRpjK+2NBCdxt3q
 GVlo/GIznjJsF5lZmYIexy8H92iZRG8336UeFGfLu7G1t8bY9L4RaT7lUsFhDRvk8zxXIQVhGWW
 gRzek/aj886gV/HTI3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX1c3F5sd65asQ
 CuJc3JKAauaIYgVvymx9Svgzy34M1LH0HdQEo4riCWqEW1zt47kVSOhiAHIv910kz5wKgLrszBd
 FIzgUfVyHOqLGDcYVKSKUJtWC5b8fqU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmggfCAxMSArKysrKysrKystLQogdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMgfCAgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBi
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IGViMGQxMGQ2ODZjLi5iOTBmN2ZmZjFj
MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKKysrIGIvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmgKQEAgLTUxLDYgKzUxLDggQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXND
b250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChncmVnc19tdWx0aV93cml0ZSwgTlVNX0dSRUdT
KTsKICAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklURVNfTUFYXTsKICAgICBpbnQgc3JlZ19sb2df
aWR4OworICAgIERFQ0xBUkVfQklUTUFQKHNyZWdzX3dyaXR0ZW4sIE5VTV9TUkVHUyk7CisgICAg
REVDTEFSRV9CSVRNQVAoc3JlZ3NfbXVsdGlfd3JpdGUsIE5VTV9TUkVHUyk7CiAgICAgVENHdl9p
MzIgdF9zcmVnX25ld192YWx1ZVtIRVhfU1JFR19HTEJfU1RBUlRdOwogICAgIFRDR3ZfaTMyIGdy
ZWdfbmV3X3ZhbHVlW05VTV9HUkVHU107CiAjZW5kaWYKQEAgLTEyNSw4ICsxMjcsMTMgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4
LCBpbnQgcm51bSkKIAogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZShEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJudW0pCiB7Ci0gICAgY3R4LT5zcmVnX2xvZ1tjdHgtPnNyZWdf
bG9nX2lkeF0gPSBybnVtOwotICAgIGN0eC0+c3JlZ19sb2dfaWR4Kys7CisgICAgaWYgKCF0ZXN0
X2JpdChybnVtLCBjdHgtPnNyZWdzX3dyaXR0ZW4pKSB7CisgICAgICAgIHNldF9iaXQocm51bSwg
Y3R4LT5zcmVnc193cml0dGVuKTsKKyAgICAgICAgY3R4LT5zcmVnX2xvZ1tjdHgtPnNyZWdfbG9n
X2lkeF0gPSBybnVtOworICAgICAgICBjdHgtPnNyZWdfbG9nX2lkeCsrOworICAgIH0gZWxzZSB7
CisgICAgICAgIHNldF9iaXQocm51bSwgY3R4LT5zcmVnc19tdWx0aV93cml0ZSk7CisgICAgfQog
fQogCiBzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19zcmVnX3dyaXRlX3BhaXIoRGlzYXNDb250
ZXh0ICpjdHgsIGludCBybnVtKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCBiY2M0YTZlNmVmZi4uODFmODg5
NWU0N2IgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC01ODAsNiArNTgwLDggQEAgc3RhdGljIHZvaWQgY2xl
YXJfcGt0X2N0eChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBiaXRtYXBfemVybyhjdHgtPmdyZWdz
X3dyaXR0ZW4sIE5VTV9HUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5ncmVnc19tdWx0aV93
cml0ZSwgTlVNX0dSRUdTKTsKICAgICBjdHgtPnNyZWdfbG9nX2lkeCA9IDA7CisgICAgYml0bWFw
X3plcm8oY3R4LT5zcmVnc193cml0dGVuLCBOVU1fU1JFR1MpOworICAgIGJpdG1hcF96ZXJvKGN0
eC0+c3JlZ3NfbXVsdGlfd3JpdGUsIE5VTV9TUkVHUyk7CiAjZW5kaWYKICAgICBiaXRtYXBfemVy
byhjdHgtPmdwcl9tdWx0aV93cml0ZSwgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKTsKICAgICBiaXRt
YXBfemVybyhjdHgtPmdwcl91bmNvbmQsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CkBAIC02Mzcs
NiArNjM5LDEwIEBAIHN0YXRpYyBib29sIHBrdF9oYXNfd3JpdGVfY29uZmxpY3QoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgaWYgKCFiaXRtYXBfZW1wdHkoY3R4LT5ncmVnc19tdWx0aV93cml0ZSwg
TlVNX0dSRUdTKSkgewogICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICB9CisKKyAgICBpZiAoIWJp
dG1hcF9lbXB0eShjdHgtPnNyZWdzX211bHRpX3dyaXRlLCBOVU1fU1JFR1MpKSB7CisgICAgICAg
IHJldHVybiB0cnVlOworICAgIH0KICNlbmRpZgogCiAgICAgcmV0dXJuIGZhbHNlOwotLSAKMi4z
NC4xCgo=

