Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0F8C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8os-0007Qo-Rx; Wed, 12 Aug 2026 09:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lb-0003ww-Ky
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8la-0006ku-5X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4LEW3963393
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=; b=Kq0/NGRebtY8ENTJ
 XkxahlkjeM027cNA5Ee28l+CiVwZ9jPDPkCt9jvLzBqdnSjIBImdZpjFSIeYoZaF
 HK8PCysUF9xSfJqzxthat2rC/UUVjrGjTdVJ5e9RDCh8tmDp9AaXgtROncrhNRGi
 h1rImnQe7S2SrvMysqkEWOqg7Dvr/bzjaGWjvHXq9J1Y4sG7d2htGJSq54BnVjd7
 VNAGFDTmPN/BriKLlkSEHX2D7wx845loSnEBfWzlC7fgSd6otHP/SUFY3+uu8Q3k
 38rF17Q7gj5Sph2s7Gs51mzShUGFE4ghBmWX1t/YnwTP+dcIvMyS86uSdXx+J+0v
 gPs9CQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgwrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so81656185a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540388; x=1787145188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=;
 b=EXSbvG4plkjRfEzsNPAIwsQEUQmePMb5beCx7WeavNGCubr++9vKDod/B6sIYg2Yqi
 uIIM4SwmcwOT15fjDL4lGaamdJnfaeqaI14w83Z8F7/VuKc06R7FgKkE1FvIG5TpOHrs
 Y80mhOWu4pvCIhSD8jZ3apG4njEazQJdbWSu1oaVHfZm8k/238HoejeBwxII9wRFu7/M
 Q6gDS+cEWQmPc03UZxoFb+pWeEEfwPkm+Jz7T9iZ44BzERVLsfgt7mYVR3LpXJlHzXIo
 CLOIXzpah1NcS37CM6hdLzfno/nRO9Z7vc7xHROvU2AEsyrdxAIDKXt6C3s1SXUt52Gy
 4kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540388; x=1787145188;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=;
 b=bQO3kUg4lx1idTz0lhRHEANllXZwqwWtyZxXqS+H1lMEU1JLdJOB96OMSF6+5UpJ6M
 d0w9odU0N0nZi1HOq4oXo4T1R5/GH0cZ+qaS1Nf0dlc/FnJXZEM0o3XM3MF9TLu9UMJk
 7SX2IdH5yf1eDdXcRHd6WvrLsWsV+N6CCCwkhXsvBkV7vkAP5cry7PsZ2TxO2RoJ5rF/
 DwaBjx3aohGrchC2T273h9aOVyEKIF/2kM9eGTn93fXu+9PIESRM08jKAhZd/BBzpDfI
 7xF6pG+6i2Wveym8/3EseGiXOX05ndsVoihgaj9lHy0XEZk33J3zrBpoO54HSMFqgOTQ
 bQ6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbESm/mQEUQ0bV5TsfomhSGqkGTu1KZLVDRFFRAiehmRwqRfeuoqOTCOz7KKGvAh45JeQcLIJ3jDgs@nongnu.org
X-Gm-Message-State: AOJu0Yzf/30Mr3Iz3DoIPPWMO8k+zVe52P3Qgxowc9C6zkGse/qEIflm
 uv8hO03mAa+2yu1sCWA3t+XGhadjnTMoSklutFK8YGXhra2AR16PnpltA8GMy1vzdTYd0lP8YC4
 0vPqYIxUy3iKNjs/4TcpnNp7tgeuyt3hN6+sgWX7TFDViVdzLKhjjYTCDNA==
X-Gm-Gg: AR+sD11G1ZyMlyJwtbjJHf81Pzo1QnARc+9aznGe7y2KOdafb/rnT82tfcC4rqXggPI
 xuAaNO0Lb/RWTIPA4YwvTjhqOkH8lyurI7Tkvj5twMR1JabhC7vyNpwMQJH78IoQMN6A1zpv22w
 L2eGrxSpnsVNQQqMf0u007TVkgWpwthEMJIALe8bP8Yu/yboQbGN+Bkepl3XrIcRGYlaHycbV+H
 k6lhR05+Y42H12xLAs3AzG9g3Wdo7oSWt0QveCRbWwbyr0cfsHTSnn7pLP2FSTWo7EntMHTRPFb
 JVPkUWEvV9JFjf9GJvvb8rEzMERuXHNC6vKfoUAjKWIrfHnRKhr6YMTRpF6XwgviAME9q9xSP2q
 n54mh2hpw997vnH4aJb30Zb0TWBF3nJVDn+R21jStWA==
X-Received: by 2002:a05:622a:58f:b0:527:631:8d6 with SMTP id
 d75a77b69052e-52d647d7a18mr37861871cf.25.1786540388473; 
 Wed, 12 Aug 2026 06:13:08 -0700 (PDT)
X-Received: by 2002:a05:622a:58f:b0:527:631:8d6 with SMTP id
 d75a77b69052e-52d647d7a18mr37861351cf.25.1786540388089; 
 Wed, 12 Aug 2026 06:13:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c9944ecsm49617005e9.14.2026.08.12.06.13.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 11/16] monitor/hmp: Remove unnecessary 'monitor/monitor.h'
 header
Date: Wed, 12 Aug 2026 15:11:42 +0200
Message-ID: <20260812131147.83188-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DoQiGmc3CoFd-C3XHkvlYPQqwIudZVvJ
X-Proofpoint-ORIG-GUID: DoQiGmc3CoFd-C3XHkvlYPQqwIudZVvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX/53tsVc44PNs
 IUOfrzJnfGROetZIikzUI192Mw5NXHm1UBzPjMO9OnckBMbebGjnjP84huWOWk7cpUuVe7tT8V9
 DsQaxIJ17O8e0TqcinUgVL6Dv0Q+F6pnCLbZgK7pdhi5VC5urynKaU4M5wQq3wtm5SMFzBNgymU
 W9+aVLukRMhgzhjEAtRJmOyJPnb8ThiZNZ1p/5sMPZXK1umXwfCkMw5hCjtJpll7FmUG5Lf89YU
 dVAX2C6I83juwwuTYRUaomSpLAmWwaEhUpUgQrhV7zFLXm42jsfWmnhVFGSdfvLA0Hr+MimneV3
 FMl2tAx7EQYyvLs5a8AvdlqbngeOHSTCwPunx4s/YokpNXYiG3AaWJ87G2uo0l90xQE4aVdaRlg
 qP36Hm1H6zYOig9PCJ1VLXy5nMS3pmW3s7erWMq0oUzL8x4ZOOvSr39LuMqaiW+M59gY+b2My4U
 IUUXQ6ozC/CmWM/NO5w==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c7165 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-VyI5JErSVUQEuwvVSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX169R2NwtJETe
 QBlbHyHdEVXDGDlbzEtyiEE2CvAZ0qQ66YRg7v/jwHFKk4UGEIFkwFj7H3k/bVl7SvR3FZo9XWt
 Y/crYIxqCnNOISOvMTY6S16E7BVnbmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

Nothing here requires declarations from "monitor/monitor.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/hmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bff..9be7fe28988 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,7 +16,6 @@
 
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
-#include "monitor/monitor.h"
 
 #define HMP_STUB(cmd) \
     void hmp_##cmd(Monitor *mon, const QDict *qdict) \
-- 
2.53.0


