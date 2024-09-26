Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD4CCCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgUI-0001H0-E2; Thu, 26 Sep 2024 00:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgUG-0001GK-DL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:52:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgUE-0002ea-Mo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:52:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so4719435e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727326337; x=1727931137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HLUc6IXcf4JTIyonuOIkJjvzd1HfdQYqAEJplhDCdoE=;
 b=WdYcTZ0TxhdQ2BNe3+jlQHD4WlAA6O3/QzBR2qaFW7l/J62WTg6wiUqfg0imB77nYS
 o/ngZ63Mj34Y179ho4veMUvNBO5+WRTL1wzPa+DQTcm1rEgd9/K+jMc11+o1f8hOmPuH
 QxdGGLLjsbUP6Fr1sDpsXuGmjJljPPpNDS5q+AdCX9J2XC3YQfRAM/bJbXXKHqwLa9xm
 SxAuH8ZBUzRPG5B2AZdu+FbTB/6k9ybGsfYxNbM+Qt2XoFuVtNToDsInRDh/XZSKRSaW
 f2L9vOOd/0YEx7tz3l4W7CPJNBqZGV8EiNncij2X+29obooE/UkeY5XFmw/ly/+NuH1a
 h5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727326337; x=1727931137;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLUc6IXcf4JTIyonuOIkJjvzd1HfdQYqAEJplhDCdoE=;
 b=ahJUnJ6M6yWnGEa32kqC7eZLXwBHkuH5jmSjB8i8IBjLZgGs9lFJEy+M4Xe+wwpR18
 Z0PEc/uFPUwcCsROIgiRFsIvcRitjyj0860GbRQApXRDGijVFZzKXRObLfjQWYJIEQKX
 1S34LuT+siCQVCcxYXU1M+f0yuu/DLS9zUyuJMRV61Ow2Xdfe5Gh3o+7p65gPxAto71F
 ALQBT7lJnzbX+YSweDp+PtGvWenCx0Ou8yq7/KVGVtx6KVs8FaXmdx/WujAYJNWHQ0Pt
 iWNFUFaPZKr8YVHxCzkVJ0P1XVnu6YZyLMBbZuf5LKDJKE/aJBJzvVmj/Tp6M+3W5YT0
 1VDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvePZYLwRcWNsOAA9ihuFd3wyKF59OT5XJS+3kvsc/IMjGDjb/w5n90UUR9OzmiPyCGlucXyhWa88W@nongnu.org
X-Gm-Message-State: AOJu0Yw/CJMYmOGnQHvoh5lKgyMNZ3AOo7Ssl4dtIx9wuUzsbrO3W5Ah
 1ImnRacxLw5lDL195VQ21Mvdp0FHKdba17yrDOXFB8yaySTBTHOSbGARSQBqgwE=
X-Google-Smtp-Source: AGHT+IEejKXfIoJnPiYBMmHJJQ6QeLqK9SorG57kY2v6ao2iHOrcoLctNWpbeg1Y2Jnwd+4PlXgMuw==
X-Received: by 2002:a05:6000:1288:b0:374:ba2c:3028 with SMTP id
 ffacd0b85a97d-37cc24c5ad3mr2555727f8f.36.1727326336959; 
 Wed, 25 Sep 2024 21:52:16 -0700 (PDT)
Received: from meli-email.org (adsl-13.37.6.161.tellas.gr. [37.6.161.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f244asm35130635e9.17.2024.09.25.21.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:52:16 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:50:15 +0300
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
Subject: Re: [PATCH v2 07/22] block/stream: fix -Werror=maybe-uninitialized
 false-positives
User-Agent: meli 0.8.7
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-8-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-8-marcandre.lureau@redhat.com>
Message-ID: <kelj3.9xegcjaacjj@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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
>../block/stream.c:193:19: error: ‘unfiltered_bs’ may be used uninitialized [-Werror=maybe-uninitialized]
>../block/stream.c:176:5: error: ‘len’ may be used uninitialized [-Werror=maybe-uninitialized]
>trace/trace-block.h:906:9: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>---
> block/stream.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/block/stream.c b/block/stream.c
>index 7031eef12b..9076203193 100644
>--- a/block/stream.c
>+++ b/block/stream.c
>@@ -155,8 +155,8 @@ static void stream_clean(Job *job)
> static int coroutine_fn stream_run(Job *job, Error **errp)
> {
>     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>-    BlockDriverState *unfiltered_bs;
>-    int64_t len;
>+    BlockDriverState *unfiltered_bs = NULL;
>+    int64_t len = -1;
>     int64_t offset = 0;
>     int error = 0;
>     int64_t n = 0; /* bytes */
>@@ -177,7 +177,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
> 
>     for ( ; offset < len; offset += n) {
>         bool copy;
>-        int ret;
>+        int ret = -1;
> 
>         /* Note that even when no rate limit is applied we need to yield
>          * with no pending I/O here so that bdrv_drain_all() returns.
>-- 
>2.45.2.827.g557ae147e6
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

