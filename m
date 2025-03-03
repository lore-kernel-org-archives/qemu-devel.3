Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A210C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Jm-00023s-EJ; Mon, 03 Mar 2025 08:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangpengcheng.pp@bytedance.com>)
 id 1tp2yB-0001m9-ET
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:24:20 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangpengcheng.pp@bytedance.com>)
 id 1tp2y7-0005Wz-TE
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:24:18 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f6b65c89c4so1637126eaf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1740997451; x=1741602251; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=z90qa9XVM2Hw25sX314g1+III6NKy9XBsCbbQWH7Yl0=;
 b=c7j9FW0vOx9LptFcrRhJtBWZvvcm6IBnCDS8NerpEeNH3CPVbiTR4kjekF3xz18ihP
 q89lhtZ0s5Qtdz03U6dZrX7NR829DH7H0Jj8sMOrSsExCC6MkyBAlK6c5oq5wCoxVc/E
 WlopyxYtzodm87J+11SAdIdVNnT9bDOMs2jNoxK6HB3uwfX5lD+p++hQszb6X2HFfZhJ
 3w5cjFjOuMsF9gslBcYjlgqQTfTGM3vh0fHIiUhLlW27SlqX2hVQGUfMduMcNoyqvWv3
 ka/fBg+GNSSlfOf0XDaYWNVjytg8yCyzr9pc1r9QqhSyDP/ma3zfny5pyi08tE8tqkfy
 C4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740997451; x=1741602251;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z90qa9XVM2Hw25sX314g1+III6NKy9XBsCbbQWH7Yl0=;
 b=NqkkCvdoIigksuXOMbP3bnrL5sKSj24a0tevn1WOnBksjN9pN+Su0KyEc4DSbG6HtS
 VJ3NGm3s9x2Yqt7lRGkD8VHexx/0xFV8UpvY3rgtgqcQ5yH9S8YtymNb7wqKBL2Qn5vS
 00fJ1m4YtF5GqHXO+yZpgmZYnthjQePPRFj71ZBKC+SqNONHzib12GGQAM2b8xVZ0t0m
 x1JRKhF+JU0qwePvSY5T7Diux76pR1aScSjda2ok2Zd/JNgy7cRF6CkYwnuDBJdmJ6EW
 pD4QDSELAwmK4sp3iSIhZt0PIart0XsnrtdBeXryU11h+YdpABwDYilLV1N0V7PyF1jU
 qY/g==
X-Gm-Message-State: AOJu0Ywt0E23DKpfZNIMIm5Tl2YdSoNVSWkYSc3JjnCES821TcxPi5vJ
 FebAVORDIyozphnauWzzj+aeYdQFF58fYPmJLO0t+K+BlzpPFx1q+9DWgmUqTvfP0mVI9mR6Sh5
 P8z++R6FcydxnNlP+qAHLntpKs5lrhmLVUdlG/A==
X-Gm-Gg: ASbGncuPpQbENefyFxy4x1zh24AzjhhGSGKsuhX5Sbc/8QTLvXENm3Xo3ZjTMowvrFf
 7H8Xdy3hMonfUzhi2998D/DJs8YnDEI0khp9EWB72UT6nlyCsZqiV+3jvRKo9+iEOsxUxb2NO/M
 HdQ8bDuIUrEjfKQmOdAeIHhINQxTVr
X-Google-Smtp-Source: AGHT+IEML89iddHopPI8LxVzTb5+s3HluoCQDEndohiZFzpU5zEOHIZg/eJkg1/A6WxhROqE9MFvE4VcYAr/UdSEAhU=
X-Received: by 2002:a05:6820:1e12:b0:5fd:1401:7d32 with SMTP id
 006d021491bc7-5feb3584067mr5958267eaf.8.1740997451081; Mon, 03 Mar 2025
 02:24:11 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 3 Mar 2025 02:24:09 -0800
From: =?UTF-8?B?5rGq6bmP56iL?= <wangpengcheng.pp@bytedance.com>
In-Reply-To: <20250303100927.3443321-1-christoph.muellner@vrull.eu>
References: <20250303100927.3443321-1-christoph.muellner@vrull.eu>
Mime-Version: 1.0
Date: Mon, 3 Mar 2025 02:24:09 -0800
X-Gm-Features: AQ5f1JpPol5J-t-yCdVUEMvMucTpd54bvsTPUy5uuJwu4osQTBdu2nIpUqeDl5w
Message-ID: <CAHtqR7WAa09mwhO1QeQb9b7NR==ajLnuDC=L=NzYHNSS-6kjZQ@mail.gmail.com>
Subject: Re: [PATCH] contrib/plugins: Install plugins to moddir
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a080e4062f6d8e74"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=wangpengcheng.pp@bytedance.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Mar 2025 08:58:40 -0500
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

--000000000000a080e4062f6d8e74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What about plugins under `tests/tcg/plugins/`?
From: "Christoph M=C3=BCllner"<christoph.muellner@vrull.eu>
Date: Mon, Mar 3, 2025, 18:09
Subject: [External] [PATCH] contrib/plugins: Install plugins to moddir
To: <qemu-devel@nongnu.org>, "Alex Benn=C3=A9e"<alex.bennee@linaro.org>, "A=
lexandre
Iooss"<erdnaxe@crans.org>, "Mahmoud Mandour"<ma.mandourr@gmail.com>, "Pierr=
ick
Bouvier"<pierrick.bouvier@linaro.org>
Cc: "Wang Pengcheng"<wangpengcheng.pp@bytedance.com>, "Christoph M=C3=BClln=
er"<
christoph.muellner@vrull.eu>
Currently the built plugins can only be found in the build directory.
This patch lists them as installable objects, which will be copied
into qemu_moddir with `make install`.

Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
---
 contrib/plugins/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 82c97ca0f5..c25a1871b7 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -14,11 +14,15 @@ if get_option('plugins')
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
+                        dependencies: glib,
+                        install: true,
+                        install_dir: qemu_moddir)
     else
       t +=3D shared_module(i, files(i + '.c'),
                         include_directories: '../../include/qemu',
-                        dependencies: glib)
+                        dependencies: glib,
+                        install: true,
+                        install_dir: qemu_moddir)
     endif
   endforeach
 endif
--=20
2.47.1

--000000000000a080e4062f6d8e74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_7.37.0_xLisITrU" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">What about plugi=
ns under `tests/tcg/plugins/`?=C2=A0</div></div></div><div class=3D"history=
-quote-wrapper" id=3D"lark-mail-quote-174099744"><div><div style=3D"border-=
left:none;padding-left:0px" class=3D"adit-html-block adit-html-block--colla=
psed"><div><div class=3D"adit-html-block__attr history-quote-meta-wrapper h=
istory-quote-gap-tag" id=3D"lark-mail-meta-AInAwZkKl" style=3D"padding:12px=
;background:rgb(245,246,247);color:rgb(31,35,41);border-radius:4px;margin-t=
op:24px;margin-bottom:12px"><div id=3D"lark-mail-quote-e2c4f23b02cb14280e10=
36b3f3ace1d5"><div style=3D"word-break:break-word"><div style=3D"" class=3D=
"lme-line-signal"><span style=3D"white-space:nowrap">From: </span> <span st=
yle=3D"white-space:nowrap">&quot;Christoph M=C3=BCllner&quot;&lt;<a class=
=3D"quote-head-meta-mailto" style=3D"white-space:pre-wrap;word-break:break-=
word;text-decoration:none;color:inherit" href=3D"mailto:christoph.muellner@=
vrull.eu">christoph.muellner@vrull.eu</a>&gt;</span></div><div style=3D"" c=
lass=3D"lme-line-signal"><span style=3D"white-space:nowrap">Date: </span> M=
on, Mar 3, 2025, 18:09</div><div style=3D"" class=3D"lme-line-signal"><span=
 style=3D"white-space:nowrap">Subject: </span> [External] [PATCH] contrib/p=
lugins: Install plugins to moddir</div><div style=3D"" class=3D"lme-line-si=
gnal"><span style=3D"white-space:nowrap">To: </span> <span style=3D"white-s=
pace:nowrap">&lt;<a class=3D"quote-head-meta-mailto" style=3D"white-space:p=
re-wrap;word-break:break-word;text-decoration:none;color:inherit" href=3D"m=
ailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;</span>, <span st=
yle=3D"white-space:nowrap">&quot;Alex Benn=C3=A9e&quot;&lt;<a class=3D"quot=
e-head-meta-mailto" style=3D"white-space:pre-wrap;word-break:break-word;tex=
t-decoration:none;color:inherit" href=3D"mailto:alex.bennee@linaro.org">ale=
x.bennee@linaro.org</a>&gt;</span>, <span style=3D"white-space:nowrap">&quo=
t;Alexandre Iooss&quot;&lt;<a class=3D"quote-head-meta-mailto" style=3D"whi=
te-space:pre-wrap;word-break:break-word;text-decoration:none;color:inherit"=
 href=3D"mailto:erdnaxe@crans.org">erdnaxe@crans.org</a>&gt;</span>, <span =
style=3D"white-space:nowrap">&quot;Mahmoud Mandour&quot;&lt;<a class=3D"quo=
te-head-meta-mailto" style=3D"white-space:pre-wrap;word-break:break-word;te=
xt-decoration:none;color:inherit" href=3D"mailto:ma.mandourr@gmail.com">ma.=
mandourr@gmail.com</a>&gt;</span>, <span style=3D"white-space:nowrap">&quot=
;Pierrick Bouvier&quot;&lt;<a class=3D"quote-head-meta-mailto" style=3D"whi=
te-space:pre-wrap;word-break:break-word;text-decoration:none;color:inherit"=
 href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a=
>&gt;</span></div><div style=3D"" class=3D"lme-line-signal"><span style=3D"=
white-space:nowrap">Cc: </span> <span style=3D"white-space:nowrap">&quot;Wa=
ng Pengcheng&quot;&lt;<a class=3D"quote-head-meta-mailto" style=3D"white-sp=
ace:pre-wrap;word-break:break-word;text-decoration:none;color:inherit" href=
=3D"mailto:wangpengcheng.pp@bytedance.com">wangpengcheng.pp@bytedance.com</=
a>&gt;</span>, <span style=3D"white-space:nowrap">&quot;Christoph M=C3=BCll=
ner&quot;&lt;<a class=3D"quote-head-meta-mailto" style=3D"white-space:pre-w=
rap;word-break:break-word;text-decoration:none;color:inherit" href=3D"mailt=
o:christoph.muellner@vrull.eu">christoph.muellner@vrull.eu</a>&gt;</span></=
div></div></div></div><div><div class=3D"lme-line-signal">Currently the bui=
lt plugins can only be found in the build directory.
<br>This patch lists them as installable objects, which will be copied
<br>into qemu_moddir with `make install`.
<br>
<br><span>Signed-off-by: Christoph M=C3=BCllner &lt;<a href=3D"mailto:chris=
toph.muellner@vrull.eu" target=3D"_blank">christoph.muellner@vrull.eu</a>&g=
t;
</span><br>---
<br>=C2=A0contrib/plugins/meson.build | 8 ++++++--
<br>=C2=A01 file changed, 6 insertions(+), 2 deletions(-)
<br>
<br>diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
<br>index 82c97ca0f5..c25a1871b7 100644
<br>--- a/contrib/plugins/meson.build
<br>+++ b/contrib/plugins/meson.build
<br>@@ -14,11 +14,15 @@ if get_option(&#39;plugins&#39;)
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0include_directories: &#39;../../include/qemu&#39;,
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0link_depends: [win32_qemu_plugin_api_lib],
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0link_args: win32_qemu_plugin_api_link_flags,
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dependencies: glib)
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dependencies: glib,
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0install: true,
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0install_dir: qemu_moddir)
<br>=C2=A0 =C2=A0 =C2=A0else
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0t +=3D shared_module(i, files(i + &#39;.c&#3=
9;),
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0include_directories: &#39;../../include/qemu&#39;,
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dependencies: glib)
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dependencies: glib,
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0install: true,
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0install_dir: qemu_moddir)
<br>=C2=A0 =C2=A0 =C2=A0endif
<br>=C2=A0 =C2=A0endforeach
<br>=C2=A0endif
<br>--=20
<br>2.47.1<br></div></div></div></div></div></div></body></html>

--000000000000a080e4062f6d8e74--

