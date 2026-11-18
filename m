Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011E606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppMUTDm2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GZ2i0nGw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTjmw-0002AP-0O; Wed, 18 Nov 2026 12:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTjmt-00029r-Vy
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:49:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTjms-00011y-By
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:49:39 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGA94401627
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GMQh/LrdbQVmwpvsX1LQfc
 YMX2xIrfdSJjTQIoN6QSw=; b=ppMUTDm2DNlNaNv/004ZZaIuRxs0QDq/9lbK6T
 q0ACpzx9X1kYaNOkB579FrCNzr8IB+6HW2WGxTENGsYVT6riS9w2JFNpJGfVqXEC
 1rGJniA5Mdj7v4jF8LOR3W0TX4fkRmDGZs6ovdg/LxVRYvkpCLu4u+QOGVoxMUzY
 +zK0a2VnoqGlielG4JnCxBlsdZVgUaN/qTcR1ymewTBCmCFPxxXbNP0KMf7h+Su1
 rUqE6Jdf3rtS3uFFvqfzsjOebwafjsNCvYwbGZuzbaWOgMsn9cBTkD37EmBLg3Qm
 fw7pxNJDZt2tvExW8ol8xnKQIKHVSbZNkIteC+zMNy+B258g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qrtgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:49:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b3b45597c7so2284802c88.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795024175; x=1795628975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GMQh/LrdbQVmwpvsX1LQfcYMX2xIrfdSJjTQIoN6QSw=;
 b=GZ2i0nGw2wEgal0UXbYqqywlT6IecTli2+23/6yNjJfSscW40ec6E7uL6Ndsg3kkn3
 c94P8ViJW0Kw41VX5s9qexsUJurOnBU0csfHXYLbN5QhK9flqUdxqZZovPiNxQeDx9bJ
 Qs5L7Mud8MGSg+AmeeFR4oQtXtOvi8FhDzoVA66WD2sIrP6DUysHBYkRP9OeZt3vg0k0
 NLUs41I86tbSsxOjeYAGBnd6CwNLZ2SbxOXpt1uh9pU5l1NzFOzP0GS/yF8zGbvinGBf
 dr1RN/OcJdgCkdgCIET3Otr1K6JUuQcdmibx0Rr0KsPW+0HSfM9ndDeat5ZJ4BOBJkcw
 uc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024175; x=1795628975;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GMQh/LrdbQVmwpvsX1LQfcYMX2xIrfdSJjTQIoN6QSw=;
 b=rV+ynwENflt6DOkDj1nJAZJd1x5wzqE/8u+eNt4s9Bv5JsQxaYNWJXEm7dOozUbXRj
 yc41TFXiZLlD9A2YPbBIWRpt1796AFBY/awh3s2LpTpGVbCNasHJ/yTDvZK8tgoirUDe
 Krxxf2dcisHgLJw3ObpF4II+muHLm3C6Ce8KOBJb2gQGRe5fn7S2jOehZkDw30wyC8bQ
 GfwQWl4+5DMuCMlgg4d/asAkpTXm8UZ5iC+I+o0nW0dP0bRPSuaH2YM+T73Qj8yhZwLI
 1JoXKeOXMiD8TgdsHqJVHjY3LbXeK1hvYRc0mTRoiCtc0B+zEterApF0sCdSmuBoyU99
 BbwQ==
X-Gm-Message-State: APuU4Z/hWBFD5lq4r7SwRNYAd/FPRmoceB4ts8wPaMx8MsHa6BA7yyIe
 0/xRfGRS71u/KxnWZHxfq9KhNzAlFdRkMRklVp9ra8wjFrgJG00Ib70W2UM8jKDz8KYYfMZ1xCz
 hXFYxMSh1P20YrqTvctta8sHV2IlaWG85nvc1cwZLtXlQaohDqn6NoPXWqdAJW9QxaQ==
X-Gm-Gg: AYBFou0PZ0Lgw44JhRAar2HNyYlga4BctyvpHXF/XQgFUmgDsnHy9bidWfiCgtzu/Hh
 T2In1Sg3F/rMTzSwlmZCE2anggNqQy+qUUmwvVnb9EklftzFrJB0OiR7ZJ4wB8E/X0C7FF43wND
 EXw4kFuCcC0o35CDh1MNQu7yfkXjcY9+sbQFBzZxtuCVNnxvkRpSdGhch/Eu+R152TKl2xxQv3W
 ajAqomB7JHTwJtEaJCOLh0i9/5fddScUddg6zRL8vMeZNRDBiSfjLT74njSWiR4tzixWoCktxqu
 179Z7NAXA5EydXGIH2DXPxpKgQzlQ6LghSF6N14U7T3g9k+ZYi6bwtQe5PkxE4v+AsU4nSEVwe/
 bOAnWxbEtJfv7BccgAF7wKBYBjN6+NWrRoTCGezlAGd9UKPU5DvJ7bwOWVo3EThd6hCuC5Wkb0B
 CAhBq/l5/IJ3WPQA/wHFQE
X-Received: by 2002:a05:701a:cc93:10b0:166:862b:9bcc with SMTP id
 a92af1059eb24-1b543cffed0mr3247298c88.18.1795024175284; 
 Wed, 18 Nov 2026 09:49:35 -0800 (PST)
X-Received: by 2002:a05:701a:cc93:10b0:166:862b:9bcc with SMTP id
 a92af1059eb24-1b543cffed0mr3247274c88.18.1795024174713; 
 Wed, 18 Nov 2026 09:49:34 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm10292884c88.5.2026.11.18.09.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:49:34 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-stable@nongnu.org
Subject: [PATCH] linux-user: copy nanosleep's remaining time on EINTR
Date: Wed, 18 Nov 2026 09:49:33 -0800
Message-Id: <20261118174933.3814952-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: V5QkNJj7AmZ7l_nrMymKiGlR09OeeqTm
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afde52f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=48bKN7e9TvwGekxNErQA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MCBTYWx0ZWRfXxhCFaZIXUZUL
 2OCB67aezvyYaDtYZEr94mvnyAETW0paEmzJEnhuD4cV5F2PrUHE0KuV8CMz+Z1hIOBcAtr9xBT
 dbf7mZTFVF0kq8iIjsXV7LAJjnq9+tY=
X-Proofpoint-GUID: V5QkNJj7AmZ7l_nrMymKiGlR09OeeqTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MCBTYWx0ZWRfX626aAlWwVRMy
 JxQmHcJc7LNbcZ5y0BRkSASwV/PN+JJSwT1QHbaPQjl9y6TAEpPCBlPhpd3TY6Em5LoPek+C9LI
 1/McyWtbtkrITmxZ2ZliLLshPfrh1zwkPSdy4AQ/7wpiyX8tU9xlI5mh1cPg5WaPOBbRu15dZ5F
 fgynFdkWUdmil6OELKGC9sge9c+baIcKynBnFhQVzM9/A4pvK7f3qoT5Z+pvzj6rU2LesgOtuBs
 UA6dbol93C7M0FRpg9HNS9R6zrbjng6qwKT5zL0WRWySLN9KY/GfXGhv13yCWCCw+1/wKO781JZ
 Ogw8HLXhg/nc7CacVoToYoaAH9SKSY1X+Syz8Wm44xgfqlA6Nvzg5RnpcnM8LoHHO/YBTy0F47J
 nCvCIgCDZEyzNHM3x8vu0572WnG6v55Osj6fdpWeRPJ3Al+/3uybZgQkdiNVG2+TRSCpkQsvvur
 IcRhHDxWo0rDLLtAndg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180070
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ZG9fc3lzY2FsbDEoKSBjb3BpZXMgdGhlIGhvc3QncyAicmVtIiB0aW1lc3BlYyBiYWNrIHRvIHRo
ZSBndWVzdAp3aGVuZXZlciBzYWZlX25hbm9zbGVlcCgpIGZhaWxzLiAgQnV0IHRoZSBrZXJuZWwg
b25seSBmaWxscyBpbiByZW0gd2hlbgp0aGUgc2xlZXAgd2FzIGludGVycnVwdGVkICgtRUlOVFIp
LiAgV2hlbiBhIHNpZ25hbCBhcnJpdmVzIGp1c3QgYmVmb3JlCnRoZSBob3N0IGNhbGwsIHNhZmVf
c3lzY2FsbCByZXR1cm5zIC1RRU1VX0VSRVNUQVJUU1lTIHdpdGhvdXQgcnVubmluZwp0aGUgc3lz
Y2FsbCBhdCBhbGwsIHNvIHJlbSBpcyB1bmluaXRpYWxpemVkIHN0YWNrLgoKVGhhdCBpcyBoYXJt
bGVzcyBmb3IgYSBndWVzdCB0aGF0IHBhc3NlcyBkaXN0aW5jdCByZXF1ZXN0IGFuZCByZW1haW5k
ZXIKYnVmZmVycywgYnV0IG11c2wncyB1c2xlZXAoKSBjYWxscyBuYW5vc2xlZXAoJnRzLCAmdHMp
LiAgVGhlIGdhcmJhZ2UKdGhlbiBvdmVyd3JpdGVzIHRoZSBndWVzdCdzIHJlcXVlc3QgYmVmb3Jl
IHRoZSBzeXNjYWxsIGlzIHJlc3RhcnRlZCwgc28KdGhlIHJlc3RhcnRlZCBzbGVlcCBjYW4gbGFz
dCBhcmJpdHJhcmlseSBsb25nLgoKTWF0Y2ggY2xvY2tfbmFub3NsZWVwKCksIHdoaWNoIGFscmVh
ZHkgb25seSBjb3BpZXMgdGhlIHJlbWFpbmRlciBiYWNrCm9uIC1UQVJHRVRfRUlOVFIuCgpDYzog
cWVtdS1zdGFibGVAbm9uZ251Lm9yZwpGaXhlczogOWU1MTgyMjZmNDMxICgibGludXgtdXNlcjog
VXNlIHNhZmVfc3lzY2FsbCB3cmFwcGVyIGZvciBzbGVlcCBzeXNjYWxscyIpClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBsaW51eC11
c2VyL3N5c2NhbGwuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvc3lzY2FsbC5jIGIvbGludXgtdXNl
ci9zeXNjYWxsLmMKaW5kZXggMmZjNjFiM2VhYmMuLjM1MGU2OWUyZDAwIDEwMDY0NAotLS0gYS9s
aW51eC11c2VyL3N5c2NhbGwuYworKysgYi9saW51eC11c2VyL3N5c2NhbGwuYwpAQCAtMTIyNDks
NyArMTIyNDksNyBAQCBzdGF0aWMgYWJpX2xvbmcgZG9fc3lzY2FsbDEoQ1BVQXJjaFN0YXRlICpj
cHVfZW52LCBpbnQgbnVtLCBhYmlfbG9uZyBhcmcxLAogICAgICAgICAgICAgICAgIHJldHVybiAt
VEFSR0VUX0VGQVVMVDsKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIHJldCA9IGdldF9lcnJu
byhzYWZlX25hbm9zbGVlcCgmcmVxLCAmcmVtKSk7Ci0gICAgICAgICAgICBpZiAoaXNfZXJyb3Io
cmV0KSAmJiBhcmcyKSB7CisgICAgICAgICAgICBpZiAocmV0ID09IC1UQVJHRVRfRUlOVFIgJiYg
YXJnMikgewogICAgICAgICAgICAgICAgIGlmIChob3N0X3RvX3RhcmdldF90aW1lc3BlYyhhcmcy
LCAmcmVtKSkgewogICAgICAgICAgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9FRkFVTFQ7CiAg
ICAgICAgICAgICAgICAgfQotLSAKMi4zNC4xCgo=

