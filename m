Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5496FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRAU-00073w-Jr; Mon, 27 Apr 2026 14:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wHRAI-00071k-EF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:58:42 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wHRAF-0007qk-CY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:58:42 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12714f01940so776620c88.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 11:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777316316; cv=none;
 d=google.com; s=arc-20240605;
 b=D/0Wi0IJG4G69EsZPPuSIdEO3g5VifE/Yeb/08q6d07BTUr7IloVgkqCQSrAjurIVF
 0M2R7TEUzOYVPGbyoK6Qz8jAXsw6/7qEhIFxeYGxf5bpMOYXncfXn7VevXqmcegFnwk8
 OatcR9fiolG+G4gv6OpTiLVafbLTlGUrYPQxnzczq0HMCjKtQodSKTIiNmFDiOQfv7FA
 N8NXpslSRbM5BIO+uOYN2fNDK7KzfvxUjJ1h589ZT1c4CHeNY8WD/huPN5hJ7glE8lpj
 P57GVW6TnraBFSz1QtwF4NEWEUabBhCuUpkfiZzrmJzwU2l+JbbC3bKx8UhaJBK1rAn4
 FUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8luF2a7tqALbx1AixS1HhgpnsyXxC0cJiB+dhyTDtS4=;
 fh=f7vFWFR4iwqDzyn15gDjVKUg8qDcsw7ufdiBVQHbagw=;
 b=Fsyn/+GumavKu5K2pKXT0Lh5PmqdRCXjF0s+HRJLePF7Yyc2uGe3gSK6Bp6yU3gf54
 R2cjwaIx+GKR8oaoT+EqQJzK/phomDoU3ga1txO6P4p5AteAa4rIc9KpKEch7j3adHuP
 jsoUeAn8PumzSBjj6uzvtXfhMJlrMeRN1ZJJFdCTvLmeDhOuLiSU71t+0JrJKDge0lOl
 R4lgiaWcOc4fmlGobrACuJhDsJhBDnxgAMHV/rRxtKR7OweNfEPahhgSxeKUKm9YV42N
 XNoarxp1riugioGws0Pw3UljwMNPBj8pxUQ3111/+s4pXQdJx5Z2B+QHXkBSojR8pBKt
 bp/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777316316; x=1777921116; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8luF2a7tqALbx1AixS1HhgpnsyXxC0cJiB+dhyTDtS4=;
 b=SHmSbjGBSszls0yWI2HTDgulc5rI4QqDvhWW15ha/ZWpxB/XkSIdJagHAFMcL+hImM
 hbWZU+1UZ9uG4gdpZWIeSAttidyr6Y+c+6kxRh2Dit+APeUgH9uuPlTfuxEUJTj3r4/J
 zgxKNbcRi3NTkIjCqGnxH443lKmM9dkS/C6Kx13YjR5tHBmU9VQYPf9nwsgdGpryK7Ru
 oLPePkS5YFdTPav/q2OwcrYfnc/vkkehmSLsGYCE9gWGW4coGrDsPwyTS0FD0TUKCh9W
 SEYqbqd/0AFfCG1MYl11eyILGBcjpbue+RCPFW4iVjr8M5rDGjWwWBgDpJfkJfw2KM+W
 FuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777316316; x=1777921116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8luF2a7tqALbx1AixS1HhgpnsyXxC0cJiB+dhyTDtS4=;
 b=CboPfMmD5d4ntIpP4WV7RJYpwEberOD/wB+qvBGLCX2O73ksZLM+fUKqhiMak16Ufo
 xMGzHofxBsg1dZNrJV2g1E8GhAG5nT5CEDcDlmYPCfO600EQJlCS8h9tzM68xrVpqdmZ
 ExIzGhbvLDM3xMvtqv4YtPNEN1PyzWwe0ymE2/XnzrzFpKSmx3Jug20XIi1PX5MnHydQ
 A+fdr5TM4CTgm/wh638zIE8utk4CBuj9+qYsXJUZllwYAaaGw2D1UR88lYJ0cylB8o3k
 Z+Krb2ORykGtFceBl8GR2HYZLtX7gSVPT8ppf4RvBrmeQy27nWRkhJmA3CimC+KAj9Wl
 4csA==
X-Gm-Message-State: AOJu0YzDWgOHkVl6Dtb8nsKQFJot9otehv5MxWfcYOAlhA/K5Vv9kGT6
 0tcF4vJJLvddhqlRvVhCcb8uTWv0RI2UAiESgovrmPyByBEoIpdtPrtCkO8SWLoHTBdkd0IgsmG
 qytxKZTlZkiQ4mqknEZA6pErYT9m8d/A=
X-Gm-Gg: AeBDiesjUpMAc0QcAs4LlTBVpy+p87hb9N0z72sY2iOpZr4eKTm4tp5HTgUD74jEBcy
 aRg57mT9NX/0pRFe//PUijUu3SzqFM0SGmWhqFhigEAQwmknULw2+mJjPPHFFLzIX0K9NMnBfBG
 BYW9kf+H3BAGAwZUE34mag7huj50QyDEolQV6l++l36flXOBSbBUB4A4w8d2bukQJ9R59vcYlFk
 muHkghyESV5HflvpRsW2a3vdD5ZC99QQ2pVjW5tvsvzGO7PsX3KeA9RNrueugme7ZSdBZ4MxJLl
 Whu29CmBwH2bDgnZEw==
X-Received: by 2002:a05:7300:214f:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-2ed09838d98mr60213eec.0.1777316316193; Mon, 27 Apr 2026
 11:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
 <20260424-master-v2-1-8b50b5c063ed@gmail.com>
 <c4c6e1cd-1236-4bcb-9fab-a65b20304922@oss.qualcomm.com>
In-Reply-To: <c4c6e1cd-1236-4bcb-9fab-a65b20304922@oss.qualcomm.com>
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Mon, 27 Apr 2026 23:58:24 +0500
X-Gm-Features: AVHnY4IQcVB-_aFFMn5rKDD8SrR0rd9lvLiDY9PuTc5qTGpTjrE2QwNGv8dhhlM
Message-ID: <CALrERebJhL8LPgphbDBPy_PHUt-Z8CSC+ogSOMeWfa+3TeBh1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] linux-user: Filter /proc/*/task/ to hide
 QEMU-internal threads
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000ae2928065075b32f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ae2928065075b32f
Content-Type: text/plain; charset="UTF-8"

On 4/27/26, Pierrick Bouvier wrote:
> It seems like this patch does two different things:
> - fix issue when all entries are filtered
> - add mechanic to filter non-guest threads
>
> It would be more reviewable to implement this in two different patches.

Good point. I will split this in v3:

  patch 1: refactor do_getdents()/do_getdents64() to wrap the body in
          an outer retry loop. Pure refactor with no functional change
          (without a filter installed, the inner loop always produces
          an entry per non-EOF host batch, so the outer loop exits on
          the first iteration and behavior is identical).

  patch 2: add the fd_trans tag for /proc/<pid>/task and the
          actual entry filter.

> I guess it does not protect from opening directly a specific thread
> file, but there is no reason someone knows the id without performing a
> getdents first.

Correct, and this is intentional. The libcap PSX deadlock we are
fixing only happens via /proc/self/task/ enumeration, so closing the
direct-open path is not required to fix the bug. It would also be
hard to do soundly: a guest can already obtain a non-guest TID via
/proc/self/status (Tgid/PPid), gettid() in a host signal handler,
etc., and blanket-filtering those would break legitimate uses. Happy
to revisit if you can point me at a concrete attack/correctness path
that direct open would expose.

Thanks for the review,
Ali

--000000000000ae2928065075b32f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 4/27/26, Pierrick Bouvier wrote:<br>&gt; It seems like =
this patch does two different things:<br>&gt; - fix issue when all entries =
are filtered<br>&gt; - add mechanic to filter non-guest threads<br>&gt;<br>=
&gt; It would be more reviewable to implement this in two different patches=
.<br><br>Good point. I will split this in v3:<br><br>=C2=A0 patch 1: refact=
or do_getdents()/do_getdents64() to wrap the body in<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 an outer retry loop. Pure refactor with no functional cha=
nge<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (without a filter installed, the =
inner loop always produces<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 an entry p=
er non-EOF host batch, so the outer loop exits on<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 the first iteration and behavior is identical).<br><br>=C2=A0=
 patch 2: add the fd_trans tag for /proc/&lt;pid&gt;/task and the<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actual entry filter.<br><br>&gt; I guess it do=
es not protect from opening directly a specific thread<br>&gt; file, but th=
ere is no reason someone knows the id without performing a<br>&gt; getdents=
 first.<br><br>Correct, and this is intentional. The libcap PSX deadlock we=
 are<br>fixing only happens via /proc/self/task/ enumeration, so closing th=
e<br>direct-open path is not required to fix the bug. It would also be<br>h=
ard to do soundly: a guest can already obtain a non-guest TID via<br>/proc/=
self/status (Tgid/PPid), gettid() in a host signal handler,<br>etc., and bl=
anket-filtering those would break legitimate uses. Happy<br>to revisit if y=
ou can point me at a concrete attack/correctness path<br>that direct open w=
ould expose.<br><br>Thanks for the review,<br>Ali</div>

--000000000000ae2928065075b32f--

