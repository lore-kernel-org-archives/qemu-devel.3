Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE2606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q2FMgj5T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dipqbDmL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvq-0001NF-9z; Mon, 23 Nov 2026 17:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvp-0001LZ-9G
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvn-0004zS-K7
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:41 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuXiq1332752
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8YUnh18cEWGCE3mifSou8FIxxClWBbjsYj8WDyPXnuw=; b=Q2FMgj5TuQA/QJBh
 /NRSeBio5BRfpOMmiEHrQ8wTQGKvRXPwX/9qSAw7yFoPHB5wk8dly/drEDkRgD9q
 5b0CEB576Ga2ikSFQWgvYC/AKfhmDZg6tSxdE7rcYhwOdEBjqqTSiEIByENQ0FOE
 C2Njp1ZNEjPz+fC4OLKPFOUdLTdOmJE84X7S6VTD4nLd0NjHu8yz5QULHfZCetGK
 2gxyCBq3CZXSqfeAqaOTWNf2YAHWLNRH7g2U5hrRfi+IBkGCIZRzrQcdH57RVQl9
 IY4QaalU2jMQXpSIy1JWkv4z7Kd3OisL63OnmH8QgHZexoEPruiU1RUWY/j+Dj2P
 gVOQmA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g743thg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-948d83322f6so102480685a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474478; x=1796079278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8YUnh18cEWGCE3mifSou8FIxxClWBbjsYj8WDyPXnuw=;
 b=dipqbDmLR1R0hAxCx9mRPjOQlObxP7H6BMQMfnSqE2SItLxLoAhLlC0Ca7BLb74MhT
 xRC7ApVqPGMTFnqEutzOmp8IjUY2+4+uu/b8B2RkWYoq0wZEUcFTR1d17HMwaKnru8LI
 lEcBM2YfrkbsUmlb8a4oao0WXhK82kARhpJX6Ql4oVJiF/tKWmj/jBveasGDSG3/gIkP
 5aQZ4VyKMHuQciCKXSikwye6ooGM2hQIgBVSVlmkIo0GNuu8aEM7frZ30VgV7hA+dapC
 iRNrUQo01SrQObgQSzEDS966s6bcUlLgypYuVCM0TYplEYsIlADLs0fUimFZvMh6Awt7
 DGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474478; x=1796079278;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8YUnh18cEWGCE3mifSou8FIxxClWBbjsYj8WDyPXnuw=;
 b=AHXcrYTWP7gNP1vCxf4SPZA/oIlmBJnj7mMEbuPF6CPF2AqwVdwuYC/M803a6Qb7jJ
 ywQnZUMHKIjC9FNIDLKNgxkI3sIyuAkG5Nwcgg59mwqt25vn8ZdMBUWUElQyl9nVQ8c0
 kqN1tVD1OCmIQJ3vevhWq2TmcjziT8So2GQuURoX05weXqK/dkdFKLcg2LrY7PcgzLNA
 M0IDyJFzG6VQxdb/d8drzkCdEnfazz7lC3Hotcx0THtMSuJKpvfL65kT19OdS3ZecP6U
 d/6UpWGrv48aa3zLsd9erWTWbTm3pksY0Nsm+jOqZpRLLoRPBjPtmbWXcfFQtjuO27ZZ
 rFIQ==
X-Gm-Message-State: APuU4Z/MYDEfgGAYiMFuqeL9zbfygjODmu72kxSOVLQfIAJT2ClWK9C7
 CYEH1sJfrcHg53ZXYLPjsf9OgU4nzU5Hj8Toh8V7bD5KkKGOyFmcXnFrWLdXtuAbij/bog1CJ4l
 Ao4Jkm7NKux/fKLTggMDKHZxdheSu4/cs46Zy1vcKXa/XydKG/M0BLxbWZdDwnu6fWOma
X-Gm-Gg: AZFdTZdSRiOalSTShCCcl/s2DtB16r6+aSVzULDNAH0hDggA/sLY12ZBoLSwISF1xQq
 +QkW6SpPzxeufAEg8yqYLWLfjNw3w7jWxWSJS8bhjfL23Sd26fBD7cCmuflEOuWwwkA0ijWz+yy
 2lBJkHxeYB4bzP28r9KLvgK5sQ3O4/+wE0wwBnK0p68M9z9HIf45VkBFc4Xluu0ngcrqShNMSTg
 4G/v50dSg/5w8ZTFEAZ4rz2kl8EtExm/28y91gUR8SW7Tn65O+k+TK+eJWf4E2G9z5uaAq3oeZ+
 4IiihfywvcS0ccd5xVPD0lWG0pF9+zD5oLuRX1HMWYXXLZp8dMRXzvdtc+0m6MyzgrwTtDKbOrk
 liTEyUFo41T1SjIDPq4J2xp3m5gn/2eD5mZNSayAUpQDgJ/D48vySLW4Xq26J07mVvA8a7aJfbB
 VG+fyoohMAJwGQTg==
X-Received: by 2002:a05:620a:271a:b0:949:7473:b1a5 with SMTP id
 af79cd13be357-949bab1d726mr2226988885a.55.1795474478174; 
 Mon, 23 Nov 2026 14:54:38 -0800 (PST)
X-Received: by 2002:a05:620a:271a:b0:949:7473:b1a5 with SMTP id
 af79cd13be357-949bab1d726mr2226985985a.55.1795474477673; 
 Mon, 23 Nov 2026 14:54:37 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm198631f8f.54.2026.11.23.14.54.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harshit Mukhedkar <harshit007k@gmail.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-11.2 6/9] hw/sd/sdcard: Validate migrated blk_len in
 post_load
Date: Mon, 23 Nov 2026 23:53:46 +0100
Message-ID: <20261123225349.54981-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dvr2kLrSuCystnYqvjBYLIZMFXVFPxAA
X-Proofpoint-ORIG-GUID: dvr2kLrSuCystnYqvjBYLIZMFXVFPxAA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX0mADAnaFKCrE
 lwxCYMRrgcss1QOQZHjsRXh6E2+0vpt0fDpaRQCT5jnstcLtGoI2Q76TY8iE1N65LwVQiXfm48U
 yv/kKFwQ79oS3cthsKc3tfx8oB47Brs=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b04c42e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=AS-B_AZf7FWz2WqFvX4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfXxMIkeWzBlJwA
 kpuCq1o+p7oXcpAGpWOvbRiCeHvyQpv5WMoOA8coptoLSpsYaSuEdowMHFCabTGOFAPiPQ/zdA6
 qAngEXR4GKJc+nE+4oPn5sO7MlXaHVDhu14FWaY26lcAIxqQv1ZpEfigsPstrfezwJX/pInK3Na
 neZwncatb17+U4Fu10FT5kR3uA1VuYMguI1CoFEdSNCWjK6FKJOX0cxbK8PJTgzfyNwvvtko1pc
 v+UH07jA49OQ6vUvCkecvdSOAzzxbcJRCaSEHxPAFpQTm0llVTvgA6YsfF1UgpV8W4cYC2hJqgB
 B3T15m7p4otAqw02QurHRC8Q80HzYq4y2KOCjw37o6axdsa20PDp+wPBLxxxJzdml/+KIl1ijA2
 vyPB2IqDOreNyTboohZlux9luymTcm3kMal/9skvnHnG047s0NXiLq3tyFFy0imixRiE5Ib3OYl
 eEeO32yWaman4Vqw3AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
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
Reported-by: Karl Mehltretter
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cca8debc0938..ce1d1ed583bd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1100,11 +1100,24 @@ static int sd_vmstate_pre_load(void *opaque)
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


