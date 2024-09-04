Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4855CD37A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 00:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sldWw-0006Cf-AG; Tue, 03 Sep 2024 20:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldWi-00069s-Eg; Tue, 03 Sep 2024 20:05:37 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldWg-0003h6-KU; Tue, 03 Sep 2024 20:05:36 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4fce2c0707bso1705615e0c.2; 
 Tue, 03 Sep 2024 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725408331; x=1726013131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6D6h+E33ca8Vnp6Fonk4Os9QPHKHEISxdCxy/av7cY=;
 b=Q6OypOVkL3ROtXRAQuopLbn65q0xg8keffSShFvWwYrKOcjV0PqggoAP5+pRlPyUBe
 5QsNsNvyWYnrOtp5y7Opj9W7dT82lTwFVXaRD3sCkslCAwmO1wgRwe8wzrmUe2fZkCAw
 RjagC83SoS+K0UvKbUuP3shQbOrdv/guTJgSf2i8KW9T4kB5JcMxeR1eZ7WydPASrMUQ
 yaoPq+iSCGkD+C4i6lSp2dzWmBokPXbCCM0HPzFrCzg8JOG17MUfWnReKPoYnov026EB
 Hhovp25EO4PWPN2e2uesNNa93AlnndORQDP0pujTHfm+VIf7pQxOHsW8DajUyjTM8HBZ
 eGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725408331; x=1726013131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6D6h+E33ca8Vnp6Fonk4Os9QPHKHEISxdCxy/av7cY=;
 b=aP28BFwagaIrtEWOHm5RmCW72vs0lk8P0fbWfz/DHHajqj4uMFYy8Ru6hkt0mwziag
 U6HabYyviHKXAiyAEG/WiLmISQ0LS3qs8eUnRNyKXOOhXjS+ELJEhDpqSMC3rV+vVyBf
 Rx/UkuWYtX1Cm95R37ffI17cGcKyzC0g6aCMeIYmDz88/6gLYfJdUbyBI+7O2RLOG1P+
 yLjdkAtDV3y1hkeDv6Z7i1fEq79gLpw/ad7HNt+8Ljq7brCT+FtFHkbcX5ReUqgv7NJt
 pqD+CDA9A6Istq8LvgdKjd0uQJh1sVGXweIdEykKTMftgikM9UQ0IzmfzN8WqZmP4H7H
 dgaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFqTALieexqL86z/ixfjqLYspcNnNfk0vtm3NFYnK+dN2bX50zk5OWFr8IpN3Ui8CbxgDAYaWOforz@nongnu.org
X-Gm-Message-State: AOJu0YxUkOQVH+MM8orZWSh7WlOXtU3KvznizEtRq4tVl1BgLSLr3Veo
 Qsig4jmFzXkPD7bv94MUNLJOrjIV3hpEqz9hSZ60UD/utXRpCPciMGSB6YAwk5vCHeGMuAH1jAW
 da2BbZAOmAppMTLRVc9XQvYyuGsA=
X-Google-Smtp-Source: AGHT+IFMI+kF4kt6uFz15KCIfLoz1fhJ74VTfjik9r75sZ67Y8KGCe+S0fnguMRDbX+tPKloPzTKfVHhtKvGARxMdzM=
X-Received: by 2002:a05:6122:2902:b0:500:daf1:4b05 with SMTP id
 71dfb90a1353d-500daf16bc1mr4218092e0c.1.1725408330702; Tue, 03 Sep 2024
 17:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240903061757.1114957-1-fea.wang@sifive.com>
 <20240903061757.1114957-2-fea.wang@sifive.com>
In-Reply-To: <20240903061757.1114957-2-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Sep 2024 10:05:04 +1000
Message-ID: <CAKmqyKOvbsseR3Zx8kdyHKPM3raK0cb5-wzYJqEzJSPbGQ568g@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Add svukte extension capability variable
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Sep 3, 2024 at 4:15=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrote=
:
>
> Refer to the draft of svukte extension from:
> https://github.com/riscv/riscv-isa-manual/pull/1564

We won't be able to merge this while the spec is just a pull request.
We need a fixes spec that we can point out with a version

Alistair

>
> Svukte provides a means to make user-mode accesses to supervisor memory
> raise page faults in constant time, mitigating attacks that attempt to
> discover the supervisor software's address-space layout.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>  target/riscv/cpu_cfg.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 96fe26d4ea..636b12e1c2 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -81,6 +81,7 @@ struct RISCVCPUConfig {
>      bool ext_svinval;
>      bool ext_svnapot;
>      bool ext_svpbmt;
> +    bool ext_svukte;
>      bool ext_zdinx;
>      bool ext_zaamo;
>      bool ext_zacas;
> --
> 2.34.1
>
>

