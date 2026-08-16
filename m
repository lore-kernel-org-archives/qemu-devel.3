Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F460C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAn-0004gT-1b; Sun, 16 Aug 2026 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcA2-0003zd-EP
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9y-0000pl-Ge
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDmMA13633961
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a+WcWjDtr6Aqfvb7rgsLeTX+z7O13m3aV0M2b3rFLZE=; b=ZSqBE0VrkZ8vRrpm
 IYGJrWBeya/29axMK0CQN053zRGJKVIT4Ekoxx3U8+38XCNEN4i96zd5IcUEG30j
 MBWX8XcNAydtA3/guWngASU7DMb48F9bn0M79h1938vBynV2XT1lot5ge4KeQYV+
 2TEUiXpKeVrEtfvNEpze6QiskZLDFFqC0Rl/nk5P/23ToiW2nOc/nZthqWpZzsfk
 teNdXLsDuHthnLt38fNye5k+dOVHUipzWWnI70b1QrSPF5Exqt9pa94JcqraQl7x
 uOnCqjzoFp1L5GtVrBfIDGgBuRp2OAKYMFJWoo4LXsjah5YLnOQ0D2WuJdFjA0te
 VibJcQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekq1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso49068561cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891703; x=1787496503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+WcWjDtr6Aqfvb7rgsLeTX+z7O13m3aV0M2b3rFLZE=;
 b=LC26JNdrD4/aNgo5XYo4OBefTsJKDhzNdgJ+mpswhkCfVMXacVGBdV+zRLqmPfR1uJ
 w4+MIFN9S6o6vHsx1P5S5DJApf3d5gMNeY9kvkjphc1BmhfnxWSeRufGQzJhpbKvitZA
 SjDqoGtkHXh/+PnONAHKXwoLqiyMBHHdnS8dd532xrBNUvosLu0DspYBt1ebMtdB19fa
 JR96IP6YH4+D1etFOoEQYMOK4Zvag/Sle+U2dYNshiJGLsW5UD1+Rj8Clf1TW6wOV6wv
 0nYBqU5ZWbweyRKKgrBPYC6MRs11jxlCR/ryeJi1IJDYNVWpoezKCdsxiO8WTWD2a6v1
 2r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891703; x=1787496503;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a+WcWjDtr6Aqfvb7rgsLeTX+z7O13m3aV0M2b3rFLZE=;
 b=hgQUwoz+bICx7Xq7HemHpR9pdbYncxpLx5IHvpBoZAH09DnBemCjftlGpxZ6unNU/z
 U7e6WG0PDahasuZZ1HK/kSG/5Nx23T8OhRFGebPvX4gFnuYuPX8odfRYakqKKE1eMxbk
 EeCnVlYtJnym5+axmzZAEndrORabAZPc1ZX0MzF8eaVQPzoT/cnwRwQZFXnnDyphkCuZ
 DqyFYEc3dI1IuJvQ3tgD5K50KXL1RzXjMkmifF7iIUiCMD7YD/Y2Z4fR47TJ98ezcsl6
 3iFR7TcQwpa27aR6y1KcFnZrWYoiZvf0+qkdc+mgRFuaXfV8T/23q1U8HC5RnSdGOyZh
 /ozA==
X-Gm-Message-State: AOJu0YywnKAPwydY26M9vmjLnMVwTxXe0zhARS4TZqMOdSI/q6MpKHW9
 F6Y+eeogBcTbhXk5fZl0lOWNflciLU5WGrcN2QUOBHAPo9pM+NyvM/D8lUTzjEnV1NaBKlvh0Nf
 SkuIT/g6fuR21CAuNrzyVe0gk/B2riwQ9Lm42bVXMzp+oPZRw2ziWL5kKGRmuVxtNsw==
X-Gm-Gg: AR+sD12QsGZWh5ilwdrPdNIYqxDinNfzoTFcn+U8FjGqi1Bw6dAhiUUy5P7BLs1LTLK
 pLMxntYgFY5H2u/5e8hKq+0q0ji2xfXSiCpYgM++yvNKy4T24IER0jfrJfEB1jECxVdJ1dkfvdX
 Hi6tBSY6ztkOrODgAZU4k5xPQUiKXNhuTeHeje+T3ufZk3W+FX39MKC3f4dmJTLzgDi32oiJM5Z
 ysPrPReaSaKMknPyzW8myACo7UlVPrHNg/KwBYfd4dMZ8d/k20KIfpMdpPWSM7zuVy2HhEC0Nqo
 e06cN/QF2Go2aASJ7oH/fVAGU1axsNA8X1vXNlCg2JxsF+7Td7JqAdb5ShdkI8DNkj0cRrqp6w/
 dhhnYOhbFhZEGEkF2p3799BK47PPT/OP1ARPkcC7/tQ==
X-Received: by 2002:a05:622a:1a88:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d8543f3c0mr200751061cf.25.1786891703473; 
 Sun, 16 Aug 2026 07:48:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1a88:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d8543f3c0mr200750801cf.25.1786891702972; 
 Sun, 16 Aug 2026 07:48:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1fb7sm24526763f8f.17.2026.08.16.07.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/56] hw/net/rtl8139: Fix handling of VLAN tags on incoming
 short packets
Date: Sun, 16 Aug 2026 16:45:16 +0200
Message-ID: <20260816144556.69009-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81cdb8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=RxFCA_QbULDqiWA6Y9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX5kuzTRClWW6C
 CvuyV73k3WHGxqDdzP74BplWy3fuT2Pem+3t7BDNMo34JzUvoFHxMmOSr6p7e+DjCvmwDk+5l3X
 bSS6ktSJ7bHuccqvrgS8fDyvFo6RBtw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+R0o2Ycjx9qs
 8Q+WPiUHXnVe0DfXmpd6wwI4YdDD2AJMQUgFkA03ZNuw4baWMmg+SPWZN52tfl48tnFamf7aZVM
 J4glkYY2x77kSogzfZxXwyROziIZkkt0FlHNT6z/Vh0Q1S80OlPXl9s1pjW4ZnEk40ascAJCtSU
 KgB5iknKQt1GfDMfG0AnnjXFx1XeyJpltEf39F9HeaYv7yfSHh1KVjzYtJpJGlGASNI3rmGkfnG
 Nf/Yn18Nt33PZOOKyGQLQoIzZOoUyNuGzFuAt09Y4YmagZUAqEPcNlPPqqsM4oOxZ6ZOeoAQesf
 TWzBreb4fkr4KUQl31O7TKFhCOrfRiPuwtdN5imHk4XUJRHuSaNimul816x8VaFWlqoDVpe/Ptb
 1YhNeuPn3AcnzxqyhSWnxghcooRSi4NyIla3M9zq8d9RXR3wTeOjODxng4YKpwsCHX2Q76EnQNc
 sQ2N85yZl/I1U6fJCgg==
X-Proofpoint-GUID: 5QvN0APf8r-sICTdkTDTx2iBB6PgNE95
X-Proofpoint-ORIG-GUID: 5QvN0APf8r-sICTdkTDTx2iBB6PgNE95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

The rtl8139 receive code handles VLAN tags in incoming packets by
copying the VLAN tag to a special field in the receive descriptor,
and copying only the actual payload data to the receive buffer.  This
code tries to ensure that it pads out the payload to at least
MIN_BUF_SIZE bytes.

In commit 63b901bfd30 we removed the main "pad short frames" code
from this device because we switched to requiring net backends to do
the padding.  However we didn't notice that this broke the VLAN tag
handling, which relied on the old code making the buffer at least
MIN_BUF_SIZE + VLAN_HLEN bytes so that it could copy MIN_BUF_SIZE
bytes into the receive buffer even after removing the VLAN tag.  The
result is that the guest can make us read 4 bytes off the end of a
buffer by feeding itself a suitable short packet in loopback mode.

The old behaviour is actually not correct, because the IEEE802.1Q
standard says that the minimum ethernet frame size remains 64 bytes
including the 4 checksum bytes, and so when a tag is present the
payload data only needs to be 56 bytes.  (A bridge implementation can
choose to pad tagged frames out to 68 bytes, but it doesn't have to,
and so all devices have to correctly handle incoming tagged frames
that are 64 bytes long.)

The RTL8139 datasheet isn't very communicative on this topic, but
there's nothing that suggests it adds extra padding on receive that
didn't exist in the incoming packet.

Drop the last remnants of the padding handling from this device;
this avoids overcopying into the guest when we receive a short
VLAN tagged packet.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3518
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260731093618.2961031-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/rtl8139.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 424af73a18f..2b61c171f2a 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -778,7 +778,6 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
     s->RxBufAddr += size;
 }
 
-#define MIN_BUF_SIZE 60
 static inline dma_addr_t rtl8139_addr64(uint32_t low, uint32_t high)
 {
     return low | ((uint64_t)high << 32);
@@ -1007,10 +1006,6 @@ static ssize_t rtl8139_receive(NetClientState *nc,
             lduw_be_p(&buf[ETH_ALEN * 2]) == ETH_P_VLAN) {
             dot1q_buf = &buf[ETH_ALEN * 2];
             size -= VLAN_HLEN;
-            /* if too small buffer, use the tailroom added duing expansion */
-            if (size < MIN_BUF_SIZE) {
-                size = MIN_BUF_SIZE;
-            }
 
             rxdw1 &= ~CP_RX_VLAN_TAG_MASK;
             /* BE + ~le_to_cpu()~ + cpu_to_le() = BE */
-- 
2.53.0


