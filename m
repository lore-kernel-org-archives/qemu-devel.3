Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB78E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 15:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKfcG-0001yx-N9; Mon, 09 Dec 2024 10:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tKfcD-0001yI-Rv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:24:06 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tKfcC-0004J7-AK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:24:05 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-85c5a913cffso1329604241.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 07:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733757843; x=1734362643; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LdJXjWSSEQilEvq28ws/gPJF8yk0pvKAZOZdb2nCKk=;
 b=OYQL/IVHVH+kI1OHxYv3JMFSPrZOqTOSqKKEkLApzevP2941YGVrYomgYfUkdvd4xT
 u/TzISd7oLFT6ppR3DMooBDb950ygO0VEQQpaVu7ARNxhKJsJqMkwUifR2rciqQKVMyI
 OToAM29+PEOTJbwKjM0zjWGqbtG/TSFy5oZ2b3kmKeuLxZxvXZGI6/oxpXnzMIld+W4J
 LeLAFHwTfAbUWkP5iBF2WZpJFz3/FZU0wFEep4jGxnewKcHWuiUFZwkeAYN5hx0mQzqY
 8Rcy9qcNNLetJH5w+x8DULc4dKpMNOkjOKqGL+/Zj9MGqaB8ibM1PJe+rnC/m3yGnq73
 Ebvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733757843; x=1734362643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LdJXjWSSEQilEvq28ws/gPJF8yk0pvKAZOZdb2nCKk=;
 b=seu12v71Z5d2hMobJPXGAK3UUw1nWQ7vJ5oiJkSwVzc5kH++GkwsY/rwuUFlLfWOCA
 AfEnhKfxTbwlDxN7a/VMcyKBOE82Bh5l+aCV4b6tC3vkxEcd5TPPbRMad6XI3usw5lyc
 NAahPw4vQNuPZAel03C8OkgOuvJ4XGzX9q4MJIQ7zxMAT3Zw84yPIMNTuoIlXLe6LzTF
 ejBsQdO/jQZne8J2RvZkm/4qx+5AuhOLedgHUiAyWFflen2z1XJfYENrfyJV/a2iOODg
 069ZiY7dbJpA/W++MmkA24HGsItwfKxtRt3Vk/CXF4c6DaVmElq9g4QOFxHYQxowRz0I
 tGeg==
X-Gm-Message-State: AOJu0Yzb8fC461b5mfJjO+Wgv5n/8cKlAoGrdmmwcaaGfaubpA+w1HQm
 uTy4iILa9YPZvHdiPcwB66HxObxOquuH7oZuhRqalGjNHmUU4fZQkLxYGHXuwhCM6CwT73sPalH
 01JOtfAIu5lufh29HhbftMzsWd3c3qQ==
X-Gm-Gg: ASbGncvIJrBqyMz+0R8v85+3GdLhSNjuHd3t5rIMrC13uqT3CZ++AiiwzTbY7A5BmK1
 ZRgAw/3AAOpbQceL2BQtXVSoTGEKyTh3zrA==
X-Google-Smtp-Source: AGHT+IGY+lNP97QX6NgRG25wN8h/b8/usP3TM60YyFU7GQ+f8+IardlniM7CJ9h1EOQjn3xllKp208bDY8WmLNKdGhY=
X-Received: by 2002:a05:6122:d24:b0:518:859e:87b5 with SMTP id
 71dfb90a1353d-5188834be83mr1462521e0c.4.1733757842830; Mon, 09 Dec 2024
 07:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20241109123039.24180-1-dorjoychy111@gmail.com>
 <44ec59ba-2f36-4482-9b56-05b583199603@amazon.com>
In-Reply-To: <44ec59ba-2f36-4482-9b56-05b583199603@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 9 Dec 2024 21:24:13 +0600
Message-ID: <CAFfO_h5-=uNQ+7KjWp6ekynSoU9Fgn1ioXG4tK0hAJgRd9oqEg@mail.gmail.com>
Subject: Re: [PATCH] eif: Use stateful qcrypto apis
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92c.google.com
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

On Mon, Dec 2, 2024 at 9:39=E2=80=AFPM Alexander Graf <graf@amazon.com> wro=
te:
>
>
> On 09.11.24 13:30, Dorjoy Chowdhury wrote:
> > We were storing the pointers to buffers in a GList due to lack of
> > stateful crypto apis and instead doing the final hash computation at
> > the end after we had all the necessary buffers. Now that we have the
> > stateful qcrypto apis available, we can instead update the hashes
> > inline in the read_eif_* functions which makes the code much simpler.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
>
> Reviewed-by: Alexander Graf <graf@amazon.com>
>

cc Paolo. This one has been reviewed as well so can be picked up for mergin=
g.

Regards,
Dorjoy

