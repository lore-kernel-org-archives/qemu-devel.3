Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F6ACA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7Tn-0001tI-Ul; Mon, 12 Oct 2026 00:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tl-0001sk-G4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tj-000171-0H
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lMld916407
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=98tWezUZfhwLZxUdLGQ1qu
 pxVmvjwQvOgWfs3Z32VPE=; b=QYrl1MJccZ/LApS4+pDQV0V4qybEhR3ktF06Nr
 W4ad2gHrEVhv/V5kQ6IMgnHm44bz8DUSx9IQlSk0MqeLEU3sbt/Urg2mxdI/KjE8
 7oiErV6fp2WRdx7HyM9aLMnswtiL2jcefO8+znA2wpKFKWlaL+qBSpBD8LjhzfuK
 udqkz8l7uLSHNyPgU1k7C69EgueRIRy6F29zinzJp1CJx9sISJlAsI7NSmrRX1fS
 nv8VkXoJHkBw9/NIs5+zMo622Nic1aRUe++0qCiBCRU64Ng0tCcpA6SlJivwXb7j
 NobfGuLb+19CN0H984dqoy6ZjRhxijOSE44XZXtid+Zuuc8w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24nbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so1505587eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778646; x=1792383446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=98tWezUZfhwLZxUdLGQ1qupxVmvjwQvOgWfs3Z32VPE=;
 b=i5Uw+Tk9R3MZ3YHYLYuZkbxmxa1TnGl8uHc9LEQO66cWpHAh9teBrYKx7skyxGPYVl
 s4aXf0MXdOS5e6K9/kdSi+vBI07eqwudNDhfcUrb+Z/NCWN1gQZCzGH6gul0Dvk5pDSF
 djhXKpk4vilnU7s6TRSd+gFx83bXmrd3FalIfEw5d2iJWMqpFjggk6JXkR7EK0F9zOju
 /p2R4xRSR7QP+MWlbmdxsHpI6EGpKn3OOKv57Kw372gyPUlBM23r/tH0R70X/c0y30RE
 QpdTkdm1lfbB5qb1bBwXs1wy1A+pptEYSdIJ3ekYXtu1jK60DKS+zDAeTJeAAF3E9yWq
 FWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778646; x=1792383446;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=98tWezUZfhwLZxUdLGQ1qupxVmvjwQvOgWfs3Z32VPE=;
 b=d9YTUab4TvT57+WW/hsT2tmK9ekbb1jRyyOXIpjaT+avQCQnb7gMb8OGXVe7QpsW8+
 pIlQNO23bT075B/pRmFhROBkQokoYKVr7hGDuwFEw9dMfON6PjAJOinHUVLmsEKfx/T4
 cg78fQeRlEbTe4+UiycwNr5LU6MVlZDH7X6uXjIVUfUJWEwqsmNKzIdgKIJDTs129Cje
 Z2DkJ5xlMz6D6AucxU7BeGvtgySST2J1poEPN+458UYN1iWAw9ynBvA5KLY5xLC37cmV
 AM4xTx4pEIoxyg7+PHtDTnU4Hj7XFAX+/Ix7v+8QzrIxLCAJT8AZ1Zb7lMCwqLPTTSrB
 PhEQ==
X-Gm-Message-State: AFq9FYIp3Px52c0KuA4tAe9AtNwl8XYBK0rLukgIdA7Vf4hpPwl5AVTs
 v8b4f/cXtqwWGsRE3GcSUhmebiR4yU/sE0oy0/yurQr/OAiZ+J6dXFietmyyU/QBvhr8qfhWRk0
 3fP3lgioYMTjXJeli22JQb03tBIy+0FN0Pl3QZ/A/2w2HL9OKjJeZYCt0rPPMxbuonw==
X-Gm-Gg: AYBFou29OpubOc+fT9MXBMYbEWZE25h7JaX6Gcerny2WKxhSatYHv3Ny1+QeeqB+C1f
 bR9iFSheVEZHvKCyFnz1/R9IRV7cgpzwebgIL9wvqVHKImQB74zNTWSOsNDyEZfmKDH8GuSq5pI
 ODZlVmbnO3ySj5YhVRl6FG1aGHh4rW81CsTNnKBu5wk7H5KwjpPKwlbteNpZBJmiDQimz8JuAVN
 9jgDXAxLe4DysoEKI219L6XkQLSh4U94aUU+E9FFPe1wb1cCH5lpqhTB3jijY44tH6SOM1q5q+d
 ex9CZ4pLN8Kz2pGTEioH/9tQ5L9OGjmZJOdHmlPYSg9aufF8df1qgTL6QWHuGUadYMZC2RZ2zQr
 uQnG+LlrXxUDOchhL8+N8+StUgkVgWvlF72xzPhhFtEHKM4A=
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-35a47edc590mr3305414eec.37.1791778646328; 
 Sun, 11 Oct 2026 21:17:26 -0700 (PDT)
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-35a47edc590mr3305385eec.37.1791778645765; 
 Sun, 11 Oct 2026 21:17:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 00/25] hex queue
Date: Sun, 11 Oct 2026 21:16:57 -0700
Message-Id: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: J7esRZYs8GPvgD0e0B1WNcKaN2JbMwPj
X-Proofpoint-GUID: J7esRZYs8GPvgD0e0B1WNcKaN2JbMwPj
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc5f57 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=8P3fkRyKrpD4u59XIs0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX5iYjKcl9t7CQ
 VP3Mw/d+QO2hOEddyAjsMK8zD7pVJfYOmtTj5y6Ft80DsdYhKWiWe6k3K42EW6QSglum90d31nE
 Mnynf8mWOmuneRJAFT2z9GXsJmFlZjyXYN0W62mYmMfJAYStHmH5LL70m7hiS9r83FdTr4co+Pn
 yUnxcWbXz3D+m2DffslBq1lUVDOGG5zxKlCg3TWi1IGT6yZut2IuOsOJansqUfR0EuQXksixotR
 Ogd6NgDWEUkmmNoizZBKBXqKh+JOs47iYKQql1dBCTK7z9fxu9AcH62RpvyVrK7ZbdQr5TX0riE
 G20OdvvnBoF+C8qi3WGuurota1R+L3flfZ3JfjCOWBrYlSzaiEa0BiuNAA3Cwzm7vouAbplIpfG
 FSTpHOvOqqWJSyLS7zz3pYwlUVR6n2X9v6kAn46aO5BUcKPV0a0MH5fdUhCBYhZxvV7H97YpaIS
 L7l5P7m1Kj0rovWnmkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX1Ykyq62fu4yG
 kV0+UKOLWmQu1kgLDFuasZHrnPp4wnWFuE/GhwuS9MaiR9qh7dW333k5WXtFO4Ea8Qhx7fTrUWW
 dDgxGU5jaTdileKV8e/eE4dh2bbHryU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2MTVlY2UzYzQwNmIyNjI5OTZlNTY5
ZjI5ZWE2ZWVkMGQ4MWM0ZDhkOgoKICBNZXJnZSB0YWcgJ2Zvci11cHN0cmVhbScgb2YgaHR0cHM6
Ly9naXRsYWIuY29tL2JvbnppbmkvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjYtMTAtMDkgMTU6NDk6
NTMgKzAyMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAgaHR0
cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUgdGFncy9wdWxsLWhleC0yMDI2MTAxMQoKZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDQ4MTY2YTZjOWVkMTE3ZmUzNWE1MjAyYWNmOGU0
OWE5YmMzNmYyMjA6CgogIHRhcmdldC9oZXhhZ29uOiBpbXBsZW1lbnQgbm1pICgyMDI2LTEwLTEx
IDIxOjA5OjMwIC0wNzAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpIZXhhZ29uOiBIVlgtZmxvYXRpbmcgcG9pbnQsIGdk
YnN0dWItc3lzLCBldGMKCiogSFZYIGZsb2F0aW5nIHBvaW50CiogZ2Ric3R1YiBzdXBwb3J0IGZv
ciBzeXN0ZW0gcmVnaXN0ZXJzCiogb3RoZXI6IGdldCByaWQgb2YgKm5leHRfUEMsIEVYQ1BfWUlF
TEQgZm9yIHBhdXNlKCksIGltcGxlbWVudCBubWksCmxsL3NjK3RsYiBmaXhlcywgYmFycmllcnMu
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkJyaWFuIENhaW4gKDI1KToKICAgICAgdGFyZ2V0L2hleGFnb246IHBhc3MgdGhl
IHBhY2tldCBQQyB0byBsb2NrIGltcGxlbWVudGF0aW9ucwogICAgICB0YXJnZXQvaGV4YWdvbjog
c3RhZ2UgdGhlIFBDIGluIHRoZSBQQyByZWdpc3RlciwgZHJvcCBuZXh0X1BDCiAgICAgIHRhcmdl
dC9oZXhhZ29uOiBkcm9wIHdhaXRfbmV4dF9wYwogICAgICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFn
b246IGFkZCBiZXN0d2FpdCBzeXN0ZXN0CiAgICAgIGdkYnN0dWIvZ2RiLXhtbDogQWRkIGhleGFn
b24gc3lzIHJlZ3MKICAgICAgdGFyZ2V0L2hleGFnb246IGdkYnN0dWIgLSBBZGQgc3lzIHJlZyBz
dXBwb3J0CiAgICAgIHRhcmdldC9oZXhhZ29uOiBkZXJpdmUgSFZYIHN0b3JhZ2Ugc2l6ZXMgZnJv
bSB0eXBlcwogICAgICB0YXJnZXQvaGV4YWdvbjogQWxsb3cgdGVtcG9yYXJ5IEhWWCB3cml0ZSBh
bmQgZnV0dXJlIHdyaXRlCiAgICAgIHRlc3RzL3RjZy9oZXhhZ29uOiBDb3ZlciBIVlggdmVjdG9y
IHdyaXRlIGNvbmZsaWN0cwogICAgICB0YXJnZXQvaGV4YWdvbjogYWRkIHY4MSBIVlggY29tcGFy
ZSwgYWxpZ24sIGFuZCBjb252ZXJ0IGluc3RydWN0aW9ucwogICAgICB0YXJnZXQvaGV4YWdvbjog
Zml4IFY2X3ZjbW92IHJlc2VydmVkLWJpdCBlbmNvZGluZwogICAgICB0YXJnZXQvaGV4YWdvbjog
dXNlIHZlY3RvciBwYXlsb2FkIHNpemUgZm9yIEhWWCBvcGVyYXRpb25zCiAgICAgIHRhcmdldC9o
ZXhhZ29uOiB1c2Ugb2JqZWN0IHN0cmlkZSBmb3IgSFZYIHBhaXIgb3BlcmF0aW9ucwogICAgICB0
YXJnZXQvaGV4YWdvbjogcmVzZXJ2ZSBpbnRlcm5hbCBIVlggdmVjdG9yIHN0YXRlIGZvciBRRmxv
YXQKICAgICAgdGFyZ2V0L2hleGFnb246IGFkZCB0aGUgUUZsb2F0IGxvZ2ljCiAgICAgIHRhcmdl
dC9oZXhhZ29uOiBzZWxlY3QgUUZsb2F0IGluc3Qgc2VtYW50aWNzIGJ5IHJldgogICAgICBsaW51
eC11c2VyL2hleGFnb246IGFkZCB2NzUtdjgxIEhXQ0FQcwogICAgICB0ZXN0cy90Y2cvaGV4YWdv
bjogYWRkIHY4MSwgZXh0LVFGbG9hdCB0ZXN0cwogICAgICB0YXJnZXQvaGV4YWdvbjogZW1pdCBl
eHBsaWNpdCBUQ0cgbWVtb3J5IGJhcnJpZXJzCiAgICAgIHRhcmdldC9oZXhhZ29uOiBjbGVhciBM
TC9TQyByZXNlcnZhdGlvbnMgYXQgY29udGV4dCBib3VuZGFyaWVzCiAgICAgIGh3L2hleGFnb246
IHByb3RlY3QgdGhlIHNoYXJlZCBhcmNoaXRlY3R1cmFsIFRMQgogICAgICB0YXJnZXQvaGV4YWdv
bjogcHVibGlzaCBUTEIgdXBkYXRlcyBiZWZvcmUgZmx1c2hpbmcKICAgICAgdGVzdHMvdGNnL2hl
eGFnb246IGNvdmVyIExML1NDIHJlc2VydmF0aW9uIGNsZWFyaW5nCiAgICAgIHRhcmdldC9oZXhh
Z29uOiB5aWVsZCBvbiBzeXN0ZW0tbW9kZSBwYXVzZQogICAgICB0YXJnZXQvaGV4YWdvbjogaW1w
bGVtZW50IG5taQoKIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCAgICAgICAgICAg
IHwgICA4ICstCiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgICB8
ICAgMiArLQogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggICAgICAgICAgICAgfCAg
IDUgKy0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2
ICstCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggICAgICAgICAgICAgICAgICB8ICAgMSAr
CiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICAgICAgICAgICAgICAgICAgICB8ICAxMCArCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oICAgICAgICAgICAgICAgICB8IDI0MiArKysrLS0t
LQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCAgICAgICAgICAgICAgICAgfCAgIDIgKy0K
IHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstCiB0
YXJnZXQvaGV4YWdvbi9oZXhfbW11LmggICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogdGFy
Z2V0L2hleGFnb24vaW50ZXJuYWwuaCAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogdGFyZ2V0
L2hleGFnb24vbW12ZWMvaHZ4X2llZWVfZnAuaCAgICAgICAgICAgfCAgIDMgKwogdGFyZ2V0L2hl
eGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgICAgICAgfCAxMTkgKysrLQogdGFyZ2V0L2hl
eGFnb24vbW12ZWMvbW12ZWMuaCAgICAgICAgICAgICAgICAgfCAgOTQgKystCiB0YXJnZXQvaGV4
YWdvbi9tbXZlYy9tbXZlY19xZmxvYXQuaCAgICAgICAgICB8IDEzMyArKysrKwogdGFyZ2V0L2hl
eGFnb24vc3lzX21hY3Jvcy5oICAgICAgICAgICAgICAgICAgfCAgIDcgKy0KIHRhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAgICAgICAgIHwgIDIyICstCiB0YXJnZXQvaGV4YWdv
bi9yZWdfZmllbGRzX2RlZi5oLmluYyAgICAgICAgICB8ICAgMiArCiBody9oZXhhZ29uL2hleGFn
b25faHZ4X2NvbnRleHQuYyAgICAgICAgICAgICB8ICAgNSArCiBody9oZXhhZ29uL2hleGFnb25f
dGxiLmMgICAgICAgICAgICAgICAgICAgICB8ICAyNyArLQogbGludXgtdXNlci9oZXhhZ29uL2Nw
dV9sb29wLmMgICAgICAgICAgICAgICAgfCAgIDQgKwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxv
YWQuYyAgICAgICAgICAgICAgICAgfCAgIDkgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNDEgKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAg
ICAgICAgICAgICAgICAgIHwgIDI1ICstCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgICAgICAg
ICAgICAgICAgICAgICB8ICA2NyArKy0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMyICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0cy5jICAg
ICAgICAgICAgICB8ICAgNCArLQogdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jICAgICAgICAgICAg
ICAgICAgICAgfCAgMjIgKy0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5jICAgICAgICAgICAgICAg
ICAgICAgIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgICAgICAgICAgICAgICAg
ICAgICB8ICAgMiAtCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfaWVlZV9mcC5jICAgICAgICAg
ICB8ICAyNCArCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0LmMgICAgICAgICAgICB8
IDgzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL21tdmVjL3N5
c3RlbV9leHRfbW12ZWMuYyAgICAgIHwgIDE0ICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YyAgICAgICAgICAgICAgICAgICB8ICA1OSArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
ICAgICAgICAgICAgICAgICAgfCAgNzMgKystCiB0ZXN0cy90Y2cvaGV4YWdvbi9hdG9taWNzLmMg
ICAgICAgICAgICAgICAgICB8ICA0MCArKwogdGVzdHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dh
dGluZy5jICAgICAgICAgfCAgMTIgKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9leHQuYyAgICAg
ICAgICAgICAgICAgIHwgMjQ4ICsrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13
cml0ZXMuYyAgICAgICAgICB8IDEwNyArKystCiB0ZXN0cy90Y2cvaGV4YWdvbi9xZmxvYXRfdjgx
LmMgICAgICAgICAgICAgICB8IDExOSArKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi92ODFfaHZ4LmMg
ICAgICAgICAgICAgICAgICB8IDI1OSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZf
aW5mby5jLmluYyAgICAgICAgICAgIHwgIDU0ICsrCiBnZGJzdHViL2dkYi14bWwvaGV4YWdvbi1z
eXMueG1sICAgICAgICAgICAgICB8IDE1NyArKysrKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19m
dW5jcy5weSAgICAgICAgICAgICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24u
cHkgICAgICAgICAgICAgICAgIHwgIDk2ICsrKy0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21t
dmVjL2VuY29kZV9leHQuZGVmIHwgIDYzICstCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZl
Yy9leHQuaWRlZiAgICAgICB8IDIzNSArKysrKysrKwogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVp
bGQgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3Rfc3lzdGVzdHMucHkgICAgfCAgIDMgKwogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQg
ICAgICAgICAgICAgICAgfCAgMjUgKwogNTAgZmlsZXMgY2hhbmdlZCwgMzAxOSBpbnNlcnRpb25z
KCspLCAzMDggZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24v
bW12ZWMvbW12ZWNfcWZsb2F0LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9t
bXZlYy9odnhfcWZsb2F0LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9o
dnhfZXh0LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9xZmxvYXRfdjgx
LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi92ODFfaHZ4LmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBnZGJzdHViL2dkYi14bWwvaGV4YWdvbi1zeXMueG1sCg==

