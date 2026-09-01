Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6986C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SN3-0005Xu-Gw; Tue, 01 Sep 2026 13:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN0-0005XJ-3o
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SMy-0007zu-Av
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HTpAo2594409
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oB+OTqvYes+sTStslsJP4i
 qzjAV61z/V/QtLN36AgSc=; b=aVE6ka3cHdS1G6kzmDz+PrdXPj0x+PxVvLy8s3
 1mWRKyj8QWD+QMBNDQzuBKt7j8SiBveorL+0ibJg6pGGbKJJdTEXoNryM8GTs0Hc
 WxvFXRvsRfzrHpMx4ceaRPQujU9KgxthxilzgY28HEUzyZx6yynZKUWwz3o79RH+
 NrilehupihDkt03+H8ZToBiMQsFSj2dlG9j5AObqoEvUkll0pazGC8qYUpxMNSp9
 V5FklAp8JkQhR1QQXZzPR0RlsbxsfbalwzeM0R6/DeodgaNnrESlDgIHwNbHKCHt
 CEzIiRwI/vellqF9Yfc8HxrOrwUi8K4LVkL4nz/0bVpmeTTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k00gp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:33:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39906175917so99282a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284036; x=1788888836; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oB+OTqvYes+sTStslsJP4iqzjAV61z/V/QtLN36AgSc=;
 b=iVq24l5sasQqcu64g3dQ2bILAO5TmLbVZcyN8MFIhiADp/2JuKaTr/LUl6Okuh9/g4
 M+9bQTUvTv7XBNWKRzTpYh5dVOXTKwut/jo5eVPnnR/+CiYMUClXrNI2iUlkBQqNhK6F
 ntvBiMmPYN/J9ApaRHyiZUQ/aokTlLDn/i3IBDExqBhk+U5ZIbtyKSS0ixNUqLjiidHL
 2OK7JeSMjudy4iq9/9/kLjMBxaa/8YBegOCZekA2dpJ2au6Vd0I8CIfi4NeeFjUdww1a
 E/RjlXYqGs0zYav45fcEBeC56kYt8oZZLllXzVjUPxh7NPNx8q9rp6woK2ESm0lGc/xP
 O7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284036; x=1788888836;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oB+OTqvYes+sTStslsJP4iqzjAV61z/V/QtLN36AgSc=;
 b=L8ajGeIhd4Z4YlDRh+jGfPu0gza8T4suI4dQTstBlkEsvhg28l9six1eWddiArkueG
 Y3ASG/S/ixi5eJuhFcqif6UzZsfilKxaQdXS5mHcOQAaTCG2Jhaf1z0aqQHBOfrO+UJl
 u/MToaZreENamk64t2U3bcjzEUBzP70ek4heH8c0I9W/6VUDdthNDTfANCDyEFmAEfX5
 Sh/SAL9roAd8je0z4y2Ru0cOpQmf9fkUDbmSsDu6Xq1DtMM36p1LE3NjZTRKp7yBJUd0
 3JG5MsR9eq7ClIez53u98CqCtf5wFEMOsoecnxnN04wxRe/mmJ0Oc8c44m3+jE7FdpJ4
 /U6A==
X-Gm-Message-State: AFuF++n9Zs+UGJ3zhrQL7dUhDgyhy7JANtu4cVIaHnryPjJGUiGEdzsq
 eF4VurHQogSZhbqgldIQODg30luy12gPL7bLE+M+/vOCG1s5wdy3l8RGxUqk9ZR12lb3oZvMh44
 P7ww7vzorvl7IU4Xoj8ifte+KuMRT5Yqg6/zWYaa71JCdiuw4GPK7IaXyw90c+CpLcA==
X-Gm-Gg: AYBFou3PhhLZJir3a/8bw9MhRY9nTU+Tl18BxJPZZWN8TNMHVepGY3zD7wupaTxjZbl
 NHE6/VGiW+KPr9UAGfXSYy2WKOz1gcxkIJ0PqmeLCeSv37IMUOEgH3pe1IrNrw/DPgCre8Zxrmi
 Qs/gP7E4lYkZTxQKbUXIaAdFPBlsBt64rEwNeej4AYRhutP+tYII8r07AQTxpQRawCuV6IkJEAb
 y+IgbshiG+KBAVmXKqyv0nN36smw2zMxNBj/SUdFkoOb1oXiqUHq0Fm9KysMKN/4Oc0JpM2se8T
 nTh+sp1kjqz3FMkF5Gk27mSsFwxZ8iaqUKbrTKTR8H8MsiitWRgIktdxOfkCeoD0L5adDq6BBgC
 XnCH7qvjz0j2shc4b2hIOg03huz+bnFzUL6wkw3+VRCtIbuq1
X-Received: by 2002:a17:90b:1d83:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-396d1023217mr46103564a91.14.1788284035788; 
 Tue, 01 Sep 2026 10:33:55 -0700 (PDT)
X-Received: by 2002:a17:90b:1d83:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-396d1023217mr46103524a91.14.1788284035290; 
 Tue, 01 Sep 2026 10:33:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:33:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 00/11] Hexagon: exception, interrupt, system reg fixes
Date: Tue,  1 Sep 2026 10:33:42 -0700
Message-Id: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NCBTYWx0ZWRfXzPmbnl/WVYtM
 zZMBi5qe6a2mB/PFHojvmpP5dysvNrgJD8mF213ddWbAUP4vDTx9ySBYc6TVBd2H5wYSIBIvDfW
 mlSMmBfMbJQ2WeJpVA99hzsY3zgXluE+HyyNcTlJUhl7U4CIIUKpM1cys3f6GFCuuai6Gj6Kv3u
 XEouFDy+5nYZMdnNe2Ywkf2DKsFIPqKKl5qERvdtCen4SY55VM34kWt7xqMYU2z3+JGjPn4Alh6
 as7T4imimCrH/UkUV++aLk/NAePPCpIhxCldtn7YIrJoyV3lSsJ4uRE10C9OIYhGT3kbVBzFGcM
 fgnqTH95TWN+u3QgDobgiAhvde6LOQ+zecowN+69Nc09Xu9coKUJp6tBm9PZ1XBnLepIJPsMrgJ
 nbR1aeytkK2HTAFVLIamCNWpyJCJcPqOBeRlSYNy6OwUBCzVmxLFrrE0UzbJsHle0KOBvxfd+LJ
 NUyE648n42kG1Cm/PMg==
X-Proofpoint-GUID: 2SH-CX9KmZSye8KX6F7t6LVua85aQxEb
X-Proofpoint-ORIG-GUID: 2SH-CX9KmZSye8KX6F7t6LVua85aQxEb
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a970c84 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-t2gi_CsGC9hvwCbGDEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NCBTYWx0ZWRfX6Z0fW3aIdb2O
 XUQHVgtn6/X3lp+dMLyXBGr3JgiBltRSQE8BVqX+WsfOtzgA6tBE5Ix5J+KCHjyoRe0ltxVsT8q
 LfFSkrlGO4XKk4s5yPBqI1pYgfnoe0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010154
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

Q2hhbmdlcyB0byBhZGRyZXNzIHNvbWUgdGVzdCBjYXNlczoKLSB1c2VyL3N5c3RlbSBtb2RlIGV4
Y2VwdGlvbiBjb25zb2xpZGF0aW9uCi0gRGlyZWN0LXRvLUd1ZXN0IGludGVycnVwdCBkZWxpdmVy
eQotIGludGVycnVwdCBtYXNrIHdyaXRlcywgdGxiIHByb2JlIGV4Y2VwdGlvbgotIGwydmljIGVk
Z2UtdHJpZ2dlciBjbGVhciBvbiBkZWFzc2VydAotIG1hcCBhcmNoaXRlY3R1cmFsIHRpbWVyIHJl
Z3MgdG8gY2xvY2sKCnYyOgotIGZvciBgZ3VhcmQgd3JpdGVzIHRvIHVuaW1wbGVtZW50ZWQgZ3Vl
c3QgcmVnaXN0ZXJzYDogdXBkYXRlZAp0aGUgbG9naWMgdG8gZWFybHktcmV0dXJuIGFuZCBjbGFy
aWZpZWQgdGhlIGNvbW1pdCBtZXNzYWdlLgotIGBpbXBsZW1lbnQgZGlyZWN0LXRvLWd1ZXN0IGlu
dGVycnVwdCBkZWxpdmVyeWA6IGFkZGVkIGEgY29tbWVudAp0byBleHBsYWluICJkdGciLgoKdjE6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MTkwMTMxNDQuMzI2NDA5
Ni0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDEwKToKICB0YXJn
ZXQvaGV4YWdvbjogYWxpZ24gZXhjZXB0aW9ucyBmb3IgdXNlci9zeXNlbXUKICB0ZXN0cy90Y2cv
aGV4YWdvbjogY2hlY2sgcHJpdiBpbnN0cnVjdGlvbnMgcmFpc2UgU0lHSUxMCiAgdGFyZ2V0L2hl
eGFnb246IGd1YXJkIHdyaXRlcyB0byB1bmltcGxlbWVudGVkIGd1ZXN0IHJlZ2lzdGVycwogIHRh
cmdldC9oZXhhZ29uOiB0YWtlIEJRTCB3aGVuIHJlYWRpbmcgdGhlIHN5c3RlbSBwY3ljbGUgY291
bnQKICB0YXJnZXQvaGV4YWdvbjogZ2F0ZSBHUENZQ0xFIGd1ZXN0IHJlZ2lzdGVyIHJlYWRzIG9u
IFNTUjpDRQogIHRhcmdldC9oZXhhZ29uOiByZWFkIFVUSU1FUkxPL1VUSU1FUkhJIGZyb20gdGhl
IGdsb2JhbCB0aW1lcgogIHRhcmdldC9oZXhhZ29uOiByYWlzZSBpbXByZWNpc2UgZXhjZXB0aW9u
IG9uIG11bHRpLVRMQiBtYXRjaAogIHRhcmdldC9oZXhhZ29uOiBpbXBsZW1lbnQgZGlyZWN0LXRv
LWd1ZXN0IGludGVycnVwdCBkZWxpdmVyeQogIHRhcmdldC9oZXhhZ29uOiBmaXggaWFzc2lnbnty
LHd9IHRvIGNvdmVyIGFsbCB0aHJlYWRzCiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiB1cGRh
dGUgdG8gdjAuMi4xMiwKICAgICt0ZXN0X3tpbnRlcnJ1cHRzLHN5c19yZWdzfQoKU2lkIE1hbm5p
bmcgKDEpOgogIGh3L2ludGM6IGNsZWFyIHBlbmRpbmcgYml0IG9uIGwydmljIGRlLWFzc2VydGlv
bgoKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oICAgICAgICAgICAgfCAgMyArLQog
dGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdl
dC9oZXhhZ29uL2hlbHBlci5oICAgICAgICAgICAgICAgICAgICAgfCAgNCArCiB0YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAgIHwgIDYgKy0KIHRhcmdldC9oZXhhZ29u
L3JlZ19maWVsZHNfZGVmLmguaW5jICAgICAgICAgfCAgNyArKwogaHcvaGV4YWdvbi9oZXhhZ29u
X3RsYi5jICAgICAgICAgICAgICAgICAgICB8ICA1ICstCiBody9pbnRjL2hleC1sMnZpYy5jICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKwogbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29w
LmMgICAgICAgICAgICAgICB8IDMwICsrKy0tLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxNSArKystCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMg
ICAgICAgICAgICAgICAgIHwgMTIgKystCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAg
ICAgICAgICAgICAgIHwgMjkgKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMu
YyAgICAgICAgICAgICB8IDkxICsrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24v
aGV4X21tdS5jICAgICAgICAgICAgICAgICAgICB8ICA1ICstCiB0YXJnZXQvaGV4YWdvbi9oZXhz
d2kuYyAgICAgICAgICAgICAgICAgICAgIHwgMzcgKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9t
YWNoaW5lLmMgICAgICAgICAgICAgICAgICAgIHwgIDUgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jICAgICAgICAgICAgICAgICAgfCA3MiArKysrKysrKy0tLS0tLS0tCiB0YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwgNTYgKysrKysrKysrLS0tLQogdGVz
dHMvdGNnL2hleGFnb24vcHJpdmlsZWdlZC1pbnNuLmMgICAgICAgICB8IDc5ICsrKysrKysrKysr
KysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jICAgICAgICAgICAgICAgICB8IDEx
ICsrLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8IDE4ICsr
Ky0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAxMiArKy0K
IHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCAgICAgICAgICAgfCAgMSArCiAyMiBm
aWxlcyBjaGFuZ2VkLCAzOTUgaW5zZXJ0aW9ucygrKSwgMTA2IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5jCgotLSAKMi4z
NC4xCgo=

