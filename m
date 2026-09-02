Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1A0C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mmr-0003ur-SN; Wed, 02 Sep 2026 11:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmq-0003r4-Ai
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:22:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmo-0000Li-JR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:22:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CRF372001702
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u3sukywh0ccw7qimtYe5ZWsz5XS1jMV02iGullEuYuQ=; b=OfJqEvtgSkyBdzij
 i8crWBsRff2zllkptMivcqE/b0COULYQ96bOebNoaz96YcuwtuMDsvKe9RwGY2ei
 hit9egGJUbub4TuCSfOzFFnfCSsh7cWJHpMQsJG8Rz3QcWRyEd7g6RR8slg6jqpn
 lxD0pD8eYF8kf1ne/CUo+/GzjNDcHR8q4u8dyd10b571U3TxT0PArm2ABrznNe7p
 W2weUc97iuv7hbQOEcfTCF7f0Oe8Lda9VpPm0BsTkRloSMgSd4F119opjJoSIJEq
 KuEVASRWC+fDCfDc4kT4hTUgM/SHDHqQEz2jzQsPbTH/Sq1PbnLZy0rsdiqcKnGA
 5sUIbA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy1fff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:21:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93922c75037so39232385a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788362511; x=1788967311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u3sukywh0ccw7qimtYe5ZWsz5XS1jMV02iGullEuYuQ=;
 b=eaTyyzKrpGtEUJOfTKWk05M+dK8AVs71bpzPKwEndskiJ+TnlEml1GwAEk5VS2dJ5w
 YWYa4g+YsUO2SEY8jJK4ezeWNYGZHE7VoGs4ZQmjUv3TujXYEqRtKTtdM/HFxc7guSr3
 mmWLA6f27lhqbKPVpBL+P7Pak0ROSEiJsHYqtQMlHLtgJy5rTPVbUVlGAQ3Az2rs9R1u
 VwoEBI2piabEEEhqA+qP5EnfU2Cw61Rq+5AK5rQhztdlBF24Rn8RziS38yARbxfiAZ2d
 PCouXSet+IFbG2dd0sdgCI1IYBj4prplfut19/lW306GxJuUN2LoVVPaHmRcoMDLa4St
 Rlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362511; x=1788967311;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u3sukywh0ccw7qimtYe5ZWsz5XS1jMV02iGullEuYuQ=;
 b=BLPZKPPLPm9Tx02FoosrleDsvINdB6Rkmps33TFxp9+R3uiIpOmOUZY+TE9+eyQ6zD
 DqvzXFwm7XY35rxvZvPLWfxZmjxTBgjs2/6VYfBdzglqurFMzUKsb0M9tsbS3UHhw7A7
 /yavYlGERpMtk9FbVkzPNRE/xR70HJsPKoPqDA6V+g+yEZFz7Bl8VqbgMvzAVr7hARod
 l9uzwKENa7BDl0gfIXqNXPQCs4AdyISjaJhHFQI7hPwIRVXsHmq9gWJ5gevg1xIZD1Vo
 zpXAk/xGrrFf+Dapmq0b9fVMZg9MrKKWNr5sZY+xH+adAu1nEv20tzf5fBC7czc3CJnc
 n8AA==
X-Gm-Message-State: AFuF++kn6OvWgSR4vJ8O/hTy+5h3ZsnO3kDqn2WkNLyUzw4GrjyRnuBu
 DxqsLODiNFcxYdy/ofNRw7FOHESsCVKGnmUr4vUfveR2FdyQZRWm3zfgm9Dx5iYtfHnrtEK17Ys
 zYthwtUXQD7S0dLxWAUcUB7n+olnjjTTePGdwpODaiizMuSgTCF2F1FcTzvwukaJQJQ==
X-Gm-Gg: AR+sD10vvVPrLx6alCl5jjTPAFJhcRLDkjJWbqN/GqrwpjTTLckY1VlAIrPZPCFsRWU
 XwtDPAl+vAdZw1nJWoocWmRzlXLGkdlXcyFRvA5TesOfbA0MQPdv0HaBxluZsJumNwNzqv0NS3y
 ktOG7GcMWbjDngalCxAjRZ3YFP/MOBYrj8c6JRdJ6hbSmE1ZcWqlBOLgP7cqWNGvXkvImwnR/Nz
 A86FLEWkNCKvOni1EawMDTxYmM6P8PACEVlNIAyYbhTwaijrHVEGDd556YoiAsb4LtZuB2sG1o7
 1C3oiwbQUtQuM5K+LUCuuNCp8zd0fAKqCRGojDKMHHJwZHfyDCYK1ZgGoxxorLxBPtfUeTV5zx5
 LpkyA3D9koLl/oZUfuPmXMhqGIlRe6C87zsDW2T+C
X-Received: by 2002:a05:620a:1a15:b0:937:1538:6b93 with SMTP id
 af79cd13be357-93960ff982bmr701341485a.40.1788362510782; 
 Wed, 02 Sep 2026 08:21:50 -0700 (PDT)
X-Received: by 2002:a05:620a:1a15:b0:937:1538:6b93 with SMTP id
 af79cd13be357-93960ff982bmr701328385a.40.1788362510044; 
 Wed, 02 Sep 2026 08:21:50 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47b9817sm57021005e9.1.2026.09.02.08.21.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:21:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 08/11] target/hexagon: Move to do_interrupt() (BQL acquired
 internally)
Date: Wed,  2 Sep 2026 17:20:39 +0200
Message-ID: <20260902152044.31291-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902152044.31291-1-philmd@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a983f0f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kjvkjD5W99lJKOkStTcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 2b84j2cIh-TnUGHdZ7l0KaiimpWtT-Ai
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX51hy0geBlO+p
 i1SGYvAKMV40S2aTp/akOPrfk3ZphNw4ZK2PalzNZWWLotWP+CFFPVqveihqd0KpiOajlT/aveJ
 y94+1U9ZehCazwcejjyA0Z9u6BtkkLs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfXxxasNkMxhw83
 vy3YQ4BoYpM8SZWZrAP3IwgkDj+4/+EYKpKMf8uxC7RwTJ92x8R+c6JGW+buicnAZYETkbyJ4k3
 Z7DDSuz24B8jIhFlVHidpICKWML8k3O6Pkw8Ir4HsTqd7l8QGe6u6FtPl9IxOdJ8TtKs4242Ycq
 WA3dkIL6eTDuw3osnoWmfQE/Xq4UZnXDmr+sE9TbGF5rFFGS0jOeE3dk8S0AfSH1pXO5UcRQ2eq
 8prKXIIdnGPD1NV3FeBzAVJ3tZ6UVrGQmXCkwZe+UpRteBePmmbPnziia1NYde0T3R5C3l7jWmL
 aermYp5NsxSNWl19Qlsl35jttaAXBN6JBgWchEhTVoivx+O5fVnd2pbtcWgPs6vG039mB5hBxGK
 Mra9K7MXDhKj6+dqZVQIwWFEVuN75dWq5QU9f0ZtH2lIbEZ+oq3lhe/eOHC3gbtsNifObBi6uTN
 WbIC66aeajFpLXi0aqA==
X-Proofpoint-ORIG-GUID: 2b84j2cIh-TnUGHdZ7l0KaiimpWtT-Ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020136
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

hexagon_cpu_do_interrupt() already acquires the BQL internally,
so register it as do_interrupt() instead of do_interrupt_locked().
This reflects the actual locking model used by the target.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index b5dcbfc99db..7067e5b70f7 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -769,7 +769,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .tlb_fill = hexagon_tlb_fill,
     .do_unaligned_access = hexagon_cpu_do_unaligned_access,
     .cpu_exec_halt = hexagon_cpu_has_work,
-    .do_interrupt_locked = hexagon_cpu_do_interrupt,
+    .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
-- 
2.53.0


