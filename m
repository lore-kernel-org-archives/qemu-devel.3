Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A85606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzxVMkF+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6wEHyPz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPEW-0008EZ-DV; Fri, 06 Nov 2026 14:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEK-0008D8-Df
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEI-0007Ef-OE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:04 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HtEUB1075848
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1+wAAFBq2H+Hcs04M0R2ml
 rZnoR2AKQMwKWfQxr+jw4=; b=XzxVMkF+JApNaP4ZbCRMIPBmtSKBvjxHADXHug
 p1pOzHsphexKryl6oO8s7Hno0U8IFyJHb1CjH0Qs5iKe8AsikqfOu+UrMAxosrfF
 fNSHnYT2GKTTIzsmcvILcP5S848vw7rppgIOy+ueWLoyJc0ouisDE5iueKWzPRBc
 r/3pqNUL78BCY8VYVCVCL2T+4MO+AK/Z6z5qOAQ4fd/i/bCMUqInWN6nPAmCJNFU
 dEgYxjwYcwRkGM9HsOyckeoL+p3bkUxYQhXXBwmaszuQTLhvkGwXXn2CE3nYLaWf
 f/toeRUcnq0W8blCSCw5OvjZAdpkSs8cQfu+Q5mW9uaNoFKQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb49eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:04:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdb4c49e4ffso572809a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991839; x=1794596639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1+wAAFBq2H+Hcs04M0R2mlrZnoR2AKQMwKWfQxr+jw4=;
 b=C6wEHyPzndauw+YtxHnaDZfRoHD+LH+/PM42sKTWcyazV2FdWQgkiDnr0SHoTwGAC4
 jikOr8/KXEuAK9HsV2QneyW4ynQYRPw1X9akQG5O/UeSN5HvoBudQ1Sro3G+J4h4Pesj
 sg8QZTGprNEhawgc1rK3hyWtHQljq6sFJNFvbFa8BeBYg+GNg2wB3F32ZvNgWsgwthRC
 HeM6XmdVokDBlNWU9nPfzQolAHJSMXZI4u51K0bzV1iw/JVYjH9pZhax17oOqvsuoib0
 qYwtF0cLgzL5tPVOQEbiIEEYTnDrbejjI07DevR4NwmzwxSmlbYogdUI+ztCwydZO+6Y
 9P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991839; x=1794596639;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1+wAAFBq2H+Hcs04M0R2mlrZnoR2AKQMwKWfQxr+jw4=;
 b=0uoFNtjhRGTF2qWVb3iF6mUR85GQckZaLAP5DGiV3PZZNuAUV8wp/D1d2Cn57zGwfW
 zDTPkRMd7cF29LzcT3JvhVUiVIGy53Xen2oaAUTebEVCQaco4lhwBKI53UbNpxFeEF51
 xZAlWOB+WNxkUlPKvoxp1/dF+IDa8470SNsKVijD6TFFUhQ7WbiFo0DRQ22xOz2kxyHR
 ThjCTEQ4KHVQEi9SbZrqt2OOrpQtWll8fqc82bu3GdQFzootx4VyzAu7TG0M9S491DMP
 mwZbcMQooSHU0K9wmIXpVlaDGbED9vkLkV4EgzVm2GujupL/2eulyoOwgEfcvnG3yrby
 z9jg==
X-Gm-Message-State: APuU4Z/DY7b/Dv9SJBSWXn1xpO6u18Su0T2VADjrT+outluxcqV75weY
 cKCYrJGIxWDOrDTkSsL61pgJxq6oi3XT4Cz0jHmoF0jwaPpRrig/ZgfCl6IDW6MFpMar/8RsNyd
 78RTwT41zyvetovVAzCYLaj1TmIg3L1Y724Bs1p2Io8lTwbFuQ4f4bXXrSyL/0k1rfg==
X-Gm-Gg: AYBFou061PIPjl4fAf/3mF4UPvoSOk8iz/ghQbswJba1ZYTYi0yuXVmpDeGIjNWjMW5
 CR5jT3k0xZxNAVcUO/jS8ae2ZthAHxF98Gxf90k/QvS/qn1JqZ6Qff3fmI0NuHFZR0wXZbbiU5X
 fWSs9KAh63V2AjP4RfDBmK/UbNWV9DMy2HqojDIZsh+Wh+6ytmjBwEZhu+bAWjfjY8K0/kgwuJi
 qlwcmDDmDBjnHHzXInwIK/9ctHpKSxm5KI/wc2FuRY0+a6+7Gobl0GECeS2y/m+dkW0rkuiOOFW
 1qTSnCMSAgrc1nyoCop30FeyAf+UljuWWJE5y8nudtRKPYsbVVjXQqcTOc5RC8xltvNWRr2wPiU
 S/Ua2Fr8jPjHFc1GiJqPzVEIdF6H11BktcOIQPdRESM4WLLzOZbE5jgvpkVGhegFewB1OVOkqEb
 1uTetRXCpZmAERSSVW3Ac9II+q7dVaNl9du0YF
X-Received: by 2002:a17:902:f64d:b0:2ed:2e3a:1fa4 with SMTP id
 d9443c01a7336-2ed40e8e3ffmr38141485ad.62.1793991839425; 
 Fri, 06 Nov 2026 11:03:59 -0800 (PST)
X-Received: by 2002:a17:902:f64d:b0:2ed:2e3a:1fa4 with SMTP id
 d9443c01a7336-2ed40e8e3ffmr38141165ad.62.1793991838877; 
 Fri, 06 Nov 2026 11:03:58 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d40d19sm8283735ad.32.2026.11.06.11.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:03:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/5] multi-target Final fixes for 11.2
Date: Fri,  6 Nov 2026 12:03:47 -0700
Message-ID: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OoTC3Vl0ufCt2sPB3pY66P2gCpBxulkc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX7J57761nXtYi
 Kk9VJP0TXXeAN7zJwbzcOARe2Ugj0+5H0aBjTwKyiXF4FqywHnnXP9LO8Kppbplp8hL1ubikiB3
 M7oErsKxeYuYj4/5SzZZsvwN98VEVcY=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aee24a0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=PDsJIxZcscwx3M2FGl0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: OoTC3Vl0ufCt2sPB3pY66P2gCpBxulkc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX4wVC6kXRQzLW
 8kIWefSiDTBXDPFp3d0mNGy88/hfnJP8J+ZDtCqq9V9/KCniju3WH9E9HXEXBIL314xUWMukfKA
 xMKjtrL34BcTYDKtOa04mTv4dWDMyj8dDMnMi/+tWA+swnLRhq00O+NIqZPS4a98bNhkklpEh/Y
 vtoX6glTpD3YxTvE+8kNR1Ks1+uERbyA5XnrUY2jh0e8NIuGVp4Y3UvfXQ+NvOrNQTY39SZ7hc5
 FIUSjUoVKbitjUCnEaNuExQTkeSukux1FXFE10m2Pg4A2fWWaRm8ciX4PnbOYwIc83z4JlzwqyT
 47G8sLNFnNaub4xH7HV+bl40IiBqpsAkQ0E3qJOGRb0heBoB58aSmFduay2yGoPBSOOnjnp6LE9
 7d80liXqfHzOtBs0cnGxkG1rnF0sWt1WJnpCv+iT95f+KoZSLk25bTh2vRknXWAzZNiH/eco/Ai
 qJlE0aZiMv5h7dFEbow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 76fdb3373c9a27b3f50ecc9e012cbdeb90af7151:

  Merge tag 'hppa-715-cpu-nic-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-11-06 07:49:02 -0800)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261106

for you to fetch changes up to 1b879fe489f8894c5b07438f0b10706db916ca4f:

  multi-target: restrict whpx-accel-*-cpu to matching target (2026-11-06 17:56:13 +0000)

----------------------------------------------------------------
Changes:
- [PATCH 0/4] hw/misc: move vmlaunchupdate.c to system_ss (=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20261106171836.2020151-1-berrange@redhat.com
- [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching target (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Daniel P. Berrangé (4):
      hw/misc: move vmlaunchupdate.c from specific_ss to system_ss
      tests/lcitool: add mips32r6el toolchain to refresh script
      tests/docker: add igvm to Fedora container images
      MAINTAINERS: fix typo in test-multi-target.c filename

Pierrick Bouvier (1):
      multi-target: restrict whpx-accel-*-cpu to matching target

 MAINTAINERS                                         | 2 +-
 accel/whpx/whpx-common.c                            | 8 ++++++++
 hw/misc/meson.build                                 | 2 +-
 tests/docker/dockerfiles/fedora-rust-nightly.docker | 1 +
 tests/docker/dockerfiles/fedora.docker              | 1 +
 tests/lcitool/projects/qemu.yml                     | 1 +
 tests/lcitool/refresh                               | 2 ++
 7 files changed, 15 insertions(+), 2 deletions(-)

