Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349B4C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bW-0000U0-UM; Tue, 07 Jul 2026 09:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bV-0000OX-Jl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bT-0000QE-Ly
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9c6D3619376
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9iSCTsvy/zYaI+hiohs4sGwpOHbQL3Yw+cTcIjQawcQ=; b=lxE3zYXFYMAuTPe5
 UXgGzxt3s7ovBadbSH/pVTH5FFEaOYv934aVyq+nVyZC44Ff53YOtlcdr2cEM2mA
 nUR+cRHvwfPeQ2oLDpQSyxCDaMtv2YGpvy6UMoU0E2K0xei6DAw/1c4/sneQYUKd
 QFDwRKjCxqojd86D0+LS9lLmAdTgVKYU6X004qkq2c5pmIlDP6VPDzpCZ85eCd/T
 SO5myumtrd028BicPJKL/F5v/YgVceUZZ+xDSKQF2tAWYcMOtXaEjX2VODu2hF//
 kev3RQWea7FqRxEpTyO7VzPY5nqaxHTGje7Q7ZnxgTthG+XTB4alJUIW9a2wOstB
 MLgwPQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun1de9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:12:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso8359221cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429965; x=1784034765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9iSCTsvy/zYaI+hiohs4sGwpOHbQL3Yw+cTcIjQawcQ=;
 b=eGujGMQaTWzmI1XaPuvY4PomeqrWQYLnhGr4miuifx9s72Llg9E9UAWpsTuKHX3k39
 TA3pLtrz4dWAXGgaNV+vIu3ZtW07GqIqNlMTBIk/Zji82MFnU8a0Lu9UIhdfSaOah199
 S7TfgO3Hz4zWPuHe2oNz6FW079K4ABqajmx8yZcFsZcvLRvzLh9uPZnB0zwaIhdXpvef
 /GxiQaw7odsUl696dibU6Cds6j+3lZ/SezyN4DD4u4pge0/3YZelfmWHsFhzuuYaf2Gt
 XzOJka4FJqm81sltdTtUM3nR3HITGPuZ2g2pAkNQKCnLt+H/TG7lnF+NRaxJNpS6jP5f
 XBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429965; x=1784034765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9iSCTsvy/zYaI+hiohs4sGwpOHbQL3Yw+cTcIjQawcQ=;
 b=Q5JnsOo4367bhmHAxuYI5x4pWLao0+FV3TaiLKAeFgU/Aglni994QzvVTO6j6jDi4X
 lQ4rMpU0/LPsNPd2Vg1PnesgAllM2iqeY6N+3MgFNUG0Ip2l7UykEn/YXml1WCn98u71
 MF80lSVkidVEv2H09wugh412jhCl6zSMjF9W1AfbeDxJU3NY/zcjw/YoHplhAfQFzKFF
 u2tphXGQYAJqqABetX6+IK4++ukbBElmVhIz7r3AIPDaYH+AYUw96BQMvWRDrs07V84O
 qbfzeDYi+kTuRym2lJQ1pt4ZYSN42GcqUZ/OkqdqUJuZdmd7riBYkpfLKISeZWrxTxnb
 ZGNg==
X-Gm-Message-State: AOJu0YwqrjgDsmOb1ftFfIdCZexwRyKgRcBoCH+e1/51bWL5jMY21Fsw
 Xb7EkNaL1rnTAyDdXlChceJ5rsAvpdMnMn0Wiiy7fCe6iAWcO3vZ6F0MWF0okWsOqZvK8NaFrYw
 lCH2dM94lqzBX4RX0/NY5SL/M/FM7MPx7O2R8wkNOfRTonbeaTSlHsBNvb6keOpgC5A==
X-Gm-Gg: AfdE7cl1fg6SI45/jqebZeUxlvmt3eehMDrlwSM5VdR2Rj884+DF+RfKwhj3kt7qA8m
 aG8coLz3olN8c3xVBaNmMwObXlHM/Fv7cNjGsaWrPC79iXpkDL304aMTFit6PRPyNFUc4UPQJZJ
 59BXKAzAjy69X5eoAhSiYrfmZ7T4wa0Grm6zFsLwOub+dNmrjPrLPml/2mL6b0OgPx1k6W8Uo6U
 vbDnOe8scOE9fWv9tVx284dm5n+XwxdbeEya+LXrERC7lFWq9nMqr9e0asmXk4ZjQAV+6ZvWV8R
 jSKqxSkZrYjGZ55e+pZH2m8xX0W9Nc0s2sV2YW535aIyjFbr1d+k/O2B9xwPrnFMqv6gMqNx4Sd
 XnHNXNHT5HcEhAUq5kl0uI97dcvpV0lmeYQXXioVeq3bdRtlrtNl5QLo3KAMuxk7M+nmb
X-Received: by 2002:a05:622a:418a:b0:51c:86b:3487 with SMTP id
 d75a77b69052e-51c7a773ec0mr27854491cf.33.1783429959854; 
 Tue, 07 Jul 2026 06:12:39 -0700 (PDT)
X-Received: by 2002:a05:622a:418a:b0:51c:86b:3487 with SMTP id
 d75a77b69052e-51c7a773ec0mr27853891cf.33.1783429959217; 
 Tue, 07 Jul 2026 06:12:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a3652a02asm5045158a12.11.2026.07.07.06.12.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:12:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] hw/display/ati: reset host_data.next in write handler
 after flush
Date: Tue,  7 Jul 2026 15:11:52 +0200
Message-ID: <20260707131223.51505-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX0uFVYGLhVQ/g
 zugVi+HTAKhdFcPuEKN6SSgW5HlS+r4rDRDw2ot82tMQRrWCJx5KO8cW9mU3Ef3wL8oDQ6M8fIJ
 qD9FqJu7m6E7UB052yQQgbbEdlV8w8Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX3V/aYq4pXgqz
 WC/L/aDt26myc0wIuZn7TmESVpERNpb4vSwYGYFku5BfaU95gkkg+ohbypou4t/VTRwyIab0jCX
 Gecux7k/WCfs97Xbuu273xrw+56JYAQM8z1OvEMD1XpaVLyLxf+/Qi6Yk5GmtrzC0B54YXTcT5x
 Y8GWhmL4Sj88ETLAwiZj13oPUB+CGPzTqHEdJ1KHV3Dc19oOBLqEQPy2Q8d4SA/g5brJuTb6RpC
 3ytz+VpbNZutbr++cPxxHvZ16zoY/e8MlCiSA/Ws42I0kHCadCht5+MAPUNZZaFC8vkIXbvu4OB
 ckxVBrA7msihW8H3lZmsCd60FmaknUHU06IVGHOva/OohzMwlwe5S30jTBY2jTEKw/cMezpfQXP
 5DmYkdx3lCJnfcZkd3LqwJatUk/4i2X/l+TShGEviNrTAWLDJFcUKeQmgEgKnUGhXcgR/vVXsMM
 hD+8pB/t4PoaR5BNqOQ==
X-Proofpoint-GUID: ezzzceCfSzY0h1XUptzGCVISuj-OAuHQ
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cfb4d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=69wJf7TsAAAA:8 a=57R0qBCtAAAA:8
 a=EUspDBNiAAAA:8 a=0hMSH2Hfg6KUgAemlSAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=mR_gFduoMj4eUoa7Ntlv:22
X-Proofpoint-ORIG-GUID: ezzzceCfSzY0h1XUptzGCVISuj-OAuHQ
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

From: Junjie Cao <junjie.cao@intel.com>

ati_host_data_flush() resets host_data.next only on its success path.
When it returns early (unsupported bpp, direction, src_source, or
src_datatype), next remains stale at >= 4. The next HOST_DATA write
then stores a guest-controlled dword at acc[4+], overflowing the
4-element accumulator array.

Fix this by resetting next unconditionally in the write handler after
calling ati_host_data_flush() or ati_host_data_finish(), and removing
the reset from inside ati_host_data_flush(). This ensures the write
handler owns the full lifecycle of the accumulator index regardless of
flush success or failure.

Cc: qemu-stable@nongnu.org
Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://lore.kernel.org/qemu-devel/Czyl6yVfL6sHl_o1kRk8N_LpwXMMRVhO9vgz1qCVJFagn9D4nHSKuiux39iOLty0Q3acxQq_FeovPhTQvSKus2htwjI9lTajLZmqovr0Wxs=@proton.me/
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <20260519023937.439077-2-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/ati.c    | 2 ++
 hw/display/ati_2d.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d77589df67a..db7e08a462a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1034,8 +1034,10 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->host_data.acc[s->host_data.next++] = data;
         if (addr == HOST_DATA_LAST) {
             ati_host_data_finish(s);
+            s->host_data.next = 0;
         } else if (s->host_data.next >= 4) {
             ati_host_data_flush(s);
+            s->host_data.next = 0;
         }
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 48498677c7e..8ef82bb87fd 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -452,7 +452,6 @@ bool ati_host_data_flush(ATIVGAState *s)
     }
 
     /* Track state of the overall blit for use by the next flush */
-    s->host_data.next = 0;
     s->host_data.row = row;
     s->host_data.col = col;
     if (s->host_data.row >= ctx.dst.height) {
-- 
2.53.0


