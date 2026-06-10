Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E4ACD98CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOVc-0002tS-PN; Wed, 10 Jun 2026 15:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVb-0002sq-1U
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVY-00005n-UB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJKHO42440943
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4GeTS0dMvnl
 COcj9gb7V6FN5YUjBd2ROZshzt4CCZVE=; b=eXkiqQiujlpVlqrnCDkks3Knp8k
 aVsv7Xgmn4FGOe35h/u2SzMTs3kH5nzZyeRRNmy45rNfrhY6AaUjILrrp6QEZ7TY
 gIqeUXcVhAGT/Ek0kpnq4VWfThM7XCR3zLQ88ylYp74sK7ZhxGAHn0kNeUnznKeX
 YrjxMWCMMAAraEjC06YpF8PmNVGKGioOhwTjxkhv5FCP7EtfrPZOe+ja/ZaRmftA
 GabDSzOJVJgb+PtpWhS5gjPmuj4EU5ZPJR1qcxGd62xPth6Ots+6Kxm3gh3mTFst
 q2RVJL7QgZAWg+z5oTTdswLpy2Fav8F5LZMGABJ9fQ3UG6kJptEdOksmgLA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kdbpwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3074d4102a9so5524850eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119354; x=1781724154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GeTS0dMvnlCOcj9gb7V6FN5YUjBd2ROZshzt4CCZVE=;
 b=ZSEZ08EXJ9ZWK8oonSnCWeyBfVsVWY+UpP1opPFbBSLF8rbuXpY0S4Pktc64+Btoz5
 IZV1fEDXLEBBSz+ZpcTYVGwHwR9940RonKldFwv1SSIRgH4BHCDE8kqsoeZ3PnkzQrka
 4R+dN9Hfq8RXpNmCJ6Gi5DaVhDEdqZYi6xy1+LGdgrgBoA24zoV2QI5SV7uzICVWKlxm
 hNBFNG47RwxkS/Y1UJULE6XVhqvXG/prj8AzIc0PyvcCohZUhKz68Re16K7KiPPmIpSl
 HaNjs9TbNeXAepU+rMIcZOzC4Wt6TLRlMZ5ZpN4BasRIkmjUpWYwgdrBkdFAi21JoMyk
 314g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119354; x=1781724154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4GeTS0dMvnlCOcj9gb7V6FN5YUjBd2ROZshzt4CCZVE=;
 b=g+Hl9KgBKCBrhWdcoH3P5fs9pDpPsRTDNztznrQ22GDyvHAiuT+PSYrVybejMTzeVE
 q7Ce0grWRhe87zlaU8fCHTddhwa3nI8nGnKRPxUN0pAN5txjce0R6dXy4FusYzoC1FNt
 mlcRkVmEIEgbkhaWHj7pEuPls3+f+4iZvqeU/pbSuVpSXsCEYC7ADtJCA4bLkmTJA8w+
 HedPhSHogQ7ffVyh5+T9JcbzsoAKaXXmRAvixAuugno9Y32k8j0F3EifVVO1tBbinyUc
 rmI0WmuLi5WhmMPiWEqocpOIIbdprDAgcB3WFQc/S0+2UULktkW7t2VEY22I8HS5afW4
 FZ7A==
X-Gm-Message-State: AOJu0YzH6xLPh4RRDrtb4D8EZUUcGMWNd4FhPiN78ZmyQ1XWubt9Ls3H
 AqndyW2zOAHrDW0UNYs82snnPf6jVekRDhGxvrq7a4wob+QN69ZXzUy86aJQk6+WgbkoVhDtfNU
 FBViSH4nokGaYn62sPp+hNFPaI2FnN5AMJmkEv8cOhxQ47vKZu7wkrMkLg4OGRf6ccfIM
X-Gm-Gg: Acq92OHPNxLeDKkjNkMZR1iiwhMMBsqLH5H3xjfCxQdE/lDk7Nq5XAwV3Br1nMp638e
 NUK2xKnS1fn7s5o8b+Ycj70h7OC/CjLEZRhL0m/rKqLUV5kuRxW/Fu5EAo1/Z9BLKS6rf+DZOoR
 fYLvSMPaNaTxQNv77m0vOgEgABmbl09XQxXQCETDPcceje1sR/1CN1MKe74tUUXde6vhqAa88yv
 HZ4QgomZOZz5gWtlKc7JYIiddwshbFz/rJ7/dKz5jixXrOSx2Rd7+EBkFjI8kWolNmbZ1jYB22l
 1oOZO3mX4PaH57y7nontC36RPHKcxne1TAKJKmltKus2LbCtKwW7hpAY1XhpX9CzB46Nz2vEdOH
 vutdF1Xbw8wANyR+0U6P8RXv44omSJ+KkRg5l1YLXGnX0ZjI0FKYv2Zj9yfi32Ied5el0N8ut1M
 q7nl1oq1SteoNX4tXk
X-Received: by 2002:a05:7300:2d08:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-307ff52dbaamr384288eec.3.1781119353771; 
 Wed, 10 Jun 2026 12:22:33 -0700 (PDT)
X-Received: by 2002:a05:7300:2d08:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-307ff52dbaamr384265eec.3.1781119353223; 
 Wed, 10 Jun 2026 12:22:33 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm34128986eec.23.2026.06.10.12.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:22:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 3/5] docs: update mention to ubuntu2204
Date: Wed, 10 Jun 2026 12:22:20 -0700
Message-ID: <20260610192222.2709135-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a29b97b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=vLs1zl3SwQCVldxWroMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: d1Z0BU1WcXNqWKD6zOiAVLbWgRYAfRTh
X-Proofpoint-ORIG-GUID: d1Z0BU1WcXNqWKD6zOiAVLbWgRYAfRTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfX6Inln+eCD7Oa
 WqslreGqTLrMpAxPePBSpyVi4XIZE9+Vz6aNbaXGR/fUYlgdsQQLSaTib8JOUDT+wgR289tyAjE
 O5yvC7+zkndaPPTfit7C7aV5iQlKDNegzfLn1hmUdCqW6blMWZXOWlufRz/hxqE06P78pKE+VsN
 W3/4vjPJmVi1akXz/aN5WNLVW0DcqNFdoBDRslEKfVWrSfoHmRYR+0F/Oa25SojYMzYdlhS5jPA
 LwvxbY3MNJrgaiRmSHxs6wl9bFBEo41Sz2jmShTgWnd3HoLbG0IKE5CtRxfQQOECVwU1ZCYDPT7
 yp4jVMCPI6MDR4lYEdgWwRsNsqsx3UklsnRbMysQyOBk3fUph+zKUWumj8OkA/RhPkxWgrzNcG1
 wyCzPPrcx2dDbD4kfFbbiNhW+oDPtL+TW4uJ03b4FtE2Xz6YIZPzHE6G/PBO+dvvLOA8A7NTX7D
 x/M3lWfuDHkyglcgRjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100183
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/testing/main.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 3408b5836dc..c6821a36d99 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -711,13 +711,13 @@ https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
 
 Thread Sanitizer in Docker
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-TSan is currently supported in the ubuntu2204 docker.
+TSan is currently supported in all our host docker images (for instance, ubuntu2404).
 
 The test-tsan test will build using TSan and then run make check.
 
 .. code::
 
-  make docker-test-tsan@ubuntu2204
+  make docker-test-tsan@ubuntu2404
 
 TSan warnings under docker are placed in files located at build/tsan/.
 
-- 
2.43.0


