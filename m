Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8863E9E30B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqAZH-0007NI-Lp; Wed, 11 Feb 2026 08:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1vq97N-0002jm-RB
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:14:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1vq97M-0005lZ-7h
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:14:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-436356740e6so4521015f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 04:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770812090; x=1771416890; darn=nongnu.org;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zG6fvW7Y4yEGvw/51SYY5erMqI42PQdEwcMjOYVkg6k=;
 b=exqq8facs+PYq3C3JypZjhCMHdDdhZYTGfi7M7A93GDy4fv7Wv5Fq5lSwPKryleCwc
 28HcWkIkLCpJlDqEh/EfnKP2KqQw9wPAEYRJkFGkGwDwqLqjaOiREefAP3Bxj0fi9oei
 uE0OIx6SiVr96SQONnzGXDZ/0y26OZiCeSy/TB+6VhjAGoAfcjs3LXiset+NGnZBVwLn
 i0CeTidMtWIfHsH2R69foTx0NMmFT3nlMBeCEKWrL6ebJAwDp2G0gcZDIYzXnFdUcz0E
 aA4Nbc5KH/txjd4nB4h28/pZR23SAMgDLn0hVebYaXF8nYM1GpR+SPnf/V7SHXH08WMf
 zgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770812090; x=1771416890;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG6fvW7Y4yEGvw/51SYY5erMqI42PQdEwcMjOYVkg6k=;
 b=A9ZGQgGCcOaKA01a9Mfc7p6atwudhKdM9rRbB4kHs6lnLlqQvgAPZD9sjSAEnG+7lK
 jA4La3aM0D/CQ8gi8hp116n9qtmhjuWISxsj0ZomSyIJ8IDaHgV30eKOgm/S9lZR+UAS
 AvV1LDm4WZKapPKNo4SQ/17VPkg/4g6fRh24JhIka9bXa3GY9k3jnGrolm0BILNZGmdn
 RBVxC5Is/MrIIDTVnciyYcd6aIp0uFffjV7QYq8T4QP7xnfn/32EDXtqk5jHj8xgANmF
 CagRuCR9+p6f7jgyDCKuIsiLQfntvTBS++tov41w2yNGcEBRaoeCF5tanUxP5b7HbEhj
 OaOA==
X-Gm-Message-State: AOJu0Yyo9CWPiayB5VvBLZK3eYLeFHuvMlkQNBwLTd4olzVtVd62lfO7
 tAY+urzzHlwcjXazZjBasS+KLETMFHRFKTgvICZGP8YycjyuRIhUkANP
X-Gm-Gg: AZuq6aKGRvvRYO00emZ2laA16kh6ub12S5pusWtXMwzI3xJ2r182DHSzqKhyKZuG71e
 COa9ci3pAyEjXp6Y+3pR2KzUPLssi3bAd2hwuxEuU59DdhBjT77J5oUMTYBSVLyZR6bqvt+tb5y
 amP9cfT949UEeiycUZKcqoJjjpX/iTeOtFyq1ttus8YSpCl5LoMZMqrC/B9PeTijH9awE/2vbQ0
 cj9KCg3+q27H4lJ9p2Utj47vr+1KqM5Z4C56Bl1LpjvnDXN+phQqbDoFcbPEhET0+nhR81HVpNB
 9//oQ8OjQDy2Cxg3ByG9D3FlmsOpBQl88eog/tJPdbz62uoJCBvZNEwN+Lh5ETLGG3axA1QktHb
 2AxR40CS/ZVWJDouZErUiAmIObpYkcBA/vArJ9uOk6XQGQ2ja3ZnGww5UIfykc+3V27tvhIw6sy
 0S9dS4mwd9SsDZupVzSl9Kmx5LHDTK+A4EjblR
X-Received: by 2002:a05:6000:1acb:b0:431:a43:ee88 with SMTP id
 ffacd0b85a97d-43782caf54amr4153348f8f.42.1770812089395; 
 Wed, 11 Feb 2026 04:14:49 -0800 (PST)
Received: from [192.168.0.107] ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfda66sm4482885f8f.22.2026.02.11.04.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 04:14:49 -0800 (PST)
Message-ID: <698c72b9.5d0a0220.3b91ca.1514@mx.google.com>
SavedFromEmail: elisey.konstantinov@gmail.com
Date: Wed, 11 Feb 2026 14:14:48 +0200
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
Importance: normal
From: "elisey.konstantinov" <elisey.konstantinov@gmail.com>
To: balaton@eik.bme.hu
Cc: qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--_com.samsung.android.email_1293409933850850"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 08:47:40 -0500
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

----_com.samsung.android.email_1293409933850850
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

VGVzdGVkLWJ5OiBFbGlzZXkgS29uc3RhbnRpbm92IDxlbGlzZXkua29uc3RhbnRpbm92QGdtYWls
LmNvbT5SZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNz
dWVzLzMyNzQ=

----_com.samsung.android.email_1293409933850850
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iPlRlc3RlZC1ieTog
RWxpc2V5IEtvbnN0YW50aW5vdiAmbHQ7ZWxpc2V5LmtvbnN0YW50aW5vdkBnbWFpbC5jb20mZ3Q7
PGRpdiBkaXI9ImF1dG8iPlJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS9pc3N1ZXMvMzI3NDwvZGl2PjwvYm9keT48L2h0bWw+

----_com.samsung.android.email_1293409933850850--


