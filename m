Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B80CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJ9y-0006g7-IO; Mon, 15 Jun 2026 22:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJ9u-0006f2-Sn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJ9p-0007qR-SK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xmrR1767350
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=r24YxL54g6oRE1jeavtlc2
 bfSTV9RDxfKNfsyhHe3wA=; b=FH2JsZYRKuK9TeMHpWkl3glC4n6wPc9y8a2Lzn
 l0+fQ45dXw3rhqwg4Jq98fWEHkCjtfJM+j74DAqtfLjgw8eJ7/cpQk/KejeHmSKM
 Tfdwg3UCSto84gNSBIvUF0oqtvAG02v3aSHU+r+N1RKBcT6zWFD+BSYz9Hd3VIgX
 r1uozJi/bc81ng9XhmgCWPKOtV0pYFN8fIA4nP+liHb7KZLGudelNPsozqAhETzY
 wSx7Bm/gTET30n3JAkmJutJLV5F2CHe4uY9xdpDXFX/geAJGv/tqaI2pWJjzyPM0
 8ZTOUc8s1xo1E2Oe81DfD7q9LUe+uEXe5R10mGVrO47JG7Vw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydc21g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915767b341eso389922185a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575441; x=1782180241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r24YxL54g6oRE1jeavtlc2bfSTV9RDxfKNfsyhHe3wA=;
 b=TOF7q3TfUPyf0YEOTd3O8DotbO9xzMnYMwq9gmWZpBsJ5MCphAVSuEZGIO99ef60Eo
 GzO4OXSZE/VOk4zP4ow8dydkxnYbd6Lfl/eqAfqmABZyf+Y0Mz8Hqk0Q21eOINU4hLyL
 3RZVX185gqzus/NF26qyRjLfGv6JVR+Y0vAuI2EokWKX86/2GEszkEGHbnZWLZy9wk8J
 fwLmZoP67AgEC0eVSuzyYarGLoGKCucbil4z6yf9bTtCyEB4ek8Hv82wUVwPTtwQxg7N
 oSUM/fNcvvmlphAggoKs6U/1IByY7lLov5enDSSU4X+uszGYt778l3N/vjw3KnY6kOUQ
 QnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575441; x=1782180241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r24YxL54g6oRE1jeavtlc2bfSTV9RDxfKNfsyhHe3wA=;
 b=ib6jY3xJ1OKdGW2X+46v2UqZD3vpBcqp9FZd7bkRyettVRl1X82GzLFNxHY6oDV3Rq
 eJUR94/Hdvi0ayQBRQ8QJ8xbUD/g2WNl++/SW8ZmZlpeAIgO7l4V5z4JGbCqMA5aXM7c
 yRsiSUZcQkdqhOcG2FcTvbC+UojDdQuYiM/L5oBZTjkK7NS8Q9Nx8UsnlsNlN7jCB/GE
 PKJyyJL5LzmWBvbt1fUxfgfeEHH5HRSmC5zVwmwgxIQps+nr+gAA2RriR80KgHCpHTNp
 vIdRg3+6yotfvDQ6rmF/brADMvC3UfAZiE+gL6mBvNOZZLu1GuBV+wErndGM7x0Z3/AP
 rQCg==
X-Gm-Message-State: AOJu0YwGianBO1k7hgyVerLQzA3tquRIEZtud7D1p4w/Tsmy3wSfU5uZ
 SN+7wMKvyzpE5fiDQG8fbej/L7vFJZ9jpXurBseh7e6C+PutVGLtwAxfIdQLJRN5HGuoqrfQpja
 xQ5PQ6BfSsxHMWeSvz9jHs2sOqkDB3k7ODuc6pZUxs9Zk4pONF5hE5pr4z3o24UgiMQ==
X-Gm-Gg: Acq92OHJVIZ7ZgOOdaMeyf+r5fvdNxmliyECSNmdIReiNSYMSKSp+5ns7A31tNuFjv7
 MQzizSmfuwL1K/RvC4QyD+riuluHEwE26UIFdW1L3l/LgsA1IQETAaZO/4klheJvnBBTDqiEas/
 fhlHMd1J9UjXZKwA1BjqrCI0zC5KusmG+i1Qp/D5YyfpQsXD1cutzc4ho7y9i083uSIQVQ5DnN4
 Ofv4Eod+3LKqd4H8C5e37yZ2AeRTYi4yUf247UlnKkJbOFqQT+C6N7xS+LzUiRQvHms4+qcEsn1
 Pqb6WESQXE3N6YS7OnBfHq8XcnxLqlnBKPNUyQYdSt5FhzlmYGRN2P3+7adMSP9KUEax+LdM+Ep
 kv8ybgjctuvM5/BaI09xhAC7UA+zutEJM87nZnRXE9JQMLDjhBBFD/nTs4M4Cug6YEg1a+Sl4nh
 qMFLk=
X-Received: by 2002:a05:620a:458c:b0:915:d322:c465 with SMTP id
 af79cd13be357-91c4541436bmr271988285a.6.1781575441450; 
 Mon, 15 Jun 2026 19:04:01 -0700 (PDT)
X-Received: by 2002:a05:620a:458c:b0:915:d322:c465 with SMTP id
 af79cd13be357-91c4541436bmr271985585a.6.1781575441022; 
 Mon, 15 Jun 2026 19:04:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm43616863f8f.28.2026.06.15.19.03.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 0/6] system/memory: Constify various
 AddressSpace/MemoryRegionCache arguments
Date: Tue, 16 Jun 2026 04:03:52 +0200
Message-ID: <20260616020359.18627-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8wWgPECfGsRTTot5Y7Cy1KyISGHnlnKk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfXznxDllp3edd5
 kzUrrIBIUEVqbm7pLEd5jLplJS/0bSWhKp4UPlOqE6wy2/xmIddwjgCsnb2FnTj8Py5UkMro6zx
 OxcCEpQI/XJqEPjWYo8Xj1Oy4q/0WGg=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a30af12 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6aqAmV0DK60uwL7E1wgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 8wWgPECfGsRTTot5Y7Cy1KyISGHnlnKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX8HHqqo5JJ+1P
 EuG+hHVMnWzX35x3hGsFSr/MDg8HVOrn5sbNCkAL79Q0rl4FNpv/uIytFZPvX+RZ8uH5Ce5P7xO
 12kzl5SZN2h0Wt+BeRMfa8QaR/pdKmkjeb3lAjSZUxy1MtPnJJ4uEI3o6A1ykiK4RBeudGouOie
 VnyA9pRKvi3CiEKdIhoWeeLxbOwygqACQOVvXoNCV4pja/38BO+5YquhsnalVvstMQz+KBn+7F0
 p2eK3nJWqkKuC2/BSMPUZBHW7XpDwu+TlPrbGGxQzp7paxDgObtp+NSRpY8m8+GgX1RDLAQyXBM
 hYB4C3B4DZQdy6Be6JV+tRUdIlrTDMLvD6acqX3PHw4ctK47i+npqbHOfat16745ByTZqKENTDz
 ON9KmoIFdhyZoisiV0lir3tMBTg5pP/xlxVpD5KXvgA1FOClTyOmbSQuf3+ncVNfbRT1FG4VI/K
 eL11bUqe1QsBNFgVlLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160016
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

When structures are only accessed read-only, it is safer to mark
them const to protect against invalid API (ab)uses. This is also
an useful hint to compilers.

v2: Remove 'xlat' patch (Peter)

Philippe Mathieu-Daudé (6):
  system/memory: Constify various AddressSpace arguments (checks)
  system/memory: Constify various AddressSpace arguments (flat-range)
  system/memory: Constify various AddressSpace arguments (notify)
  system/memory: Constify various AddressSpace arguments (cache)
  system/memory: Constify various AddressSpace arguments (access)
  system/memory: Constify various MemoryRegionCache arguments

 include/system/memory.h                 | 18 +++++++++-------
 include/system/memory_cached.h          | 20 +++++++++---------
 include/system/memory_ldst_cached.h.inc | 15 +++++++------
 system/memory.c                         | 16 +++++++-------
 system/physmem.c                        | 28 +++++++++++++------------
 5 files changed, 53 insertions(+), 44 deletions(-)

-- 
2.53.0


