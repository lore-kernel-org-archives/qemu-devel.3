Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34497D78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7el-0002nc-HV; Mon, 02 Dec 2024 09:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tI7ek-0002nT-LA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:44:10 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tI7ei-00011k-AH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:44:10 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-5152685aa0dso821609e0c.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733150641; x=1733755441; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olpclqpdbckmZjwmrrX+NRmQ9MAxVGc9nDo/UWwQb8Q=;
 b=Ve7acQBkjgOj2WmWN7wGM7mD4Ck4TLeoMH71D4ru6apWGe9f1EPaVrg90VwAxRWisg
 bCM12EnuCxd4Pl54yIGPdyF6ZmNph+2PLcnZ0i5EDnf6ZhSfQL7eK97EjMekJHUDBvJB
 2rTnmKuHgFJnNGMcEAsQ02nyfSAtKhN542SCGsce9V8rVU6fNDv30cE2z4Xlbe6qvOOP
 ffGdgxht76BPan5NsvclHilCSSjMAyRNtVUixPsul/AEXU/n0vEBK6kyxbZRH+2W6Ksm
 yqAZpuej2a5fGyyFDnvEULuDYx3WgrNpSi6Fc1fTxnK8yJ4oGcsikMy/YP+GmTANyU73
 b0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733150641; x=1733755441;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olpclqpdbckmZjwmrrX+NRmQ9MAxVGc9nDo/UWwQb8Q=;
 b=qWQzKn1evXENzdeP4EkPloXRefyEw9l/0vbu/qQMum5/LifBOzJT8hCCfvqHS+PYZI
 16jKPAwRkeJHGsHcGiiYPoNCtw1dNVuk4wMhoAzafWLoVl0VsbaKS1j4iMYxbri9/F3d
 6IvP58pktak3j8i+6bM8Ne4B3EQUjEDeAQrsRL3iF8aiH7SieFFGRpBgbf/5UXDJmPXB
 ImTdXoLhU6bN7OHaQjO4HCL2csOguL0fXrr58K2prxHIibOmtXFp/Qj6bWgluqdhKW3Y
 RqPQRNAfWwUcq998U4eNMoXdoveMwyXSIWHs3obVZaZgljGl5Go1KYkswjXenzlWw/kb
 4f4w==
X-Gm-Message-State: AOJu0YxsYSLaxxHwQ+KTBij7xIpJOjYJ4GEugYE0Oou+cqU+y4ys/QNL
 3mV5+hRFSoBHKaUlQhqsg7in4t312PsiZC5PZV0ByyS59GmogdZs555lECkKczR9G+d5MK8QTbt
 qecQOt2cud6P6nxAQOr7niWxZyYcePQ==
X-Gm-Gg: ASbGncvLLtKPO9rwcoo24ISVRjkSKRJ+GOS1BYIT4p9bHzUdUYZ+yoczuYWwQjDg0bQ
 PffyBkwR+OwrUKlcjbcQCBo1KXi6CVjZcfQ==
X-Google-Smtp-Source: AGHT+IGa7t0ANm+Q7SI+QnfERZBZREznnWMgLaxuVAgYN+/83s/WyIiDzjyri7C1K2NviK14OkhK8UWpt881DdVnGdU=
X-Received: by 2002:a05:6122:c87:b0:50a:cb38:31d5 with SMTP id
 71dfb90a1353d-51556b0e4b6mr26229093e0c.12.1733150641219; Mon, 02 Dec 2024
 06:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20241109122844.24057-1-dorjoychy111@gmail.com>
 <CAFfO_h7QxmXNGv2DM900hUvN7GG+WRTq6774it4VLq6FzmS6Aw@mail.gmail.com>
 <CAFfO_h7nMKUB1AhTHdEMf0w4Mj_M-UCqQsQ4c2TF2n-sQDJsYQ@mail.gmail.com>
In-Reply-To: <CAFfO_h7nMKUB1AhTHdEMf0w4Mj_M-UCqQsQ4c2TF2n-sQDJsYQ@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 2 Dec 2024 20:44:09 +0600
Message-ID: <CAFfO_h4RRQ4WikMDzWVJ5YoNNLSFUgj-8w4-tpT4TG9G4GV=4g@mail.gmail.com>
Subject: Re: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
To: qemu-devel@nongnu.org, graf@amazon.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa31.google.com
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

On Mon, Nov 25, 2024 at 8:59=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> On Mon, Nov 18, 2024 at 7:10=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gm=
ail.com> wrote:
> >
> > Ping.
> >
>
> Ping...
>
> This is a very small one that should fix the UI issue in
> https://www.qemu.org/docs/master/system/i386/nitro-enclave.html . It
> would be great if it could be reviewed and picked up for merging.
> Thanks!
>

Gentle ping.

Regards,
Dorjoy

