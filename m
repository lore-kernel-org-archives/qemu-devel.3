Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33A606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iFv5Fhxo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEoACPpC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvF-00012C-DZ; Mon, 23 Nov 2026 17:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcv7-0000zX-Ul
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:53:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcv5-0004uV-Th
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:53:57 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuaiL2973605
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=t69Fpha3VeZUdHaMMe94Zy
 2dl0Z8G363Yv8yJtnvFNA=; b=iFv5Fhxorogeyk6meTO3kLGvEbxRSzwE1o/lWg
 xbJVIQQ6Y+DtLd5+zgUq2CCxJNTzQvaq1iC4OmqhWIOtQxCpLtcvBzp1GRywDta7
 jDhImvuJ66l680sffB6Dpj9kTz+4SL7F3qW5GpxgLBI8/UJb9sWEMfoRbO6XTidJ
 tG8QWQc1LjGI9hy9vx5awnu72wASYCG2P0TBVIk54/MpdxGRC6D/r1gGX8Q4K572
 td2HBjJKRP0LinWBRAamvyVMZIRmWoy8eUKTqxJMViG+iVoS0xwjErmOR5XxMHv4
 xGSoqAPyyPKcWKQLKewaXxAhWu+Ncl20deYoi+//PVUgXlrw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy03u3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:53:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so968074285a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474432; x=1796079232; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t69Fpha3VeZUdHaMMe94Zy2dl0Z8G363Yv8yJtnvFNA=;
 b=iEoACPpClU0yMVRpTL/5SX/Akj3/V4htTScHwi+D4bX9uuKnaiII59NfP+98IEZlXM
 Ptso/y61KC9xWRVe5dBfv8tFFBKnpvxqY6SIiJfSIcU/UAz3meiaLKCiW57HXex8EbyF
 XeX6vq6/HL+IYJA1SOPEHyPb5+Dc6exD9SapsEWtyzFOETKJSolvkSKN4V8cdk4v3qXb
 raKr2UEmUH7/NaFLkRnH86QmzYvar3sMcPTYVLmV4tOOtXjj4gflMc9BgNB0TxkUazpI
 OEfNmCdC6DjNuY6CLv9vfqATPTknyO29tLMGh8JSF17Dyr1xyKp7vdKNk3XHn2JpBtWu
 GuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474432; x=1796079232;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t69Fpha3VeZUdHaMMe94Zy2dl0Z8G363Yv8yJtnvFNA=;
 b=d5BBF5T5kXWoUhI3YRCHHtgLM5s7BIfuae/JF0xPSjAU7JykO/a1JFD4J+Wa2RzJI1
 wKKu7U/gIest5p5LCJ1fzdyx04PoqEYcW+4gam+FIIS2KyIXOoG0+1k5qDCeA5ZV9fkz
 mZeuFnF79d/MahUE3pKLcVnT/gF5c2OaVOO+EVcUL9HNszHvjIK7mC9wPg5w8SBprq8U
 KENQxETq4bKCizeqBFoO/EHfG+w16oo29wNbrHdZxne3sSSWUH0IyQv/QrZ5A5b/T8gz
 FnU7kKj12aMZGAFbL0qAbYaYjiwDqQ1TZsWrfVlE5s/3KvHZEm9SZ3eOM07GfhhNGat4
 W0bw==
X-Gm-Message-State: APuU4Z+Pe2T/R/0IIZmYFtlCBRbfi2wJx8CH700fIJwVTZGEq5GPU577
 igMGYy0f6JRp376nlbE4DVGU4hJVtcwV5X42Ija9v1LrZH6/77qqs7OIRvy12Fj4ZHTzLHGIkgs
 Hoy7AfF5xdOrVCoMu048sG1G68wLK9tkGLVueT61PzuzyMmBd+rZI7chcrg7ow2uUKP/4
X-Gm-Gg: AZFdTZe2JnXNYTuVFf5cqttjobc5IpPbTCn6XeFDZXrcx1DrfiuSzuCz4je2VklLdUy
 nR1BJV5tKVHIpsZX+FY5M49RhFlPEITkGQtUyM/w775DMGXTRkxQC+k4VPdAqUaff16d+/GvZU1
 RCvZJUhQm0DwT/xxob5CrphVrOyMJ8wa7m6kv/YZA+QT2G+j6y7wumeWrOpSOV5wl/zMlb427y/
 b6KLF5dj8YXWwAJ3KL//Jnq+pymgcgE6tMbIAkBwxq/+ayFyExbv01C/6Q6ZAcMfgPdDHa2rLKZ
 Ve7WBfeDBbpgtwPcXNmiFWb3RAMTxnmn1jkb6P+wQBC3OSob0d2oJ2BbrPlK5xPpJVdZxEdCWht
 SRI+mKe0DeT0Znblj6ya9BFOjFTuoU9dU6M39JGPtOk9z9Y+Whl5DTeEfNhiLbSQFb6Y+wkHis9
 nPxh1NrYSFA7xNRg==
X-Received: by 2002:a05:620a:f0e:b0:949:a03c:a6fe with SMTP id
 af79cd13be357-949bab1a6f2mr2297939685a.61.1795474432601; 
 Mon, 23 Nov 2026 14:53:52 -0800 (PST)
X-Received: by 2002:a05:620a:f0e:b0:949:a03c:a6fe with SMTP id
 af79cd13be357-949bab1a6f2mr2297937085a.61.1795474432063; 
 Mon, 23 Nov 2026 14:53:52 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm342873475e9.2.2026.11.23.14.53.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:53:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-11.2 0/9] hw/sd: Security fixes
Date: Mon, 23 Nov 2026 23:53:40 +0100
Message-ID: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX5W8oO9tv4eyQ
 OXcQENIFJlmwfnXcRmhika6TZ1PTRTgQZAHJiSnBj79umgiC/el9yLuj9TMjdroCu1PlCUIBq34
 GoAZjg424RZ8BRQcZAuCbNGqloRkkwynAtbOk13pdTs/O5YK5g+4hOEnAUKLLK9uE0b6YroTAfl
 u7fBtdBRltLY2DW1YzPpKOtEVimYEp8xNfrqyGX6t054iFsucF9w8nQLtCYQpB8ZOkkJCekjsyv
 oHyhObn7l2Ck41INOdXszL+GhJl+RN2H6ZQupj3163h9ykngYUSpPa2KSExaH6L+Xv2vzsccEtV
 Viv8jSDwfdABGfmeB4yP0mJWxX+M8iGomG/aRWwq1iYtUMZdC7k5Wr2nZ++0yjWzToi8ydy6V4h
 8P5nOaATbvjX/GzIezmQ+nURKIo6osDY9neXnlOxEKm4WZs9b5m8PPs85ECTntVsCIcO89SqWRY
 TkaXs3n0l0secuobIwQ==
X-Proofpoint-ORIG-GUID: sPDFnOWii_vcoOUZ22ceclyL6rNa7sa4
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b04c401 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=zGn6GFLlv3nM-rAxoCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: sPDFnOWii_vcoOUZ22ceclyL6rNa7sa4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX+jRAVNTUUZ6N
 EmzAnJgxlr4WtNf64DZKqQgTy3kvQznVJJqoFFbFQwOXqIcu+sByYLDldhg0mmTX8TzCmZ9+2rX
 Y6WV5VPEZ0LKK8K6M3Gs7zHXNs3u6Ds=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Various "security" fixes (as defined by docs/system/security.rst:
data corruption / crash guest triggered) worth for 11.2.

Harshit Mukhedkar (1):
  hw/sd/sdcard: Validate migrated blk_len in post_load

Philippe Mathieu-Daudé (8):
  hw/sd/sdcard: Reject zero block length (CMD16)
  hw/sd/sdcard: Do not write data to write-protected areas
  hw/sd/sdcard: Do not abort when writing DAT lines on invalid cmd state
  hw/sd/sdcard: Fix incoming migration of SPI mode cards
  hw/sd/sdcard: Migrate the data transfer size
  hw/sd/sdcard: Validate the migrated state
  hw/sd/sdcard: Fill SPI R1 response for rejected commands
  hw/sd/sdhci: Report Auto CMD12 response timeout in error status

 hw/sd/sdhci-internal.h |   1 +
 hw/sd/sd.c             | 122 ++++++++++++++++++++++++++++++++++++++---
 hw/sd/sdhci.c          |  18 ++++--
 3 files changed, 128 insertions(+), 13 deletions(-)

-- 
2.55.0


