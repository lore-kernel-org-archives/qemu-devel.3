Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59145606D836
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YMg7iCK2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PKVPKgBF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwxB-0002lH-AD; Thu, 05 Nov 2026 07:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwwz-0002kW-NL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:52:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwww-0005fU-5N
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:52:16 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tWDU406831
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=C4wyhq0QCfy+i3u8v5T5DX
 pWAtc9llSmeEyL5gk7RJs=; b=YMg7iCK2dQuIT4T18+Am8zHmo/7wVPG7DVPGUe
 x7/Ik9xQWwwY47tVZAjvh3PRqvztI6dBi8d55i+TMcSm6qwbNlCe7gkU6RYfimT7
 9k93ueSwgcBsX7bbxRC/UcF2cwfJFX6o79ToTwEig3YIJK4MQ8GhThdDt92KLQMq
 +9lOMdcWp62JMZiU1yzCw9op1RqdMNVnWaU0bf2kg5WYcUFvA05vidnkKE8uuuhY
 n/EqynFP/jIvmJSEVulpfWpLPZKTOT9mHackjO3YgRpmcrEeAq+KR3CaSPNNB1Ha
 wsPCretCErsbKkJGlqU/yO7/SXZ4dPJW1v32wH1WPkowZ1aQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v1m00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:52:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so415670885a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883130; x=1794487930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C4wyhq0QCfy+i3u8v5T5DXpWAtc9llSmeEyL5gk7RJs=;
 b=PKVPKgBFp0TYw0MsDoi6ai0lOModOLJV2g5zOBJA/oWdalLVyVXr4GvF/2/X3VmXKS
 FjJOnjOXmTkdb7RZ1gxD6+z3UMer4fJPgAfjHVk8RCrbjNzt5UqF+LyE6Ga/wrXP+scc
 FPAkcCcbG0rYjQif/kNg4+RTJf2fwgCwFXJU+Cf9V2oWjkBy1e0HN8Mfi8ItjM9FYD2T
 4Luflz1i17O/Kb8no6eo4fmaAZw9SGtduYQsH5Vsth98tR+Q59fQGnmmlctGjDfpc/X5
 M8wufTFC5CS4xgjNIp1uhJC0mpeLapUth0XN/eFNUaJhGFjNREh4VO3VhPAA4U3QCHnV
 BdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883130; x=1794487930;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C4wyhq0QCfy+i3u8v5T5DXpWAtc9llSmeEyL5gk7RJs=;
 b=ONKvfSz29i8MIM/N8hFThDcQc32czvE4ykUtepK9CEzSWI7cQHGYdFWH83jdnw2+Zq
 ZYWFZd2UhbdjKsw4mS7+UifqCWGDHQ+XwvEYTxr7nmrbhjNHDKbokt59EE+XwZlHH+rO
 rvh42ChDSjAR+hFVeMHAhjetUZe0h7jRY/cB72tsOSgR6MEbUfoqKkAf5lfgmDXJiSOX
 6mZpcISwXgg27KgJoxZs//gpA0foVGIkRhmo6E3Ox+OMmcYR3dTjJWisMK/ZSdb/QLIJ
 vDqjpO8WhfgXohm6qEvX709I60/aGcXihc3XmUvvJNeNwWDFlpeKOjB5K0azHGZKmqax
 VRKg==
X-Gm-Message-State: APuU4Z9EmUgzjT4dSOoxjuMsirSFYrw6jA3VxAHWN7PEUOo8X80MUxzb
 CroonIpvl5Dwf91bUO4k0w3GoE9NCfTGA0XjhYlyD9rMvTvO+SZNA3WF78/vFbBXfAFNPOguuRC
 vRHVxtfCCUp/iF9Qzg8am7aDYJ3+U43R2y6jo9dHws2/DjGsshotJJIlTkioQE0X9YQ==
X-Gm-Gg: AYBFou1/G1IBH8mo1pbv4attnoWUwogM8liv6CCHoi3R1n/LnKtPIoslqGvj1uxxGPS
 EXeuPfdmCiKQm/imoMAlvKmggJD7hgBsBmG67kO+4G+VXsAZ8F5DINybEmOrrZClYs8ZsuFRnb5
 wAiaWGfi6OkDjp4AKPcGRO6iiPsSUbZm32xpqnTYRG08uHEkJoBYQeVxNK0Lm28Ug6RdigkcnNX
 BKU0TWlWOXq8kv8sQgwm9U+Q5ezAQn2Gvi6gni5LkTDeadrR8MoysaTjAfkDYmoHcGZ9ID3vku/
 /D6zdTx/3SIIHUiaZi1GtFEwFDMzn2m+yIHPJmMu60SywDlf6OeOl4ORlmgd4gNIPuXxPe9sxwp
 isUVJackG/9k6H4uGSQxtdsO8b7nXRDpzc7ZieM4elfkB3TzIfAO0/g+pFC6qswGx3vZxKhV33Q
 SQRHCmcv4NuM4xyWvBO2vjaTg/XgfGmQ==
X-Received: by 2002:a05:620a:2614:b0:93e:920c:bfcd with SMTP id
 af79cd13be357-944217b0ae7mr3278776185a.57.1793883128850; 
 Thu, 05 Nov 2026 04:52:08 -0800 (PST)
X-Received: by 2002:a05:620a:2614:b0:93e:920c:bfcd with SMTP id
 af79cd13be357-944217b0ae7mr3278772785a.57.1793883128276; 
 Thu, 05 Nov 2026 04:52:08 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55ac57b9csm1738357a12.15.2026.11.05.04.52.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:52:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 00/17] buildsys: Replace some deprecated sprintf()
Date: Thu,  5 Nov 2026 13:51:45 +0100
Message-ID: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX9Uk9UjZuQk0y
 8zN8o96QoS1pm+DBX0B6ctYYQaNZERGwuGWrkm+JW05fkV4L0u60urtyILCjDxjyAGl+It7kgKq
 Rme+87yqeHS8RgbJRInPTf1NL/PNXjQ=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec7bfa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ym21472aoLdQ4Bz9H1MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXz3/1yUtOPsVL
 Yep+NMdFjlaju0o3T0Qr4oPfObcXQJjpEIOQjK+tNoa1eu2+SvZvt3RecaxOWXJJTvTgwjq26kk
 BzIRK0k5Hhf5M+XFqvRXxX118lhC5MtKeBwuWA8kbpo51Bdl8aQJjEsYvUqhKBMERWdNG+SuyP6
 s8b3nwAKFmBKwMfzRTfe2bewnSK7NmcAuHPOHM7uAynbkGHgYksIbycWWMONKUZZX+po3yOgI7w
 GgfiU2Hz7hvDzgOPTM12SK4cJw2fihiCuXyPTMHpVbpc8wMF5BD/owbq02CyggJhmascLNex1vL
 sB/R5e09PCk+tOUIQq4qNFgQB0qrWhhL3wVC3PEGsXIlwsJnmvngok27IJebGRS3ERXRQw0crnr
 bu3MYV759eXdw2ALAkVoBEkWeTXxH7lbTqoZ5jciCleCOggvlP6A5CoRwMSy2u0qvWk5lT6PjC6
 51sK0piDOA8vdOh8JGg==
X-Proofpoint-GUID: IIgABVGEWqUmcHTPmiIL1v95AWTuKk8O
X-Proofpoint-ORIG-GUID: IIgABVGEWqUmcHTPmiIL1v95AWTuKk8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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

v2:
- Use g_strdup_printf (pm215)
- More replacements

Since some time now we get the build output cluttered with
many deprecation warnings, it is becoming hard to notice the
real ones. This series fixes few recurrent use by the
--disable-tcg --enable-hvf build.

(Yes, VOF is not used on HVF x86/ARM64, I haven't
 investigated why it is selected and built).

Philippe Mathieu-Daudé (17):
  tests/qtest: Use qemu_hexdump_to_buffer() in qtest_memwrite()
  tests/qtest/npcm7xx: Replace deprecated sprintf() with
    g_strdup_printf()
  tests/unit/qobject: Replace deprecated sprintf() with
    g_strdup_printf()
  tests/unit/visitor: Replace deprecated sprintf() with snprintf()
  hw/ppc/vof: Replace deprecated sprintf() with snprintf()
  hw/usb/hcd-ohci: Replace deprecated sprintf() with snprintf()
  hw/riscv/platform-ref: Replace deprecated sprintf with g_strdup_printf
  hw/vfio/pci: Replace deprecated sprintf() with g_strdup_printf()
  hw/ppc/spapr: Replace deprecated sprintf() with g_strdup_printf()
  hw/net/eepro100: Replace deprecated sprintf() with snprintf()
  hw/net/rocker: Replace deprecated sprintf() with snprintf()
  hw/scsi: Replace deprecated sprintf() with snprintf()
  target/xtensa: Replace deprecated sprintf() with snprintf()
  target/m68k: Replace deprecated sprintf() with snprintf()
  target/rx: Replace deprecated sprintf() with snprintf()
  libdecnumber: Replace deprecated sprintf() with snprintf()
  qga/vss-win32: Replace deprecated sprintf() by StrCatBuffA()

 hw/net/eepro100.c                        |  2 +-
 hw/net/rocker/rocker.c                   | 24 ++++++------
 hw/ppc/spapr.c                           |  3 +-
 hw/ppc/vof.c                             |  2 +-
 hw/riscv/server_platform_ref.c           | 11 +++---
 hw/scsi/scsi-generic.c                   |  2 +-
 hw/usb/hcd-ohci.c                        |  2 +-
 hw/vfio/pci.c                            |  7 ++--
 libdecnumber/dpd/decimal128.c            |  4 +-
 libdecnumber/dpd/decimal32.c             |  4 +-
 libdecnumber/dpd/decimal64.c             |  4 +-
 target/m68k/translate.c                  |  6 +--
 target/rx/disas.c                        |  2 +-
 target/xtensa/xtensa-isa.c               | 50 +++++++++++++++---------
 tests/qtest/libqtest.c                   |  6 +--
 tests/qtest/npcm7xx_adc-test.c           |  8 ++--
 tests/qtest/npcm7xx_pwm-test.c           | 14 ++-----
 tests/unit/test-qobject-input-visitor.c  |  4 +-
 tests/unit/test-qobject-output-visitor.c |  3 +-
 tests/unit/test-visitor-serialization.c  | 21 ++++++----
 qga/vss-win32/install.cpp                | 17 +++++---
 21 files changed, 102 insertions(+), 94 deletions(-)

-- 
2.55.0


