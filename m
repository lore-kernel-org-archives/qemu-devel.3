Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28351606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OzJ5WHrV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pq5EYn8c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB8x-0003U3-TQ; Thu, 19 Nov 2026 18:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB8w-0003Tu-JB
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:02:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB8v-00019V-0U
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:02:14 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1NP13814558
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HHBhEjMGCl8EbFhvgcNzBr
 Tu60EkUHNioI1NKpoWu0U=; b=OzJ5WHrVDvceRG88B8jlWhuOfGARLYQGlj7LIW
 VUxCnP9SSfH0Z3o6yF5S7qNHk3h5DQVhvlnqSw67NwdfHvuMG1lZOOZIOdsRjxi1
 HbifIHYD7ebgNcHIb/KIFxf7cTTimPRNnqGF7/Uz1ohbbdvzy/iBGqCfNuFZrPlv
 gEF63651IAiUJtw7vSlfYL/9HJzJC3LSEmDtaULr7A6nRp/lt1ot+HLMeyzZ9ZfT
 yIc3kknItO4lOwc6QF7bPmsSLALlGZKT9URhVrkfKrMqxB7WpMQ8mZlmJ66qyGF7
 7O/uv09qjjYDkleXXmba2Z60awfjsV8xzEHHIUoPxf62plkw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6urpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:02:10 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b18c67095dso4830337b3.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795129330; x=1795734130; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HHBhEjMGCl8EbFhvgcNzBrTu60EkUHNioI1NKpoWu0U=;
 b=Pq5EYn8czSAC/5ZH4FbbelKRBfryDromQlfNVrpo1U95vUUvneAg2e/bNGv4CaP9Mi
 iOSWjkvkY7LRmVGFMWyfEb0E64GjtvIA8do1ADcCuGCUDqEIY2S1gBatF8UiTWyalieL
 tcXK/9SyR5LSDFLpugFGm7WJGBArsxI6JZYFb2eCYtBh9WbnRsttMylAPt0DPSfT88TP
 Gq0O0r6NRHT7ocml6b4Mq4n99lE19yv1QtFMkzQNxwaNdxM6ud4vtndSLllFSdiabrH3
 QoRUSpoFRtSdAGbOejt6rU2J3IGLeqeIOGB9wZzrG/X6IbG5T1HQMA77aIXL5BIq6/4R
 en6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795129330; x=1795734130;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HHBhEjMGCl8EbFhvgcNzBrTu60EkUHNioI1NKpoWu0U=;
 b=Zn3+DwgOszG4jp0o0ZHVQ91oAKRcGZgSIfpumu1ydinpei8fBIyE0pw/CDc8Rmx52z
 8UtGuRMMQd9YkXKChlJhdLxxjQHg00poZl+nKsmEhhjS2QNBsIPw/v+5cupt3wMAZu6A
 InRZIY9A3xqfm7lxrCXq2XBlJ1enGhGpLiub+jc3Ihk12uc9KhtpFb+Q6nXO3UCVBKf9
 f4XsOrSxQffYcmmjIY6TwO5uKT+aiISbz/D4PQiUew+ta0ol4F/hphwr4EIPSL490CR0
 WxIQOvLUrxCiqy7GNmIVu3510m/WNaiPClxtrm1o9IIFO8EnOCOgTAKOPSjm0TkBxA9a
 uQNw==
X-Gm-Message-State: APuU4Z8Gs+aKCwMr7izbi6XaDC1EvOjWLxqmdlJMxPiQNOEnQCGJYgI+
 aqYJQybgoegJY5N2eVHC82cC6Ki7uX5zAoXjUmQ1oKiEjNGcj/PQ0Mm76gI0Ai3s7+h92CWdj8t
 UeJd50bA6RwBL1EjiCbG18GF3lONgQdFxIxpkNGNkGYXwRHDf//ng9FkcIALm3lH5HT/n
X-Gm-Gg: AZFdTZdtbgRO0yL8m4lI2K7oxyup0It4M/CWXEzWUwyW3+QdjOocDm+GHEZNb2kavz9
 1y/Cgefn6CE8i8W0HlwUENAJ0El4s3I7QGzMyxMPtj3fWwH8RsVO7OGGpJzpGLjYzVNTg0yk8py
 j/VovQ6DHXp0PQ1HhwKP/GUJRsxSvK9KtH8oHEBYIyJeZFay7Gu7c3aAVO5ULqkZR9BqyiMeeX2
 uZTeoqvD2zWXXaBBkHg0oiP7f6Dzg4dUytAmVB5+buzm7D5GV5k6BEEClAM0NJsiGb+ZR4EDlr0
 3+3sh/XRfe0iuQkenaeYZJEeZPq8Uc1BC3meoH7iY6JcbS3hWvPuUuedCxxuQ09FAyVbuiuwcZO
 jA4LCoT8TQlkfmTp4ihY7KdCe5J4ujJ+Ot7wutBpTb2qTvfXG6CfMykKey81HU97z+AX1ZCfGzp
 O9/NUshvQcq0RWUA==
X-Received: by 2002:a05:690c:31e:b0:8b4:c8c5:6b14 with SMTP id
 00721157ae682-8b520480078mr5799117b3.32.1795129329552; 
 Thu, 19 Nov 2026 15:02:09 -0800 (PST)
X-Received: by 2002:a05:690c:31e:b0:8b4:c8c5:6b14 with SMTP id
 00721157ae682-8b520480078mr5798877b3.32.1795129329034; 
 Thu, 19 Nov 2026 15:02:09 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm2000344f8f.50.2026.11.19.15.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 15:02:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/2] target/xtensa: Describe RER and WER register operands
Date: Fri, 20 Nov 2026 00:02:03 +0100
Message-ID: <20261119230205.4744-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aff7ff2 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=xUIsFMJfdJ-BqvSB1bkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX7yZi1UtOVTT4
 rHxzuIFw1xzI7ZToaAGgpD1UzCzt/ufvFsDminnukbFLN3qF9yjBzDOhhgSrUaRaTA+NVRVARni
 mZF7Ai7/WnCYxs1CLL1m3bfBx8zIToQg0WxnudqJaJ3nibxQqpE3Xhyl0vN/jEK17vvNdjam+MT
 qkz04weqDLn1R+6l2rXR0rGL6Hi809+BMK2FTlqBu7qj1sAP8q3vFYHnpsdzKCZpIOiwej6YDeN
 P0m1gmhtbOIhjefGhVSBBvLIaJp72DgaCy6DloPVGiGxmctUQcbNKFygGS0scB03xqTgd+wVQum
 nBfBLh44cPtOU5nRMQuASdXB+8i1symE0Y9yKYKD2HjwpWEC8DPhti9EoEkAuy+AWqqWxtHfMgD
 dbSel66P9b6UtEAnSEJtzoJxBo6HHcZiWfEgDIhYEKaWAuIajWzDDfb61rIx4zru0QGRllbctWf
 n7W9/nlw9+JeHR7u/6Q==
X-Proofpoint-ORIG-GUID: YLVRvWG-hk5JXtSygmxEZe67YoBna49l
X-Proofpoint-GUID: YLVRvWG-hk5JXtSygmxEZe67YoBna49l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX1ufGdvwJ+wJZ
 Cx9XzZqRk8ylRpgIHAIhZ9zoCMfAmtxgnbgXj5oVNxy4e6iJh2NPNzik58Cq027SeT3Geno3/++
 8rB8tZXumM8M5Ck0xn6834auEf3W0ew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dc233c, lx106 and dsp3400 cores lack the external
register opcodes arguments. Fix and add a test.

Philippe Mathieu-Daudé (2):
  target/xtensa: Describe RER and WER register operands
  tests/qtest: Execute Xtensa external register instructions

 tests/qtest/xtensa-extreg-test.c              | 81 +++++++++++++++++++
 .../xtensa/core-dc233c/xtensa-modules.c.inc   | 14 +++-
 .../xtensa/core-dsp3400/xtensa-modules.c.inc  | 14 +++-
 target/xtensa/core-lx106/xtensa-modules.c.inc | 14 +++-
 tests/qtest/meson.build                       |  2 +
 5 files changed, 119 insertions(+), 6 deletions(-)
 create mode 100644 tests/qtest/xtensa-extreg-test.c

-- 
2.55.0


