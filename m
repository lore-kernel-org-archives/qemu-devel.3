Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C21C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7th-00062o-Kz; Tue, 21 Jul 2026 06:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tg-00062N-E3
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7te-00035J-Ud
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LAR5lL1349401
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CdgvIC3nQLcvLayxllfnEnjsQotCjZRtIT0d/i1oUJo=; b=MIzVXL5R1Q2YW2gn
 63s7AyiVZULuYaT9mp2V7ADc526vjQMm0xPJLxHJphVmXqeuwHDKaspkKvDJv6I4
 M43xWS53hNzqShtIK4eUansbqe3jEi31GE6YAixj1siMaNM+LPBlLA6DA9PwgvH2
 rv8DTJInhB6u6pVfdAxLHI/7BqfPfF1IXblt+1beKJFKab69bsvEAR8uYTv/hgvY
 u1tIWkvXTqv1loGAY152/qyB9BCthLQoJLvXXooVyx0PHdLX5TNeaj62qicyufng
 0oLOGXHHqkFopfaIblAJP4vT7JUqrmxEPPcPFb8UPDxYj22IWI2tnjSqj1rt3ahB
 ECZIZA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6pa84vg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso219526431cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630421; x=1785235221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CdgvIC3nQLcvLayxllfnEnjsQotCjZRtIT0d/i1oUJo=;
 b=MSk0AQjJqk0w3rOhZy51xiUPCjNRwQ9kLchAaiBT3Fh0qRlqxqH/NCyVWojJ8vWQk5
 6V2XaIZ5pM6Fjc8ipcZ95gMgjYK8hNhsp+SfHDsaQrc65n7Oc/o1veYDpCxv3HRX1HP5
 yykjkQ/po2lbp9KDLQZlaloUqb8qfMe4QwZ/rN2reLjjdffD0usUmq3TJ6abU7eXKwVa
 OoxqA1b+HsubS1Xm8fdIQkU6Y9+pBgV+aEoadIhvjw0Las+ncRiqtNucsl2itamN8p2b
 WvoCJ29o6+/lOHo2k51MZvPbGyWmmsY4CURi/9Bw0vLNCB/N9aXmnvPmorShyU+JgLiU
 gR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630421; x=1785235221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CdgvIC3nQLcvLayxllfnEnjsQotCjZRtIT0d/i1oUJo=;
 b=fB4LgrtEwUXdtCUboBJmGpHAndNn0ksh11gdyDG6oAlgkFSGGfusmE325BQ68n1j5E
 Grv2ZvfLNlaY1WGgnnmtVHlehvubZjNeGsbkSv8W8enlIytFriz6cpRmQ0ip38bV3y+S
 KLhB033zKtkEa7Ka/OqZoF4iitdGmH2QFaETpf4QBel6J+FkMP7rrs+ADFjIfiEQ24Ar
 9HvCa/mjkVaPvNJhS+R0LZNIxaOn8eBtG8Q5Mip98EesfYjr68MLFThgdfs3grhsn9kO
 O8AGZrBEOg4LO7EKhOZplKwJL+Nn14VYXUMP+6C+Y2r7w+f9OHVp3DO/Xpnynz5DyHxA
 i42A==
X-Gm-Message-State: AOJu0YwK5z2rRETjZ6+xiNXZKlYzUOgHA0i6hLcX2gNIhmv+MHg1Yxbi
 SCuRbGWAjS/Hi2ij/2yhKZLurD0RwLdhQiS4fM1c+hhyMhQl6VxMH3dUQRLFOr8d+cVogn09LAX
 bMRwvpQLxMpY3Dl6xsq0jJIKvEJoTE2kCIlHwOCW4B7stHcIWz22ednGlr9Gkfhp5GQ==
X-Gm-Gg: AfdE7cl3HiT/FK4NPsdDzt5JDfj3XjHOqnpEDILDGH3rmgeQ/SUfXmJpsU6PfC23Y7H
 fQ47cmWX0+EVBA4zMz8BvrLKe8nAOp6GFe0pcntLHoGR6UkDdhpFiV6qTEwGS75CGSr1pzxK+8J
 a3nf9CV5X1/pDNe6trl0MsO2ZE2EyLza+x5NWDnS1DMy3J98vcGakFVXgd08kaCBDFzWMpay0lR
 sSOCRDuFuGyzWtOU3QKDV+heXbBcYwMaHZGXmMEojsmFtZrchmoHTDHMqGHWICfryUw9Cca0LvA
 B58V6Mdh0uJtHBZgC9i5hN0rCQ7HXOiCJZNHk7g3QSK5gRsIGTRosGrPqqYhCTaNfBTIZ9Lhg6d
 gfsqYDtVd19XVi+vrLUbfJP9rUbMpvvuRKxGNxbbXqCLZxOxsKi0T6H9gsw==
X-Received: by 2002:ac8:5706:0:b0:51c:1a4c:3c9f with SMTP id
 d75a77b69052e-5213c007406mr163307391cf.4.1784630421226; 
 Tue, 21 Jul 2026 03:40:21 -0700 (PDT)
X-Received: by 2002:ac8:5706:0:b0:51c:1a4c:3c9f with SMTP id
 d75a77b69052e-5213c007406mr163307151cf.4.1784630420744; 
 Tue, 21 Jul 2026 03:40:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm39213499f8f.24.2026.07.21.03.40.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] hw/display/qxl: validate monitors_config heads[] in
 phys2virt
Date: Tue, 21 Jul 2026 12:39:57 +0200
Message-ID: <20260721104004.84934-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KMyYFEJqxIkDQIbLeTgsYJHMFWu-Fybh
X-Proofpoint-ORIG-GUID: KMyYFEJqxIkDQIbLeTgsYJHMFWu-Fybh
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5f4c95 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=UO_m0OBs-Tm0aSID5pMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX1VBEGccV3pSE
 ajbGgZJqw9ng9g4g5f+Tg+XQ/rz/oyEaAI6ig1+r2YLo7PK6zJ4OQPNn/qolAJMPXOjNc4psbGG
 SwWPoh8s0O8nSPXVWzJ97IXjhHoWStm9DsRZRdmoT0p44+OR+C18MnueH00/0VmhiAzIAHveAPg
 hd6eRLjSjROtl+/y/cXJtJMzH90ejVg0un8nrtHNZtarHin3EOwfB5hBojst5fEZMwc/ocjGTOk
 HDOk05Wko2HyEfmUzXjYuugu/ccoh6Ep1k8hqPI4v6zO9DbpiUnPhJ0ntB1qsSJEsOm4S9YmSX3
 Aq3gn9lkDeVKL8eTr8/YnleJo9pWh1ZINd7LM8M/wYpXal3JoI/BSJ3XDsWVUzZyqhZIhO5MBRO
 lsFWfF499UHRXDwotnf2vApYjkohxS4PF473FFe2KWBjezabHBfiBcyQvQLCo6aMhA9WbMrx17A
 a+gpOmQg7oTlfZ70pHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX/S8w+NO2uJji
 kECZ8gUWLw/6u2J0d/kwV6XsKmpzrhGup0AchkH8SVJvgqQ7DaN/UmOTKj0SD3IN5opVCCJxS25
 57ZIxabXtmaJLr/cMtDBC0chdZi9r6Q=
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The qxl_phys2virt() call for guest_monitors_config only validates
sizeof(QXLMonitorsConfig), which covers the fixed header (count and
max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
buffer size to qxl_phys2virt()"), but not the flexible array member
heads[]. When count == 1, heads[0] is accessed without its memory being
validated, allowing a guest to cause an out-of-bounds read.

Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
the first head entry is validated within the guest memory slot, preventing
guest-visible memory reading.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
Reported-by: Tristan @TristanInSec
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 74258afa582..3df796175c2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -270,7 +270,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
     }
 
     cfg = qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP_GUEST,
-                        sizeof(QXLMonitorsConfig));
+                        sizeof(QXLMonitorsConfig) + sizeof(QXLHead));
     if (cfg != NULL && cfg->count == 1) {
         qxl->guest_primary.resized = 1;
         qxl->guest_head0_width  = cfg->heads[0].width;
-- 
2.53.0


