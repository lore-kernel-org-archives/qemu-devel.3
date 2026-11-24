Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D7606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJwk5Z/6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjpr-0004R2-Pb; Tue, 24 Nov 2026 01:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xVjpp-0004Qo-Fr
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:16:57 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xVjpo-0005sU-1X
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:16:57 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2960003f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795501013; x=1796105813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MFeXA8yoi9dER3NvT8kfDIkvQjvmByI1kpZkOZbaRdo=;
 b=EJwk5Z/6j+wBz+JJ8uokYLsvVYRittYLlr6HrBwu76gJ3t2brjtBlzbuILkkNigZMv
 RJrCWjVrJgAtTef3XIM2aPryVH0xjN1GG0IEooSI50h9LyiizPMfpOXPHDJ0hIfPcSz+
 RmsyBcgEWx6Z8WXUdiZ8D8KlFnvXtzaMT078B6lbq3vdxpDuRWDJbDJJ+eQRxO0O1k41
 xRbj9C6eh45MmaiEmyJWeZg9QqR8TFO+jBNU+PmgCAeStNXizYaRU+4z/0TY9y8jq3az
 I987zYIKqjB0Ouu9EnLYpJLA2eKOUFK0wW0Obc70+9lPytLVXFW8pJ7MPb5DfPp8+msn
 7X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795501013; x=1796105813;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MFeXA8yoi9dER3NvT8kfDIkvQjvmByI1kpZkOZbaRdo=;
 b=qgihgiABcoDHwZbqnZlRepTeAQ8MU8zb8foG4pJ/QbV7K5M0xc+2pwPNyuWfTH6QmT
 aDvHk13RgBJ42yFXlcj7csKQ9J46jzMpjP54gZ/7TCJWhCY66gbRC5Ls7HWBEbxU4fqj
 t7MKVI/G5N9dG+WxliBD7XuJ3oq/eL3RJL3x4wszsaVA6l0B/YflX9M742YUoqK1yRvA
 8+k2kpcJrdFjN09ecWNSNfgDrEr6i6WlIuJuPlSxaFETNv9qGUTd7onAl8xiDcXCSrkz
 CJg6+mX8va0Q73eenTdYGH0Kmv99qHJ2dLtsedX4E+ql3cK1czh9VY23MoLYmvn2+CyL
 5Cjg==
X-Forwarded-Encrypted: i=1;
 AL+hErGLRWaRGSNmZbUqD4aDB8w16aACHrOEOpvAFHRCpCPwmR18EwF7tiMQ7mV0SylLCU6mFOuH+v4QZ1RZ@nongnu.org
X-Gm-Message-State: APuU4Z8wifgnkXErSF83yfifEB/OQawnrCa1HLN7nUaGLQdEy3q9D6xo
 UAy4+zMW6S3glI8O6dHfSBXMg4Sg2VVrCLmL+P8npI0nqlQ2aKlWYu4s
X-Gm-Gg: AZFdTZcjEnp84/938yJUgV0jdbQIB7xtLOen7DTzWMtSG6NIz1gUnYFJrRwfI9KVBct
 pwNkAZQ9lDhljqpIUDI1AsCUXhILbyGE1pjNahlvdMtglnRsm8AuBmS1CYb5kpKdzan3YWsuqhE
 7wjYLIxcHYbbv1Y53/SepQuGcQUoVYTVK6YLwPVciS7qkGQm8wn8xVLzN9lmEHFAGzo8wGan2ny
 H+IQrD+aLUqU3CTdwfffGAIcHB/63QEzzZuJoT1RHjg2tNIqp64KEZEoIYGWl9fHNwDuPFo0tkZ
 bDD+jv7261PeBKsPnSMaSEY+ZDXD5w6tW+UafG5295M3GxASluYvvLo+IvEjUkBMDTISH5BSkUM
 BCj7beJzy669b+xmyfXGABsiHAFygTUE/x/934KsJcXgYvokOFLzSSfd/E1uQ0RZuM33cfbX+2I
 MuZ2vMnIR/D9EXVzE7RULvRZSt49uPKyvqXPJZDUB4lIQaN9gcI/L1qfjZMmBgmAlIOXtgVO/vq
 0Jrtb6AEdhIOhGSsCF4a/nbU0mLRHMp7HfppN/HFsXN2uvEZbRAPXewEnz94Q97NeZE9+D9O3wN
 chsspMC5x8YQG/aM0QrJVfv9kGP6xqFUAj6siurIw8+Zm4CoXDWKPhhMZZFZs/ar64GegFraH8F
 fcOYI3SN9jNUUHjBQRxenC1irSNuA7eb1BsiztkbSJ37zUpaA7N2jGqvd4rwP8KlmaSGXSLCddT
 X6MA==
X-Received: by 2002:a05:6000:2506:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-4abb47b0f64mr32830783f8f.37.1795501013389; 
 Mon, 23 Nov 2026 22:16:53 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-077-002-108-156.77.2.pool.telefonica.de. [77.2.108.156])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c50sm25587659f8f.37.2026.11.23.22.16.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 22:16:53 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/display/ramfb: reject invalid framebuffer mappings
Date: Tue, 24 Nov 2026 07:16:45 +0100
Message-Id: <20261124061645.74635-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022145437.3546795-2-marcandre.lureau@redhat.com>
References: <20261022145437.3546795-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kmehltretter@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 18:54, Marc-André Lureau <marcandre.lureau@redhat.com> wrote:
> Validate up front that the whole framebuffer range is backed by
> directly accessible memory, and still return early if the mapping
> fails, leaving the previous surface in place.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4740
> Reported-by: Karl Mehltretter <https://gitlab.com/kmehltretter>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

With this patch on master (2bfbe39d0fff) under ASan, my #4740
issue no longer crashes in address_space_unmap().

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl

