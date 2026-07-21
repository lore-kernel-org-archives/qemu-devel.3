Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4559DC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7tb-00061g-8R; Tue, 21 Jul 2026 06:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7ta-00061Q-1n
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tY-00034y-BX
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LAR81H1349447
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9orFn3JcygZsqjm/wuUrr1jCHtahYzJU1UXC1wLtoE=; b=CKDGRvL/+EEGTi0F
 dwi6F7854QsBIWL0lSFI3FmFVzvA5u8Rnv2d6Kow7mDBZFZUL0MMfzdGw66rKtEh
 JFYtCd/8f2nA3cK//vIsHYphTdFNN9QsQFd9OF97Ze54SHFxh0ffgt1zHNqMNFoD
 /Pf26/SfP29sHkxiUtPgs5OPBOjvNIZvzGlimJSKdMXPAYR8uDlvyPzmzrXke5O1
 Glwoae3swoK2s7v428v6tdkdeOVk95m72+UM2lAfC+Sk3537PzjnqvWf4wRbczxW
 CWKMUufs91duJXcgVFQBzCNCvYW09udwKEd9B9DECoCwdoMNC6MYEdVZFAAR7Xj/
 6tMGKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6pa84v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf321d786so98358261cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630414; x=1785235214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W9orFn3JcygZsqjm/wuUrr1jCHtahYzJU1UXC1wLtoE=;
 b=ZuuWRCFkEnWPQKoXh09RrMuogJX2Uy9uj9wmHpSQNlfve86U3XOYuvBk4VPrjLOIWB
 VfToPmQZI1RSb6TVmN7Za+OjrtV6Us9bgbc6730vwWlb+2avfvxa1yFFn1qgVx6wxi16
 s23Ec5vi4Y/nMdeEkDeuapIUC9brESJAfKUU7klHl5c47dGTTIOGRpz2UWgtTb50aIUo
 NQJDfKOyCL1nOknIVm05rcBwa3PplaOoF6X7A40bXSS2Vs+Zh81hTFUggEnsF2nwzDLa
 Zims86UrO4UDpckHMeHk8bkX+uV4vO6dIbe3mL1+eiHFJ3KmFZZ+R4ADg5sPZkjrWTxg
 a0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630414; x=1785235214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W9orFn3JcygZsqjm/wuUrr1jCHtahYzJU1UXC1wLtoE=;
 b=oaLrbjYfLNH32toxNI4r0qmu3mizVJNsuirLZCukMACHv2fb9mp161EGG8Y7tRfZqU
 Bz65hiA8xPosKunsQJYMQSkWcv6LJNhAfhs6XKvSZcDlBFDttNTp3InTF1Jv2/MoAGhi
 mNslso1MUZLF8RRKXtN7WrMz7Yvz1/5Lm1qK3M6kejtwMDNkSIDQY1tTdDogGLZqvJm/
 ijqtr/S2/kJ5Xfp9XPZ6TdDHO5c1tq9HHxhcdaRqV3lrTRTNFLyXLoeXAuO2pz88xpOt
 mqUmNcHaTLtiXb9ZSEXytTG7gPQSrx79RTcQkyg6S3PSDEUVz+h80AwzyQR9IsWRpbKF
 SIlQ==
X-Gm-Message-State: AOJu0YzfpbJ3Rj4+C6v9acrQ2f17BRB9t2SUDG4coNvfHnLu0Cjy42va
 1fTCr7rHiybwdE/q01kKLxudT5mcABSaP2ROSaV8Am9vzzr0NFFmfYO/rzLx1H/+USKKLI/Hqmi
 vdFcnoG0Rn8x5g7frFPzQ6Cu3KGMe8OElUuxW1Clir89KgapXv8A9/UWzRhfNx3iBrw==
X-Gm-Gg: AfdE7cl54Un8Ch0xGqwGHogJRH+5lNlz9i52FlObgMyQJyHX42Tzy8iG1YN1Tj2WRK7
 RJWyEyviW2T59pZRVXHisucaJSfdzt1SBFfrVRTh/y27NnGYZCmEgvdTdxJ+1bF2yH0tprBZ43S
 Wnx5huvkpW3nU6rOpJ3SAg0knsurL98RKqgMWuMBBKCIB/MJasbuw3gGEX5EL6aQfi3UmCc31WC
 a9RFX18Vv2waDr0Y+4AVETNOCzZ06mxa32ljyEBh/IuyciLA8Bxv3UncQQLIi/bWESc7k4/RMzr
 D8ybFv3LfDQaqVTVuOTOnvIqRpEYayq9cVWhT6RZtMjQ/xI9DaiiDGDYs1jxiiJixI0V7I4Nb7I
 Tic0xQIX/6fc9d4JJv2DA+qjSGUZTwlvS9Ys4WXIzephGUmSWxr5eU04czQ==
X-Received: by 2002:ac8:570f:0:b0:51b:f340:d2be with SMTP id
 d75a77b69052e-5213e48bcdfmr168057621cf.53.1784630414098; 
 Tue, 21 Jul 2026 03:40:14 -0700 (PDT)
X-Received: by 2002:ac8:570f:0:b0:51b:f340:d2be with SMTP id
 d75a77b69052e-5213e48bcdfmr168057401cf.53.1784630413606; 
 Tue, 21 Jul 2026 03:40:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm36498459f8f.6.2026.07.21.03.40.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] net: Correct padding check in qemu_receive_packet()
Date: Tue, 21 Jul 2026 12:39:56 +0200
Message-ID: <20260721104004.84934-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Joo-fI3rKWIvvh8n6CsmnvEGCibyP1SY
X-Proofpoint-ORIG-GUID: Joo-fI3rKWIvvh8n6CsmnvEGCibyP1SY
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5f4c8e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8
 a=EUspDBNiAAAA:8 a=Ys89CfVQ5-dVtwXYUXMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX3Oi2GniKGdAH
 nr6gw0xxfOzRomZ2/0TYksyP14f4YR2udW4KLKly0gmiuotug9Ik6AIhA9ny19pwY4NAB5MiGlD
 rnRZUYdLStsV4AKV9vXlfXe7x3pMIo1KIt5A1MDNqRQHmMQYiFHRHX3uSFE9fa+5/S+abKqKvxB
 dSyPk6rx348A+3IBS6RIKQhfWVMM+D2Wm2Li7XAIEn6cnUcbg0nnxNgSmf/Wxw6kmCj7gg90Brb
 TKad6sVCBsbwKVcp38n9Osy+VhhaiG34O2RfTOn99je82mDekUHExx1PJYwuaamb+aS+r0VTavr
 0v/G8kVq7owlTjIObZRlYRAtyfIulpT/6zFKvPXqW+8LbY1n2a0jalTanAcjCTAwFrIR0qCyHxo
 GgAR9vsg91+oZos2cK5Y2qMBrcPCMmJdh10qtDOm5c1x8DUADndxGOBjKds9Rn5Ry4bsvxeNycL
 QrcG37dkI+vdTjPC3tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX8hgRz1jaghoX
 BBPrOsE0KIcnkhocXYJ1BK3+YgUNNqlRrvWp0aGXBB4GnOXPeT/WMrIrPSnP8Z/mHyPQyKPoT/R
 sIdFaH8uHuz/PVD7HNhrdQRD/bsBZl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210112
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

From: Peter Maydell <peter.maydell@linaro.org>

In qemu_receive_packet() we check to see if we should pad a short
packet.  This is doing the wrong test: because this function is used
when the device adds a packet to its own incoming queue (i.e.  for
loopback), we should be checking the NetClientState's own do_not_pad
flag, not that for its peer.

We didn't notice this earlier, because at the moment all the real
peers of a network device (i.e.  the network backends) do not set
do_not_pad, so net_peer_needs_padding() always returns true except in
the corner case where the network device has no peer at all.

The effect of this is that if a network device has no peer (e.g.
because QEMU was started with -net none or with -nodefaults) then we
can still let through the kind of "guest misprograms the network
device to loopback-transmit a short packet and then we mishandle it
in the receive path" bug like #3043 which commit a01344d9d78 was
trying to fix.

Since the distinction between "we should check nc->do_not_pad"
and "we should check nc->peer->do_not_pad" is a bit subtle, add
enough documentation commentary to make it more obvious.

Cc: qemu-stable@nongnu.org
Fixes: a01344d9d78 ("net: pad packets to minimum length in qemu_receive_packet()")
Suggested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260629164246.2028947-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/net/net.h | 23 +++++++++++++++++++++++
 net/net.c         |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86b..9edfacf827c 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -349,9 +349,32 @@ uint32_t net_crc32_le(const uint8_t *p, int len);
     .offset     = vmstate_offset_macaddr(_state, _field),            \
 }
 
+/**
+ * net_peer_needs_padding: Should we pad as we send out packets?
+ * @nc: NetClientState
+ *
+ * Return true if the peer of this NetClientState (i.e. the
+ * destination that qemu_send_packet() etc send to) requires us to pad
+ * out packets that are shorter than the minimum ethernet frame
+ * length.
+ */
 static inline bool net_peer_needs_padding(NetClientState *nc)
 {
   return nc->peer && !nc->peer->do_not_pad;
 }
 
+/**
+ * net_client_needs_padding: Should we pad as we queue packets to ourselves?
+ * @nc: NetClientState
+ *
+ * Return true if this NetClientState requires us to pad out packets
+ * that are shorter than the minimum ethernet frame length.  This is
+ * the check to make in qemu_receive_packet() when we are queuing a
+ * packet back into ourselves (i.e. loopback).
+ */
+static inline bool net_client_needs_padding(NetClientState *nc)
+{
+    return !nc->do_not_pad;
+}
+
 #endif
diff --git a/net/net.c b/net/net.c
index 5c39f8e7b44..0a30579ca4a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -783,7 +783,7 @@ ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
         return 0;
     }
 
-    if (net_peer_needs_padding(nc)) {
+    if (net_client_needs_padding(nc)) {
         if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
             buf = min_pkt;
             size = min_pktsz;
-- 
2.53.0


