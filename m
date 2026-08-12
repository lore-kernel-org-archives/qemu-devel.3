Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F74FC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGLs-0001kM-68; Wed, 12 Aug 2026 17:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLX-0001CF-GN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLQ-0007oo-F0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2X5U246457
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6pUTbE2syqmA7oZ20AgG6JLbEPFbMRRLvqwwnIBp3hc=; b=RzSp0n8fcQCn0IWU
 MYIAZ0dqEQk9OJ5x+743cKNIYC/QhTpIfbeqibqGvE7EbiA5mSyERpafG6+FdL2m
 NDr6vxNAqyzLicclvcIdGtTNTP3/jaFkeKeiass+TEB0Yza7P5GejZmSRGqUIYwi
 DWUB4dWqBm9WH+2ALpTtZQ2GpNaxabP/J4N9VRJSYilPZ30Cf7nYyxBQP2Il22ke
 G4RzKZvJ+r8fMfLT8m9k2chNKPkeTAtQ5o76ep28ChVGIjdR299K+jTRjzCiylVT
 RNwLzy3xXSqv5HAVan4YsyNnAteDDUBhaGF514N+OuVWi0OUxwMcMQWR0b4VwflX
 lznVsA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts1eqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so14456851cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569516; x=1787174316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6pUTbE2syqmA7oZ20AgG6JLbEPFbMRRLvqwwnIBp3hc=;
 b=S7QR309V8A3/SbU91kcIsNOslDoZIZAwFYe4rwcQjYWQib0V6rDfMYSe0DzOm863Wj
 FHukVwfk7bgNrAI7IJufdz+mxpOJwfuls4W9/f6BN7Tat6/LIlw5/LKLmcc8RzdPsRkG
 LISBl7PFDzBNHp6XOia1+NZ6WWvIzKbLdhWK47+dmv6wzQeGiMZPaox0ttKVrUUR5vtw
 4FjYVqJJUZjxV4PmKxOrDzD7FEBbBvXwxEJRQoVT7EfIaoRmyuhpKbV/BhHvxQMju/mX
 tCTKM5MAlOSivJkL6Q09JC7SvikBUtrndwOkfwx4axuUKoANlIJSL46AL4YHvtFiCO+/
 P7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569516; x=1787174316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6pUTbE2syqmA7oZ20AgG6JLbEPFbMRRLvqwwnIBp3hc=;
 b=VaRLz8ICpZBOvhanyc6EMUA/+Ww/Be24zrfUCUfRljYP1xa/7d7Q8S2nWF+dsnse6Y
 bVbJKr6qOP/D5X4F2aneRZ9U4OL8EZAcQYW6DyP57jeFqJprANA6PCW7GjAYWl8fLRjP
 9a83uE8joCQeMsldaYcxp4wUzlHaI/it+C2PTNPyQKR0re1Dn8sR16XpK0KrtTTvPzko
 6LIBHRavoUvKZa7cipVWcaxECvZvCe9R7z+rgx03aW/PRs4bmx7FudDzohLE0OSloR6P
 ZyQBH4Urm0gJy865Cv0dHIEeReWvXTanr+sKbEDXq34djxKTn5k83xZExY4XJkmT9nQB
 Xliw==
X-Gm-Message-State: AOJu0YwKwrBXV24bOi9BV4zsBp0wQJEVfmere+Wik9cdUX1K7AckjuM5
 rzXKqVvzpBPXnW8rGwnJ4F7GJcYLchaC4fWmatyNMPvBRDu0FUY0gaq1HliZ+4q6rtB5S/SVqmw
 AwoaYnyK5StQZ8kt9JGkAxuk3U50FaDd9bQItspgNNspG4BikWGH1flzvj2TE811wKQ==
X-Gm-Gg: AR+sD13whzSXtzorab/SMOMB7E+pMSYR5RKnQ1rLF/W2PkEgVVe6V11vkvV44R/RXxm
 1eK5gmSdj0BPwhtOfl5P3gzRfxmlsqBujMVU3MGxS7bq6OADe586wjBvJwR5l8EEgYq/LmPTD1Q
 eRIz+t49dIVC/a0C3YtiU+p1RpTLKHc/K5hHkE3OZuFFi0TPLQLV5LmRDgsOXWLtr6/OvvMrZc9
 rAEX7l2V3btb6WTXEKzwpFEGsf3brjLY1Ika6wkKwP7LPe5vmZLMBfsJpMfeHNt/o2J+Tcf1DyE
 k1zyxvKTxVUU/Tu7V1GQhEPJ2pIMRpZkyEN4zZxKS8k8JUuxWZz2+N1s9CGyLD2Ezn8P3umyEdt
 3pa8ka5m78m5l8cbcV7FaTR1IXZ7f6vMd5wwNBNcyog==
X-Received: by 2002:ac8:5907:0:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-52d73d8a4e7mr9618361cf.21.1786569515619; 
 Wed, 12 Aug 2026 14:18:35 -0700 (PDT)
X-Received: by 2002:ac8:5907:0:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-52d73d8a4e7mr9618021cf.21.1786569515157; 
 Wed, 12 Aug 2026 14:18:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981ded713sm8617665e9.1.2026.08.12.14.18.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 11/23] monitor: Remove unnecessary 'block/block.h' header
Date: Wed, 12 Aug 2026 23:16:55 +0200
Message-ID: <20260812211708.92824-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Dlq_adkXCC8N9-rDauQiEb-33TQEAp9k
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7ce32c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=neFa9O3qn1L-Jj73aAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Dlq_adkXCC8N9-rDauQiEb-33TQEAp9k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX01DXoLM1UU7I
 iqkvnMwjsOOlDLDVaON7InZ+5fCkdLvgaTjBKcgN8YFfiR9Jxd9Kmw4jUTfsVG2N23h/ViMsYQ0
 8TSquv1ZnjWHqqkuu+GTbUIzXRmzvEc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX/fh2EFjX7o6F
 wxq1ciuTkpKTRusKAnoyv0O2H/wuhAyxaHXHJt6mKDKUCPyKNHeJDVpRiLWfXFMBbU2c6Ym+FfP
 SH67mCMGh5T95rsJA8TU/cYQfnR+BI/7V5A6XOjlTm1MDOdCi7SbCcAsuvqNrNAOwl6haLutY0t
 /lA9rAzXhUMQwb1As+jT2bQhVYJYh7AuQIVYRbvIHAv+nLb+Sa29i+WDn+H7LRoyV+umlDiiSAO
 LfcKMkyDSKDNrRqE7kT8ofc67Wn8510XJCfexhNODcnnvFlwDeXiRLHOFFpZkB0uDn7uI0HoBsv
 or1Fredx88miht0DEa0AGVauND1y4OdHnMK7F4FRdSzc17syHAkGkMnQ60bvlpV0J4IY7AHvmbq
 XSJoQPUkPNCKB27G88rwfKuQBThh7/ckTy5IKGZVb2xd7Zfs8CK2u50pFlvL2PA8513vBTD5r0I
 6DBJVLXOu+RCJjSgbLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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

Nothing here requires declarations from "block/block.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index fa9f4a8a75a..fd98ee2c71d 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -1,7 +1,6 @@
 #ifndef MONITOR_H
 #define MONITOR_H
 
-#include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
-- 
2.53.0


