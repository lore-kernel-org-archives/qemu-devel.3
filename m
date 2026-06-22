Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8833ECDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn8u-0003Jw-Dv; Mon, 22 Jun 2026 18:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8s-0003In-1E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8o-0006FT-Tz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbF9k2122438
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=; b=il
 M2jNt9k+gVZQyfV2DVKBHbwwauSqUoA70ubAalO9KaEUC818z4ygeEjfHU7MRfSp
 8ORArpQYRYXeRlRLiKndVNRJNZc7k1Gb6ZCFMzlhiJeWc7Fr99QCCeXyWGk9k5fB
 +aQtJb9m9n20ZqjtNKocI8SCG7jmmBCh+9ywtDOzseFhRhm9mBZIruVWeaMV3JyX
 B01pXXV/arRj7lGjHce7tFGHdqUSWxcrq1txIN3q/uj/aX0HDwNgnVyZ8quTtc9A
 sWrfwgbpc+0vgRf6xmTtxUSeDQNxmE8ns/HSSaKNgiHvYfAGL8dxSJ93EPtETipt
 Xd6AunyzkbEZ7lSAChsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41xvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so15193617eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167357; x=1782772157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=PZC6LFShPhZ9ngcVYw3l2S/+MUgHZ0khHPkdu3hBey6rw50jsQDKq1AxG2XIFfZd24
 tccgVWwtBvkBbvQaxLo5v+Pcv7dfxfXf8RPE1OFLi5GfcpM3wVifHpAnIAHPijL9geS8
 ls4fHYEEM88JvguH/CMWJqmi45d/4bhVC93eaMU1Z0rFkXwkiUmh2rNkW+k7qinwUOyr
 cjlIhJXiaSzT+qmuB9gizqvbnsifE0xM2hmuWY25EOAqz4GHnurVUp1LRZbaxzUoxjtT
 2GMPh/KtDh7kq8ZQav3NWuEVa89ml9tMDImd4RhPyh5Yug6QaK+x+OTi+kzDdSxXvS9I
 CX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167357; x=1782772157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=jPYOAhd/iJUAXK48prM/l2YQy1s0fbON6iAL8OCVxrD2+UBc8bLvaQj52Ee8eSWIx7
 Gj2ZcjWQcgutBKY+tB+PazRGymHJFzWY8usxRpyjmm48Mj5R+z3S79fejSakKgH+7b9q
 hG+0sTVIfuaTvCgD7Q9wI2Yw4FveU8neWuaNiIzbLYR8xNzJTmB7YDK4lHNjCzR5tsGS
 AZWsPUEku2GijYxtnqYzIb6BELxgnxqNlZzH1L19RPNZjIcvOX5rIILnFY8aXe5NqW4c
 IEQ7HjiB1hBNrgRzNgtFxZwQMh88m+xEpvNoEMT+7CzCofpKV5YKh/EPvi35fsuWH9Kf
 77gA==
X-Gm-Message-State: AOJu0YzF6DFA4B7o/UFBuc9cwwW1Reiw2FuSXjWRQNIHd7UMViqYbkHS
 dazOqUEYj703hEVwas3g/IQduAjLeCWJPwePXAXDsPxbY9wMh3eHAMzjaYcRZoneJmhxEWTGK2E
 Hn6ViY34PTotT1SNBLaaUQoUpsuHxaD9n2tK1r/1HgpN5BtFFPsUHp8/moclz6d8uYw==
X-Gm-Gg: AfdE7cnEkVZzPLoSMUYVoa/Pblj6oWQyFNGVYIGIRl89w5EdFzqOThALTDJJajiGKup
 xn40a/xvN8X4BMcSFZK2BTJN/zHtk7dJGgVoS2qKqiPTm1mqrmjJHeohc3ztzhBMFfBJ4r4tgz0
 cX428eDUaZKSXu0jvG6OODSRwdun7M2YTcdSWp5/yqpYYdxr9UsK+Nrsbw1PiKcq2BwEVqHv03/
 JrepywVrPqWtw+/ksNPeu4nCHOGaxfgYvxSJgPxMU5wAcGYdm+mVt8+uXA8jJ0mFEP1PTGtK8r7
 5UGbHKpY9TrPQi0X9WhKqzExfzqVMdlbXdFjkJYwzKSIUwYxd3c6s8rLCjvtoUy4nHECup5nSYo
 HpCC94OZHGeu2MrqWA2HTsQwfl6q8rKkzRFMwdeeK/k3W+TYuj4JVwxv+5aA=
X-Received: by 2002:a05:7300:50f:b0:30c:554f:cc2 with SMTP id
 5a478bee46e88-30c554f1148mr1387824eec.12.1782167356738; 
 Mon, 22 Jun 2026 15:29:16 -0700 (PDT)
X-Received: by 2002:a05:7300:50f:b0:30c:554f:cc2 with SMTP id
 5a478bee46e88-30c554f1148mr1387800eec.12.1782167356261; 
 Mon, 22 Jun 2026 15:29:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 04/75] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon, 22 Jun 2026 15:27:53 -0700
Message-Id: <20260622222904.607771-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1TRcAeRY4HkW
 m3jbO7bbXeuVk09xsGprM4NN4bLHEUt2FDo/nE1EL91i1ydc1fRSX2aPkiyeID9eOA9QsPxf9dB
 bBvMViLbeKj6NfEF8JW7gy2iIESQ+M4=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39b73d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: h3iYGEAYFlTYjc-RYAo5XXFCMnEcUkGX
X-Proofpoint-GUID: h3iYGEAYFlTYjc-RYAo5XXFCMnEcUkGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXwzOm5/3I0vCb
 JvBTNFwlbaCX6LC20hWw9SrJHH7ufZVliRyI0vv6Wt9cEg9QRHKH+G8jFOHXK4tFfToiAzIahux
 ZQGIdCxxNgumM4UB202nXrmteWS/C65uDJfpYl6BmOLVN8YLkv/WdRq9YlKL82VBillAKKwRIvq
 +qVLb8hPiV3FAsddgaX3eBoEOdlbKv8EK8YuTjkSxELPKFETUT1j+UV+oeO9xtla6jHV1kuhZh5
 sfXqKYBrnWLYfXlLuvLNfhR3AmMrZMfqafeU0IsCaiHiJMEKcqavZNe1WP5ydvj75dzU5fTWhFu
 rLx1JgTq/zDdLxDEqMBHAWvUtc3vQWcK2zaP15BQDLgqwGO5ekasMQnDcPHFdDa73kq00W/XF7G
 wN+XpC5PU2V8Jta8eCzo6yjhANSPgcXBO6reRbQnXrUL9L+LzGA/pf0CkTo+IGTR7Jp3dpSaQSz
 MmWa0/cyuj6BKPZcDUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMTEgKysrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAy
YzUzZjJjMjgzNi4uYmQ1NjhiZGQ4NzEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xMTAsNiArMTEwLDE0IEBAIHN0YXRpYyB2
b2lkIHByaW50X3JlZyhGSUxFICpmLCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkK
ICAgICAgICAgICAgICAgICAgaGV4YWdvbl9yZWduYW1lc1tyZWdudW1dLCB2YWx1ZSk7CiB9CiAK
KyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgcHJpbnRfdF9zcmVnKEZJTEUg
KmYsIGNvbnN0IENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtKQoreworICAgIHFlbXVf
ZnByaW50ZihmLCAiICAlcyA9IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAg
ICAgIGhleGFnb25fc3JlZ25hbWVzW3JlZ251bV0sIGVudi0+dF9zcmVnW3JlZ251bV0pOworfQor
I2VuZGlmCisKIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0sCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2tpcF9pZl96
ZXJvKQogewpAQCAtMjA5LDggKzIxNyw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fZHVtcChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgRklMRSAqZiwgaW50IGZsYWdzKQogICAgIHFlbXVfZnByaW50Zihm
LCAiICBjczAgPSAweDAwMDAwMDAwXG4iKTsKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MxID0g
MHgwMDAwMDAwMFxuIik7CiAjZWxzZQotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ0FV
U0UpOwotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQkFEVkEpOworICAgIHByaW50X3Rf
c3JlZyhmLCBlbnYsIEhFWF9TUkVHX0JBRFZBKTsKICAgICBwcmludF9yZWcoZiwgZW52LCBIRVhf
UkVHX0NTMCk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzEpOwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

