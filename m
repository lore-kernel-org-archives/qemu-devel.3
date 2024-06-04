Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06886C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEI24-00078e-Tt; Mon, 03 Jun 2024 20:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI23-00075l-Bu; Mon, 03 Jun 2024 20:28:07 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI21-0003Aj-Qf; Mon, 03 Jun 2024 20:28:07 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-80accea5cc8so1390077241.3; 
 Mon, 03 Jun 2024 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717460884; x=1718065684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIee9Zpm0WduGDuUj4ya42FmpUJp9MBHNsqkH1fdyQM=;
 b=UBZU3/AQ+iNQcHe9s2TtRFi6bBDqrjuwh+8wd+wUUGz28ZJ38Z5fxoNFL6VtvmOUk7
 7MqMWEIOHsu5jbNnFmgNOLItCI9754k/q+JKg+mshSecg/8HKq660+twqyOZJ0KFQK9y
 suBpviTfTqJ1uHoWqphanMuVRVsOEkqdiB7ZVyVrpAylwE5hEWC88IzpgfdtOstG06lV
 l/TAaDDsxNxo1StyGq4s6BSE6Qmaw5Sk5YNuWc/JyGCp+l6ZtVueBQnm8nL+NB1ub9oF
 m91W4aNbkMm3jkQ78U6REjPukPnDwMa8SNr73Qx7oZo1e8WqdchWpaQyMCH2u1QW1Nj6
 erDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460884; x=1718065684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIee9Zpm0WduGDuUj4ya42FmpUJp9MBHNsqkH1fdyQM=;
 b=LJZhVxZoI080ajkC6fFWvBftCoWzTihWottXxczz3jsfAPbbqe8HIabRNLkVtYF4Rv
 t1qKNg6+H+9nTPKJuyimXrbK7ZcN+x8oyeK3uDObW9f6trAVsBEICJ07xe3t7L4jcwnQ
 itV44D+z3w83o3/n6MZWt41FkMceg/lr9BGbCy9Uemj5Zbtf8SDgzAsfKVyjrnicdDIA
 BkuonHbJZP4om10C37fNri2z/wwGy2Ck+wx8/vlJZdKaRSI9qosg9XeTCkZL3WQ8MlTF
 end+fbopmKHmhoF29pNNVT/DaJwz1fH+KT/MK6WK/PX9SzINFqA/oZTzNdhXg+pzRl2d
 S2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu95dsgzhQAOCuR+lv2BblbXtf8NaqBbiZmBvXc83kszJID7r6eKmC9wqEbt3c4PI92Kb0ceB88I3dJE7YeukAA+REWFY=
X-Gm-Message-State: AOJu0YyGCYEVX4wjkF9TokP6M/R4qyLpVAaA5I9U1E7vBC20pEQLm/XZ
 SlVL/dJwDo46I19GVTM4VCt4JFHV3XJe+eNM4FgTxugR8cksm51KJEEkHNU6QrS6rqa11RH2i6a
 x1xfRV+ezksjpoqErLcU12DEGlUE=
X-Google-Smtp-Source: AGHT+IEhAGIN4ZEafPSMVombCZ5L91+0kOtV+saYeJrvcxF2UCDUu9OIbu+bNCwAsNFqIYTvV7/UnYjAPbD7HZT0op4=
X-Received: by 2002:a05:6102:470c:b0:48b:bc62:b142 with SMTP id
 ada2fe7eead31-48bc22e24a9mr11734240137.27.1717460883964; Mon, 03 Jun 2024
 17:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240227012405.71650-1-alvinga@andestech.com>
 <20240227012405.71650-5-alvinga@andestech.com>
In-Reply-To: <20240227012405.71650-5-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:27:38 +1000
Message-ID: <CAKmqyKM2N21UMsRDhLMfRu36RfJzOtAw25+eEhu4tXXtmqSMqQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] target/riscv: Apply modularized matching
 conditions for icount trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Tue, Feb 27, 2024 at 11:25=E2=80=AFAM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> We have implemented trigger_common_match(), which checks if the enabled
> privilege levels of the trigger match CPU's current privilege level. We
> can invoke trigger_common_match() to check the privilege levels of the
> type 3 triggers.
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 9f9f332019..eb45e2c147 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -624,7 +624,7 @@ void helper_itrigger_match(CPURISCVState *env)
>          if (get_trigger_type(env, i) !=3D TRIGGER_TYPE_INST_CNT) {
>              continue;
>          }
> -        if (check_itrigger_priv(env, i)) {
> +        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
>              continue;
>          }
>          count =3D itrigger_get_count(env, i);
> --
> 2.34.1
>
>

