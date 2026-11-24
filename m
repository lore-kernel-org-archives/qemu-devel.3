Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F5606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mwr5G0dR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SsScGS3G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzdu-00005x-RV; Tue, 24 Nov 2026 18:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdq-00005B-Ke
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdo-0004tX-QE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:38 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMameW3274463
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jEgjtKjEJ4sBVU94JZ7v4VmhSxWWRQKlw7vpgiN9DBg=; b=Mwr5G0dRMrmDHwRw
 P01j0Jds5uD+elQ5vExsEUt3cvDnLsB6v67opYWm20EcdyQzQe0n7VF+ID3eufCc
 NvJXS+NPvAWKtM/7vyFanwKzRsWe4rMxVgJ0HDmsgZC6qyb54DT7KsR+wjItOMc4
 1zoddn3KBw8PFUj/dOTYZIyn7aY5V74Oe77mh1E9Fogi4j2KIGafVhdn4Sq93Gaw
 Iaolzf5CD+XtETGVl9GfLSrYMuV6wIT/ZT7eIQgRudq5T/09thnG5XqVnKN1AJvi
 Pvk7CJUfg0fxLZbesUKgtUH2W9x+uiAAd7CX8n58H9Yuw4brmn/Oy5GEUnZtyHym
 gYZi8g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnf8pvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960bd17b5so836277385a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561775; x=1796166575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEgjtKjEJ4sBVU94JZ7v4VmhSxWWRQKlw7vpgiN9DBg=;
 b=SsScGS3GRAlL7t6KcpXkuFKgh5PIAZHZiMdrE4gVr3tmJMwTjr+Mi40dkD2d5r45u+
 0MEu6f1g1PZa76eb9e483E/3TAlLHZIppon8rdj+NYIKJKCcirXH/yywmv6XptXyBrOl
 6BDsZbI2tX+VfYGGHJ1TS+W5Y2HBt/bWU9yI4g4QPxu8tRIH9IA1vpVGZMDsN0jKLr2y
 3Nq0b8TwwukpN3TtZX3JAkhRnlItuBX1Td+7UCdm9Jfh/4MEAwbHQxnqwFGWrcctZhXf
 Kuv2P/G3G5ladau2f/6ojItcG/pKM1Uq/HvapQzySLKYU1rrMHjBLBaxZXD4YpR1NQ60
 gxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561775; x=1796166575;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jEgjtKjEJ4sBVU94JZ7v4VmhSxWWRQKlw7vpgiN9DBg=;
 b=vtyAGaxb77eVg2uM/4Hz7pyQBzhmYC4wFPeSDbwJNUam8pS9pX6f1ea9S79krpnLQZ
 +O4qR1Y3NxPfBQNEW9ZHhFfmkZQOGu5oV5uM7zi0KKj1VAcdEEw8Mum+JulUc8Ostjty
 iz1B3qDAEYJ4dAxgML5tq1EO86v44VWWjfE4xD0hORW5g+odNm5FVOFmots3gj+jlwCD
 H4wkKVkXytK/qiNsOFGRNlCJctXMs6NRx6eZ5Dfv0R5VROoSCbN1xTQXwd8RjrnBfIaj
 OfccqnEYyqwPB0QiRsu1sMMs1MRdVEDbmGwCY94g7+EZ0i033eMLeD7T3kv4OzRXaX0z
 0mZA==
X-Gm-Message-State: APuU4Z/BbLDpztrY2W5WqYliut+OiOG5u0za7rs3uvRbjj1lmW4RVUiN
 RuXDlvbDqRDLyNRaQKM695m/Hu4yGc8r6lIrvwFvNR7gTpPycs9uChRyq2qupgoTGAM0npdJ/cF
 iNJg79HFxYxy3Sd0/4DSxKRzg9M4bQcrGHxt9tkfh4oDq/dzYmMzfs8ivr/4nTrn/Cf/w
X-Gm-Gg: AZFdTZfRLV9kTbwJWlj40dIAyLF1FWl3WNQ+tfCLD6JGPZafTyBnCkzhZ1YmNEkj+us
 IjuOIcc0RLTvXPEIzAYUR03J1sa4ybqQw4elU1QoZaRaQgaoDSD7yuF4xbuff10oli2JSgKRzzL
 RMdjw4iWRrvqmaxQNifVWNZg2kdt5KxCtFOnj/b3NILf4LITcvJEQFyt3A0GHbfDF21yaDOycWU
 w5l82Xt8rSwLtB3Ix/DGUKpOwZSpoQ/zR1Tm/VC87ObD1dSplosIL+CEK3nLevIVoDmHEo5cMqL
 6SRe0JGgRr4TK9WDeVz2zz6+A0WJTgabliqQtEAmg0CSSb1exJJZmGlI2jB/14AfrVSnfbyU7hi
 NDm+vY1TvKj3MPkl9V4DhKdVOIozaeXTV2zNeu/wdIcmO2eDJ6iABpqqxxZJ1ZPkKlBsjIGPr2N
 vvXJSqoA0XM2mRiA==
X-Received: by 2002:a05:620a:1d0e:b0:949:6530:8170 with SMTP id
 af79cd13be357-949ba95dfb8mr2878501085a.16.1795561774693; 
 Tue, 24 Nov 2026 15:09:34 -0800 (PST)
X-Received: by 2002:a05:620a:1d0e:b0:949:6530:8170 with SMTP id
 af79cd13be357-949ba95dfb8mr2878496285a.16.1795561774147; 
 Tue, 24 Nov 2026 15:09:34 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b3415763f7sm10799946f8f.9.2026.11.24.15.09.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:09:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] hw/sd/sdcard: Validate migrated blk_len in post_load
Date: Wed, 25 Nov 2026 00:09:02 +0100
Message-ID: <20261124230917.88704-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX/ooiMTgCWSXg
 ugtZoVD9zNyDnisxbE6L4Y5Q16/T0jsEW9hlWfh4fl0lDAxcwSEfYpyr179fggKRtx2LsCsNERW
 89Jb5BiAF8/DDMOSC85aTCl81FyaohQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX9hJSDDfdbskB
 VOzVP9hcLOd08l3dqWkX7w1OWb2qrfMIgnwELv6hJy9ibwkc54Qzv/45HcDVylGNoxGswoKppNh
 iUrgMghy73+XUTwF+qaJo+ISPkflPRsWejFJDMh9R7vi1PrlNZzIwJmwcKtVU6wWdH/Gk7K2yDb
 TQ3DCKI8KEmDB1cSKKy2ArkU3QsqHohMTISsGB48sZQ5S/lI3/1zKnaNan19/12zfYHvGmbR9GU
 Y8qAZZYK5KArI5X5VZW8vyxWiH1Tx4Fes/omwXgIbsxc+T+a/jVvQ+vBXl/bYnsf6fAdYozHJOX
 urSleHUyGKzw+gwd8IvTbzWrsLa/HVT/oC+/zlib+AyzMBt5I40kE0LK25MFNKrs4TYUj+xTqL6
 sbA1iJlOmWx/f+XPiWIJQb/FtyT1WoVr0FktL1pRtsjY5msRUnorPFYSVfOgl6XemqYzLJxPznG
 hxNAX3qlTClKzh05jvg==
X-Authority-Analysis: v=2.4 cv=f/Xdl+yM c=1 sm=1 tr=0 ts=6b06192f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=AS-B_AZf7FWz2WqFvX4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZZN0Dj3Y-ZaDc4TfMzFy51uNIXD5jiZ_
X-Proofpoint-ORIG-GUID: ZZN0Dj3Y-ZaDc4TfMzFy51uNIXD5jiZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harshit Mukhedkar <harshit007k@gmail.com>

Migration streams are untrusted input. A crafted stream can set
blk_len larger than the 512 byte data[] buffer, so a later block
read passes that length to blk_pread() and overflows data[] on
the host heap.

Reject such state in post_load.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4725
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f1b5dbe011ae..5a6045f1360a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1073,11 +1073,24 @@ static int sd_vmstate_pre_load(void *opaque)
     return 0;
 }
 
+static int sd_vmstate_post_load(void *opaque, int version_id)
+{
+    SDState *sd = opaque;
+
+    /* Check for blk_len that overflows data[] */
+    if (sd->blk_len > sizeof(sd->data)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription sd_vmstate = {
     .name = "sd-card",
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
+    .post_load = sd_vmstate_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UNUSED(4),
         VMSTATE_INT32(state, SDState),
-- 
2.55.0


