Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnP-0004RB-KP; Mon, 29 Jun 2026 09:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnO-0004Qv-Lu
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnN-0003Bj-3l
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuqe2640837
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=bpyyRje0/murKpeL
 vdQtg+tdifij4QDQ2kpymROimtkggMSVhoyaFJF0JLdx+SENvjWYmK9JYAv/3xlG
 VRTt7M+vrlfnBT3cdliZ5U7/L1WDQqDT9zVbTKoWFsghSdJzoV9WPEwMb0In14rq
 SGUFOO+bifedoIaVyGkCmc3apMN72RWyb0vzmeTFrwfMFu38bo2b86ddRUPH5fLl
 A5nGbp8qvawnN54MjJiTawzBAMS8zBtuykLccd7qIIvw5tIlENpjpphFyuXEVUiR
 niUp2XjGx3y1uj+jc//KqwPm4ooOTG1g3DuhP1sp6wsOVwLkjoOLcUPqIT3m8jah
 Ww4w+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s1428-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso2889366eec.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738783; x=1783343583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=Rb8N/1Y2VeqO9OYSgWRYaq7OfBhfJlrsQiVFx9JCsticoO7z4GLNYp2D8QuTDn+9a4
 /bdJKm+6NwWJC/UOaKASvTW+KFMa3LkQx4pavVopDtP+Lr8COfhfAhA3hZBCQ9ZwFK+i
 8cx2MYfGj9XNaL/4w5eU9g98LdsMmF/0cJbHgadEPTB6yFgGSCeKWfMDtrMUNtO9gsTl
 GuxRFqJlU0PI3ayr+cJYdyfgFmsj/20SzB/T7o9OOn/UiYYIZv7gjYLiAye0JUv9BbqK
 cf/8MhAJePBClhT5ofjqvSCzcxP1s3mNx1nCda+Io4kEqogETD1rzTSjMc8CoR5VeIr6
 KxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738783; x=1783343583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=SV1boXYg0CelSIl816Xqb+fM6L1DLkDXw/RfcJX1bPZwyArmhwRMFeiH0JTt8EL7DZ
 0hu7ribR3VgecrjQ7rTbG60WsumRQTkG1ORjO0QjDR5TS1VKlbkS8PlxLIRHB6rplTtg
 63IQvzFdzJwxumklhA5k0pYsA04M/4nqL4aDgFk47zXYnrWd7aJWrMOI3gDUCn2QOqh+
 pPeNTAPCZBprweZ3RbJwCjZvuScK+kRrjIMOt92MDnEthbq/0nJ5oxPk9AULH7nLYw7J
 LzuoxZpZjr86cdHf0Rynu0V2mWYxpekMrUPcwONEBydceQKQlKds5o6C7QCZCT3vkODU
 Ibbw==
X-Gm-Message-State: AOJu0Yx9U4YI3HGlzSSStEejcgv3xhnFazR1DnQ2oOhE31AbU6VnTzCA
 Q0ekvvg3kdOwDfOy15lQVVrG2gU+h86iZGj6e2mRZRNExVuWkjOSwPhP//kRkACie4PCrQGdPNu
 Ty6c5tJ8sCV5QoIAwlA1vcWvKjFIMApnKkpyeGDeysb6UZEMZkJ0D/ObmEvpdYJcVaA==
X-Gm-Gg: AfdE7cl7V/FaEI38GjoBFeQFAJCVdFQA3aLjBGMPldtrJoilh3Y/GjEweTT500zdQsi
 0Cr4/CzcmMI/OwFRxcJy7TpUDgVxGiaRQAUlmgsgiYK5tkdnTBBj2eEITCLg1Fos/Z88mlsHB/r
 f3gR3lUrq3NgzcC+qTh8ryUArOsnziUvEnseOCGIuLpQYjzUh1aoXg8+D/ei++kC3jYAiG+a5Ea
 f3AOgK80eFmYjxrpeThmAE/6oKut3YsDCYucFtzreGgHulkiGThaIhJUQrDcIwt1TyvUTBONz2v
 ITLtRy5k3mCkbeJw4I0HpZy+Kl6kG0LNfOJCnt7D+rSmjMSwSGXOhkWpLfTqIsI3Mk1F/Pf8tvd
 8rneLstCHhxKpaUFEE5c9jusF9DIMqAAKldqFisR+nTaoMDTZ8b7kVPibsVU=
X-Received: by 2002:a05:7022:2604:b0:139:9e79:43fa with SMTP id
 a92af1059eb24-13b220da169mr358838c88.9.1782738782966; 
 Mon, 29 Jun 2026 06:13:02 -0700 (PDT)
X-Received: by 2002:a05:7022:2604:b0:139:9e79:43fa with SMTP id
 a92af1059eb24-13b220da169mr358817c88.9.1782738782445; 
 Mon, 29 Jun 2026 06:13:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 15/77] target/hexagon: Add guest, system reg number state
Date: Mon, 29 Jun 2026 06:11:30 -0700
Message-Id: <20260629131232.2487780-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX+j65/tccPAfJ
 5caR4F4owTN6McyUAyaFAqTFAh1+SdV2R7A1hJ4FKzsEkkcyLj99UAd8UKwU7AmcZfcDr1V/8bi
 fHOse0OsuQqa5MKrRB+ujvoqzX1is28=
X-Proofpoint-ORIG-GUID: rsT4DzWK9NeKyhoo5Vmxkw3_pepqQwo7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX9WRUzadKIkqi
 H+HBxZM8SvuAIp73BG3HQYqog7VjfaFMexOa7e+4XlsVWnBHtg1Zvl0kq7XROWZi07OJ5vvHNOr
 ZTgvomFEHMTat1vNp3DZQQcYLrT5w64tqmL9Xx85QSILJ0njNFAsuNeOZ2RQTRAn1JYNJZMKLdU
 QjpQOmILmpoiiIfaX1E65NTceN2dMo1dwYtj4dU7PX0g/pPDomOOC3g8+M86ylZjwOidQZA6FSk
 Nc9L0wgYeShRabC3omVo0YcDc1qt7RcYMRlT6wpshgkIiZPw8oJFGPFgrbebhxiH4vff/lPGlXf
 9XL09ZQrjzXz6IM4oLtK3YKpkDM5SWPT69UzcC6MqgSyzKWGlK54gJQcL1Npe2/ZlAKI79XzbYI
 ZxKvm1ZVkoGzZTEKi8IeG5qWxK7FWhT9huCVsxLMR8Et4D99yphyEJJ9bOUDMuOk8TqMGXKqhty
 X16bFGwCMZC83azPqjg==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a426f5f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rsT4DzWK9NeKyhoo5Vmxkw3_pepqQwo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

