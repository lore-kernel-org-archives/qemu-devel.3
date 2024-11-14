Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC15D68B01
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZLm-0003T8-Gb; Thu, 14 Nov 2024 07:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZLl-0003SX-QJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZLk-0005UH-4I
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731588807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cXVPkM0170TEFy/IjrILSCLqMh1V/FCONC4DHuWjqQ=;
 b=I7vE+6hVISZ1aiIKTXlL7rLWkbcsnBNxj7SlKGT18+vMTWTsn+NPlnXqDiIf8OI4OYtVIT
 aOVFniJS5EttPQh/HHrARA4zuBWKzbRhrbed8Q/Jh9LeFog2XQf/7574fZL9TBao7gtLQg
 TpdOfvMrWNijK0OAYaQiuGmU5kEczgk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-e40qVt1RMnKEKQRjYzF8yg-1; Thu, 14 Nov 2024 07:53:26 -0500
X-MC-Unique: e40qVt1RMnKEKQRjYzF8yg-1
X-Mimecast-MFC-AGG-ID: e40qVt1RMnKEKQRjYzF8yg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so4357845e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588804; x=1732193604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cXVPkM0170TEFy/IjrILSCLqMh1V/FCONC4DHuWjqQ=;
 b=BgQKT3QjvSGF1s+aVuaybn49iCvQBqTJj2MCsBLy+tpqXU8jl+ddWtFyKG7kLzqsfI
 hRjcdBd20ZcyVi6gaBu+luv7L+OMsG9nhlG1gabVGO7cKmSWSI8GWGIkgmdbvEeXiua5
 sGSg8kg4DiITXvNHyepT3/j0DdRoDu6t0Iq1mFhHN+OvwdomA82vnm/OplSVtOxFXc4+
 UX90D4BjsOtBqt/0JJRCjF1Ssk6U5B32GJMmv0LAMFSJ25+Q6ewm2fPxfvNU9J77btHE
 42Tb8Cj6gVJDBNt1qLYZs1rrVGIZvIX66Xh+ny3IyWa1NiQT2rJxCKXOU55+YjgqpPVn
 2weg==
X-Gm-Message-State: AOJu0YwysWnjXZyt6e/kAbwNOLH6xg+aSvGgSAV0g8hm1tO4isv3pAL9
 RWNhIHJ8VC5dWX+m4//39P+jg7lOEh9Toi2V8He9N4hRKTV2hfqILdsrKi9IpWclsYHxKEzvC/j
 Lyhw544cPVJf5xQPm2TToq/tBkcfpXFf+xyv+MCy8krR+kFKaq1IApPmlMm6bBdTdy3IUPsfdrI
 3oW/J8NB5MSqLA+cozaVsf8dmPGR+loS5Dw5Q4T7A=
X-Received: by 2002:a05:600c:35cb:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-432da77f1ecmr18488745e9.13.1731588804472; 
 Thu, 14 Nov 2024 04:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtWOjSyACHpjrQPtye2XfhzEMc9TysELFO6ycQ0LSzy72ydoPCNfBcx1GvKOpUFOf44rfQug==
X-Received: by 2002:a05:600c:35cb:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-432da77f1ecmr18488515e9.13.1731588804070; 
 Thu, 14 Nov 2024 04:53:24 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432daafc6b3sm20539235e9.0.2024.11.14.04.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 04:53:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] hw/audio/hda: fix memory leak on audio setup
Date: Thu, 14 Nov 2024 13:53:18 +0100
Message-ID: <20241114125318.1707590-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125318.1707590-1-pbonzini@redhat.com>
References: <20241114125318.1707590-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When SET_STREAM_FORMAT is called, the st->buft timer is overwritten, thus
causing a memory leak.  This was originally fixed in commit 816139ae6a5
("hw/audio/hda: fix memory leak on audio setup", 2024-11-14) but that
caused the audio to break in SPICE.

Fortunately, a simpler fix is possible.  The timer only needs to be
reset, because the callback is always the same (st->output is set at
realize time in hda_audio_init); call to timer_new_ns overkill.  Replace
it with timer_del and only initialize the timer once; for simplicity,
do it even if use_timer is false.

An even simpler fix would be to free the old time in hda_audio_setup().
However, it seems better to place the initialization of the timer close
to that of st->ouput.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/hda-codec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 74c0292284e..c340a9481d5 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -487,8 +487,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
-            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    hda_audio_output_timer, st);
+            timer_del(st->buft);
         } else {
             cb = hda_audio_compat_output_cb;
         }
@@ -497,8 +496,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     } else {
         if (use_timer) {
             cb = hda_audio_input_cb;
-            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    hda_audio_input_timer, st);
+            timer_del(st->buft);
         } else {
             cb = hda_audio_compat_input_cb;
         }
@@ -726,8 +724,12 @@ static void hda_audio_init(HDACodecDevice *hda,
                 st->gain_right = QEMU_HDA_AMP_STEPS;
                 st->compat_bpos = sizeof(st->compat_buf);
                 st->output = true;
+                st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hda_audio_output_timer, st);
             } else {
                 st->output = false;
+                st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hda_audio_input_timer, st);
             }
             st->format = AC_FMT_TYPE_PCM | AC_FMT_BITS_16 |
                 (1 << AC_FMT_CHAN_SHIFT);
@@ -750,9 +752,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
         if (st->node == NULL) {
             continue;
         }
-        if (a->use_timer) {
-            timer_free(st->buft);
-        }
+        timer_free(st->buft);
         if (st->output) {
             AUD_close_out(&a->card, st->voice.out);
         } else {
-- 
2.47.0


