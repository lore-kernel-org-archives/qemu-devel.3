Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F8AC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDw-0000UV-N9; Sun, 16 Aug 2026 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDs-0000Ih-CL
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDp-0001yw-OG
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkmcS2760393
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EVTMZJKsYTIXB0uIpj4jwnCmJ3xCFkAx7TnXI4n4Elg=; b=Ge0GTyp5y7ZgSjA0
 eJ54km56kKVaMZhsN2YqPzhJ7Wqy7ZGQ09JpjhCwsLxbomk7m4rFEuRGkKOQF51K
 LfWyhV4IvfCNQZy4K/K++xpzzjSaKRK/Z0m2o0d+jwRgjwR56b2Pv4nam5oiMZiM
 6VwuXORZq7JZZ5tLEe5Pd3hUH5QFH4HzfvzfOE/XP2GkK3RgZryeshK5dBs4IVsd
 oBrhf7aKV85ttHC8vQVl8QKS+MsJVYxnoD23HCpw0srIaL5/NUWsWF6RPsXdF3k+
 1ifikf/L75497/Zm8avxfVBEt8cQZuNAREYaIIkk3lKyvu5e68iJJN7odJeZ5P3v
 Ia9/Fw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkhb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso45131221cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891943; x=1787496743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVTMZJKsYTIXB0uIpj4jwnCmJ3xCFkAx7TnXI4n4Elg=;
 b=Uw/WOaPfvF5GceVhKttanbRCcT4eS6QKN5CAZ5nQOc26g3AZOGL14egLbMFgevxIv1
 wj5bgdSFS2i3Li+jnZ7anD7GsbndKueY30EiQJk1csgPrte8+6XRA3VkhCmZaRRZ9YLh
 4iOnd7UVTUnFcooO3GlLcvzjkFRFEm59SepdUrqjUGiNFDjhtQ+dSjaPqyWdaiJUvbiX
 D7IjdfYBkQn3XxC/pOC4x1gB1gqndiSLISBwybx3jLU78ocDPI4JjPuVefdpQ6mblu50
 4rtRmfuwlxdUD3jrMdbsIIVSsgcFRXcgIE/dyIleK8L/3WNIMf1/YcFV5ikjtwRwmT5a
 rxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891943; x=1787496743;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVTMZJKsYTIXB0uIpj4jwnCmJ3xCFkAx7TnXI4n4Elg=;
 b=rc5k6MkqYg8B0zAZLGRL7z7EwGt82+nQ29d/vHWURck/XXll72t0LwDBLKk9G7ft2m
 zd9TlAScmo6OnbtXOgm3BqHTxEqy2HgOu7GsOnY0kIZVZobRG7LkjKXPdX81zN7CIMO9
 tcg3mjPFiIkjanZIcJFgo9iy3goN8htaeFZAYkvIYNJKxFHeDjTLA32MtnX1R+cSdG71
 FMIMUB7xt/484RjUUPigVX3cLj7JyIXZXcXNOkMpWPetYcj0l8gWIUvQXLG6kS1jsf4L
 M1DeBbuH4LxPCLfBt+AOXEfPs8hYzQoJn2QShoNv3MBOLHoXTNh2RUwXW4RiD6EGekDZ
 bqfQ==
X-Gm-Message-State: AOJu0Yy2Sz0pNABigrTtstYDj66xRO4AcUh6C7ZVCxTFy1aM35N9D26f
 VweA/9fXOBCPCw6GlV7jUrsAJuhtbgV/4IfjaMF9Z6rhNg+T81i9ojsgW8OLegEXQXTyW6l6p4x
 oFwmJo1fz94AOJu4VXZ21uflHQEBuMGazzuDBsoLdkaH+zlqfEW6ABox70ICS79j/Qg==
X-Gm-Gg: AR+sD10ksAbpSRsmCThCOdu39DA46zuIFmY0NkS0ILB0pLcT6MNi9vSkIw6OGjBY65M
 51CMR1C+Gos5gyQyicNwTzRcvLmZ3tfTB3G37NgJlLEL8zuZ3s6ypPePMwsoaqCqaB2HyYCQap4
 nXvWyv3TwhEGLRSe5z9mqdPDWZNeqvQQiVqcTXF+98fPa+PYWDlNwVk0Q06uq/bmvAmOU8Fe56u
 Dey+C1pJA5CDo5+221GwgVznP41POECILSDFyQnfwePli2eRIHX4i28Iz9QnTeW1ksu6O4pOX1x
 TZmeEZndREweDn4K1qJwcOaXg6BWqS9t3zYYE+TCgcFk0YT8+j+/Xscurcbw8tthQ4ZMgFu9nzS
 e6p7QKKBuaelutjjWg+I7SJ5Jlf7e0gH7nhz8HQBl0Q==
X-Received: by 2002:a05:622a:1445:b0:528:3471:9390 with SMTP id
 d75a77b69052e-52d8535dc23mr166721001cf.10.1786891943450; 
 Sun, 16 Aug 2026 07:52:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1445:b0:528:3471:9390 with SMTP id
 d75a77b69052e-52d8535dc23mr166720801cf.10.1786891943006; 
 Sun, 16 Aug 2026 07:52:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996183b89sm67527395e9.12.2026.08.16.07.52.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/56] monitor: Reduce inclusion of 'qapi/qapi-emit-events.h'
 header
Date: Sun, 16 Aug 2026 16:45:44 +0200
Message-ID: <20260816144556.69009-46-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AcdOtkz_MhjbDhlCQwt38F5Q0x9vd16p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX/OFicLS63PHO
 VS1/OFwRZnTshxEIQYZ17CkfhyBK0puOx17sTBAZl0Mk1AlzVRAr8Pd/PlekMY5VuQuNo98vLLs
 HpXFAITL+mDjM4Z2UOAwE0MDgnw4uMc=
X-Proofpoint-GUID: AcdOtkz_MhjbDhlCQwt38F5Q0x9vd16p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX2SGkbQ1mIpJQ
 miJnIEysO5WwS20Mu9w8NbChDXqJMWbL3LT6sTkOgxbAPDsVy7SNDRBN/1EdVe4O0zuvp0Z4Qjp
 Ea/ni9BffOifeotx/gNZoSr8pVNNYNAJgfyygOVVSwZk+dhuqTD+mrkqlW7lYXpDGXu39PsK/fm
 6P5tlgSRyBlUsHOZ+Q1no2P/K4P3Bbvpoie5sxwBGlKBcJFOoLIggNz3lBfreVUJqe+NOMYDqCl
 f/xOcNFGPnM+ep9499y8qqBfty2l454b//GTrTvDVJjQJ1sDzrv/qqgftIbuEhIPW6IoGmseSqu
 gYY7LMsV/e8Bwy/33Iz7/6kirIjzVin7hIpl4pWvZNTBKXIlaBrtJwrhknVylthx96AyUhoL6cu
 Ku9HIiZBZM1DFjHNghW/VkMTstJiFWcQEbEzJ2TDRafpdoJmw0esPDLN1EiY9s2WE07ORBkz6mG
 ObdKOXemjSuReonVLCw==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cea8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-11-philmd@oss.qualcomm.com>
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


