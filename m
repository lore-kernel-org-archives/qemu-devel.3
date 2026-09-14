Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB73AC88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5zVJ-0005h4-S1; Mon, 14 Sep 2026 01:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x5zVH-0005gn-M8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:45:19 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x5zVF-0005Q2-Vl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:45:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED53C439B4;
 Mon, 14 Sep 2026 05:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9700F1F000FF;
 Mon, 14 Sep 2026 05:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789364714;
 bh=NasLpgnzyo9opigpQXP5scggM3RytPnBQgM/sa9RiOk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Akq4NTC2t9sOCsvoU2WrIlaZeeUz4W5hCGAgDYQhnHb3eMx8isgKUPlggrxa3odr1
 U1J3iU7XRGaYB4C/iBJ1qbepsILJGfm6vApWSmk+moUwP6s0YcGGmCob+5rLdlwjkV
 Bd7DOh9Ur4F+tWXX3ziIKpoNsI6Y284k+mYTfqilqJbNPpL3eW8kmJMHl/2TySmHVF
 isyxaKnDWQ79jXp2w1PE/o3k/UP66yt8dFqiwO0/7yqtcfyQUimpsURME4YaR9Tvmw
 YC9/fEHdNvlB8C2hZU7fUG9G5RiOq3Tc2iB4YFC5HjF9jr7p1ovZn2Z9iTBqEsZFdO
 n+xPSv+U8iUjw==
Date: Mon, 14 Sep 2026 07:45:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [GIT PULL 04/14] docs/sphinx/dbus: register build dependency
Message-ID: <20260914074511.269c7510@foz.lan>
In-Reply-To: <20260913-ui-v1-4-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
 <20260913-ui-v1-4-7a8d89d0423a@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 13 Sep 2026 14:41:22 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Touching dbus xml file wasn't enough to trigger a new build because
> the file wasn't registered to the dependency system.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Makes sense to me.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  docs/sphinx/dbusdoc.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/docs/sphinx/dbusdoc.py b/docs/sphinx/dbusdoc.py
> index be284ed08fd7..2b086e2f583c 100644
> --- a/docs/sphinx/dbusdoc.py
> +++ b/docs/sphinx/dbusdoc.py
> @@ -146,6 +146,7 @@ def run(self):
> =20
>          env =3D self.state.document.settings.env
>          dbusfile =3D env.config.qapidoc_srctree + "/" + self.arguments[0]
> +        env.note_dependency(os.path.abspath(dbusfile))
>          with open(dbusfile, "rb") as f:
>              xml_data =3D f.read()
>          xml =3D parse_dbus_xml(xml_data)
>=20



Thanks,
Mauro

