Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzY9-0007bC-HP; Mon, 19 May 2025 08:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1uGzY7-0007aq-6c
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:24:55 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1uGzY4-0005Vo-6p
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:24:54 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-476b4c9faa2so63333781cf.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747657489; x=1748262289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tFFX/gtXiSFhcZGrLTQtaw1fYAtWju7tu4cRr0xv2Y=;
 b=HGszit6T/o0KSEaA4NetYRMdoBsAoT7ga7An3RUjmCgCe5xjPCzInVnLO9scxNXdMs
 MY6Qte29V1Th8t4DSaRz+z8bVTQsE2yidZXsCuti1TSU3QlXM4I+nD6NThehDH7kr/l+
 1EPnjcv87OpIL6ZxgTOdsOFpskOPMBaQIQm/GZxkCVk2+PgqECaCp+uBifem9REFxuBi
 Dbt2xT0Mr2MqJPa04Ra2qbh+4b44yw7PQON+sKryn9479glCmqQX+01g8cT9YyLIXTJY
 zYlDhD2BHsjPbUClm8wvridBDfu0OfVNugAEPwfYglqxbQ/qoh4OI1yyUigRUIHRAjcD
 VnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657489; x=1748262289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tFFX/gtXiSFhcZGrLTQtaw1fYAtWju7tu4cRr0xv2Y=;
 b=gNfsIoZqmepCgkLakkOP/yA4kHziC7mb9tQKi7u30KzKpPfeGx07WDLYdkwA1W84xQ
 YB4OZ8422/rb5P9L/DEXy7ufm1T5RgwpmDujFvJP7JAFdyTl8uHjzk2HurfZ8sEyLXU5
 2tJef/H5tjO6sGXqlvqvQ83ckvVtCx0uFhWidO3zq/THEIh/MgeS+O75oOTVtMANOmFF
 oPsXz9b3UuXLUGekuIg9XNktGRnR/edOAK5fhZtDg1Y6gpZkigtQ67jSWfS3kX4Cl44Q
 ssFEdlJfYXWpho03e049ZYp0MaH9XL7XKkOpCg3bX6Q0ninsz6AqoQOi9Tq4fIyk4y+K
 UxOQ==
X-Gm-Message-State: AOJu0Yz0ReL5Ih3cHMlFSF5BTGw5QSjgxX3lLtwnFRu8zD4nskeDE2w+
 8XjF7UAJWP7Zzaob0anI33OHdJibM/H979MvvS45wqD8ghE/aOypOnWM+tt1ewu6+Dpc+cOMYW0
 7xdjomaqahvCW7HYUQEldpzt7MQSB99Q=
X-Gm-Gg: ASbGncsjyg+F05GVMFvgJQxvSTSO5yr7fEvaJ8zbVl8WwDnq75VM4/M5/eqHOJIS3Ai
 b3UqqV4HYdZIxRlUGyPOFi2eyQjTSMIkSOeFQizQih94nBmIFHqkecX6zl5eqNK2T2hlA91B1bG
 pML0UjKtYbVeBOww+D64wkExgVxS0Mlrc=
X-Google-Smtp-Source: AGHT+IGdup8o2TpESYglxWEBfs3WuoYIvRZfKw6rRCekjvqmnJ+QWQM0lTBJbtPMhXOZvGBc/t7wfW2OSzzaDNhwzOs=
X-Received: by 2002:a05:622a:8c9:b0:494:f1e7:65ea with SMTP id
 d75a77b69052e-494f1e81bc6mr155888781cf.36.1747657489609; Mon, 19 May 2025
 05:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
 <20250326123059.1268756-1-aleksandar.rakic@htecgroup.com>
 <PA4PR09MB4864D472FB32302BC1BD162584BA2@PA4PR09MB4864.eurprd09.prod.outlook.com>
 <PA4PR09MB4864BA648EA8F2BBBE2999478491A@PA4PR09MB4864.eurprd09.prod.outlook.com>
In-Reply-To: <PA4PR09MB4864BA648EA8F2BBBE2999478491A@PA4PR09MB4864.eurprd09.prod.outlook.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Mon, 19 May 2025 14:24:38 +0200
X-Gm-Features: AX0GCFsKRJbHXFh0h4CjMANDH649OiQAimPVHNkpGCtgBKjzbXuVaSWVCZDwdNI
Message-ID: <CAGQJe6r8vK2qQKgwU8cbHESUj0sn27aHAP853YkgofHHJPc=Zw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=arikalo@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 14, 2025 at 4:10=E2=80=AFPM Aleksandar Rakic
<aleksandar.rakic@htecgroup.com> wrote:

> Could you please let us know if you have any comments
> on the latest version of this patch?
>
> Kind regards,
> Aleksandar Rakic

I confirm my "reviewed-by" for v5 1/3 (v5 is the same as the initial
one I reviewed, except tests are added).

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

All the Best,
-- Aleksandar

