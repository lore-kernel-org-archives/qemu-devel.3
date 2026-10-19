Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC8606DA67
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9M2KwzE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ki6mosL9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpPE-00048Z-2d; Mon, 19 Oct 2026 11:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpPC-000480-Ha
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:36:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpPA-0004jm-Bq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:36:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOuqY3158941
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FzkLnVpfa8cVvGFe0S0jDhiA4X7/iHEOcsADfUC/l4M=; b=O9M2KwzEJwQyRO/P
 DC1FqezHKgrT3RWNN1ojIef8xAukxq0Gnd+QHP7exxzHu2kqNLCXp7w4cmCJ1Q9N
 1M/FAeHMnuHiUDKDBGhF7ILluzbpMsdg1lc2c6cgUtnp/C1s/crXUgHgSTzqEYTE
 kV1+9gbQvVw06kqclKmom+iHTz/gWBkSrPooa4fLOJdgs+31cJqrA2JAyJ10d3Mi
 9DSmqi8SbOWUXheaLIOp08stVpM4TpuTiBkwWlXSqjDMyzP4YzBBcc7K5zTRC7i3
 u1Kw+gIn+bPIvKa2yM/DeKlMC7tu6BUWSu98hmAVK+zT7GgGYZ1KeRVygdzK95Se
 hb1jGw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x9ygm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:36:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so3848317eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792424162; x=1793028962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FzkLnVpfa8cVvGFe0S0jDhiA4X7/iHEOcsADfUC/l4M=;
 b=ki6mosL9viNRpjCa3ZSwDw5SxVHuyBwAm9OTnddzeyvTx25OS6ZF53BCe3drScgnbI
 6y5s0QRZVc0thoHpZEvJd1o1+6GyYCRzSPZyjjjyYGU3SUi4/NxeXASgMI0anHoetpPw
 dk4edLojFHWuD6yVvnuUmqOfWw6EcB/r8AdYDQl+daBFpz22vGyH/tWumGzRGgmiffNX
 A1AjQxW3PmsYi+FsvwWcENaXop/gDkteXDJ2M++VkdBAioXhKJuHXEgD8vAr+CNdc9Yz
 7GItkt2J3cZ0PO4GKS8CJGx6KFSGFEMWfHiGt8u5qAUU+uTPefXE7S/PiZcys0VdobQy
 jZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424162; x=1793028962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FzkLnVpfa8cVvGFe0S0jDhiA4X7/iHEOcsADfUC/l4M=;
 b=n9Fd65xpx1SSjVuqkHti6BxJlGbOLLzg/dMnQYCPAoWHNTBAqh87/8e6QEVS0CqPXF
 8TRiCE1kJyRekSG+uzQjxK266ZHwoQ+Hh4suHh3xa4DuSLOB3yb1UeYWTqsbKTIWwvwU
 1vDVpzWsX2SKgTZP/3GPcWxIL1BNhZ/BpMYlRB9/MzbJntJty3DFRr0kzURYkTXMp9uj
 9xR5S6q31nzh069jRvvZlxjDu+PoZAYw4AHs/1KiXSXi2yc3ZO5O6dwAGoxYM0uUs2Cc
 6IaOabJ9k/djJdKvtnehtAYeyDsALcUhaEeRCE5Dt0sS9DB9R9YecaB1JY8jMU/htA/t
 UBIw==
X-Gm-Message-State: AFq9FYKzy6mGHpFWlke+fahmfv4Wfc4S5TrTyB3DuvFqOAOW3G6ORkjC
 BfMBGpv/VHyWDbMW7SSdw8x9cOZg1Ai72GlP/z/R9nSabiMn8eK8NPH7WVi6PxqA2DBibRZxHXH
 fXUN4NSBNzVKIyn7QWH4FLEp3Hy4yfeKWA7JrtxB9DwiOJY4QjdYaxEirOzSGh542HA==
X-Gm-Gg: AYBFou0T3x2rFawcjyRTSOzOjYknQhF7KvFSNTKJLLofYSI5l5dJO1DwLhJNRWD8y0W
 LUQbWrLCWLehIorof8iEcTR5KMV2rmUScE0aZZLG/g3Q+JENoG6nWEQ8Z0NLxQRI9z8hw05zpRi
 R1bp9vyuuQ8goP/HRGM/bIatZuJUSEkMSVQDzUA8kRLdjDtIR4eIlfFBBNlWu86F7Muv15m+w04
 MdocAE0bNcfgQY5A7TDvF2puBhqguw5LFyZXa6NWaomO84ysdhEcFta0K+yEbHcxKnh/2gbTYat
 +wjtalSNAbIjCU82UeypCAMXkxILaT+RuHQqEO+2ptKGHi3+hAdz1rjR1I/PEG+KVl76e0PJCbd
 kAaB0y8t7NoRaLYdDrgKE0FZMF4EW9h+KmSg+wjmZ5ULyRVA=
X-Received: by 2002:a05:7022:e808:b0:143:50a0:56d6 with SMTP id
 a92af1059eb24-185118edb25mr12918458c88.7.1792424161422; 
 Mon, 19 Oct 2026 08:36:01 -0700 (PDT)
X-Received: by 2002:a05:7022:e808:b0:143:50a0:56d6 with SMTP id
 a92af1059eb24-185118edb25mr12918429c88.7.1792424160764; 
 Mon, 19 Oct 2026 08:36:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm33595924c88.4.2026.10.19.08.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:36:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] target/hexagon: assert qfloat shift
Date: Mon, 19 Oct 2026 08:35:57 -0700
Message-Id: <20261019153558.2422277-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
References: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 88GuFikPo1XzOo3utlG_o9T5qVs-UuKO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfX0Z2NcPDd+OTP
 pxyFmSX958XnQ1k/3IOq7culbB9CaMbyCnLTYPtcVODZtQh+EA9JsT+GeISDpkQibeB28bvDuqA
 02I/Gl+xC2LY4bzZYElLVNrG7V1MJIY=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad638e2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 88GuFikPo1XzOo3utlG_o9T5qVs-UuKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfXxakJxkmi+H26
 3L5whyzOuURoq2WER4GDNDSZDpFCrGW6urNi978YHqnHhruqF8tPK92Fa3bR/5OaFLTWgqNG3hb
 l8P1/liIq/SdKZXg/HHlfyIhi4EVg8sfTdQrf44mkjKzQzCp1vmhnIHJeeloxuOXwobO2uwGP0P
 fcXlanORhr4vfRyZN5afRc6Z51CtbO0XC4MgzOof2SWUMzCOMjhyXt83flssVRgGY8W/rwL0Zgf
 bn9iT8m9FxTftUwDaP4keRJXgOeDkFNzwQXVI/HLnxcg6uDLyDw7C6Mz+jkITJuCwfQ/vr9aGq+
 lsljF0pzWyfu9G7+B5n2xnEkw6Z65mhrgN7kV0ckoFzpPufaiVmvTCKg/TR3BY6VC+L5/uL/4w3
 HZmp2aJsbJwYUHHb5jJoMU8ltJaZ3nMSM0FmpV9ExTkE9ECt6ztz+rHaf0KwiAPztlrh1rlwHcE
 2iQ+zeESRI76WZud2Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190062
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
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
IENJRCAxNjg4MjQwClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0LmMgfCA1ICsr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3Fm
bG9hdC5jCmluZGV4IDQxY2M4MjdhYTg3Li5hZmJjYjExNGNhMCAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jCisrKyBiL3RhcmdldC9oZXhhZ29uL21tdmVjL2h2
eF9xZmxvYXQuYwpAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdGF0aWMgaW50NjRfdCBsZWdhY3lfcm91
bmRfbihGbG9hdFBhcnRzNjQgcGFydHMsIGludCBleHAsIGludCBmcmFjLCBpbnQgYWRqLAogICAg
IH0KIAogICAgIGlmIChtaWRwb2ludCkgeworICAgICAgICAvKgorICAgICAgICAgKiBUaGUgbGVn
YWN5IGFkZC9tdWx0aXBseSByZXN1bHQgaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGV4cCwKKyAg
ICAgICAgICogbWFraW5nIHNoaWZ0IGF0IGxlYXN0IDQxLgorICAgICAgICAgKi8KKyAgICAgICAg
Z19hc3NlcnQoc2hpZnQgPj0gMyk7CiAgICAgICAgIHRocmVzaG9sZCA9IFVJTlQ2NF9DKDMpIDw8
IChzaGlmdCAtIDMpOwogICAgICAgICBpZiAobG93IDw9IHRocmVzaG9sZCkgewogICAgICAgICAg
ICAgcmV0dXJuIGJhc2UgKyAxOwotLSAKMi4zNC4xCgo=

