Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3254BC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAm-0004et-KY; Sun, 16 Aug 2026 10:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAH-0004HD-KF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAE-0000wa-9q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkkFD3609380
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mJ52XJEm/Ufrioi10sFwL6GNYhnPWGnTfcMAWm7npzw=; b=HZpowZd8psKDf4Ws
 pMVaUphwlYVjhTzKzkfNNeIlJFzPS1q+gF1im4b06GfAPg45h5r0Ba3pU2oTLFDb
 PFK90QS8AJmygU3v9Sen4Cpq3WgN5J5NH0jwO8cRLXc8feM9krlfvd13RXIWAf5u
 7ZBbllU9TESWyzZ/vDPdYD4B8H1Yqhm8OqdvPaj0c8UGIGoD7D+/xF34jPNYZTOI
 cePqitKI9AjIv1f7+hJWUsGIuw+LOatIFZC4Ls9hjJpPt4zDegfG23D0b87FwnQF
 wfdzDhNlQqdzX+yJ2zmPavCBKEbB6vIhz5uFlZqRFACexWtwFFWiiH3MoLEh2ThR
 eeLHqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfuk22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936cadb0e8bso220330085a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891718; x=1787496518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJ52XJEm/Ufrioi10sFwL6GNYhnPWGnTfcMAWm7npzw=;
 b=eVIT0LRKk9VVQRG013TwmhlSXbK2hl+lEic3xdcRnBh8atqa8VpistW0K5DbbsMAgk
 a/t//nzEBVDN1UDQhzdD08r4Hwk+K9tGeHPl6vegvMuFKsFm21kMQYLSPjRNeSK40Zrf
 d/+4AwoFUZamoswrV1n1DCw06GJkkwNkCSscTOBBYnBMQgugOBPi9wJ6B0F/ShzAt3Fl
 fWcz7XBApi7GpQXzQCutqdWCGXBk1evwGS92/pAtOmmNLaHu/gIkmOjAj2Zfy1us/7qa
 zckX0Y1amjfP2ijAQ63Jhfwp1RW1btCVoUPh+Vx577gvagZV9yzBG9zSsx4zG0viISO0
 1jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891718; x=1787496518;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mJ52XJEm/Ufrioi10sFwL6GNYhnPWGnTfcMAWm7npzw=;
 b=HA/F/LcCR9N9TFToRasoDnxIoUIiSDRX5X1gZqri/0ZDOmbkMq3DhJwdwWqxEf1W3Z
 QzMqskbYFhwtKHUR5ad5jhjoVKrZAG4/EKc5eY/8IFf14QwwokMBtzW6ngt88kXGmoeK
 PN4VbpO1gs2JN2YYEP+D8ngd2cYlNODEjfH4+++icg6TshT+UEfaVV4XsX8YiwjuWwYp
 +j70k7+Iee5Rrcu5M9K8uZMm9SZFO43NKm6BUEoKaTqh12Fs+ilZbI+KwTwf5GuPPRbI
 ny1zB6JLNNX98R4qfpdG1GWe6c2PloHgnOJopUFNIsGdfx6G3w4pFy7FsRk72jJJabMj
 HK1A==
X-Gm-Message-State: AOJu0Yx8M18BdExrT56Cn1c2LGez/hQ856BRMivuE6w/JHLzu2I7G2D+
 tClyMYxa2WG4TI27E/FvWFKSNdmhRNFRzOBwsaBalOlkIuRfbgdzhpxM214P3+sCp2AaEHsmX+T
 luv6RMjljEwYrb7tKJkAiywDWo8/EKS/7dV6mSNs/ynlC85HQrdzvvdhjWrGdNuNbiQ==
X-Gm-Gg: AR+sD11gt8PwfwVxyy9glAZ1JB6dxnR1iAXreugBQGwHXEQnL+AGzrC7zEJItgDFaYX
 oipm99+q7+cu3NjkeV1pU1bG+TeuyVD/ZPa/+NDJZB2L0HE9soin48GUS/vW9jTpXK/g49gle6g
 DlR8pWQn6bKK0+DnUv5Tl9GfD5UqQccaZiRrc5mQw5kyF+DfR9+NM28Bd68e6nemRXcF8jqUkmp
 2iP6vYnNtsS8NMwzVjH6S+x5YnxK8FrOFdZeAmhvyRNfECRjZAwtpKQEFKE/RFS9TxGRTPW+1Ot
 wgV+etCUt9jrxkqvQFDIpKQ3wXAZk0MqtFtAIBNwkfhWQG8oISkM51IeIq2D4UZZ4EztN4KZYu3
 GsAbF9hG811TM/UZ0k4949umLfqmkxgSL0yCUMf2q1g==
X-Received: by 2002:a05:620a:2941:b0:936:7a4e:db1 with SMTP id
 af79cd13be357-936d22e985amr1944916385a.23.1786891717778; 
 Sun, 16 Aug 2026 07:48:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2941:b0:936:7a4e:db1 with SMTP id
 af79cd13be357-936d22e985amr1944911585a.23.1786891717085; 
 Sun, 16 Aug 2026 07:48:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996108141sm46894005e9.6.2026.08.16.07.48.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/56] hw/block/pflash_cfi01: Restore ROMD mode after migration
Date: Sun, 16 Aug 2026 16:45:18 +0200
Message-ID: <20260816144556.69009-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX6ScCrEoqOO44
 wCdNqiHbx8aHDkzbiDrH3R5DZNv5xJAX0cdrKHbgjhAatlDLrH8CRKz067wktSja84Vwph4UzI/
 hzFbmkXqnAa3lzPLF2AMsF8EKXVuCgU=
X-Proofpoint-ORIG-GUID: wlDgjguj5PzaMOMh3gxYtvnAqE9HaneI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXxVdYFWzO2yfG
 tD2ZDI97OR7uouHczb1MXifDZpE4wW16H6dcYDDo9Pt4NaDe2A24HL+jCG7EyKtOOTG6qBHHzWQ
 +urRUtOYViXTUo9z8+dXe4P7uUjEnHpZ5fseJXniJdMssE3UsJ0LO3bTUoNTkY0F5VmwhBweZoo
 TAUMNimYb01Ystr55PtO0tn1zUvu/NZeGueZrtG/YpRxACgNOv1by254/Ls6gMBqZcn45XoLUgQ
 cZ5mpRsqurq9aEfgyeGMlGSkqgoA0zB8k3tDUHhgFDI1TASxL05e6rMu5nyjAdTCHGz0rRuM3tq
 Z2L8WiAHyCEmZ3LLhl7P+7SbCaMgNo+bHe+OR3nBhC/duYquy2RgjKGmWXAUC18QgGUXskDfxZA
 989z6nx1J2523ohmzOYA9C7Zzhp+lY0fRY4eyy4OQZLoA/ybjkVBY01eCi7EPd5jMLiM32pD/U0
 T0wYTLMHKQ6ZfcnUkKQ==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a81cdc6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ri07d896u8T7sB93P0wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wlDgjguj5PzaMOMh3gxYtvnAqE9HaneI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

From: Bin Guo <guobin@linux.alibaba.com>

pflash_post_load() did not restore the ROMD mode of the memory region.
Although cmd and wcycle are migrated, the destination retains the
default ROMD = true from realize.  When the source was in a non-array
mode (e.g. ID read, cmd = 0x90), reads on the destination bypass
pflash_read() via the ROM fast path and return raw storage bytes
instead of the command-specific response.

Derive ROMD from the migrated cmd/wcycle in pflash_post_load.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4042
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMD: Including review comments from
 https://lore.kernel.org/qemu-devel/CAFEAcA-P6RH7nJK0KQ1H8576ULFA7nocB0EkhhZf6Rw3g0WCag@mail.gmail.com/

 Confirming that this is correct is a bit tricky. It relies on:
  * when we set romd mode to true we also set wcycle = 0, cmd = 0
    (which we do, in reset and in the mode_read_array code)
  * when we set romd mode to false at the top of pflash_write(),
    all paths out of that function either go through the
    mode_read_array path, or else update pfl->cmd to something
    non-zero
  * nowhere outside pflash_write() udpates cmd or wcycle except
    for the "clear them to 0 and set romd mode" places

 This is almost but not quite true. In pflash_read(), the default
 case for the pfl->cmd switch sets wcycle = 0 cmd = 0 but doesn't
 change the romd state. Luckily the "this should never happen"
 comment is true -- there's no way to get a pfl->cmd that falls
 into the default (except for being deliberately fed a bogus value
 via inbound migration).
]
Message-ID: <20260803041808.58174-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 5b9ddb20b18..a13b91967ed 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1030,6 +1030,16 @@ static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI01 *pfl = opaque;
 
+    /*
+     * ROMD mode is not in the VMState; derive it from the migrated
+     * cmd and wcycle.  Only (wcycle == 0, cmd == 0x00) is read-array.
+     */
+    if (pfl->wcycle == 0 && pfl->cmd == 0x00) {
+        memory_region_rom_device_set_romd(&pfl->mem, true);
+    } else {
+        memory_region_rom_device_set_romd(&pfl->mem, false);
+    }
+
     if (!pfl->ro) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                         pfl);
-- 
2.53.0


