Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B91E9273A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaF1j-0001VA-3P; Mon, 29 Dec 2025 10:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1d-0001UA-Pn
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:14 -0500
Received: from p-west1-cluster5-host3-snip4-10.eps.apple.com ([57.103.66.161]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1b-0004cr-Ro
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:13 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPS id
 60FEE1800164; Mon, 29 Dec 2025 15:19:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=EqHRfZnrCznqFeQjrmgx45y9nqB0PoXMKIno3sbxnD0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=WB6NoyQTfePJwNvL/LaPVSJ1tDBF2iHamGpYe1g/pBNj7ZagqNG/iCozsuzGbayejys95f4A1Nx8/aZmvj4dBfFVYuejzegfC7zL8hDk7NHZhR1Up99CGNBYUwDnaMdg+t0qDkf3uqd2Xzi7eQ5AGkn9JCUZlwizCjh0PwBRSAGH/TQGENDUW0jEYGWrFw6D9WxgidZBcXVN0Iqz57FxL5+81PowBKSr6DRBT2/cV/ra35BXq5r567HmGiIhg1SCuCAJVgkibnpFDyFgTxsD1xoktB4YRZu7D2UZWR7/FJ8azsKHmWtIshRFtBi7zRSw+jG7kQJJ3eSePedW0K01kg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPSA id
 678B41800948; Mon, 29 Dec 2025 15:19:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v3 0/4] vmapple: making it work on the latest macOS host releases
Date: Mon, 29 Dec 2025 16:18:46 +0100
Message-ID: <20251229151850.96852-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE0MCBTYWx0ZWRfX8Qf2WiZChv5G
 K5kp2id2Qljc74Of/a7muqPkJ2oF3mp0hUCIdHnmyMDPeN5viDY0HwZKlhTMlcA1Zs+Z+rtpN6K
 2Ya37GN/L0L03byHPJmqUkWv0mkK2GWPvEvSHZFTUFOI6iMG8O4IMMBSb/eFxcgat+YUiEqxHsk
 is9H0uRNlvtGU4pUybdvYjkzN7nl6zch9/RnNmUeO0t7F+ZhjVvNtSQUipQLj4OhHvJFpUwfwo9
 ujL9DkPseEJ/VhwlZZqy2zTuOvpFvqYbcEhx/9Vzn5jEsVl/16COdY0q40QU8Qq5r1WjZJYFzsT
 34CyBF9KEbTtthYjWCz
X-Proofpoint-GUID: _uDmYanV6DjdQ_4eYYpn43y0vVMYz4JH
X-Authority-Info: v=2.4 cv=GMoF0+NK c=1 sm=1 tr=0 ts=69529bec cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=PWwuWOSklEzM4Y2Y:21 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_2RhaUPNESQhlGQwPh0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _uDmYanV6DjdQ_4eYYpn43y0vVMYz4JH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=402 mlxscore=0
 clxscore=1030 phishscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290140
X-JNJ: AAAAAAABxb6ZZZ5Jn5Wiz11+ElCjddtNQGHUxVP3gLqcTsbtztg3XB6YYtRmXRbDPaGDcm92mGBIMbJiz50N1fIuWu+2oFqUpTjFMGDV59rC6kulvbekZOphdBbJLU1Yu6m8BmQVbdxbittqS+6FVJvfWUnXTDTYdtC+M9+y90AJ6QkSMVZEK6B96Og1SV2hiZvMPxjOnsSLmGssC1WtKrN4Eaf/hRSe2e1ErLwY97yJpIeRrSy6exfoOceUs8nsZapu2V2JS6rf8VMBdk4/fePY2qZXmGfgJkJTZJB2kuD6Ec0MEkVJ0swoc7LGJ0hn73ZPI0+1WFvNx1IjcMdZ1RhVM8Ye9KjottAzk+cV9jjlie6ciTQnyAvqWqFMa4B78PMPgWU6HkRI1Wxuus6HV2CiYbqYCxpvzlH92gXagP9DbxSpjRostIeYmuqUhriEAWJwg92NwnN6YtuEY0VM43UAKi5R7WHB4HAUCYnO0a20e6IVDUd7XhzgbWzMhurD5mL4XAXwNnsfEP2KVFq/E67zj8nhhcHfr/Ot3Fx2MYvDRqsHLl7JgjUyuFjtUrZtoZhbIFPFQv0VBZpqGSjiGzGQ7zBnP2PEdYIHa7BDf+/iyRIzK0jPqk+32FRwV0cfxUN9nYID2+cZ/TunW4tymi2/VrMuLtNt3UTQ6KpuBOnI+Bv6I+wcbMsbUjAnPLhQnUcQvJdK
Received-SPF: pass client-ip=57.103.66.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Support for newer guest OSes isn't part of this series.

v2->v3:
Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
Address comments

v1->v2:
Remove some lines that shouldn't have been present...

Mohamed Mediouni (4):
  vmapple: add gicv2m
  vmapple: apple-gfx: make it work on the latest macOS release
  Revert "hw/arm: Do not build VMapple machine by default"
  vmapple: apple-gfx: move legacy memory management APIs away from
    inline

 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 70 ++++++++++++++++-----
 hw/display/apple-gfx.h                      | 13 ++++
 hw/display/apple-gfx.m                      | 47 +++++++++++++-
 hw/vmapple/vmapple.c                        | 23 +++++++
 5 files changed, 137 insertions(+), 17 deletions(-)

-- 
2.50.1 (Apple Git-155)


