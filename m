Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87895D3C933
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 03:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2jMA-0005Al-71; Sun, 20 Oct 2024 23:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2jM7-0005AK-QJ; Sun, 20 Oct 2024 23:45:19 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2jM6-0002Ke-BN; Sun, 20 Oct 2024 23:45:19 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4a492f73befso1056991137.2; 
 Sun, 20 Oct 2024 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729482317; x=1730087117; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji23ZJD5Z0v9qFSN8xOpbbcFvETbXKjj2Lz0GxzlBxY=;
 b=hJEUtRyEb7GTogme6AeZCicsRK6sv+QfEUdc0ii0XrIRn5DpxjKVBnVDJ38VJHM6X4
 kFzUQyk5I4ZRAfM75M5VHxMHDldDqeLvT9shAw54ARDyMO/PWNcEpAGauzlqkB06bong
 GPa/epqi8Kb0ehAvjT8IP6uWo3l0ROvjuj26+/LQ+M/AOnKVCnlgSh0bIpvzG2sZ+3rS
 zEhLuxr1QmAh3Ey/od9ibpBo+UtdFvThA1cGalSE8SIkwlfBOvfjzUB1hFmCFB9cctae
 x3EYSQe2A+OZI/CTAdP9+VCfj13mCSREIEV+Bwbp2Ddad2KITKXLbq+k0fS0vmDJ+Q+r
 eFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729482317; x=1730087117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji23ZJD5Z0v9qFSN8xOpbbcFvETbXKjj2Lz0GxzlBxY=;
 b=BF07S/60Jbmjl1mBPc6NcyMoszJjeBGkIHY/XmgRfik4J9J1zGurwh+7oiRsXx/Jru
 rimFyTm9oBXDoRVpZYH+rYawfSTKSoqywaJz+3vXjqxG9x9hxKHDaz4gaJt6+4552m/N
 smMChvbd9EuH0tesIIzdJlODzarKEjXsktSuw9GZ+b0FggC5IuBXZDQhlcjT26nviJ7m
 V8UOzyXwlVlkUHK4ldvOsnh4t7u5L0jOuNmPPST4YwmZALNAaCVUoKdJwTh8nBmz72UK
 6oC4PsoKWA+F/axPmA8ZJBesksALnwJEdNJ5Lhgf3rrkvWgvwCD24rY+yLPJ15nVafdE
 cEmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3lPQdKQyqo2LXE0NykM4STC3gzKFJMaydMYoR96FULisu7/VYXzs3r+I94rlzP+MmN/Wl7PcSh9Bu@nongnu.org
X-Gm-Message-State: AOJu0Ywt0MS8t9ZhLz1MFNcn1we+SXK/QzE+hcOcXr/cdBPeYrkqOOli
 +sfrN/aDA6vzWAoxFIGVDCQXP0IT6h71d7qIMgQwZhr4hT1LHCAPxaoLc8x4CvBb1mFnKiGyvyn
 9VcjeWPVk925w71ZNvCB0cJpmQTw=
X-Google-Smtp-Source: AGHT+IHZ6jDzckV6WsLjgwDzz3wWhFFp/2ESz7RrLuNpxz1yNXBhZR65HNnOKvUPtzOVrutgD0eyYOq+bEBkMosSM0c=
X-Received: by 2002:a05:6102:442a:b0:4a3:f4b3:d07e with SMTP id
 ada2fe7eead31-4a5d6a8dfc2mr8748537137.8.1729482316822; Sun, 20 Oct 2024
 20:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
 <2ef501ab-df75-418b-9c94-df47b9389723@redhat.com>
In-Reply-To: <2ef501ab-df75-418b-9c94-df47b9389723@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 13:44:50 +1000
Message-ID: <CAKmqyKOJ8NridjUwD60WBj4sWzPQbWBQuLPNQ+32NWpN_242Fg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] riscv: char: Avoid dropped charecters
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 atishp@rivosinc.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Thu, Oct 17, 2024 at 11:22=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 10/09/2024 06.54, Alistair Francis wrote:
> > This series fixes: https://gitlab.com/qemu-project/qemu/-/issues/2114
> >
> > This converts the RISC-V charecter device callers of qemu_chr_fe_write(=
)
> > to either use qemu_chr_fe_write_all() or to call qemu_chr_fe_write() as=
ync
> > and act on the return value.
> >
> > v4:
> >   - Drop the unused char_tx_time
> >   - Update the migration in vmstate_sifive_uart
> > v3:
> >   - Fixup spelling
> > v2:
> >   - Use Fifo8 for the Sifive UART instead of a custom FIFO
> >
> > Alistair Francis (2):
> >    hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
> >    hw/char: sifive_uart: Print uart characters async
>
>   Hi!
>
> What's the status of these patches? Are they good to go, or do they still
> need more work? (I'm asking because I'd like to convert
> tests/avocado/riscv_opensbi.py to the functional test framework, but it
> would be good to have the problem with the dropped characters fixed first=
)

I think they are good to go

Applied to riscv-to-apply.next

Alistair

>
>   Thanks,
>    Thomas
>

