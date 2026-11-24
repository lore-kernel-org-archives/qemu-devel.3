Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FE606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bxf5KQuZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PrmFH9Br
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvgZ-0002mI-ES; Tue, 24 Nov 2026 13:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgS-0002kk-7H
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgP-0001HX-SV
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:03 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXX0N119713
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uCihi+aEfSGRjMo2FNUSUN
 YISa3RJZ3Mx1xVk7Bwt0I=; b=bxf5KQuZVFg+uKog7ydBh/vgXDRlMcwj1fKmCW
 Lvi2jsej1wmdP1bkdfnKI25Mu2SDYajDsxBu2G+nu/iSxpISINkR2mAUgH+LDHfB
 tPn9ykSjgUL/kz/hUKH4VoS0ZAmId62cIJ4K/lMMxXyP+1GsHEThCxGzfXlu3Tb5
 iLBOFeObctYqOsyaCLqkqBljaDlE89F78CTkDJX54vkz3RAtOYOxlzSl5yXGohe5
 N860YL/QDDm6AquprjWtfS2BodDS2nKKfpNt3kGVzSc2CqnvAMI20jAyODUsd4T3
 gUS8zp4GSxjoQoZ7I419LJdDNQphWNm8S5uMe5zx1mjc/XLw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5effrmdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:55:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so850151485a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546559; x=1796151359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uCihi+aEfSGRjMo2FNUSUNYISa3RJZ3Mx1xVk7Bwt0I=;
 b=PrmFH9BrHzRtooRIA4rUnlLBCjpNwjnw2XYmeu6uDrG2WdybHHnHbVnSVmTsvxMUFY
 wSoLZUtOCkkZarX00eTdIljO8LCTPYMLWWIPRhfWU7U1YvM1sWvCN1Xz7ZtSKhxXTdud
 Df625xR0Lv9V9A6+gVEymv7rDDSiVkizau4sWphlveoQRCEO6SayM/J2KnXfCzQ/FTsC
 T8NjnN6s2r7OjHY+Hc3Z1jLsnHDJSnCuU8PBtbKKg7q8JxaCMrXPk3modefqhgX1pyTn
 dxmhyD4VqsOB2rdKf6jXvjxwvouOr+iqI7jeXOB8sr8LJChzNN4dNXcSBJUVFseKTFEf
 GNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546559; x=1796151359;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uCihi+aEfSGRjMo2FNUSUNYISa3RJZ3Mx1xVk7Bwt0I=;
 b=AVlDcoxaixmujbfHInU39QRPi+jh/IothOXp+F3WdV4Ns3mUAekRkAbX907sCStKnf
 s4IAgeeIakKnN3iWrMQHpfZdCo40B88nPg5Prec3ImbjLG4SSCGaHxouvY/AFHAHn1V+
 N4goug4WWWpPRjDDI5ngYvTT46Xt0NNmv0SQn9JxAjDWHzjaqQxqBpvROSoRpPhwUv7e
 LvqaxtZlF2r5hEImV0/JCTxH35Qcgprddz33enAJSbUBPr2crATR9T+arP3kKk9yGAZp
 zx5DGojnxsEMnBfDWv559m7APW0qfd2RbfvoQoyEeYjluk7chTsFRh6cLogHmUIVibPG
 KyPA==
X-Gm-Message-State: APuU4Z9h9S9PaiC2UdN0l/EvugaaxvawObHh/ZEha+wjCFjgfhLXuDT4
 aV8sf29GnbE5o2aM9yREGOq1X8wbn8IJcotYwsPoZHmLSvZDx7Es4tos7YoyrmHrGINeqOfGtI0
 tKiqhCgYeXeETEyRyjdnCxjtmdGqi6x243emBAYDwdkCxa0kUOBRiY/SOc/chbu/l5Y64
X-Gm-Gg: AZFdTZdAOlqj+Pcj17jMfPui8Yv5QKKztUKdqGRcR3wSqbGdJ8GIs8N7SQbOn28bRxN
 1iHU1NztLTJF/eOATeReh/Wr9E66KxAb8xU1cS9PoNz6tcJcN9PF6+alHBYNcQNrxPpFPJeikU+
 3UUQmFgqZl4i5sofpmrA2yFcih2lgSC2jG1RsDeto3W8i2gdIdqopcwarYr7kJTthl22z4FU11z
 pV2q3Wepy2ZBQgEUGDgxVJ9g43kF9z2SSupcBdQzdmoxZoCC7cmQW/KNLcKUbl6cRq2phOZbLf8
 oQ2jSBS/SxO5lqp4SGCdYy9OHboAcLT6QzfYcrzQvboVqTm6aBG0FaahtXZf+gk7IS3oZpn1jyX
 9DNfDGJV0OZOQlIC7oMmSe3CvfQ9AbVHAaclGU30kbaycBQ8d1ORosdY+EUKqImJ9imBbdIpUDI
 c6AOG0o6BFtaGqYg==
X-Received: by 2002:a05:620a:2685:b0:949:8106:3ee3 with SMTP id
 af79cd13be357-949bab12235mr2632052785a.69.1795546559260; 
 Tue, 24 Nov 2026 10:55:59 -0800 (PST)
X-Received: by 2002:a05:620a:2685:b0:949:8106:3ee3 with SMTP id
 af79cd13be357-949bab12235mr2632047985a.69.1795546558775; 
 Tue, 24 Nov 2026 10:55:58 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399e2esm513362105e9.7.2026.11.24.10.55.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:55:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-11.2? 0/3] hw/block/pflash_cfi01: Fix 3 GitLab issues
Date: Tue, 24 Nov 2026 19:55:53 +0100
Message-ID: <20261124185556.81132-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b05ddbf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=xPYjeQLg3unfQg8HGrwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX74QXoS+GVKsj
 SMSA8xNLQNKRghjUNBTbbO8cq67Qsor3iQxoSPAYuS4cjn8fhPXPW5t6KMIidZa4fIuhXvi9h6r
 kD5LIyqKe5hWGwlcyT0dtBQPwnTQUIbRoMoMulWCuyDOnfsuhi3bTTxUMP3sc1N2GmZRqmRUIup
 l+eOb+A/i1UW6Tg9iosh9Erk9MWp9ym8AAhEHSmEtNF6kBnVpjcD2pbr9hrprhnGWQXoUGOhEU9
 h/K0mZ0wyL0JlEVjqoG/5F9xWY531DH22rgV470avJeHpWAtHhQvsA+xaYo2M2u0zWAiSzCYZPM
 lVAuJ/0842RRgDkxaXVHZq4l1Eb9VUFajMyw+gXbuMRwqykiEKaUBj53ELJKJU3iS1avlAkYMOD
 0lmp/WdbqOBSbaVk6y9LPMsJecqJGLGXUJeYSTVgeARRLnbHCRf1GOov+DBafQh4xkQXKTaaa38
 CAIua0dhSlbpDwRv+Tg==
X-Proofpoint-GUID: ZblgO193nMDtrR6y-UU5vm9nKeDzE0Fk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX4RAowSh+bx6L
 YZJwnQkTeF4r98flpxY1EjA2LdbIlEqty9QdBZyi5plO0BrKiykSQjFX77mXTWG+DJIaXrKgnvG
 IAG2EfTv85Cl2b8a6bNxqIYsR7VmB6s=
X-Proofpoint-ORIG-GUID: ZblgO193nMDtrR6y-UU5vm9nKeDzE0Fk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I hadn't looked at GitLab PFlash label [*] since some time.
None of these are classified as "security boundary" per
docs/system/security.rst.

[*] https://gitlab.com/qemu-project/qemu/-/work_items?label_name=Device+%E2%9E%A4+PFlash

Philippe Mathieu-Daudé (3):
  hw/block/pflash_cfi01: Register VM change handler once
  hw/block/pflash_cfi01: Allow zero-count buffer write
  hw/block/pflash_cfi01: Reject out-of-range blk_offset on load

 hw/block/pflash_cfi01.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.55.0


