Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C62C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8cG-0001HO-Lc; Thu, 06 Jun 2024 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sF8cB-0001H0-Tc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:36:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sF8cA-0004Ro-9n
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:36:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4215fc19abfso1800555e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717663012; x=1718267812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rzOlTpGXOFDC46rae4mb64yBb7uEDZ0xP/1eKZGmBUw=;
 b=LzhvlNfkgvrjF+55yCJBWEh+tCUEou/FpOlB64ao0UrB8+POjmFvKW4mXC1OhzqSGK
 frnQYnl9tRlrCl6gA4kvwJlyM+NVPZHxumsN/kg25lszZaueDa7IOR96nlgt3XPU5okd
 od6wu+GoIS+2ZrN5KhSn5zD6Ut1tbgXJP8rmSlzgDAFZhz9SjDyL8sNupWLjkRnAvC76
 IUU8dWd5rBdFUmCgxmeFvZQE7I5DxQQzOv6InBk/qxQO4yOIMQkjGKe8xkgsA74H30u/
 /MsEYtonWYehP9BmDBbY+M+iZoxvPx7So+Zz5zNEmFIkh5UMLGvKmUu6+Uqk2WVTiO+e
 5IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717663012; x=1718267812;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzOlTpGXOFDC46rae4mb64yBb7uEDZ0xP/1eKZGmBUw=;
 b=BeCX1hCAHfBytmsOwPZ0qkqu9blY4Lh5WTocit6KCUAVxpYCRoqqGknVmSSohc+RVK
 uNTGrrWPzY+zXXR8kJBA2YkvEE4K49YvSl9hD9hR/PPTF0AnSIEympNQobv9/cuMgntw
 Vzya4JV7TQUUGLiTa4Os/fJFiQtQMTNf2x7R0J7LyVIQYiQtYR2MU4F3xsxS74GAm3+U
 CG9x+W2XFBE+WVmHcylNlu61coUb9ffLcrtWxJrCSnPAPq4NGY2109xPYFQkiHcO0sHD
 /UCeqFdNzue6T0M9Jsz7qj07JBtk7XQqviqGNZHZI7HIcmkBpL6Ri3hsKrdk48CH9a66
 DNgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGtfsRIf23VezR5W80gy616hk9R2DbqnORTEHLcdv4VvZYCbNPcRIq/ybm3sJBLRTOMshOPHmmKYPCqlRAUH07mSinvmo=
X-Gm-Message-State: AOJu0Ywl3eqTgJ3SLdIfbWOJMFrwAKurEkSBwpIsjcOQTEyhaX33/YZU
 mjjT2++n5fgBJ6EzGBis4WQiO0giIrvWv0SOZBS/nFRfbvooqlD0
X-Google-Smtp-Source: AGHT+IGzT54QNK7IhOhsW9oQdhMM/tkMLq7skxG0VwQqxfW7PvYNgJZbnLqz09Ajr4xdIhZI5tb7+w==
X-Received: by 2002:a05:600c:524c:b0:421:4f34:3ada with SMTP id
 5b1f17b1804b1-4215632dd1bmr43362575e9.32.1717663012050; 
 Thu, 06 Jun 2024 01:36:52 -0700 (PDT)
Received: from [192.168.0.151] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c690dsm13781485e9.34.2024.06.06.01.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 01:36:51 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <434fea2b-c7e9-42b3-bc1c-27ef811d0027@xen.org>
Date: Thu, 6 Jun 2024 09:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ui+display: rename is_buffer_shared() ->
 surface_is_allocated()
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
References: <20240605131444.797896-1-kraxel@redhat.com>
 <20240605131444.797896-4-kraxel@redhat.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240605131444.797896-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/06/2024 14:14, Gerd Hoffmann wrote:
> Boolean return value is reversed, to align with QEMU_ALLOCATED_FLAG, so
> all callers must be adapted.  Also rename share_surface variable in
> vga_draw_graphic() to reduce confusion.
> 
> No functional change.
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/ui/surface.h    |  4 ++--
>   hw/display/qxl-render.c |  2 +-
>   hw/display/vga.c        | 20 ++++++++++----------
>   hw/display/xenfb.c      |  5 +++--
>   ui/console.c            |  3 ++-
>   5 files changed, 18 insertions(+), 16 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


