Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6DAC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJE-0002c0-Dj; Tue, 28 Jul 2026 05:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJB-0002Zz-DN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJ9-0007Od-Ls
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82Ghr2128814
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u/byRxww6h1eTsTIyxFmwIVT8X+SFfGh7WiYz2U2f1s=; b=AqPhFsJL88cOtGk2
 BfRo3c1WK/tm7Ki9PBvLLrJ2XTXQjMNCDpwZO8EX0+7d/y32zwPsMbPEGe4HGpoM
 KjmxNf4q+Thz++3jStywynIkNaj3BH0qZWDIqSP8lqSU843piRyDU/z4mksH1rct
 EaLewsZYXQs/N+eCJ/9OPqni6KuTtCxmzTOYYGsadr87h2liHjkd41YxNkjpMkHN
 Ya+my+0jnLt4bOSFXrUdCpDOeypiIz5HwgarVs+ykYnumf3VTY/AHj9zBZyv9LfO
 Gc0x1NKK1Wu0pqkgekFJY4AXx+Mv3GGo2/B8shOYD9ztaV1aa8x+ZbvIESFp3GnD
 Pkb53w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8bh7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso45880581cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231665; x=1785836465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u/byRxww6h1eTsTIyxFmwIVT8X+SFfGh7WiYz2U2f1s=;
 b=bXiod4GZgkl3+usoSxvNt9W3o8MOOKQM5OcjRSmOUJPIu5ewVbRqFnDr+KiDLjI+t4
 eeE0zcR9b2beF9xPduZnzJzYEtCGeYJUBH6w4YITFvHAKMdxxnHMKjpRm6Srxrnv03In
 pyc7V+rfDxaHWD0B52J+VFaAVqXn/uQloAH/7mxEmcOiOmyfR95R4frKkV/O8mzzeYW6
 IGSdZgcLCjq8zDHkpkKNuRHqRCeGrfoFKS+In1xGY0diYDyCY0wBcdkGKlcr/b1rEjcS
 VjU8i3XDiSQ9sKPSLNAQOTKrkFx+OzPvnq9Xz0sqqYMMZZxZVs8WESx9nSqq9rBdznII
 6iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231665; x=1785836465;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u/byRxww6h1eTsTIyxFmwIVT8X+SFfGh7WiYz2U2f1s=;
 b=bhxQ4PqBOGooO7UzDcGlwMhkGEb9FVo9MGKe1craWe4lxkGMr/o6Knc+QdZetWTmcY
 qIb3TaCD6uzd1Np5aE9CnJLZddm2t5xBGME/ezvmxtcx/RxORWi27jj+vBDlubl+jxL5
 jsBU7ZL9b8tKybbi8aIvSH6mG729/j7s5pvistYDeaVtOjwHUNRYPG0T1yqo0gATTNaF
 zCJd9HPtl6S6k3oFmxI6abPldbdoXsxeYhvsDchzquZphzoV3hGYGu23Elx9wtlyGYER
 Wu8lyYzMayRw++fdIQM0C8IkFF2b0qHkQ1D9R6Iud0vviK596WYF65brfAngROIZCeh1
 T+Eg==
X-Gm-Message-State: AOJu0YxZru6I1EJh0jT3TVg21MmwpD/6KKxuN1tSY+2cZorXZof/d1Pr
 Xo6yz4duHZz5/8x58ADHatcFxCjugwHxsiLxFu4+qC635hhpiIoeYQ3Y9d8/TUFf62xvCtJIAac
 5dbLxkTGKWJi3BdDnhMDnDCLf2dqIprphIp0YrPz4F3Dg5j/7LNBPAz9i92r5b5HtAg==
X-Gm-Gg: AR+sD12naXnSLOypOjUfZ4IjrVne6+rNGL/BicffchC3GqA08JiH4RqjbcoPwTgv3v4
 yZaUkvr97DTjj6S7vsCs7RFaQOcJME/3wPnGJMho9vHaNo+aOTRDAg0v1qVdAisMAerhmWdWgCL
 luXO+j3mwwQFR5bYM2qEZblgofzbE9Ed5ZkXn9IE2lwXKpwHEd/XtM/R35gkHwQ0dSuX/ty5ILl
 4ggjZxJOYd0sDNaKK51vpF2PHeMIi+aBaBIynyvv55D7KGuwk/tWeU8HMbRh0HNQbsbzJd7d8Z/
 BmZR1jWSEc+K3ENSsdrV/eBZe9TJX7g44GPX2btgMFkqxaCLStDlMTya/bF+yw0I7/tgmSdZw4A
 K7Jd70Vlk0DspAvSxCiczuULZLAwHSiPIzat2+eYIRmKkhIFleGDQtwDKVA==
X-Received: by 2002:a05:622a:558b:b0:51c:667:7e30 with SMTP id
 d75a77b69052e-529d70d8521mr11364071cf.47.1785231665031; 
 Tue, 28 Jul 2026 02:41:05 -0700 (PDT)
X-Received: by 2002:a05:622a:558b:b0:51c:667:7e30 with SMTP id
 d75a77b69052e-529d70d8521mr11363821cf.47.1785231664337; 
 Tue, 28 Jul 2026 02:41:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm57977299f8f.30.2026.07.28.02.41.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:41:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] hw/net/xilinx_axienet: Don't write checksums off end of
 packet
Date: Tue, 28 Jul 2026 11:40:50 +0200
Message-ID: <20260728094055.12684-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX0ypmpS1O66J2
 zsZwlA7KDzHPJr2ILFmDhzLOHBpAWtrzOY1TyjbTcXwU6/2j37Rw3u7Bga8ZK+cakhw/XOwOasW
 1MfvSCsKqFcj2cvzzGLE+0i9a64FTqclhikZQzXoQVfE1TqDHSN6lDJSS1MNeKqdKHilzM53Sli
 6z19KZOrGRl8ey+0MQHners5GRfTVC0NdNkUpSfPE9zTtMjA4ICKpA0xAGfsUUYJcZz6F/clQUQ
 AvMZycbzuJCkWoWASAgM28rbCuoimh/pCaaVkiS8VmB0c7Ppb9CgkfrgUg5+DwiJrfTPcYMXlhw
 J2qBIsSDaGU2wH3jPc6//Fqeo+yF1z83wFu9yvR1mx7dMy8fkVIY5RlWy4Ri7si3xKrgZ6IeCfX
 bWXb1O+VyJi9HLHyKRb/F2DyUKxdTrKWICj06fkRLOphfS6/2sVWP9YlL5vXyTqoG0vLmeEzjLx
 a+dAaNON/9BV2ynBW2g==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a687931 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=keMAUe95F7znPUNsns8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: ozyWDdBcZEspOTB7D2ZyeasMK8OPWFjd
X-Proofpoint-GUID: ozyWDdBcZEspOTB7D2ZyeasMK8OPWFjd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX6QrXYm++hNoK
 SaeDy3RShtAboeNZJXWaa1v1a6pHmOLbZB7ebSwmIzw3EtV5bpiRcmlF7H+E0Nx7Ebrik49bk91
 OnvKo0qoR7VLDKCP6M1PW2t4oBJAkWM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280083
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

The xilinx_axienet device has ethernet checksum offloading, with a
mode where the guest provides the offsets within the packet where
the data to be checksummed starts, and where the final checksum
should be written into the packet.

We don't sanity check the TX_CSINSERT offset before writing the
checksum data into it, which means the guest can pass us a value that
is larger than the packet itself and cause us to write the checksum
off the end of the buffer.  We also don't explicitly check the
TX_CSBEGIN offset; this doesn't currently cause any problems because
we will pass a negative length to net_checksum_add() which does
nothing, but it's a potential trap for the future if the type
used for the length gets changed to be unsigned.

Explicitly check the offsets.  The datasheet doesn't say what happens
if the guest misprograms this, so we choose to log an error and send
the packet as-is.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3599
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260706162704.787495-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/xilinx_axienet.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 9f5f65ecfac..d35f4a847d6 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -922,20 +922,27 @@ xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
     if (s->hdr[0] & 1) {
         unsigned int start_off = s->hdr[1] >> 16;
         unsigned int write_off = s->hdr[1] & 0xffff;
-        uint32_t tmp_csum;
-        uint16_t csum;
 
-        tmp_csum = net_checksum_add(s->txpos - start_off,
-                                    buf + start_off);
-        /* Accumulate the seed.  */
-        tmp_csum += s->hdr[2] & 0xffff;
+        if (start_off > s->txpos || write_off + 2 > s->txpos) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: offsets outside packet, skipping checksum\n",
+                          TYPE_XILINX_AXI_ENET);
+        } else {
+            uint32_t tmp_csum;
+            uint16_t csum;
 
-        /* Fold the 32bit partial checksum.  */
-        csum = net_checksum_finish(tmp_csum);
+            tmp_csum = net_checksum_add(s->txpos - start_off,
+                                        buf + start_off);
+            /* Accumulate the seed.  */
+            tmp_csum += s->hdr[2] & 0xffff;
 
-        /* Writeback.  */
-        buf[write_off] = csum >> 8;
-        buf[write_off + 1] = csum & 0xff;
+            /* Fold the 32bit partial checksum.  */
+            csum = net_checksum_finish(tmp_csum);
+
+            /* Writeback.  */
+            buf[write_off] = csum >> 8;
+            buf[write_off + 1] = csum & 0xff;
+        }
     }
 
     qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
-- 
2.53.0


