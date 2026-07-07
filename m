Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE777C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5d0-0002Jz-2S; Tue, 07 Jul 2026 09:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cX-00021n-Ef
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cT-0000Uh-TB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8hlx3616652
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gqx3pTa8d74O/aUOvJClkkM0PH73BWXonrGG6zGJlxI=; b=gtEDtG5+HUnEStNr
 irjhGw0BG5FRfRDM0i32VgT6ziJScT/Br0q5BLLRcKMpDTcIFHc6zbBf+lareiu/
 +j6NDQLcSeoEF6ozOpHFMV9NQBvG9cDPmIRAE7JAWnd5dfPwlWt/8Zu4VKBQNHk9
 U+i/0lMNDsm1AZxXATBSDGEae3TlafNNT3HoaC98Pk3CHllfkElbXBm+xG73x3Hv
 sf3ssu5EjU6/nzq16yejrN+5TLN1sRBHrtwG2xpOkvX0cQyts05JlqMxWzf7pwrR
 Q8JPYI8k5EkdCM0cOkunbiC84Lf1REPjTEmxQXXyTea2T9202Uc8He/RFEWpbfNa
 UYIEHQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun1dhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso8374021cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430025; x=1784034825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gqx3pTa8d74O/aUOvJClkkM0PH73BWXonrGG6zGJlxI=;
 b=K00aYpOMULEQPqvwwDiZm/RE00g9D01h3PkWYY4GaNeYWAz3hRu93wWxGYjUeeR6WC
 Es+lUli8OKt8u9lRvlNFd1vJo7Kpn4huYbBxwIdCC+mooYpkUh1RMxkWFnmX+5AivULF
 oVq1Y8Cqqi84lGRV5iBDm6QNmjqkloiBKj+DUYy/gKnfQOj32RUPL/j8A56AxDdsm6Mu
 OSzamhv+dTqSTbjxlYijVn4h038lsTfEI7Zw2TtrieMjtRB2Wj+UmhgPyQUXiqFQfewl
 Wo1X2wYNGUtKxJ23fIDrpmyVGnTZF7CL0qfUNIkQNDDhWs0p7Q/NQVQGgX2yHDUpNDk/
 YMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430025; x=1784034825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gqx3pTa8d74O/aUOvJClkkM0PH73BWXonrGG6zGJlxI=;
 b=B4/7kTpEyC5D6ozwutW8EnIlGZoUTUU0cpupOyFPr/hE84gMk/38ut1P9csMKWYRNu
 MNQMPQ3m2gEMIDOf8MI9JG4K9eJarERm4DdVh4Unn9SlNgUyqlSJHAlY6qmCxWYlVARJ
 fzYZA7D6pmBV3TRjDtPYm9EjpOmV26aoOe+HGhMQe7UY0g7oQk6ekobveKzcCSDKjOc1
 1I8WSqacL1sEeqVWMDHPrZ/OeZiGrZGLzYXLUV+nzwC6vq0WwD7gPgf23SrQ4fVTJZPR
 Vsl8P/x6DWLZbkNLCC5oZVnMWZjmrvxiLBTvjsyB1v8heDSTqUOrwlQEuqQl/EgCb4v6
 iQ5Q==
X-Gm-Message-State: AOJu0YwWOpAD+bNFHWGHBBMKWhaogs5C/D7FuOlCMxpybLpaRE9tXlwY
 u16quqhaVvyAmlWY+mQv/TYQepTJtWwK4PPhme7tA05NmKMH3PjEmgfeVm9zaNpxZEOmZGgDgY3
 mD8yNTKDA54ZbI2RyuvhDIu3ik6l+CFG5D6s0sDqW7SWp/f4KSU1Kbv24VlP46YvENA==
X-Gm-Gg: AfdE7cken4pjLmBZMjTwOuGeAgD8vKXufsTr8T7fCIgwPEqiwL7EvVk3QaU9JU+BGqJ
 yxGyXo5+YErwq6RBTIp0efjsDTSZBmL4mm0EYlsb3S4NkcrpQ32OMT8JaK5+MnaT3g0ajzYClUS
 8XtGsegU4F8F0k5CdpcxZOEqg0UukkUk8Q+Te2n84WsYSNi1rx2t/8Tbg584PVxyQSfyxwvEnu7
 P47EnfKTGLq9d0TwnT8yXvlUVoCAYkf2atnlngVnm7DyRgPn4oYM/jYHckLEYAdb0ZroMEyWqV/
 ZtMAAJQ2d+b6koTLT84K5x69x4Kp3DD04VSyXS/xSG4oysknTtwXpEFHPnMCldogBfIaYqqQQbE
 GTsDGQ6yunB0QxR5b9aAyniH8roQ8X0ZnWj6RbJz5rwAYGZmuKxrXhRBz4b6Ofm5HPreC
X-Received: by 2002:a05:622a:1e1b:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-51c7a751ab6mr25609171cf.22.1783430023588; 
 Tue, 07 Jul 2026 06:13:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1e1b:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-51c7a751ab6mr25608721cf.22.1783430023023; 
 Tue, 07 Jul 2026 06:13:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9b9ea4sm134603166b.38.2026.07.07.06.13.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] hw/net: fix e1000e/igb ip_len inflation by Ethernet
 minimum-frame padding
Date: Tue,  7 Jul 2026 15:12:01 +0200
Message-ID: <20260707131223.51505-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX9yfjzSWc14Xv
 pdON72LPGPIerZH9ILXKU95sDs6Ya0efIU5WL9NB8NdvKmVSmqClZMPIYmqloMlpYxYJmNf10Wu
 IvVicyobL5OD7121Tefng4ti/m/tjqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX3FI68ZwfKK0w
 kBGx1GYbE6ZHnQ7KMYAltvV6tMVOpfYLS81QyDL2TdVHdyLR/zucI7WD7foHhPa2wxfNNbjoRCG
 N5BW+ETfOknlOrvsnDz/j12XZFN8tl57D0VLd8hMzNn/pHNuykm6AE++GGG/ygb4T9mDQA35xnA
 mpz1+9mi1P1kVApSV2B/Q4jeeBEkxXw4fSyQV7LDVwdLd+05X28EWHriWlpuShvKL3yXLNiCA0S
 pT3NfFnTN0k0XRV84KssjTEBbwCazb/OSikCbOyI0EfX9fu/ZeTc6vtR4ZbGQkSRzEBVuHgMdw8
 NQqGuWy/AhUtx0Rno3yLFKHcrGWXix9+YjwpiCjAFauVFYHhouQQY/iqONK8hUR5JzBfSTW76SA
 8E43Fi1VVeWzPQrUWxjPlt5FxHzXStJ5q+1luY9zinApUtv1TuX5wCCmwsNImoD2U3mVC71EG4e
 D8FtSeID5Z9DZGVjuSQ==
X-Proofpoint-GUID: OHKF0dY1kibtlnJEfTUnHdzxPKVC8wCL
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cfb89 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-DT0iAkgnNDEg5C8mEQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: OHKF0dY1kibtlnJEfTUnHdzxPKVC8wCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>

When a guest transmits a short Ethernet frame, iov_size() returns the
padded wire length including any bytes added to reach the Ethernet
minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
this inflated size as payload_len.  net_tx_pkt_update_ip_hdr_checksum()
then overwrites the IPv4 Total Length field with payload_len +
l3_hdr_len, inflating it by the padding.  The receiver interprets
Ethernet padding as IP payload, producing a malformed packet.

Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksum()
so it only recomputes the checksum, and moving the ip_len assignment
into net_tx_pkt_update_ip_checksums() where it is only performed for
TSO (where ip_len must be derived from payload_len since the guest sets
ip_len=0 per Intel 82574 datasheet §7.3.4 for super-packets the host
will segment).

Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()
from their IXSM paths, so both are corrected by this single common-
layer change.

Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Reivewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/net_tx_pkt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca24..b134348fe80 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -93,9 +93,6 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt)
     uint16_t csum;
     assert(pkt);
 
-    pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
-        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
-
     pkt->l3_hdr.ip.ip_sum = 0;
     csum = net_raw_checksum(pkt->l3_hdr.octets,
         pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
@@ -117,7 +114,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
 
     if (gso_type == VIRTIO_NET_HDR_GSO_TCPV4 ||
         gso_type == VIRTIO_NET_HDR_GSO_UDP) {
-        /* Calculate IP header checksum */
+        /* Set ip_len and calculate IP header checksum */
+        pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
+            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
         net_tx_pkt_update_ip_hdr_checksum(pkt);
 
         /* Calculate IP pseudo header checksum */
-- 
2.53.0


