Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F7FC28B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZKj-0002it-N6; Wed, 12 Mar 2025 23:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tsZKZ-0002i9-CB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:33:59 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tsZKX-0005ir-I0
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:33:59 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30c2d427194so5698981fa.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741836833; x=1742441633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=llJLdAhd5pWNyilXZCjXYM2hxmoqQcD6/g84Ng8G0sM=;
 b=TmiSI7QUYAg4hf/C3YI3t7Ear3B4HSuj0krFp78JE0HLs85eukaSQo6fcgIT/+R4o5
 QUOJxhJB2X3rJJCB/watPjcLfCbidS1vAt0ZAipB2HxfsKHDoXHYWGuFFqSXXyu44ADX
 U4oPjMeUxrxSTw/gHmxS4Q5QYUnjxNOPUn58Tjtd5ZBXcqKw++tTkHlXGgcDBYA4+Wk0
 An00+bsEdGHncLDx7C9iyAjurlgT74NHXcA+fc9Wwi1oxg3Yqp7cYdGValQe27jeBTCp
 5ZA882knCVWXhNqSmmJL8NdYq17ewJmFUeNnIq3e71ZCNfA3psJO6syj64phvgt6wNVw
 UF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741836833; x=1742441633;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llJLdAhd5pWNyilXZCjXYM2hxmoqQcD6/g84Ng8G0sM=;
 b=ucWiDgZZorJ2EVORSHKJV8ov3U7nf9m618/rLJuRwGhYr9QxR/BiFwOFNz8qVYLkpC
 tV+goekb2K4Pe2yhWUWImCnrp2NTAmyhWuD6Kje76zlZkVIzubkbEaWI9FVJOT5u7CV6
 jxwuIT3Y/zhuKhTA4Wn2T6HFsL5zn51oFVVcmvgOiSVdDeiB+lwUlIfqFZtNH1ajSV8a
 Jg1BSaE5am2Hx+RnrzLP6YoD2C9vstHSGUkpEAhc/2I1hhKjP2c5eWERH9ihI2LCWYYx
 Eu/up28ahGVRS1rZDJIZi6D+bgvWTyrwl8sHTwHOR35OibDpdJfjEh2yK6ZNmJZ1gio5
 gwbw==
X-Gm-Message-State: AOJu0YwBQ0/rgCRbkE7qAGUGM6sw1WfAzpALqP6gumbwayIxm31vqg+i
 zN/aPhzO+ePt5xewV89yMcMaIAt09ggFnheBMKJhkwea7/n+ZqGS7cz5k640xXtRLuT8euLdxM1
 OaXIiq+gCTIC+VLySbf9xSmcw0cT2Iybd/w==
X-Gm-Gg: ASbGncuNp8JUBzAUU7E7H2/o+dTplmcom1cvHuy9WFBsz7LvTeKZBdGT2mCUFUNxY4y
 1s6Qo7aUD2NkpgGM1R7Ug+mP/YT1z4mcpdT19vzmFYYPs//jFvm2y4ZBOoem06Jrzq1e5s5949j
 7ldcwv7pqWMSP4Xr/CVjJYT+4=
X-Google-Smtp-Source: AGHT+IE2Pxt3rnupGZRQCbbNo2SyyDUmZe/tVAW0t8LBEqUFxtb6xOVXIFJDL0g4k6JL31BFJ0tvxYtLjErnzLnZ9k8=
X-Received: by 2002:a2e:7a0a:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-30c20696d86mr37917291fa.18.1741836832802; Wed, 12 Mar 2025
 20:33:52 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 13 Mar 2025 11:34:25 +0800
X-Gm-Features: AQ5f1JoNua4GkWwKma3kxCrWm_pHzHZtB-Cmj3H0PoypIgZjTKl2hQKG5rOPN3Q
Message-ID: <CAOYM0N03vdsc31JFan4cDBpk8z4CZrXfUSZ0hQfxM9xyQW1cOg@mail.gmail.com>
Subject: How to build with subprojects/slirp.wrap? but not native libslirp
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Content-Type: multipart/alternative; boundary="000000000000ad0d6f063030fd26"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x230.google.com
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

--000000000000ad0d6f063030fd26
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

According to the commit below, configure qemu like this:
$ ./configure --enable-debug --enable-slirp

and even before configure, i did:
$ meson subprojects download

but qemu still builded with native libslirp,
then how can I build with slirp.wrap? even when libslirp is installed on
the system.

*commit 0abe33c13adb0ef67bfbbdce30dc5d9735899906*











*Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
<marcandre.lureau@redhat.com>>Date:   Thu Mar 2 17:18:47 2023 +0400
build-sys: add slirp.wrap        This allows to build with --enable-slirp /
-D slirp=3Denabled, even when    libslirp is not installed on the system.
 "meson subprojects download"    will pull it from git in that case.
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
<marcandre.lureau@redhat.com>>    Message-Id:
<20230302131848.1527460-4-marcandre.lureau@redhat.com
<20230302131848.1527460-4-marcandre.lureau@redhat.com>>    Signed-off-by:
Paolo Bonzini <pbonzini@redhat.com <pbonzini@redhat.com>>*

--000000000000ad0d6f063030fd26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>According to the commit below, configure qemu like th=
is:</div><div>$ ./configure --enable-debug --enable-slirp</div><div><br></d=
iv><div>and even before configure, i did:</div><div>$ meson subprojects dow=
nload</div><div><br></div><div>but qemu still builded with native libslirp,=
=C2=A0</div><div>then how can I build with slirp.wrap? even when libslirp i=
s installed on the system.  =C2=A0 </div><div><br></div><div><i>commit 0abe=
33c13adb0ef67bfbbdce30dc5d9735899906</i></div><i>Author: Marc-Andr=C3=A9 Lu=
reau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@re=
dhat.com</a>&gt;<br>Date: =C2=A0 Thu Mar 2 17:18:47 2023 +0400<br><br>=C2=
=A0 =C2=A0 build-sys: add slirp.wrap<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Thi=
s allows to build with --enable-slirp / -D slirp=3Denabled, even when<br>=
=C2=A0 =C2=A0 libslirp is not installed on the system. =C2=A0&quot;meson su=
bprojects download&quot;<br>=C2=A0 =C2=A0 will pull it from git in that cas=
e.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Signed-off-by: Marc-Andr=C3=A9 Lureau=
 &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat=
.com</a>&gt;<br>=C2=A0 =C2=A0 Message-Id: &lt;<a href=3D"mailto:20230302131=
848.1527460-4-marcandre.lureau@redhat.com">20230302131848.1527460-4-marcand=
re.lureau@redhat.com</a>&gt;<br>=C2=A0 =C2=A0 Signed-off-by: Paolo Bonzini =
&lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;</i><=
br></div>

--000000000000ad0d6f063030fd26--

