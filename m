Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B36EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZPpn-0001oN-Ux; Thu, 01 Aug 2024 03:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sZPpl-0001gB-TI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:02:45 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sZPpk-0006Qv-F2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:02:45 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-65fdfd7b3deso52543757b3.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722495763; x=1723100563;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y60dAhiB9TpAG3vFZA5OT41Hv33FRZaVbvibBwxofko=;
 b=q+NqVP4tnivumBM8wTipxzREJAMpLKYkFpemRKSwEIRbipQuMpD/D1cHFXzGhn0Rep
 fRJg5oOew6gDXEWjPFKj4CQBkGwtUdYMZLzMszbwpjYDcI3Q8jRIQleoGQZLhy71AFTh
 kCFBXxVHfuP5guj0E4AqGWRe6+phw/vZhPcbEKNsbEduJRO8BNneVrkrH/d8c4v/+CDn
 7RTYek0Ic61oGAflIS6aBOS1Y1XqlHA/vZGlvjoWqfTh3qIRehlyQegP2rzpy++1g+aM
 IBt7MMy63XDni9paQGu8pYiF8sweHvK+80X7aJYSfCSifCAgWAkW9wPgOUhHV+TQHnEQ
 +fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722495763; x=1723100563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y60dAhiB9TpAG3vFZA5OT41Hv33FRZaVbvibBwxofko=;
 b=Yir/F0WEEP1I0h/bPteK1/aSX/5XvlY9xvNjhg5KVbG52l/ezP4fgO8R0Cy0kNqQU2
 trSgdiczIOgWhCuUUGUzdYncHazuOF2upHc+CpgTwxuaIUTqfhOhpRjN3tWCJJZUDZmo
 qUHX9erccUXkYaK62LCowwLZEWtD+UbXTUPNcUlLMGJwgeJHxh1wp6UK8pwzoWAMyQqB
 TLNSdrdD1H8nPcnM82JOptcJ/sy8N/W2eB/pOcK8XDPu11aACNYzAdQOGIsZhGk59QRf
 V5e4nGmJfywz50bgoKJx3S8ItRiz4yyo6jXg7oz58XzE2z5WsEvKDHBqt1gYq6ysZfWe
 b7eA==
X-Gm-Message-State: AOJu0YyqEVyaaCIdOkmLJvkszwGGjGqL6f+7qdcnAJyPo8KsFXtXQnqr
 osmkhaiLtaSuQJ6fdFEGmFq9zT/Nx+gbGMELw3m8guoGH6Hh4xp1PI/A9bnv4wUqq3Z8SOKubc5
 S2MS0CGsdhH+oUF8WineDIubFBZXL/p5REmlwaCUDyN2DrgAX
X-Google-Smtp-Source: AGHT+IHgv+Zn8ZJrZVvAcIvuX+Mw7QUPd+mDCdPKOFTL8Ox3bgGBrKWJ7+2I775xS20/IXsjXvErbuGMUEcHBrOG3vU=
X-Received: by 2002:a0d:d203:0:b0:648:baba:542f with SMTP id
 00721157ae682-68744e6d071mr17331167b3.0.1722495763176; Thu, 01 Aug 2024
 00:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-10-debug@rivosinc.com>
 <91ed2cef-db2d-47b3-9141-1d0826ff0588@linaro.org>
In-Reply-To: <91ed2cef-db2d-47b3-9141-1d0826ff0588@linaro.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 1 Aug 2024 00:02:28 -0700
Message-ID: <CAKC1njQhdbjtD9Ofd+oKNJy6tX7o7Xr2AcHQesBxQOSn14ZVtw@mail.gmail.com>
Subject: Re: [PATCH v2 09/24] linux-user/riscv: implement indirect branch
 tracking prctls
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=debug@rivosinc.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 29, 2024 at 11:27=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/30/24 03:53, Deepak Gupta wrote:
> > +            /* set or clear branch tracking */
> > +            env->ufcfien =3D (flag & PR_INDIR_BR_LP_ENABLE);
> > +            tb_flush(env_cpu(env));
>
> tb_flush is not required when you track enable properly in patch 5.

ok. will fix it.

>
>
> r~
>

