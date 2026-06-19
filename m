Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93534CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifg-0003wj-32; Fri, 19 Jun 2026 19:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiff-0003wS-8O
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifd-0007RH-PP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYdKN1337398
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=; b=bRgkZewBp2VKCchO
 46Ed44Mimi/OMrKYGJMIoZw/SDPFjEU7lhGb7O1Io+3WRYg1YZR52gXOUlIiFWEP
 +j3kAZjS/oAPwuiB70U+jPxufqU7pE0j2VpPXjaxqLOVgnL3P7dO6wEN+Zbn7gVP
 HscnLv/zxJGvoGwjE1jCM1kAhzKdS0TwkFV7ZtAf70Fq1ArXvQNO/F0OZSR30Okr
 D5zHJuIqLec5PKqX1rOD3fHuup+H+Bk4dEr4zyQGYa6aRY6gHcvHL7nbAy64EFsX
 NwQ0DCz7EfMs/eVAl/e6YR6P8X+KSHaUDCtHpxNN9QmrrDwVvWC2Y33w2kiYfagX
 mLAg+A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6757a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcbb34e57so4177241eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911834; x=1782516634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=jwxOmIj1ss8cULPmK1TKjjsCEoCLepOUU+RHr3vDuRnb7ZxyZ+s/dWmoqWXNpX4X3Z
 ZXlSlHtkHzOOax2F1i+/TenA6kbGkvuqWMdGe1E/LPvFfxI/kdUtz474dZZOv9r8vc/S
 LKVkTMYLb5GgqjvdlNyhTx1klCUfL3Ox73eezTHYBcK3mDIVsWUQLCxf0LWmEVLARkMi
 x9z/NtpTuK7tRq/cMUr+qLRe96m6rHXKc3NjafElKYd3bn2E1KtxZftNFGI/8VMkZd7E
 sxcyzMcbtNhBwf6EOhnoSuxgbCdJ/7SStrZpeWdzxL2EH2dlXaSNC1zBv7u8OuAyBcFH
 2Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911834; x=1782516634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=UENw0c3DmnNsrPacgQXmpBnwCiOwMLz0bElDj84xq+lxyQP24bsxL0a5Ox1wfNXNat
 KoVBWgmcjIgDBEAp0kUVpnd75yPMHf63b/q9SSUStCyz5PhdshOQNTWI+ZqP2+QbXPBq
 PIF4eFGQ4Atb4M5lpyrA5PPZtLWWNjZ2S2XQOxRCkIcHgml3/WvJl606AifHTsF0wcYm
 DjxDxPG44tAeoyniulvY+dZnkSQqNDQLCoAX3D/byb7cA3bCgS9V8tVAWa9JXrYHPZ+W
 XFYr/8BO2m+JKV1rhaPDC0Riz0MLhZmnRuds08RUokfjwyyRVIC2bxiUAsed6ZYYbAo9
 4Pqw==
X-Gm-Message-State: AOJu0YyW9e0FOkzyrB1BRTSLwqg6M+GYA9eqD4d+QLlr7zhHEWt6Uge/
 KAFgnFBDNDRRRkIC0h+InKYb32oorZ3TH2d8ZO2Zgg83C++RmZ7yuU42/n+huWvQuyUAtfPsfNb
 6A6rxr7CYrvbsHI+FzIFFzpHtP4O6jRePr5NEBB7SCPOppjbUvj95YxdZMZMx5cXM3A==
X-Gm-Gg: AfdE7cl2C2lNDOeJzizzqAhilrDdx35AzvM7/IxdorpFxzpwS8f2S8NkIY3BIt4vDcE
 QjhHDgEmYT3cINZ6HrHdPBUJpOA3uMJiqTdVGqDgbjp/3S7AGpzWOnVkdof7y+K5BgjHrbkzUdb
 3RBhYyJMJtjW7ySbkS/295IAuZ5efc4IKQaUbjCq1arfSMgiDPeFGzDQI3P9ppWRB/bu29vQY2G
 ePM5OTY28NFcB0hhfvifF2bm+qYVMx8BsscgZ75lw2JMcP4cnH7e5mqOBeU7+rHMuuQmQNJkU5h
 0JlJwYQV0YDIq1PsGMc9fxzm5hUbaDW7zQ58GvlqwALH2nP/swcECucSrBeohhjq4ILr2CN5Flo
 AHlhLMDOnR2l3dypVfQkx52QCs8gsnX7G5Izv4R5J39m4MZ6jcD4YdYRhbxs=
X-Received: by 2002:a05:7300:f10a:b0:30b:fc05:a18c with SMTP id
 5a478bee46e88-30c071d1c6dmr2658799eec.24.1781911833877; 
 Fri, 19 Jun 2026 16:30:33 -0700 (PDT)
X-Received: by 2002:a05:7300:f10a:b0:30b:fc05:a18c with SMTP id
 5a478bee46e88-30c071d1c6dmr2658789eec.24.1781911833388; 
 Fri, 19 Jun 2026 16:30:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 54/74] target/hexagon: Decode trap1, rte as COF
Date: Fri, 19 Jun 2026 15:58:51 -0700
Message-Id: <20260619225911.159473-55-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Mu1maJGVrkMzmrOnYMmJHFj5lUDZ-EPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX/4ygnUsse9Mz
 ZTLgINQcXGxAZP3YXI/FGfWTDeYYD6Yih8hrProS8I6aBteK/J6/lVsEgE27iCG59fM7qczq8Qr
 4CKHrf8VDbnPn6rTfNEUTQQS0FZ0wWyJ6k6HtcpjFk51vTbPP6+K/+0W3xvgx8r/g5O3rX5hjrY
 MrebQrFlmDJ4KDOkh9IQETjnq0CjVLHRe464blHWdhTnwL+edAZfv0TrmT2xwM+IZtbgZ3/3CZo
 uyQyLzxgeGnYluO1YaXi5Cxyq6lNhKJs56fd/RMmUObFSPrW8o2nmpPlSJ+HYkaoRVDT/z348EE
 TtgIMBTxQ8NmihW0h/nGDko/bC68zoOv8zUQKd8tRGNWUgnyAkZs3EAowo920JesTpElqcoZFBp
 gDVY8Dzk3JDXAYc2X3VR5muRK3dmjRqGlt4skBkUcScWghMwI/T6zAddiqiiAZxmW43BQjaWKaR
 d+zDI3na6r9UtTq1jlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX0h+U3UDF0Bbb
 0hcce3Bi9zZaavo/Q9lHUxLtu2gNtkfvY6VaXq3vTcHMppQDcrgLLiiSGQzqgPfsVbvAA4s9Qqu
 ORLqsAYeimfXvw0iMGB6cdBuGJix1h4=
X-Proofpoint-GUID: Mu1maJGVrkMzmrOnYMmJHFj5lUDZ-EPt
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d11a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Rl
Y29kZS5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYwppbmRleCAxNTk1NDUxOGI4My4uNmVkZGNjYTI2ZWQgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0x
ODUsNiArMTg1LDggQEAgc3RhdGljIGJvb2wgZGVjb2RlX29wY29kZV9jYW5fanVtcChpbnQgb3Bj
b2RlKQogICAgIGlmICgoR0VUX0FUVFJJQihvcGNvZGUsIEFfSlVNUCkpIHx8CiAgICAgICAgIChH
RVRfQVRUUklCKG9wY29kZSwgQV9DQUxMKSkgfHwKICAgICAgICAgKG9wY29kZSA9PSBKMl90cmFw
MCkgfHwKKyAgICAgICAgKG9wY29kZSA9PSBKMl90cmFwMSkgfHwKKyAgICAgICAgKG9wY29kZSA9
PSBKMl9ydGUpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfcGF1c2UpKSB7CiAgICAgICAgIC8q
IEV4Y2VwdGlvbiB0byBBX0pVTVAgYXR0cmlidXRlICovCiAgICAgICAgIGlmIChvcGNvZGUgPT0g
SjRfaGludGp1bXByKSB7CkBAIC0zNjMsNiArMzY1LDE4IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9z
aHVmZmxlX2Zvcl9leGVjdXRpb24oUGFja2V0ICpwYWNrZXQpCiAgICAgICAgICAgICBicmVhazsK
ICAgICAgICAgfQogICAgIH0KKyAgICAvKgorICAgICAqIEFuZCBhdCB0aGUgdmVyeSB2ZXJ5IHZl
cnkgZW5kLCBtb3ZlIGFueSBSVEUncywgc2luY2UgdGhleSB1cGRhdGUKKyAgICAgKiB1c2VyL3N1
cGVydmlzb3IgbW9kZS4KKyAgICAgKi8KKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQor
ICAgIGZvciAoaSA9IDA7IGkgPCBsYXN0X2luc247IGkrKykgeworICAgICAgICBpZiAocGFja2V0
LT5pbnNuW2ldLm9wY29kZSA9PSBKMl9ydGUpIHsKKyAgICAgICAgICAgIGRlY29kZV9zZW5kX2lu
c25fdG8ocGFja2V0LCBpLCBsYXN0X2luc24pOworICAgICAgICAgICAgYnJlYWs7CisgICAgICAg
IH0KKyAgICB9CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQKLS0gCjIuMzQuMQoK

