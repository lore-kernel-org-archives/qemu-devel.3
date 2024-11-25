Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E99FD58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFab3-0008Ue-IK; Mon, 25 Nov 2024 10:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tFaaz-0008UB-Hh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:01:49 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tFaay-0006P6-5h
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:01:49 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51529df6202so359180e0c.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732546907; x=1733151707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZQlRRlgNqyzHsgApeD91poFrJoujNh18htO+RS1rKg=;
 b=e7E1xFBtqN/Tj26c5s5mgGzbkvytKQgZyFO9CnN+dUTRm9T5nZGRYye8HxklJvPtlL
 dAvRO9lWF2A0XJ2a1N5y8nv8aUOpv0/6tcph3hhUpqdkQrufNVHBH7AbS5PRk+8XdAmh
 j3fhnB1vM5qYpZlyOjll3R0cPTQGLSqEEltm+LQKKYjYfqqxxrGuVjpIIwwpFLElg4IB
 rYwFJoF27JdS8+eYjVUKY8bt+07xp8kgteJiuqHs2wvxwo2nmssRDN2dstNcMTseZT6C
 rvaBdGnHCp+oKsTI3QtjTraBZkPUxe47O/QDz9RdGat9TCkNBer0XxajF2bh28tzBT1i
 /9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732546907; x=1733151707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZQlRRlgNqyzHsgApeD91poFrJoujNh18htO+RS1rKg=;
 b=tbwTTrl6BhYx7p6izsVCeuF3y5oLxq5CTpE5QuDxranyMKAUqSi+B0KK9goFuE8Z5w
 3o2LjH0gTkWFRcEout2F7F72x1B5oljq1iLpAxSpvJJLDHMlx2pKY7PwEJj3zsCrQiVh
 I0Xf5e2fyQ54R9dLjGFQJr8MKncU8T1lCqo1Jyg3TWb6hviK/9Ua/aE6p4hA4ZO45p3s
 yAFiCWrFA/JSMStJW9P1VWI2b/4wyXzGZGDq0QzBs9yVNQ3ix9PjRdM9Zv8W+F46sIEC
 CAaiDhHtSrVaCNLGlLfKFrkB6dvIhfWC0bbPAZDDBfrVcdDm/muaMvdZnk9HUF2EDnlv
 DySA==
X-Gm-Message-State: AOJu0YyHPtWcc9kcISTQd2GKdGhn+138jcldV17LULP4x5qjlN4n+tV7
 IJMzQ5OiSoISUMz8YIUXSbMPGSTQZeiuMyX0vbKgsVk8c0nlM3J/ES0O9sWd/A+69LkZOBOLCgw
 NHbDjuTgJSX+SOFWtYoMir5texw90Mg==
X-Gm-Gg: ASbGncutxBwTwuHl32GD8Tg8pA58Gsh8cTDCFpK1DzDkh+wW3jzfBaJmr3DJPTUYT4k
 +u9Te/G2TTawtC4ZVffbuW8mALd1S64DR
X-Google-Smtp-Source: AGHT+IFOKRVfg32oSPKML9nKWvJhXmEwRvdvzRXZhdBpjbSFFbM5jDXorOEn+KTxGcshwIprZ21fXoz00QwEGXfIlrU=
X-Received: by 2002:a05:6122:4b1a:b0:50d:869a:e542 with SMTP id
 71dfb90a1353d-515009bfec0mr12677563e0c.9.1732546906707; Mon, 25 Nov 2024
 07:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20241109123039.24180-1-dorjoychy111@gmail.com>
 <CAFfO_h7Gmq9vQYOXB255c4jWK3KUEF0xro53i0qior5XQhqbNQ@mail.gmail.com>
In-Reply-To: <CAFfO_h7Gmq9vQYOXB255c4jWK3KUEF0xro53i0qior5XQhqbNQ@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 25 Nov 2024 21:01:52 +0600
Message-ID: <CAFfO_h7rjZiaP6LsFHPeOAHR=qitmodGq4jNQW1+1-0HtqM4qQ@mail.gmail.com>
Subject: Re: [PATCH] eif: Use stateful qcrypto apis
To: qemu-devel@nongnu.org, graf@amazon.com, berrange@redhat.com
Cc: pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa34.google.com
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

On Mon, Nov 18, 2024 at 7:13=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Ping.
>

Ping...
This hasn't been reviewed and I think this one simplifies the code in
eif.c and is quite small.

Regards,
Dorjoy

