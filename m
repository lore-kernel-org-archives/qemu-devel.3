Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B43CF258A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 01:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sznKo-0007he-EW; Sat, 12 Oct 2024 21:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ansorensen1118@gmail.com>)
 id 1sznKm-0007hK-3G
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 21:23:48 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ansorensen1118@gmail.com>)
 id 1sznKk-0005sn-It
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 21:23:47 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e29267b4dc4so1450431276.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728782625; x=1729387425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xkz/AA9q7njB4bWRltnRDHKan3lI5vjbm3sQdZddlFk=;
 b=XA5xGAS24pWQ2LX15Dapap1zLLKtRnbgtjdul4VLdgSfDxn9axYmE5YsmY+HH3KpbE
 +W1KOXuTc7fOYxP+oMLNWXmkYMpxPSxUPW4JCFfVAjMEWNm66mAzDu5Mv/hYjeDD4yEt
 YhqWKQ01wi9QF9mDsjgX1a6SuOo54exCuWv/qxkseEI8aOHTV+tJmDlCIdLV2ByhNONI
 73vwfj39aTLBsL3O1Y11kmy4efOs411xkUChpiixeq69qncSqcoR+jw1NoVzk8O74e51
 97Np//tiYBHtYYRIdbv5cRIWMC9W9I+na9NvBaTx8RRibwM+2mB7txGjlVjsiWBbVeEB
 f7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728782625; x=1729387425;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xkz/AA9q7njB4bWRltnRDHKan3lI5vjbm3sQdZddlFk=;
 b=YTA/PLxZjqFUTcVVMIO29KwpCpIWevJzbT2EQplV+NfldJ7FYe5xu3Qt7lk010z5fR
 zyXzmhEz7ltspSp3vozDtU3R7rg9H6ILKkeMP0spYhDe3QNF8taEowYacs4r+TCudTtp
 e1jnhctHBR6Afe9fCKM59518TG1MUDE+NRLq7tpQ9MsC1wVZOjiROIHOyO4uiESsENL5
 0ikL5K9xeCo/L6GSevuv69UzVTKx+I8LQWil38sL9PKieKiTUCcSWxS8wuI7nbx1MaYV
 zx7EYub5hBrqLJFHuitQzvTFbJM3AHM5WyYxfBrHfFL9vY2CqRolrwi20h5phBJiqTkW
 TZmA==
X-Gm-Message-State: AOJu0YxzURdgjtOkB0QK3UOFvvOQ3Ma95WxB4tw0+TmGCI5v+dy0EC7+
 wHeQo6JGz9+Psu1SYWTsZMcfQcfI4hzuOiC4KBF4qoXRrlcf3vxAGIkeoAAWQtTuXLUXkg/PiPt
 Cp4TttIVgSMS7pgaBrEs60rvnjG56Xnwt
X-Google-Smtp-Source: AGHT+IHB9Ev9BNFMUPUmC+gyOnssaoysftWNmC5aVJdgQLwBy/vVs1j5soglaW2hjyF/IPZvpKwy+XDTZNyNe0liYLA=
X-Received: by 2002:a05:6902:258a:b0:e29:204:9052 with SMTP id
 3f1490d57ef6-e2931bca73dmr2575278276.35.1728782625077; Sat, 12 Oct 2024
 18:23:45 -0700 (PDT)
MIME-Version: 1.0
From: Anston Sorensen <ansorensen1118@gmail.com>
Date: Sat, 12 Oct 2024 20:24:00 -0500
Message-ID: <CAJ0YB0a-MdVWVoXqGjpRtToVcX-HXA=vRfVOO9VOvcutxvvmkg@mail.gmail.com>
Subject: What is the status of the performance of D-Bus? Should it be used?
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000043041c0624519207"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=ansorensen1118@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000043041c0624519207
Content-Type: text/plain; charset="UTF-8"

Hi,


I have a few questions regarding the status of D-Bus.


Normally, D-Bus should be used for direct input/output with QEMU (if only
local access is needed). The driver is not in a good state and needs to be
replaced though, correct? Should I still use D-Bus, or is there an
alternative that is better at the moment?


I would rather not use spice or VNC, as spice is discontinued and VNC is
slow.


Thank you,

Anston

--00000000000043041c0624519207
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><p style=3D"margin:0px;font-stret=
ch:normal;line-height:normal;font-size-adjust:none;font-kerning:auto;font-v=
ariant-alternates:normal;font-variant-ligatures:normal;font-variant-numeric=
:normal;font-variant-east-asian:normal;font-feature-settings:normal" dir=3D=
"auto"><font color=3D"#000000">Hi,</font></p><p style=3D"margin:0px;font-st=
retch:normal;line-height:normal;font-size-adjust:none;font-kerning:auto;fon=
t-variant-alternates:normal;font-variant-ligatures:normal;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-feature-settings:normal"><fo=
nt color=3D"#000000"><br></font></p><p style=3D"margin:0px;font-stretch:nor=
mal;line-height:normal;font-size-adjust:none;font-kerning:auto;font-variant=
-alternates:normal;font-variant-ligatures:normal;font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-feature-settings:normal"><font color=
=3D"#000000">I have a few questions regarding the status of D-Bus.</font></=
p><p style=3D"margin:0px;font-stretch:normal;line-height:normal;font-size-a=
djust:none;font-kerning:auto;font-variant-alternates:normal;font-variant-li=
gatures:normal;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-feature-settings:normal"><font color=3D"#000000"><br></font></p><p styl=
e=3D"margin:0px;font-stretch:normal;line-height:normal;font-size-adjust:non=
e;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures:n=
ormal;font-variant-numeric:normal;font-variant-east-asian:normal;font-featu=
re-settings:normal"><font color=3D"#000000">Normally, D-Bus should be used =
for direct input/output with QEMU (if only local access is needed). The dri=
ver is not in a good state and needs to be replaced though, correct? Should=
 I still use D-Bus, or is there an alternative that is better at the moment=
?</font></p><p style=3D"margin:0px;font-stretch:normal;line-height:normal;f=
ont-size-adjust:none;font-kerning:auto;font-variant-alternates:normal;font-=
variant-ligatures:normal;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-feature-settings:normal"><font color=3D"#000000"><br></font><=
/p><p style=3D"margin:0px;font-stretch:normal;line-height:normal;font-size-=
adjust:none;font-kerning:auto;font-variant-alternates:normal;font-variant-l=
igatures:normal;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-feature-settings:normal"><font color=3D"#000000">I would rather not us=
e spice or VNC, as spice is discontinued and VNC is slow.</font></p><p styl=
e=3D"margin:0px;font-stretch:normal;line-height:normal;font-size-adjust:non=
e;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures:n=
ormal;font-variant-numeric:normal;font-variant-east-asian:normal;font-featu=
re-settings:normal"><font color=3D"#000000"><br></font></p><p style=3D"marg=
in:0px;font-stretch:normal;line-height:normal;font-size-adjust:none;font-ke=
rning:auto;font-variant-alternates:normal;font-variant-ligatures:normal;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;font-feature-settin=
gs:normal"><font color=3D"#000000">Thank you,</font></p><p style=3D"margin:=
0px;font-stretch:normal;line-height:normal;font-size-adjust:none;font-kerni=
ng:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:=
normal"><font color=3D"#000000">Anston</font><br></p></div>
</div>
</div>
</div>
</div>
</div>

--00000000000043041c0624519207--

