Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70835CCD183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6E98-0004qN-6j; Tue, 07 Oct 2025 16:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E95-0004ny-KK
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:51 -0400
Received: from p-east2-cluster4-host3-snip4-1.eps.apple.com ([57.103.78.132]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E91-0007No-5S
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:50 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 06BFC180054D; Tue,  7 Oct 2025 20:18:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=V+zJwX4L/DzvblDStAA8JGYXFzCokmls2vVKdItSBSo=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=NxWQ98E6ovHVVDrjqEjJUnduec/0udsllVbu7m68Mz7EooOaoKVQW29Xj8RzzIQWuqbWD+f0FKlptP3evlsf80hk/96rjsaiXd/CiDAK7nAKbOn32QipvVQB9cmr55quejDdJ1DYHkfeaYtSHnntVr/garKKBclu+sRai407uaotnWbPjuFhEr3OGuwAjCEHZZqc1iyy/jA6BWesXv2cAieiDBMlXyn0qNsOOQskaonXQ6o9vWFcSHEt4I4u9tvJh/RcPGKGrDnQxhZa2HyyiREsOO/O125Ok8//29bOESBAFn2j1BJWS2gm0TxMU0F0vKW/Jm+CLmyGTek6sW2XkQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 92CF118001E0; Tue,  7 Oct 2025 20:18:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 0/4] vmapple: making it work on the latest macOS releaases and
 Apple M4
Date: Tue,  7 Oct 2025 22:18:33 +0200
Message-ID: <20251007201837.28992-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfX4Ujmz5LvGDpf
 m0KcrvKo6fekt12c2o+Fih3BDhUc2WcMfqia5pyfZfRYpSFsAzYQ6HRntcenPEPjS2Nt7yCs88E
 ZG6Z9Rrt2gpxd2ggnFRb+C153plsnHETQ7DlOtY2RxKo0JLMzY+GUSrzMk+ExEWntDTzzwico+M
 CI3etTXhHoQjmU7LIFzkBiZvMKiSu6QpkoctZQ5SuMKVnOm8asDuv70Vwav7PUUhX7ha9S6UGTt
 jxfbUxm9y8ilCr421za3MWluOqfcNCGIFv9J/Jh12SJVURLnZjeQBJM8Rk7z8D1ItXVpSFzJw=
X-Proofpoint-GUID: RA5ay4XNHGQ-UpzO9p_yhspPjKa2XuLJ
X-Proofpoint-ORIG-GUID: RA5ay4XNHGQ-UpzO9p_yhspPjKa2XuLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=509 mlxscore=0 clxscore=1030 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.78.132;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RFC as it's hacky code, especially for the Apple M4 support workaround part.
Support for newer guest OSes isn't part of this series.

Mohamed Mediouni (4):
  hw: vmapple: include missing headers
  hvf: arm64: add workaround for Apple M4 to run older macOS versions
  vmapple: apple-gfx: make it work on the latest macOS release
  Revert "hw/arm: Do not build VMapple machine by default"

 accel/hvf/hvf-accel-ops.c                   |  4 +-
 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 56 +++++++++++-----
 hw/display/apple-gfx.h                      | 13 ++++
 hw/display/apple-gfx.m                      | 42 +++++++++++-
 hw/vmapple/vmapple.c                        |  2 +
 include/system/hvf_int.h                    |  4 ++
 target/arm/hvf/hvf.c                        | 71 +++++++++++++++++++++
 8 files changed, 174 insertions(+), 19 deletions(-)

-- 
2.50.1 (Apple Git-155)


