Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3098EEF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 02:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjLg-0006Eo-Ed; Thu, 12 Feb 2026 21:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLb-0006D1-Ux
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:56:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqjLa-0005EP-Ez
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 21:55:59 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D2jX7j2093498
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ny9pYL1+zg0oqnEh7/1eyI+NbtaSPqENfMw5U+VnW+E=; b=hRXed2A55KrKTacW
 2dZ/JEdqGtlJxDET2Unst1FiY/cG9EhXP2f0//Ym2n8FDCHGyTscFDp+BgLkB0MC
 lv6VUDDfIegwsdIzttGLvh/bJVeyB1SNJQErTOpeQZKc/AadpE1JBqj8cPyr+ztB
 wi+BVPoMaKu9Klwqreuf+k2eZERR7ZEHRCxSQKes2oX5pC3FsdN46iTu4D0B/lZR
 OmLQ2qb5f+CCejQnbWpFP4r0RR4O9AiBdoZMV9oQQRDiqBzDalo2IFYaAmocIDK/
 lCgQqAwlYJnOI3zjg7Ft8SHc8PLhhlzG/TyQWAUj6LA5bS/bMIte3bbAiOSGMZ9H
 1OGbNQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y1spk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:55:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba6ad2ca1fso3942229eec.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 18:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770951356; x=1771556156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ny9pYL1+zg0oqnEh7/1eyI+NbtaSPqENfMw5U+VnW+E=;
 b=ZqLJFzGA8NVOK/udQ26XPHuL7nZKBptZNl+GFv72QNtvE3OCzRE0s8fM1PqLkjEz1D
 p3IUMX1i70dKZu07S+QzZGh0G0LHHx4gFPLJxJDM5SGvhwAVv2lUskmOjEujGnfkyiC1
 eTbiWnbGC5Fal69wJ3W3DSwC3s4e8AmHcj0CxDp8HEx7MEtbQMZAd2aIYS/dUUDlq2FX
 2Fn9hQiClCAtkqKMWWA2la8T9q0VvCsLmp32k3vWl1HAw7BnXcYeVq/SST+StEVZubBS
 g1advsb3w+k108hP9fsq/ZS+czkX0z+GsVzMeyHSF14hTctMnw36aoIFzTL/Hz8FmJuL
 o5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770951356; x=1771556156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ny9pYL1+zg0oqnEh7/1eyI+NbtaSPqENfMw5U+VnW+E=;
 b=admtixODs0h8IjpcbfiS/rWJCRq+7tT5XTHfvvFF3F661jrhrC004Pq9TCs85U5shW
 k9/PfR901CrWUJnFDNVGmQ/dVnwXkV0NzLxv6WEihlAgrGKBQBc2FrRWPNKVPVJN7vCx
 aFyQenxbTgcL45zeljmz5wdG55iNNwP7JAF48hXN+QEGYZzQcJa314rpKPCp8B4wD5j/
 QhtOYVGxEZZpkrpNeM6TCWgUbAYxZ4QLyEkCQnXMAdnIwjVGbvsF4u3BnS34LnyCZgVX
 kc3kwlKH8IgEJ8GV+gptgt6WDHYrg3BsdYgezAN7w/0pem+6VDG+3FyZZ8gN6bv+ZqOr
 lInA==
X-Gm-Message-State: AOJu0Yw3wX4Y80RRx7ylbeZsdIR2W17JurpEM1oiQXaC5l9bxzG+Wcj4
 wEvA/ClfGW86jA3TEtDdR8BqvPgfgHBNlaKVl+kjp0EOFto8hcdWzu4CSr7j5xkJOziF7itMuDp
 XD1sQb2dH0rEOqtKOQCjJa/G8074UG1wAKA8mYyzBQ8Alrec3w7T2eqkkLbQsE6vDHg==
X-Gm-Gg: AZuq6aIB8SVYr5y4EM4LkM12NMjYuQPktJQMcZ1zqM+BJhKCzSMxjDAlhUHrBF6v8LU
 8wrSWw8TZe2Q389IKJNje1jr/DC3oqwNRvPse0Ci3SPnElIXwfE4La7FNpIW6l+HtBP3vjbBhe0
 DH7zkp6/9/xx7J8R9RdR87bd/huc0FIlx1uLB+amPjE4sc+CCE5ED9EpRUBm0z+JQb05nZXDVfe
 1zW1t1Qh+qUMxnGn6Xvok5ByAI+nzjbk86S68bsjPLFHACU9fCvJa2bPRgZKiE4LOC4QQDR7jHn
 ihQv42fHbLbKDsxExMLlztHGp0RP7G5Duyfne3zTMGB3YDVI4i2+AaDDKMtVFFexeeE48Lv0eJX
 vYIONiwdsSM05yNEwhaxurdx1kkqLiUTaDfeIjuGxmQwMADkIZl1Pm3W3aKec9RR0uOblHw==
X-Received: by 2002:a05:7301:1296:b0:2ba:a2fa:84c3 with SMTP id
 5a478bee46e88-2babc44f43emr167701eec.28.1770951356321; 
 Thu, 12 Feb 2026 18:55:56 -0800 (PST)
X-Received: by 2002:a05:7301:1296:b0:2ba:a2fa:84c3 with SMTP id
 5a478bee46e88-2babc44f43emr167691eec.28.1770951355814; 
 Thu, 12 Feb 2026 18:55:55 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbd5d3esm4500943eec.10.2026.02.12.18.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 18:55:55 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL 6/7] target/hexagon: Remove unused EXT_IDX enum
Date: Thu, 12 Feb 2026 18:55:43 -0800
Message-Id: <20260213025544.2497992-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
References: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698e92bd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=DONroWUodXjVzxm-Au4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyMSBTYWx0ZWRfXx088cWlfo5x6
 ek9RuCRE1xA9rpR7Jwz5Agu4NOX6sUJs/z5Y3vNufpy5OAj+/j7NUHnEToiOaXw5VtS/H/lvVNK
 D9klZdng6yr3AVRSqeTXGsenlJBTqpvkleQlszF3iwa3jR6uaV299fMVvCN8AN6OwruXKu2O2fV
 MXMFVr9QD5wrjN2HON4GxjgtyRb5mCOwLHUshUJY9MYA2iFjV8nd30lU82LOX3f6+IcYtx9DQor
 E4lI1MwCzSZpmFVAMVvWislGVZx5p2kD7f7Bo2cXNcayHkm6i7NK2xB3QNAwxmoFQnuwcni/qGu
 oCd4bV9YrfZbe3cWFeFR7GfKwGStYolfNo0MEtUHma3TUydwRYjfGTT27eRFzECNsauhBMXamVD
 gS4w0r7V7ClwjAPgjobjK4L6tb64bHpvSSP/5fiNvQb1S6WJb2T0I6yHrQME7lWEQ/fIKZTXAO6
 FMX/jtFJZL8PVmWBxDQ==
X-Proofpoint-GUID: Rm1cbXKLUFXP1sxX--8yj98qbUBS3tpy
X-Proofpoint-ORIG-GUID: Rm1cbXKLUFXP1sxX--8yj98qbUBS3tpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClRoZSBF
WFRfSURYX25vZXh0LCBFWFRfSURYX21tdmVjLCBhbmQgWFhfTEFTVF9FWFRfSURYIGVudW0KY29u
c3RhbnRzIGFyZSBkZWZpbmVkIGJ1dCBuZXZlciByZWZlcmVuY2VkIGFueXdoZXJlIGluIHRoZQpj
b2RlYmFzZS4KClNpZ25lZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5x
dWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25A
Z21haWwuY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgfCA4IC0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4IDAwZDRhNzlhOTUuLmRiYzljNjMw
ZTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2RlY29kZS5jCkBAIC0yNiwxNCArMjYsNiBAQAogCiAjZGVmaW5lIGZaWFROKE4sIE0sIFZB
TCkgKChWQUwpICYgKCgxTEwgPDwgKE4pKSAtIDEpKQogCi1lbnVtIHsKLSAgICBFWFRfSURYX25v
ZXh0ID0gMCwKLSAgICBFWFRfSURYX25vZXh0X0FGVEVSID0gNCwKLSAgICBFWFRfSURYX21tdmVj
ID0gNCwKLSAgICBFWFRfSURYX21tdmVjX0FGVEVSID0gOCwKLSAgICBYWF9MQVNUX0VYVF9JRFgK
LX07Ci0KIC8qCiAgKiAgQ2VydGFpbiBvcGVyYW5kIHR5cGVzIHJlcHJlc2VudCBhIG5vbi1jb250
aWd1b3VzIHNldCBvZiB2YWx1ZXMuCiAgKiAgRm9yIGV4YW1wbGUsIHRoZSBjb21wb3VuZCBjb21w
YXJlLWFuZC1qdW1wIGluc3RydWN0aW9uIGNhbiBvbmx5IGFjY2VzcwotLSAKMi4zNC4xCgo=

