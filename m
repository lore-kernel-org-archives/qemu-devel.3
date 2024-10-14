Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B99ACF258E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 01:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t09e1-00083i-Rn; Sun, 13 Oct 2024 21:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1t09dx-00083C-Rp
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:13:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1t09dw-0000P7-8Q
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:13:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c803787abso24365435ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728868382; x=1729473182; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WOODR6qoRMQCpMYe1ZnLvJ1dTneMZvkNnUgWTmzGKDs=;
 b=fKx47Uu3r+t7QuzoBUR06+XXmoNjAHGtbZV8voftowS3MgpUlZ9mkXrumcpee9+4oN
 +UlvbMdX0IraHzRiz5zMyJLwckv8TT5B+00LGjbzhTO6gq9xVkw+FJkI+WGhCqKl91sg
 OIPhFpwDETFwZC98JkryhMBllaueaUE6X2OmMYHcsswZuGkDE7X/G3AHaEcIUVUWvN2a
 TPxSrtra++A3wk8CDI7De7Cjw6TMYKpwEtjNsvyYTSitHHfBQ/wEpnzlqGSV+Zirl5MT
 G8ZT6uMaXscI4X+SsMzZoBA9uuMN6ELm5pvW/GoG1XPDdsi965HJfVtKNi+CvQ7suO3g
 O+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728868382; x=1729473182;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOODR6qoRMQCpMYe1ZnLvJ1dTneMZvkNnUgWTmzGKDs=;
 b=O0KLRbUxNv45nBrpygwQmUWv92QNNXQ/Cg57ufhjI9IQM0hlPvOYomcB33J8WZbvze
 rl+HR/i+l+00nFZBOH9ur0RCVL69OxjVt3O+aKdGCfxWX4/i1qF5KifCwccIWuI8e2wp
 21tVk2oo1dGrux03ju0FfRlwn5r8/KCEgqX3E5HHXaAkHn/keqNnK6FH7gRjU2RGNMKR
 u/r38l/tpWtKKzZvwyz6bWIVU/qy5vlV0PAS9nxsmZ2iJnE/Sln1A9x8rpna/BUha6SR
 YMisKyh43giI3fuKww6OBYvJsF4b1ys8uyq9j7iyj+6QSvNNG3/dn9haH78lvbs+BBuS
 woKQ==
X-Gm-Message-State: AOJu0YzJa6Skhe3GoYhkBm7RW9DESAvqg8zkLjehuZD8u2k2TPhuR2Sf
 SYyTEj0np9Eg86NGFS4j/D4ZU5ZvKCYtEpOU0qdxehpBcwlLrJGanJNfxPBkn4d/aX7gM6CAgva
 6s/bXnzeOocvi70H3R91yOhu2XeRHCe6a
X-Google-Smtp-Source: AGHT+IGVZFFszDrJYO4i9Ykl3EfgqaiddZwUpB7HtOdlMW0iN29wpQvwC5qYGPGUPKdmH9h/VIXl3RmDQyXMl/Ttfz4=
X-Received: by 2002:a17:902:e88f:b0:205:8a8b:bd2a with SMTP id
 d9443c01a7336-20c804ee3d6mr204000535ad.22.1728868382169; Sun, 13 Oct 2024
 18:13:02 -0700 (PDT)
MIME-Version: 1.0
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon, 14 Oct 2024 04:18:42 +0300
Message-ID: <CA+rFky6nRpHj8xKa7Wnw_coe_gbJoSXn61fc87-w0Z_7V-aBPw@mail.gmail.com>
Subject: ALSA support in qemu-user?
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c8625d06246589ff"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=randrianasulu@gmail.com; helo=mail-pl1-x636.google.com
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

--000000000000c8625d06246589ff
Content-Type: text/plain; charset="UTF-8"

some 8 years ago this patch was sent  to qemu-devel:

https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05333.html
"[Qemu-devel] [PATCH 7/7] Add ALSA ioctls"

I wonder why it was rejected, may be as part of series?

Right now I use OSS Proxy Daemon providing oss and ALSA output at the same
time, so qemu-i386 /usr/bin/mplayer -ao oss still works, but this is recent
addition to my system and having  normal ALSA output for mplayer and co
will be useful for me, at least.

I can try to reapply it to current  git. But it will be sad if it was
rejected due to some deeper reasons I do not understand (for example I only
recently noted that qemu plugins basically only for observation, not for
altering qemu internals.)

Any comments, memories on this functionality?

PS: please add me to cc, I am not subscribed to qemu-devel (only watch it
via web-interface)

--000000000000c8625d06246589ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>some 8 years ago this patch was sent=C2=A0 to qemu-de=
vel:</div><div><br></div><div><a href=3D"https://lists.gnu.org/archive/html=
/qemu-devel/2016-06/msg05333.html">https://lists.gnu.org/archive/html/qemu-=
devel/2016-06/msg05333.html</a></div><div>&quot;[Qemu-devel] [PATCH 7/7] Ad=
d ALSA ioctls&quot;</div><div><br></div><div>I wonder why it was rejected, =
may be as part of series?</div><div><br></div><div>Right now I use OSS Prox=
y Daemon providing oss and ALSA output at the same time, so qemu-i386 /usr/=
bin/mplayer -ao oss still works, but this is recent addition to my system a=
nd having=C2=A0 normal ALSA output for mplayer and co will be useful for me=
, at least.</div><div><br></div><div>I can try to reapply it to current=C2=
=A0 git. But it will be sad if it was rejected due to some deeper reasons I=
 do not understand (for example I only recently noted that qemu plugins bas=
ically only for observation, not for altering qemu internals.)</div><div><b=
r></div><div>Any comments, memories on this functionality?</div><div><br></=
div><div>PS: please add me to cc, I am not subscribed to qemu-devel (only w=
atch it=C2=A0 via web-interface)<br></div></div>

--000000000000c8625d06246589ff--

