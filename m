Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94781CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCS-0003NN-T3; Fri, 19 Jun 2026 19:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCJ-0002tJ-TS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCH-0001uI-Uq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY5BF1369135
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=; b=VENmky/z8h+GWv0o
 LJFh1dtZO8vFhjFVqr9hLat7F7bcvqJNr+6mRD5UJ4OIYIJqDWBybJid3etHUfMV
 dny3SMgxe0WYuPtRV/W1EZBHfjjq3zccpJgW2Z/AXJZXfWHIo2OwQRkAvqFzJjQm
 3jE+4Vd8mthTdfG3oQAVA9QExgZxb8NCWEKjAQr3B2Ghpa6A9e1PiAG3/aD6pwVo
 ec2MILw90SPPDU9BgHujyUqbrnfnc5yAfMoMHoFVWDC/4osAeoGN+ZB8gs0Uz0Zn
 24lh8ehuwGNbjRXmnui87hiIDDZcXls+WY0V4v2lMhbSjnYgnqVnFekU9OyuQT9J
 7Zrazg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewcy30btx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-138455d7e20so4396860c88.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910013; x=1782514813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=ICSu55plrivxA83bTj08stkWdtMcx9PL3p0hqxYtTe/xfqjMnITmBRSdXl2xDkBBy/
 pi42fIK48YNPJU0MFKWKQHcgf+/TXWZ0ugicWybSMM7MCQMA4v+olB6nTDWLFQ97r2V3
 iA0qJbOEb9YII+nMKHBXO1sf+IEL/jbv7qldflWia1g5GeQvqpbFFNEopG2HkJKWwx4p
 45OnPDsZKxk/921N+xKuNFJrERzNu47T3CvNuhbJSz4O9k0mPteIY3M21KiEeEh2kBh9
 OVFOlnnH5zTP53jctOaUKJkfjh+Zdxsl207sBD8tNIJMx4g+syI4TvOs/elDtkI5qRJE
 yDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910013; x=1782514813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=UpsshGs8cgod4B4+TitQA5+fa0xFI27gYsnCHYOFP/ZRbQfGPok2Sb3utnMtdWU+66
 cOinPcgYQtQX+XWge3lpj7k2JKl03Ci33VvIwxnVeqIprCZ0BGaNTB9RqJ6gpbClUZ1e
 QdeSbtSs1XqcFt/CsX0eTPb7gJZwJHM2smJ2/R0HVHpGgPxTOQb1ZwGF0TAPUwWJ4HSJ
 ABwJQ4LK5znl/VOtCRHi1k1pFtcjyN+T37vqRiwBQqjUYUgOqz2kM8uuUw+LnYPhm0EO
 IN+InDEMO1kxsdUs7ZU1ATzyHzM85xWtsD1vvonoNLRBG99t3OTgzSBSMDkPZPWSF1Y9
 p/kA==
X-Gm-Message-State: AOJu0YwNTRxCOGn/t5MDOARnpF6kbSz1DISkcrEQ7isR7ldM66kV14dK
 SJi3Km4z6F+rPlHOIsfrvJNDQAryWlTa8oxDxJrjlx386UQ7pmEJTDWTJwJ/rEiL2xjts7Ame2r
 XlBNfHt3/mw+UczPBqlDkr05P4cYu6TErnpZnmWJm/3OrmEdyPU4UN+e2gYC7bQzMjg==
X-Gm-Gg: AfdE7cnZFDacuaqT5M6+c6vs8mjIiWutKa8BPdsDhB1QsI4FLzbjoL1gnBLK/VDYUb7
 SXVEyDU6G9SZWPy5yMrWBuYmXtttEqluUIBAEDRoL6AK76hYacKc/8qno+FiTHsKojSs968seYX
 yf0epMR/l6vWc3urMpMB5/GdI8EAOeDJZvCnZOSuh4cMh7M5OM7VAQV8cqbiyrLYUTU9rFyxM2l
 PudjDEBhZZwm9xFx9kkGK3EK0C2jnX25JenKG8lYpqfyBlvujjoGMy3BwRdCDmA+e7dRFVlpbjB
 vPyfEbYJ+mRyDmMDE1gMQEFi3kl+Gbt0HMr01a9BtxKK0xw1yCu6MUGEJu3/pkmZRMb1A/EFRF9
 NmzzcqWg5DHTiA6W0fJEJEK2vFinQxVau74f4o4K+XY8U5M4aXHqjTQRxq1A=
X-Received: by 2002:a05:7022:f99:b0:139:8172:76b2 with SMTP id
 a92af1059eb24-139a2107105mr3424034c88.21.1781910012480; 
 Fri, 19 Jun 2026 16:00:12 -0700 (PDT)
X-Received: by 2002:a05:7022:f99:b0:139:8172:76b2 with SMTP id
 a92af1059eb24-139a2107105mr3424003c88.21.1781910011928; 
 Fri, 19 Jun 2026 16:00:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.16.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:00:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 39/74] target/hexagon: Implement start/stop helpers, soft reset
Date: Fri, 19 Jun 2026 15:58:36 -0700
Message-Id: <20260619225911.159473-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 3iHvtnom9nuxo5VbpS9KyWsGvB316mKB
X-Proofpoint-ORIG-GUID: 3iHvtnom9nuxo5VbpS9KyWsGvB316mKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXx8wdW6kWxLM5
 AeTI6HLiDsjbgCXu9riYD42CDYiKRCoeJqljqAe7Y15ZeO2iWNTpnCJJMTsY3cYl4AKAQe9I2HZ
 l+fipOhmqlQCjraSqsEWART9bjczF0DCKEWU4uyaq5xXi9y1f0KyhPGbzIo30gPkvnJazRtnu31
 fBXb+AAp6vtKSRTgURN/4q06vD7cjLBVaFF2/D/flQm2LdYj3yN3G47kkkzsBEiN9H7iAWCTT9o
 gLwVwq9wb1mLuoYTGfJw3SqMP9oeFj/G4UgUBC/6NqINnsbMF2ncNkl4aNgurGuBgYVDKmszElN
 pfnddLK865SpN+DFcLOS4mOp7n9QNOj6uRiVE3AYRsujwBb5AAkcjaCYjdXos4TAa3had6bW2fN
 n+Qa+Z4XbXM6zcD8WpPev8JpETKfJSON3ZRgh7du8Nd61r0Txq9Cjnokoh7kNefPD9Be0CiSTL+
 UXWpoPzXY26PZBUCSLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX9sCXSFxUacOM
 GLXnIgdmJICbFxBvtCXSIBl/ydQXmRqVH4VfHgfVY53QxyrtcGUtqBCOxIsmFFNzcmrUOyNSKkl
 YnYFrGS7WVp0audy3WgjZqr3QM9zdM0=
X-Authority-Analysis: v=2.4 cv=ZOvnX37b c=1 sm=1 tr=0 ts=6a35c9fd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vY3B1LmggICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5j
ICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaAppbmRleCAxYjIyNWUzNWFiYy4uOTJkNGJiOTcxMjkgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0y
MTMsNiArMjEzLDE1IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9l
cnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludHB0cl90IHBjKTsKIAorI2lmbmRlZiBDT05GSUdfVVNF
Ul9PTkxZCisvKgorICogQHJldHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJl
IHRocmVhZCBpcworICogbm90IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNf
ZW5hYmxlZChDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYpOwordm9pZCBoZXhhZ29uX2NwdV9z
b2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KTsKKyNlbmRpZgorCiB0eXBlZGVmIEhleGFn
b25DUFUgQXJjaENQVTsKIAogdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpOwpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRl
eCBlYjFmNzA0OTI5OC4uMjdmMGVmNTBkZjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0zMyw2ICszMyw3IEBACiAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKICNpbmNsdWRlICJzeXNfbWFjcm9zLmgiCiAjaW5jbHVkZSAiYWNj
ZWwvdGNnL2NwdS1sZHN0LmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKICNlbmRpZgog
CiBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25fY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hh
ciAqY3B1X21vZGVsKQpAQCAtMzEwLDYgKzMxMSwyOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3Jl
c3RvcmVfc3RhdGVfdG9fb3BjKENQVVN0YXRlICpjcywKIH0KIAogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKK3ZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3RhdGUgKmVu
dikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHU7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAg
IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0gPSAwOworICAgIGhleGFnb25fc3NyX3NldF9jYXVz
ZShlbnYsIEhFWF9DQVVTRV9SRVNFVCk7CisKKyAgICBjcHUgPSBlbnZfYXJjaGNwdShlbnYpOwor
ICAgIGlmIChjcHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgdWludDMyX3QgZXZiID0KKyAgICAg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19F
VkIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOwor
ICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGV2YjsKKyAgICB9IGVsc2UgeworICAgICAg
ICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworICAgIH0KK30KKyNlbmRp
ZgorCisKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJl
c2V0VHlwZSB0eXBlKQogewogICAgIENQVVN0YXRlICpjcyA9IENQVShvYmopOwpAQCAtMzM5LDkg
KzM2MiwxMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKIAogICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0hUSURdID0gY3B1
LT5odGlkOwogICAgIGVudi0+dGhyZWFkSWQgPSBjcHUtPmh0aWQ7Ci0gICAgZW52LT5ncHJbSEVY
X1JFR19QQ10gPSBjcHUtPmJvb3RfYWRkcjsKLSNlbmRpZgorICAgIGhleGFnb25fY3B1X3NvZnRf
cmVzZXQoZW52KTsKICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKKyAgICBl
bnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworI2VuZGlmCiB9CiAKIHN0YXRp
YyB2b2lkIGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvKGNvbnN0IENQVVN0YXRlICpjcywKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggNmYwMWYzYjkxZDguLmI5Y2YxZjE4OGJiIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTQ3OSwxMiArMTQ3OSwxMiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgaW1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICBoZXhhZ29uX3N0YXJ0X3RocmVhZHMoZW52LCBpbWFzayk7CiB9CiAKIHZvaWQg
SEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQogewotICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CisgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCiB2b2lkIEhFTFBF
Uih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQotLSAKMi4zNC4x
Cgo=

