Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CACCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHhD-0000xG-NQ; Mon, 28 Sep 2026 16:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHgy-0000tk-UD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:11:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHgw-0008EG-L3
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:11:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHwUCS1941017
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wgDM3qEhbp+7QdX1Ng6R8eYj+a0jxFrcVLd
 g64hWt9c=; b=bhWi6ce4RSVt/4HmN0cjHsl+JD84Ee6DxqMFz4lHlR+KOqkJl8U
 vbR1H3RpSx//o90NQK8t+AuYzIlH2cgyFnbdKVZaNVOMOMQBOZE5KN7PeewqxnvX
 sVECfnAVieVKUIW4oVRuR+tvg3WffIL9CrAgON1ukQbOj3iNJWcV5zzUPyicghED
 UGpW8zI6PwTwQm1qiUt7R3L9Syj+B9VziFW1BO47Y0CU+IfTodJGtnIo3o2yTIQ1
 BwhIJ7M6CYfdfQH19QsgimtdDUHfwvE9LS1pKC0Im4P6hi9ITofGxCA8jQb7Cduk
 N/eg166+mkU4BTaWPvMA1yf/+DNxQgrksOA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mu6wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:11:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530d86d40acso80544641cf.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790626272; x=1791231072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wgDM3qEhbp+7QdX1Ng6R8eYj+a0jxFrcVLdg64hWt9c=;
 b=U6Cv83klH0yU1eClnEMjOxJqUKlIIMuFs4E5xQ0KaH7job6VrZE6OoMvPZM1gYdgc0
 VyuqcSAYNJN9MVCP75jbr1lNbxOMWqVtYm8MhaRUPK4jDCgLTtUFI2h9UJEBwRUMCIIy
 JH6vll3F0IQZrUPM5WYHeZw2N8QRsh/MhpehnyLtFpzMqgQixLDiewdpf19i9sI75TpL
 gfBrxd29ud0uSdQJgLO4KEcwBKc8pTHjgJVCCtytvFly89X8Sszyg8Ojck5CcQRCibeZ
 wz6kD0bCfA3J2AUOgXG32pVux67yM1W4Rv8ujUTgeGbDmz9Hq5W7qXU6ZjKc2B+J5VCq
 LImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790626272; x=1791231072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wgDM3qEhbp+7QdX1Ng6R8eYj+a0jxFrcVLdg64hWt9c=;
 b=Imylp6MS+23aXCLJiQO3AIVRWXaLV7b+nrkldyeLPiP4zpNzdcQRuw+J0lRLkhkiR6
 45kWCuHkFIsNq4Ylb89roGIY8CmyNO0EUN5DjvJiAoj4jUjl9f4N72fW3XQYx2PRW3Jd
 8iA6sJsgn31oqw1DSzWtwuXPN8c4FzBl0jMP7bslIVFj7zg/N1vHtwH/tNQDmzuOUfoW
 bEBPgrpAg81qhJ4qs8I2+8/u6+N5f/Of9mku2EU7MXk7xk0mrzJcZw1SlgEx5Pce46RW
 DoKARmx36t7Xg/9fzpcNVk9uT3i0mFc+vRq809cxYI7pvPSi8b3Hb7ezTrv32LGuiEwX
 95Rw==
X-Gm-Message-State: AFuF++nkorK58WcaDjPx4cAHCrFKcsDnRY8nYLXbnt8DNyxhgw/is4pZ
 Q5/FUFzNjO2lVOQ9QOq3dEACXf6VOvzVi49s/J8W3g4LvJy/3cTK9K1Ogyr/nvItwgcf2GWQKEk
 bH7wuKWMvLPCb5LHiVasWSqtv0xcwbyr5RhKi2BSr6iKK2foGXNFMPDHte+4A1bWH3g==
X-Gm-Gg: AYBFou2JtLz4iUCz19aZCUrMoizHkINJt+mc0tgpct/86aMDv3T0UV/t0ds/XuaiBtR
 o1x3NMTAUSabQEe3Z6cqkwcvh0lBT/NM8QAtPKt5ObdX0OnG6TOA1OCeID3Ny6OsRmtQc7xRd63
 kJuFv6Kad2rJAu1I8XTD2JQ8uKZaTsAQ5IY+q0W0dga5uwUu36rMycMbtMtQl5yN67m31kEdt1H
 gVZ1x7RseGE3+VYaoJJkEYd24mhDIJmWmmRLdDjpAqRG7XXSGhLciIJsnKrYTYgZEdvukhlBu1E
 u2iTOs3kra1AAbmG2G/VwsLwbdiv8ar2yLg6OD9tk681eF74LoX1zH7dTYScL5BOlRE7zJwpCTU
 /w/SdRin8adTt6HXXEj0Y73WbsbqU3irA8ug=
X-Received: by 2002:a05:622a:1341:b0:532:a96d:5957 with SMTP id
 d75a77b69052e-5330dd31e0emr232751241cf.51.1790626271963; 
 Mon, 28 Sep 2026 13:11:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1341:b0:532:a96d:5957 with SMTP id
 d75a77b69052e-5330dd31e0emr232750631cf.51.1790626271431; 
 Mon, 28 Sep 2026 13:11:11 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-914399d5002sm79815646d6.48.2026.09.28.13.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 13:11:10 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v13 0/5] hw/riscv: Server Platform Reference Board
Date: Mon, 28 Sep 2026 17:11:01 -0300
Message-ID: <20260928201107.2049458-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UZp5ExYXkh-TfLYGbMb_Tk3FHHffOqTR
X-Proofpoint-GUID: UZp5ExYXkh-TfLYGbMb_Tk3FHHffOqTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX49N5oc9TySPu
 4Qu01OYfOvkEWn6SCctVu/psrAEIJVoCz97bS2kuKl6ovTVaE1nd4quLevXzYtVW9BSlWLjhYYH
 gZMbs6Wu7D+8pU8J14GOyjLsK+wXfjvB6MQ7LWtKDvRVIWiMiVGjSaZEjPvLt8WrAnRumdbuKNR
 WscmF1+cJIT3wM497nj00f9dAGrzcqbXRoXFpF/H4wndDek7Ng3/9WU4sKAJqeh+X2hM04ZfMFN
 e/l1p66/YdUTSlQ1O6tvLOl4lT+ClJzcEPF5suoBg0MY3c1SV3CwLZ9YZyQWS/yjOnCRlTb5hN+
 dDdNJyfKZ/ouKhgy2qRSfTbPvGzjF2OYtBUJExS7Zmh68/s9RFPg0owTvr+HXFcGdvHNWcW6MrO
 Vd8XUZo1hIzn3Tk0HzmYg4S209gdUSZbPAkAV5ZCYLoUs0/USBqyzHrJq4EA0BOFfS7iAyU+ncX
 usm4U8LkCdYCUyOmKZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX+dgfTKBjyn4Y
 F6urIkG3KW7a0iM+kNP7liSCDxbEUWOoziya5UfElvaQib+g96KV9ozpV43mS6NYDY62MTm94tR
 0IZUdasKv0Eu0rKNCxMU/gY4LK4Pmv8=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6abac9e0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5fshCkEan8EIRWPqq3kA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280080
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

In this version we added a small addendun in the riscv-server-ref
command line to show how to instantiate a e1000e card with the board.

No other changes made. Patches based based on top of sdext-v10:

"[PATCH v10 0/7] riscv: add initial sdext support"

Changes from v13:
- patch 5:
  - added 'e1000e' command line example
- v12 link: https://lore.kernel.org/qemu-devel/20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com/



Daniel Henrique Barboza (5):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  target/riscv: add riscv-server-ref CPU
  hw/riscv: server platform reference machine
  tests/functional/riscv64: add riscv-server-ref tests
  docs: add riscv-server-ref.rst

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/riscv-server-ref.rst      |  65 ++
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |  17 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/server_platform_ref.c              | 776 ++++++++++++++++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  35 +-
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_opensbi.py    |   4 +
 tests/functional/riscv64/test_server_ref.py |  90 +++
 11 files changed, 992 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100755 tests/functional/riscv64/test_server_ref.py

-- 
2.43.0


