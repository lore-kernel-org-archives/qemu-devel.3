Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273EEEE0AF3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 18:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vomi9-0001Vf-PW; Sat, 07 Feb 2026 13:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhz-0001TZ-R2
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhr-0005LY-Cv
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:01 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6174chvk1050589
 for <qemu-devel@nongnu.org>; Sat, 7 Feb 2026 18:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SGn9Dx9TKhYwyyq6cn6DSMXoUDg7D4YZd5UT23z4be8=; b=UPzu8Q3wpDgI26vz
 zbO24C9sDc4Gd+imdiPebjMx0n3khGuvoT1UkYo6y6jbMsL14bRgmuUgZA7JhS2L
 nyEcJqroAvDyWE1vMSyopde+tl6rUH+mmqOc9qe8inbHkc/+30wIdoVl4+nqB8R/
 a9+bUbjtKhiR0J67JqcHM6Cp7/g0YldotKxwVcFe7I4vcEtX2eEK99PK/1fiFU8w
 ch71oqq1wig0ss2TrI1+o0o6bW8wYbN5dFpCzIRgblGnpDQ6r4NsBjPZLShR6T09
 Uay9/hpebcylmTMXilb/4f0TiS+8m40sAKUbKtO44SzY6DY2fYW16CW6oRw5mpd1
 XDQI8Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xj1938u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 18:06:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b708fa4093so9415553eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770487613; x=1771092413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGn9Dx9TKhYwyyq6cn6DSMXoUDg7D4YZd5UT23z4be8=;
 b=g2iSfc1hWoVUCm+D7qiNk++SkQQOFK7v9Ql2LX8vT3tVIQL40M7jh19Xcw8KFpleVR
 borkWYzOikd6HeuhQtJnTbVeLAerGFM/OMRqZDHm1ydhEFx9yDK0Yt2CxA14jkuNKAHX
 e8keYbGillc/71mAlJgkRkwqV1MkIH+BwHaU6UscJdcJvfm0M3+b16/pNusfCsceYqmM
 92rrvaQXAeaR5Z6qut8PQG+9FdrQF5j0NVGUG+WuiHh6D/3HNxLhH87S8XQyPX2JyZ9X
 hpEUpEr3cjuPpAwpW3il41xvS7oz9PvtMnpVWu8/YFk3u75ZN57FkB77+lXXpKKb0ZNE
 46DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770487613; x=1771092413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SGn9Dx9TKhYwyyq6cn6DSMXoUDg7D4YZd5UT23z4be8=;
 b=ivJDVSu/TEITVUolk5D3KVMWr4GvQuu/PEco1/HwWBec6p63UyxYxzLwK0JFnrjeia
 sp3SLVMdejOEMGa5H/JmHTsMPgSSrm2XWsMsql8incsLNsLdba5yTZhmqC/d2NNcpOBC
 +5tjm0gYpei+VdDMQXsXAQHmLjArUU4oDR9HUP9q9OsTn9nm1vaWZXQvlFLuhFPtNsWx
 WtE4bkmMhYY/do0cXnqWsxFvfKm14gCmoLcdjaelCOwlKILBP4OPWX2X/nhZcLgaKMkN
 dlXW6bOL1jvemVguz0nvvviHsCxgi6VyFPIHYZyL28ZHByR/p3CgfBkZ5ZdFYv6oJAYo
 U7nA==
X-Gm-Message-State: AOJu0YyCJnbVHQE+Wsk05SO4KfD1i3cUOkOxSRpnm888g5+jjsHfF0wq
 siAmM6aRPLI2RvVyWqWL0Q8qmjxvAFcZUdZowfeeop9seX5QYfBW5BKA4mj5X8nnEbDfIhZX4cf
 QVkYtEjNHmp3031s771rSYkvg60PnsmZz2g4X0CwokEcP7SNSf96p1DF4GdKxk1/tjw==
X-Gm-Gg: AZuq6aLMi0xp69EGnzN0zc4F/++lLDJFxE/bCZQkWUCmfVyGiEQlzhJeqIj7hk4gwpG
 78vOSg4G3GAhwpBufDbYl5aaOy0wdmFJF2eeXVPTa8fqW47fCr7N666myzObfuiLbEiROo5sSYG
 dE2rRUstYvoWnFKBJSA1JsCPj59FnnJyyiZ/aLVX+YyQCeGRQheGF3MsWem8tOq2oXx6bvKzAxS
 toSooN494katJXO504d8Us7yovQ3Rop0OI8Wtc4bwmNAhRFUI96x4f/O8VjcZODtgPpL7CGfnvI
 mbj7kJu3OPeWVlZ/6QHd6QySpUfpVBiKoCQ5OO4Llt3disyNUlsTwz+CNRmiLJiiy9Qz1gMhI2d
 ubgMCutu4dtgL63erKAeQfZ/8UzGyHJ9TRLxhnqh1NzwOk+xRJ9XQTG3jqA==
X-Received: by 2002:a05:7300:e82c:b0:2b8:26b8:3420 with SMTP id
 5a478bee46e88-2b85646dfcfmr2996063eec.5.1770487612610; 
 Sat, 07 Feb 2026 10:06:52 -0800 (PST)
X-Received: by 2002:a05:7300:e82c:b0:2b8:26b8:3420 with SMTP id
 5a478bee46e88-2b85646dfcfmr2996054eec.5.1770487612112; 
 Sat, 07 Feb 2026 10:06:52 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c63152sm4002328eec.25.2026.02.07.10.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 10:06:51 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/4] target/hexagon: Return decode failure for invalid
 non-duplex encodings
Date: Sat,  7 Feb 2026 10:06:31 -0800
Message-Id: <20260207180632.1042754-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Z-wkv2KEKX0WKULyRiwCpPmh3EaKlWbA
X-Proofpoint-ORIG-GUID: Z-wkv2KEKX0WKULyRiwCpPmh3EaKlWbA
X-Authority-Analysis: v=2.4 cv=F/tat6hN c=1 sm=1 tr=0 ts=69877f3d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=D67r-eMCZ0zeLs--bqkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDE0OSBTYWx0ZWRfX6lgXRZnCwhgS
 kBmPD4GgCl8LumA7McuVW4f9LMD6BQoxSgG4bvYn25KyjzV2U3cvFjo/YYSiwaaaktztnlXOo/m
 sYzr+P7t2Q+t+H1Hh4lTr7Vvqxm6Fm3IuuvoYXt7CsyMwAjiVxNu/fnt+xt4WM6DrnVdiTCHKZ+
 P2dK5KY0r3w3qY35DCLqYhU7JQEYsNh3xN6/CDT4AKuk/4C0zTv311viQhCixQVjjgBgYO2saif
 wMP60j6g9xsKj9zuRdk8uiZvjukXxg1B+NMjjNgp2W58dHKSJljeLjf8TGJHJEet4nV1XfPPfN3
 P3ufz/TBwunoVJEbgQD2kXrseg5E7bCaE+LLyIA4tbKnG3/m40sw3hgrww4+4bDKNgp29Wu52Ma
 rqwQ/oumy8HxjQs2Lj6aLqItT6uRyyCv2UeZC9F3p7qG5v6DkaqJDNVI2RR5m1Fe1Gr+S5TL4YK
 +u1ACELAoUCFksRer1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602070149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

V2hlbiBhIG5vbi1kdXBsZXggZW5jb2RpbmcgKHBhcnNlX2JpdHMgIT0gMCkgZmFpbHMgYm90aCBk
ZWNvZGVfbm9ybWFsKCkKYW5kIGRlY29kZV9odngoKSwgdGhlIGRlY29kZXIgaGl0IGFuIHVucmVh
Y2hhYmxlLiAgSW5zdGVhZCwgaGFuZGxlCnRoZSBkZWNvZGUgZmFpbHVyZSBhbmQgcmFpc2UgYW4g
ZXhjZXB0aW9uLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPgotLS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgICB8
ICAzICsrLQogdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jIHwgMjUgKysrKysr
KysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJn
ZXQvaGV4YWdvbi9kZWNvZGUuYwppbmRleCA5MDQ5OWZjMzIwLi5lYmI0ZTAyYTE3IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUu
YwpAQCAtNDg5LDcgKzQ4OSw4IEBAIGRlY29kZV9pbnNucyhEaXNhc0NvbnRleHQgKmN0eCwgSW5z
biAqaW5zbiwgdWludDMyX3QgZW5jb2RpbmcpCiAgICAgICAgICAgICBpbnNuLT5pY2xhc3MgPSBp
Y2xhc3NfYml0cyhlbmNvZGluZyk7CiAgICAgICAgICAgICByZXR1cm4gMTsKICAgICAgICAgfQot
ICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgICAgICAvKiBJbnZhbGlkIG5vbi1k
dXBsZXggZW5jb2RpbmcgKi8KKyAgICAgICAgcmV0dXJuIDA7CiAgICAgfSBlbHNlIHsKICAgICAg
ICAgdWludDMyX3QgaWNsYXNzID0gZ2V0X2R1cGxleF9pY2xhc3MoZW5jb2RpbmcpOwogICAgICAg
ICB1bnNpZ25lZCBpbnQgc2xvdDBfc3ViaW5zbiA9IGdldF9zbG90MF9zdWJpbnNuKGVuY29kaW5n
KTsKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyBiL3Rl
c3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYwppbmRleCAxYmJkMzEyYjYxLi4wNDBh
N2Q5MTQ3IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMK
KysrIGIvdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jCkBAIC05Myw2ICs5Mywz
MCBAQCBzdGF0aWMgaW50IHRlc3RfaW52YWxpZF9kdXBzKHZvaWQpCiAgICAgcmV0dXJuIHNpZzsK
IH0KIAorLyoKKyAqIEludmFsaWQgbm9uLWR1cGxleCBlbmNvZGluZzoKKyAqIFRoZSBlbmNvZGlu
ZyAweGZmZmZjMDAwIGhhcyBwYXJzZSBiaXRzIFsxNToxNF0gPSAwYjExLCBtYWtpbmcgaXQgYQor
ICogbm9uLWR1cGxleCBpbnN0cnVjdGlvbiBhbmQgcGFja2V0IGVuZC4gIFRoZSByZW1haW5pbmcg
Yml0cyBkbyBub3QgbWF0Y2gKKyAqIGFueSB2YWxpZCBub3JtYWwgb3IgSFZYIGluc3RydWN0aW9u
IGVuY29kaW5nLCBzbyB0aGlzIHNob3VsZCByYWlzZSBTSUdJTEwuCisgKi8KK3N0YXRpYyBpbnQg
dGVzdF9pbnZhbGlkX25vbmR1cGxleCh2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBhc20g
dm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIKKyAg
ICAgICAgIm1lbXcoJTEpID0gcjFcbiIKKyAgICAgICAgIi53b3JkIDB4ZmZmZmMwMDBcbiIKKyAg
ICAgICAgIjE6XG4iCisgICAgICAgICIlMCA9IHIwXG4iCisgICAgICAgIDogIj1yIihzaWcpCisg
ICAgICAgIDogInIiKCZyZXN1bWVfcGMpCisgICAgICAgIDogInIwIiwgInIxIiwgIm1lbW9yeSIp
OworCisgICAgcmV0dXJuIHNpZzsKK30KKwogaW50IG1haW4oKQogewogICAgIHN0cnVjdCBzaWdh
Y3Rpb24gYWN0OwpAQCAtMTA0LDYgKzEyOCw3IEBAIGludCBtYWluKCkKIAogICAgIGFzc2VydCh0
ZXN0X2ludmFsaWRfZHVwbGV4KCkgPT0gU0lHSUxMKTsKICAgICBhc3NlcnQodGVzdF9pbnZhbGlk
X2R1cHMoKSA9PSBTSUdJTEwpOworICAgIGFzc2VydCh0ZXN0X2ludmFsaWRfbm9uZHVwbGV4KCkg
PT0gU0lHSUxMKTsKIAogICAgIHB1dHMoIlBBU1MiKTsKICAgICByZXR1cm4gRVhJVF9TVUNDRVNT
OwotLSAKMi4zNC4xCgo=

