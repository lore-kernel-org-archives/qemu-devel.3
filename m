Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7F606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a7mM3GO1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGxF-0002tC-Qb; Tue, 03 Nov 2026 11:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOGx1-0002s7-74
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:01:38 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOGwx-0006rQ-Dr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:01:30 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ac9d666d4eso40074817b3.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 08:01:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793721685; cv=none;
 d=google.com; s=arc-20260327;
 b=I2eo0emhPkyayf2ry4UawEE+XWS3Ib0+vycERL+7iNpqJngveDzMTvzJl6MIhs906X
 8npJxCgVR9HXO6Dwrfq9P+/wcOJI+wH1Va1WAuhB1ozLGVgG9dxPuFunbQ2DnsE7QAdP
 FBn5ljqW+2MdZB4TXh3DMYtr1bGEN0GyIJ7jmfXZD5atSh07ObvU5NPk/G8hVd6BidND
 nRoqK2ff52zp9cba0D4y1M6qoB8UzFDUU7CESj9q+BXwkYtfMw7yFtNaj8NRoXgQ1UPn
 dW2JlNh0IyjKCZkyDodlQvfmaEN514fE2SaCoc5RZk0SbGTUmkGVN9PBX4U/Mxk8KBow
 uBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JBjJfK6MbAsnUPPYcGQw7MJ6zbZ6I+gqahmiT1tLixg=;
 fh=AV8co0yQDJskNimnzYB6tDsqA0t7GoQSciVgpxgRhss=;
 b=cuvfIDpV+MXDvxNSuKbStL9PhNySMqdLJfWyw5zT40hEToUxbJwqeWP1QFZhSzwfuN
 pcOFOLEVSbuM+XJO2BTkfaSBziJ6HWvMAWAWG4yP5QNSVCCVbuPPx+i1gQSxzuDdwsds
 n5gaTvIpkcQxj9zADMVrujqHr/9zqzAQXtkavH2vsuziK4hkTqnYHEBDMnVtJWUxuXH4
 uemEtlXocsyOTZ2Wp+2DnxLi4rWExTV1U3+ZRvfmGOxfcQfGFd5tLFNB2EjpuOcgkjOO
 l4azIDT1lM2mMSPmT7eYBaorAx5dgvRAKP3pON/rE8Io8n0PpxCcBRD0136r+AcVY6Ax
 99vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793721685; x=1794326485; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JBjJfK6MbAsnUPPYcGQw7MJ6zbZ6I+gqahmiT1tLixg=;
 b=a7mM3GO16ufregf0WLu/kJbEjtiEsoev5M0g8ySWgvjS5QApcZAM/gks9KG973N/eD
 iKrrg52R+fbLwvfq/9dd+UHOGDjhnkpMXeqO0d14QAvpt2hhmkY/oB66aSKZBnBXsU3k
 34a+lZVLN6bcEclR09GJrvfonQzbYS5NiXP+6oOsk8F/MElqH2ezEQySuxgNw+6mNdfF
 lPXGF2miugboTMne1sqdqGOaQrdM/HlmyyZ3EuHrMqo+ADVstAUNUtb8pPrl32DXlVdr
 Sd1bxM1h6SRvW6hy0+ICsan6YBICbaNZleDzUnyW25XRvOdhem75O01iuZxk0USrcsvH
 Eocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721685; x=1794326485;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JBjJfK6MbAsnUPPYcGQw7MJ6zbZ6I+gqahmiT1tLixg=;
 b=Al+FWf75xGi0iMs79JH6Wstyj9/QIyXpxNNhBfAz0KZusiltRzRbilVxZod+JYISzQ
 BvS+7UyJNVIiUCiiOxlxkvAoTW5VO3iuhRfkKyLdliKZbtSlHrejKK79UiDDREsIwoOJ
 ZKVJwazHWbbWV5saUn1qEQe8eKzRSaZ1TcvWwSfxc+xs8JKuIGMcHKxdmwwIjyBAv+Sk
 jL8wXGYl5nYg0AR2WdysXnmKxc7w7O3NqwfXtuOUxZksesGOtmkB3rtVXqjAYkRyVMdh
 1cQU5DH657WYofB6S+R0DEwQ1HhfmUSWubkOuL1IOAG2nqfIkDezOVei99Gd6mqqtGqa
 QtfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTbMj9xOsiR+v2BBkcABY1t4sQXAFaq8HUeEgEyt/z+Fq5TxJwolRPh8Va7cBgy8Cs/bccUl82oDPT@nongnu.org
X-Gm-Message-State: APuU4Z9EQVrB+xE4UNmNMb2LQGJ5QcamdJ9hVoiMdUVt6pu63EsKuoWW
 P/41mMTA4pKq6in+seStqaJE8ZfjWCmwkALqxyqvckT5qedASDDeAvs4uRxfEjJhFbSekboLEcH
 aZJpAaRkd1vbvFzGwiQYYm4lSSXilPRuIt9hSaEuGsqBkOB4wG5ur28s=
X-Gm-Gg: AYBFou0+t6eOroaZFY3WEtZ34ByeNcoq38s10u/0+B31QmvA6B2S3AsdmpsBWI+hlrV
 pKqFQ6DfPg0muIAXVzpTbxVfQF/6JFKn4VFPHzYF+w1la1pDdnQLVwPswSdd958Zq+ix7MEowMf
 F6Rc1lHlh7Vbao2TYZ6Qs4RQNW1dq+ffsikn1GIDQ3OCxfwTRVnz01eV/zDhXRgs3h/YBaO4M3M
 6naCr3uR+yjXjJ0n7UPkkbphLvpc8XsWshZhDP5hfTzjlVJisL2Gggz5qHTpgKDkesFHCgugH+d
 R6Tm9w1+vStcn4DJUYPagABmscJA7nxDVc0iA3sQsEo/z+GLCzWPT5SiGJ8p7X9xWuzrw6fpbDj
 XmMpZKCKWstX5WmV8lKjo8jUkRTTaeG1K/uUu8GS4yycrhwOOfHkq8uFN/1aTmjXeafoWstJaFa
 431OJCLJhbzyc2MST4wsUm
X-Received: by 2002:a05:690c:7483:b0:8b2:bb94:8cc4 with SMTP id
 00721157ae682-8b2bb949029mr93061057b3.97.1793721684808; Tue, 03 Nov 2026
 08:01:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103155018.1454989-1-mark.caveayland@nutanix.com>
In-Reply-To: <20261103155018.1454989-1-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 16:01:13 +0000
X-Gm-Features: AclHuK8puEX4msdzc70XJSfXXdKUYXvOvyvSzbtfg4WKeUVIE03hIcpLevtxaQg
Message-ID: <CAFEAcA9VrYZ7rRw7uq7AissZP5CW2CufDd9Nnbj7e5RnntD_Zw@mail.gmail.com>
Subject: Re: [PATCH] i8259.c: don't leak I8259_PIC output IRQ
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 15:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Commit 54fbbb30d44e ("i8259.c: introduce TYPE_I8259_PIC device") introduced a
> separate output IRQ for a PIC representing a cascaded i8259 configuration, but
> failed to free it afterwards. Use qemu_init_irq_child() so that the IRQ is
> automatically freed when the PIC device is finalized.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 54fbbb30d44e ("i8259.c: introduce TYPE_I8259_PIC device")
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index 79b5e603bc..6c784ef2a4 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -491,7 +491,8 @@ static void i8259_pic_init(Object *obj)
>      object_initialize_child(obj, "primary", &s->i8259[0], TYPE_I8259);
>      object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_I8259);
>
> -    qemu_init_irq(&s->i8259_primary_out_irq, i8259_primary_out_irq, s, 1);
> +    qemu_init_irq_child(obj, "output-irq", &s->i8259_primary_out_irq,
> +                        i8259_primary_out_irq, s, 1);
>
>      qdev_init_gpio_in(DEVICE(obj), i8259_pic_set_irq, ISA_NUM_IRQS);
>      qdev_init_gpio_out(DEVICE(obj), &s->pic_out_irq, 1);
> --
> 2.43.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

