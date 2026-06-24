Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEB6CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB8l-0007JY-Hn; Tue, 23 Jun 2026 20:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8i-0007ID-32
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8g-00039U-GR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwrNk613918
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t4FW760/dwatMRdPf5Z+Kiei6+Rz9q8sXcA9tVx5ZWo=; b=QxoqfrydSjOkzUia
 f4h/hxFIPhDNfxju6Kk+QEhKGoRfAyfNwyPvjaFR3oNkDoohx5wBumDu7/mCKtwk
 8HgdkuwhooC1r3NN+no3Hu5dWU3clI3f36DWlBt4mP7Iq/9WaWrHYuzkMVetGkvr
 XPXgl6Kh4an631Z/crL+nxrMnxzKxnL8Zw3Pf9xc2EogyTa88WnoBxuwIaKneIf+
 oZxEeaC8Ys/nK+xaOy0u14JQm+A5Rc7KcvUHCH67/6YP1WH8M7aSY0cmWnp9mFXL
 pk6v3uzucFSI0Fw/rao3ZMsAwcB68ydQgfT8NuBuBDoTHMdMdl/2u7d4ZByvcjaV
 Te6DQw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppykjcf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517afbeda8eso7449691cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259603; x=1782864403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4FW760/dwatMRdPf5Z+Kiei6+Rz9q8sXcA9tVx5ZWo=;
 b=WBBlffXfYOg2YBvnIZDCP9rPfCF4Y23eo8Zu2cTH/oDF9wnQ+p+GsWfTHUlk311JQP
 i13+uavO8qGGKMTuBp5vcWzC7+TLM2wDzWiaJ/J3e69oDSBug8E+UWm/bsJwcZBkAM+/
 zu8J9tq8/K4/r/539J0TqOPMDxg5Yori4o1miMyx5txvjWJEzyJa+nzGK0qzE/fBQsRN
 CUuwT+c12QzShXbm4P8dZUYWwq20roFrv44l05dht6QCxw7JdGexSXDW0WJPEZcpX9vg
 EGk2W6N4tMpSciMHcL6hB43H3YAg0oU4xDQdHjl7F6c6NEsYjiXtNNJ4v/k7+6ebDUPT
 fFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259603; x=1782864403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t4FW760/dwatMRdPf5Z+Kiei6+Rz9q8sXcA9tVx5ZWo=;
 b=DjyZXxhRFgzgZK3g40MIz3Uz8TwCYRTPbGN2jLlndiXA7XxYE4j/kpVbzyJ9fNq7Ft
 zE1JUwi2nRrGJAiKIGxLnKlJXHGWHgQkkklS6b6SxcbxEknqCqn6IzNpbakFni7yWZsR
 C+yzmC5iQkzJPYrdgHHtfLSX1ezI/2YF7+A7uhXyiqRcLFSFMIs6yuwl1vMBQt5jR4Nc
 tsdwkpCZP2LBJE78CiPirOIXgSxVgSUu8Gk9v1eV/FgURFaUwGKmzTp1zJkz1c7RFb3H
 tFEibtAC2gf71aStgMn/BMudStSy81GWh7gCa00fVu5C9a4jEtkrVVA2fUloppFngn6L
 9cEA==
X-Gm-Message-State: AOJu0Ywe+XuwvfFKYGCRDACI6++7OViYoat7GuBXF5g//1hKIMnogqzV
 PLhujeAMWp2JUQ0pab21OihfAegpSxqUehcUbn5vpQyvQaBi9kOSrgHM8v4j81KBOxJS5kDzh5J
 Tt9sjkyfUXms5J5IcMgr2Ux8tFJqSOgWPOVwL/WlfhehvmB6JvT0WJ5hW4RUfLQoO+g==
X-Gm-Gg: AfdE7cmaJUsTlDgIPNx9ar3XAdKh79JetGWYLcTsO2F0VNCvTufNZk41Hqxs0duBcCQ
 4wXSLglVP/Itaij2sopcjLlWccrOmCpLF8CBhExo/t/L/sOxeEMToUz8IWDIxU2SbyfdpqpW2P/
 p5DjdGS2luY2CsSnZ0XKid8RUtQrRRhp0Ls2RV2CshFUOkDrLM23Swp1DQseJarLiJvFDCDE5Jm
 TYUg79HWm6ur9Dg008VXKYU+nbNZGbjRRvC3PJci5umvVnEDl+dhXKn4LuqZzL5QX/iYj8pno/3
 xUyicSfq0ezEVt6B9vm/vcW2d2AU5RAinwbi6DJDXEe6Q4rH7TJ5tL3Oa8MQvW7iMOmKQma2KtR
 AGP59m6XuvGE6gpwigYVFCfLkGw14k+iWZHk5Rizv+Z9REA==
X-Received: by 2002:ac8:6907:0:b0:517:c65b:f416 with SMTP id
 d75a77b69052e-51a61cb160amr19911851cf.54.1782259602696; 
 Tue, 23 Jun 2026 17:06:42 -0700 (PDT)
X-Received: by 2002:ac8:6907:0:b0:517:c65b:f416 with SMTP id
 d75a77b69052e-51a61cb160amr19911181cf.54.1782259602131; 
 Tue, 23 Jun 2026 17:06:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 01/24] target/riscv: Remove unused tcg/tcg.h include
Date: Tue, 23 Jun 2026 21:06:08 -0300
Message-ID: <20260624000632.2149359-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX9Fkxg6UhskYK
 si0pbCj5gD8znOsYT9php6fH9l2sNd2Me/6fW0DVHy/NgIDPDlOp7leSFBDxdaRhP1X3RcxHf0u
 1+W3Vq8dkWhZQsQnRu208qJLNwlB888OXbK21/wlO+AIM1MPBoOyI5eJ20Xz4+Q37ESRRS2il4+
 S623bb8CoFpxhzzJYVgdWLLFcFY+Yl6ytpH9sfov3nYLZ0fHMHevhiyG7Z3swKuJbJ1rmsLaIAa
 zsy5xyKXQoxo6+nhoMnZfXJ4OCVArdb/4gYFSPGX3ANZ4002KRldu0Dx9IZXyfVs4XcEPcdUmzq
 8cFW9OPkilBN04E+0y96om8uxhOmfVdNXiV0lS1TVUWnv9hwNuUYgze94X3QsxYqL0EoXeXT0R+
 x2Q3SyWNmZmv5KiOtQ49MBq868j+oA==
X-Proofpoint-GUID: V7NIL8dbYL05Bz1QHlfP8mFIPAgCMz7f
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3b1f93 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=beEPI9FAKrdLFu6WGxcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX3+tL0GwMF8UC
 uKFfmAWxuTlK0Oe65A7btr0cu2q47IQgOZAY03tYsVP5yJKLMtX6+ZcKelaBuSCt3sR8//xp8sK
 CGylYae0EJnnnmMK2hDHhcFY2oaBeLo=
X-Proofpoint-ORIG-GUID: V7NIL8dbYL05Bz1QHlfP8mFIPAgCMz7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bff3ed5de1..4e96bbeb60 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,7 +38,6 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
-#include "tcg/tcg.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/debug.h"
 #endif
-- 
2.43.0


