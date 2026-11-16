Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA40606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jMKlc5Pe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GBJOJIQf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT64m-0006lr-1I; Mon, 16 Nov 2026 18:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64a-0006eh-Iw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64Y-0004X8-P0
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:16 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCDNp2710439
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FaaV/EsEktMabD8dGYYauHKBWzcfKbywPrEEulzv7u0=; b=jMKlc5Peu8e0pV1D
 eQbh08M9WZVPQaFoikQfClWxWD1uhHOdY5LqKEZhwKGoIrLiOd1MXUfbdotVHdRa
 MVaN0II8cUU2SQ21NPpYsmAHjaBNnjWwIh9eQ86h7iQUoNjpJrdwMPdgEW2TtKY1
 DiR2XNIP0/FephXA0yPv+9tzlTJXDP0YM+dKjk/P46QLiAjVgaS5oKwC56E8ecPl
 EpC2ffy8XjYFQyn3dOeZP8PT7xk/ie96qPE/9oGbS10vRdy0IMXluqtnbbc2v5di
 0sCoNSjad/ixrojy9R2kSEVOfDc5se18oKLK5YHX6dvPSMcbSQHCq3aKFo6IvIXB
 u/Y6CQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htgcsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94967c6d4f4so243690785a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871512; x=1795476312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaaV/EsEktMabD8dGYYauHKBWzcfKbywPrEEulzv7u0=;
 b=GBJOJIQfr8fHdjXVkCjAGkRYCTTOjnbjE0hupKN8YBjtErcy2WguABruQmMETHA+qh
 koUVfAUSt61p4+SeIqSP6XFZZ8/VTVwp3bp8kd00+WqUlKzQxkI9a7eYTB60ijKX43is
 qYuZ8J7bdAd3lCEMCeDIe2phXy1PAPEE8sv3boD2F+reDLjkEIlmUuKPpN7NXWpUg1Yv
 3E6fzGnilEfng1gf+DGzM45aptEriOppAl7Uv7Malfz5GhR2Q6Z3pAhMtxHEM2bUR9Bf
 g6KbGhBb5aPh5W21VeQC8Z+Heq3ichAbAvAopUNTwLChEMLIH4PVxto7JqbYQC6bTSCA
 5jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871512; x=1795476312;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FaaV/EsEktMabD8dGYYauHKBWzcfKbywPrEEulzv7u0=;
 b=Azl9aSmriEC1Yx6fqnutnW7RmLMUscJX708KHsxMhfoP8WniKPkFzond0uwlfepvYs
 RmNPrkLKBfMvyNUIGMYAxa4XTPIXMqkZvkEbpLeqbXqwi3JXJKoTriTrryLnXDkJQkIs
 f3PPRm9iZ2D0YuT+jT+WnwVvA16L1RoVp4KfJY/Bnlf3oggpAEOXSh91Xs/ZNdYSzvEo
 HIWMGO00PoD8Vka+IxHMcOnAqfxd6Epe41sccEWgnYVGEbUkSUa+CnjUHND8ylYIUj7j
 S5NyOpsjmxYcsWWif4S5td+p5bXwqeZnNQSvyXjQGSyvJNKOD0h1WsDL0HH3Iwz7Rijb
 kXqg==
X-Gm-Message-State: APuU4Z8FA8HJArLI8o09J5RrJYb+ngHaBn5LyrRLM2ch/HnC/UK5GGyY
 6NlPoA3q43FhvjDeoFxaIOM6Ype5r4GhMZNv3qqngYJkyiRJY33Ry3CI4qJtDkTcrPStcKBWzDR
 btrGceji6OjXbN/60rMGGe8CjP7DEjhrYsrBBqp9vzCQbUbYxuD7cKPNJT9y4v4GZFQ==
X-Gm-Gg: AYBFou23bIZd5llIqORu7seMHv3YkbAabtMtHGKvPfnD9AxIdzelFzghKt/VR+Cqs6A
 8xKh1ZvVPNlSL053Or3fsxu4E8NXw+cAuqZg+KM9nUg49WhY9qkqN1hHABzChvT8jpZ3C5YGEqG
 dgWYx9PDWjxmhrN4gg3506gtpTTZmF+yw/SQ6RRjncHXIR9JwUttv3SMnaYgg7KRVa4sNS6CAw0
 WP75xEZHERB69g72NQwoThPo8ZfCGeccYVRTZncpYF4RMOJKiGHn9N4tBugmJP0ROkbiWRF9Kgd
 0HCCThMSYxvQ8gLna/kli5dkACDGpNTBQ9xw6pBTXlVut1TkqMoK7M/a0Hq/2RkQudT/yK682sl
 h2cN0/NUodBZTbT9/p68a4Wyz/aMfMbpvgeHvY79gXu8/q9gXnbucz/t4kDlB/3jyVTOYAJNWo2
 raj+2VO0ZRvFSZ/g==
X-Received: by 2002:a05:620a:1a09:b0:948:e2fb:c00a with SMTP id
 af79cd13be357-9494bb892fbmr2006538285a.28.1794871512257; 
 Mon, 16 Nov 2026 15:25:12 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:948:e2fb:c00a with SMTP id
 af79cd13be357-9494bb892fbmr2006534585a.28.1794871511755; 
 Mon, 16 Nov 2026 15:25:11 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm24239567f8f.35.2026.11.16.15.25.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/22] pvg: disable by default
Date: Tue, 17 Nov 2026 00:23:25 +0100
Message-ID: <20261116232335.31593-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXxOQG2V/FtvZ3
 YGqBfIVjQaFly7FikUTgvTPwVEtwX/8Is196DAkhvRklSlP9O7Li3UNJcKvOiM21TPZtaXMB7ip
 FIY68y+Wa0LNcQFqGqJ8OQIcZ3J7nxo=
X-Proofpoint-ORIG-GUID: OQufl6KCOh1hrJVn-nKV4XnWEggdUsRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXxpdRJW4a/AHH
 0qse1jTeem841B+ET3g9J7WWRbJnp9oAIqU2/gwMNwX1//o7SX/15+ZvEhXLeZXnJMQ1Pp7auyI
 i99K/IRIauNoZ2Y5kCtay0eglVWs6uqt+g4lYWLaZ6M9Xth5+OcvwSWoW5Lfne2NYlBGfFUrTS/
 O4DDaCqUEfPIjUskm3CIpw2CNzc1QXe6FM5EHKlsTldtRRWmBohJWwLJ6qvMfFmiGX67FqOcABy
 FtV2DTq20pPz6HVZgBqgymzgVMurwUpW6LEo23X9q/fV0mJdh9Y9aSUOAkNZvSb0e55Kg+LqtG2
 6dadk3eh6pI1DDW6x3z5z4j1uBW6OcnCMsHP2OYFVAtCTO4gLlMSRGzrxep7E59mZR6T9GULsS6
 1/QnIYuIvcQ0Wpn7T891qQqP+o3KNIyL0uqE2b48wyuV5i/R7GCTCcLPP3el+wNTREY+hz6xyd3
 iAt8MxIw8r5hQAJfmug==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb90d9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=sNqdT3DZ9Mi9C-_xMs8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: OQufl6KCOh1hrJVn-nKV4XnWEggdUsRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohamed Mediouni <mohamed@unpredictable.fr>

macOS 27 removes support for x86 processors. As such, support
for ParavirtualizedGraphics as a public API has been removed.

Current QEMU does not compile with ParavirtualizedGraphics enabled
and the arm64 side of PVG is not documented or supported by Apple
for third-party use.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261116144951.71940-1-mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson_options.txt b/meson_options.txt
index 9ae8e44ab54e..ada233473eab 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -208,7 +208,7 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
-option('pvg', type: 'feature', value: 'auto',
+option('pvg', type: 'feature', value: 'disabled',
        description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
        description: 'Ceph block device driver')
-- 
2.55.0


