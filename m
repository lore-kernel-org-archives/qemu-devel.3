Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AE606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nt8vBelh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QyWIFQ7o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcMl-0006Hi-Dk; Wed, 04 Nov 2026 09:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMi-0006Gy-2M
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMg-0003fW-Fn
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:27 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4BZw6v119391
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5oC+P1nCpI71y+qROZXo6Q
 FIQD1GCbW6BQEFgt2qWHQ=; b=Nt8vBelhlKPQstPB4zumkiPe50svwGox0f73Xo
 U8QpjVQYIaizjvqtjAVSEVUvr2M0Bk+R8a+xTPAxUfGWjsU/W7DXYe1AypWxj6Zi
 ud9M8erEUnH/YtAcqc5hO8zeUzLGYRJNfGxZle6wrz+RI2PvYngbGrlKcWAKoZvp
 PgBBZXVvRh6NH9CZtw4vYddmv1jX9pIxZgLNZVER5xqvGuoyKGT0kAIElOMD5Dkk
 +cCy2KE3gICv/bmB8R6eXhFmtYhExmWSjwFyvG8J/o1TCegpOy34r1qjt+LnY8Cn
 IgPzqMf7MMujHoRH8WFwVkBLkrfJ5gCt2khU8lJzSvnWuaEw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb0agt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:53:25 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99064f8c7efso463642241.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793804004; x=1794408804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5oC+P1nCpI71y+qROZXo6QFIQD1GCbW6BQEFgt2qWHQ=;
 b=QyWIFQ7opztTwVEAyX8ypahnEfJtVz5RJIrkNdam23hpoRW1ye6hbTFwFyfZkliPdg
 BSpj0Q1reORsPlpR9Zf/hE2uOqJvbNUvZgoLTykGBHRI3075fnhA7xINLxNvEXTs8IJC
 wWqcL0eieZ1DOMrQTOae7qN18dmYPkHpRhkvQiNxA/FH7zHDN/6bnNuaS3Fz47kWdQnx
 +LB5+hcTfRzRMopwUmpor3JK2Mi6CJX7tApSymPHAifk7sKKEi/jfaf2FhDzT33IWS84
 aM4EXbHQ0aDl7+PEYbdlA6B6xjVFhmjI3qyWkImtQhgPl79tH58wHhQrVjc96L1mX/96
 K04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804004; x=1794408804;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5oC+P1nCpI71y+qROZXo6QFIQD1GCbW6BQEFgt2qWHQ=;
 b=qu5Ee8g1TfW7nrHMTMhATXGfPXBz1Q64BuSPfMv1V47XUEDwuUfQewjNgu1c9XJHr4
 aBiWDEkFqWRSiEBJYCT7rBR2tEbkOcqy2z/xbfPoO/eDXXz0pfawvVzLtCZyelqqnRjH
 iWskiVv30m92ZUso5agmDpg9gdrXVar9evx0lqlzt/oGCvcyrGknO7jenHGEKt3I/Amg
 qLjf6vpU0sH70d+3m3Y3Ct2zW/fFRmUQXkcz3xEwMiRBmDQoYMzfzkJr0dYWSBZDDzW4
 DK3XDywH/YCg/dUBj7xlEHSbgXHKIoYYLT/2p/wh58HAtjL5VX+HPI7lp7o4PWJJLGJf
 tT7Q==
X-Gm-Message-State: APuU4Z81tkkYCxw5Kj1SS9L7uK+zeRsdCJ4MCK1EpwZe9XDB9lE4pVVI
 YKCigfLHyc+jCWJ3zLx4OewnBomGNLvLXjd99u0pfELZAU3H10aIxCHBDHbQJylWl3Ty2xzCr51
 K9vNgT6GaAjvfu+fVedpxXI9PqjOOMQlygTteUwNkoaC04aEESbhrdny0V8cb/k2WWA==
X-Gm-Gg: AYBFou0JHd20RTHvC8BXavZSKpn3XcM8nsC/wbLGnZBNfarRJBMvgZnoUcSFudeJYR/
 C6vLRGR8WvyxYhi8kSp/XutPpNGeJceOGulG5kK4xRZyxGR+KuuYzFwNvWKcAo7Jqai/8CBzkFR
 7KqsH4kg0oKsY8lV3eCG/ED7Nay/4BxM0JTyaSaSPiiqSawINffx86tTTbadGU+7rfVkH6u5NRv
 tek2K/YPWqmGX+uMy4PZONLfIFisSaEzP1CXjb7NLo+k5MjooK+cKuqGF2fFJtA39CH7olV8jLO
 Jq49rXC2iIN3j6oMI2M+CZTn7kdXL0E9cYQVyno7lOsY4mNAiy6WDl9p/xe63VArtZ0ZGVIuv7E
 pM6MOUreu/VOewlN1lHBqDpOq8OBo4al3Az2J/3p/BJ2RQ/eqXr2fnmXR+DyeTRBAUr72NmUamu
 Lm8H7sHyI2KDoDnw==
X-Received: by 2002:a05:6102:3ec5:b0:7c0:cdd9:31c1 with SMTP id
 ada2fe7eead31-7d072615564mr7113536137.12.1793804003956; 
 Wed, 04 Nov 2026 06:53:23 -0800 (PST)
X-Received: by 2002:a05:6102:3ec5:b0:7c0:cdd9:31c1 with SMTP id
 ada2fe7eead31-7d072615564mr7113432137.12.1793803998666; 
 Wed, 04 Nov 2026 06:53:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fedc09675sm4390363f8f.55.2026.11.04.06.53.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:53:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/5] buildsys: Replace some deprecated sprintf()
Date: Wed,  4 Nov 2026 15:53:11 +0100
Message-ID: <20261104145316.18841-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX9w4gJMnlQ8sj
 bev5zsDBhUQP+VhMPJEHz3dfxoQkbKZIiWn3BGynTNzwDYFZnXxySDXWU32pUjEcJ88I+FDCl+v
 jkhNelAutnuwYG5mqebATUcc3fXq328=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb46e5 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=vRnTLshjCre8FNkmUVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: aqExp9UNyvCwhLXg0bdW1Het1NVRLfKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfXzx2UFeZwGCW2
 6kotoun/pmfed0oOTeRsxgtHpG7vSvSNhLyHcJpA5TchlwhdnBvBYK9RaSeY9iydskACG68ZAx3
 QmmJ9KQcpN7b2q9f+cpgbSAHCal/gZmi0PJkXzk37OSsOHKQobRWC/D0FNmN0Tpxi4FKeNkrDtQ
 7LwynnjdQAnk/H79pjnkaHBWDIunciM6PW/a4guPHJLyyeUvvjX6GlRhoThthbizJXdkNP+PiFc
 38u9lbwD2LYJstYY8wdaz2Td5QL/uKujISCoyJ+JRFOvqSB5zYZa7ibdvYy3dS+hGJEUUTp5zsk
 UxX/m2SHclD2jD4WqPcBudlAIYvptThrOWK0c0Hf/Gh51NmA5j1KC4jebHzQb5L2JycshNiwSkt
 Ip01jKaNZX2l2XRVqjsTQG9XM+9eauUyL+ryZwJY1yKKu9+gFo5We2HaXITgIqi+lCEiOgYOAWl
 8BeKCfxfIt8re3P1rPw==
X-Proofpoint-ORIG-GUID: aqExp9UNyvCwhLXg0bdW1Het1NVRLfKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since some time now we get the build output cluttered with
many deprecation warnings, it is becoming hard to notice the
real ones. This series fixes few recurrent use by the
--disable-tcg --enable-hvf build.

(Yes, VOF is not used on HVF x86/ARM64, I haven't
 investigated why it is selected and built).

Philippe Mathieu-Daudé (5):
  tests/qtest: Use qemu_hexdump_to_buffer() in qtest_memwrite()
  tests/qtest/npcm7xx: Replace deprecated sprintf() with snprintf()
  tests/unit: Replace deprecated sprintf() with snprintf()
  hw/ppc/vof: Replace deprecated sprintf() with snprintf()
  hw/usb/hcd-ohci: Replace deprecated sprintf() with snprintf()

 hw/ppc/vof.c                             |  2 +-
 hw/usb/hcd-ohci.c                        |  2 +-
 tests/qtest/libqtest.c                   |  6 +-----
 tests/qtest/npcm7xx_adc-test.c           |  5 +++--
 tests/qtest/npcm7xx_pwm-test.c           |  8 ++++----
 tests/unit/test-qobject-input-visitor.c  |  2 +-
 tests/unit/test-qobject-output-visitor.c |  2 +-
 tests/unit/test-visitor-serialization.c  | 19 +++++++++++--------
 8 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.55.0


