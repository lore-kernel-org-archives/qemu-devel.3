Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6F6C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWgZ-0005SE-4M; Fri, 24 May 2024 11:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWgY-0005Q3-3N
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWgW-0004TK-Is
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716563899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4sZEKTbQEmk9hlt4iUDspneBB2M6C87My59pWDKM+c=;
 b=ElQ14nQYeXq3E1a+V4DhluRw3UnWFtmi2sndhBVXsEw8fnI1dkmb+zIRraeS006SWmnXS1
 iEg7gahcMIZa1eEuMcAHw66RBGvUCbqF5HTGFy5cVVeZikxFQ5J6rEYeBLTSYLxc0+jZus
 2Dwg/4rfOjWltpVCKo9CWue4IUJBgsg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-2efvgYijO_iI9skMfVk8cA-1; Fri, 24 May 2024 11:18:17 -0400
X-MC-Unique: 2efvgYijO_iI9skMfVk8cA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-355045ed552so228638f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716563896; x=1717168696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4sZEKTbQEmk9hlt4iUDspneBB2M6C87My59pWDKM+c=;
 b=Yqmcn6p6uDRDody92rhsChjLf97XT9oJbMGjWgeoypmSRCbzwin5EOwbVQdt0b75rz
 jBfF+G5pB8g9fWCOPEznzIJwJmtPSNYQXKnSdaBjU5LzM9tZ9f/N5gaHGokgSL5nXweB
 T3MTY4dkkEBH2X+q+Iodyzr1ZPgGZg+6QPr1ZkxAyMvnYLt+l4DK3Mn1cqpG+6yFhPqk
 olasPb9eG8NJQ5n9+q/5TSJUhenikWBI7L8eXsShQb1/Xre1bFYc8r4e6xs+NLX1NW9L
 1QVnVjcsl/T65uwaSm1WPATFEcwLdqhYxSjIWX0fD5KOknvo/3yMXjgtPTZIIYfHJCon
 D5XQ==
X-Gm-Message-State: AOJu0Yyxn6TbTacrna6BkxbMEhVAhEXpjO08vRWT+3zlHLmqi5SRV7zl
 g6eC4qkV02BybFg7wq4ZxpOB9Rb12NDu0WIO6ZhGGmT8fsHcBV/BDizypF3CEDNPRFQS9aocMW3
 Owd9yI/x+axCcicQ4VYABtnsTbR6p/vm78JX7E2uYTRHKagCSKU+mVaKyCDaZ1smLKCL8utb5ED
 dLpNMKga6SfIOU356BJa1z0/1mIe0=
X-Received: by 2002:a5d:5452:0:b0:354:eb32:6d1a with SMTP id
 ffacd0b85a97d-3552fe020c4mr1426288f8f.59.1716563896694; 
 Fri, 24 May 2024 08:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHji8VtT6o4KYbRnlc9zewIEYlLIx1tz1JF6lhxhVkT1mWPZxvB1PLHn8vIeUMCUwth0/7EMVpmcqtE7r0ZUM=
X-Received: by 2002:a5d:5452:0:b0:354:eb32:6d1a with SMTP id
 ffacd0b85a97d-3552fe020c4mr1426275f8f.59.1716563896282; Fri, 24 May 2024
 08:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-4-pbonzini@redhat.com>
 <a11a973a-bd0f-4f46-ae39-4dc1d7a65615@linaro.org>
 <CABgObfbXNZKwxxeCC+6OUt2fie92TGUzhcRAxGsO3QxaLM-1bg@mail.gmail.com>
 <CABgObfb04iUXNK+0OQMQUFkj58m5cALuuxe+kGfTaCZqxN3C5g@mail.gmail.com>
 <1ccb076b-156a-426f-ba4d-567a31798c19@linaro.org>
In-Reply-To: <1ccb076b-156a-426f-ba4d-567a31798c19@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 May 2024 17:18:04 +0200
Message-ID: <CABgObfZ3SDNtSvEAh0qzLNQuaqsQntA0oAXRUg=LJtq2=7WGMg@mail.gmail.com>
Subject: Re: [PATCH 03/16] target/i386: document and group DISAS_* constants
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 24, 2024 at 5:13=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/24/24 08:04, Paolo Bonzini wrote:
> > ... and nope, it's the other way round - DISAS_NORETURN is a bug
> > waiting to happen for x86 translation because it doesn't process any
> > of HF_INHIBIT_IRQ_MASK, HF_RF_MASK or HF_TF_MASK.
>
> Do you need to suppress use_goto_tb in these cases?

HF_INHIBIT_IRQ_MASK and HF_TF_MASK already do, HF_RF_MASK is missing.
Nice catch.

Paolo


