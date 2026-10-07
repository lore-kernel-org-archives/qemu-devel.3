Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7E4CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWez-0003uH-SZ; Wed, 07 Oct 2026 14:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWex-0003tw-Gt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWew-0002fL-0Z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IB0w5870062
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pn0l0BOB/GkoXvEZbHSCThcfr1hfzuLmFCBinF8pV8E=; b=Qhq4etAHtDo5DA7E
 RXFKHVFuoOZxDlU1huxRtQP99Lsn4yJCLSYw5tLuYOAqe3K4m+N1Qj7wvEu0mwPV
 JqSI0RfmolMhrxmWZ2PX7YapMC/XLtiRhgNb8mjxAzi9Rg8GqTEEwJyy6HKgRlF+
 I3/TD5PhMhb2EBeeR8+DJDBUeALGq+TecQd95spPlzsWwvhEE7XVwyG5jml2+8KA
 YqTHgiy/H7BcA2dalcuLjTdrZIwXssYsaw3qbfKMz4Mkt4kM8NH7VyK7kzKeXtQo
 K2iF19i+sEpKY9avgzLqu0an2jYkG+xx9tQCNWOCDQQ/6Q1zVWGV/dOHeuIEuuNn
 Bacv9g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5td40cjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:46:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34ef0362d95so8139059eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398792; x=1792003592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pn0l0BOB/GkoXvEZbHSCThcfr1hfzuLmFCBinF8pV8E=;
 b=ZP8VCenOXaOuWAS/KzqM0gfbimayfBxf3sS6q9WdGTAcAgZ0lz/bEr61tNFCzqjhTY
 9LsBkvJ3764R8k6VoNTrv1Ro1YytEjUYdUcH2nTh1uuKacHx4XzKmvCfErK0KmrnOYrZ
 JOIko89kHtvIFejW9FGtTGcyKBNjw3skJ1WtIZ3MrlqFMh3tXxxzS5rWUwi/TVpOuT7k
 ipVzV807EZbBB4XHqM2z1wLGD5neTlDqVmwyGi9oBjbf5sylN9vzl6+L6wtm8/XmClNd
 vOpfdli/EoJI5VKZ5qqzehiqPpViumFJe76i6QCRVUBA6zLe/1LfD4R6a7XFFQVuCKyx
 4SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398792; x=1792003592;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pn0l0BOB/GkoXvEZbHSCThcfr1hfzuLmFCBinF8pV8E=;
 b=FsQ6ondnGJNEgqq8dslVX/oxHFqJejQh06nJm2Dykcs2elChncxdgS/5TAy57WP8oq
 ++7pRYtuyEUTv3siqLu+9P24raz0oEWzq0u1o4twjdRz70M2y7WiMQPNdyG8I9uZ4qcz
 eqK29ixYBk23ShoDX2O7uctImf+Esxm76kxicIwvVmWA2hn6D+O9fJX53EKztcTbwjyU
 jh3PVKdlsg9nQTtZr0hWGGUsIy0jhxHM+GhB/5LkFakdkpe4OLeUBhTSH9bhRWq+h9AJ
 7hlTwdQWz4uqVZPEHVPPXlwYI59NL2y2zxQ0FwYC11E7rsK6uHuRB/fd70I4DVbzC01g
 PNZA==
X-Gm-Message-State: AFq9FYI4nDY/uskf0SdWjzZLW6l7pQLg7vJhEq1BAbI8mVamnhQO4p6K
 bRudLbVApgm9KnbDqR6wcecI3HLLpTQCQcJOEuUfQT5lg+frN5U+KCbBgqsi33mt3vFRxgeMxjD
 u8IeYfgUTi2bBZNYwzFwBvpfRWrsG/Se5eV9kVPXcO36mYzIwmPA7V35LJHYWk1cAdw==
X-Gm-Gg: AYBFou3E8MWowNfVCxYMwjMK4Ui8BxyAaYRFWGQ9aL/kuf6mMdFcOsvIGHO+tUKW4NB
 xXKDw8vMLUTnhFO1lEH/QkhL34SBp1jiCrz2KJgLqco1FF8o/MxAf83qL3TDKbG4ZSqkORbWSEL
 OrAm094bIMjVok1CJeiY6dEt5HxW4HMMwBkR6LgnLxQPi4fXxzw6/d1mEuDO0rFzr0faKqvAUSc
 JfTnv91RoK1JAsMhZbByDir5KQmoQBWznFShtmrK0+x6pgdT6uPHEOVMAj/A9QJsRy5jmq1SfcJ
 glfh9mMTOPCKKsJK1aMbFHX6e+E5ns8c1F51w5GfJpfGACHYMPeF2VuCS3DvD4D6RyaGNno5TAI
 ShgoxPO+elrK7yIK037FT4aCnF0H/sZ8VOTaI6/goAZ0qaYKuozfeZed0VNNn
X-Received: by 2002:a05:7300:ac94:b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-3515da28748mr3824719eec.1.1791398791744; 
 Wed, 07 Oct 2026 11:46:31 -0700 (PDT)
X-Received: by 2002:a05:7300:ac94:b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-3515da28748mr3824584eec.1.1791398789607; 
 Wed, 07 Oct 2026 11:46:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af3ad13sm8295910eec.14.2026.10.07.11.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:46:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 2/3] target-info: use TARGET_ARCH_VARIANT
Date: Wed,  7 Oct 2026 18:46:11 +0000
Message-ID: <20261007184612.24073-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1w2TDXuMmQlLOMno8NlQOtrAmEctKNYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfXwJqXrdd/O5w1
 r5r1dkX4f3cHo0v4ukDg4oDYpMgtQEx/zS2jaCxS3ai2JXPIZnIbtQrzuCsWKxYrxhOMEIAaRzu
 COM0p5DHudDg6I+8Y3NuRFzx3RYz9pixVnFk7qgmBVQ2nwKsrSgMKQ/x4PhtF3MJ71bvNl1AhQR
 64bAcn1Rz5egDoLjyK4kQu873aoDGIGS6DBWfew+Qtor6jGi4zYtHdtoUCGkfOESvTyH33Y83WZ
 DaRS0juPhxgtdWsqUKj7cVjuL3NWKSBH51SUd6d/uTUaaYp2Hby3grKCgYKYi/ZkcRvzX3tto4r
 dxGJLtJe2V6SbmWVYFu/3EXUygTedR+IlEa4VYt6qYISuobUfMOZgkhNyyJsurXsJnwR2gXXOnI
 cqfg3eOf4DT18qMQX5Tf+UIInZZvjnjB0MAr3UO/oSZ7N2TZbuEGqAhmSCGq1s8gLsbiG3urZBc
 i5k03VDSMCLvMlsKkgw==
X-Proofpoint-GUID: 1w2TDXuMmQlLOMno8NlQOtrAmEctKNYF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX8ZbBJUW2O4aK
 Y25gALto5G43DQdS7HbxZOeVbjSvQCM2uEmp3PcOsVrjdGdZvDr9MkTwVDwd1Mty4acgbhWVOQk
 o9GouQ32yvtqgiPl5MilrqDgnYL+Ttc=
X-Authority-Analysis: v=2.4 cv=NY1zRGD4 c=1 sm=1 tr=0 ts=6ac69389 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=gua6CS0tsYA4MX_G184A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

target_arch() will now return the full variant, per SYS_EMU_TARGET enum.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Yonggang Luo <luoyonggang@gmail.com>
Fixes: e934c624f3 ("target-info: Statically initialize target_arch")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4640
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target-info-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index d121b8c0170..b0079d44dcf 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -26,7 +26,7 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH_VARIANT),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
-- 
2.43.0


