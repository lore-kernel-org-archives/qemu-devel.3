Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4F3CA6002
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEc8S-0004cf-5l; Wed, 07 Oct 2026 20:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8O-0004cB-97
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8M-00080N-Nm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:20 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtQV34151676
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1fYxCdPlsVoy0ua9lCJU64oESTcVOsWTJDaSLomtAaE=; b=CPa9icX+/JR0xagt
 F+/xYdbeD/ByfIfEHERfaYAFl+VtG8QwyImF+3xVJmFhWfI4tdf/x1fwo98wkTxi
 DO1C5GLZ19cNahfJ1ZRYXz4TG2HQmDYn3y5D/hIsW7kNEm6thbzwglC1whKoezir
 TAaTjQyTePaC1bCrqD66u9yAvdXEY6rVRFMAu5AJMfNgOkTpuaibJehEnSyUt2F/
 cY0w6yEZAlpOARkZ+JKWDbQkP+V697f5plsUNSwwlsy8UBnGYLHj7oAFQIOhjbkj
 3CLGUfwK9EdP7PnM7JXwBokMaqj5wxG24IZ95MNBqRraIIA23px9R/4uSB2CU4EI
 aorhsA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe38d2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:37:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34e676375d9so4759853eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791419836; x=1792024636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1fYxCdPlsVoy0ua9lCJU64oESTcVOsWTJDaSLomtAaE=;
 b=Ijp7C+YV1u1U+Bteh96WpWi0AuG9uow/j09KvnbJd5r3RDywZWK17Nqi++rXNTLekw
 NHzvnX0QrhIucaU0NpBsEF3tJ8VJ5tf9eiOtv2VtYoQwm1KR2eSUpkrohWMpZlWSlCEV
 05BgRdaPGecrXmFSFEQOJ90RSV0gf72eEifeLtBdpFAur+ykkWIUlj3IjK0k6mKkat4Q
 pgFI4iY4p0t+t0f9ZIhe855Jv4Lpc5W9f5KknmCcUw3pAK2iAWGVerFROKXhGC7KOsnx
 DDCHkswUb+N4DqUiGb0OlCIlnpASFt6qWw3RBCKn8y2nnrLmHh3wmtMetUiW5cwhRNvn
 Hhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791419836; x=1792024636;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1fYxCdPlsVoy0ua9lCJU64oESTcVOsWTJDaSLomtAaE=;
 b=KZ5RdS0OAHEMX+YlgFwqetSEhG9CDGX+KTIEwOikbIvDaday9ght35N9HeGj1keacG
 p0gcwTl1DDBfy8NDcSbYt2Q2tPo8Zz8MJdkTexx8TVsP3J1cUDjyp5Prn6ji487KnapH
 iVzJNf02LEDLGAwQ6eT6hx05TRWBptpLwCuw1FgKyDtp/nBzxhaAC2cenl99CrrSWuPa
 qcnQTQJK5I2hN8AHR+++1DkSReopnolb0QTaa1+1kh/gAz4LC92kRcCTKD95zqTZ+weK
 yulUjUUH33THO7/UoRXxyiLjOF/RO+YrVuYQepTUMR7n+LcF1tMRI+fZy9eGb4KMyZER
 +Y6A==
X-Gm-Message-State: AFuF++me+J9fOif/p1zFBWw1vNr3LS6c0SxfxnIwb6wjfAz1Q3jkF2sa
 xgqzeTL/AkVdMGWb9X11IjPVYEss7iflQcZSSshyLNM/yY5wwUMiBXgV4PwLtUdNIbl3/nxHs9y
 qO+EifDljh/a3l6AtaFNOW8+moylnrpBhAUsI4Lk++KRpT/x6DYKxPvgYmNhRosoyaA==
X-Gm-Gg: AYBFou0pbRwL68c48XaIjX1qim7RIHjyk8ymuy4DjiWmLgJ2KPCyovy65tmwRZa1Xij
 cEFiZekNeBujZ5DZAndA1WS8h5A33EIJUsv016VwA/uw1UZ5Ds14IXRcXIOHedOm6+Alhq28AH5
 5MjH/AZnetKJrgC1TYqZfiq0bm5ywLI7hbvvKj5GPioX3DgfIWSD0wK6w3Ge2YByiN1daUq7iTb
 YeMnKFw/pN6xCH59oIBXvIp4KyVWOrzWwlKUWRT7dT5RKeSHxBHMYV5KVDcCB6weKVPwUTiBomF
 syNfifl1Pd5fvWZoJw8t7u0P/fGzFI0HZE69C8PB/RcvByB6BB+zUB/KpFvlvUM//Qlz75y7sAz
 JT6AF3gjtZ2ZUZvmTys5ff8HC9V5kCuy56J8RGbSoeJXX9is=
X-Received: by 2002:a05:7022:f108:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-165a33fab34mr897068c88.20.1791419835658; 
 Wed, 07 Oct 2026 17:37:15 -0700 (PDT)
X-Received: by 2002:a05:7022:f108:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-165a33fab34mr897033c88.20.1791419834966; 
 Wed, 07 Oct 2026 17:37:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm4380048c88.7.2026.10.07.17.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 17:37:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 01/12] target/hexagon: derive HVX storage sizes from types
Date: Wed,  7 Oct 2026 17:37:00 -0700
Message-Id: <20261008003711.3984454-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: PKpnDd274F8iU5-BBaxWlGV39L4pkgII
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac6e5bc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=OyJAZBVBAfdT-SukITkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX5EEH3pCJz9ZA
 SIJ6jAsS+zaVNLB5SqWSvOWcMGFDndSZ0JDM8ZoBkmXqKK8Y/Yg/odNf8kGOvVjTckSw4bdBpqW
 1iTeftZ/yvtb/+TUbX1Lffb0HrEqDqs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX5KDLA8nVvO06
 nnT8uU3a2hri3biHhyyQu61rtyo2vqOaZ1zmVHxtcwRHH4Ql4bf3j3bgdulb+ujbendMKakatvQ
 CMMj8t4sil5k1x+rsubTZ4864684pJ7I7vS6izuhVXLf459kHSv5mU3X+PY1u0R1LmLcNgTlfkd
 AkUuVGrsp3u1IPdlIC5I59q8Vh27wFZR73Qwnqb2/lYVFdh+W2bWVwUIPLaUZd+2qHYewP3Q/yT
 7PnbH8/9Zx1Xa/U+s/eGC4Zn33Ta9Knna0sUAY4ED6xOhdLiZszn3A+yfFGJxQPS5DYiRC+nwDI
 T9sZ5mK/TFI7u8etL0ckyShFrZp5AubMbqaqJSLyWEXwUVlVsFd/tQLgSAlN/f30Fq7hdsuMyjA
 mxk3SJITehgq8GTeb2RyTrlUmTxwEyZXPhW6qwHpEkEuNuyCkDChOwd2WXSR40jVw6Ve8xfzm8W
 cHphcKNB26eJXFvT/sQ==
X-Proofpoint-ORIG-GUID: PKpnDd274F8iU5-BBaxWlGV39L4pkgII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080001
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

VXNlIHNpemVvZl9maWVsZChNTVZlY3RvciwgdWIpIGZvciB2ZWN0b3ItcGF5bG9hZCBzdG9yYWdl
IGFuZCBzaXplb2YoTU1RUmVnKQpmb3IgcHJlZGljYXRlIHN0b3JhZ2UuICBUaGlzIG1ha2VzIHRo
ZSBpbnRlbnQgY2xlYXJlciBhbmQgYmluZHMgdG8gdGhlIGZpZWxkCmluc3RlYWQgb2YgYSBtYXgt
c2l6ZSBjb25zdGFudC4KCkluIHBhcnRpY3VsYXIsIHRoZXNlIGJvdW5kcyBleGNsdWRlIE1NVmVj
dG9yLmV4dCwgdGhlIFFGbG9hdCBleHRlbmRlZC1wcmVjaXNpb24KYml0cy4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9jcHUuaCAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL21tdmVjL21tdmVj
LmggfCAgNCArKy0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgIHwgMTIgKysrKysrLS0t
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgICAgIHwgIDQgKystLQogNCBmaWxlcyBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGRmNGMwMTgyMjQ3
Li5lMjVhYzY5Mzc2NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTEwMyw3ICsxMDMsNyBAQCB0eXBlZGVmIHN0cnVjdCB7CiB0
eXBlZGVmIHN0cnVjdCB7CiAgICAgdGFyZ2V0X3Vsb25nIHZhOwogICAgIGludCBzaXplOwotICAg
IERFQ0xBUkVfQklUTUFQKG1hc2ssIE1BWF9WRUNfU0laRV9CWVRFUykgUUVNVV9BTElHTkVEKDE2
KTsKKyAgICBERUNMQVJFX0JJVE1BUChtYXNrLCBzaXplb2ZfZmllbGQoTU1WZWN0b3IsIHViKSkg
UUVNVV9BTElHTkVEKDE2KTsKICAgICBNTVZlY3RvciBkYXRhIFFFTVVfQUxJR05FRCgxNik7CiB9
IFZTdG9yZUxvZzsKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvbW12ZWMuaCBi
L3RhcmdldC9oZXhhZ29uL21tdmVjL21tdmVjLmgKaW5kZXggNjYyZjlkMTU5N2UuLjI4ZjMyMjRj
ZmZiIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9tbXZlYy5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL21tdmVjL21tdmVjLmgKQEAgLTg5LDggKzg5LDggQEAgc3RhdGljIGlubGluZSB1
aW50OF90IGhleGFnb25fbW1xcmVnX2dldF9ieXRlKGNvbnN0IE1NUVJlZyAqcSwgc2l6ZV90IGlu
ZGV4KQogCiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgTU1WZWN0b3IgZGF0YTsKLSAgICBERUNMQVJF
X0JJVE1BUChtYXNrLCBNQVhfVkVDX1NJWkVfQllURVMpOwotICAgIHRhcmdldF91bG9uZyB2YVtN
QVhfVkVDX1NJWkVfQllURVNdOworICAgIERFQ0xBUkVfQklUTUFQKG1hc2ssIHNpemVvZl9maWVs
ZChNTVZlY3RvciwgdWIpKTsKKyAgICB0YXJnZXRfdWxvbmcgdmFbc2l6ZW9mX2ZpZWxkKE1NVmVj
dG9yLCB1YildOwogICAgIGJvb2wgb3A7CiAgICAgaW50IG9wX3NpemU7CiB9IFZUQ01TdG9yZUxv
ZzsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1
LmMKaW5kZXggMWY3ZDhhOGRmNzAuLmQ4MDg1ZGI0NzU2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMTkxLDcgKzE5MSw3IEBA
IHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRlICplbnYsIGlu
dCByZWdudW0sCiB7CiAgICAgaWYgKHNraXBfaWZfemVybykgewogICAgICAgICBib29sIG5vbnpl
cm9fZm91bmQgPSBmYWxzZTsKLSAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJ
WkVfQllURVM7IGkrKykgeworICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IHNpemVvZl9maWVs
ZChNTVZlY3RvciwgdWIpOyBpKyspIHsKICAgICAgICAgICAgIGlmIChoZXhhZ29uX21tdmVjX2dl
dF9ieXRlKCZoZXhfaHZ4KGVudiktPlZSZWdzW3JlZ251bV0sIGkpICE9IDApIHsKICAgICAgICAg
ICAgICAgICBub256ZXJvX2ZvdW5kID0gdHJ1ZTsKICAgICAgICAgICAgICAgICBicmVhazsKQEAg
LTIwNSw4ICsyMDUsOCBAQCBzdGF0aWMgdm9pZCBwcmludF92cmVnKEZJTEUgKmYsIENQVUhleGFn
b25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtLAogICAgIHFlbXVfZnByaW50ZihmLCAiICB2JWQgPSAo
ICIsIHJlZ251bSk7CiAgICAgcWVtdV9mcHJpbnRmKGYsICIweCUwMngiLAogICAgICAgICAgICAg
ICAgICBoZXhhZ29uX21tdmVjX2dldF9ieXRlKCZoZXhfaHZ4KGVudiktPlZSZWdzW3JlZ251bV0s
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFYX1ZFQ19TSVpFX0JZ
VEVTIC0gMSkpOwotICAgIGZvciAoaW50IGkgPSBNQVhfVkVDX1NJWkVfQllURVMgLSAyOyBpID49
IDA7IGktLSkgeworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVv
Zl9maWVsZChNTVZlY3RvciwgdWIpIC0gMSkpOworICAgIGZvciAoaW50IGkgPSBzaXplb2ZfZmll
bGQoTU1WZWN0b3IsIHViKSAtIDI7IGkgPj0gMDsgaS0tKSB7CiAgICAgICAgIHFlbXVfZnByaW50
ZihmLCAiLCAweCUwMngiLAogICAgICAgICAgICAgICAgICAgICAgaGV4YWdvbl9tbXZlY19nZXRf
Ynl0ZSgmaGV4X2h2eChlbnYpLT5WUmVnc1tyZWdudW1dLCBpKSk7CiAgICAgfQpAQCAtMjIzLDcg
KzIyMyw3IEBAIHN0YXRpYyB2b2lkIHByaW50X3FyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0sCiB7CiAgICAgaWYgKHNraXBfaWZfemVybykgewogICAgICAgICBi
b29sIG5vbnplcm9fZm91bmQgPSBmYWxzZTsKLSAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBN
QVhfVkVDX1NJWkVfQllURVMgLyA4OyBpKyspIHsKKyAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkg
PCBzaXplb2YoTU1RUmVnKTsgaSsrKSB7CiAgICAgICAgICAgICBpZiAoaGV4YWdvbl9tbXFyZWdf
Z2V0X2J5dGUoJmhleF9odngoZW52KS0+UVJlZ3NbcmVnbnVtXSwgaSkgIT0gMCkgewogICAgICAg
ICAgICAgICAgIG5vbnplcm9fZm91bmQgPSB0cnVlOwogICAgICAgICAgICAgICAgIGJyZWFrOwpA
QCAtMjM3LDggKzIzNyw4IEBAIHN0YXRpYyB2b2lkIHByaW50X3FyZWcoRklMRSAqZiwgQ1BVSGV4
YWdvblN0YXRlICplbnYsIGludCByZWdudW0sCiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIHElZCA9
ICggIiwgcmVnbnVtKTsKICAgICBxZW11X2ZwcmludGYoZiwgIjB4JTAyeCIsCiAgICAgICAgICAg
ICAgICAgIGhleGFnb25fbW1xcmVnX2dldF9ieXRlKCZoZXhfaHZ4KGVudiktPlFSZWdzW3JlZ251
bV0sCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BWF9WRUNfU0la
RV9CWVRFUyAvIDggLSAxKSk7Ci0gICAgZm9yIChpbnQgaSA9IE1BWF9WRUNfU0laRV9CWVRFUyAv
IDggLSAyOyBpID49IDA7IGktLSkgeworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2YoTU1RUmVnKSAtIDEpKTsKKyAgICBmb3IgKGludCBpID0gc2l6ZW9mKE1N
UVJlZykgLSAyOyBpID49IDA7IGktLSkgewogICAgICAgICBxZW11X2ZwcmludGYoZiwgIiwgMHgl
MDJ4IiwKICAgICAgICAgICAgICAgICAgICAgIGhleGFnb25fbW1xcmVnX2dldF9ieXRlKCZoZXhf
aHZ4KGVudiktPlFSZWdzW3JlZ251bV0sIGkpKTsKICAgICB9CmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9nZGJzdHViLmMgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKaW5kZXggNzZhYjUy
MzVmNmUuLjVmYWM2MmI1YjA5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jCkBAIC0xMjAsNyArMTIwLDcgQEAgc3RhdGlj
IGludCBnZGJfcHV0X3ZyZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQ4X3QgKm1lbV9idWYs
IGludCBuKQogICAgICAgICBoZXhfaHZ4KGVudiktPlZSZWdzW25dLnV3W2ldID0gbGRsX2xlX3Ao
bWVtX2J1Zik7CiAgICAgICAgIG1lbV9idWYgKz0gNDsKICAgICB9Ci0gICAgcmV0dXJuIE1BWF9W
RUNfU0laRV9CWVRFUzsKKyAgICByZXR1cm4gc2l6ZW9mX2ZpZWxkKE1NVmVjdG9yLCB1Yik7CiB9
CiAKIHN0YXRpYyBpbnQgZ2RiX3B1dF9xcmVnKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50OF90
ICptZW1fYnVmLCBpbnQgbikKQEAgLTEzMCw3ICsxMzAsNyBAQCBzdGF0aWMgaW50IGdkYl9wdXRf
cXJlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDhfdCAqbWVtX2J1ZiwgaW50IG4pCiAgICAg
ICAgIGhleF9odngoZW52KS0+UVJlZ3Nbbl0udXdbaV0gPSBsZGxfbGVfcChtZW1fYnVmKTsKICAg
ICAgICAgbWVtX2J1ZiArPSA0OwogICAgIH0KLSAgICByZXR1cm4gTUFYX1ZFQ19TSVpFX0JZVEVT
IC8gODsKKyAgICByZXR1cm4gc2l6ZW9mKE1NUVJlZyk7CiB9CiAKIGludCBoZXhhZ29uX2h2eF9n
ZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikK
LS0gCjIuMzQuMQoK

