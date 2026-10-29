Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFF606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFnq9Utp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bes1oGBR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRvY-00082f-5t; Thu, 29 Oct 2026 11:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvP-00081v-A3
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvM-0003dG-Mq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeIPF2761923
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2OGhPPdwB+qabvhsoxF85A
 E4w2jcTx/kcY1mbLCrWf0=; b=JFnq9UtpX/PkYnaHwXAoYY4cufFMe7L2MdBV5A
 313Ka0tvSoaywg6UOx5f6s+EC/zGwBnhWYAjDLEnrBgXG3X7kAdlvnljd4TbbUbn
 ZxEPhYZ3R9HS9mFkRaVDbLGG11nyk4mVvGpSJGywLZeXqPUggKyKdOAWpfpnBmrN
 stHzA/O9wdI4kSR6hT7iSRhPfTIjT9TmrxsgSoAfat/nXvcdfWxP5fcqSwF+eK4O
 VNM8YsSKM5ol04VrrkBrDq8o7/S2a/HULSrUv18f5hbaM8EKD4nK6rodgocnxYLe
 Ncv0C2pYaGDUuDWMXRQioigjNgvI4UKmoZBLnLeLJGPaZ8Pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b1faa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f559420f3so200165185a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793287213; x=1793892013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2OGhPPdwB+qabvhsoxF85AE4w2jcTx/kcY1mbLCrWf0=;
 b=bes1oGBRrMdoB66pvn1PlTU3eXtB6JRa+ypGdUmALpoIYSsgrzj7k2H45JPUpsP6e5
 YRf6bklKIR9NLYd4xh0p+XsDVsimK2wvsmbWyCklIg3bgD7cTqZlQtoFj6WlH4UoBcK+
 1mQfzG2asWvbFLWkyy+Z8T3CPcGSTxkQT+awyN5vexUTBC0WkB6VHzj+MGnCISeLVBEU
 /iPk8tFpKSn/XkkDMqWoaq6kDx/DD2rOVkiowVREszc0+4OEJZ0nfzBQuJjdrFplWl0j
 MZ9OBBXbG3Fvh1D6V9aVwRESLQjnfkg/RmOSYyGOU7/iWrsjLny2s1Z486vcLORFZ3s6
 CDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287213; x=1793892013;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2OGhPPdwB+qabvhsoxF85AE4w2jcTx/kcY1mbLCrWf0=;
 b=pSGBaFbXxHpgfSRSSmHvg+8Tg+bu+FqOGnmWfUs1wIRXSfMjhjznk7sn/QvAmrsNx9
 FNNdlMZCU5u//orihrWL4wl+7nTm8HDIxOW/ExTDjmcBQccw2ZIdJZCBbOSPQBOqNQvD
 NuIW0pj+QVGr8yt8dC3bS28qckeJfAuBg59enIQ8gB8t3LJIi82q7HVG9+GVoSXu8oLQ
 G1Dv4tyzQTF8eYiFkLxmJkZsD3WfwTpqwl9ZTrKKV/9HPUlsg67LkVxpwaAAcz7+FBwN
 qW91rsMbAZuOYfqKDGLOaurFcYV80M6aW4i6R8ijwd2NCL6GILcGuZef368yfn+sgJOR
 hSzA==
X-Gm-Message-State: AFq9FYJ150sborb/YImJ34wd3yqmBTT4T1SMZAYag2Fq7pDEXDg15qTD
 rbalw0OLTbgdmdJ1+xqP9wlrjpEyScVuup7oFYUNKoKhal3kWaxyScluidTymW139uOTtX9zCgk
 6MgAjSmAT0DE89Fj+bLYhvd869bO3D2boxrknKjsfbR8pUjml+FHQ74YqcSQcHdfBHJHd
X-Gm-Gg: AYBFou3jkC/vxYqs6AH+mbAi9F4+0WDg5JMOpI9KWyGNs+23PvoAXUnTNV5Y4BsuKsK
 szzBJcFiJDGq9rtyPnyM5P7mdwX8cOJOwGY2/ydJA9XqrfVb6BVIpWoWmn52eRbQ+8ws5ljy4MD
 6DltmVYYK0LFtYnBroWobaAiwE6mzoj/IHavWyKAkddrn9De2j8GhttEFMzfGoeXFEkjRBrg7UY
 YfJ4JuYa3n8C8t30vsz4NEKa8PMvHUS5U3btSYnWgPAt+Kb4gH2r8soeExbf09fXH+dYKUaW6v1
 vk6ozy5BaZM6stAye8VSPxD9NsdSPV3OXs1Mu6ydCYAdf1i+KYBAVYiRG8/mO00C6hrBuW12YEF
 WPwLGA13Mxv3mNcRdgTEwtI9rrv4ktNP17Dql0/niCdGLJCdIQwk/TPW8/f8hw6bheCKUzOm4el
 wwHYJkT8f1uaJjptFkGMF5tptJ46cVeA==
X-Received: by 2002:a05:620a:4486:b0:940:f224:5a63 with SMTP id
 af79cd13be357-94408d0b33dmr990694785a.64.1793287213258; 
 Thu, 29 Oct 2026 08:20:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4486:b0:940:f224:5a63 with SMTP id
 af79cd13be357-94408d0b33dmr990674585a.64.1793287211225; 
 Thu, 29 Oct 2026 08:20:11 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2640sm70678815e9.6.2026.10.29.08.20.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:20:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] tests/tcg/mips64: Test Octeon POP instruction and report
 with TAP
Date: Thu, 29 Oct 2026 16:20:05 +0100
Message-ID: <20261029152009.19812-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfXwY9DZCL0kusO
 3bmyUun6mrP0HFHxH3tb4KgjtFyRY9+6JEUySfz3y1UvkTl5hXs4cpDirrDf33cq/SxMoIfNL//
 0TbqqglgOxHbX6rbbPDbAP7Ks1HQHwE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX61B7msQtQf9a
 6bAE9sBzGDk4bbXmpGxBlAsJTACoxa4kkecnSUHKJDbcJZXX00hkMraTZSNgM7Kgk0xisezl7uP
 FlNJxXT8noycnb+7jbrUT7Iksw2hSDtvVAeLlSe48F/P19XGZfJpxzNcgux4iqsN0xzi5ZovrM1
 ufB/WX5yr8lRjUE0pNUh06tyRneLWcN7tZOupxc+4hLHAFOsdQTXbLWq24sIoNnKc8nhfS1l7c8
 mqC+veuSB6m8Hjk6nHhcSRyzYAQ0nibijaGigw9YULsY/reiFgrAJ9yjApQX3eEb4Zg2i0decWK
 tFMs6MUj92qlIUyWYoWKzVzjUQtHE6+571MgGcqdvJx+OaEHguqUSW+aaICJgLY4al2XjPgnDlU
 Jm2p7xYCCuRbktvi+igiWanDA2eI/wAf+jgYv1PZQw5q8B1l28twhGC777gtyN8jaQ3ukI3Bgby
 vmWWg0Pc5muIO2UK2bQ==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3642e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=z1y5NhdPnG8iZszXh2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: QclYorz6MQnfrmu1t27o4o4_p_3i969Y
X-Proofpoint-ORIG-GUID: QclYorz6MQnfrmu1t27o4o4_p_3i969Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Leverage support of TAP protocol by meson in the Octeon
tests, simply replacing assert() by a handy CHECK() macro.
We were only testing the 64-bit DPOP, add the 32-bit variant.

Based-on: <20261029151317.19170-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (3):
  tests/tcg: Allow tests to report results with TAP
  tests/tcg/mips64: Report Octeon test results with TAP
  tests/tcg/mips64: Test the Octeon POP instruction

 tests/tcg/mips64/octeon-insns.c | 94 ++++++++++++++++++++++-----------
 tests/tcg/meson.build           |  7 ++-
 tests/tcg/mips64/meson.build    |  1 +
 3 files changed, 68 insertions(+), 34 deletions(-)

-- 
2.55.0


