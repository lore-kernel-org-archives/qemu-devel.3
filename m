Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76257C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRP3-0004ao-To; Thu, 15 May 2025 01:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFROu-0004FW-EW
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:01 -0400
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFROs-0008Jo-Np
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:00 -0400
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout02.t-online.de (Postfix) with SMTP id 0792A1DDB;
 Thu, 15 May 2025 07:44:42 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uFROb-0WT93B0; Thu, 15 May 2025 07:44:41 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 758462006CF; Thu, 15 May 2025 07:44:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 6/7] audio/mixeng: remove unnecessary pointer type casts
Date: Thu, 15 May 2025 07:44:28 +0200
Message-ID: <20250515054429.7385-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747287881-09FF955F-D0D75273/0/0 CLEAN NORMAL
X-TOI-MSGID: 0b9464b5-c8c9-4c99-9e87-c71a181284d3
Received-SPF: pass client-ip=194.25.134.17;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout02.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A simple assignment automatically converts a void pointer type
to any other pointer type.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/mixeng.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index 69f6549224..13e1ff9b08 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -286,7 +286,7 @@ static const float float_scale_reciprocal = 1.f / ((int64_t)INT32_MAX + 1);
 static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
                                        int samples)
 {
-    float *in = (float *)src;
+    const float *in = src;
 
     while (samples--) {
         dst->r = dst->l = CONV_NATURAL_FLOAT(*in++);
@@ -297,7 +297,7 @@ static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
 static void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
                                          int samples)
 {
-    float *in = (float *)src;
+    const float *in = src;
 
     while (samples--) {
         dst->l = CONV_NATURAL_FLOAT(*in++);
@@ -314,7 +314,7 @@ t_sample *mixeng_conv_float[2] = {
 static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
                                          int samples)
 {
-    float *out = (float *)dst;
+    float *out = dst;
 
     while (samples--) {
         *out++ = CLIP_NATURAL_FLOAT(src->l + src->r);
@@ -325,7 +325,7 @@ static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
 static void clip_natural_float_from_stereo(
     void *dst, const struct st_sample *src, int samples)
 {
-    float *out = (float *)dst;
+    float *out = dst;
 
     while (samples--) {
         *out++ = CLIP_NATURAL_FLOAT(src->l);
-- 
2.43.0


