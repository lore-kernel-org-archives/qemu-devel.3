Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC6D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 03:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5zY6-0004gN-SB; Tue, 29 Oct 2024 23:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5zY4-0004fr-Tq; Tue, 29 Oct 2024 23:39:08 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5zY3-0003U1-J2; Tue, 29 Oct 2024 23:39:08 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-50d4797098dso1993920e0c.3; 
 Tue, 29 Oct 2024 20:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730259546; x=1730864346; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/lV+XwUWAMJSFFLGFaLaELYuAfJgk45jt5oIh0XI7s=;
 b=TYJzXK3fcX1WR7Y4JRsrHuhZB+vj/fbKDmK1H2gn+qKDl55btlZNCcF5Qe2BjDL4ds
 iV7crN1B9Hm8Bk689TOKlXDJ8xMQO/AaDX0I4U4LF2yifp90hqiuq5CwTbhUPphRnJns
 oY68dq/nph0voNSbTcykKAiR46Ha1i4Ak/yHsxMV3H9dACwkZJ34Tot+Q4L2OoEzTeH0
 6L8meA3O6hzyv/5+iwcsbddkH0aR798EhrVgqhvaSD3pULxAMvXFVD/6D18CKPqXK+gu
 eAQ+crvWdeeE+WuXBRxLT+m0e1TLlsYODTc/c6TN1ZEthigddO+i1EjIbmVvkfjPw0t9
 sPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730259546; x=1730864346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/lV+XwUWAMJSFFLGFaLaELYuAfJgk45jt5oIh0XI7s=;
 b=Ol2Dw0hcpq2U2ck5UJHHM7axCyQyw0UDXbTvLISRBHfC4nSeFqqrQmx2ar7xN5BONC
 C9tj5ozg9+pZwl6kpjQZkskKjS22jXekoMINsMHSD5Qf7cO6tjsRcoWuAEQ1UCtP4qd6
 0UvEzl+7f0qQMX5qiDWvbGTL6TFVuNcz1zhuas8IjJ+vuc+wW55DTQaOlInukKbYhNZR
 Eq7Y+SGXpx0+KecyaSJHz8ekjsQXdZMjKzP1w9vHySC8PD918vlMEFuXZg/ap+heePOR
 dRYJfLCpaZhplqhQowaH+QEEr+QxO9Ry+96mSrA4aOsxakqigUMOM9JCAM++bR6qH8MK
 Zz9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVXTq5wAkD4taUkbU1eqNJ4/5rheZ91ceSrrFseqEpsqtxGqsT9QYcOtGsva0kBkMBk7uWfHged7U@nongnu.org
X-Gm-Message-State: AOJu0YywRaLAHQEyD22nUPvQYB+TmPBbSRR9FArUrRlVZ6Inx6y5POBx
 yix563Ld2iEb/znRpx324i46bJmSzoaqi8v79F+jNsqglI1wxsZziF87ZAwklELmWedvn9rH2Z8
 yMs4cecOtdTipeIKin2qk+W+9j14=
X-Google-Smtp-Source: AGHT+IEvloXoEHO0S4QFLeAVtsh1d3lWOd8ndf15CUyRoVRI5T0tmC3Jitmy4GsHtuAwk/RvIdDGv98qqdC1d9h7tC0=
X-Received: by 2002:a05:6122:78f:b0:50c:e37a:97e3 with SMTP id
 71dfb90a1353d-510153410b0mr12761651e0c.11.1730259544805; Tue, 29 Oct 2024
 20:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241030004146.935656-1-antonb@tenstorrent.com>
In-Reply-To: <20241030004146.935656-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 13:38:38 +1000
Message-ID: <CAKmqyKMJ0Lu7Jvh2KM7yGjq00uHnAmav9sV7cmWnzrkchQR2xQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix vcompress with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Wed, Oct 30, 2024 at 11:13=E2=80=AFAM Anton Blanchard <antonb@tenstorren=
t.com> wrote:
>
> vcompress packs vl or less fields into vd, so the tail starts after the
> last packed field.

Is that right?

It's different from every other vector command. Although the wording
in the spec is very confusing

Alistair

