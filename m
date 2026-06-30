Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7118C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegYf-0004Y7-VU; Tue, 30 Jun 2026 18:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYF-0003sw-6W
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYD-0004BH-LI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDalv2959923
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RuLkuN6qYZZFkB58VCvqz7mMm2jVG9P1AWo3rZc52xk=; b=WVHklZzBF9PJHOQT
 Bbx7SdY27TxMGNKMoBGNCPn8rbygryqluHyfh4qIELhziibB1lxVfZ7OMmEdD79i
 UbjkWG7ME8x+rOLbCdfzH7+ylN5Wsa+vGjotmyWLPs2dFCfmz2Iyug8+uSOdVefq
 CaxXBAtnFgnPtgutaNWW24gQ/eSlynLIeL0PZ24OcwrtSljImItObKab23swLgaL
 7DBDfhVTL9ONREt8nz5YMfNrvfgsHYdbQ6QCQsJwd/1vIMWJUNEOC5/hlaNvJ/lt
 EhOaJTFEE7OJHOjDUmi+EbN3FjdGMGfztkbck3yQqTPJIqzkP+rurHi4ZHxJEVFR
 3gbTfA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9113t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7377e2f1a62so836564137.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857007; x=1783461807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuLkuN6qYZZFkB58VCvqz7mMm2jVG9P1AWo3rZc52xk=;
 b=SuPv0VbLVNyi2Z/FCyKOpyfFr/Iz8Sm144pHXRRZA+RaK/1AVSoVNDoR0RE6jJ/QIh
 PWpIViQxn6UiDG1Ffi3nWngwStTYsJpHDfsj88UqV2kax+XrvyLvA+qjgPSGT8E4TypL
 fpkVE/wTVewOgjixqaqmuOpJHqkKm56FPaeH4H/XpfJ1aBXFCtbElbcbB5AGzxHpwTvA
 jH3MqPsDcaCLSv2O/rKz+XxW6SWilURg15Xv5EbEPj9SUJR6RRama33iCve6eKXyD05r
 /yE4bSfuRs7SWaAzKhWbhMD/usRnju6ouE7Izts9j+UZ2LGz2ENFOYelg5uvHPW8fMft
 iK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857007; x=1783461807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuLkuN6qYZZFkB58VCvqz7mMm2jVG9P1AWo3rZc52xk=;
 b=R+VB9uifLw8Cd8RCTPPKqUMXSo0FFZvCfG9hZ0AgXf5uwq5QeBStFe/otpoIADjm82
 PdlvPXPEhdl8e2l7o/JwxsQbqdSgij5Iv0TX9gHKrdGeJAinWhuLuN9plz/CD/uOwUly
 KCHOGGvggdKtKC9hmyB4lqvI9hGrnsRRGq+ai8te6YiQ31cBn5y9rJDtfYmEBHxLF2Jw
 oYDhkbRvsmf27/zM6uzk1spaxpmLbqUv9ymvLauJ7YU2sGMYEZzkQ88x91W2aE5yO5gb
 +kw/X3o7PyPsF44DzjBAkhKujpSN7U79MJ9Gsy/ppvGPIPGSNhMW+6T7rTl/RGZDniuR
 DMYQ==
X-Gm-Message-State: AOJu0YwblPK7MvQ48A+j8knErsVOx01WPLH4tZQ+EPBf2bzira7o8b8n
 l5j6HjV7Q1gIF1HVRRSYGSeBcY52cFGi3BKoKuh9iFBXKu694OxTE3kt7aAwSCgNM7U7fQSwR1R
 kSaKKEkiMkeT2l0p9c4xGlisjGiTqAmG2mMG10pgworxoxW48RixBH9X56md4ZsO4KQ==
X-Gm-Gg: AfdE7cnS6K73binFIXg2VpDvjw0+RHVW+HO2W0t9/OB71azH34HifCUEH8y2Q1VOQNV
 UEVU53xUmbAVr6Z8oPojkobfQMABhclByAkOL5Xlwys9CDpMq223O4UtcuhSSC6/noO6lpwWmPO
 1GcX9H/Ld7HHVoeecTuFYTDOWHdESTs35WJN0QXIKrHhdwMcQTxZPUH2Le8cJ0AS0YTe5wyrZos
 kV36J/56yL4xCLx6M83+69kdXmZyT2PUXnbzdLy1a5YBJfcIH77Q9Xt215F9WwTodccV+S7GnSa
 osvP8BXKRkFj156XFcx8usK32URAkVjwmC6f76G6t4nUgjQ7lOIDiYWLznc/n3/x19GzGqaXDwO
 eH+uoU0qDKBjqMUDU5CGjIH5XCDQpnQPRjGdaMVrvGkJaA7/3ZWYEANwBDOV3/pJsayKP
X-Received: by 2002:a05:6102:3047:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-73a35cf53cbmr2538066137.3.1782857007030; 
 Tue, 30 Jun 2026 15:03:27 -0700 (PDT)
X-Received: by 2002:a05:6102:3047:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-73a35cf53cbmr2538047137.3.1782857006576; 
 Tue, 30 Jun 2026 15:03:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfc32992sm9074735e9.11.2026.06.30.15.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:03:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 19/33] accel: Remove unnecessary 'inline' qualifier in
 remove_all_breakpoints
Date: Wed,  1 Jul 2026 00:00:46 +0200
Message-ID: <20260630220100.1289-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e6nHdBw-c9uDbH0LawJMzhG74oK31eqC
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a443d30 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ucb4Co1tYGy3ov5cU_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: e6nHdBw-c9uDbH0LawJMzhG74oK31eqC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX0/uPN2yKSqKs
 ViFChPHNggXCx9JkpZjt+r6S7GvPnh18frYHyNLSPei8Md+L+CZFDPyEdUs1H44/hJoin3pMTA8
 G6z+9cfToIKwJTrN9Mjd3kmuvVIw6I7y5lecRxRsOKMHtaivWOYjFQhCCAoKqkqyCyGTUGt/8Sc
 4rz4ckuSEu6xL0M8/BH3iYcj+bCkCQp/6aTBL+OOyjFzGc/O/+PQoeHMPReaWwiaK2kL+o+BEpZ
 +K80nBMXCdi+4ON28uDczrZ6IYLwzRCCTZMw3B2nkhDnPkP+ptwoy/Bu0FeCK/wHCs3cGKhsoBy
 1V8EpjGHLyMZe/C6QRl/gZw43sVKo5S2cQe2zgpLGK1/EkXHE4Onzkc70vzOEIqiIE8AeMDEEld
 Qyi6zhGG/tRvJxhxtTrSpwh1EELlx8+yWVXf5oZ1lr0ugTjfU1qVGt/MYu3OXjz4sbBMmISNzHw
 c49xqlkDLsIm0/8FDng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX6NdcmNEytjce
 fKoQj4dfhC83D8qKuLcwe4KBqCa8aaJPEL2kYuTn+YMPGsXvc2HkNfp9n3pFMQ/fGY7zMoed6rl
 A5j4uk0E2x8h94D/N5+LXuCm9X04U/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/tcg-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 26d34c72d9a..c54acc770e3 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -188,7 +188,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-static inline void tcg_remove_all_breakpoints(CPUState *cpu)
+static void tcg_remove_all_breakpoints(CPUState *cpu)
 {
     cpu_breakpoint_remove_all(cpu, BP_GDB);
     cpu_watchpoint_remove_all(cpu, BP_GDB);
-- 
2.53.0


