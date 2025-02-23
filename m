Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8221C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 15:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDtL-0001J5-Id; Sun, 23 Feb 2025 10:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jksoftdeveloper@gmail.com>)
 id 1tmDHZ-0005fr-Sf
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:48:38 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jksoftdeveloper@gmail.com>)
 id 1tmDHY-000771-7k
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:48:37 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e0505275b7so5761481a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322114; x=1740926914; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7wwhNC53TLt5k9Xg5aKnIYGSdc2F+Vokb8tVJFJ+I3s=;
 b=ngB3eiSYOG6iQm12KwcdN4PjZ0LHri1AgjVFlTh9ej9+d3mzzj/KddCpUKgcbEDaqh
 y00ZpgDVMYhowzKZZVEnc1w3ImEwqrvUqTtfzRJ4w0RhpF4Eizpl4ZYEM3OoqriTIY+e
 5XugtZMdfettXXY5/64IGKmHsTBFZ8Hjz6CAiWKNBHIJvZNsuXfSBYJBRA7k9lEMySXA
 KKMnV8yFkGIQ/fxnC7mv2wGbWJW6ZHgMSviZUna0qFHX0Ox1y9jI9Ryed9/IszZJHleG
 ATI/4fecXF33g1LHMxo6INQU9apyqC+nivogluQDPg3EwRp4738aHlqdc0aBtf+vO5m7
 X0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322114; x=1740926914;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wwhNC53TLt5k9Xg5aKnIYGSdc2F+Vokb8tVJFJ+I3s=;
 b=B50tBH8V8Kt2tSMU+n1bx2VfcxPQgBZsYMSbWCrLvVUuVYRUZV1RqlwSgi2dLpdNNm
 /ggQbG4ROBdaHH59fYUlYuxta07VOu9SoLLulO3r6fZLXWlGBzFn2cuJ1Hx40zds2eUM
 MxMg2OLSuubE+Ohjd2G5luuVcnLPX5QNH//S5f8Tn7ZaxRo59CdfiJS9D3CcF08gDheW
 eJt0cnBvvEFfTjPbSaPV7vJTf8NrKdpJcoZViwyDa/qxfEAzElLTV1+EeQBxUFWAXQ2C
 TSFTDanejJ+H+ctVv6Jos/mqNcAt1AgiauXr++2pQEiIygKHgxhv7RmNs+QvChVjcIlS
 l2eg==
X-Gm-Message-State: AOJu0YxzMy6rGDd9kU2Y6z/j1GmKcWfB/uOD4pEQFCHXqllCateqAq3b
 tImnYrco+KcMWjzlx1kTY1hMHDl+LVjgDzKJ6YTV4Aj+y7aPY4iUACvCj+O4XimmG8CXdPsBgf8
 e9Shmn75Mzqom9TAHwO4vlXPHxaXckg==
X-Gm-Gg: ASbGncuN0xnPy+a6bs7i36DSSqvsYN7eYqAa6m9+MQNRZOwkF/2eqQxBmX1MtsdUU5e
 nMIqPp/dOWZ2LYCrNjS1WI2a30++Gt4EmqHspU8q8K8h91+6QncEiZ89HA6Uhl+Lui32Qiqy+vd
 VOqVzY82qxmiWmPmLcj2R1EOC1T6mRNBpQtdTd++kC
X-Google-Smtp-Source: AGHT+IFy86ZWIBUi1gHpCmyGFMvWjUZz3/yW/zy/66d5tYA1lc0GR9GiUfIx+K3Il7OYsTZdE8Qp+px07dzuTKucQ/g=
X-Received: by 2002:a05:6402:2102:b0:5e0:82a0:50dc with SMTP id
 4fb4d7f45d1cf-5e0b72500dcmr9508249a12.28.1740322113731; Sun, 23 Feb 2025
 06:48:33 -0800 (PST)
MIME-Version: 1.0
From: Jayakrishnan A <jksoftdeveloper@gmail.com>
Date: Sun, 23 Feb 2025 20:18:22 +0530
X-Gm-Features: AWEUYZmKLQp6JZcKmkokKsE3imXwCeBrckJD3bLEBETDQ8g22c3z02cgw6yfDpc
Message-ID: <CAEHwtECacvmv98uAvXisx57qEN1hMbLjHNWUkm8mOt56wtWGaQ@mail.gmail.com>
Subject: Seeking help on implementing sync over ivshmem shared memory
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006248c1062ed051bf"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=jksoftdeveloper@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 23 Feb 2025 10:27:37 -0500
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

--0000000000006248c1062ed051bf
Content-Type: text/plain; charset="UTF-8"

Hi Team ,

Seeking help on implementing sync over ivshmem shared memory , As part of
internal project we could able to achieve shared ivshmem with doorbell
mechanism ,But in order to achieve shared memory synchronisation we are
trying to add atomic operation  over this shared memory area variables ,
Just wanted to analyse whether this atomic variable between VMs shared
memory will work as expected , If not is there any suggested way ahead to
implement synchronisation over ivshmem shared memory for threads running in
multiple VMs.

Thanks and Regards ,
Jayakrishnan A

--0000000000006248c1062ed051bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team ,<div dir=3D"auto"><br></div><div dir=3D"auto"><div dir=3D"auto">Se=
eking help on implementing sync over ivshmem shared memory , As part of int=
ernal project we could able to achieve shared ivshmem with doorbell mechani=
sm ,But in order to achieve shared memory synchronisation we are trying to =
add atomic operation =C2=A0over this shared memory area variables , Just wa=
nted to analyse whether this atomic variable between VMs shared memory will=
 work as expected , If not is there any suggested way ahead to implement sy=
nchronisation over ivshmem shared memory for threads running in multiple VM=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks and Regards ,=
=C2=A0</div><div dir=3D"auto">Jayakrishnan A</div><br></div>

--0000000000006248c1062ed051bf--

