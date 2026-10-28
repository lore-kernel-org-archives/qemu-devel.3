Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B214606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=UGzzmGMP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLwP6-0007ms-5y; Wed, 28 Oct 2026 01:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLwP3-0007mD-US
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:40:49 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLwP1-0007iR-Te
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:40:49 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso80578766b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793166046; x=1793770846; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KPA9q31D7UkjqcHAwkHe6GQHFQdyeJwK78n0ENxvic8=;
 b=UGzzmGMPmWHmmg9RuEyXONFYKvfAs+8aP3mWd2wSG15zFlKO9dwsVlLdimM8Y9EDDV
 Y/sWDqz8ZlEXdqyv789D1OLvKXlUtj0DJilOzi7BBhKHW8z7+MhdmTEsLKyLf+8veRbj
 LxW4+pqVb4J0mtdIM4BF/qJu7fSGj9CoWRWszPPKp3ayYvWVDfZ7hp6h/SrSGpm40hQ8
 scmvJeLRduWGg4u5ZqDRtvF+jHv8wDC6kZhBeaAEjp3h3bwtsrWhUdNGR64FlavzPgzy
 dVGII66Hx5j20G4qpcXNQgKkmpx2ta74BRYbuJLY0nM23xOSgm8msMYfBC+O7xLz/htz
 c5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166046; x=1793770846;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KPA9q31D7UkjqcHAwkHe6GQHFQdyeJwK78n0ENxvic8=;
 b=DqnFFjUNJDnFPyQ0PXt0wQ4IpnAWTW1X8MqFcdIYvnvfv7UuMPIx/jyqBuxioOglOa
 zlLbcN6YclqLmPnLFoPrAzu4Zdf7GbaETUKxWVc/j2W8sy85sXVZWZ+/8O4XwEGuEYAu
 l4HchA3PYu07mUCWlHzb6uWaxX5CztH8aXkSD3H6JCuNAcwYdkqPlMJbALYWofpjAPR0
 6LF5xCD3dIS0pdEFss6XiGxBeOEh2SgCctgtlSJNZUA7RaSsunazdqska7bHIfbCi1ZI
 cz2+Q/z5uHPczt8DzfwNFEYEcq/CTW7zUJLEvlVKEon+GKeaFoKmTPlhV85MUJvWD2Kv
 5tPA==
X-Gm-Message-State: AFq9FYJBkMKzbrBQwRY4eTU2udN/e/i6s41HkACsNoTrVuHpokiC4AfH
 W0J5LNXSfvLqwXlJl1dy+Z9Eettw9gzqPGOqlWznDYDiPepKunpa3YWnRFVqij1sSwmxs5auBaM
 gZFplTdUH8Y+DborBhwrrPTLKqkjkUKsf1/rYnnNRbHRFNihL212oL06QIPFUGJNRQ7ja0bo0ts
 vQS0JkcGlWQ/347NCgblIwnW/AaXtXyLXSr5NF8B2h21k=
X-Gm-Gg: AYBFou3LDB5al4gZ8saeNXDk59hLtG3PlubKvuFB1Rw/blWyrh/fIe/GOZ9oGy4CS2a
 goRHElKMDCHCPjpm7Nahe37CYo9Wyrda3pq9/Qo8/jNFP1N7q4HDlX7YWw8B9cbP9YArx3kQ823
 f/Eg9YUBdonSkxAGapm3XyFT8dzp2GmZlmamOJhpWV7Sbdw4bQIUtNfViwg6918HdxOy2m9S0Uy
 Yw5vBtD22B4B42LLhs9uJFxuB2mEm0L2lNpjuoYXSmZxnVv9kvwmgfmHs7dZ9RJAfrmoYhlANzP
 kHfaA56MCd2WstE9+VpUXtR2HWt4T8/syH44hBbHrul8ExWXlRRstUU6PsT+KjpJuOXmJnk357/
 AhWGHtX9TOxwp9e0k4OYy/g8ZlL6sfhubxQl4VtIWlP8DC8njvhShpo4NI272R/cJc75UxsPijW
 acgzkKZujmt7jlvfILbr58asDVyTavoKg2eEzNuj3Wm7IYkFLldsNWLoCFDjO3urDGFd8nJUGtp
 rXojsrJsXOXRVnx7BO4i4wehJAvqQmxYbAZnrSNoOh0Q9v+HEi+jfaDZcbiIV2oW3ALh0eDPDCg
 wyOK3kQZ3ur9JFLo3qMk4aVfnRSpUMplf/lql2e5vRXgtXxZeqBxrVtT4kKPvZ6FiQ4=
X-Received: by 2002:a17:907:a893:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c49bdf394e6mr104961866b.17.1793166046014; 
 Tue, 27 Oct 2026 22:40:46 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350706sm566986466b.3.2026.10.27.22.40.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:40:44 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so1049695a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 22:40:43 -0700 (PDT)
X-Received: by 2002:a05:6402:6cf:b0:6b4:35af:3264 with SMTP id
 4fb4d7f45d1cf-6b49cc1649emr493263a12.38.1793166042821; Tue, 27 Oct 2026
 22:40:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-14-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-14-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 13:40:31 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZ=boFJCfv-xFmQBW6yvyH+yUOze64NiOOY0n=6cCDT=A@mail.gmail.com>
X-Gm-Features: AclHuK-bveYOpSJSxQxMYWxD_z3F6AccK-rf-BN-LnyhnzSHBOuCbRGcWLexR5k
Message-ID: <CAMXXpfZ=boFJCfv-xFmQBW6yvyH+yUOze64NiOOY0n=6cCDT=A@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] hw/riscv/trace: add format2 msg helper
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="00000000000001793a065ee0018c"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000001793a065ee0018c
Content-Type: text/plain; charset="UTF-8"

> +size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
> +                                         bool notify, bool updiscon)
> +{
> +    RVTraceFormat2Payload payload = {.format = 0b11,
> +                                     .notify = notify,
> +                                     .updiscon = updiscon};
> +    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
> +                                   .length = FORMAT2_PAYLOAD_SIZE_64BITS};
>

Shouldn't the format field be 0b10 for Format 2

--00000000000001793a065ee0018c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIGdtYWlsX3F1b3RlX2NvbnRhaW5lciI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xp
ZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPitzaXplX3QgcnZfZXRyYWNlX2dl
bl9lbmNvZGVkX2Zvcm1hdDJfbXNnKHVpbnQ4X3QgKmJ1ZiwgdWludDY0X3QgYWRkciw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBib29sIG5vdGlmeSwgYm9vbCB1cGRpc2Nvbik8YnI+DQorezxicj4NCivCoCDCoCBSVlRy
YWNlRm9ybWF0MlBheWxvYWQgcGF5bG9hZCA9IHsuZm9ybWF0ID0gMGIxMSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubm90aWZ5
ID0gbm90aWZ5LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoC51cGRpc2NvbiA9IHVwZGlzY29ufTs8YnI+DQorwqAgwqAgUlZUcmFj
ZU1lc3NhZ2VIZWFkZXIgaGVhZGVyID0gey5mbG93ID0gMCwgLmV4dGVuZCA9IDAsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmxlbmd0
aCA9IEZPUk1BVDJfUEFZTE9BRF9TSVpFXzY0QklUU307PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlNob3VsZG4mIzM5O3QgdGhlIDxjb2RlIGNsYXNzPSJnbWFpbC1wOGk2ajBm
Ij5mb3JtYXQ8L2NvZGU+IGZpZWxkIGJlIDxjb2RlIGNsYXNzPSJnbWFpbC1wOGk2ajBmIj4wYjEw
PC9jb2RlPiBmb3IgRm9ybWF0IDI8L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--00000000000001793a065ee0018c--

