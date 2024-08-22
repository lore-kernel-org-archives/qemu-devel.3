Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shB7X-0004Vk-VW; Thu, 22 Aug 2024 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1shB7V-0004UL-LD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:57:09 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1shB7T-0004QX-HA
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:57:09 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f3f68dd44bso12387121fa.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724345825; x=1724950625; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vqYv44eNMe3f9JNYIiZe0Y4BWrUV6mmRC7f0+GfRAcI=;
 b=lTpwpCb/5lqROHC+XvlIrwMZzFxa1+DG/ihzgkVp3/GETm1svvAtP2Z/pWBeI6klAj
 9ByYaxoS+SnsrB7fYaiU5uyxmLqf9OwlTuLnLi+7NDuVuTE8FsgggqcJDVIVn0WZN3KD
 kMe+9SNqFs+ZBYcMGmJRHj1guBh8IAamlVZvw1hUGkuxB21ncq+GIZM/mKGlLMHA6C97
 ba4cX/IFWxQOIq5NCl/dgBJiEY2OIXivc9eEhfxdbYVB8Ku9XdGkE7wvMFj7rG1X49db
 tGDgbk/iIBOYPNbA7g7OtRvd1d4emBA4PaSB4//EMUfkDexHq9hKvz/1gw902izSvLD5
 iCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724345825; x=1724950625;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vqYv44eNMe3f9JNYIiZe0Y4BWrUV6mmRC7f0+GfRAcI=;
 b=FRE+iSsAfJxcT9Lh+De+AX+5MdrnBG81nch26OFFqeNV6lhTSTZsGvB0d+rnIkSGm/
 ed0+8HLdfYSNHq2efJ6dTok8vl7EFOMmVjIB1MSzouAP9MVdquv0wxdG1P865Bw/HK7y
 SRCaRH68wBycEUeaFMw2D4i+7M5J46mu0hwUSdKpIMYv8hVfejlg254At7/bmSMFh3c/
 bxu9SFtYyidP7bvz0WPUFWvUVF0BiGDKuj2Ev70ZRIwFeu4ygZafRWQ/NY0wnLvPYl/A
 tS7afMO7PD6m9sj3TLbTqQbUiNfeLoM8coXK/qCcpb47Gm4xxVuLHWTab15FxsRVYgsr
 GjcA==
X-Gm-Message-State: AOJu0Yw0cS2yGB01s/L2Z2uNL31q/wsOFf/p2xtb6P1p5O5+25/Arfhs
 UbJE6xgLCoRUJeCe10WcOeM/T0tRZBvvATFj0dcB6QgCuQflLu3D/+4F9UidTcJ0PXUtnaJhHUc
 ZDAM6s+YHxFzmGJcZZUb1n6mK0Na8SCGI8Bo=
X-Google-Smtp-Source: AGHT+IHtax+3724MJEwzp4MMGgRTBVNSWqYNiKQ7AhGn6+SRfdvIWH3sv6APth9j9rjz3pHTQr7Elhxdyi5nRBzgKE4=
X-Received: by 2002:a2e:e0a:0:b0:2ef:2c0f:283e with SMTP id
 38308e7fff4ca-2f3f8832ab0mr31824931fa.12.1724345824532; Thu, 22 Aug 2024
 09:57:04 -0700 (PDT)
MIME-Version: 1.0
From: Arman Nabiev <nabiev.arman13@gmail.com>
Date: Thu, 22 Aug 2024 19:56:53 +0300
Message-ID: <CAGMt57fehAuo7jLURogTVPtRosEWZ_hC+5yb5+hCBumJxjAbnw@mail.gmail.com>
Subject: [PATCH v2] target/ppc: Fix migration of CPUs with TLB_EMB TLB type
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000057616d0620488c04"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=nabiev.arman13@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000057616d0620488c04
Content-Type: text/plain; charset="UTF-8"

From: Arman Nabiev <nabiev.arman13@gmail.com>

In vmstate_tlbemb a cut-and-paste error meant we gave
this vmstate subsection the same "cpu/tlb6xx" name as
the vmstate_tlb6xx subsection. This breaks migration load
for any CPU using the TLB_EMB CPU type, because when we
see the "tlb6xx" name in the incoming data we try to
interpret it as a vmstate_tlb6xx subsection, which it
isn't the right format for:

 $ qemu-system-ppc -drive
 if=none,format=qcow2,file=/home/petmay01/test-images/virt/dummy.qcow2
 -monitor stdio -M bamboo
 QEMU 9.0.92 monitor - type 'help' for more information
 (qemu) savevm foo
 (qemu) loadvm foo
 Missing section footer for cpu
 Error: Error -22 while loading VM state

Correct the incorrect vmstate section name. Since migration
for these CPU types was completely broken before, we don't
need to care that this is a migration compatibility break.

This affects the PPC 405, 440, 460 and e200 CPU families.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2522
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Arman Nabiev <nabiev.arman13@gmail.com>
---
 target/ppc/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 731dd8df35..d433fd45fc 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
 }

 static const VMStateDescription vmstate_tlbemb = {
-    .name = "cpu/tlb6xx",
+    .name = "cpu/tlbemb",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
-- 
2.34.1

--00000000000057616d0620488c04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From: Arman Nabiev &lt;<a href=3D"mailto:nabiev.arman13@gm=
ail.com">nabiev.arman13@gmail.com</a>&gt;<br><br>In vmstate_tlbemb a cut-an=
d-paste error meant we gave<br>this vmstate subsection the same &quot;cpu/t=
lb6xx&quot; name as<br>the vmstate_tlb6xx subsection. This breaks migration=
 load<br>for any CPU using the TLB_EMB CPU type, because when we<br>see the=
 &quot;tlb6xx&quot; name in the incoming data we try to<br>interpret it as =
a vmstate_tlb6xx subsection, which it<br>isn&#39;t the right format for:<br=
><br>=C2=A0$ qemu-system-ppc -drive<br>=C2=A0if=3Dnone,format=3Dqcow2,file=
=3D/home/petmay01/test-images/virt/dummy.qcow2<br>=C2=A0-monitor stdio -M b=
amboo<br>=C2=A0QEMU 9.0.92 monitor - type &#39;help&#39; for more informati=
on<br>=C2=A0(qemu) savevm foo<br>=C2=A0(qemu) loadvm foo<br>=C2=A0Missing s=
ection footer for cpu<br>=C2=A0Error: Error -22 while loading VM state<br><=
br>Correct the incorrect vmstate section name. Since migration<br>for these=
 CPU types was completely broken before, we don&#39;t<br>need to care that =
this is a migration compatibility break.<br><br>This affects the PPC 405, 4=
40, 460 and e200 CPU families.<br><br>Cc: <a href=3D"mailto:qemu-stable@non=
gnu.org">qemu-stable@nongnu.org</a><br>Resolves: <a href=3D"https://gitlab.=
com/qemu-project/qemu/-/issues/2522">https://gitlab.com/qemu-project/qemu/-=
/issues/2522</a><br>Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.=
maydell@linaro.org">peter.maydell@linaro.org</a>&gt;<br>Signed-off-by: Arma=
n Nabiev &lt;<a href=3D"mailto:nabiev.arman13@gmail.com">nabiev.arman13@gma=
il.com</a>&gt;<br>---<br>=C2=A0target/ppc/machine.c | 2 +-<br>=C2=A01 file =
changed, 1 insertion(+), 1 deletion(-)<br><br>diff --git a/target/ppc/machi=
ne.c b/target/ppc/machine.c<br>index 731dd8df35..d433fd45fc 100644<br>--- a=
/target/ppc/machine.c<br>+++ b/target/ppc/machine.c<br>@@ -621,7 +621,7 @@ =
static bool tlbemb_needed(void *opaque)<br>=C2=A0}<br>=C2=A0<br>=C2=A0stati=
c const VMStateDescription vmstate_tlbemb =3D {<br>- =C2=A0 =C2=A0.name =3D=
 &quot;cpu/tlb6xx&quot;,<br>+ =C2=A0 =C2=A0.name =3D &quot;cpu/tlbemb&quot;=
,<br>=C2=A0 =C2=A0 =C2=A0.version_id =3D 1,<br>=C2=A0 =C2=A0 =C2=A0.minimum=
_version_id =3D 1,<br>=C2=A0 =C2=A0 =C2=A0.needed =3D tlbemb_needed,<br>-- =
<br>2.34.1<br><br></div>

--00000000000057616d0620488c04--

