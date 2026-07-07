Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bw-0000iU-Fv; Tue, 07 Jul 2026 09:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bg-0000bT-Nd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5be-0000Qg-4O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C97BR3590276
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pmyT0UMNc39CbCJMKFwO9TA6QUU+tGeAZaBKfSjnQGc=; b=JU/S7iLMkA88YhRM
 9+exTkxxoaE44snvACIHvjxxr8IhwbHHlWedlfuAC5zsrXHTft1n0nco4DeWIDGR
 sO4Oa7jfnpyKG7WieQPBivp9HhTHFHn597HYlH5hrGrftMUB9RKTu8vlQNgStVxd
 3+XIVpetIYgngLHORknj10CgGyvJ6IjfZO3RnCiy5ECeWRdmaeGEqO3bBW/CZvjn
 rpN7kzrXT5HQ7NKN4SHT8wK7RaEt0JWyvS99vTgqpvg6YojKuAXQ6iVwJWIgOEV2
 RhEl3Fe5UJCnQElTbRXDppUYFFimAejt8IK6f1Ey6oTDHdS6Uvex9qLSAvDQLPL9
 8sSlOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9bdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:12:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e63df032bso61070585a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429974; x=1784034774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pmyT0UMNc39CbCJMKFwO9TA6QUU+tGeAZaBKfSjnQGc=;
 b=JRLE1qnvMU4eBgMYhBSmy2C+43PAwDtkDOppKfP1A8xQYA1L4Qz984LVvJMD1D4UoA
 dktUPxOAHcEiCefdvJAX/7fvQ9tB+0oIuxE3q3ls7o8ZE4JdD2r2c1JmgZQsrxsHEQc1
 iPkDUNPtIyVJj2mq/8QnXBLfFLYWPjLRtb0xIDHyDuIzRLk23r0eXWLIlzmIlixwJpFP
 JgAoeLPlN0XBwiqBjPHKP4X4zid5qzy8s2nwNV9K1m5P7uGLoYDC9mNbJzJ5q8CzrhOH
 b8hhBIQqwbCeZW8tfEfY61A79NIXvwGBtVBepuV/3O1Mbgu3qKk3j5j+bWcwzNzV1YeM
 eQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429974; x=1784034774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pmyT0UMNc39CbCJMKFwO9TA6QUU+tGeAZaBKfSjnQGc=;
 b=iGxQ+wClaFz5E5mbORj2T+1Rw3INIHP+yHDYTB8scR72IICL1WZlcVU/SIDPjmuFwy
 y55NNSCWRdxIdJ8ZMvCOHmYUNa+naqHwTfaAyFyrOYw1DnO8Jb8l0aD6PdGOjwQcUzwL
 A0dyXGwH8eGWc6DpgD+9PiiLr+OBrkO7Jgh8Q3ZkatO1d5B2o8MSWppOj/XUFXMlH+Qr
 127IJY95szyL8poHY5GUWuLQIYuqGOs1u/vIISbgEkq5Ru5SNK99odGChaP0ie+bbtjn
 Iw8nPypKcpUg3LOLkeYIlF831dwQSfm0OkFWsAwfBmnUQlIREU+RD2XkuICJ8WG+XTVb
 YODg==
X-Gm-Message-State: AOJu0YwtFWatEwj6MwIiXzwYGvGU45BmJUQUlRjZE+o9Jz0vohSKmvqw
 NAh0Mfm29a8tbl8tDiLysukhT0MzSXytpIskD+4FuZPFQYo5IW3hbIMjnb0Iy/QHh4aWnWcXptm
 TNSI9FbEJ+JfmWOwTXXFKE2EejGPS5L40EioRlcUCtB4RguTpUplp8NLp/DfEFTLu9w==
X-Gm-Gg: AfdE7cmBeneRBvmNA3cFzQSyo7NzCtgtsyql9KuQmHUKL1g/w5+KC4fUocl6xAkswAm
 UEaukaQna1lbd2Rg/MMVaNGdQYIxqPTnkFgctg2uh0v29cPeezdHTgrab2qPb7uccBRhCXVnhAa
 5jVyEP7rTOK0oc1Nb3Us32Qy4huJNtkN6bSD+1oR/l+XF2w+uArsVTdpFDp5dFzyWwXZfSQMzX+
 tWBj5xZf1YqMcgrORTAvFbZg4/xs1td0njQuNpw105vebhuk6Ar5/8k+q44RNBW1a4zLEImyWL6
 SXIAE+J9+jkKLDEnTrOk+Pw0Lx8sfFACIv3MZTgN69OxlG20j2PHKjzinlBTKCeOE+hRu5EqR18
 2MkQOgv1we90IYtG+q3QfgdH0PGGpBA2Tilw9j/82LAphQHfU4zInpV39HX6ak7EcCnpJ
X-Received: by 2002:a05:622a:1352:b0:517:9407:5c38 with SMTP id
 d75a77b69052e-51c7a7516a5mr24572721cf.24.1783429974019; 
 Tue, 07 Jul 2026 06:12:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1352:b0:517:9407:5c38 with SMTP id
 d75a77b69052e-51c7a7516a5mr24572201cf.24.1783429973337; 
 Tue, 07 Jul 2026 06:12:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada036efsm133177666b.45.2026.07.07.06.12.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:12:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] hw/ide/ahci: cancel in-flight buffered reads on command
 engine restart
Date: Tue,  7 Jul 2026 15:11:54 +0200
Message-ID: <20260707131223.51505-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX+r5chnLctXBP
 O9eFEunsvi0tg4/As5KXDWbGzbe+gSMP+Wpi/IKoX67GEqJ9M5YO0kZWOi9oWr9XAbujSFtMLTf
 NRGhRjmjActiaSz3lRFcsMkUCj3rQ3I=
X-Proofpoint-GUID: RbYGI-SE8WWFtowURJRfoWPsaHA5nsp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX82tB6anaxKru
 l7l3OoBrCrh6niJYBJSxHWmRHT0zK5VgG9j0w08OnP6FbbzhQUeDQTNzfLPoSX8sGxpXVcGHhPg
 169zyeuwcWi95GnMyYWNuOhHyL5lM2G6cq9zA6YBWS6KeShKkrhhWPKHqB8GL5DtjfALjUfBeEF
 QTSRoXVkm75Eck9wVjaxrqa99sW4nmefCAi5wEM0z8nJU4nlblL4k/uGym5mauM7L8zJFOEon2g
 948A5ElhMy3TI+YjT1P47Y27Ndw4jZh9RwlAvP7rtn2CSmfwLDTk21TGOhaz/qY5R6famRe2qoy
 77bgeKlMZ3QxfsJKLhqShyRe5lPujDeGZTyTLcrOawyEsZqbNiRZiAKz30Cdrpd3jlf0CwgsQOI
 fundNpPbx4x9/lHIT51JR6FTkveUtyw/2n0z/jO+NT1quUkSEZhSsjPBWvefrfTZd6qeBfE0PDq
 bW3C056XTeOZfk03xWQ==
X-Proofpoint-ORIG-GUID: RbYGI-SE8WWFtowURJRfoWPsaHA5nsp7
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cfb56 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=qsC6rtayLlhOkZH4ynoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070128
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

From: "Denis V. Lunev" <den@openvz.org>

ATAPI CD reads are issued through ide_buffered_readv()
(cd_read_sector() and ide_atapi_cmd_read_dma_cb() in hw/ide/atapi.c).
The PIO path discards the returned aiocb; the DMA path stores it in
s->bus->dma->aiocb.

A guest can stop and restart a port's command engine
(PxCMD.ST 1 -> 0 -> 1) while such a read is still in flight. Stopping
the engine unmaps the command list (ahci_unmap_clb_address()) and
restarting it re-maps the list and clears AHCIDevice.cur_cmd to NULL,
but nothing tears down the outstanding read. This path does not run
ide_reset(), so the drive's transfer state is preserved and the read
still completes. Its callbacks then dereference the stale or NULL
cur_cmd in the AHCI transfer helpers:

  PIO: cd_read_sector_cb() -> ide_atapi_cmd_reply_end() ->
       ide_transfer_start_norecurse() -> ahci_pio_transfer()

  DMA: ide_atapi_cmd_read_dma_cb() -> ahci_dma_rw_buf() ->
       ahci_populate_sglist()

Both crash with a NULL cur_cmd; the PIO variant has been seen in the
field.

Cancel the outstanding I/O when the command list is unmapped, reusing
ide_cancel_dma_sync() as the ATAPI DEVICE RESET command does. It runs
the completion callback with -ECANCELED (which tears down
s->bus->dma->aiocb for the DMA case) and orphans the buffered request,
so the eventual asynchronous completion is a no-op. Merely setting the
orphaned flag is not enough: it would leave s->bus->dma->aiocb pointing
at a freed aiocb that a later reset would cancel.

Fixes: 1d8c11d63154 ("ide: add support for IDEBufferedRequest")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260619112158.304782-2-den@openvz.org>
[PMD: Use ide_bus_active_if()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/ahci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c2b4432b947..749f0efa1d0 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -740,6 +740,9 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
 
 static void ahci_unmap_clb_address(AHCIDevice *ad)
 {
+    /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
+    ide_cancel_dma_sync(ide_bus_active_if(&ad->port));
+
     if (ad->lst == NULL) {
         trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
         return;
-- 
2.53.0


