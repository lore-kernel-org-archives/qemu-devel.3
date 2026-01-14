Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6320BD37E44
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2iB-0000bt-Iu; Wed, 14 Jan 2026 10:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2he-0000G0-Mo
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:39 -0500
Received: from p-east2-cluster4-host7-snip4-10.eps.apple.com ([57.103.78.241]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg2hd-00008E-B5
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:22:34 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 5F4491800101; Wed, 14 Jan 2026 15:22:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=uL7SH/8eLEnNDGttJV810T7r+i9fS8o6dskAKag2GG4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MgkvP/pOPSOLfX86ZahFLOusr2FglU1G8offiCTpQlAR3LXOdn2Yg4FXxj+90/LJeJ+7uMgcAfYjlUD8QyW1J9oIYrpxcsB37cyVwbuMSEo+9jSd2oHClhhhDXNBO6avUEu1Z/y85PjL1Q48fysKTNyLGKyLvJwLItVfcuEvRk+jIUW17hm1hjg6hFSoZVv86vfIGI058HoDWgL+OIbHZiq3AuaiWwRFed9uhbP1lzPy6yjjt48lh1U57ymUTOjRnPyUyDPHqWZeaS+vIA8V8JVFLUq1A6JYvJK2Kw8drUANgrOeZXUb/mDIVu7LQovey/j0WBFd9WyNGAeTcy9kbg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 0E788180042C; Wed, 14 Jan 2026 15:22:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 2/3] Revert "hw/arm: Do not build VMapple machine by
 default"
Date: Wed, 14 Jan 2026 16:22:19 +0100
Message-ID: <20260114152220.89640-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114152220.89640-1-mohamed@unpredictable.fr>
References: <20260114152220.89640-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOCBTYWx0ZWRfX1HHXYUdsYHPk
 jWcazRd+SEgcR3H38FypHLLNk5iqKUximgUeRw4NfpvAzM6mVb5mqt/23J82Ck+lTcjAYhqvPYT
 2rarDlbFR/sOPm9jeZKSQQGbcU5NSZcrFHJKsrsru62UI72Fg22zAXysD4QB/ofPUk3V8TN0LRa
 mXAtAF0JNHnZlCGS0/F0NtWbigKegqablYVYM2u3KeXF437E8qYPWZUI2lDllWxIfClp1U7hS5o
 SEZmTxeZoUepXHljGElP+svOKQGXFygphStjDLoUXeajhizq8eNUwmRMTIjYlaJv7FzeFMQyor3
 znywwomJLIxZICspKYA
X-Proofpoint-ORIG-GUID: FjYN-xGYt_0ip6Mpov7WTe8AnyjNGCwt
X-Authority-Info: v=2.4 cv=EYTFgfmC c=1 sm=1 tr=0 ts=6967b4b6
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XkhoILwbEVSdr8iLt8MA:9
X-Proofpoint-GUID: FjYN-xGYt_0ip6Mpov7WTe8AnyjNGCwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=819
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 clxscore=1030
 phishscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601140128
X-JNJ: AAAAAAABA3XwEAJpGUMXNYnjqTp+vGG+8Izv0XB6C6i5PNsS5EvMca71LhOWja3Rk5gnn7vwOYB+e/0q4DE/dpzDsGYgUi7jJVq2feCGRRQC9WoQMbqzofj2Fi7tEy06WuxEoE+TYQm4BM5TgCxB6rXMz8gTIkBxharSfNRmoQmdy+38i0voYEg7wAAoNu4Bn7uLtjAvmpzi2rmHfhFzd1E92pyOS+msDVA0tz+0i/x1EJLoCog8b3xPjU5+8765Ii0fiNHW0zZhoF7/fYEXyBsZGn6auS+LIytkpfERShBerisuDQjFMCnSOd5ofI+X+cgHKeG8Q6EeJuJ5oaF9LI4E4lopB2SesN2Xg/XIgNm/LbvsfUCMLZgdf/TNKyqEcchREv77XqIGhIKdzOIgBqfz68dYTTyg+jUTTQy2iiJcvcIoDCEY4V2ZwNJEg0GmnmnvaQv3yATce0L2nV9LOG/HF42/v6wq3uojdkrYJfINpmhRghmnsArh+D9f7osCEG7GAkvZpIixOEREO4da6iIa0lMzXO/cTSJL1yuv7lp1G9mG3OdJtmYL/hMEksP+WCb4ihq7U8oOxD1+KO4E+jijpHeGIpIhgW64bIU8ufeAv/OIiU8j7YWskFrtT5EMZz8ointjKKhRuP6thEvHYXHvLVfakQf/0gsOemZ2rj0ersrBjYfbqQj4nI+DQuaZSu5G2w8M9jTWHbdablsrd52C
Received-SPF: pass client-ip=57.103.78.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
2.50.1 (Apple Git-155)


