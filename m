Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08001606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aUGuSB38;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eJFjas/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvnf-0006mL-1H; Tue, 24 Nov 2026 14:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnV-0006kK-SR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnT-0006gs-T3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:21 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXU3i1618140
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iblzicKTOsgvQkE7KL9kpd
 u8qG8vgeBJvD31SgbH0Fw=; b=aUGuSB38oXfBdpBO7qjHQdy20rDWsmyw/oFYOM
 rPvBLKSAuTywvCV0iqXPZPG9bEeNt+eqA9LPWo10nGopbr2b1JRoE0D7RRz4f1k0
 lZiDKLWBzAcyOKQ/h4eXoTkONJgnn4iTMEb+XjPiT9yOhSmyKa0PHk4f1CAupRsV
 SzFaKU3B1lsOdFJ/Kj3zxifVo/Xkoyl8UXmGS7a2MWuZmlszkS4B2jgCmAtrYw/A
 vz84wU+dEj2Qeao3KbIJP/Ag1iBRiyhAoUhwyNHMw0zEoLKO0cdlV4JvKb9HPhGD
 mJBZ4teGSM6JyqAguGgXbbzGusoqVyz60bafzW+7UkH44+Tg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky4d6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:18 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4dab94dc3e7so10704638b6e.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546997; x=1796151797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iblzicKTOsgvQkE7KL9kpdu8qG8vgeBJvD31SgbH0Fw=;
 b=eJFjas/qtM5JJgF1W8O+0YNc5RMmnFZG88Rn1Bc6UNVQ4VSKZ41eEvTZlH5wJetRjH
 ruYYerT6drmLQA3X4e/D4RqMfR/Gq4m32DE/Ank4k1ESiNgXqnMsMeArygK7z/rgZEfj
 Qv4Xjmxg63X2plyRcGSFi22R6DaVLmG5hTlrC2aTWXuTC4Z6r093tjx8EPBNGyk79rxx
 30Qrj8ezeaOs1lQDo3SAKoTmGAadW36hVoiQq6Qj+2bw6lDG2CKB6W+Av7G4OT+2BvTV
 IYWv8V3xOvIcgQ0AuOUTCOMkBLXD4A1lhGLFpxKkdFtRt0DhzSCmdcWcsVtsH9oJHLZ+
 OT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546997; x=1796151797;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iblzicKTOsgvQkE7KL9kpdu8qG8vgeBJvD31SgbH0Fw=;
 b=vTEZJR8OWxmf5IdVy3mLWyxHCVdFQXch1YgQhAcrJzA4n/uUzqwPTfbDcYqFvKyE6P
 SOrFiMotcvMy0PqpakEYyV9KhrUceACqpOyYyV863eT6ySPRcu0JUQLPyF8DTpjHmOur
 WppOFEnarfw31m0YNRjPH8YmtQfmAwrmtbpgV0TFYa8TBKBygwhykU0kO9HORJb49Q3s
 W23Z09mKhxXDrXSf9S0SGwi7+nv1lRsyo5qL8TskU2rYkTClarn3sCUPEKYc/v29xvJz
 erYYy+6gsRKEzPO2H4zp7byA/BDvCVL8bpCPzpzjvNY/IVeFxBiFfJbcnf6sA/tm6FPC
 pKsw==
X-Gm-Message-State: APuU4Z9jwHCnDRhnPoKE3sN6W61ZkcVdcK5sERDEJBpXaA5cYcHkKs9e
 NHWBi8ONabgYOeKtpSVRxUuY0KY7xdpJhHC9mS4lWY9xsN+ihxQbNHfO6yV7O8UTZwNQtlgtk1b
 koaxsKoDT8DLqgxRIaBzD5XwvBJhJ64FlGmTf/FNRca3ufiQ7Q1SiWE8OsAaDY+UX0w==
X-Gm-Gg: AZFdTZf7uv/ud9psKKfmsVvFh8pepJEoxf8PDMTJPRrKIX7NBFFxYMGD4o8gsvCJV1H
 OtyEMhsZehjEbOY8kkCEKgs5DJ8oB9hF8t/9es6EcfFJMOOhRBFGsQpgBqWS6vLl9HUVFUuloBU
 HzBVL2LpJcOac3ClCTKFG46WU2gQlPq+2DY8BqPqLBzcsMpCwSK3PZusDUiBM5bif+qe19MNOq5
 IiA1zGToJRkvpTznWPhe5hgawLAbkCCe0KS1Sd5tR9EemXnp1vkKYtVCIME2t3GH8fEXqNxEIFE
 vZq23hox0xcD6VSS/Kq8jS/dMVx95dZaSDl30jLjzwN77vxu6NmQSt1nJRoEKU2v9j0b6LYPEaV
 yLraOiXr1QtSR/MZ+jenEy16dWnzNPg9kB3QyVImp3Nm8eiivoC/yEfwEZ+MEi0xSqUT/z/WEX3
 RZQNET9pLV3aKCchL5SSSzMQ==
X-Received: by 2002:a05:6808:c12e:b0:572:1c6:6108 with SMTP id
 5614622812f47-57a0a20aff8mr17219606b6e.12.1795546997278; 
 Tue, 24 Nov 2026 11:03:17 -0800 (PST)
X-Received: by 2002:a05:6808:c12e:b0:572:1c6:6108 with SMTP id
 5614622812f47-57a0a20aff8mr17219568b6e.12.1795546996859; 
 Tue, 24 Nov 2026 11:03:16 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:16 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 0/7] Hexagon: fix systests + migration
Date: Tue, 24 Nov 2026 11:03:07 -0800
Message-Id: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05df76 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7by6yNVA7aV1XjCT5ekA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: ikhhBX-TQSvETOyjOEhTb-7GuQBCHk0v
X-Proofpoint-ORIG-GUID: ikhhBX-TQSvETOyjOEhTb-7GuQBCHk0v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX9VLfrHHArhXQ
 zNUFxerqEc3FY2Cxo9Wu+mb7AmyqjLkDiPMLKhdOY7mo3Rem4wE+E0q2PEOdO4w31lo9vjTYbGK
 au1JTqJPYilz/yEArUOUYFfERiee0iI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX4FRs6hZRmb3o
 jUQCYkUsTyPF6PBYa6wlkzSFpmxWkChC+MiiTmS0dQTX8HgwDW8cV4J8qJBtsNM9RRWv2Ezmv+5
 1JqBVaarSsUs8suHh25w7ty7j026d388BRAZhmsuHWLTaX3uOc8fY9MFdiJya/uRC8be/XLLlJp
 +roP/yb+O8JtIUBfwHzrztJCW2yHaJNySKRl5Mrm6ntR8mUk8AtQU/UTk3fTjPRFL9nWBiaIACJ
 SQwfJHA6bbcjzitNx50NkGwEImHyRJcEJMuqY9FRGFYW8cB/DuP4z6ZFqgZWobXFYDxkdfXsAhi
 koCe1x3zTBvcgrYa0y8g6yPYodHIGnE7qU5SiJ6G4tQSigZwzpx53zryv1O05H70oz21pFyX6sW
 1R7xw07gTHLk+02KvcogCCt2xcL+uS1vCZDGwDmYmqCmctA394WXNxcJGWbs47I7RETnvd+OZJC
 zeLUtSA0re4TxR8sUmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIHN5c3Rlc3RzL2FyY2ggdGFyYmFsbHMgd2VyZSBjcmFmdGVkIHdoaWxlIHRlc3RpbmcgYSBk
b3duc3RyZWFtIGZvcmsuCgpFbmFibGluZyB0aGUgb21pdHRlZCB0ZXN0cyByZXZlYWxlZCBhIGZl
dyByZW1haW5pbmcgYnVncyBpbiAxMS4yLiAgQWRkCnRob3NlIHRlc3RzIGFuZCB0aGUgYXNzb2Np
YXRlZCBmaXhlcywgcGx1cyBhIGNvdXBsZSBvZiBmaXhlcyBmcm9tIE1hcmNvJ3MKcmVjZW50IHNl
cmllcy4KCkluIHYzOgotIGRyb3BwZWQgdGhlc2UgInRha2UgZXhjZXB0aW9ucyBmb3IgY2FjaGUg
b3BlcmF0aW9ucyIsICJ1cGRhdGUgdGhlIGdsb2ItcmVnCnZtc3RhdGUgdmVyIiwgInBhY2tldCBh
bmQgQ09GIGNvcm5lciBjYXNlcyIsICJ2ZXJzaW9uIHRoZSB2aXJ0IG1hY2hpbmUgdHlwZSIsCiJy
dW4gdGhlIHJlc3Qgb2YgdGhlIHRlc3RzIiwgcGF0Y2hlcyBhcyBvdXQtb2Ytc2NvcGUgZm9yIDEx
LjIgcmVsZWFzZS4KLSBDb3JyZWN0ZWQgdGhlIFNQRFggaWRlbnRpZmllciBpbiB0ZXN0cy90Y2cv
aGV4YWdvbi9wYWNrZXRfdXNlci5jCgpJbiB2MjoKLSBkcm9wcGVkIHRoZSAnYWRkIEhleGFnb24g
dG8gdGhlIG1pZ3JhdGlvbiBmcmFtZXdvcmsnLCAnYWRkIGEgSGV4YWdvbgptaWdyYXRpb24gc3Rh
dGUgdGVzdCcgY29tbWl0cy4gIFdpbGwgdGFyZ2V0IHRoZXNlIGZvciAxMi4wIGluc3RlYWQuCgp2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTEyMDE4MjAzMS41NjA0
ODEtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjYxMTE5MjAxNjAzLjIzNzc5ODktMS1icmlhbi5jYWluQG9zcy5x
dWFsY29tbS5jb20vCgpCcmlhbiBDYWluICg1KToKICB0YXJnZXQvaGV4YWdvbjogZml4IGdldF9l
eGVfbW9kZSBhc3NlcnRpb24gaW4gaGV4YWdvbl9zdG9wX3RocmVhZAogIHRhcmdldC9oZXhhZ29u
OiBkZWxpdmVyIGZsb2F0aW5nIHBvaW50IGV4Y2VwdGlvbnMgYWZ0ZXIgdGhlIHBhY2tldAogIHRh
cmdldC9oZXhhZ29uOiByZXBvcnQgdGhlIGZhdWx0aW5nIHBhY2tldCBmb3Igc3RhY2sgbGltaXQg
ZXhjZXB0aW9ucwogIHRhcmdldC9oZXhhZ29uOiByYWlzZSBkZWNvZGUgZmFpbHVyZXMgYXQgdGhl
IGZhdWx0aW5nIHBhY2tldAogIGh3L2hleGFnb246IGhvbm9yIGNvbmZpZ3VyZWQgUkFNIGJhY2tl
bmRzCgpNYXJjbyBMaWViZWwgKDIpOgogIHRhcmdldC9oZXhhZ29uOiByZWFkIHRoZSBvbGQgcHJl
ZGljYXRlIHZhbHVlIHRocm91Z2ggQzQKICB0YXJnZXQvaGV4YWdvbjogYm91bmQgcGFja2V0IGxv
b2thaGVhZCB0byB0aGUgY3VycmVudCBwYWdlCgogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAg
ICAgICAgICAgICAgICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAg
ICAgICAgICAgfCAgNiArKystCiBody9oZXhhZ29uL2hleC1zdWJzeXMuYyAgICAgICAgICAgICAg
ICAgICB8IDEwICsrKystLQogdGFyZ2V0L2hleGFnb24vYXJjaC5jICAgICAgICAgICAgICAgICAg
ICAgfCAgOSArKystLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAg
IHwgIDEgKwogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgfCAgMyAr
LQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICB8ICA0ICsrLQogdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAyOCArKysrKysrKysrKysrKy0tLQog
dGVzdHMvcXRlc3QvaGV4YWdvbi1jb25maWctdGVzdC5jICAgICAgICAgfCAyNiArKysrKysrKysr
KysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9wYWNrZXRfdXNlci5jICAgICAgICAgICB8IDM4ICsr
KysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0
ZXN0cy5weSB8IDE1ICsrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAg
ICAgICAgICAgfCAgMSArCiAxMyBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKSwgMTUg
ZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vcGFja2V0
X3VzZXIuYwoKLS0gCjIuMzQuMQoK

