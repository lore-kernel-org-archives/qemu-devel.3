Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfd-0007x6-FD; Mon, 06 Jul 2026 09:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfK-0007DL-8J
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfH-0006Xk-7u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666B03Ov389752
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MbjzyS2vyKB7M5fl/op/EmZHIEWbw2ST+XTV9X+k+G4=; b=I9YUk+MepRExRo4l
 /XggrhaC5hBrVLbBAne4RyFmf4ruS+9jC9BS0X4nx6vWydbYfC+cOvK+EeXvrjOT
 lwEj+yGPfzXurqtuCTFFQHrFJJUi1GyqBCQRS1gjANnmb2T1cvk6taS55VRhJUKR
 pVQEBfjPxwwWb8tf/lMvcB0N7jOlaf/KmCbeiFVBG2ic7daWidmTx1S70hiAaBFa
 R5GfK+7+ajGy63ZJuwm7NV5THm4oSViGddHOSxQRTE5ellyyct4qBZ2sxBjDhD3V
 z4LYPMn36ECyJccYUkeO3VnQrndiX17ZV62TqwnwLRTbfVidLhXYk27EIBdlf92O
 QDKHgA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0w2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:47:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5939so303596085a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345634; x=1783950434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MbjzyS2vyKB7M5fl/op/EmZHIEWbw2ST+XTV9X+k+G4=;
 b=iZpV3tnw/g9co+MAmbSBLF/WTVMd9w75yovmJeFSFNcUA0+gvl1om1ULhDrjgAvzzE
 ssCF8EgJv5YkOFyioug6CDFNWuZ8Bj2tK3KV2BqwSkBNfXHogKi0rPn0NJD2qwz4TCAC
 5AH3SmuuqJAn6BypE3RMtDVvx7PNU6aT0HOFzwsit9QYRx53q6kZs6/B9V85XaQxIu9Z
 dDZ4I/6Pw9f3HQZY0uXi/pP5hox0k3iT/sVJqCjTbv7OSvfboTMjXglhQN/Xg34qmfvu
 axk36uTGBL9A8fDjX68BGMY1ah862bmfoAKwF0e+Q4a2MulwRTD1K1fiwP4IvPTJG8bc
 98mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345634; x=1783950434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MbjzyS2vyKB7M5fl/op/EmZHIEWbw2ST+XTV9X+k+G4=;
 b=fipWnBPgtVWteJN7boDmpnN4DwY9ZQzqC1QcZ0/6ajDoedXuRD6SW69QvuIw8gnFOA
 6fZvIq24zPkrqXOWex1NRqDFXOIq9YG8Ap+wFloBbztrH0OCPpeq3FVmdmoUY+Qkl3u0
 WkdL1VeAI1bcxtVEh3yrjr9l5jnTPdPBCqGYyCK5onawWyhKoSkLS7Q3R5kVNxVS+fbO
 77TgKNx1if7OdReBehhDcs/vBMraYo5Z4C06PMriic7+DmN0LTGmh/2f7jn/wFlnDhXu
 Q+8ifPwui0K92Up3neq5LW2vIqFdLzK8/jpefiLZNSdNZBJ7iH43WotnQVlbXY6JcTtN
 DbXw==
X-Gm-Message-State: AOJu0Yy2QbpbiEiRxdbjt/kYwULvUcT1aG4BbkSxkKaw76sUz0jr5CuY
 qhDqECvJCnVeLB4YygAzfFFCOPdDp57PvBT5G0ZL/g/X13hiYEWLzNQIKD/M5+XjUhQje+MJn3d
 KsYAk3u+7KQBw0l5cKfpEhsizAODICyo5ejeqmSc8hwvikMV1fAbI47RizstkYn1ToA==
X-Gm-Gg: AfdE7ckpuuqU6M72ZVYVIxm190EebrvXwp5TxSGjKeBDTokY1y1xO+Fp0rbinFDF7BV
 /xsTOp1KYh32tLYdipvi2eRMrH5n03RhQ6mtbv5Yeyn9R34Lk7B9mdl43yK+e8yR4OvWEJ0YMCE
 G2c8+tCpWkbj49Io9z+Pxx9UHHD+UeZ6wugPEywz8ss7NBuS8jp2AeOAWEoLLSLOV/x40bQNMRZ
 gW0z84GxwU26RJSQNRVOTrvkztEQSE9PZLgAh9FZ2nbIYa8yizXR8dDZACmBjH3TKWQ02VOGjcG
 kaSWgc5NkNDxW4xW0lagdnAvLZJATL6jS4HM9U9fLols3lvTN0nLscPRGeb6TOvK/Fd4Zz5GNIp
 Mgt/byvfPcGw3Y87fMnOzCw7V+weKfNA0kX1+ZjxEAGWKTcWaURu6KuRNsQ==
X-Received: by 2002:a05:620a:4103:b0:92b:5408:b6be with SMTP id
 af79cd13be357-92ebb4fa30cmr81581285a.23.1783345633740; 
 Mon, 06 Jul 2026 06:47:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4103:b0:92b:5408:b6be with SMTP id
 af79cd13be357-92ebb4fa30cmr81575885a.23.1783345633049; 
 Mon, 06 Jul 2026 06:47:13 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm25670118f8f.21.2026.07.06.06.47.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] accel/kvm: Simplify kvm_init() w.r.t.
 TARGET_KVM_HAVE_GUEST_DEBUG
Date: Mon,  6 Jul 2026 15:45:06 +0200
Message-ID: <20260706134527.84808-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX4oSWKvM984mx
 wyPyNiMiefpKcwYhqxgXF11mDIvIX35EL2wkMQyqoZ1q0u8QXZlEcP+aSsjJjZ9MYTwgHbkvLgp
 x/5KA03cZKbfGiYQp4++Td6gVfw4/veAF29Y6ePYG5vXfA1R4QtCDQYoN6G6MRo9tlDoHLOAe6v
 8qdlywZ+f1IP6hMkbPJGpROP+VHuyXkfQjJ1ErrStGxJcCfUeOwYEtr/d0o7NKQmnKDMsWe8kg7
 R0uO02vZmbiLx4vEIIzNK7gLPmNTZvrC1Ii7sLdWL3X/zKwqaK/Xh07/Iugeecw3qQkK9iF1+h8
 nzb9jUSgoBjCjTNJ/TqyF6JO4/mLFCSvGrdQtVs5/gG1S2gP2ey2PKuQuE+GJhixEJUNfjyzvMK
 nj1whVhJwHLniBM9Z2riX65PHjJ/WUmOkh9Nx49QCeZZRICvYeMGgnkDkmVc0Oo/wPzYGUD1tzZ
 iOZDb4Ppg7JIeB1Qoqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX2Oao2YXJGBxt
 26W7THoNFD3c1XIy4kEH05M2VtFLGIvuYsMgwrShnEsJ+DnmOyuwXgVRWcVcEd/GmPyfCVjT/Lj
 7O874BldOduH6LF0bhtEtQQUQepH6hE=
X-Proofpoint-GUID: 9CwNiTUx3wfP-xJzBPIHgK2X5HSAWRTn
X-Proofpoint-ORIG-GUID: 9CwNiTUx3wfP-xJzBPIHgK2X5HSAWRTn
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bb1e2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
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

Simplify #ifdef'ry using TARGET_KVM_HAVE_GUEST_DEBUG in kvm_init().
No need to zero-initialize kvm_sstep_flags again.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-11-philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-all.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d55cb45cf7..304467704ee 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3040,21 +3040,18 @@ static int kvm_init(AccelState *as, MachineState *ms)
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-#endif
 
-    kvm_sstep_flags = 0;
     if (kvm_has_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
-#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
             kvm_sstep_flags |= SSTEP_NOIRQ;
         }
-#endif
     }
+#endif
 
     kvm_state = s;
 
-- 
2.53.0


