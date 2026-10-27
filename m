Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E9606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P6bWtJW/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hUOev6Ae
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiLv-0004Z5-Or; Tue, 27 Oct 2026 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKR-0008TW-1n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKP-0006Cv-7K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoD3L1316480
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=; b=P6bWtJW/9e3Pu7ST
 SUvoep7KbHxyP6WxQQfNkjqEWjEVRNCd+wSe+95n2w6sBDY7zxfB3F2GD3dnlgia
 kb5AH/Zg+mXrEPK5T3Kqokk5bartGaseu2ma6j4KLSmC46hK/5mrfqpFmRTW5+A2
 rJbZoZE4Y8pSm2Ijr+RojB8af/hVmC6x0yiVrGBd/F4teqA+gGPOvDaduhRNH1d1
 qfcjgxgNaHUUz0kEIOjVqcdgmRUVt0DVO3v+5jeSBiOVBeOsM84qgvKJ6U/Vr6DJ
 CbWLa0Wl+XH9TKH1S840ZwC61FAjpszY0DygJ/pZe91fWn9Y6lD29xYWdpVYp1+r
 ebyQ5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98ju7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad98380ccfso6645468a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111943; x=1793716743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=hUOev6Aeq1sT4dh5TlLFkTCF2zvrnwt5sjiXE92zNTMQ/gyP+Ny32IZ1omYDM4Sxub
 p0/muiypGWGGxf3EXw5quiUwB3zpqYz3QvW84tp2abpxknsNTcHu/K1gXYvBLI3Ov5Bq
 f9F8fBEcN1o+XwH1Tn1WO7iun6SLLSegVFkGF74BWPqqIysfMA1mV8E5nkYZiKEqH32r
 e5fdsb3XIaeD/2HDyu0dbbDeKCDGqq4xG/6w5La8QVllSzKmE2EVEFGk97pj1HAn4B1V
 EZ+Q7O+EufzT9+Mdq02PsUMKV55AsJh4Av7rHFdv5PZ31lF3y5+2vlu361DsEI58d9dT
 Q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111943; x=1793716743;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=u4G/lD5OvC+n9erz5vMMoQ2iz//0Y7vl1xKtX1Srg8ytdL8VBbiyKmAUxKCfxEk5w8
 FjguPcoMPi9LXv7Caz9L1BDznJZBaQmsPYmOqL3JGj7IwJ9ah+Y0iTf8ni7C1QGDMYw6
 ukcgdauSksYZQUjdoDqPmX/tKdKflNtNEpQvBYddpgU/JsNVge9yfCp0ORC2CXAaWj/T
 C9qPNyEpKOZWzVwrrVRp9lgIFDMe/cC9RTqy2gq97Vs0DPadGH1GmlS9PTqdw8nZAtMh
 koNVoUW6aHpIrJpyvmSpywTpCFFD40xaETOzTYjilV4OvKiz3L7KeVG8PTAA+JG7wyEa
 hlMw==
X-Gm-Message-State: AFq9FYJ00Y/amDM/JPOOfkFmY7nAC8a1IBCOImCZ6uag7n2Ln5fvYVzo
 5TTop1Rkf7g5npFTaWbEHw+UPIXwnvkedCAun9byEovzt3uRjk82QKFboxUtIRI7PkSFlBbZnqO
 u1P7bu0MqkJcUUTfv3+OhvvzdQF1kGHsy1HQ+nbWHP9PxmiErzLuzhmOnM88upzu0Ow==
X-Gm-Gg: AYBFou0bw6DWUmP5QgKmWYnAK562cKL3mn5msJkbYT/gCvtCP33OFm+Hs8RiNtpwrMS
 3kWxqkOsv/UJkZFBiLjWxa0bb1VloAWjYoPYNZWOCOdjsi2wfbpuCtoxTPcCwCwTcO6k6D8avq0
 4wzL+xLZvNM//cqKn4QqAg6UMf6q3TME6xlr3UpkBj/fzolOxImlJken6ZiSGXzJpCipKqlR5aK
 ysQDyzL06VQlCOhCRcLrQ2VcXhUyV+emjEeTeskw+dPtot+pwXLwKDTge3q8WAhYRiHV+UZvKUP
 B1/KrSM77ssXXjd5mgW31zY0GaSdEs2+30JUaLbIHxakQc2SQU69iAmEDCqHJJ2muyBh7Oo2OCG
 2Q9Vswq3Ti7VjwnIFvyesegn8T55zJofLCLOvKH4gEgPVcrn7DZe5/8s8pqMZHoQCL/+YGOkjXu
 2KDdPKRfDV4v6lpnFl1KgQ
X-Received: by 2002:a17:90b:1a92:b0:3a8:211b:6c8c with SMTP id
 98e67ed59e1d1-3adeaae6e15mr8977438a91.22.1793111942874; 
 Tue, 27 Oct 2026 07:39:02 -0700 (PDT)
X-Received: by 2002:a17:90b:1a92:b0:3a8:211b:6c8c with SMTP id
 98e67ed59e1d1-3adeaae6e15mr8977417a91.22.1793111942347; 
 Tue, 27 Oct 2026 07:39:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:39:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 36/42] target/hexagon: assert qfloat shift
Date: Tue, 27 Oct 2026 07:37:15 -0700
Message-Id: <20261027143721.4125584-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0b787 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: WjATGUeU8G-c7Od7QmZT6rt8y_PiBhNU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX1eP5Jf1qskLC
 BNICQYj3SS8O0hSdXHM/9xUc+9YiJbVBzzIVKt8rG6B7IvE07gnlX0TEo/4KacJ2ETY/18kbOAG
 h6gZ1fXCwNF/EOVI9GlAXSmIjzv1yXf98TF5HSH9avmieHHP3P068DLCpLdT0EbIZdjVKqAPfnY
 Ph/XUZwcPE1bsdHkav09uF6yAWfu5Fqb/LCd6XeoCaBUt3VZ26nwoCasjDXogu8mON6gbu5xUFu
 VNq3cmsC6SfzQVVrTpnotCWICrJaJL2Rz1nzXiWQA0Vi8yaSNj1WtbKJBl3ajHUfXNN28MPujIM
 40h1Q6MbQ1gWU/DbAfrkvOEdkmJPhNjrDzU7r3DcHVPEETZgndFS/gOtMov2j245btje+CAHnIh
 VxDaPOrtByK6cBMAuzE55brSzEziGaDrX7uO7TqoC0Vzfu4ZcptdAvVKhttzu8hhGIZRNfXJz3K
 s1pC7pZRjRFHLSTk2fg==
X-Proofpoint-GUID: WjATGUeU8G-c7Od7QmZT6rt8y_PiBhNU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX7KWJnczVURFZ
 EUlWDoAsal55bt7m/Dzy3+ElVke1b5SwSgAZ3wFGdhmPF/IBpecXVZiUMFMr5OhQQb7nJOrCV9x
 D2AD5KdsWHsEFa5C20IXRLb7RbXe1d0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIG1pZHBvaW50IHJvdW5kaW5nIHRocmVzaG9sZHMgc2hpZnQgYnkgInNoaWZ0IC0gMyIsIHdo
aWNoIENvdmVyaXR5IGZsYWdnZWQKYXMgcG90ZW50aWFsIHVuZGVmaW5lZCBiZWhhdmlvci4KClRo
ZSBsZWdhY3kgYWRkIGFuZCBtdWx0aXBseSBwYXRocyBzZWxlY3QgZXhwIHN1Y2ggdGhhdCB0aGUg
bm9ybWFsaXplZCByZXN1bHQKaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGl0LiBXaXRoIHRoZSBs
YXJnZXN0IGxlZ2FjeSBmcmFjdGlvbiB3aWR0aCBvZiAyMyBiaXRzLApzaGlmdCBpcyBhdCBsZWFz
dCA0MS4gIFdlIGNhbiBzYWZlbHkgYXNzZXJ0IHRoaXMgaGVyZS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQV9XSi1QWUNmaWl1NDR1VFFpRG9jNThfOUt5
M3VFZC05ZzE0blBnRFBUX19nQG1haWwuZ21haWwuY29tLwpGaXhlczogMjYzM2RhMWUxMjdmICgi
dGFyZ2V0L2hleGFnb246IGFkZCB0aGUgUUZsb2F0IGxvZ2ljIikKUmVzb2x2ZXM6IENvdmVyaXR5
IENJRCAxNjg4MjQwClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0
LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIGIvdGFyZ2V0L2hleGFnb24vbW12
ZWMvaHZ4X3FmbG9hdC5jCmluZGV4IDQxY2M4MjdhYTg3Li4zNDViZGRjZDM2NCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L21tdmVjL2h2eF9xZmxvYXQuYwpAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdGF0aWMgaW50NjRfdCBs
ZWdhY3lfcm91bmRfbihGbG9hdFBhcnRzNjQgcGFydHMsIGludCBleHAsIGludCBmcmFjLCBpbnQg
YWRqLAogICAgIH0KIAogICAgIGlmIChtaWRwb2ludCkgeworICAgICAgICAvKgorICAgICAgICAg
KiBUaGUgbGVnYWN5IGFkZC9tdWx0aXBseSByZXN1bHQgaXMgYXQgbW9zdCBvbmUgYml0IGFib3Zl
IGV4cCwKKyAgICAgICAgICogbWFraW5nIHNoaWZ0IGF0IGxlYXN0IDQxLgorICAgICAgICAgKi8K
KyAgICAgICAgZ19hc3NlcnQoc2hpZnQgPj0gNDEpOwogICAgICAgICB0aHJlc2hvbGQgPSBVSU5U
NjRfQygzKSA8PCAoc2hpZnQgLSAzKTsKICAgICAgICAgaWYgKGxvdyA8PSB0aHJlc2hvbGQpIHsK
ICAgICAgICAgICAgIHJldHVybiBiYXNlICsgMTsKLS0gCjIuMzQuMQoK

