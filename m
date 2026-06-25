Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3435CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcku2-0000AV-6p; Thu, 25 Jun 2026 10:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcku0-0008Qi-N1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktz-00007M-2R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juto1753960
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=Uep86Jp3ps0fWohM
 ZazpZf3+IWErty5hutkamkEB2e02MS86w09E4IEp/D6LLPr6IinOsL0/cUztuKKV
 iaahpWDfHsWCR9luMsQ7JeFagnbfGvZN736V1wUliRh8qSFtZgfIju/sFpv+g9Po
 49yEXA12Ztvoi+UJBZySKpd/Z7iyGzsspWUuYUcKH0XKztjeVbauZmsQky8gzoG8
 z28GB68Q3iHQZJJxqbjyuMxSH0HikClv6+bGVupAmBurV2AOwxJ7ZbR+sOnHSKdQ
 kEF4YToc7A4XpDkzkoasQuDGWDuG9o2T+s3vhtdxSCsywQnCvmS1Sj8RVHrJTL9v
 oMChxg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q26xs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c5b9f6a51so648714eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397067; x=1783001867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=Ps27DDtp9bEWpeXjViUOZklYHEpODePPY+gRPlaLQzMzA7SvyKg28i1AsdpDjRLlIu
 Ywi9LLjYGwa1UpA5BzkxG7HlbTF6wElum9mbEVVN6u54XCa2+GxoevcXgk/jjHwk1rpa
 jGnMeoZCj5BD0mDHZOq1PuJVLqEH5P+MPv+U7IE8XXqFqTmBg3nYEbhUrf07u1lsHCDV
 yGzJzAf0Bk0perR+r8gjM7ymQCJN984SaG9XnVIr2x+ltEipPPhOCINx+qAWVwpRAsge
 IxQqVY/bJXCN2gdsbjTlvi35QsV+9CjIMc5a4hbu17uHx0cApW+aRBCFHiAXipfKrGqA
 bbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397067; x=1783001867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=HRLT7+3qpkXznLCiF0zMCh9VlsZgECqyeCgyD68FzS0nt0iHSYP+ZdvyhWXG933Nqi
 QBchDfL+3fU/TsTldXdDL7LST1+yDv5D38Q602SgEV78lq5ruvq89lF7eCMOVVyOOi5O
 wIp3Q/q2fm/cNYG5NtxFA7uadJBLF2w8774j2nH6hjVuBqXf0SL4rQibXXg0WW11bjZN
 +Q1gkvI4XZPJoYrIQhBy2ozyDjocc/SSZY2m5tmLrQzOcrxtfKDOT6JEm+2KJT5bhT+A
 UasfzJOwerCxWO4aXkgdhl/ZHkesdAPK9DecpfwQuhdFJAjsuJtvPKwRh2rX+W/Lzw3V
 qwNA==
X-Gm-Message-State: AOJu0Yw+psWr/0pGU2/OBkS5t8GpDDqaczaHZGrO3HRTtbo1/s7l/8to
 3bTiEOMAeB2Cf0I7Hwl88Q3/LkGaDjh3TgsrX6xU6S1eI8iB5hYVrqP7X3IplPs9OQvgpcyLmpv
 6ma9mt/7P0REH3S9unDIn5p291ZQHHDHmsbk7xKsVq6h4uVaJYhLojhoItbGzkAlAjw==
X-Gm-Gg: AfdE7cki2Nv87lPCOweLVpkhhqUJz33HXD8PGgtK3HQj8xdhFPLCJv2hXsLI2+JKMFY
 2OHArhPTMsKI+ifHkqHTVKXQdzt+0SUw9B7GsG6WcL3reU9FaKTv/HQT7udJByVF13kUCjHs6Zi
 PQIG1diN38Accmpxl1n47u7Idv0VW+f3CorHRJtLxrkqjLSEKSrHUAlXQrnuUrCD2ookxi+8AB7
 LY4RNSbvwIfQRW73Xf3hTBCZXTWNnb0sOaaP3wb/MljhUg5eUFBqRDYI2NAA7nvZPvF+j1eJrG0
 yXK5eJkBc3QiCRQxxOAKQCbILzc6ogpQzbNo5yOlFpM8y+7zIhURBr7SjmzfHANpIvw2xJjCFKZ
 t41EvPsXfj8ifKQUovMx8sIbT/3Y1qXfNJlB8fBORWDF/gDh8hFZhzEdJxpI=
X-Received: by 2002:a05:7300:372c:b0:30b:c0b4:db42 with SMTP id
 5a478bee46e88-30c85a5cd27mr3415352eec.11.1782397067091; 
 Thu, 25 Jun 2026 07:17:47 -0700 (PDT)
X-Received: by 2002:a05:7300:372c:b0:30b:c0b4:db42 with SMTP id
 5a478bee46e88-30c85a5cd27mr3415323eec.11.1782397066594; 
 Thu, 25 Jun 2026 07:17:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 32/76] target/hexagon: Add representation to count cycles
Date: Thu, 25 Jun 2026 07:15:49 -0700
Message-Id: <20260625141633.449487-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: fWC_k3igJLIlCyuk7hcI9KBrFs_FbSZI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+GqCwSmYObbz
 d3y5LPqJ5fN8UiojF69gF6Nw58n2nApaDxzZDB0eP4I5Qh0sUTYwJiuepfEBON7n9C1hPcQkPSW
 w3TuApaARPZOTcHpfPEV1ol3ZttC/MM=
X-Proofpoint-GUID: fWC_k3igJLIlCyuk7hcI9KBrFs_FbSZI
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d388c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+4aOjKzqZ8JG
 DoaeNTq873KaX2vYmZg8TRdDyidKf6JK5PWQuaImivyxy27mLFf+ssoucJDDGSL22U1EDNqiVMp
 ZBEYZV403Wk9DahwR3LtixMOhILgAHWkIeHSf1Mh6cZaBLan0ZQpyvsSVxDzbE4rC98xulZDd6H
 86y/Qx2Zh4ML0TLL6LoA836FHygUDHvHoRSZSDfEpyayfxCf//hH3gaUbrYfSEUxicv7x+fdMRQ
 mPVTcnLmu8gG8OLAU7V29mAkxpEX8WvKvRdbBf6svz+wZG324JVQ4/RzQiSbS05e3mZgNBI2YzB
 QIgfeN0VgKaa6C9zM1GbWH7yO7jGQbjk22zQyaIr1wISY2qcDj0nfdhjV2abtE+VhJP1sc/MY77
 s5fhre0WVYYYC1K+1Vmh54HI0KkrmYDLHbxBlNadPt47rFMdIPge3PKxNN1SUkDC6F8c5g+KvJP
 nVrcEJ52ZNS58VaPdLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

