Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC9CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgI2-0003HC-5b; Thu, 26 Sep 2024 00:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgHz-0003Fs-Ny
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:39:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgHx-0000eV-Vx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:39:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so4368305e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 21:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727325575; x=1727930375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3gogcSzT/KX5dTe+H4U1xRcPecVfpNGwrC5LBpH95M0=;
 b=ZdCGvBIaAN89eGDxpuj93m+H62Zc+ZiwsRonwepk7C7JOdPjxUcpmHIj8kZBK8AsMb
 Mt7nsczEwsZTWo25RNZSDOuUU97LM9zpXsGW7np7rU7Tdtbl0fgEke6pfqQtZuOWAZS+
 Rp0w0r/eLqnDPoyddS4lXWFliTgN+4vDjSmMAAh8lqV4BZPKh/P0j2d6uEgbqTFlnucK
 DU068qOY7BRNDZSoyRiLE9e4pAuhE3f/gkoAa/3J3YHBPiX9+nJ6qAtfHBTN/R6B4aiN
 vmdYspLvS8h2BX+0SZy1olTNwITu7X77CO76D6SfppwjD8nVobkWk1ZWtGx3Y2oBvMHo
 bUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727325575; x=1727930375;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3gogcSzT/KX5dTe+H4U1xRcPecVfpNGwrC5LBpH95M0=;
 b=fiZNkhdJWfqvLwg5a1wKt90RCi8OeDg3wUP5WZits4fanuYP28BWZJn/i5Up2GHFv7
 Zs0CSEka72nK4+qTWNwe00dKLDHoalAq6yWHdNT50rIOmRqSyJ7K3e1mpp4Pv1UvzSEs
 dkEEQGWoTAk9pZUOJFUNjEASrKMNqZpcofdUCt3ZWZR3tVQqNDh/Uv2mACr4soX4Ccvu
 e8VIXuD+sbJgGmrDXw2D7kbDRkXRNJtokRzxe9ly2yJxMRaILzDZj/DI0VaLgHmCIKd2
 01koPJDTiyYgbHs401+CFn6vLVGAb/3mMC3Gn2Uztz2qosvqUdp2EQ5eoX00kAK9CVEN
 D4gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7j+PBaBVaDodFD91qbQos2pDIuIpQTxw/Q7GE398gTByPdCKJOC2UHYNQNrV8NltLGTCLNnhpFiuZ@nongnu.org
X-Gm-Message-State: AOJu0Yy1Q7mzufQuUitOjKmk3XCrK710ELKYv/ZHGpA/PvmMW+gxLG0f
 hj1bW/eo+5wnPxTIbT78pjsgoq1qmv9ijza9E3L4hltD0r1I/luuUHNoVAq8tEI=
X-Google-Smtp-Source: AGHT+IErp+buCzgoosf9IBp+WBbRF78ItDvBZi0zgPem+5TRVOw4VKAn3/M7J7SBvaVOVuGbpORwdA==
X-Received: by 2002:adf:a341:0:b0:37c:d02a:7e41 with SMTP id
 ffacd0b85a97d-37cd02a7fefmr206717f8f.15.1727325574917; 
 Wed, 25 Sep 2024 21:39:34 -0700 (PDT)
Received: from meli-email.org (adsl-109.109.242.225.tellas.gr.
 [109.242.225.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c143fsm5375724f8f.28.2024.09.25.21.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:39:34 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:39:02 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Hyman Huang <yong.huang@smartx.com>, Klaus Jensen <its@irrelevant.dk>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9_?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9_rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 02/22] util/timer: fix -Werror=maybe-uninitialized
 false-positive
User-Agent: meli 0.8.7
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-3-marcandre.lureau@redhat.com>
Message-ID: <kekxx.dnzrkwmhj8j4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 24 Sep 2024 16:05, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>../util/qemu-timer.c:198:24: error: ‘expire_time’ may be used uninitialized [-Werror=maybe-uninitialized]
>../util/qemu-timer.c:476:8: error: ‘rearm’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> util/qemu-timer.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>index 213114be68..c948cb1b72 100644
>--- a/util/qemu-timer.c
>+++ b/util/qemu-timer.c
>@@ -182,7 +182,7 @@ bool qemu_clock_has_timers(QEMUClockType type)
> 
> bool timerlist_expired(QEMUTimerList *timer_list)
> {
>-    int64_t expire_time;
>+    int64_t expire_time = 0;
> 
>     if (!qatomic_read(&timer_list->active_timers)) {
>         return false;
>@@ -212,7 +212,7 @@ bool qemu_clock_expired(QEMUClockType type)
> int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
> {
>     int64_t delta;
>-    int64_t expire_time;
>+    int64_t expire_time = 0;
> 
>     if (!qatomic_read(&timer_list->active_timers)) {
>         return -1;
>@@ -461,7 +461,7 @@ void timer_mod_ns(QEMUTimer *ts, int64_t expire_time)
> void timer_mod_anticipate_ns(QEMUTimer *ts, int64_t expire_time)
> {
>     QEMUTimerList *timer_list = ts->timer_list;
>-    bool rearm;
>+    bool rearm = false;
> 
>     WITH_QEMU_LOCK_GUARD(&timer_list->active_timers_lock) {
>         if (ts->expire_time == -1 || ts->expire_time > expire_time) {
>-- 
>2.45.2.827.g557ae147e6
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

