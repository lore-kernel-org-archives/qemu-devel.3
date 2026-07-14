Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88FEC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiwl-0005qy-Mc; Tue, 14 Jul 2026 15:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiwg-0005bs-HA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:37:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiwc-0005Gc-Ca
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:37:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIweap1485327
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 li37RecpOHN+cGlMnRf8KaQVgn0TTXJIfG+QCjT5K+w=; b=XBVj+opDmEMc1wZP
 iNEqDrXgUdlVVXAaINGlDY3mfzXxTrD+sOu7kLp4ILKP5mvceVKTOBDheq5kaHBC
 jUsqER8AciekCXBq/IcZGDsj3sI2AfPThZsr9z/gVG+CWvRXX2wTzjoLzn2AI9rG
 WQ3fN5zHeA0hX8yliRcotgnChXRDRKuo1YzRxF3k05ahlXL/kPVm7dcRUObwqoL0
 4JfwDvW9tze4scW+0iv2BF6VPH5SwsuZNu7Lkv2wbdwsAC1ZdDX7QDyRbWs2cMxl
 xf084Okt7lv316HhhINzpdEVu+bs/OJdrOlblxvQuIvpZyJqK8zNCP3K1BD9+X4/
 quA4qA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqsja9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:37:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso60830286d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057847; x=1784662647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=li37RecpOHN+cGlMnRf8KaQVgn0TTXJIfG+QCjT5K+w=;
 b=bW/54chZAdthh5j4vM7CwgKP3Ea1d1uJr105345dbBJ4k0nRYpfb0rAZkiIr6rpzmB
 AdwBGQnoCvL8TRjU1i+2vR5QbSN78XDbIpuAmopUKqOp+Lo0YcuY+F8n8qH17+aGMJRW
 ZEyxzgkPBs/Zwo0PgGcFJnQcQa/K9SfpCfuk4mu6eH8fiskyP2silYgq2xewbrNpawd1
 ok2Km0wHnn+BIBVUq/U/N5BuiK1tC12kraAXDAM8Az30xPwKnNn4V5VojVw/o/1dklzh
 GtSykE8HItrMJaVRKiALgvmopQ7CTxE5MRXUkLddfvPnaAPfNZCh3a+3uj6ZfCXM3wfm
 QxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057847; x=1784662647;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=li37RecpOHN+cGlMnRf8KaQVgn0TTXJIfG+QCjT5K+w=;
 b=BnPV2zPDNS81WHAqzsqn7I3m2QsouC8ihsy/UJ64b0tX1dsE55A1/3Iw/emkv6M42+
 d4qYY+lHd+7VBgKpmPVYOD7LITnPKrlucgtxpltaLSXKKHaV0LUdaym5iFXxaQ1RsYKO
 9ZHqUCiaoW/xJ2RcLMfXrS/EMWPlqC7xDnJIqgAVKzHXpufi8s2etjbc1D4LM9sKo0AI
 R3fECFEkTUPOc+K/xCptXsVvtwMX82e1Xn7EkJuVZyaOAii4XrNcArWUB4d5lPajBF+s
 +8Tj+AywpY8JQaRtDIu46r7NcnW4Pu+kVMY0Wfk8V19oKGP3Yiw85zvlAW8L4RNesIyv
 gc0A==
X-Gm-Message-State: AOJu0YySCkLtbzQrviD+IHjZlMv4aN8qaxzmy/eLK8rEUo2nDteXeksZ
 xQHHcvhey14/idjKTti80iC6N2klrEPuLLNn/he1uXSffzopx1rxx8R1kC8EQWUHrhyvcbIiD58
 81Cn8ZciW5HXPBd+tgG/IMcvNk+F0RKfWUc8eNkBBsOPcUi84J214f2QVAfZCCFf/5w==
X-Gm-Gg: AfdE7clC0K5wagf5Fi2YgA1DIlYNy4zeMO24L2J1m62bZlBT0FyKnyvcyY94flUDHOe
 8rRtKOjkW2QSjwRF0Kb2E0nlsZljc+VAnOOPc9ADMWuLNbzukhj1RnEcIPCGqJwk1WpsvHa/xes
 suT+vU+prKcFn9hSa9H+avjrCXSoCcFrZz62sC9jhKw2kcn/GEMvYEiBchK03TKnK7Sg24syRNg
 6FOJaiQRFtKJy6Hq374+gx1C42lCbYHvJKDKMIZTYANUKNf5f/VpV59CvZNND0uLEOl6Qe99XE4
 PWPfzQSdy+f1uyhjGGBTx45+Euhe0foLW5Mp/lYPdOxs+Onmx9RPFbjkOeeEw45YWJ/LkAJ7gQo
 ln5g04YIyTj6dYssbo+pzEgOaMfwCPKMOjloC16uW17NMxGYeBN3mTYA2+E3EIUaSjhA5
X-Received: by 2002:a05:622a:1a95:b0:51a:8696:cb38 with SMTP id
 d75a77b69052e-51e42352628mr34116791cf.7.1784057813880; 
 Tue, 14 Jul 2026 12:36:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1a95:b0:51a:8696:cb38 with SMTP id
 d75a77b69052e-51e42352628mr34110411cf.7.1784057802192; 
 Tue, 14 Jul 2026 12:36:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm11514654f8f.22.2026.07.14.12.36.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/13] hw/usb/hcd-xhci: Remove the FIXME macro
Date: Tue, 14 Jul 2026 21:35:15 +0200
Message-ID: <20260714193517.60708-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXyhZUYY+stdJh
 zkIt8Wvofi0+SYVHZHkoxZryBTmKwy/hl3vPqBK9udrCa/VrsaSnuE4itXMWgxZQ/lf8Kb4/Vzj
 N7SBhQFyXooVrBITmMWgxPmC00xesiB7gPavD39pXHehKnW3L+qCWU54FzxLdhDd5E2CzLSAn+Q
 kUXawxD70ZfkXZzdTdphVRl+D2IgMjw/zLy25+R3c3E9jw30tHNCq0RtCFrqfsSwaA5XvmZwGN0
 SCnuSGYUzR7W1Cqc1bPTEX0jxNep4oEPFnsUpmFQi8KoVdSxkRukW1hLTncERyK6Brmb8JH+b0w
 l5l6+DdHy1TePnbluTjdsINXLMWzRgsQe6tgi3XiDWi+6zgnurBv5MDG88pBzXmhXw62OwtRp57
 VtOf8cBwUxKUGcRksedfetDeld1aRUjWh5QCK83s4kt7TeAERIaEl8r4qbjkZU8N3m1exgI7cGw
 yMHYCSj92zqbLD3xZOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX0+orqcp6Hs4c
 9SUAKey8XPGRuFDwhmBbiLniLwGjyc8RdmD/j+6QU0eTe6RcWY0QcJJ+oB6JAfe1si1aOkSdMoT
 ZWnivk6R6d+p4dPmYsAjUby6tQjXSBA=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a568ff8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=X5usCbvhwCoHlLRjaUcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YkQlg_93YEiIxV-cCRvBTZv0etQDH5mf
X-Proofpoint-ORIG-GUID: YkQlg_93YEiIxV-cCRvBTZv0etQDH5mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

From: Thomas Huth <thuth@redhat.com>

The FIXME macro is only used in one case, which should hopefully
never trigger: The containing function handles all the USB_RET_*
values except for USB_RET_ADD_TO_QUEUE and USB_RET_REMOVE_FROM_QUEUE,
which are both internal return values for when an async packet needs
to be queued or dequeued, and which shouldn't still be the status by
the time we get to this function. Thus let's simplify this spot
and use a g_assert_not_reached() instead (and remove the DPRINT()
in front of it to avoid that code analyzers trip over unreachable
code here).

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260713161406.361197-3-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/hcd-xhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f5bb7d25600..cc61e28d33b 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -39,8 +39,6 @@
 #else
 #define DPRINTF(...) do {} while (0)
 #endif
-#define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
-                                 __func__, __LINE__, _msg); abort(); } while (0)
 
 #define TRB_LINK_LIMIT  32
 #define COMMAND_LIMIT   256
@@ -1673,9 +1671,7 @@ static int xhci_try_complete_packet(XHCITransfer *xfer)
         xhci_stall_ep(xfer);
         break;
     default:
-        DPRINTF("%s: FIXME: status = %d\n", __func__,
-                xfer->packet.status);
-        FIXME("unhandled USB_RET_*");
+        g_assert_not_reached();
     }
     return 0;
 }
-- 
2.53.0


