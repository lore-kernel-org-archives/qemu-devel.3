Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66924CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgZG-0006No-Qm; Thu, 26 Sep 2024 00:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgZE-0006MX-Ks
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:57:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgZC-00034Z-E5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:57:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so4588685e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727326644; x=1727931444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sHoO++pRV+rtvVWTvuIhS2SE/q8IjIpTMbwImJJNI3Y=;
 b=Sd6GyfykAjCFEX+0LQc1ULyssbXifNQR0Lz2IcT4/yhI016eue3sRasjUZyxgH9UjR
 VRwowgDTTh67GY0FmLIkvciFsh5tdpUFX3OHnFGbodDsDw3yMVt2BlawGCoa9HJVY959
 zETP1arhNq/lh842mybwvUuTAt6jwYJ4eY3tAjtgYMPiGUYcabravGG7Jr7TTAQAriVR
 V7DdQKmgZOHTbby9441eeBE7pAY8adijVlJ4nJH+3JqE2k0yBASnGMOvz6dgjtp6C6QJ
 Xgquu/U5LM3FIsElHkvycp3ILFsi21VwDDm5pmUmge48bYcnNQhlTl74OpeD6zWe+T5/
 RJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727326644; x=1727931444;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sHoO++pRV+rtvVWTvuIhS2SE/q8IjIpTMbwImJJNI3Y=;
 b=LccNVTkXTE+b5tokG33h4LTk3guN19pdH3mnhpfcKyvmfNGLpcYT4h8Hkx9JoO9N/0
 mnNQpSwIN/T+cfYrU40PGjvz1L/DRSoChoo6zELghdVmk3fnN/MMv+5kkLlnMOii1UoL
 V+bymV2mALRdKiQSFvUU88T9cfnEQOumvkg3UowGltlsDPbanRjuMaHy7cvb7UYMvxu1
 x4WpBLYWE7mzWQdj4Ip8lQrjK5nUFqFp5+9T+rrNxGfBA/RgFRCpQaM4Mc3yz3GcRmbR
 kHkXLGxYctK7Zh8eZdqBjUZblRsOiD6LQXPwFiFGGY69MrP9m7VzXALaAECCf8zy8aI2
 bkAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOsVW1VXaMllsZyztUnSAPofpRYKVBCtWcDQrn6mvwZxL5NwnhrNkERl0Ck4dlJt6WIVBTv7hdZFHd@nongnu.org
X-Gm-Message-State: AOJu0YyTLF4yeaNqqmYa1TZb10lcCzS2RoYDTR3FrFsYJCRI2Er3jUKL
 XW2AoQ2Kx4xkSzDIkEisG1SWwsR2QDkK0Yl20hlOkJZt1xz0RzajtNGYL0aPEbw=
X-Google-Smtp-Source: AGHT+IEa4UzQyxsP/MC89b1V28U3nplwISBAtPnskaX6qfysybRPaB7fd27cM1vA1PGJog97F+UznA==
X-Received: by 2002:a05:600c:3b99:b0:42c:b55f:f7c with SMTP id
 5b1f17b1804b1-42e96119176mr29102725e9.15.1727326644114; 
 Wed, 25 Sep 2024 21:57:24 -0700 (PDT)
Received: from meli-email.org (adsl-109.109.242.225.tellas.gr.
 [109.242.225.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a0d8eesm36142865e9.30.2024.09.25.21.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:57:23 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:52:27 +0300
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
Subject: Re: [PATCH v2 08/22] hw/ahci: fix -Werror=maybe-uninitialized
 false-positive
User-Agent: meli 0.8.7
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-9-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-9-marcandre.lureau@redhat.com>
Message-ID: <kelrm.tpdvgy1258l3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
>../hw/ide/ahci.c:989:58: error: ‘tbl_entry_size’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/ide/ahci.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>index 7fc2a08df2..d700986c39 100644
>--- a/hw/ide/ahci.c
>+++ b/hw/ide/ahci.c
>@@ -948,7 +948,6 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>     uint64_t sum = 0;
>     int off_idx = -1;
>     int64_t off_pos = -1;
>-    int tbl_entry_size;
>     IDEBus *bus = &ad->port;
>     BusState *qbus = BUS(bus);
> 
>@@ -976,6 +975,8 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>     /* Get entries in the PRDT, init a qemu sglist accordingly */
>     if (prdtl > 0) {
>         AHCI_SG *tbl = (AHCI_SG *)prdt;
>+        int tbl_entry_size = -1;
>+

Semantically it should be 0 instead of -1.

Either way:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>         sum = 0;
>         for (i = 0; i < prdtl; i++) {
>             tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
>-- 
>2.45.2.827.g557ae147e6
>
>

