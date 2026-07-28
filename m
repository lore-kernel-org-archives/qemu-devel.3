Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF315C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodxK-0002nJ-83; Tue, 28 Jul 2026 05:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wodxI-0002mj-Aa; Tue, 28 Jul 2026 05:18:32 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wodxF-0002zi-Ud; Tue, 28 Jul 2026 05:18:32 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 0913BEC0259;
 Tue, 28 Jul 2026 05:18:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 28 Jul 2026 05:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1785230308; x=
 1785316708; bh=A8MKwU2FpthTAOiIJxZIj/MOvjx12UQUDF2knN41A1s=; b=M
 GrBAlhv4jOKd/qkv3zzKReeAnIWE0RYNPZKXfMfZr0LkJiE89CuSJCtwkFCqJ6dC
 UpNKJlmtjQo97dOPfbP5Ig16xTn7XCdxWcYaD4/nRDrv52/3H0vfw9KSoeKrHurY
 IEMacZ7hwT1IReho31upQFsmRsjsDR3nZccDYneFqem6+ywTbckiaAYKtDqw7jRZ
 d29MZx5kOK36vl3Dt104WjKVHwtVJGbub72EgCfB+VSoRHQzIPALqf7e6hHB9kdV
 fYhwu612ap8uUpu1ojTHIUBZZL2n4ECKx0tcaN7FDbVAF3zFNLnM7yyGOL1b9TLz
 /OTUEcufOAsz4iX75FrwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785230308; x=1785316708; bh=A8MKwU2FpthTAOiIJxZIj/MOvjx1
 2UQUDF2knN41A1s=; b=AM3kblsCMVt9suPJ4+R9zdkxmFZuyH7fKFUun+e1LT79
 FtwtpsWj95f8hOBA1IQrFtCksn8HMQr3W7YuxCC4jslT/TcXYiLB2CWlAvQSc/2t
 LI/ul0bEDjsaaEr5s7K7ej6BejAqLb9iWL1VDeMYEobUlg6iYzd1C1UltgZbzQDv
 DjIIdcxsZWRCdhQT/nBwzNDFKikW68k7KoZA9Q5V2Df62oXQ4+Yo3ToQrKwY09XB
 uVJJ5ARvbHfzV2qA+zIBmAnvlwJb8gBAQECbtJx4uJ/4tWDhISz8j/WuEnwPIPLI
 8BtpzHddF7sTwCL+kSAGhSToieq4bw4lV2bqqSLucg==
X-ME-Sender: <xms:4nNoak24t808rnpgwaSQLqKz2D0Krpove_WOBS-MpwHnqC6BvXzWQg>
 <xme:4nNoalEezSyI7mraM_jU507LKglV0zDoBscmJicj6qJcYSx1dh36a8mSbwnyUiA7n
 OVggPW7o8sGvrAZDuvMSuQQQymZyQWyrhDaz-xY1YzLYVJu3UsK9kiy>
X-ME-Received: <xmr:4nNoansX_yB8HQUfQ7CY_aHsSUKTenKj2bCI_cV6X578zUotwB9ZENQdo0_tc4hhZdWVxX948Hnp4gmCiWPzeTnh>
X-ME-Proxy-Cause: dmFkZTGsdScXanNP17351JVzUtvTnMTbYcuh/Izdpc9QPl/LcfohjMdAIiNc6sLDAiFmVj
 bn/e7NbcpAA+X3WpJBssLLQf59uox3Qaa94nZ7UbM+OE4yQdZJxEObD38Tst6nNPmb52g9
 Hj1G3z/Q2/nHHLsVOBzdSrg8+MVhSQSZsBxT8ClHlHebqm8OYiWcPlpo2pOBO6ddGHb7Wo
 Djet0sgiEJUwIJ2IepAlh4WOSaFqX6SbVd9pSps9rRhna5R7NNsFbmSeDjgBKN0/3EGEYP
 6Rrhry3wglDVDVhFtHRwGpVNVHtqTooJVoxi74aCpsS7s5GURiq/u+7ksYjjQLkTSq2qE3
 j6mLYrzeihKZL4JV1Q5NVr6toY4OTsLR6ypYGvZoAZaGnpj2xfZnS9yetBkrp8Du8AobqH
 SqiRV61QWcVxAlvQyYs4vfRZXAtuxk7uDyVHWHWf+06bhacqmQkFzZEmB6lwHzEDKCut+C
 bwWLaja3MaGC1odwQmVoRzKJTvPjv18Si1/4bERFvFX7ePM/g/sE6oxemg8ZhNpmjoPHkX
 AdbhQQ+fU6WXCm2XoEvQt7scxC+O0aeRfeqkH+640HqFzZNctyMcf+8EHRhKyXP7LGmySt
 +DzAE+g9O0ft6YdjeN2xa65NXaAottDf/S9HZcyzExc4yQc/DiE/TcgxvS1g
X-ME-Proxy: <xmx:4nNoagqSi00ogVSfdJcO0ynjUSSDUTTy9aAqxSYG8ESAh4mhfVYqag>
 <xmx:4nNoamXsVEBg36CAblJzQSORpRWNti104LA8W34fycoG17BlIYvxCg>
 <xmx:4nNoag3rH5aWy6hWvjqVPfoDjf6xoQ5EECoEvSIi6RWszobCzV5YBw>
 <xmx:4nNoajsGD4bGMXR9ga2Q43vm_gkmOg49zLV7v66hSBnvfDY_8u1pQA>
 <xmx:5HNoahwkV-p5qTrY0ap3ODAuEJKSaE1CIvzmBeYkh8QHisZwgK1K7FSr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 05:18:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 28 Jul 2026 11:18:23 +0200
Subject: [PATCH] hw/nvme: fix cross-namespace copy dif buffer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com>
X-B4-Tracking: v=1; b=H4sIAN5zaGoC/x2MQQqDQAwAvyI5N7CN1a79SulhiVFzWSWRUhD/b
 uhxYGYOcDEVh1dzgMlXXdcacL81wEups6COwUCJ+vSkjJP+kG11x+q4WeEd+6F9MGdK3UQQ4WY
 S1n/6/pznBSVEEclkAAAA
X-Change-ID: 20260728-fix-cross-ns-pract-6934cc8205f2
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Jihe Wang <wangjihe.mail@gmail.com>, boy juju <agx1657748706@gmail.com>, 
 contact <contact@xchglabs.com>, david korczynski <david@adalogics.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=ZfnEmLdgXF/4Btjz9pFvKdp/A6R6rv0EjqP8z+66uDQ=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3BvYytBcld0NGppc0dWR1ZRU3dCOVg3cm0rCjF3aEtNL2RvbUUvTGpZY0dK
 V0RzcVlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcWFIUGd
 BQW9KRUUzaHJ6RnRUdzNwL0hrSC9qUjB6c2lyTjh3dEl5Z3M2Qzl4VUJDUHM1SmcrRHlJSVhFWg
 psU3BwVmNibmFTQy9mN1VEUTlqbUVWb2RhSFJIUnUzMHV4V1UveWtBZGhJZHNDdVYxMG81OG1zd
 k00QlFXNFVBCkpRVkh2aDAvSy84Z2tyTlVBK0JMYjNhb1JaVW1LQU9OZHRIdGVwTDdKVG14WE5t
 MTdiRDZ6NGdiUjBlbFA2KzQKa01VWC9HN0RkRUV6a2dBcGZyUVVEbENDbXA2bXhHZFNReFZHUm4
 1NER1U2ovNEFSV0lIT1ZtU2V3ZzBPb29pWQp0WU55V2pEalI2ZEgySW1SZmpWcGxzbmg4UTlwQk
 1mdXJYSE1KdG55RWs3aFZFdDhOK1RxNTE2WUgvZ0ZoN3djCnB1TW4razJBYWQyMm5nS01UQkdJW
 lJwQTFyMk1lZ214QktHZGdUTGFPZkNIY216SjlvNUFlS1BNCj1xWm1DCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

The NVMe specification allows a controller with multiple namespaces to
use different LBA formats per namespace. On implication of this is that
the destination namespace may have a metadata area for PI, but the
source does not. In that case, the controller shall generate the
protection information, but the bounce buffer is errornously allocated
without space for that, causing a buffer overflow.

Fix the allocation.

Cc: qemu-stable@nongnu.org
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3692
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3841
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3853
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4031
Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Reported-by: boy juju <agx1657748706@gmail.com>
Reported-by: contact <contact@xchglabs.com>
Reported-by: david korczynski <david@adalogics.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..409aeb9921c2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3332,7 +3332,8 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
 
     g_free(iocb->bounce);
     iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
-                              sns->lbasz + sns->lbaf.ms);
+                              sns->lbasz + (sns->lbaf.ms == 0 ? dns->lbaf.ms :
+                                            sns->lbaf.ms));
 
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);

---
base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
change-id: 20260728-fix-cross-ns-pract-6934cc8205f2

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


