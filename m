Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876A606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=el79QSdp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQTUD1OT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl2e-0007fm-9c; Tue, 24 Nov 2026 02:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2b-0007f8-W5
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2a-0004Ft-1u
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:13 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k6Ex901980
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6Gsvs9cmo+YItHa9q7k1RW
 5ZR94apIXcuqWzf+Az2PE=; b=el79QSdpwva3bbbK+E+hhbNeN5K8vyPaEkkOsB
 yAbiKJcma1r7ULrNsUPZN2LETCdVD/0JXnrX/C9Y0mNdGKiq1gZVFWz5ZZSsNY9l
 PCl/3CuhanJooz8GbkhxkVxHLJIIr2CaapTcc2s/SKpzelf2Wv5giK/gsPUaewx3
 o67Cl0B6AQNdwutG/8dJrG4yAJf7dS0nYEe0KjSy03zru8nmpDFzYDxg2TbLQVWq
 PYFHyAHVx36pUwH3QHz0eLjaolg0hkLrr0bQMc7zwFTD8l/TDu6zMYM+LEbY4yF5
 CHml0TulEAfOOaJ6xUtNppSVHV9RLVGO6BGDc+wAutFmebCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6st0u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94967c6d4f4so446054285a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795505649; x=1796110449; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6Gsvs9cmo+YItHa9q7k1RW5ZR94apIXcuqWzf+Az2PE=;
 b=jQTUD1OT0V2c2qae39h2f1DjbFlxLzhOTdtYLr+0W8tEF3gYmm01CW0xDxfxxOpKxO
 TSWkOtRyh26q8n0GWc4VlVhpvTkUtM+iHafiv6ME37hOBz+Ep65graWUKjF2TKsGY8Pa
 uCYvV0wBmsrbuyyNM+PNkzp/oyZWZ76XIrROyN5M+zdVoqevW0sXihHubAzAHbPkivre
 zGDRIL2vIBBXxhJxzNe38IfnCKoyTxCL+Y3BAngnJbPgd0kkT1LX3TlUaz6VgZUTHUdv
 S430ytiDVYJQRAKLNwybg+cteiYi8yo1+bGfxxPy5ZXQoPr1az783hRrRWDCK6/wJVX7
 5k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505649; x=1796110449;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Gsvs9cmo+YItHa9q7k1RW5ZR94apIXcuqWzf+Az2PE=;
 b=SyUwv9R1tk18TzssFm0iiaiji6xSKfpyu1bgxvIMR/dlrkwpdNloYlBO9KRz1FXGbg
 B0sAjxDQpXQlM+vbUhzaHQeQn8gjbw9yTIRi4ssM2Vu20foR1X7lNlr9sSUT4GXOhzoc
 ubl7xj1CoHEh6UpOuDtjb9S90zyjGb+P1iK7NGbXDhP5wEXxYlk3phS2ihtr3xNrejTt
 hS/wHGgugmy84Avf/LflRFr7RAND3C6QRybPiAe0uLtXfdW18jwu4eOn0UdbDcIv9r5Y
 SumLlSzcriCBlvBH1WhxNfZPjgFZ+QUgYhUMarGMaSaFq4xNNPmclVnUWsKuuaYM6CDi
 wevg==
X-Gm-Message-State: APuU4Z8lotUQW4MdfYh3uzdqc9waQCPTD+vR3blyRfZbNrvC9U5WITN3
 zMoqcoN76JynDgTXfCZblXmZPPScMQuGl7nSYuoqzWNhmKbinfSIT6Na2XLgZIitrLMW0LalLPO
 L4oOs18oR0SO0eFkhpqOAu+cqN3FBKnlwKrwAWuS610t3cQRZ6l/PZJU0pyJKMMr6t3Tn
X-Gm-Gg: AZFdTZf/6wEythppf4bMHC6FTHpqYihOdXjenmZTx/DFz01Jwe38WkL0ST0Gy24+JKt
 eYrpUqOpQmUNyvliEZnOe1UV7klnsPXCZ2pkRnUkhmkM5/Kw+KhisQQs1vOBFWrNymA9K9NTDz6
 1ZwHLXOC3qjbCpuxORL6ZadTw4cnfDZLabmXe/9SRU4MK+o4yDGMjus5mWzGlQaA7wE3dE2mZhx
 ShvXjf3xFdnNDm09U5tB1W6WPm28H098rWeAPNyswOCx0OLEtEN+4HekavF8UHFmjB88+JZb/Wr
 qwXmxKpHNaNLVEQkV6BoPzm6rHqB5DZp8QQmPkRR+Z5XaTSWb9jOikn4Hvv56Ii+f9EbrGC9N0U
 YclXLWDUBscyv2Y41kzrcFj8a7vlQSQByW/ctyRb2BKNBH2SkvhYqDC7U4rcGUaOVtK1YM3doKM
 J2EL3vsE1MGVh5aA==
X-Received: by 2002:a05:620a:2610:b0:947:920d:3408 with SMTP id
 af79cd13be357-949bab188famr2499346185a.46.1795505648807; 
 Mon, 23 Nov 2026 23:34:08 -0800 (PST)
X-Received: by 2002:a05:620a:2610:b0:947:920d:3408 with SMTP id
 af79cd13be357-949bab188famr2499344885a.46.1795505648343; 
 Mon, 23 Nov 2026 23:34:08 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm467822175e9.3.2026.11.23.23.34.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 23:34:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH-for-11.2 0/4] hw/sd/sdhci: Fix combined command and data
 software reset is ignored
Date: Tue, 24 Nov 2026 08:34:01 +0100
Message-ID: <20261124073406.87537-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4SCXCQG1k62uS0FQJfQ3VxcuEVBqtZKy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfXwRUCCICWip5K
 zqrACWwdIG1ibMUKd1Is/ntD/TDO/2ecoQ3HNCZZZg90foaW2xOJPLuqk2sQXYsn0oVRxS42nCq
 /IoVwc/8Lmo5W7F2PVk072lnts1rOKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfX2xMnMeyGHpOL
 wUb/tturzOYLi2/nYUpjR6nCaaEWkQDjUkAxU10jFkGgb4EdwKhpmQ5Ow4MPbXlNrIfZbo59SCb
 Lb6QEskxXp2Qz3pQAK2RRhzpcyi0pZ7nYqAfww2CmhjKk1ljaMD8s4NiiUx2xsBWhrgmg+3uoGn
 QhknRkC0AJXBQ5W3kLpos/3e8pXmij0goE55NN3l+F4XbxJM3ox33IAH4aCIxekLWeE611ARQOO
 oAQ1pdzfDu7wFot7NQFKgSa5K8gn8zCGvQbZlPJonWYBhYKQre65ajwWGy0oxXRrLclxNPB100A
 aC+6XczjodNwIOkUcHEp3svlw6sa5vfLHwRdOItiRQ019Xgc5Hq7kizK1MTsrMarqb3CKZirWZw
 2BG+/5kceerpzd4VMsxeIkZaqzv0zZw0EVRYWYw1uiflpBcgRD7mQaf9D+jqrKDzrKqww3skBYl
 8O7S7LqB9P4n6OQzv0A==
X-Proofpoint-ORIG-GUID: 4SCXCQG1k62uS0FQJfQ3VxcuEVBqtZKy
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b053df1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=9FcztEhfUaEQW3NR6JgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240029
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

Fix for https://gitlab.com/qemu-project/qemu/-/work_items/4745

Philippe Mathieu-Daudé (4):
  hw/sd/sdhci: Report Auto CMD12 response timeout in error status
  hw/sd/sdhci: Cancel queued DMA progression on DAT reset
  hw/sd/sdhci: Treat Software Reset bits as independent pulses
  hw/sd/sdhci: Gate Auto CMD12 error status on its enable

 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 57 ++++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 22 deletions(-)

-- 
2.55.0


