Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D589E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 15:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKfYw-0000VU-MD; Mon, 09 Dec 2024 10:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tKfYv-0000VM-Ty
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:20:41 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tKfYu-000488-A0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:20:41 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-51623968932so598568e0c.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733757638; x=1734362438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7J3Gi5sEZKOigphPUHH1DeQSygmC5fikQaEHNAsgQjs=;
 b=Nmp9ZuUUN5v6KmrM3jGV4KIkweRybPoIYYI1EUNf0N8nGg7a6pRGd2BI1fLCTk/1Mo
 ciuSfBFajDndGxRkQlkB+9WQEuBindIa6o5LJK0kKrxETgahYghtL0qqWKbcIL9EAdVG
 suETrGMa19b8isxpwIB75mB44NjfbQJqAzj9QZjMafgJ0GQdu2qcfItK0FNMwCS65yKd
 0YaaZ5ouS48ZNxbawyWC6uOLB5w8NLr7XyXnS+8eWgborzkSeuSLJ2Sd2A5JThTUmStE
 FzaxYsOPGwSOeoHETRftnoFOKX7PL6yvZLqCNVZqWM8MTTKOaNrIoW77ysMg9u+cUo4B
 zfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733757638; x=1734362438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7J3Gi5sEZKOigphPUHH1DeQSygmC5fikQaEHNAsgQjs=;
 b=pFBikkLQEowVpeFrglruCC0MiWkTozFVKmNVbCqKeoHnX7C1YC7U++nsZ4fdt/F7Ds
 aOoNCn5mlpfNMah1eQJvBD8yWcMV9+81pc2aoeinc/GO5xxKwQ+YxDUzCKovhaG/qvwE
 /Nw9Hp4lCY1iP2yEiHkrgfbIQW+YHTHALmCknu9sxbH8Z50abXjlOg7r53HKIiCIXn+9
 66/PB67DiYScyYIlpKDOBNbPYIv4OADL67URvPeZc6k+HhwHKdblSY/ZvVcbcVcUTCls
 ARIv4CJiMdefjIwZMR68O0vjfcyvyGx/3OMZY7m5Xyuz3iWPVTOGAqvLsBaSHIbU4tai
 an7A==
X-Gm-Message-State: AOJu0YwaobknuCu+X1M7BOKBR/pbxPvzF30XPiVXaOWEb71pR2RP/IvJ
 I2bdVLjB7Wi0/Mh16PWOf+J9yXKTe4NOuumUj1VwMfe1KJ6gSM8rtor6i5AXx0+VC1sDnSWE925
 OUesCHE+eyRENgOLDCtBtfrFbnfg=
X-Gm-Gg: ASbGncvoeHU7BBov3IXIPf3TkUSSINSM6tkVvBm2HxMpUfi0s7vYYJ0xe6xVvC5xKgr
 rpIb04MSvjjOwwkyUywOH161L/Kx1gESL/w==
X-Google-Smtp-Source: AGHT+IHqyHQdgYrNM9UjnuRs1bSuZ0N1Bjpo4WyciK1QM8xyZL6BlCMqqwR+uWoaItk7enR0tsBCcIceDj7NDFGay18=
X-Received: by 2002:a05:6122:6413:b0:516:1106:4c1a with SMTP id
 71dfb90a1353d-5161106580fmr7672627e0c.12.1733757638684; Mon, 09 Dec 2024
 07:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20241109122844.24057-1-dorjoychy111@gmail.com>
 <50eaf439-5812-41be-b279-55274bb3ca78@amazon.com>
In-Reply-To: <50eaf439-5812-41be-b279-55274bb3ca78@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 9 Dec 2024 21:20:49 +0600
Message-ID: <CAFfO_h4yV7+EKKu7On2Z7jr3NXD7-izRe3=hK+7dLeSaq3yR6g@mail.gmail.com>
Subject: Re: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Dec 2, 2024 at 9:36=E2=80=AFPM Alexander Graf <graf@amazon.com> wro=
te:
>
>
> On 09.11.24 13:28, Dorjoy Chowdhury wrote:
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
>
> (nit: Please make sure to always have a patch description in the body of
> the patch, even if it feels like the subject says it all)
>
> Reviewed-by: Alexander Graf <graf@amazon.com>
>

cc Paolo. This has been reviewed so can be picked up for merging.

Regards,
Dorjoy

