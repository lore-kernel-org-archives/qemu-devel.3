Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C33CC98326
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9O-0004xb-PG; Thu, 24 Sep 2026 21:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9G-0004vC-98
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9D-0005s3-Sf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kval3884170
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9JK1eSMDJSgcWmEjXfRCOnbStWrh/IS/L6ofvpcsDwM=; b=QWqvgQXahnGYA2IX
 0FmbzcCcDsbOloC0GXODH9fq3M8ou/MyX3CF5kc1IcSuQYrgt4XVI8E2rkZPRkTe
 R04+fSC0U4TKvWapEc6Yrt1AshPgBYtV3FuC9XbqEbCBBHI/s0UOxkFnMk33WL4r
 tVcv24oKx+veSVCpbcHZhZWc9cBBdH+7KQwGf7iLNUe4PKJr0Er5A1sk8RzoRP8o
 NbTbp07L+qSqWqqvetKHAC007/15gQfGSIggH8wgFrAe+japHkYRnJ8xgrfiLAp/
 M1eXdNSFc4Dvn5VgHNQqVYAE9iSfdEWp6YPaAccCSFZExyhIaJdsRMSGrBpMMGzq
 3dB2uA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4652s1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so1433658eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301283; x=1790906083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9JK1eSMDJSgcWmEjXfRCOnbStWrh/IS/L6ofvpcsDwM=;
 b=D38mvn12cVfwkAPUo9zstjp+4C0Z50BzwYiFmLgKMTS1/VEp36s6RlPA4KUrC305Gy
 sDcau6iHLDA1tVMCyAtdGhjdyHIqZlkoBYQrC+Y5433K8hmRzR28zjTJOXAeKr/omySQ
 2Yr0wzStGjhi7SiHCjAIipHFY+qS6hqcMAtZA9Z3ayqj4OEZZh1J64E4aBMDV/kmGAWC
 Kk+7hJeAHKqwawkb4EB7gyHYo4qEsalX4F+DUJBLidWbXnOkvrzzwqvgICpkBQI2paig
 67crR04ywN2BrY0Q/8gl9mfTYXfXLIN/T8lufU/lk0IIsSy7GtXkhJ9T35wYVU41T6D8
 hEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301283; x=1790906083;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9JK1eSMDJSgcWmEjXfRCOnbStWrh/IS/L6ofvpcsDwM=;
 b=SKEG4dZ/+Nudqm4zkEiTSrElSEQ/s9TGp/BVNZaIq3nAzsDPGe3kaCgtUzOviXdkVZ
 C8r0AOx3uLxbTNk+Md5Cx4Uv0IfgPCUXsINMi/loIVEbIkv/CzZXHOqdwhV7OFzpKW/9
 jJExxWMJnM1vOqWIkJlNfyLwbxDaLxjSdmx/z/LpUr/17iL/wWpp70DNFWw5N3th7TuT
 AJhZvz6ar26lVPL3yyFIhO0tK6IKme9a+TRadwTHJP9Xu5th7vKENoUrBtYmHiG/Pisp
 GOmH0tpwvFHtuM1qci/+GV9wmasOsC6DfPXcl5WXqrowiY+QuCjaAX8kvVpg4kQ2KXB1
 PFMQ==
X-Gm-Message-State: AFuF++kbB/bEPpr6aA6+b0dw8Hn5r6ZfITldSmgMAHFFyu7nO57o9qeG
 M648s531yM4z4htexXusSIJfLsBaXNvQ5xv0d5eIWq9ojZH9ZjK8fuFBPf8nAYRMNZN/cJ/g4nL
 OTACYYsQ9JmhlbDYEIWLLjf9Dv+u1oNfnCe5L7gYn+avyyoo19CBhchCCtJ93j0rUww==
X-Gm-Gg: AYBFou2HPSU+d2DwuN4ALP1twJ7CT/s5Rf2UPkif8qzfwz/oVWWxGaoQHgC4CrwluE5
 FqmwpDFX7DIdo17iecMazVv/OTE4tnFfKqppiRzIJ4smK9SmH50C5uth4RlL6Qv5iIEsYHzf5cY
 iTGQGdA9uHFpi9axYGA/86M6bydSnv7AfG8XKyAacaXE4OeiX4Lre6Mkz9533H+51qEBtx8ZTlZ
 /2Oi3dQKGXi/sT/2lcdY+Yr5UYY6KwGIJUxscsZWnFtrJ7uai2RZRBXev+BMfxH3hUKj5tKYIgy
 5FJY7z2UGw7oClUfS3yrvGb+11tsDF9/gpQuqK7IANuPY/UpP5WycjXY7LpMu06FCOrcrvMTDQH
 IQLjj6WcIqz7/xG1670OLr3EG583ZLdr20l35rziJRbDGgDA=
X-Received: by 2002:a05:7300:ec8f:b0:33c:e73:2337 with SMTP id
 5a478bee46e88-34002edf25emr3197596eec.26.1790301282453; 
 Thu, 24 Sep 2026 18:54:42 -0700 (PDT)
X-Received: by 2002:a05:7300:ec8f:b0:33c:e73:2337 with SMTP id
 5a478bee46e88-34002edf25emr3197566eec.26.1790301281792; 
 Thu, 24 Sep 2026 18:54:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 05/40] Hexagon (tests/tcg/hexagon) Add tests for vreg multiple
 writes
Date: Thu, 24 Sep 2026 18:53:54 -0700
Message-Id: <20260925015429.2579174-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab5d463 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=teolCTQGscwzjPTLZdYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: dd4rimYormdqY9BEeOoZRWvSLE2RyoWZ
X-Proofpoint-GUID: dd4rimYormdqY9BEeOoZRWvSLE2RyoWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX1Unc2G9jkO8I
 SeRlupuwzIh25CTlKtrRzm3AB+B9E00BARmggKpkaUGJ0qeqP+pKfAcUMs4cApKHVb+kMF7KyHH
 ABOqgxlrSIJQq3hCCBIOLsE+ss49uHxtuI8s5iAVO6KKUij8rlWQo9cNvykiqLGD74RWmrMrOay
 a59z0WOPw8qSPAX59B0pz4cz8oSedSHupfl1Le0CWmfgh23xNBx+RbW/7511hfbhU9oeujDlUPE
 DogxR5geCvoRzSZ6cb85J3jOkeJrWhZcjsIn1Uwh0TKWE17Z/IqdNK72SXA3a1ZfDHi2WReea/H
 oQ0h1AK18Wv40/Q1hE6rzCP3nreqSadxd/k0lm6cHr/NujYSrT026KHh4Xp7CwV2FYvtdwIBthn
 EfftV1h3iFDp3qFCF/BOHltHjAdGtQ1fIGZEJZElutS0p0/JJU83BDgWZRP1zVFSjULBMOOP/cb
 fUZNt+hdFKWtXZKyXEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXztoW7G5Y0g4g
 9K6hfZE3l2EMW4xUSWwW8o5ZIrB+TD9amL4HIwKDP22f0lWhoc2JM4U2+CMhzF4r/gfjVgeLPEF
 GiVU+29TKb12dQtD+HTW+lsVUVCfmYM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMv
dGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMgfCA2NiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgfCAgMiArLQogMiBm
aWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdHMvdGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMgYi90ZXN0cy90Y2cvaGV4YWdv
bi9tdWx0aXBsZS13cml0ZXMuYwppbmRleCA0MzA1OTAzNTQ3ZC4uNjJlNTgyOGEwYWYgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jCisrKyBiL3Rlc3RzL3Rj
Zy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jCkBAIC0xOTksNiArMTk5LDY4IEBAIHN0YXRpYyBp
bnQgdGVzdF9wb3N0X2luY3JlbWVudDModm9pZCkKICAgICByZXR1cm4gc2lnOwogfQogCitzdGF0
aWMgaW50IHRlc3RfdnJlZ19sZWdhbF9wcmVkaWNhdGVkKHZvaWQpCit7CisgICAgaW50IHNpZzsK
KworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIxID0g
IyMxZlxuIgorICAgICAgICAibWVtdyglMSkgPSByMVxuIgorICAgICAgICAicjIgPSAjN1xuIgor
ICAgICAgICAicjMgPSAjMTNcbiIKKyAgICAgICAgInAwID0gY21wLmVxKHIyLCByMylcbiIKKyAg
ICAgICAgIntcbiIKKyAgICAgICAgIiAgICBpZiAocDApIHYwID0gdjFcbiIKKyAgICAgICAgIiAg
ICBpZiAoIXAwKSB2MCA9IHYyXG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIxOlxuIgorICAg
ICAgICAiJTAgPSAjMjNcbiIKKyAgICAgICAgOiAiPXIiKHNpZykKKyAgICAgICAgOiAiciIoJnJl
c3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAicjIiLCAicjMiLCAicDAiLCAidjAiLCAi
djEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnOworfQorCitzdGF0aWMgaW50IHRlc3Rf
dnJlZ19pbGxlZ2FsX21peGVkKHZvaWQpCit7CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xh
dGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAg
ICAibWVtdyglMSkgPSByMVxuIgorICAgICAgICAiLndvcmQgMHgxYTAwNDEwMCAgICAvKiB7IGlm
IChwMCkgdjAgPSB2MSAqL1xuIgorICAgICAgICAiLndvcmQgMHgxZTAzZTJlMCAgICAvKiAgIHYw
ID0gdjIgIH0gKi9cbiIKKyAgICAgICAgIjE6XG4iCisgICAgICAgICIlMCA9IHIwXG4iCisgICAg
ICAgIDogIj1yIihzaWcpCisgICAgICAgIDogInIiKCZyZXN1bWVfcGMpCisgICAgICAgIDogInIw
IiwgInIxIiwgIm1lbW9yeSIpOworCisgICAgcmV0dXJuIHNpZzsKK30KKworc3RhdGljIGludCB0
ZXN0X3ZyZWdfaWxsZWdhbF91bmNvbmQodm9pZCkKK3sKKyAgICBpbnQgc2lnOworCisgICAgYXNt
IHZvbGF0aWxlKAorICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisg
ICAgICAgICJtZW13KCUxKSA9IHIxXG4iCisgICAgICAgICIud29yZCAweDFlMDM2MWUwICAgIC8q
IHsgdjAgPSB2MSAqL1xuIgorICAgICAgICAiLndvcmQgMHgxZTAzZTJlMCAgICAvKiAgIHYwID0g
djIgIH0gKi9cbiIKKyAgICAgICAgIjE6XG4iCisgICAgICAgICIlMCA9IHIwXG4iCisgICAgICAg
IDogIj1yIihzaWcpCisgICAgICAgIDogInIiKCZyZXN1bWVfcGMpCisgICAgICAgIDogInIwIiwg
InIxIiwgIm1lbW9yeSIpOworCisgICAgcmV0dXJuIHNpZzsKK30KKwogaW50IG1haW4oKQogewog
ICAgIHN0cnVjdCBzaWdhY3Rpb24gYWN0OwpAQCAtMjI0LDYgKzI4NiwxMCBAQCBpbnQgbWFpbigp
CiAgICAgYXNzZXJ0KHRlc3RfcG9zdF9pbmNyZW1lbnQyKCkgPT0gU0lHSUxMKTsKICAgICBhc3Nl
cnQodGVzdF9wb3N0X2luY3JlbWVudDMoKSA9PSBTSUdJTEwpOwogCisgICAgYXNzZXJ0KHRlc3Rf
dnJlZ19sZWdhbF9wcmVkaWNhdGVkKCkgPT0gMjMpOworICAgIGFzc2VydCh0ZXN0X3ZyZWdfaWxs
ZWdhbF9taXhlZCgpID09IFNJR0lMTCk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19pbGxlZ2FsX3Vu
Y29uZCgpID09IFNJR0lMTCk7CisKICAgICBwdXRzKCJQQVNTIik7CiAgICAgcmV0dXJuIEVYSVRf
U1VDQ0VTUzsKIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkIGIv
dGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggNmUzNmE5YTEyMjAuLmUzMDE3ZGIy
NGY2IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAorKysgYi90ZXN0
cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNTQsNyArNTQsNyBAQCB0ZXN0cyArPSB7CiAg
ICdsb2FkX3VucGFjay5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAogICAjIEJ1aWxkIHRoaXMgdGVz
dCB3aXRoIC1tdjcxIHRvIGV4ZXJjaXNlIHRoZSBDQUJBQyBpbnN0cnVjdGlvbgogICAnbWlzYy5j
JzogeydjZmxhZ3MnOiBbY2ZsYWdzLCAnLW12NzEnLCAnLU8yJ119LAotICAnbXVsdGlwbGUtd3Jp
dGVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdtdWx0aXBsZS13cml0ZXMuYyc6IHsnY2Zs
YWdzJzogW2NmbGFncywgJy1taHZ4J119LAogICAnb3ZlcmZsb3cuYyc6IHsnY2ZsYWdzJzogY2Zs
YWdzLCAnZXhlX25hbWUnOiAnaGV4LW92ZXJmbG93J30sCiAgICdwcmVnX2FsaWFzLmMnOiB7J2Nm
bGFncyc6IGNmbGFnc30sCiAgICdkdWFsX3N0b3Jlcy5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAot
LSAKMi4zNC4xCgo=

