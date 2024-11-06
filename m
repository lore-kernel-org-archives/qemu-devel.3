Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1C4D59F5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kbM-00009v-Og; Wed, 06 Nov 2024 13:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8kbJ-00009L-V7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:17:53 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8kbI-0002Kq-Il
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:17:53 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ebc0e13d25so35213eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730917071; x=1731521871; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLQ47IviwJYKfToQzsX1S3uL1vwZrWMk/z+YyBXFLGA=;
 b=QQ3Ts10cLj9RbLjxcIqgPsQagKoM2s5ZWuMrOo3u8Tajkm8z4fSHAIyoRRqcMa/7ao
 /IToiSetnTWXh0Ngu6HSOhFCKYFTlgMZARqur/Ckqy6xGPHHGHUJZk18MeuHuhNlQewu
 6goVCoaWIbMRvfP4v+XTWKmw5S/WVoPKgkgrQJkH/2SOzcDtBsKVBr7g/2HP0oVzgDQW
 sYZJmqcs0wG0qV994oOQxv9SYQkI7pAJSxdIBhIqXi2rvph8o5UNlCgQGlbl7pPE/JDA
 luWbcQm5DuMVVnhL1cEVcxqNQqeNdhFsZaNH3q/MzFsjpAVAGxNAN7YOv/Mrb2TrhQww
 bkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730917071; x=1731521871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLQ47IviwJYKfToQzsX1S3uL1vwZrWMk/z+YyBXFLGA=;
 b=tlBhFd3bYad8tSabkKaGTjdX9u6biQTKG4BJJp9zbmo0JPWTauh1SxIOCOYVWlJq36
 4gM8GczjRrsz8O9tPz5nty+JgzsnBi4pQjPHIHHadFII2HjMmZMEYtjZqcxYwHO/PKeU
 Lifh8HCCB1r+tNHcFOoFo5OQgnN7JOEQIMXDjd+LWebmgOZ3+K2g1b7FlL53bdn3isHX
 WZcg4L3VM/xDw1kRTlbzT7fYQa5BqttNvxJpXMIql/0xa2XjvujanhtwOWi7AcLbzC6K
 f/TKpynL3U+sYZ/1PGkRkubFGPl3+8EF6FZ/DeKlO+PTO46hSGIsN9ljm5F81nSkxiE0
 KJDQ==
X-Gm-Message-State: AOJu0YxYDLJFRHjMuOPOyGxRq15qRe04RB1B/H2qbrP7OjYaAker/D5Z
 SBMluOb0byRjOLUQUpn1DEaYZfGjv6yRmzo6mAZ1WXRCCmfUqffg0bf/Rk9OLaJGY4jdjoZW8yg
 4BLAPWC/+O5f5ChQqipesXsfsoPCORw==
X-Google-Smtp-Source: AGHT+IFDdnj2TkSEMttUihPHyK85DIf6uneBJmtcePSCf771XSWLZ+x0tiRQLuyZb8zfhRMqtB9i0Sf137Z/uuIb9Kg=
X-Received: by 2002:a05:6358:7e06:b0:1c5:e2ea:8993 with SMTP id
 e5c5f4694b2df-1c5ee958a69mr1135200355d.11.1730917071106; Wed, 06 Nov 2024
 10:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20241106181211.568775-1-pbonzini@redhat.com>
In-Reply-To: <20241106181211.568775-1-pbonzini@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 7 Nov 2024 00:17:53 +0600
Message-ID: <CAFfO_h5xukezyX-Bz+mtMg4Et+66OWHuw4kBxs5XHym9Vba-pQ@mail.gmail.com>
Subject: Re: [PATCH v2] eif: cope with huge section offsets
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Nov 7, 2024 at 12:12=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Check for overflow to avoid that fseek() receives a sign-extended value.
>
> Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/osdep.h | 4 ++++
>  hw/core/eif.c        | 4 ++++
>  2 files changed, 8 insertions(+)
>

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

Thanks for fixing!

Regards,
Dorjoy

