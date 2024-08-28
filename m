Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC672C5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjJsC-0000mK-85; Wed, 28 Aug 2024 10:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjJsA-0000lF-IK
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:42:10 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjJs9-0000ZY-5X
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:42:10 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-498d0268541so399763137.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724856127; x=1725460927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OExHFWD4sDMRKmBjpQhltXSv7D7YsdYrXfPwQKxIuJI=;
 b=Ucu4vuTxdn7jezcgnuEa1gURVeboxChKFx1yU3RMmbuaK7ozUB+fL88N1FA9KeC2E4
 6fxLsFm980XvV+dSnLlpVcJRhd65rt9r1NJB/MkKFQrX+bZ+VyK6YkBMxMQvkDezG+DQ
 Wk3UL0GemYPqNjTZiY4Tozk2Z/OoNA+ZhTm74iC93KR6ViJw+U25TY3r2yvNZKWHxCoA
 LUNB24iWDghQCPBojdq+1h+TjqDoKbXFMar1gk4+O8b55oObCX8CIkVZcVuvCShrX3ZL
 RXDECiI+swmoxBvBu7NPqtZHCwSJQFf8DibVsU8ZJk/CIAS925gdKqsNRWHd+ZDdA8LU
 Jr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724856127; x=1725460927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OExHFWD4sDMRKmBjpQhltXSv7D7YsdYrXfPwQKxIuJI=;
 b=bGipI6EzaG3cbUQnaJeQe2till6eSZi6W//Yjb/b4hb71htFI3+4tBBLK3BpEpyvPX
 vvxWgN+t5U5LEc9uD15UxB6RZkpxRmsBK3Ch+cG7+oy6I/rRkQ5ZxYOvAri1pRkWxFLh
 A2q71gop9iytTkHf5D/MPCu+y5e98GW6lhFIYqUPBptUSkKzioUuT+5WJJ1NQaARiUKH
 kO9HF4IBl54UdiTc9Qz2T1XXmLq0kSFXU+vwk2A1KkXmSxmBAXHautN76/UPmT5c90XP
 MJ7F19uTXubFj2TXUZAX0ipD37tsnO/TEiJOLTlYsxffvRQJhk4uLWZvv+e6gCbhiVWz
 s0+Q==
X-Gm-Message-State: AOJu0Yy9llJ8m67KpE1OrXtH7zV4XynhLq6khq6olvpQBhWiPXox+v4v
 O3rXUrhmnPwc3+oGrcd0eUX/A5lxZNYu3budA/g3BHEUA18ct6TD3U8tRtBS5nlsrxxMdQq6Pu1
 vjTWV5y0eZ4u1IPRff7MS+4yxZEt+Ka2bRdrpPw==
X-Google-Smtp-Source: AGHT+IHFpZX3ohCCD8VxFe9ur4kKK6hKgi9DmO2Tt9DVTKKAVQoLeqgbC3b2ZNhRh6y4xFDPSyK2E9nxjG7q0/57dio=
X-Received: by 2002:a05:6102:50a9:b0:493:b1e1:9dd4 with SMTP id
 ada2fe7eead31-49a4e3693d6mr1475318137.4.1724856127481; Wed, 28 Aug 2024
 07:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240828063224.291503-1-rowanbhart@gmail.com>
 <20240828063224.291503-2-rowanbhart@gmail.com>
In-Reply-To: <20240828063224.291503-2-rowanbhart@gmail.com>
From: Rowan Hart <rowanbhart@gmail.com>
Date: Wed, 28 Aug 2024 07:41:56 -0700
Message-ID: <CAE5MsNZET2z5WANyrE4Vzhh1-DHEGZC+1LGkxC36hSjUNH0n8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] plugins: add API to read guest CPU memory from hwaddr
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c46d840620bf5c69"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=rowanbhart@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c46d840620bf5c69
Content-Type: text/plain; charset="UTF-8"

> +  qemu_plugin_read_cpu_memory_hwaddr;
> +  qemu_plugin_read_io_memory_hwaddr;

This second symbol name should be removed, I initially wanted to implement
for IO as well but there is no good generic way I can see to access a list
of IO AddressSpace to read from.

--000000000000c46d840620bf5c69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><p dir=3D"ltr">&gt; +=C2=A0 qemu_plugin_read_cpu_mem=
ory_hwaddr;<br>
&gt; +=C2=A0 qemu_plugin_read_io_memory_hwaddr;</p>
<p dir=3D"ltr">This second symbol name should be removed, I initially wante=
d to implement for IO as well but there is no good generic way I can see to=
 access a list of IO AddressSpace to read from.=C2=A0</p></div></div>

--000000000000c46d840620bf5c69--

