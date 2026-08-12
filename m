Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6866C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80b-00077g-L5; Wed, 12 Aug 2026 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80a-00073j-3X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80Y-0001s8-AU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4GSM3664703
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bJNJ71owOHpg6avfvSNvEMJvaX22jFH3qikkicdMvEc=; b=gnE6al7snYFMHpqc
 XDFTJ1Psab6UDQfAXVJ6bK+StryZXAD/6Rtr45iIDWR5AP3CKvl/YVyA+ZGF0Sud
 jb3Ah4lTOymTknOTFMGeITCIIQ4v92PqCyS8nbfrFSSDnaNRWRinspHrlawTqVaQ
 rGTlfoshgt62tShYLRRuptUVhPwgQr+jeDXQvx1xPwPTrglw0ivbltqbHHwHHhgQ
 xNUOxhqcG/fXaWlMRqlXzTbOPRU5lQ0ZJHfUHqbF3elEQLBYgTre2RVInuNpKSmT
 67+uALEGZyrnARo9Vi3Crg4TdDgHj8fxHeF0nfC1ZDMmcrQwlUMiSn8Zb4qQgUqK
 4hQQZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rh4vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso13812311cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537472; x=1787142272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bJNJ71owOHpg6avfvSNvEMJvaX22jFH3qikkicdMvEc=;
 b=EgIzZZvu11yvsRbOuRkC1h1fFgLIhzHKhFL9OKb5/U/4UwJ3SOR7vkknnyBlo80E7i
 CrnsMuMryHek7cioCpMyGIITVs1ndC20rfJQfs/uPdTHup0QzmhPTZaQrWDB5hvn6HzN
 iYYKnPVJ95sXNzPXW5G9dSwbmLK1k+oZ1/xbtKWXq6pJer0MY5YA5GshSHqurT0E7wTd
 rKKJjDk0D29qqYhPh9wuBC3FXssZaNUOQxNmsQHgPcb5HJTARgPMIyMILcRjCvIVC9Mq
 0bIBn61Dg6s1kPTenwALP2P0jRV0xr0aGz3HOz6nuaNpcLg7Zlj0kqsPRWApTHPFl1nk
 GBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537472; x=1787142272;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJNJ71owOHpg6avfvSNvEMJvaX22jFH3qikkicdMvEc=;
 b=jiATIV2xPqQRduQRMUfuWMboQX5l38k154OL8FmixDv5NzdlX4qmFh9bWUL0sEDs91
 tBf3BFKcZNvGIn6OKgDuuLbjM6O7Hr0+sfMgIaplIV3gk4PYQcdE8v8CsVZPgwsG9GYA
 Ea9ZHKN2DEBwRjF4iJhtMNk6nFr8+j47TZNkVcaDaKW04VHC0mxSKRMK8n732JzsNhvl
 n2jAz5uDYKcJIXBJw0YdDY1TEjVm640hWQAjHkeJgzqGdfG7p7bIPq9uBljSGWWLaBHf
 1nWCmGEddU7uAvKIO+HF5lQftoOQHlcm0BZB3rXaeA0erRKFHFl0kRH0MI8PrPDrHEzE
 ePKA==
X-Gm-Message-State: AOJu0Yy0llOe+6/p/l9S0UVdDUbFs4kmN5lki7CxrxLFcxyYYeW1asd+
 8woRAht4C9YYohCgLtGbMvG/SAF8bkMSjUZUHRx1iXhPDyc1gOxJltWderBYkG/aZVJ8FobW+M+
 JJTme4Tg7L9HtQBve5+NbMFtlFsrybt19MlQZMe9mwPgYHXKOh7vbJcR5gdOug0KVgA==
X-Gm-Gg: AR+sD129vrGvP3kiGuqtYxrBQVXePXrd9Ue5b2FV4HolPKSpiazXfbKAcVa5r6HADiJ
 XaX15Xd5+DhXOQc0YJPrZhDjKz5ZoTqkXcQBVXP3utiXeM+mYUIO+XMwrfKWU4T6evvItqzrBUK
 U7o7RgNo3Uidd6NJ2PCMNz57QzSTW+fPDa4+7kmMtDoPuVFUObLBoy1jlrrQ5QfCdvbdgzpBadz
 AHQajrh2MSwQAbV7rd5KXwDPvN2ZoEgtpdQfnQgaEltPyi/19bPhkGaECwOLjdAEa8xlLZuRTbx
 pgHDBPDPtjqHBlVdRgU03f3VCZLiJhSOzWR5WbG4OabLihGuKBsrs54jwYJ78B9ybgudm3M+JHs
 zHXItjuczOWGydSX9Ow9RZIB77rstdrD9VuXmfQD6uA==
X-Received: by 2002:a05:622a:2289:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-52d646cd4cfmr39470931cf.12.1786537472005; 
 Wed, 12 Aug 2026 05:24:32 -0700 (PDT)
X-Received: by 2002:a05:622a:2289:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-52d646cd4cfmr39470401cf.12.1786537471447; 
 Wed, 12 Aug 2026 05:24:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98ce0bsm45945325e9.11.2026.08.12.05.24.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 08/14] monitor: Include missing 'qemu/coroutine-core.h' header
Date: Wed, 12 Aug 2026 14:23:25 +0200
Message-ID: <20260812122332.72975-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXwb8oq6cuOeMb
 Aa0Nf7ObwqceUnmZxhBM/f5ZMb+NX6kWaTKi2kC1L+GAtv/8ehmh9wVJ4Nzi7ySps/9r9HmOmEL
 Dpt9c7hd9tVOZMFrnA5cLRsoH9jYxdHzs14HWqRBdgtASn1DLddWaTEp2uFoYpH/vmwNtWRXNOY
 9xBvAz7cHXLOXYTcFrJ6L4Lsywrksuy0P1cgXrcBfdmAACVVj59Ga0HI8+GqSkJO71Xf1BFmQyN
 eWi6mPS63+DFbEY9MbWtk2vCCsSmDP/xYvbVVeJYci56/DFn5uBBg+QyvOtU2q6tDOJqKXwPdwH
 gZJruYXBijBs1wplNgyjeNPB+8edIc2Zcgpv6bqT6g3LVkCNL8EaXPBrXJEgwTzSAaQmhWwMW6x
 3VQmAU9Xc3GSJB0eA9UCM2Z80AkcRONVfxIznfQe8S1vUgAcXqZ99j//arRHjsZTAXL0tpLdh/D
 OJBejJD65U12ADQM/iw==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c6601 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=neFa9O3qn1L-Jj73aAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: j2kib1QCYQU1e6Wg-__K1jbgeLHC85Yf
X-Proofpoint-ORIG-GUID: j2kib1QCYQU1e6Wg-__K1jbgeLHC85Yf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX2TKZv7XfVAsm
 6Bc382NOeRBv1RkcLUvgA6oB29RQykREvGJor7TZ1A/KWzl8Dh+JM2CXa6FxUwjRsu2Guz9tgHn
 C6efIUCi0JAofTeefAd8sT+0Fs/l4G0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

"monitor/monitor.h" declares monitor_set_cur() which use the
'Coroutine' type, itself declared in "qemu/coroutine-core.h".
Include the latter to avoid when refactoring unrelated headers:

  In file included from ../../target/sh4/monitor.c:26:
  qemu/include/monitor/monitor.h:32:26: error: unknown type name 'Coroutine'
     32 | Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
        |                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 890497b0d22..efdd2165aa9 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -4,6 +4,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-emit-events.h"
+#include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
 #include "qom/object.h"
-- 
2.53.0


