Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3F606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nezCFlTV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E9Rlbict
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcYY-00043r-OX; Thu, 29 Oct 2026 22:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYR-00043L-Hp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYO-0005sH-DX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2K1cK347649
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=68Db1Dn2IVIQizyHVsDyUN
 gEyrq3mEgt0JNYLAmuXz0=; b=nezCFlTVBW9HFT0QOai92zLPRSsaOcIwSpIhey
 SBLyC9wMebZR6P7cYyC2Cl77D9Vb6t4CfdGBVcaLgYRXkTTSAaD/9DIc+p3pPrp5
 ROtj3VJ1NcsWdbWt+nNgSlFIpfuM5xd4FzWlsqcr/B1+aKY1Ob3Kf9OXsCCNFoAR
 e5BsEwO/cVDkrmjFOBEcYc+0GODIBC71m2to6xIatYnygWo8Y+kOq6r6enj80XcI
 JbnFFlTCBopAqSPqTJv2Xeq9iLfoK6xuBSwKR2fHGycvO7p7r0u69e2noc9Sq1EM
 GuRjM1CIhXGKQTxiC6AwqBCVx5ZHwCi8Dz3hPM94Fz0dPfzA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pgtjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3692c5b061bso852256eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793328073; x=1793932873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=68Db1Dn2IVIQizyHVsDyUNgEyrq3mEgt0JNYLAmuXz0=;
 b=E9RlbictWeUAI+p1YKSnI5UROkQskS/b99B2VRzV6fZGY2IiOa+TlPfh1WgF1jUXCk
 nZkLzsOSv4drDI8fP63IbuXtGdp/xc3ogSW9Dbx3FqkCyGPPdRDY44llWJise3c9Sysx
 1YmtcsyezzgOQCw2WocMwlSXKAMb+TprR1aB1+QEJy76MXYSzoPite1maRBdaxKoQSv9
 4FE7MffpiaOz2+4Ll7SSyoTobW3380SnYUZvhHg9I8y8hf7KxROvsXoU+WVo9AjI0u4f
 /4nGlgXZCm7Z7S/rNYEMuignp9Z3P3j2QJI0lxqbaS2pqPug5J8SFDkj1bp8pEbmAIpq
 Nc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328073; x=1793932873;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=68Db1Dn2IVIQizyHVsDyUNgEyrq3mEgt0JNYLAmuXz0=;
 b=ZAf2SZQu7ZbbzvA2+bjrBbiNBjQ6yXGqSZLil4LrkjG6LeL9fyGPsVg1l2Y20EgOjM
 msKtHkPdAPwNYSuMXlF9Mdq85ZEWjQjViLWhjRvoB+Fw4J75JHYJhakTfbRul2UxLxZ3
 pNGsBIRv7bqnwJ0VJz8Pk2HGxL+otUSZM9SoTiFms3/utckRf1ehiIIw1GQquq6P/VB+
 UuApwvNwnbNjqyhy1u/X2w1xFeDSX4g1Hptf/Q/Il264nZS0o+BT4KsZ5E08x2e3DGCR
 YQ9vDYaGLp2LDoYUUWTAdyY6+nrjoBd5oHMdLGbzERHj+2SgC8DOkKKDAXc6abpCt87D
 1bWg==
X-Gm-Message-State: AFq9FYLC2OX09RU7AHWT/W5HE46/ENaWtn9ixpir3dtqIKEFiQobkluV
 l9gFAeNwXQErTziP5l7iAeGCJrqNf4FMayvJ8G98R5f1NbtlaewxrC5OZAbspV8dDkELrPiQn54
 lQluVLBKG23hPu58AllKpw/CiQqpyqNF/R08pA1U0P9vqZAF16bXJZxw5T4DTctOwGg==
X-Gm-Gg: AYBFou2c9dAlU2MPDOyuVFQdJpynCiTSJfC3FzLmixPHmu3PAVE1jq0FVHe6I/MvU0N
 7DsdM7DzEyJRqiX+AmGhT7ayFTrTG+BdrezTQ7fOnWzaTNeTU6YlGRuczdDxHvrU2eLPwlw9mKG
 mOagpF7mX3FsvCEPtwABOGu0IuoNelFgEMdSoNaSIQw6KxzPs+vzFFK9NjLNjCxbZ+jPuMcolP0
 BTzkbLP1S8S+EqtWasMVXWa9ehq4hUhqU4lfmx4emAgP5tVA4h878hcTmhDus1j6FUclTQXZLzz
 YyzeGJJ073IJw7E3PamgCdVPaOcCYyK+SQGO0Gxa3QRUAi0V/nuW84LRdKEH8Qy1c2CfYrIYCno
 jKMxVXvsN0iUc4n4+/45sD8cYjib4/WflOiSl1jdgzO0yETrfdnhrUypsnu+l8QoNcKjObB9SeU
 Ov6lzx4wCtiFcFZp6Y6bUxqQ==
X-Received: by 2002:a05:7300:cb0b:b0:36a:1c97:26e5 with SMTP id
 5a478bee46e88-36a4232f2bdmr2228531eec.12.1793328072378; 
 Thu, 29 Oct 2026 19:41:12 -0700 (PDT)
X-Received: by 2002:a05:7300:cb0b:b0:36a:1c97:26e5 with SMTP id
 5a478bee46e88-36a4232f2bdmr2228488eec.12.1793328071601; 
 Thu, 29 Oct 2026 19:41:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm2704624eec.18.2026.10.29.19.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:41:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 0/8] Hexagon: HMX system
Date: Thu, 29 Oct 2026 19:41:02 -0700
Message-Id: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfXwxW8OVl7GTjz
 EcRYa0zkghWq062nt3tSGMlaRWM34VX2VEIeOoTYU0ZUA6i2D1PTMjHv6PoraOFDIuvECEZU9Te
 thhkjPb8dP+SK0Hptgc+tK6QDw3lixO+wHgeL+EzNnCjpvnZ3u0/wjP81YArz2Rg6qh+SbG+knG
 j25G2ewrYtCMEjuk0iIfuxs6W9l/337MBWehDHuqwqfOUZamEpGvMRB2KpJqsOdxwyVagxWtcR1
 kNLm8rGDziRRNkzfGd1UIhuNjynBy0tGR0aJVP6eZzHhue7gpY0vkbZwxM3XV5Ckx83xV4mKrHN
 BRRxRE5/14vz7VTP3Tl5GOG5K4/2i9J9yhzgHCroM+t0KHwKM7shQqwv3Dh9gaCkEt3VxgmBwIf
 EMVpP/4+Y5ZafCK2LIJ4VQZSBhRIPXJ0+SYamPGXn5t0josiSDUvwX3RcoOW8X2x8wSeKaJ+yC7
 Pf0zFbjxZzXriHWzJ2w==
X-Proofpoint-ORIG-GUID: PwqXLZcevbOOWum7k4P5J1ni1CKEJEwz
X-Proofpoint-GUID: PwqXLZcevbOOWum7k4P5J1ni1CKEJEwz
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae403c9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g5sNiIH2hlu5i20qNuUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX4hKrato32D/X
 z5U9WcZsYH2b+OsGKCGN9tudtyXeMTg7No4dKcJi1Tmg4pbE1ubDoRRlxKGHSAfPPv3T3OZf7Yw
 p7eU7aeaZ2TjGfpmAsWtI3P6uU7anjQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300010
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIEhNWCBzeXN0ZW0gZW11bGF0aW9uIGZlYXR1cmVzIGFuZCBsb2cgdGhlIEhNWCBvcGNvZGVz
IGFzICdVTklNUCcgZm9yCm5vdy4KCkluIHYyOgotIEZpeGVkIHRoZSAuaW50cm9kdWNlZCByZWZl
cmVuY2VzIGluIHRhZ19yZXZfaW5mby5jLmluYyB0byB1c2UgdGhlIGNvcnJlY3QKYXJjaCByZXZp
c2lvbiBmb3IgdGhlIEhNWCBvcGNvZGVzLgotIEZpeCB0aGUgb3ZlcnJpZGUgZm9yIG14Y2xyYWNj
LgoKdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjEwMjkyMzAzMTAu
MTYzMjMzNC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDgpOgog
IHRhcmdldC9oZXhhZ29uOiBhZGQgSE1YIGF0dHJzLCBzdGF0ZQogIGh3L2hleGFnb246IGFkZCB0
aGUgSE1YIGNvbnRleHQgZGV2aWNlCiAgdGFyZ2V0L2hleGFnb246IGFkZCBwZXItQ1BVIEhNWCBj
b25maWd1cmF0aW9uCiAgdGFyZ2V0L2hleGFnb246IGltcG9ydCBITVggaW5zdHJ1Y3Rpb24gZGVm
aW5pdGlvbnMKICB0YXJnZXQvaGV4YWdvbjogZ2F0ZSBITVggZXhlYyBvbiBTU1I6WEUyCiAgaHcv
aGV4YWdvbjogZGVzY3JpYmUgSE1YIGluIHRoZSBkZXZpY2UgdHJlZQogIGh3L2hleGFnb246IG1p
Z3JhdGUgdGhlIEhNWCBzdGF0ZQogIHRhcmdldC9oZXhhZ29uOiBpbXBsZW1lbnQgbXhjbHJhY2MK
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgICAgICAgfCAgIDUgKwogaW5j
bHVkZS9ody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuaCAgIHwgIDI0ICsrCiB0YXJnZXQv
aGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKwogdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19obXguaCAgICAgICAgICAgICAgIHwgIDEzICsKIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9obXhfY29u
ZmlnLmggICAgICAgICAgICAgICAgfCAgMTcgKwogdGFyZ2V0L2hleGFnb24vaG14X3N0YXRlLmgg
ICAgICAgICAgICAgICAgIHwgIDkyICsrKysrKwogdGFyZ2V0L2hleGFnb24vaW5zbi5oICAgICAg
ICAgICAgICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAg
ICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyAgICAg
ICAgICAgfCAgMTMgKwogaHcvaGV4YWdvbi9oZXgtYm9hcmQuYyAgICAgICAgICAgICAgICAgICAg
IHwgICA2ICsKIGh3L2hleGFnb24vaGV4LXN1YnN5cy5jICAgICAgICAgICAgICAgICAgICB8ICAy
MyArKwogaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMgICAgICAgICAgIHwgMTU3ICsr
KysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDI1
ICsrCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwog
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRhcmdl
dC9oZXhhZ29uL2hteF9jb25maWcuYyAgICAgICAgICAgICAgICB8ICAxNSArCiB0YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgMTAgKwogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgIHwgIDIyICsrCiB0YXJnZXQvaGV4YWdvbi90YWdf
cmV2X2luZm8uYy5pbmMgICAgICAgICAgfCAzNDkgKysrKysrKysrKysrKysrKysrKysrCiBody9o
ZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hl
eGFnb24vZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5ICAgIHwgICA2ICsKIHRhcmdldC9oZXhhZ29u
L2hleF9jb21tb24ucHkgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9pbXBv
cnRlZC9hbGxleHQuaWRlZiAgICAgICAgfCAgIDYgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
YWxsZXh0ZW5jLmRlZiAgICAgIHwgICA0ICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2hteC9l
bmNvZGVfZXh0LmRlZiB8IDE0OSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2ht
eC9leHQuaWRlZiAgICAgICB8IDE3NSArKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vbWVzb24u
YnVpbGQgICAgICAgICAgICAgICAgIHwgIDE4ICstCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24v
dGVzdF9zeXN0ZXN0cy5weSAgfCAgIDMgKwogMjkgZmlsZXMgY2hhbmdlZCwgMTE0NSBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4
YWdvbi9nZW5fdGNnX2hteC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG14
X2NvbmZpZy5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG14X3N0YXRlLmgK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYwogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2hteC9lbmNvZGVfZXh0LmRlZgogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2hteC9leHQuaWRlZgoKLS0gCjIu
MzQuMQoK

