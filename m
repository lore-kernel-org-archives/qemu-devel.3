Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEC5C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgv2-0006C9-V0; Fri, 03 Jul 2026 12:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgv0-00062z-VM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguz-0007zi-4z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJY8Y493256
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2GaQV/oxXfUYvhpcWlYYZ/rgvaJkV4F63rsqq0epSeo=; b=gXTlmUA2kzvyaKak
 rY44H4nFN+As1N1e/UZMZsUOofG0wT2AmbuJB44JfB3R15VnByMjv3WcuHnMw2Zz
 E1SnPJa/dfQvCvCylJjUaTlQ1jK2EXrpNVJBrIWKYWiWk8yVvg8pa96uy0BvEa0Y
 1Bn7T5aJRyDaXBM7d0cK0xIs3zLCN+KB1Zmm+I6fqCpGjsjT2e1o5zEgtLRV9ydE
 gHQJtuZfUWJQwgbcwsWUCuOj190PUBKqEPrbnM3fMDLKQekekWjB7I2EnuF4lWj/
 VmmBJtzSpPFTU99ieirjZ59hd8vrdQWrXu+gAkdONFmgKbQrcJTDVUlI+WercEiQ
 dWzICA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkgqmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so8553785a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096747; x=1783701547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2GaQV/oxXfUYvhpcWlYYZ/rgvaJkV4F63rsqq0epSeo=;
 b=gxsVDOcaLPgg3f0dqR1ZkHUiYLFtSJuOQJe+A2+yzksyX9BakQ/Vgcy5vs+9Q8jswl
 k/szEEp18XQTDhlf8suu+/cSWiwcJ47a/VoOODSyxwwplN3gNhEVX/77U4DjwRTmXs3v
 oqbEemVRsCeamB+o36YkXJyRoIVP6sLt1PoZ3dQ5mqGV70kxW1OOqCHl6hDITPXotadm
 eK1ynEMktAb2hJ8e5MVOGSz5DsX+RZqi2Ykr8oYVJO/n9VTtedqbWRwXoam1eGWPlj4N
 2PlYuuVHWFHgPFWrAA+tCD+dy2QU4wQcxioM+XCwTxDFsbz6MlcKB2WdEu+Svls+dQtW
 1iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096747; x=1783701547;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2GaQV/oxXfUYvhpcWlYYZ/rgvaJkV4F63rsqq0epSeo=;
 b=reivHc5XQHdztdoiyN/hVshiRFxGPLGpo0FNZsMe8nxaye626C3CPxWZquj9Q80Xp5
 7POXYyKYxQ9pFr+Pz9clYLPyQ3xcUEQBslukFHhxtNuhF3MyFYfEjHTIID9qUiB4hk/s
 NjoWl77IIg1ZFPisgQFams10JsQZqEc3TTITxvdDSKmjScyFBBneyyUBGJHtjvsaWnhu
 0UW6U83Pobp5an9/rl9QRj63kdsPVY7lqZ8fXXJ/CCUs0iRtInsNraXoB2AoHHZaGnM2
 A0xmhkax+aGSG5lqkMUxq8mdruCvhHpjbrkNhvFpRtH5jJnjboREsPhPOUI3AJiG0L9X
 vcXg==
X-Gm-Message-State: AOJu0YwHK/Ole4azQCELvX+cTwe5XWffkdElGb8x2JXrTWR8WiQrFOJz
 7MQy6xnKgQKh3LcDNmXtN96vcQa68165saPzYObOQWIBqdH4mlJr8mIK2Hss97gFFjSdgzlW93e
 llPZqMeAEJ5d+WAr8Okmbse4ORJiNe+6fJktIOaMHwuRsQT0ZiY+T58h96//KxGtr9A==
X-Gm-Gg: AfdE7cmJyG+o9zPW5pSRDSUtzDZmgDlqfHk8LKVPSoWJyhVX8mTyOa0cCWHT4xUrhiK
 dnk0fhn0kK/hX4LCANNak+aAsV7USYW3dTIggWvwRCBVbiF4ctn/RnqVvkLWvmaO9P7vXpBcnr2
 Ju2iSvFP3BxnX6T/Yf8GCiEODMinqM9c+YBbX3FzltGU57osv9qrpWxJk1Ytihct//1cFrN+uus
 AVw4qexFET1ej9wKe0/TZpTRGZczG1E+B4HnpuYD3zNOksRhXqiLYkKbIceM8nA8J0gys3h3FDn
 W/3mTkogk+0ub1kD+L1tf49iw3WbmWcRJeiDME1awcO/tsNQJoQcs4tFBhzLxIKWANsXusaEVNX
 S+u0kf5ZEKjcdF0UQQVEF3MzlFZ2IsTx2BkN8uEfxgcSQW77tmz5rDBizHVZCSR664jWK
X-Received: by 2002:a05:620a:1999:b0:916:1806:302d with SMTP id
 af79cd13be357-92e9a47bb71mr21743985a.58.1783096747562; 
 Fri, 03 Jul 2026 09:39:07 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:916:1806:302d with SMTP id
 af79cd13be357-92e9a47bb71mr21740885a.58.1783096747181; 
 Fri, 03 Jul 2026 09:39:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce12c40sm101302635e9.13.2026.07.03.09.39.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/33] accel/kvm: Always define
 AccelOpsClass::supports_guest_debug
Date: Fri,  3 Jul 2026 18:37:32 +0200
Message-ID: <20260703163757.55500-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX084cYDAxPkgE
 vkem+NkIKTcNtRU+SuyP3mI9P9aFyOursEwmyzZ7DJPE+NrB19qMn9bNBc+oVHgj/09k7BUadSx
 mpa0DuXY60YcY6OTRDkT0x3j7mE6Aq+9nZ83Vpa3fENIVs3Qkgr3+S6WwmQlj1wJa8cNjNQXzZF
 74wMr/x3A0iRXi9pT2RqMMQhFjS6a942IEwds3aDepDpZwITPFOxvXxZWxD72ywZaNHow7JBEtN
 rGn/DFVVIAtEo3oHZyJW9Q6xjbeLgcvi29rcJAnBFR37WfoM/1W9phlB5UE5RMkyotLCukv9gPP
 lGHJXFgzeq07mDDN39TJiryZzY8tuBIG9dxwjvHVDuM8esj7WOV2fVZ+KeTZ86D4ZWkpCpJnTkZ
 x/kgd8zDR8zE6BUgIsjTT8/AK0W8287RbdDu2/sb8Trtcw9b9QQ+A2wsxZVpz08vxXh16y+NWrX
 RweP5FcWG2/chtQpn7w==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47e5ac cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=j4hjfWolugK9Oy_fDxEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kfWZQqJ2YcOSyeUBdUzzmTHif93pptw8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX3T5ul93+ltWw
 a7TpTeoV3D68FdxBrNtCCMwQWS2wreo7bfK6KLyf3IDrmCwRuFRH7DTUcFVBMMbQNzS8mVp8687
 Sjnl/n4ht9eFCGuGio8ClN6OgBEQVcY=
X-Proofpoint-GUID: kfWZQqJ2YcOSyeUBdUzzmTHif93pptw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Whether TARGET_KVM_HAVE_GUEST_DEBUG is defined or not,
kvm_supports_guest_debug() still exists and can be called.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..d7967bc922f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -105,9 +105,9 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->supports_guest_debug = kvm_supports_guest_debug;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
-    ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
-- 
2.53.0


