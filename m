Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A60BC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7K-0005Bq-37; Wed, 12 Aug 2026 11:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB7G-00050w-Sb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB7F-0000R4-2r
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbtFI2728893
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5/n737thazqYjWE2APiBFFarZmcAmui0FVLXX1/ztHU=; b=LhhxdYXqmFp+JhYQ
 bfWlWw0Q/4b3KJ9i6UJGszeOEdbGEzKts3Vx5sQyyXudEZ+Pp6kQ/8Sh9V747HCs
 lxEf9Q5dnhW8Un+Qd7MHXo7pYa3qzT070CUW/G0H/bEgvV5HhvlzGgxn0JA5/Kdy
 qUsSBMgyyGaPegUwREC83soDDbGSkn9KpAtqoGEnsCw3aE4GuTtFpR4lq6v9fwDg
 WnNX3zfcVYBX4ramiVPPlpkovGCjsbHusRRN6OtlPbdAwbaQBJ0tkQlFnW9evK7f
 xmVCPbme4aSyMXNtVMEvjFhAqSjDkmEfLKtBVkklmv1QmPQMp/25jRvwp5ANXFJe
 XbeV+w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw2rk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so924936a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549409; x=1787154209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5/n737thazqYjWE2APiBFFarZmcAmui0FVLXX1/ztHU=;
 b=d9ex4rtC8l7EIvZO66P2qBSo4kFG5hcn1M9Iwyi3CQPsr5h1wJerHvmT9MShlpd9qO
 xm0UhEPorQHcqg+F+KEO7sFZZIR1r1KzMySLUYQZl0Skc0i30FjvCXc60AyMvSUIrR9z
 TuiWV4+BmM12ozS5eSbvEJ4KUGokSaKJO8RDTvrHjKna5qlKh2nqPu1G+yFEV3YpMJzz
 JMIRQlB306k8p4pm6ksjz6R9sw4/5GmNoaGPVAqgKwYaiEFjOF13EwVHDqpBsnIE3M6I
 f7RYXf94xoD7h+ay2sJkufvHycSPITGeuPMPkQXXf7qdINO+QmlFtVkMKdB4BVD08uwS
 qAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549409; x=1787154209;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5/n737thazqYjWE2APiBFFarZmcAmui0FVLXX1/ztHU=;
 b=rasVWtMOlZFe5EfG3GRETRCXoXpKbmQgOy//D0KRF8OkaRBVQn+uu6hlSgeuzqAe/T
 ThuRN0gajZppUq2DeyGo4r6MLgumokpLABLDIKoHqZMRxTNB16iO9v9qFb21L4wU0k/r
 1xsKs4qMqemuLtG2bE9HDmrqaiP+TUrZ27IKBoTzsIHjbt9ztDtZ7PgTjkPSVYXIdOb3
 PZMZJ4sx/hjfXV+4m5G4v7YgHyaIp8ZOxASH5G3MagD6Tsu/47uGe6sEjRIrvTazEqqG
 Hqy2Y4H9+Tw41qk+c8EKa8DBA0j30xdnCVIDFpwNQYbhbs6n5SsSYz/T6DJStNbZ11Sw
 CYbg==
X-Gm-Message-State: AOJu0YzQSunZQHFpJZCRZ/X7d5C+dXva2qCQB+TUbUik0hT5FN77dR2A
 iJdWW/mqLMBQ6HPVKqGQ76tBIq8sOv9dxzWWlriMzKQgnIihFw6VThEiJ6aLL6yPUwTFriwOZFh
 xJl5bNDI0XT57DUlkAveEDkQLe6SPyWwD1ZdTEKcU9RsfzLckTFXDB1MBoFXkKQSzrQ==
X-Gm-Gg: AR+sD10D1zUsLa/UsFsAFe4y91f6QytnwTaGmXvVr7nSqwh2tmN9xOjE6Jv5U6DNheP
 fJQTmP8b+GZP46y5eDRzgHz1w/4Xzi5WwjIHfWHVgrNrsazpIum+8nNs+HczI4fp18h2XtmFUEf
 xglf7ELyV8+WKajSjgIe1el5vo3Rj/kaam/j6vRhRPzpm4cmPLqAzoMCEu2rK/3KKQpsBKC5Zlk
 fAnL8x8QZPDIMW/T+LxUkmiob9mh+5MPi1ge+vaXNhGF5Gm7hI0PuWGJVJ4mWBjoG8+Sqcro4q5
 8JC7yXPdvNpYk3guOPIL5PETzzi8NqbRrURf16QP04F8Glt71IBaQ8cGMm+NUjGqfLWj7r4R7up
 DQwkYR0aFqLh9KTOzvJZIk6Y9kH32odvZfNb+zGzhhATMoyxm
X-Received: by 2002:a05:6a20:c90d:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cc3f8a3a8bmr7270536637.37.1786549409141; 
 Wed, 12 Aug 2026 08:43:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:c90d:b0:3c8:e140:63c3 with SMTP id
 adf61e73a8af0-3cc3f8a3a8bmr7270472637.37.1786549408599; 
 Wed, 12 Aug 2026 08:43:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 33/41] target/hexagon: add v68 HVX IEEE float misc insns
Date: Wed, 12 Aug 2026 08:42:12 -0700
Message-Id: <20260812154220.1029828-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX5a9Lm29BAls8
 P8BgUR+uaGa1MJQXqEEJZqGeMBKbnLmA/nq7iNEfgZOLXGqdh1An4mIrooeUdtBXXToJIR6RwKb
 SPFrg28ykh6CptwwtZUWbYrGE/4yRh8=
X-Proofpoint-GUID: CRksGj3DeEdPDB9HiLNQXjfdEhwySlt6
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c94a2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=G0yDBwImisZ_IgVzhjkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: CRksGj3DeEdPDB9HiLNQXjfdEhwySlt6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX6GT1SaGhhmox
 RQpfG0YNdHpCKIpOy5bNvqrVvhhSRNlrThkqNCrStR3UsID2ab++8T7BSctIYIPA3f2KD2FYBhv
 YvOKjEhvPnT9iPN6vgOgnzsnOzID9649ccCk0g9hpe20Fw7W+01dqGjITbRUNlOjMwECzqImNg/
 fm7RrPQjXaf87UbybMaKG12GQ+YCt47XB632sqQcRnKI/+BIj9RzyZCyOVLOrmgIFrNXllqyKW4
 V67nC1md1VJiWKFMTM6dnccokGIHfTU2DWpGdTYNqmS6PbloDMs0BSEHi5JF9GR5BiLcNa9sdLY
 2DYPlOnPtBaiESfA3+PLnK+nsSLnmD5uY8ExHKPnq64byP/YqlvQ+et5r96a0ddXjOzvNc8X8e5
 MGdr5hwvsVQmwZJOnal/T/w086Dui8dLGaY5FR37Q/CzXmNY3TBczCSu0rymciK71kW7WzTogRj
 H6PrMgss5ZRNoWxlNXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKQWRkIEhWWCBJRUVFIGZsb2F0aW5nLXBvaW50IG1pc2NlbGxhbmVvdXMg
aW5zdHJ1Y3Rpb25zOgotIHZhc3NpZ25fZnAgKHZmbXYpOiB2ZWN0b3IgbW92ZQotIHZmbmVnX2hm
LCB2Zm5lZ19zZjogdmVjdG9yIGZsb2F0aW5nLXBvaW50IG5lZ2F0ZQotIHZhYnNfaGYsIHZhYnNf
c2Y6IHZlY3RvciBhYnNvbHV0ZSB2YWx1ZQoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxs
dGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBC
ZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8wYmQzMjc5Y2EwYmJmN2MwMTU0OGUzYjRlN2E5
YzhmZGJkYmU0ZWUxLjE3NzYzMzk0NTEuZ2l0Lm1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNv
bW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiB8
ICA3ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmICAgICAg
IHwgMTIgKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiBi
L3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2VuY29kZV9leHQuZGVmCmluZGV4IGQ3ZjUw
ZGI3Nzg1Li43MmRhZjg3MjRjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
bW12ZWMvZW5jb2RlX2V4dC5kZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMv
ZW5jb2RlX2V4dC5kZWYKQEAgLTgzMyw0ICs4MzMsMTEgQEAgREVGX0VOQyhWNl92bWluX3NmLCIw
MDAxMTExMTExMHZ2dnZ2UFAxdXV1dXUwMTBkZGRkZCIpCiBERUZfRU5DKFY2X3ZtYXhfaGYsIjAw
MDExMTExMTEwdnZ2dnZQUDF1dXV1dTAxMWRkZGRkIikKIERFRl9FTkMoVjZfdm1pbl9oZiwiMDAw
MTExMTExMTB2dnZ2dlBQMXV1dXV1MTAwZGRkZGQiKQogCisvKiBJRUVFIEZQIG1vdmUsIG5lZ2F0
ZSwgYWJzIGluc3RydWN0aW9ucyAqLworREVGX0VOQyhWNl92YXNzaWduX2ZwLCIwMDAxMTExMC0t
MC0wMTEwUFAxdXV1dXUwMDFkZGRkZCIpCitERUZfRU5DKFY2X3ZmbmVnX2hmLCIwMDAxMTExMC0t
MC0wMTEwUFAxdXV1dXUwMTBkZGRkZCIpCitERUZfRU5DKFY2X3ZmbmVnX3NmLCIwMDAxMTExMC0t
MC0wMTEwUFAxdXV1dXUwMTFkZGRkZCIpCitERUZfRU5DKFY2X3ZhYnNfaGYsIjAwMDExMTEwLS0w
LTAxMTBQUDF1dXV1dTEwMGRkZGRkIikKK0RFRl9FTkMoVjZfdmFic19zZiwiMDAwMTExMTAtLTAt
MDExMFBQMXV1dXV1MTAxZGRkZGQiKQorCiAjZW5kaWYgLyogTk8gTU1WRUMgKi8KZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmIGIvdGFyZ2V0L2hleGFn
b24vaW1wb3J0ZWQvbW12ZWMvZXh0LmlkZWYKaW5kZXggMGU5Y2FjZTIwMzUuLjFiMTZlZDA2Mjhh
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9leHQuaWRlZgorKysg
Yi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9leHQuaWRlZgpAQCAtMzAzNCw2ICszMDM0
LDE4IEBAIElURVJBVE9SX0lOU05fQU5ZX1NMT1RfMlNSQygxNix2bWluX2hmLCJWZDMyLmhmPXZt
aW4oVnUzMi5oZixWdjMyLmhmKSIsIFwKICAgICAiVmVjdG9yIG1pbiBvZiBoZiBpbnB1dCIsIFZk
Vi5oZltpXSA9IHFmX21pbl9oZihWdVYuaGZbaV0sIFZ2Vi5oZltpXSwgXAogCSZlbnYtPmh2eF9m
cF9zdGF0dXMpKQogCisvKiBJRUVFIEZQIG1vdmUsIG5lZ2F0ZSwgYWJzIGluc3RydWN0aW9ucyAq
LworSVRFUkFUT1JfSU5TTl9JRUVFX0ZQXzE2XzMyX0xBVEUoMzIsIHZhc3NpZ25fZnAsICJWZDMy
Lnc9dmZtdihWdTMyLncpIiwgXAorICAgICJWZWN0b3IgSUVFRSBtb3ZlIiwgVmRWLndbaV0gID0g
VnVWLndbaV0pCitJVEVSQVRPUl9JTlNOX0lFRUVfRlBfMTZfMzJfTEFURSgxNiwgdmZuZWdfaGYs
ICJWZDMyLmhmPXZmbmVnKFZ1MzIuaGYpIiwgXAorICAgICJWZWN0b3IgSUVFRSBuZWc6IGhmIiwg
VmRWLmhmW2ldID0gZmxvYXQxNl9jaHMoVnVWLmhmW2ldKSkKK0lURVJBVE9SX0lOU05fSUVFRV9G
UF8xNl8zMl9MQVRFKDMyLCB2Zm5lZ19zZiwgIlZkMzIuc2Y9dmZuZWcoVnUzMi5zZikiLCBcCisg
ICAgIlZlY3RvciBJRUVFIG5lZzogc2YiLCBWZFYuc2ZbaV0gPSBmbG9hdDMyX2NocyhWdVYuc2Zb
aV0pKQorSVRFUkFUT1JfSU5TTl9JRUVFX0ZQXzE2XzMyX0xBVEUoMTYsIHZhYnNfaGYsICAiVmQz
Mi5oZj12YWJzKFZ1MzIuaGYpIiwgXAorICAgICJWZWN0b3IgSUVFRSBhYnM6IGhmIiwgVmRWLmhm
W2ldID0gZmxvYXQxNl9hYnMoVnVWLmhmW2ldKSkKK0lURVJBVE9SX0lOU05fSUVFRV9GUF8xNl8z
Ml9MQVRFKDMyLCB2YWJzX3NmLCAgIlZkMzIuc2Y9dmFicyhWdTMyLnNmKSIsIFwKKyAgICAiVmVj
dG9yIElFRUUgYWJzOiBzZiIsIFZkVi5zZltpXSA9IGZsb2F0MzJfYWJzKFZ1Vi5zZltpXSkpCisK
IC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioKICBERUJVRyBWZWN0b3IvUmVnaXN0ZXIgUHJpbnRpbmcK
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiovCi0tIAoyLjM0LjEKCg==

