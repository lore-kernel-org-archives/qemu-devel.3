Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AE9C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKXQw-0001B5-06; Thu, 29 May 2025 03:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam.zheng@bytedance.com>)
 id 1uKXQt-0001Al-LM
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:12:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fam.zheng@bytedance.com>)
 id 1uKXQp-0003lT-Qi
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:12:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so88332866b.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1748502716; x=1749107516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:from
 :references:from:to:cc:subject:date:message-id:reply-to;
 bh=m36nJapWM9mo3HMxoWZ7T+xAzswOXBIaHgZBEPa88co=;
 b=bAajf66tTWjBm0GSBlAxxUwp48YWpUKZqkDe1giW8PKHN3EsSY4VYWSVuKrQ4Pf633
 eO3GbAIIfLoXBitJ8oWcLOg0hZ7/3ZrjKWFEXncuZGOq3NcNx3ceBSmqUSOV+7+hoa/F
 oMOxA/ybtNwHCwwf2C73VzUyR7alrDjDvUlbb+/v/ZrfYrJaORu0tQRx45rwcQWVtE3j
 CWLq/WlC49ag7dlP+SAVrNKahjQqgIT/RMk9J/0wrcef5S04MmyOS6yKqWzelz5mSS2M
 iwSYWM/1UQpEsgq7JFAtAWhPoyPPMWl91n5gfSUa/dOFVbHQFvEEYAx9ZPW1RVTMu9JZ
 Jo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748502716; x=1749107516;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:from
 :references:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m36nJapWM9mo3HMxoWZ7T+xAzswOXBIaHgZBEPa88co=;
 b=Ejjq6KkHkVsAcJ78nEapLu9YwEUvUjWclC9/m/UzLPF0s06t0W4TYyo82/FzYD+OUM
 V40EnSxaVpM6kKKmLl2Jzx/jTRIvWzA8DrqYOxLt2jHOAC6yELySnQ7u0nQRQlJREM4V
 5Nfl8NhT7VTjyJFWItivPbGtkAwIraubpQ4r4nVg5KwqCUqIesIFy59Bw+wPw43Z0cDt
 /TsheF1gsc8ghA5FDJTRLkQiUHaSnQkxJceIzkhhg/xW9KDHsGCd11+d2ujR3/5vawmj
 Q522wo5W7ae0bxiaZcnjl7oRDHDU9l1XMxzBvmxt6ZKSOREE9eYvxVfIXpl1iIrAoeCk
 jDeg==
X-Gm-Message-State: AOJu0YylUGenRDp7kQoCdSSClloMQKSsyZ0m9iYaEJj+sGpnaWkatvPk
 Hvh4UNoK81iwAnp3lQjcy8fMW47oJeDk3L4EOzVgbyyCZqz1+fD3TVpEsHLzHuwcCScbbfOoQ4f
 nnJXX2V5HXEeEaN+yliruFbawhlUatrHgJi2XlzT8HN1aqLN/V0z7
X-Gm-Gg: ASbGncs3bc0fzvfHT7+3gx0bBKk9J52tc3mRUJZRLUiO034fBkMXRc0bW4o31wW4u+p
 s/KsdPmptszP3tQG/9uf7xaN7hV5MNCiFP06+UHl+QCOJncKrrcBggveiF5UhASSa6Eb6SmOxbW
 xanhej0OA6XdHr0ITT3vmEW/HoA8rXHGOf8g==
X-Google-Smtp-Source: AGHT+IEjI1sIM6k4aQ8cLwB1rIlHout/T1/+M54aqxkfhGQM+yeMCIbMiipMJwKU3ZHm+Cj0UgANwaMN6fWy2mFqMHs=
X-Received: by 2002:a17:906:8f16:b0:ad8:8d89:bbfe with SMTP id
 a640c23a62f3a-ad88d89c8dfmr765689666b.60.1748502715964; Thu, 29 May 2025
 00:11:55 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 29 May 2025 09:11:54 +0200
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 29 May 2025 09:11:54 +0200
References: <20250528033156.1188531-1-pizhenwei@bytedance.com>
From: Fam Zheng <fam.zheng@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <20250528033156.1188531-1-pizhenwei@bytedance.com>
Date: Thu, 29 May 2025 09:11:54 +0200
X-Gm-Features: AX0GCFt4moKtcsX_RXSwvKo7XPIoNY7At_-APInkz5ofp1gPHWNNo5v9uNBafjU
Message-ID: <CAG+v+KbMaDv6Ea-m1JxphLGFDHkz3Scu_-5paFQdgC=Rkr1GOg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update email of zhenwei pi
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000046455a0636410381"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=fam.zheng@bytedance.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000046455a0636410381
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Fam Zheng <fam.zheng@bytedance.com>
From: "zhenwei pi"<pizhenwei@bytedance.com>
Date: 2025=E5=B9=B45=E6=9C=8828=E6=97=A5 (=E5=91=A8=E4=B8=89) 04:32
Subject: [PATCH] MAINTAINERS: update email of zhenwei pi
To: <qemu-devel@nongnu.org>
Cc: <fam.zheng@bytedance.com>, "zhenwei pi"<pizhenwei@bytedance.com>
I will leave ByteDance in the next days. Update email to stay reachable.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7060cf49b9..2da7cf76b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3278,7 +3278,7 @@ T: git https://gitlab.com/ehabkost/qemu.git
machine-next

 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
-M: zhenwei pi <pizhenwei@bytedance.com>
+M: zhenwei pi <zhenwei.pi@linux.dev>
 S: Maintained
 F: include/system/cryptodev*.h
 F: backends/cryptodev*.c
--=20
2.43.0

--00000000000046455a0636410381
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_1.18.0_Z9XGVj71" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div dir=3D"auto" style=3D"font-size:16px">Acked-by: Fam Zh=
eng &lt;<a class=3D"not-doclink" href=3D"mailto:fam.zheng@bytedance.com" ta=
rget=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:2px;text-=
decoration:none;color:rgb(20,86,240)">fam.zheng@bytedance.com</a>&gt;</div>=
</div></div><div class=3D"history-quote-wrapper" id=3D"lark-mail-quote-1748=
50268"><div style=3D"list-style-position:inside"><div class=3D"adit-html-bl=
ock adit-html-block--collapsed" style=3D"border-left-width:medium;border-le=
ft-style:none;border-left-color:currentcolor;padding-left:0px"><div><div cl=
ass=3D"adit-html-block__attr history-quote-meta-wrapper history-quote-gap-t=
ag" id=3D"lark-mail-quote-meta-KFVbQjlGY" style=3D"padding:12px;background:=
rgb(245,246,247);color:rgb(31,35,41);border-radius:4px;margin-top:24px;marg=
in-bottom:12px"><div id=3D"lark-mail-quote-1d1ccc7c52303e60ec1afe6cf3040462=
"><div style=3D"word-break:break-word"><div style=3D""><span style=3D"white=
-space:nowrap">From: </span><span style=3D"white-space:nowrap">&quot;zhenwe=
i pi&quot;&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;text-d=
ecoration:none;color:inherit" href=3D"mailto:pizhenwei@bytedance.com" class=
=3D"quote-head-meta-mailto">pizhenwei@bytedance.com</a>&gt;</span></div><di=
v style=3D""><span style=3D"white-space:nowrap">Date: </span> 2025=E5=B9=B4=
5=E6=9C=8828=E6=97=A5 (=E5=91=A8=E4=B8=89) 04:32</div><div style=3D""><span=
 style=3D"white-space:nowrap">Subject: </span> [PATCH] MAINTAINERS: update =
email of zhenwei pi</div><div style=3D""><span style=3D"white-space:nowrap"=
>To: </span><span style=3D"white-space:nowrap">&lt;<a style=3D"white-space:=
pre-wrap;word-break:break-word;text-decoration:none;color:inherit" href=3D"=
mailto:qemu-devel@nongnu.org" class=3D"quote-head-meta-mailto">qemu-devel@n=
ongnu.org</a>&gt;</span></div><div style=3D""><span style=3D"white-space:no=
wrap">Cc: </span><span style=3D"white-space:nowrap">&lt;<a style=3D"white-s=
pace:pre-wrap;word-break:break-word;text-decoration:none;color:inherit" hre=
f=3D"mailto:fam.zheng@bytedance.com" class=3D"quote-head-meta-mailto">fam.z=
heng@bytedance.com</a>&gt;</span>, <span style=3D"white-space:nowrap">&quot=
;zhenwei pi&quot;&lt;<a style=3D"white-space:pre-wrap;word-break:break-word=
;text-decoration:none;color:inherit" href=3D"mailto:pizhenwei@bytedance.com=
" class=3D"quote-head-meta-mailto">pizhenwei@bytedance.com</a>&gt;</span></=
div></div></div></div><div><div>I will leave ByteDance in the next days. Up=
date email to stay reachable.
<br><br><span>Signed-off-by: zhenwei pi &lt;<a href=3D"mailto:pizhenwei@byt=
edance.com" target=3D"_blank">pizhenwei@bytedance.com</a>&gt;
</span><br>---
<br>=C2=A0MAINTAINERS | 2 +-
<br>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
<br><br>diff --git a/MAINTAINERS b/MAINTAINERS
<br>index 7060cf49b9..2da7cf76b7 100644
<br>--- a/MAINTAINERS
<br>+++ b/MAINTAINERS
<br><span>@@ -3278,7 +3278,7 @@ T: git <a href=3D"https://gitlab.com/ehabko=
st/qemu.git" target=3D"_blank">https://gitlab.com/ehabkost/qemu.git</a> mac=
hine-next
</span><br>=C2=A0<br>=C2=A0Cryptodev Backends
<br><span>=C2=A0M: Gonglei &lt;<a href=3D"mailto:arei.gonglei@huawei.com" t=
arget=3D"_blank">arei.gonglei@huawei.com</a>&gt;
</span><br><span>-M: zhenwei pi &lt;<a href=3D"mailto:pizhenwei@bytedance.c=
om" target=3D"_blank">pizhenwei@bytedance.com</a>&gt;
</span><br><span>+M: zhenwei pi &lt;<a href=3D"mailto:zhenwei.pi@linux.dev"=
 target=3D"_blank">zhenwei.pi@linux.dev</a>&gt;
</span><br>=C2=A0S: Maintained
<br>=C2=A0F: include/system/cryptodev*.h
<br>=C2=A0F: backends/cryptodev*.c
<br>--=20
<br>2.43.0<br></div></div></div></div></div></div></body></html>

--00000000000046455a0636410381--

