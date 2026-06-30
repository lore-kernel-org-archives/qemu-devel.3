Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77AAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegYK-0003xN-GB; Tue, 30 Jun 2026 18:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXT-0002oM-6m
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXQ-0003u5-Tn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:42 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDkar2947120
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uDWJymj80vwbof4Tx7YxMX1WHF7pu8qLq5dCap8A0DE=; b=eKFHOdDm+pbFEUBn
 vL2oFerUct2J6oXbbALBkKQP9T99oBjrYY90s2M5wf908NJkqpecAXZB0hi0XsiE
 CoyCYpTotrTeSk7HIxWdExFcjNHp7gycXYNCf+qQF/bZ3+JhOSSaT6uyKwzhTsK9
 C6rs+YPWi2ZaF7oL9egYwdFvxV98QBWqID0fLRgkkn/CLdWNuxE4ojYc0zX1ZSl2
 SEweC+mnXdAZp8DneXtG8hA0wQdsfYSTZhhZHsYP5doLgbrzjQSoFRAylJ4VAk1s
 xyhVSTQgm1C3JS3zN7cxvgAtNuVgZdrn8g6SFTwj8G8K7E8R5/HCRNq6p5xzMEKX
 bgjmLQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avpucn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:28 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-69e89d83663so4263eaf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856948; x=1783461748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDWJymj80vwbof4Tx7YxMX1WHF7pu8qLq5dCap8A0DE=;
 b=SL5dNMHZnhx8ZtwZ1DVn46C7ibgWz5LRWo19YzTnVJYnT/PGsFtNxNXB3rJQjkiC+E
 IDi3z4q8uAYjhaAmHLS46u0nhyVeu/z7Jak9G0R2fat5JMR/pQH5QoIuzt097WR3UdsJ
 JNvaLZtmqGs5990GkyajY5Ybmk6F3rBUb7+DjxjWwsGR39wcfOGzj7+bEZRfNvD+A/Sk
 QZQcmSGuMetVldE9PErawM4IZiia9z8rfp+Pw94Gf1BLKqifoWzkXR0o6lqVLY8WSclO
 7O5F6TtcnQl+GtJ1VADO3P2tpsbQ7L7nnGU5rVuXvhX6A3ab5QEP4Wcj6lUivJhxl+Xz
 Z77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856948; x=1783461748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uDWJymj80vwbof4Tx7YxMX1WHF7pu8qLq5dCap8A0DE=;
 b=NCXSaFGPbAHAPl3r81esFMXH+mdYGFw+cMH/Uj0fsGfbzZayvYHOKWhzknP8u0ZTiK
 T3AJQDrbVyivtfb5v1X2YeGtAWL0sAfXJju2tubKws399gQyvAugk4eL0N7vGUTgJ+G1
 iSnS39qZTTBBQtVMBxECCtdfQl3cwFMAd4t4EwSFy/yFhGcMUF2YZmay5LI8S2DUgOYv
 3DeY78QhQuumfPapzmed+qWevqoTfcYCS/gN7WcanPyowrs9qFWMRQ0kBMYxwGRuOKhU
 JZAoiU67uqobxr9Efe4h5NCqIsTdUQRVaWXU3I8ZbXPv6iEGHDmoACkLzqklzyfw2RE5
 OtEg==
X-Gm-Message-State: AOJu0YwRUW1zVN3e+FBvwcVNrsXBRk88mt/evevMlw6W/DlqXUc70V15
 UNRNbYCSX4d+1YANFeC2m8lz10FxPfTqgJtMTRwkfnlmKvPirXb2w0288ZDS4YUW7lNCs6kughj
 CVvljVSDQF0gsSAV1xmQcnN5b/JaAB9bob89NaYspWPzNNyJs+NSVgL9C96V8xyTakA==
X-Gm-Gg: AfdE7ckU1skRAiYFSget1mt4wZlYe3ldnemUBfX//Uk8hek48fMFY/jTwwKoDimdxhm
 MH1536p9ojlAhM5cgmmxRgE60hYV7U4TOocaky3BxIMKGbXZz5aqkk/qwPH2cpZG75Sji17JaL0
 m348niZCtB7ne8q8RweMDQZ6AKvcaLsqtPyAPtOxHxxC2VAFUSVbtlKPOgtUsv5eljlcoN7eDnp
 ECbuJYlPHsYnxhPzE/XiqvaL7TCiPqvMh9HE0MXsqYVjwK/MPZVg7/IPFhZ5xrtzjhm3CAHvtkX
 SCu3y6uiB4wG/MkVNfj7ITOnlOFwdaqbxGwxRB53LsA2Weou473CGTP+kDewWESagYh5igRaGGl
 2ByCQpDEuWMh6HUQrqeW/ubnGukXENwtfRxKxJash/xndbQUTBOIWX8v/DZiDzyJWCs9J
X-Received: by 2002:a05:6820:16a5:b0:6a0:e37e:4614 with SMTP id
 006d021491bc7-6a196c50f99mr1515169eaf.40.1782856948206; 
 Tue, 30 Jun 2026 15:02:28 -0700 (PDT)
X-Received: by 2002:a05:6820:16a5:b0:6a0:e37e:4614 with SMTP id
 006d021491bc7-6a196c50f99mr1515148eaf.40.1782856947732; 
 Tue, 30 Jun 2026 15:02:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4fef11sm22819365e9.15.2026.06.30.15.02.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 11/33] gdbstub: Store @can_reverse in GDBState
Date: Wed,  1 Jul 2026 00:00:38 +0200
Message-ID: <20260630220100.1289-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kMZILRAVCaLgp4P6JLyfxqgtZuALnMpT
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a443cf4 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XnORNqxp5neGsmUcoQsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX6/W9w2y/Iu35
 jZJFMstVE5VnlfgXkL5B8J80vp81sdIfwr+PMgzQ6CG/AAt0uw2Mut4Uu3gENqfN6F7cB63QYD1
 xBvvd7IcckjU6/+UBmC2aCowKL+MyjRGE43im869e7U0KlVlniYU+wGezuV2wSyQpBRfA+gl0oC
 ixgAsA5e93inWe6zcT+ZP85HwxDT3AxWH3T3eEGF6XO2E7YaW9CGLeZd1r9GlQbIG7fEwbDeQ9E
 sozOBl45K0lGFMlwhnFFNQ5KHGuSnf+ff5VvRvJB4jvxV3jTPJ7YBZROnUqYU90IOTF3uddUvDm
 2g2bGv4AGAUZMGnWPBwsIi12sfOtLU/6JSpd4KKc9CG6jJsvnyFaEyjnCBp6NKwq0lI7whdUzDd
 64eICCMiJhPRRp0q+I17Vm6VU815t8Kw0WxeWsrtjYRwMuARmccppxhCnPH5TC1z8yqKSQJQ7Rt
 KAIIjTNts/CIhAl+e0g==
X-Proofpoint-ORIG-GUID: kMZILRAVCaLgp4P6JLyfxqgtZuALnMpT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXybhgTGCavndE
 MwvP5F1kq6VYfyBuq14DjSaz42cih5Zbg8dUxMbF7u6d360xSPEHqQg+FFwzd2XSLEugMA8FJ2u
 l30GDaw5wLZPzg/gx5M+okpVzcILZ3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Call gdb_can_reverse() once in gdb_init_gdbserver_state() and
store the result in GDBState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h | 1 +
 gdbstub/gdbstub.c   | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 9b25bf58b8e..9a1b8d9dd8a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -85,6 +85,7 @@ typedef struct GDBState {
     GByteArray *mem_buf;
     int sstep_flags;
     int supported_sstep_flags;
+    bool can_reverse;
     /*
      * Whether we are allowed to send a stop reply packet at this moment.
      * Must be set off after sending the stop reply itself.
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1e0a6638bff..0037704d522 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -75,6 +75,7 @@ void gdb_init_gdbserver_state(void)
     accel_get_gdbstub_config(&gdbserver_state.supported_sstep_flags);
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
+    gdbserver_state.can_reverse = gdb_can_reverse();
 }
 
 /* writes 2*len+1 bytes in buf */
@@ -1376,7 +1377,7 @@ static void handle_step(GArray *params, void *user_ctx)
 
 static void handle_backward(GArray *params, void *user_ctx)
 {
-    if (!gdb_can_reverse()) {
+    if (!gdbserver_state.can_reverse) {
         gdb_put_packet("E22");
         return;
     }
@@ -1684,7 +1685,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
-    if (gdb_can_reverse()) {
+    if (gdbserver_state.can_reverse) {
         g_string_append(gdbserver_state.str_buf,
             ";ReverseStep+;ReverseContinue+");
     }
-- 
2.53.0


