Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6F9C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8pp-00089O-4D; Wed, 12 Aug 2026 09:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lO-0003sN-RH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lN-0006cJ-1G
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4KJG2860166
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H8bOmNlfoHQ6vnwoT3iYJ95B0zPjZH+NKe19ERFlx38=; b=J+NLMaFunxRNE5wY
 46n/YRi07i62ZrtNiogcTZm5YRRzoRb1Bk2ijz4+1/Q5al+91e7q52kEFV65bP1C
 PZwCVkWmObc2UFxbRoMczl1DItrHF+gJWf4ESgJAVFzsLMO7RBQPIAQjafzxB5e+
 lU6Beu0busUodXZtgiJHGgWZ5VQ9xKO+aDxfnkrUa1wycJR/QlCY9afBEkPmO7zY
 lauyc+4iTAFlfwu7W9D0iapj/QdApxCDc6AMKR5Bi/M8Md2mdHT0eOnX5Dv+m6Aq
 3h0bXDhWrl5TITv4iNRDuTphw6FYNx6j0r1jgIKDcl2n0XchuPlo4m/KT6pkwx1t
 P4WFEQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd97bj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso8005351cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540374; x=1787145174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H8bOmNlfoHQ6vnwoT3iYJ95B0zPjZH+NKe19ERFlx38=;
 b=aUW+eW10hJn36D9D+l+DsdPpafCIqm2TrfE79K8bi0/LEaZR5R7yNqyJ2wwFQA4vZa
 3IpKAN/K4iazVrhwxyA2zFs5WTvL6zN591mAv4pYv24EiQ7HVBzPf811wjbVHf2DyGfa
 yfOteZa2DdjsNsUuNxm/zAJW76W1g60IObMVfZsBkv5RT0wa0tdFiYMe1OWaUZx4BJ/t
 Ha0ECgtYhKl9zLD+fvcZqwWCZ8s3k8KY4CuN7YNGgUN7acJPDaJnA5zh5X9Hld3jEF0B
 OeKwzlzwm1mLULLo7LSBrPfLQI8JleTDNjMucC8fL587+FsZHrG/XQnY7qE7jXTd866Y
 bSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540374; x=1787145174;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H8bOmNlfoHQ6vnwoT3iYJ95B0zPjZH+NKe19ERFlx38=;
 b=WPkYxc4fX70iBxMphmg1o5ovU6PJUV9QsU/tN2OUsCyW4D0ebkhrqr8Q0P8gwYs/Gr
 jNJ4Ia6tXBaoVlns3+YIqowkHdWBmlUwt5fA6h25YluPcDrr432dBRPFhI5WoDCnLG39
 HSEFwGaEZvdpswrLuDtGGfMYCw5atUFxJDI0nbbO3ZRvccI0IYSWPUsc/PbD23eTqtkm
 Knij9NS5DbxjH5msrpPg8d0DKinE2C+QQkQrJOEe0cQuHaxAsECgY8FR4EC39nWyGzCm
 Ru8kk81BfaTYxI1d/Xx1IPaYTjNbKSjmCEnI6XIhrD4Z/JHlLPexjH0h9+eMrkL8QQDL
 woUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqqgZR2fDihuzYcdp1PETtivqYknIxy7B5XoLW99NDgwTNroOnIgQ602cTH92bpKLLXDgPtGo95cGi@nongnu.org
X-Gm-Message-State: AOJu0YyfdzIrA2vLAE3+6TKW10EiA6xZnmY2G2q9Gz28zqDuDTHp1cno
 bcL6ulattohZYSxuGilD60akrpsqZaAN+xIHQXgevs2G080ZuE05CDmEVD8GyozlQD8SbM9t8d3
 GpC2PGmYrQDiqrL8yIaBO4Whh7yaZaIo96lvk8EUldHumNBzXeHLwPRNL+g==
X-Gm-Gg: AR+sD10zkxQ8Z3oIYQ+BWNc754k81DUUpoaVXEnxlqBfGiotLxvQ8a1ErAVDBZoytgZ
 KC74SEifMoibncomZQ73MWlyI3EMuPs2W6E5BW1UImLppp6XOrmCvWAm+93RghvyKmSQ77+JpQx
 I9kigm80ZB/2telUtGJ1VhNcXlzIRWwyyVGiYdJMZON4CkZ8FZiYwsql6Ug03P+OPIV+cdfD1nb
 POurylvKDp4yZDlzsXHPhgraJsQZ8hcjO11IyYBRWNtK2ixDV6EeQ3NoxqkMiCDR/AXvW5r6Kvf
 iRFA/rsKK5vswu/Djfb3iDSjcgzpAG2l0x3oATP54hGIBa3eI2Mb7OUqwngf5jR6Din70XbUGCA
 NYOSInrxHEYdNEPx5MsFfSOup1wK5DhcsqhMHsrmMaQ==
X-Received: by 2002:a05:622a:1e0d:b0:529:e058:d185 with SMTP id
 d75a77b69052e-52d6486a608mr41100151cf.24.1786540374442; 
 Wed, 12 Aug 2026 06:12:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0d:b0:529:e058:d185 with SMTP id
 d75a77b69052e-52d6486a608mr41099361cf.24.1786540374066; 
 Wed, 12 Aug 2026 06:12:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm38784225e9.3.2026.08.12.06.12.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 09/16] monitor: Reduce inclusion of
 'qapi/qapi-emit-events.h' header
Date: Wed, 12 Aug 2026 15:11:40 +0200
Message-ID: <20260812131147.83188-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX7zFKARxjfMTE
 6pz74uUFyoUwJresHe1vLqbJ58VlztOqavMPvgJrK30EeTL/9oQSJX+VNRp7y7FHl958bUDOozM
 omvzNSqMjijzzEF/3C1f652bGSpSXIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXy5F2KhJrRta1
 oVRTLYOUGHFdBNIQWiWhd1XWV8yLpEm2ZWIj58yDRWzo3NM6nQG3lMt/ThpMHVwHIRepkladaWU
 /62lTd1fSD1z6++8hBOOUUZjZ4Xj8+aqQGoP4VwrMZqefqx3Q3LZt3MYzHq7SoGvVCODay5IkLc
 bXDD+4lvkOTIbDIswaaGZxEBOOUC3Gkq7C/2x3VNN95/DeYbB/zSwxMs0RGsrzpHkBllkPcyn65
 2nqpBB7EvkXfcwgRUgYL7RoYMwB+IRHfRY4oUV8SCYne+VXH67y8RnIKWQaeYV+FdOmFZpHPqgn
 7jfnTAcMISAL5xx7CAovRza4eYmaQZ35zZiN5Z43spcRIkLHEuJ7UaDh+0BgDTCdcSMmQPDG9Z3
 Dym9CZnVxkv6xxEGCkXleFEgS2kk0F5qGc1hmvJ05EzMxYpZXYRVzxEabyU4E4C6wqCTzBs+oOw
 04OO67ewQjKlIl96ORQ==
X-Proofpoint-GUID: ccRgh24-ao8qHh84g08QSRwIiDjKssQs
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c7157 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=M5_NfMGrd9FO49X1DvkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ccRgh24-ao8qHh84g08QSRwIiDjKssQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

"monitor/monitor.h" don't use anything declared in the generated
"qapi/qapi-emit-events.h" header.
However the "monitor/monitor-internal.h" do:

  107 struct MonitorClass {
  ...
  116     /*
  117      * If non-NULL, the monitor is able to send event
  118      * notifications back to the client
  119      */
  120     void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
                                           ^^^^^^^^^

Move the header inclusion to "monitor/monitor-internal.h" to
avoid including / re-exposing unnecessary declarations in the
global "monitor/monitor.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h  | 1 -
 monitor/monitor-internal.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index efdd2165aa9..fa9f4a8a75a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,7 +3,6 @@
 
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qapi-emit-events.h"
 #include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 23829f32f9a..bc0932c425a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -27,6 +27,7 @@
 
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-types-control.h"
 #include "qapi/qapi-types-qom.h"
 #include "qapi/qmp-registry.h"
-- 
2.53.0


