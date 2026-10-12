Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45D5CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7U6-0001wJ-M9; Mon, 12 Oct 2026 00:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tt-0001uk-3f
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tp-000187-73
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lRNW3646369
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 as/L4AtVMJ2a3YTgAo6jVh3GWQGz87dkg6Y0W6CHNcw=; b=KbZj6YXVstJWtIjB
 5Rb/Gyvl3WAqHIgBJ9yuHo0YALWv6WpMg0PCEDmkV3jQGrZz3AK1FwryVBwmfNgZ
 U2v/de/OU/0KmRsH+Iojc6cPWI9m5484FIilxAIXOP8H/bUj/+YPbSAtavRgmxMP
 6LWwTw4SQh5ojSqC6siXeY46rkBUpcskQBLSRFLtD3UJF6QqhY1f4blAskALHnWa
 TxASwcfGomct2xQs90Jn7idI3xV5I40IJSR6fuG9tJ1/WZ7EJsoPyqM9uw1EkHYY
 Nq0v9zZCXtaki0L1SFTDtajEydmeRbnJfthBGQ2r8kRIYr9yJzWeezRwMevRme6y
 qWAjRA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjmht5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so3542405eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778658; x=1792383458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=as/L4AtVMJ2a3YTgAo6jVh3GWQGz87dkg6Y0W6CHNcw=;
 b=a1MKZnwoLdM9ZTqHUpC8tUoPPL4C1nKwbKA9QFVuCi9t3xE4gmcRK7dGXCPCb4PgXq
 hwkKWvtozb5kJUKTScjFQcORMFUYIyHt7UU/yDSvx3ZvplVFcZJKgUTG5QDkuXvFvAXS
 bhHI+IrlifFJDJOl9JJ9HW9GSOedX8HTR8z0PUD6fkoFyz4TYCyHusB5a2FvQZOfeaRs
 0xrUgbT9ODaTG0rbyNZxJ0jYK6Opt3tM9xcvWhYaIEu4Yi00JBEQegMMZts5NCbPds6c
 CXCa02JIEPk89kxvZVJozMk3lmsDMMm9MoQ2aKxJsjLAUMyQ15nixItrWJTdHqi7gdhe
 yNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778658; x=1792383458;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=as/L4AtVMJ2a3YTgAo6jVh3GWQGz87dkg6Y0W6CHNcw=;
 b=U3JOgyWwHhzhbmXpWGRlMb9hHEqsek2fsgojsz9EUd4CGXv4iSSgaHtgn4uQWNs0N6
 w6sieZ+0o/Tc6XJSLnE/jSDDRRcgy/e0Gtqz5MVs35XTeH8FhW38Iwzdsp2H3KjOmpZN
 ADP7XpL94NUTRLRQJ0lvm3TR+y4VWrFtGfwpyYuDZkkjk/YMWAuZyrFKrwrm+BXEnKxw
 C3O1u5n74oaNOX8Ja3iBiAgWDnV14kSoW0lHYkr+1uR70Z7LCQKr6oQxHdRP6ygzMjgV
 Ey2V+LF5Yr8bQjvQlTnY8pcIs+SRfQEgaycxKfxga6wAw6Nv8usbcPWgzU20plAiT7eQ
 yY4Q==
X-Gm-Message-State: AFq9FYJQTuOiHUMOCEdoViKCLW3yXdf7RLtPxLiIogzGoNHF2x0QSzwL
 PpMxRYHny7Y9cICt4VGxGDd6litAmqPX6alLCnP0tB1hva9WqEEQwJ4KPz+41RTxgEqOKE17x3Z
 hlZpNWzywDwHFwgPJ7k701jkJhVzsCqnfFmvp4cmUMKBtLDlYTo9YgkQhKM+HG1bPng==
X-Gm-Gg: AYBFou0H1lJ0nr5eozEvpV++leTEjj4KvH+PH4k4jejInzd9EGko6PQ7HAnoLa6c9h3
 5/9oqLrZ5GE/Pb0VT5FEtB9Oxn3RIoOYQDmeTXBix2iLXOTaM6OdZpfZ11ymmMGlK93vtomYBkz
 so1/10T/sEiAOyMwkDFa7Rz1owk9TKvCoH5FFgGIo8032zoF3rsfkk5jyUTqKDfeaHt1IfH3bcY
 tPKxf+FvOwvvdINYpxObBO4kGT5B8wQpnhn5UJHFwTrs9No37+nbK8U76zQzOnB8x9x2PFyhwgC
 5qEoLaybe/NUuaBm1Agr/TARGFMx+E6TkEPqo/m/s5vM/gs5zehkl94tnezr4VQeh4eonanWx5S
 BU3HN3IW/ZFzO1AnmiJ1kgKyebaGFWF0vWuAOUJDgnzZDnfU=
X-Received: by 2002:a05:701b:2086:20b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-16a5adfc081mr12385507c88.15.1791778657416; 
 Sun, 11 Oct 2026 21:17:37 -0700 (PDT)
X-Received: by 2002:a05:701b:2086:20b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-16a5adfc081mr12385470c88.15.1791778656455; 
 Sun, 11 Oct 2026 21:17:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/25] target/hexagon: derive HVX storage sizes from types
Date: Sun, 11 Oct 2026 21:17:04 -0700
Message-Id: <20261012041722.1159355-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXw75How+gDgld
 /dmC0+VkycT0x34/LxUf4say/EhmDQQE+Qc9XhyYZOSYvcP4Ru2+G+HsR3DXOiTyfXjvwiVSOZ4
 E4cUjGSfcMkqsyAJcvF2JjIiTRxF/7Nf75qD1lThF1PS5FPSNlevqBfgA3vTVjRiCsrX47RZ4Zf
 WDIfFvMvUwo1Gou0jKXHA9f4gGC/V5p7kkP8xncG1Dsrpd/+qRHEmsbnBMcnIhrlWk/6s3qSs8b
 7rCEII1QfqiaOB/KAmnM3/toig4Wfie0y0BGrCXwiTqUQTb7BBpyRyK01/qRM+kEyhDLCt/+MxL
 SwMbkEXipWWu5zj5dJvSB4j2VAbcNqqKIGCWX8w5PYt8msHpwwPKIPteRzshhgpX1WxwqP8vSAr
 jI8Iffv9B5J+WJn+5pHrIJ19QpaQ9R6d5YPR4W3PlmIeIkU2jpYLWWQA697YBkmUNiAoHk6LSve
 F6tC+arsdmnQFh17aLg==
X-Proofpoint-ORIG-GUID: _mbtUKdknfdwNsWwIs9o2eGLbsoSQ7aa
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acc5f62 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=OyJAZBVBAfdT-SukITkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: _mbtUKdknfdwNsWwIs9o2eGLbsoSQ7aa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX+NkMtujUIvdU
 pejXg94BcBGdcBkCZDh3JNFHX/+R250bCLjxSxIWKpRxS6ejhOpqxSIk/hPISzplrpsdu1VhaES
 lO15UnkifSfIUhPNSAQfAnCpad2lSNM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120016
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

VXNlIHNpemVvZl9maWVsZChNTVZlY3RvciwgdWIpIGZvciB2ZWN0b3ItcGF5bG9hZCBzdG9yYWdl
IGFuZCBzaXplb2YoTU1RUmVnKQpmb3IgcHJlZGljYXRlIHN0b3JhZ2UuICBUaGlzIG1ha2VzIHRo
ZSBpbnRlbnQgY2xlYXJlciBhbmQgYmluZHMgdG8gdGhlIGZpZWxkCmluc3RlYWQgb2YgYSBtYXgt
c2l6ZSBjb25zdGFudC4KCkluIHBhcnRpY3VsYXIsIHRoZXNlIGJvdW5kcyBleGNsdWRlIE1NVmVj
dG9yLmV4dCwgdGhlIFFGbG9hdCBleHRlbmRlZC1wcmVjaXNpb24KYml0cy4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL21t
dmVjL21tdmVjLmggfCAgNCArKy0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgIHwgMTIg
KysrKysrLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgICAgIHwgIDQgKystLQogNCBm
aWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDY5
NzljMTUzZjVkLi4xODhhOTFlODgyMyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgK
KysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTEwMyw3ICsxMDMsNyBAQCB0eXBlZGVmIHN0
cnVjdCB7CiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgdGFyZ2V0X3Vsb25nIHZhOwogICAgIGludCBz
aXplOwotICAgIERFQ0xBUkVfQklUTUFQKG1hc2ssIE1BWF9WRUNfU0laRV9CWVRFUykgUUVNVV9B
TElHTkVEKDE2KTsKKyAgICBERUNMQVJFX0JJVE1BUChtYXNrLCBzaXplb2ZfZmllbGQoTU1WZWN0
b3IsIHViKSkgUUVNVV9BTElHTkVEKDE2KTsKICAgICBNTVZlY3RvciBkYXRhIFFFTVVfQUxJR05F
RCgxNik7CiB9IFZTdG9yZUxvZzsKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMv
bW12ZWMuaCBiL3RhcmdldC9oZXhhZ29uL21tdmVjL21tdmVjLmgKaW5kZXggNjYyZjlkMTU5N2Uu
LmVkMjMyMWJlOTIwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9tbXZlYy5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL21tdmVjL21tdmVjLmgKQEAgLTg5LDggKzg5LDggQEAgc3RhdGlj
IGlubGluZSB1aW50OF90IGhleGFnb25fbW1xcmVnX2dldF9ieXRlKGNvbnN0IE1NUVJlZyAqcSwg
c2l6ZV90IGluZGV4KQogCiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgTU1WZWN0b3IgZGF0YTsKLSAg
ICBERUNMQVJFX0JJVE1BUChtYXNrLCBNQVhfVkVDX1NJWkVfQllURVMpOwotICAgIHRhcmdldF91
bG9uZyB2YVtNQVhfVkVDX1NJWkVfQllURVNdOworICAgIERFQ0xBUkVfQklUTUFQKG1hc2ssIHNp
emVvZl9maWVsZChNTVZlY3RvciwgdWIpKTsKKyAgICB1aW50MzJfdCB2YVtzaXplb2ZfZmllbGQo
TU1WZWN0b3IsIHViKV07CiAgICAgYm9vbCBvcDsKICAgICBpbnQgb3Bfc2l6ZTsKIH0gVlRDTVN0
b3JlTG9nOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdv
bi9jcHUuYwppbmRleCA2MDk0MDllMzJkMC4uYTc0ZWFhNDVmYzIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xOTEsNyArMTkx
LDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfdnJlZyhGSUxFICpmLCBDUFVIZXhhZ29uU3RhdGUgKmVu
diwgaW50IHJlZ251bSwKIHsKICAgICBpZiAoc2tpcF9pZl96ZXJvKSB7CiAgICAgICAgIGJvb2wg
bm9uemVyb19mb3VuZCA9IGZhbHNlOwotICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IE1BWF9W
RUNfU0laRV9CWVRFUzsgaSsrKSB7CisgICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgc2l6ZW9m
X2ZpZWxkKE1NVmVjdG9yLCB1Yik7IGkrKykgewogICAgICAgICAgICAgaWYgKGhleGFnb25fbW12
ZWNfZ2V0X2J5dGUoJmhleF9odngoZW52KS0+VlJlZ3NbcmVnbnVtXSwgaSkgIT0gMCkgewogICAg
ICAgICAgICAgICAgIG5vbnplcm9fZm91bmQgPSB0cnVlOwogICAgICAgICAgICAgICAgIGJyZWFr
OwpAQCAtMjA1LDggKzIwNSw4IEBAIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BV
SGV4YWdvblN0YXRlICplbnYsIGludCByZWdudW0sCiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIHYl
ZCA9ICggIiwgcmVnbnVtKTsKICAgICBxZW11X2ZwcmludGYoZiwgIjB4JTAyeCIsCiAgICAgICAg
ICAgICAgICAgIGhleGFnb25fbW12ZWNfZ2V0X2J5dGUoJmhleF9odngoZW52KS0+VlJlZ3NbcmVn
bnVtXSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNQVhfVkVDX1NJ
WkVfQllURVMgLSAxKSk7Ci0gICAgZm9yIChpbnQgaSA9IE1BWF9WRUNfU0laRV9CWVRFUyAtIDI7
IGkgPj0gMDsgaS0tKSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZW9mX2ZpZWxkKE1NVmVjdG9yLCB1YikgLSAxKSk7CisgICAgZm9yIChpbnQgaSA9IHNpemVv
Zl9maWVsZChNTVZlY3RvciwgdWIpIC0gMjsgaSA+PSAwOyBpLS0pIHsKICAgICAgICAgcWVtdV9m
cHJpbnRmKGYsICIsIDB4JTAyeCIsCiAgICAgICAgICAgICAgICAgICAgICBoZXhhZ29uX21tdmVj
X2dldF9ieXRlKCZoZXhfaHZ4KGVudiktPlZSZWdzW3JlZ251bV0sIGkpKTsKICAgICB9CkBAIC0y
MjMsNyArMjIzLDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfcXJlZyhGSUxFICpmLCBDUFVIZXhhZ29u
U3RhdGUgKmVudiwgaW50IHJlZ251bSwKIHsKICAgICBpZiAoc2tpcF9pZl96ZXJvKSB7CiAgICAg
ICAgIGJvb2wgbm9uemVyb19mb3VuZCA9IGZhbHNlOwotICAgICAgICBmb3IgKGludCBpID0gMDsg
aSA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDg7IGkrKykgeworICAgICAgICBmb3IgKGludCBpID0g
MDsgaSA8IHNpemVvZihNTVFSZWcpOyBpKyspIHsKICAgICAgICAgICAgIGlmIChoZXhhZ29uX21t
cXJlZ19nZXRfYnl0ZSgmaGV4X2h2eChlbnYpLT5RUmVnc1tyZWdudW1dLCBpKSAhPSAwKSB7CiAg
ICAgICAgICAgICAgICAgbm9uemVyb19mb3VuZCA9IHRydWU7CiAgICAgICAgICAgICAgICAgYnJl
YWs7CkBAIC0yMzcsOCArMjM3LDggQEAgc3RhdGljIHZvaWQgcHJpbnRfcXJlZyhGSUxFICpmLCBD
UFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSwKICAgICBxZW11X2ZwcmludGYoZiwgIiAg
cSVkID0gKCAiLCByZWdudW0pOwogICAgIHFlbXVfZnByaW50ZihmLCAiMHglMDJ4IiwKICAgICAg
ICAgICAgICAgICAgaGV4YWdvbl9tbXFyZWdfZ2V0X2J5dGUoJmhleF9odngoZW52KS0+UVJlZ3Nb
cmVnbnVtXSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFYX1ZF
Q19TSVpFX0JZVEVTIC8gOCAtIDEpKTsKLSAgICBmb3IgKGludCBpID0gTUFYX1ZFQ19TSVpFX0JZ
VEVTIC8gOCAtIDI7IGkgPj0gMDsgaS0tKSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpIC0gMSkpOworICAgIGZvciAoaW50IGkgPSBzaXpl
b2YoTU1RUmVnKSAtIDI7IGkgPj0gMDsgaS0tKSB7CiAgICAgICAgIHFlbXVfZnByaW50ZihmLCAi
LCAweCUwMngiLAogICAgICAgICAgICAgICAgICAgICAgaGV4YWdvbl9tbXFyZWdfZ2V0X2J5dGUo
JmhleF9odngoZW52KS0+UVJlZ3NbcmVnbnVtXSwgaSkpOwogICAgIH0KZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2dkYnN0dWIuYyBiL3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYwppbmRleCAz
MGI0ZDcxMGNkYi4uY2E2ZDRhOTgzNjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dkYnN0
dWIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKQEAgLTE4Myw3ICsxODMsNyBAQCBz
dGF0aWMgaW50IGdkYl9wdXRfdnJlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDhfdCAqbWVt
X2J1ZiwgaW50IG4pCiAgICAgICAgIGhleF9odngoZW52KS0+VlJlZ3Nbbl0udXdbaV0gPSBsZGxf
bGVfcChtZW1fYnVmKTsKICAgICAgICAgbWVtX2J1ZiArPSA0OwogICAgIH0KLSAgICByZXR1cm4g
TUFYX1ZFQ19TSVpFX0JZVEVTOworICAgIHJldHVybiBzaXplb2ZfZmllbGQoTU1WZWN0b3IsIHVi
KTsKIH0KIAogc3RhdGljIGludCBnZGJfcHV0X3FyZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQ4X3QgKm1lbV9idWYsIGludCBuKQpAQCAtMTkzLDcgKzE5Myw3IEBAIHN0YXRpYyBpbnQgZ2Ri
X3B1dF9xcmVnKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikK
ICAgICAgICAgaGV4X2h2eChlbnYpLT5RUmVnc1tuXS51d1tpXSA9IGxkbF9sZV9wKG1lbV9idWYp
OwogICAgICAgICBtZW1fYnVmICs9IDQ7CiAgICAgfQotICAgIHJldHVybiBNQVhfVkVDX1NJWkVf
QllURVMgLyA4OworICAgIHJldHVybiBzaXplb2YoTU1RUmVnKTsKIH0KIAogaW50IGhleGFnb25f
aHZ4X2dkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9idWYsIGlu
dCBuKQotLSAKMi4zNC4xCgo=

