Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A4DEB5967
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3BG-0005b9-Fj; Wed, 11 Feb 2026 00:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3BE-0005a2-S9
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:28 -0500
Received: from p-west3-cluster1-host5-snip4-4.eps.apple.com ([57.103.73.175]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3BC-0002t4-8Y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:28 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 7D4E41800188; Wed, 11 Feb 2026 05:54:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789265; x=1773381265;
 bh=nVjDYtb7PCOKFdIlhby6GZpS+ZwoSeErtfJVLQksP/Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Qa5Gao/LQC4DFtLNWkp5RMalJVNI9wJ8ovdW7xuPgUJaY+ntxcISu7ifWcKjm2aI7jiPdyB56u+pM8MjXRIoFkUqYt8o+u6Taf4G81NPCQGlKuiavtSut6wF19BD8Bz2li6+tj3VdFPKr1C+XoNnUDEmN3m/WsBPnincrDF5rGlI641C3/l0t3MHK5ygx8UcmP67AqJ8vIIbuor1DdMwqOqQwPzlAMoh1sTCVFafpEVJyDrPOLFIKPmoPqfSxKqXyNh156jwnSnEqX4IXxYS38j6Z0umfsHuq//J9zuFQl5RqSZZad5C4iIretaU/lONvtBPpoRplK2FrkyjYmoKQA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 4C454180019A; Wed, 11 Feb 2026 05:54:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7/7] whpx: x86: remove messages
Date: Wed, 11 Feb 2026 06:53:52 +0100
Message-ID: <20260211055356.44664-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -C2SR0VYGF9YQCsjcpRfi5Y6nrjTN3r5
X-Proofpoint-ORIG-GUID: -C2SR0VYGF9YQCsjcpRfi5Y6nrjTN3r5
X-Authority-Info-Out: v=2.4 cv=Y/31cxeN c=1 sm=1 tr=0 ts=698c1990
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=tHCKdM3VofH7q6B9RbgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfX0IOrF/8Mg+7F
 mflHfme6OTfu2eqqK294nEVXDUd7fOn0PPyj7TmSnZXu/gfX5zIMrx82IEl/6sKp4wmX4m0YR4F
 Op8Iv8hkiOYKzpK0bjPoTNiHuLr1+DJykGjjZMmFfxumpFJ7IvgCPZpbO5vvga05nUuSlpht2Fm
 zqvsUbVOvRkDnQOW+MAtGS4I9VZxt8dMP3pAyeJ1vNdMmKwQUufchiP1Osn9foZRmK1HQQsqZqK
 ZJHDYqUJtZxWH7/lRZzYBrrDCJW8fbo9p3FoE9r6gfBOo4SnCuY9rColOXPtmISSxHPJpLAtYtj
 zO2BIwDkrhkYAHbAsjkO+5PkW9iD/wSzJ1d4W9SEFkVbCTWbJRPWDBjeCy8kY8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1030
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAABBvniDOb4Sfxe1tXxKLzZ9uNGT2FNJqtTdRJ6xr9e5ViXVTOLwawPb5rb/YGu62A3ls/kpWLclmI1Tdw1ZcUhWX6GEN7e7QfksuFwdEFYKzbPPg7AOnIJllNL+7iu6vCC+EUCHu1h/NeyeP5vfE4ecS1p8yy0trxpf2yL1BLxdJBXU8eRghLJGu/DIDyxHdRDc5VMdOBMLZvyCPw16LhAxglWndWT7V4nRBi98w+EecUcEhVXhMWxVfMWKM7++X8AChR7GxXGh2Dp4n7zoVZkiDrbO6VmYiKQXnh8rq3EBT9nl/+MXuuveG4S0H6Zt9ahEWaGguZ1WrqBN0fJzYDuKKLn7UqNSxxUOgadntrQXfw3nr9gxfAn6UCf6vSFCg0glyEyMjLAR/k0FeNiUmmB+xF5N5fN8D/ebzX4fYxJC/9xOl0C+r4CoE5E6xecnsxi3RJgg7zMi63lbBnd9FSS+0qdTeYp0SGs73eeWlj7gkdDJ5JIXoNliuEu0c7hJySaUxp6TyFXLANC8jHjHZfynSLGc46Q0RMutwpq/FMuQegMpzuEfceQUcO5AhlFhSopwcGYbQGShVI81WkLaNU//Xqs8kvqOFhHODA2WIE9mro9YgdVqIhFBPnghBFHGCNYLq74nUv7XVtz40QysNyhH79O4UAhTZa8sxmpwnBSTxDEe2QR+IkqMqiTuEBOMYLBqcM+iKUpX0yTMTMNWMxt21mBXkgt61n7MNf1DBp8YiGIWRjtX1ws4diASRZN0TRQYjNzPs2ZQkdxG4+h/4pltwXnb7o=
Received-SPF: pass client-ip=57.103.73.175;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove some messages printed by the WHPX backend that don't
have an equivalent elsewhere and don't convey an error.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 68ac9dd6ff..9877359274 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2244,7 +2244,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeXApic;
-        printf("WHPX: setting APIC emulation mode in the hypervisor\n");
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
@@ -2318,7 +2317,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
-    printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
 error:
-- 
2.50.1 (Apple Git-155)


