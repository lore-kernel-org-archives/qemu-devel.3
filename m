Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B3C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mRp-0008Bv-RX; Wed, 16 Sep 2026 06:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRg-00087j-Dl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:54 -0400
Received: from qs-2003a-snip6-2.eps.apple.com ([2a01:b747:3006:204::5]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRd-0005Ey-Hd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:51 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 722521800130; Wed, 16 Sep 2026 10:00:45 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-624b-7e6c-9877-52d2b8f6e054
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpTHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552848; x=1792144848;
 bh=j+R9HBIZk+dEKgvuVv7jehXngRjE0aJg5O20jEArfc0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=uQZkGkpoeJQbOr55Ys7FBVUBSO7UX4+XnFziIQ48xMj6InxKkim1baXa+ZHVPh8fiRcYjYtaKZdg/pV/uLjsqm09zK8Lek0bgjlwOK/AXtyq8LLR8UN00bXfl36rY2wvr4j27QGIN8UAa0J2cVYXke49MrSy81KK7ER0KXaeAuvAmCXcHGNhWA/6k3CyrWc/l3OOkyx3pW6vHu3jP7BbtPtTst1GBgo/XysAoG7Vlnx7mQIC3atCO8FNNx0c8jGEc5vbxlPJ47O8u64OJRFJ86rklRicGkgRcgvBRAauRzjEo+3625NaeS8BcWhz1s5icJEsvM9eEn5yNUAaW1YoMQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 5881A18009ED; Wed, 16 Sep 2026 10:00:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 07/10] Revert "hw/arm: Do not build VMapple machine by
 default"
Date: Wed, 16 Sep 2026 12:00:15 +0200
Message-ID: <20260916100021.73825-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g_E4yBW1GmeZqB2YfL0mFSULV63HdS1U
X-Authority-Info-Out: v=2.4 cv=Uo1u9uwB c=1 sm=1 tr=0 ts=6aaa68ce
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XkhoILwbEVSdr8iLt8MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX64UbtyPcpQCI
 WZmEJizn+y2B1DjCOyuWNsEXwLWV7gMieY6fKNw3Navj3ZBnSE8QQ1AElZ5M9fpEOLM5uW8q8X1
 WrglWwX+bZUzhErLvacX9kYZY9luM3iaVXNHqY8vAMx0CbIgpdB+Kj4kpYAFCoOP12kOavxNIZW
 0TIgYbbAxm3qT9s1gRUAEZgNBYkdEfi83YCkZATjo0aFPif2sL3xum+lDiQh+ITCBN7kATz7LFJ
 o7o/5aWMN4jq+OsUG37yIDD5Mmle0Vl9GdbKBS4gix1K0Bv3tYTELoAM5gKTQ2sHuTuCGPTy9Ns
 fUmrVbF4zbuq2fciLKb4J516OWFWt1larWggHY7e1bRiswSsNekfRD1H6sQ38g=
X-Proofpoint-ORIG-GUID: g_E4yBW1GmeZqB2YfL0mFSULV63HdS1U
X-JNJ: AAAAAAABY6RUChA4uD2C8bH+oe+rXnicz3+ZrTiImUsJNHsQs+DQtCznHmsP1+BRIqoBgeEwLwS2HKGOE62/EOUWNlC0u3jwwSeJLoEjHDBS2c+oV1vOopnnrafuxHxLyxK2EKY1EuJ7H4dH1cFeaDklLd8g0eoCAV9QLaPyHqPw6e/ZOnR6J5UnPISurHhWHy+7wVhvmUmFNdFY2UHCzzAnLVcP2XJBN3KcV7aJg+hdAXh+9AIrMezeqjwg4Apeia+b34D3kW0mHPVlT8deCQVs09J/20oh+msOZlBp/cQ+5eK6bA2o98oNLFDb/tvV2alp/VIyw8NZlwdUHdHJtpB+xxQxKpjMzWTYxCFnHau4toaAerGIlnk5L7Ip5k8eG3Uy2A3L9ANWrS6Kjr1ld37Yuj00OKM0+JxD7/pDToaWRPQ9ueP9kgOwqsBpH1l2zqPc/O9tHFsug5TAOcMPC1TeR1mYze6qocAcnKm5Mgk+Nc9kGyyIzkNrXlQ8WBZJ9iAmvnVDW9eegq3fF1aLjEu4kfq3cVRSEgqMLNPFa4ENDhwshpCgtjl9DaAmJ2bRE5rUpQLEgHKd6tC61m50TVG8RxZpqEcGvdPw1dVDezlxy9PXeSPru/hXD4t19HMLCvfTpTryHG67swPs3aR18JL7V/KTDYariAT5F8AADoBzA0/gJa6MRvTfc/Vt9Yx4vjnP8qV2tUIZKFeAI2EAe0wbwcxwn2bT6+V9FjQlnbCtGWDB3onLaiPcGUMNJgmktYrZcmC6YG7coktZAm5k364VJhXcKhyK2Labg4a+HBFgSg0LQGHWMiltA6HnfTEGayZFEvU7wyIjzKOOJTgXZxB2hZ5ufnDn7V9YRQ==
Received-SPF: pass client-ip=2a01:b747:3006:204::5;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The vmapple virtual machine is now functional on newer macOS host releases.
Revert commit 49551752e860f5e403cdacac11ee1d218141fd3d.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 configs/devices/aarch64-softmmu/default.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index ad8028cfd4..93f4022ad6 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -9,4 +9,3 @@ include ../arm-softmmu/default.mak
 # CONFIG_XLNX_VERSAL=n
 # CONFIG_SBSA_REF=n
 # CONFIG_NPCM8XX=n
-CONFIG_VMAPPLE=n
-- 
2.54.0 (Apple Git-157)


