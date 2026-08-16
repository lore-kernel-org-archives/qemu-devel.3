Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D2C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAh-0004Xu-Gx; Sun, 16 Aug 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcA8-00047I-0N
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcA6-0000tb-GF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDklSh481355
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /4700RvMPhJAVGgde3qZkacZXDpDTVmcTdrCQSF011U=; b=oa/6DtcCAPphvVxl
 bIULBBhp9TDqzKiXeT6mlkhL0HzZd9WdGmYilQOrOD/BipNbwBapLkBCUL+5UO35
 v+GLK5759Kx7NU0A5V1UvneMvvW8Y+38PQH7f56q5iwmjL7EbCSG+EO8lnRfgp8u
 KiFiQt5QDROJmi7LJ++630ta+LXtpMH4IGVUP6j5IxjZiT0nJCo7cgku+Sc15Bn7
 3AG3KEohRPAAf0de651FuYckQUoZB8iNxWsUgT1wotA5CtYZ03dAVSldXt9LLYyS
 1dH0PjTGKUpOt9p6KSC89JxNsA5avz/ws7PX8OuMogyLFygNo/zpdMiBVibDA3HB
 fpQTsA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbjxc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e53b8a302so268917185a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891711; x=1787496511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4700RvMPhJAVGgde3qZkacZXDpDTVmcTdrCQSF011U=;
 b=VTbwIpwAD/BDZnmQ/rlFdnjNr55tuOQZoz/Sy/6oOEPloa+ORfKMskFYvzuFtd+SDX
 0NXiwZmK5I1h0LYOcjrr5y70tFxmH37RKGkKMmE9+nudlFjRXHbajxF1Gr777Ky58jzo
 VcLkMGh2Z8E/qoxxu10Uuc+0F1MTKJ79BVm3vNNStlZZb05AMXIsCFW9zKkWGNQbf6dC
 Dlmw3efMiwILGgWFDqVqm2wLNdjXoqwNA98wRStKGUc0sbdnbE1QRdF4F28JJUJlCC0H
 4Ply9GvqWVHG/6/5JaKtznbeAcrVIC5gChZifdyqqUQAk00DFnueOFSsGZgyBe1jp72e
 KbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891711; x=1787496511;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/4700RvMPhJAVGgde3qZkacZXDpDTVmcTdrCQSF011U=;
 b=PUk+KhVTvW0zBLqAyN2pFnN+IHe4H7fpo7rXLPkXoi86A2gnkAj2DYru6/0e0gGLnw
 8L/9td/FBV/dpqGBRx281a3RBltuNnAtslk2dXS0QGcKmN+xRWy44SJ9aZJA/ra36sZB
 VmFmJHz7w5wjzT61tDWXNCgehR5etVQLwDs0WhPUOWPEh04eWS7xksdeXW289O9oLZR2
 r+jo5/wKMLkv3ALiyfYwzx3Q6rM0ES0bE+pUKlSAZSurrNXVG6xqIzjO45yfjq55q24g
 uhcG/c3HIDGxVDrrScF7IUoHq20/zYmCS92AMSaf1Zg9hLirTJpUQsZFr0BoCql8LRrv
 0aIg==
X-Gm-Message-State: AOJu0YycsZjvyPipk9SZpKfQ4fjSXN+4MwWfv6jeP5tZr0sf+akGrRBT
 qprOd9VcxaW7ZXdBVwi7Uu8DNWByt4a+eX85EGNuTrRQMn4/zzjk6nUZn3A4aXyg5ACwjotEEr4
 vpVhm9t/wDZEzMYzPqL93uKbmvthBN7Kd0hkV2sUgZ32EQ39w6IUOdPXQhDcZ5Ia7Qg==
X-Gm-Gg: AR+sD13qd7vrmDifKekXYmWX+hfmEVptaV7GA8lnOisBUJeu5d4UZv0idLlzeXq1Cbp
 jjhslOCY5RXQVcvgZmXoUedRXLZuXB01c8CrBoC1Byfx+4gv+hiI0GPT/Ed37ncPgubhJOu+pRa
 kmp/qU83YHAMK487qEdglupJHh02qhnAetOB2zgSufOi2D0xUVi/WCBGk3zcKrtelYeYocpe4AZ
 kRxvjcg6WJ/4x40MOsDOyUn/oEsc213rtfJ5hWTyj7sXV92t6bNqr+JqHEUFNmKsYcLdFnoqkn1
 ADxB8FOX7WWpo7R2pVEKah9gwPezYcwNlll+y55kHXLaZX9++jCce5gI5fbOj0je57mHCMOUw5C
 6Dsp/fnS59FAKlNlyyD7679cpSoNxUlGBBOCe2pr1cQ==
X-Received: by 2002:ac8:5ccf:0:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52d854f3ce2mr212906621cf.38.1786891710745; 
 Sun, 16 Aug 2026 07:48:30 -0700 (PDT)
X-Received: by 2002:ac8:5ccf:0:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52d854f3ce2mr212906231cf.38.1786891710291; 
 Sun, 16 Aug 2026 07:48:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100082sm79612655e9.2.2026.08.16.07.48.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/56] hw/net/rtl8139: Send whole of vlan-tagged packet when
 doing loopback
Date: Sun, 16 Aug 2026 16:45:17 +0200
Message-ID: <20260816144556.69009-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OZ6oyBTY c=1 sm=1 tr=0 ts=6a81cdbf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8
 a=EUspDBNiAAAA:8 a=OYC5cIGrZyd7Z81vqYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: V_D4tMZKDVWfo3_Zo2crV9GXQUacQqfO
X-Proofpoint-ORIG-GUID: V_D4tMZKDVWfo3_Zo2crV9GXQUacQqfO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX2p24J9xUODeO
 dJz9NsQDXGGqqUYQ0Us28ofxjWcTBdBKmatGh2A2XuPbkHKLRTyl1g1IIvlJ9w0vXWFNAXhhIee
 Y1WxxKZlAc3WIjWxhmu7eOSOKlvpE8w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX7ljguofgVddt
 Dtcrxzr7aAU5bSHOh2oGha2gbKOH82fPC9MV7gCYZ9G7oomKXb63+WMyPKSFaQdyMKuyT9s6u8T
 tZeVcvjwU2yYE5DdFLtFXS2SlLwzy+d7IVLDkvm/p1KcuXS5gJsu3hjf6l/Vd9AfTtKGyNIS9c4
 L1zh7ToouFcvmZhAT0Kt06bB8YY5Ze72QR9lTJ9SbFFTGYgvx9vd+DXBobtt089tYvNS1hBqRlV
 0AsOXR+wVGineGL+m8K6DiQRPocXoak85477n8001Lr86ZmsFE//uyed5gmzdCLW1VD+MFVfuqn
 aUlsTrCy/h/dwmiRJwPPLX26eMRtRJcKWb6KSvsv94GfcWi5n1RqTOve+5nRp1zU8uI7AbShv/3
 BBpPS2xVg6H0sND7zKSHNOuoacbE4eYr8aq7id95uEb2FtE1sxV5rsy3kKK4w96DBBryrhDz06d
 ty9ttsGEu7vEpBad/IQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160118
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

From: Peter Maydell <peter.maydell@linaro.org>

In rtl8139_transfer_frame(), if we are transmitting a frame over
loopback then we do this by calling qemu_receive_packet().  If we
have an iovec rather than a simple buffer (which happens only when
we're sending a packet where we are inserting a vlan tag), we have to
convert this into a simple buffer first using iov_to_buf().  However,
when we do this we forget to also update the 'size' local variable to
the size of the new simple buffer, so we will truncate the packet by
4 bytes (the size of the vlan tag).

Correct the logic so we don't truncate vlan-tagged packets when
sending them over loopback.

Cc: qemu-stable@nongnu.org
Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260731093618.2961031-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/rtl8139.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 2b61c171f2a..16479284eea 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -1765,6 +1765,7 @@ static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int size,
             buf2 = g_malloc(buf2_size);
             iov_to_buf(iov, 3, 0, buf2, buf2_size);
             buf = buf2;
+            size = buf2_size;
         }
 
         DPRINTF("+++ transmit loopback mode\n");
-- 
2.53.0


