Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F58EE645E
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 17:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vazrO-0007fa-7g; Wed, 31 Dec 2025 12:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vazr6-0007dy-Qv
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:19:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vazr5-0006bu-AU
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:19:28 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0834769f0so107688925ad.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767201565; x=1767806365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3ab5SQCEewpRtvw8FRjvjpvDeC7R2Ol6Kg+O2JkE0M=;
 b=yzPa5JFrWP72RO/1xM2wBhW8MHT1VaWtoJxpBUa7jifWXFz3iEbL7IMOumdGKFZsvM
 LqFr54PgykdjCZjtNb5MY+CTp8XME/vIAziOPc02tENyB6pBer383xNSGe9eTUIgSHBh
 uvaAaYyyLyCO5yb5lc7QcSspUYKcrOOh8jJ7oJI7DT2+QkgbrOISSdOc3twH+EDQtK+j
 ZXJxciWJ3cYTfWF42itIVqPY1qnUC/05LEedompzL9P0oiFJ4ArgK7qtz0pf47r84Zrn
 PDo+9yMBl/lxki8nYwzEz/Eyh2p3vKAiJlunA6ArF+9/JA2oib8NumWHaBxGwfUEdWQZ
 LKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767201565; x=1767806365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3ab5SQCEewpRtvw8FRjvjpvDeC7R2Ol6Kg+O2JkE0M=;
 b=Zq0C/XX0UABnWLwzZrGV5TaMuoB/q2zIlJpaj4BaK0w9krWIS27o4GoC+XpougL7Yw
 Y01EdyvqLiCgV/iouNjFTlgUVbmA8EhsqcB/nhiCdtjwqy6vOedVxT+cXo9tVyqotmau
 XeMLCic1XCeXD1k68T4N5/w5scjTXcPEqVDSfEbIGImFY3SGZJXibUW/p+qRlB9re6+p
 qmCv00Hk2QtL2Z7YDrWVOdFaD2P1AHaTADNljBC5NwEg0j2xBBOCn1IlkNUgsqNKc/D5
 mhUJOnQawjt0NkMTU6kCfKpbRZ6kkj0vYYWLBtRTdaxDijcrbzxxE8m42hqTcrGUP33g
 bsIw==
X-Gm-Message-State: AOJu0Yxo1ead7oMIW5C7ZqnjSnHWthSxhQJFA7Z73fQ9HcpV6bYwtrOZ
 ygiHOFmZmBM4+vreuOJqzIra2nAPiLFIODBVb43VKq3+SjXCLBiYfEUyeDS0D7GZkB++tTiQfJC
 5w1cu
X-Gm-Gg: AY/fxX6qKeWVof2vLRnhaJhYf/oP3t9iasR2BVTZRVivLbNTfezIdRvaJd9FUR/Azes
 pIRQmdP/5Y+aeax0+4c2w5d1l753tDGRhj8pRsg0ASA8IHQ+erLfS/p9bAMOBa4E6MjiMsw9rLa
 pugaNAXQPTv4B+eQY7JPPRCH3I/JykTgDwZwalPy0lkEy7mZh+So9l19boyU3JACTKH5YOvIa4d
 xKsXu8OzNAzeVVlLTjGib1y8154yeGlkry6uusKmM4S0kkHu3e3H4IZMWEUHuVYKgEiwpn2Dlb8
 I2t5fo0XeCaINod0PipE5jtfNqW9P1q7dZQZYme5Uc2O9ujAteusICc9bKEirMikMEnjzGtA1BA
 xnGgNs88EnMRsIkrOoP5hpi82I7p5dlyU301BMxZqTZZWUacNo7IYyo+5KxldN3ncnZQxwo25NG
 f/IXhOL8wBBqHNYEh108B91UoQW3qpyFZvogSenpkM3t9e7L51HwTkTeOi
X-Google-Smtp-Source: AGHT+IGsjmLP8FEVio1D1EFTckGTvYsVPkZP7oKenbBwd+a5vuyLgxgM7nhxdrWWifxkH0EwGwcNtA==
X-Received: by 2002:a17:903:19ce:b0:29e:e925:1aa0 with SMTP id
 d9443c01a7336-2a2f283f14amr371438395ad.45.1767201565322; 
 Wed, 31 Dec 2025 09:19:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66473sm310014265ad.13.2025.12.31.09.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 09:19:24 -0800 (PST)
Message-ID: <6930d759-f1d0-406a-bc28-be301984abdf@linaro.org>
Date: Wed, 31 Dec 2025 09:19:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] include: qemu/coroutine.h -> qemu/qemu-coroutine.h
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251231073401.2097765-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/30/25 11:33 PM, Pierrick Bouvier wrote:
> This header conflicts with C++ coroutine header.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   block/parallels.h                              | 2 +-
>   block/qcow2.h                                  | 2 +-
>   fsdev/qemu-fsdev-throttle.h                    | 2 +-
>   hw/9pfs/9p.h                                   | 2 +-
>   include/block/block-global-state.h             | 2 +-
>   include/block/block-hmp-cmds.h                 | 2 +-
>   include/block/block-io.h                       | 2 +-
>   include/block/reqlist.h                        | 2 +-
>   include/block/throttle-groups.h                | 2 +-
>   include/qemu/coroutine_int.h                   | 2 +-
>   include/qemu/job.h                             | 2 +-
>   include/qemu/{coroutine.h => qemu-coroutine.h} | 0
>   migration/migration.h                          | 2 +-
>   ui/console-priv.h                              | 2 +-
>   block.c                                        | 2 +-
>   block/block-copy.c                             | 2 +-
>   block/io_uring.c                               | 2 +-
>   block/linux-aio.c                              | 2 +-
>   block/mirror.c                                 | 2 +-
>   block/progress_meter.c                         | 2 +-
>   block/vdi.c                                    | 2 +-
>   chardev/char.c                                 | 2 +-
>   hw/9pfs/coth.c                                 | 2 +-
>   hw/block/virtio-blk.c                          | 2 +-
>   migration/rdma.c                               | 2 +-
>   nbd/client-connection.c                        | 2 +-
>   net/colo-compare.c                             | 2 +-
>   qapi/qmp-dispatch.c                            | 2 +-
>   tests/unit/test-aio-multithread.c              | 2 +-
>   ui/console.c                                   | 2 +-
>   ui/ui-qmp-cmds.c                               | 2 +-
>   util/qemu-co-shared-resource.c                 | 2 +-
>   util/qemu-co-timeout.c                         | 2 +-
>   util/qemu-coroutine-io.c                       | 2 +-
>   util/thread-pool.c                             | 2 +-
>   35 files changed, 34 insertions(+), 34 deletions(-)
>   rename include/qemu/{coroutine.h => qemu-coroutine.h} (100%)
>

This patch was a premature cleanup after fixing ctype.h, coroutine.h 
does not conflicts with coroutine C++ header (no .h).
Thus, I will remove it from next version.

Regards,
Pierrick

