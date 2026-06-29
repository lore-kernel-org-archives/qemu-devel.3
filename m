Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIL-0004Ge-1Q; Mon, 29 Jun 2026 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHm-0003oT-NU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHk-0006Iw-K9
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT2cK2641653
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=; b=XHzjKbOz5w2zUhHE
 bnnUWhznclSJOJa2+wuainQJhITe5q2fmerr+R5ciW8NSsAp0PqZWzWy2Nip5B4X
 hA5MMPYUSzUWgt+AU1Foyl92b5GWhAYXx1GvLCTy2lykHAwG0tvjkh/9h2ir0R/V
 H0WIYzIPn0oZsZjtIFULojkHyQc17J/IiRWvXjw9h8sjEsr3z8FlbqF33B6P8Ijk
 BAAM0HkEQMX2V1xdaHsoJPVcQgKt31kGUAlAEJ3TXmKWsVwOKtsyZMjwfXwvNSMn
 DH+d3OKpfe+/mpgYtLkXRqKWFpmimoUWKqYx5q7DNi6pJc7QtRMy1r/Tw2pfYx8t
 YXgwWA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npes2v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c79e5de32cso26130315ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740656; x=1783345456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=X6ypwhKLfycHJ6KlhBDvwEsuJubrn+FsDCpCgLuIoVePFqXwPcftAxvvV/YZ1FQyrB
 r7PmWEJorf8F017IGEFRFBystOGKlGjrm7MhJFV2IYATEQSGAFMDUMuSqmqGOZPGo12X
 iPx/9UmBqdxUw1MPxQwmQjyf9nuO6BCIwY4bYeDBnDV9eoSuqklTNJ+5Z/hVC6Kt9TS6
 xM1DYWKPo8hsMxjujkvNEvD2ZSqqR0/8iK5fb/NhoIDrHFzcH/bkk/gUzPAIIc0kG7bN
 RqsR6R6KpOLw6+NbpspH3mzmJt4M197ZeKB/0exm8PsiYx3GG+w903FvbIfXhkJPeTAL
 +vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740656; x=1783345456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=Dkd+tvD/Blw0jjTm/CA0SE2cbEULor/DTAzfbVYS3zoaJlR78VG72wJD0VvB2kNLx4
 2jmpEhQr3+46ZMdN3Gme8hP7GlLemuHn6H1CyEmjPIVCQijVpjbfeT+M49DwxXOxDLYc
 qQPAmUjpmcHu7ncIFfxYYDu83i9HXS4z5Gd/eMteN7F2OpaC15iHRMk0POCUAZLhL4OZ
 yOBFRYF1X2oIjA0u7ZFEqSwwCHy7bYnnknFG6lcPioIfYjklj7QR5JE5rJUDiZlbfRM/
 k61Z0Jz9kcaq8VEuhVKZNKb/wvxapeVRjaiQmOl4MZzkF3rEXYZ5yOI9a2gckcrzpW71
 I8Ig==
X-Gm-Message-State: AOJu0YwZxptR/Dc+guYEmLiSq7mMrCAkp2CVJt1M7yfNHAyLoXosphpf
 g5xT0PRYOZFwQ2hCg1c7hnbjRlT5XniNdFmrEMxq5ubuBKFtK0T8q0yobZeQUG9emixlsKGx0OC
 xpeRTb3J1Aj3XJ1zjsrN5oW1+jlhHwSW/BcWx0AJeeegWY11TxmT908+bEsU91cqwZw==
X-Gm-Gg: AfdE7ckoHjhp1OzQVxGxVWlpEhYTVwyXeNyKc10VR0CU2dSSRpElCp+aL2kKlbdaE2W
 r3CzhKYJNVP9OTCOrb+vfqrU/oCHS1RIj50hANd9aL1foGrb6JDpQSlKy0+NFbwMS7gNv50EHcD
 f1z40iMGRNy6eA1tYfoTI4mSdeOs/mwC0tu6rS0yEKX04ccZ+8q8krqVPPxbZhg1evzNRfwOX0F
 PrqhKuo6RmLyYiGOXLrNcNToYPNtCr5JSwdHLP40ZS8Lm2RPZXuisq2mWAwQLcrGKg2+kwVd1ze
 4gXiW92FQW7+euwr2dGwO0jLnwvww4pydy041u8iD6EADYkp3iZ1lC7a+5M19Bsd10AHTkMWyb/
 BD6Hq+atiblU0RM/Zsv49N/wvxMXjz3QYCh80bhyWnEHkkN9CEluGHiSOYsM=
X-Received: by 2002:a17:903:f85:b0:2ca:106c:7122 with SMTP id
 d9443c01a7336-2ca106c7611mr18140695ad.9.1782740656519; 
 Mon, 29 Jun 2026 06:44:16 -0700 (PDT)
X-Received: by 2002:a17:903:f85:b0:2ca:106c:7122 with SMTP id
 d9443c01a7336-2ca106c7611mr18140385ad.9.1782740655957; 
 Mon, 29 Jun 2026 06:44:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 63/77] target/hexagon: Define system, guest reg names
Date: Mon, 29 Jun 2026 06:12:18 -0700
Message-Id: <20260629131232.2487780-64-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXxck6bk7/7BHQ
 FBpjOVe6D0jTL51wwu16o940A5Z9BQ7eJxes2deVjd9RnV1eGUpz0R0IBHcV/pCJ1Rmi5TxriaJ
 nvx3q4Og3bmohWvJA298oKUSA0KzXHzYw7FTaXT7CoweKlLRj6zEJfYj7fJezPAgtkhjGl/tBLK
 zmDsveHuuQugsoA0+KIq+lzb70aXecQa5EyxOyJx7S4YNXhf0CxxL0aZdqtz9RnjaGQG9vnLPcW
 Hty1hn5LhiFVDiDqJGbdiNHU2xkl4gweGSlPNwTaY/ND7KbeVCtrt5T4vAa+CMmrFbT5BEeu+nE
 NVQzrPDrVZhAv1jwPLGeRUGWhBRvIktxHjxlqBcVyi6HGSwxuxautyu29Q5wPrnLVCeJ8qJEdZu
 nuDQWtSm/S4sLitViCdYaArTYYzOreUVAnN3aEx1nrFuXJbaoJxwaAyVzYAj+j9rnrgK7n325Qs
 KZ49VIMwkAUYGZeLnbg==
X-Proofpoint-ORIG-GUID: NlyE-BvJVjC6rutvR8JdEpHLjNfpmZsU
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a4276b1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX5W1MDM+IIcRF
 qW7OV67qiS+Ynlb8OqC31BQCl6r7TIfXpzn2kM32lf7taM+BiuoWt+g2XnM2s0CARJ5rL3f/5YP
 KF/8LioxSf79bLtBXFJ7YjWS5PDIKcI=
X-Proofpoint-GUID: NlyE-BvJVjC6rutvR8JdEpHLjNfpmZsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdv
bi9pbnRlcm5hbC5oCmluZGV4IDQzMzg5MTRlZmI1Li4wMGIzN2FlYTdhZiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CkBAIC0zMCw2ICszMCwxMCBAQCB2b2lkIGhleGFnb25fZGVidWdfcXJlZyhDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50IHJlZ251bSk7CiB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRl
ICplbnYpOwogCiBleHRlcm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9U
QUxfUEVSX1RIUkVBRF9SRUdTXTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNv
bnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX3NyZWduYW1lc1tdOworZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX2dyZWduYW1lc1tdOworI2VuZGlmCiAKIHZvaWQgR19OT1JFVFVSTiBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgIHVpbnQzMl90
IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKaW5kZXggM2FmOTBlMzBiMGYuLmIzNWNhYWVjZmFlIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtODYsNiAr
ODYsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
UkVBRF9SRUdTXSA9IHsKICAgImMyNCIsICJjMjUiLCAiYzI2IiwgImMyNyIsICJjMjgiLCAgImMy
OSIsICJjMzAiLCAiYzMxIiwKIH07CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorY29uc3Qg
Y2hhciAqIGNvbnN0IGhleGFnb25fc3JlZ25hbWVzW10gPSB7CisgICAgInNncDAiLCAgICAgICAi
c2dwMSIsICAgICAgICJzdGlkIiwgICAgICAgImVsciIsICAgICAgICAiYmFkdmEwIiwKKyAgICAi
YmFkdmExIiwgICAgICJzc3IiLCAgICAgICAgImNjciIsICAgICAgICAiaHRpZCIsICAgICAgICJi
YWR2YSIsCisgICAgImltYXNrIiwgICAgICAiZ2V2YiIsICAgICAgICJ2d2N0cmwiLCAgICAgInMx
MyIsICAgICAgICAiczE0IiwKKyAgICAiczE1IiwgICAgICAgICJldmIiLCAgICAgICAgIm1vZGVj
dGwiLCAgICAic3lzY2ZnIiwgICAgICJzZWdtZW50IiwKKyAgICAiaXBlbmRhZCIsICAgICJ2aWQi
LCAgICAgICAgInZpZDEiLCAgICAgICAiYmVzdHdhaXQiLCAgICJzMjQiLAorICAgICJzY2hlZGNm
ZyIsICAgInMyNiIsICAgICAgICAiY2ZnYmFzZSIsICAgICJkaWFnIiwgICAgICAgInJldiIsCisg
ICAgInBjeWNsZWxvIiwgICAicGN5Y2xlaGkiLCAgICJpc2Ric3QiLCAgICAgImlzZGJjZmcwIiwg
ICAiaXNkYmNmZzEiLAorICAgICJsaXZlbG9jayIsICAgImJya3B0cGMwIiwgICAiYnJrcHRjZmcw
IiwgICJicmtwdHBjMSIsICAgImJya3B0Y2ZnMSIsCisgICAgImlzZGJtYnhpbiIsICAiaXNkYm1i
eG91dCIsICJpc2RiZW4iLCAgICAgImlzZGJncHIiLCAgICAicG11Y250NCIsCisgICAgInBtdWNu
dDUiLCAgICAicG11Y250NiIsICAgICJwbXVjbnQ3IiwgICAgInBtdWNudDAiLCAgICAicG11Y250
MSIsCisgICAgInBtdWNudDIiLCAgICAicG11Y250MyIsICAgICJwbXVldnRjZmciLCAgInBtdXN0
aWQwIiwgICAicG11ZXZ0Y2ZnMSIsCisgICAgInBtdXN0aWQxIiwgICAidGltZXJsbyIsICAgICJ0
aW1lcmhpIiwgICAgInBtdWNmZyIsICAgICAiczU5IiwKKyAgICAiczYwIiwgICAgICAgICJzNjEi
LCAgICAgICAgInM2MiIsICAgICAgICAiczYzIiwKK307CisKK0dfU1RBVElDX0FTU0VSVChOVU1f
U1JFR1MgPT0gQVJSQVlfU0laRShoZXhhZ29uX3NyZWduYW1lcykpOworCitjb25zdCBjaGFyICog
Y29uc3QgaGV4YWdvbl9ncmVnbmFtZXNbXSA9IHsKKyAgICAiZ2VsciIsICAgICAgICJnc3IiLCAg
ICAgICAiZ29zcCIsICAgICAgImdiYWR2YSIsICAgICJnY29tbWl0MXQiLAorICAgICJnY29tbWl0
MnQiLCAgImdjb21taXQzdCIsICJnY29tbWl0NHQiLCAiZ2NvbW1pdDV0IiwgImdjb21taXQ2dCIs
CisgICAgImdwY3ljbGUxdCIsICAiZ3BjeWNsZTJ0IiwgImdwY3ljbGUzdCIsICJncGN5Y2xlNHQi
LCAiZ3BjeWNsZTV0IiwKKyAgICAiZ3BjeWNsZTZ0IiwgICJncG11Y250NCIsICAiZ3BtdWNudDUi
LCAgImdwbXVjbnQ2IiwgICJncG11Y250NyIsCisgICAgImdjb21taXQ3dCIsICAiZ2NvbW1pdDh0
IiwgImdwY3ljbGU3dCIsICJncGN5Y2xlOHQiLCAiZ3BjeWNsZWxvIiwKKyAgICAiZ3BjeWNsZWhp
IiwgICJncG11Y250MCIsICAiZ3BtdWNudDEiLCAgImdwbXVjbnQyIiwgICJncG11Y250MyIsCisg
ICAgImczMCIsICAgICAgICAiZzMxIiwKK307CisjZW5kaWYKIC8qCiAgKiBPbmUgb2YgdGhlIG1h
aW4gZGVidWdnaW5nIHRlY2huaXF1ZXMgaXMgdG8gdXNlICItZCBjcHUiIGFuZCBjb21wYXJlIGFn
YWluc3QKICAqIExMREIgb3V0cHV0IHdoZW4gc2luZ2xlIHN0ZXBwaW5nLiAgSG93ZXZlciwgdGhl
IHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlCi0tIAoyLjM0LjEKCg==

