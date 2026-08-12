Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D330BC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8op-0007CH-LT; Wed, 12 Aug 2026 09:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lV-0003vQ-9j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lT-0006fM-Kn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4wdK3543539
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tSP3oFOhSSJwH2wpIPExnupwUl69LTj1EeNGfJfr8IU=; b=DZk9B13ddz3BWAl5
 StOBz1GY+pJxsN6SBMVYQJc6jcteCwl9yIyluGusvKeQDCm37hZvYhncHC1NbZ/g
 dfPOn5TpJ4I90omxWJJdgSlefiCzTuCV0Wd1HZjBSH8TXxqAieNvHfFO5S4Oelvz
 EjUM8Lk6mCLEkGTL2yIbEuatGJbOJzjsz0D1hJHxpiMgaYED//A22tCVEJg1Me8n
 AlkSgM1geXGDbP0WTGPYEHTjPhVXiIAeE5yINUpEB3+0NbcTdbxNhR+9WvS7ZsVz
 4ZLywHd7wuXbBiI1i1f2XzkwnsL5MW2wn0t2WTRXDYKH2TXicep9wXsgIhh8+FnX
 tiVkIw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1hymr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf321d786so15457061cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540381; x=1787145181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tSP3oFOhSSJwH2wpIPExnupwUl69LTj1EeNGfJfr8IU=;
 b=PDJk+PdM4xvATmO48DPWVFevP2W5KbeQOl1UhqiJBI70yphLFYdbOEFfbivbIZEYHK
 +AM8AwTpc3XuGQ/zYoSfqTBqgzw0PsnnoHY/QdCCUdQ0+0oAsfOboqEoAwCnKEjpizz0
 bXRjMHesXMCFW4FBsEmMEsOItX6HjNmWAUung9Wtmeq3+Nwe2vOfZ6xELNQGNnewivFZ
 mz4auAGsDhHEilclBfPz9x/JMcnzz1p14gmglxwuhofw345ROgY7GUBOMzxGbMNSY5Hz
 4UU0tBajPapWrdncy4udpJ88xwAvi/Uhy2kD/Yn8PR6TdDZm/wEtQwmMBVTBoqpkTV2e
 UDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540381; x=1787145181;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tSP3oFOhSSJwH2wpIPExnupwUl69LTj1EeNGfJfr8IU=;
 b=JkUleZpiFrHJs+ngjio8H0faSSMQAfY0DTGwaUowNyh/W8GivPW8wTTyobXgy9JpQP
 w/OgtK2eeIGL6xfsly3O4OQM7cvsvaa3PP8nScJu8QVqKHbRgsOpVdanYR5f30ZVeqYh
 SO0JjHoXvYJHVnzzsrvNSKpWO1KN81VN1qt86qEswEGLGOCy5ZMrl8N9UyVwSkeGPR34
 XQ92iBncgHGGwFp0RezRUjXzBU/HE8KeA6sOfodLYcnS0Kyl2BmsjzVob79ya+aEqsxc
 kTL4sg0zHRp++uKVwEXKbCJIFIMt1HgQmbBF0FJZ1ClRSZEkLh226RN0Ab7nZzfLQ36+
 C5sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RplneY2fygxcEfppHSVDGXLGOqOwf2N7iJKfAdkll5XUOSGKZVObWm3SLz01ivGu2SRZ75qcgBHc3km@nongnu.org
X-Gm-Message-State: AOJu0Yzjs2Fj4LgcD0mfWBQfZ9MIq7VGoVFiS3gtJ7jJv2KqJcXCKcgT
 CwHAxsvGN9bNk32in68/rTcNKhX3a5xejc/gfGuu2X7d/fkglX2skECP+3oMz+vIxZNR/M5fLS9
 QSXzfk9zBLj+tBCXq5b+woYAktbA8W3P4szuNiQWh9pVrIDfp0tgMAH+Sog==
X-Gm-Gg: AR+sD11o3frKt56UeLJwfOoY5FSA0lw3vErT6L9E06FdqiiSc/aQYMyMuWkqOOlLgDG
 XPPLj03SuGThGiYtg3OmJQyNyoHX/fF8JhyExzLjqGFiPYPTtVGHx+TYeMjr53AkktsvmqGE6+s
 YROKWeBBRvO4oKFri4yQN5HgjILsfKfRF2MMiNb0JEDMJZ1tGWroWlRr9j5KQd41yQgK4Zq3Xs7
 DKecGN+aExhO741P7aInxg5PjMe3cWMvL12RwdxUaw+hzirZZ922gVNRDIAPmYVO9W3DlRDEdj7
 bXq8q3Si7wQFi9EG1BRCEaPtZ/sfa3LH2SqFykA9By1+Nb7v9/6e0tqx97o86J32/9pEFzuxW+a
 Eq++u4eCmJdDFNVYAv01DGoupbCrKTX41T+gLzFBFnw==
X-Received: by 2002:a05:622a:950:20b0:52d:6c37:6853 with SMTP id
 d75a77b69052e-52d6c376b2emr8901511cf.16.1786540381504; 
 Wed, 12 Aug 2026 06:13:01 -0700 (PDT)
X-Received: by 2002:a05:622a:950:20b0:52d:6c37:6853 with SMTP id
 d75a77b69052e-52d6c376b2emr8901061cf.16.1786540381067; 
 Wed, 12 Aug 2026 06:13:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98d205sm40961565e9.10.2026.08.12.06.12.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 10/16] monitor: Remove unnecessary 'block/block.h' header
Date: Wed, 12 Aug 2026 15:11:41 +0200
Message-ID: <20260812131147.83188-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q7so_dMUE9mpKiLRUvdXKNPchB8P2OCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX47Pr9RXZZ8UO
 6Y8EaxVRzFAfUp7ZHV5VaxPOPdFzXS6oI0ONGW71fO+s9KmGCKpSOKaFrVcpLWxtFFg/T12tmVZ
 Tazxg0U6Mm2BOCB17dCPduvIk91TDsT9qeCo3z8G9PIxLr0s1+l4xsFdtlWt3LVCSmMOidUES2A
 UgR6KDUrljibW3czv22VTSTjr9TBSWjYVsq3GmFfFC+XRbCw4ykLccr0vJrxJlozWaeUUKdGwJi
 l7+yL6TmWr8w/1UTyTeOyL7XoBsx3lpQsnJxwRyWq4ujGHjbGDs/3sD6uqmsF6++Z3r7BACAds/
 aLZ+cZRwYWA0veUHwnp38RQREfr/qvEDq/PahfkwWJ2kmu097HoQzAwxm3dIY6q2cgCI2W5PUB+
 QjzQfB0zhCsv6MIA3V84yZW4Xv16YRGmvpsqgHH4WO1RFX3jfyVS25r+CGQM7ykhKlP2nLTNGa+
 bLMOTmhgKduBF5zgQPA==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c715e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=neFa9O3qn1L-Jj73aAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Q7so_dMUE9mpKiLRUvdXKNPchB8P2OCT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXyFEWhADFYdl1
 BeemuAFE0SCG83HbhaYJX7whMC8sGFdggHw6cePInJFDw48dDvcVBh3KGNs9eUzn6sJfBuEAQ0N
 IMdZBQMXc9X6ddCssJ1rS3qoW25Feq4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120107
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

Nothing here requires declarations from "block/block.h".

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


