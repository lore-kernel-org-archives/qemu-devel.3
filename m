Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4D0C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJe8-00023J-C1; Tue, 23 Jan 2024 11:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSJe0-00020y-IM
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSJdy-00011k-4E
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706027336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkTIflMbohMk3ipU5K7Kji0HTe2S7ThfsmZ3XUnbW+E=;
 b=RRm6p95x7ZisGTr7t+9vhy8e6BZee1jghKTF6BdSUuPRr+TgddAZ+y2X1IoXZfx27DvhNF
 Dp3A15OCaod4/yNJ0KLuUI6+PhCQ7O4R5oThcflNvBpBPwmafKtLaTBl3peZDyVVKjNLuM
 biOJ9l4IEWsHDvI0dmuDWt5hw9cbPzU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-xQKk0bS9OCSxOFrXPmJQXQ-1; Tue, 23 Jan 2024 11:28:55 -0500
X-MC-Unique: xQKk0bS9OCSxOFrXPmJQXQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3367e2bd8b0so3340624f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706027334; x=1706632134;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DkTIflMbohMk3ipU5K7Kji0HTe2S7ThfsmZ3XUnbW+E=;
 b=JDAOqNIzN4oBo0LmFi8NiqPUgMxspCjsVQEgjrMfyO0La+dN7xqE2fmKtNViouVaSl
 81AOrq6BgvJLNQMYh/ih+ouxijatJf7y79r9pCPibnZwtWrcNJgctF5B69H4v9X8x2jj
 HpGPnRKeednVcSN1iy/70uSVNLe2TmlAyEpzA2IRmTAtE5gslZAc+QaPyOncq1LdAJIJ
 3deTtXElnVoffcApB7nHLSpTn2GlZBf5Cj2lFtB5RTvP2k9sG8c0gowMMJ/vgk/u2oAO
 Nk8XGryTwubbLjZER8SiENRFdj8jfsYrC6qdO/8zCgSnDPOd69dHx2VFtaSnWWHt7KSY
 k7qQ==
X-Gm-Message-State: AOJu0YysrLy7W4lxSIH1vfdYgwaKx3wNJVNK0QrxgYZe1u6Gb2GfoJc7
 VfcsjApUZ5HLu5AoQslqWqTksxSZUOrJ/TlB5m4Rh7PaHgbluSW7QPISkNr+M6qlMbjJI+8p3zS
 8XZLBVamN3LEX8g5Zoh+AQarrOrTjMSzYjmEPJFsoinoyNHRo4xII
X-Received: by 2002:adf:e8c7:0:b0:337:bebc:3f4a with SMTP id
 k7-20020adfe8c7000000b00337bebc3f4amr3338083wrn.81.1706027334294; 
 Tue, 23 Jan 2024 08:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1h/tjwaarIFBjBRI7zWgLMxsx7QGRNAH4BDf6cLTNvlC4CdgZ31x5Gdevf8YoQubQ+DWLJQ==
X-Received: by 2002:adf:e8c7:0:b0:337:bebc:3f4a with SMTP id
 k7-20020adfe8c7000000b00337bebc3f4amr3338074wrn.81.1706027333969; 
 Tue, 23 Jan 2024 08:28:53 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4143:2bf6:228a:1b7a:e384?
 (p200300cfd73b41432bf6228a1b7ae384.dip0.t-ipconnect.de.
 [2003:cf:d73b:4143:2bf6:228a:1b7a:e384])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d4b10000000b00337d4eed87asm13719007wrq.115.2024.01.23.08.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:28:53 -0800 (PST)
Message-ID: <952baf9c-eedf-40af-9865-91557a804b9b@redhat.com>
Date: Tue, 23 Jan 2024 17:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 pbonzini@redhat.com, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
In-Reply-To: <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02.01.24 16:24, Hanna Czenczek wrote:

[...]

> I’ve attached the preliminary patch that I didn’t get to send (or test 
> much) last year.  Not sure if it has the same CPU-usage-spike issue 
> Fiona was seeing, the only functional difference is that I notify the 
> vq after attaching the notifiers instead of before.

It’ll take me some more time to send a patch mail to that effect, 
because now there’s an assertion failure on hotunplug, which bisects 
back to eaad0fe26050c227dc5dad63205835bac4912a51 (“scsi: only access 
SCSIDevice->requests from one thread”):

{"execute":"device_del","arguments":{"id":"stg0"}}
{"return": {}}
qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context: 
Assertion `ctx == blk->ctx' failed.

(gdb) bt
#0  0x00007f32a668d83c in  () at /usr/lib/libc.so.6
#1  0x00007f32a663d668 in raise () at /usr/lib/libc.so.6
#2  0x00007f32a66254b8 in abort () at /usr/lib/libc.so.6
#3  0x00007f32a66253dc in  () at /usr/lib/libc.so.6
#4  0x00007f32a6635d26 in  () at /usr/lib/libc.so.6
#5  0x0000556e6b4880a4 in blk_get_aio_context (blk=0x556e6e89ccf0) at 
../block/block-backend.c:2429
#6  blk_get_aio_context (blk=0x556e6e89ccf0) at 
../block/block-backend.c:2417
#7  0x0000556e6b112d87 in scsi_device_for_each_req_async_bh 
(opaque=0x556e6e2c6d10) at ../hw/scsi/scsi-bus.c:128
#8  0x0000556e6b5d1966 in aio_bh_poll (ctx=ctx@entry=0x556e6d8aa290) at 
../util/async.c:218
#9  0x0000556e6b5bb16a in aio_poll (ctx=0x556e6d8aa290, 
blocking=blocking@entry=true) at ../util/aio-posix.c:722
#10 0x0000556e6b4564b6 in iothread_run 
(opaque=opaque@entry=0x556e6d89d920) at ../iothread.c:63
#11 0x0000556e6b5bde58 in qemu_thread_start (args=0x556e6d8aa9b0) at 
../util/qemu-thread-posix.c:541
#12 0x00007f32a668b9eb in  () at /usr/lib/libc.so.6
#13 0x00007f32a670f7cc in  () at /usr/lib/libc.so.6


