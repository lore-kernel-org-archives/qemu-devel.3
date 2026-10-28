Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36079606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=M2j9KT1j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxzo-0004tP-1F; Wed, 28 Oct 2026 03:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxzb-0004s9-CP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:22:39 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxzW-000297-SD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:22:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so1039502a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793172153; x=1793776953; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t29zqf7Jc2ovp8HZqV95KX9OteK2WU3BlLCnMPHXXaA=;
 b=M2j9KT1ju1VcHqpz1AmGYkhzRasLLGGx8M0QiwVrTqpKGbQSFUq4KXVOm+gzJHQGxH
 D1ViJOxtHMmk03DVb3eIjP3CFEEOsZ1HKXON59cIn8vLY463MndPIwUjhk1Rrd9k/sDJ
 ERG6FqJQDOC+AugxW5QclgAXSEwJJceKN4mUvgm+7rYlSWrCxTSSo5R5yxezmTl9txts
 y5qZasbYGiuHJ2XN2v51x/fsSjGyDWlzPew/oKXtao3tevabxmaaKViZ7byHuOndAAQs
 MhMAvXjY/d6k7RPWrLDaixV1wJIynoS1xSt3w9v/zLW43pNZct3EhbtDpbZpZMD+YyB9
 SP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172153; x=1793776953;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t29zqf7Jc2ovp8HZqV95KX9OteK2WU3BlLCnMPHXXaA=;
 b=PiqKs0rhGvIfaYQOZ3SUlVVyme+e8MjuPLHgCj/uApfE4cM/OjP3yz8/KgG/BwFahs
 nAjZ7Y7NEXadfHdeVdHtUQWydRFyXTSVtPcwccukPsoD9g7TxdNhBr0V5r+3BhGlXJ6O
 KQwTpJPwWw9PDkyc2hnj0SQZ7N3xrsNinBll032JsGqkCU7EkANkAHhuH2x2YXrvFANM
 OveWdK8WDlY/CYyRvlWk8yDdurSJigMDo6VRqQYzziEHx6uKLjn+P/1SMP4onB07AbLt
 zuO7b5DmD9vsNo/APE4d4doZcCnTFTmfT3/cy6LPoVLifVUCkXSX4TqiQBnmCqCGe7nT
 b38g==
X-Gm-Message-State: AFq9FYIdFqUBeA9NkfE1qWXKbQjER9UenXr3wAlSsDv8bTheAdW4fGyZ
 MC9pXb+FL4lut4ikKeRw06cnaYouupcPFjElfPcZJ/u8F3tYFHA+/QliqxWmKV8eoGvjSNAimDN
 52mBTGPxdrnLOLiaXJSYqfzIk9vkrJBkeRxuUgQEUCxpJ2xOV8gxwT5GoA5lgy1b0pucgjDiG97
 RAHI/FIDTH2hnMIOXmTPedBRyY5EkqB1BpJLAiuYhkpxg=
X-Gm-Gg: AYBFou10EDUgtmBoRmxGcXy7XzDa/Zt38XK0TnGBsW8uUeZvHx1RxD2oNU95EFbB0m1
 C+5TrhB1mi2TWuwMm9OzMC8oUN3g8iDzOtW/fvDs7E/GftSFn3s06k9innsigTlgohIUk5PHA6d
 3P1OFBrf/TOo5lv3+7SWNlt6aBDyB5n1kx6hkFIgFnHL+pX4kU/V9dVU655GxnmrOv8c63JAnBF
 p6cde+QpiS5eyq/zqd4Xe+CQ477P1jwvrizyXdwX75AqjUu0i5cTobqu6tanrbd/i8wtez8KJZT
 b/vFy9prWY41VPsWMuG6VVsHfvPv3ZlvYG4ixkRbaL8yFgMfpTPRp6fFpOUsdsldv4Qp8g5jUsR
 lbR8TxaGaF0rMJ5McGYfh0OLG3s2Uh3UzHu6FuMCBlzX8EYWZpjE+0SAl9WoDWtky3fw3t0E7lE
 5nlqzMXXUsZPi5MkllvJP8XtJYf6axf36Ve+j/jKnF7Id2V2huYkfXgXRG1x+er27oFEdhU3h0p
 Y//+8BgdIVanE99moQKotpSSl+s/JxcjwdfGYucXovKvWLMpcBxN5LPK5KhsL82X39ngQSHY2Go
 tpkr3Gv0ZO1qQIxj+RVHASUQ9S259CUmErtrLNECXy/Ba7nA/mbasOgQzCJTPE3/s6o=
X-Received: by 2002:a05:6402:1bc1:b0:6b4:2827:b920 with SMTP id
 4fb4d7f45d1cf-6b49cbd7a60mr531610a12.11.1793172153050; 
 Wed, 28 Oct 2026 00:22:33 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com.
 [209.85.218.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b496435d40sm1052894a12.27.2026.10.28.00.22.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 00:22:30 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c4550d8ab15so76943166b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:22:30 -0700 (PDT)
X-Received: by 2002:a17:906:c113:b0:c27:420b:7c79 with SMTP id
 a640c23a62f3a-c49bdf89528mr119252966b.48.1793172150157; Wed, 28 Oct 2026
 00:22:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-18-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-18-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 15:22:18 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZfGk6LikBdYFHiUe58LLv71Btejuh0O+tWTqqDJ_cP-A@mail.gmail.com>
X-Gm-Features: AclHuK_GLrUiT5aSPwvTS2esdG5Oq-sMOBXCtquK3zgvkyKKbRhZGHG2njXrLcA
Message-ID: <CAMXXpfZfGk6LikBdYFHiUe58LLv71Btejuh0O+tWTqqDJ_cP-A@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] hw/riscv/trace: update branch bit in sync
 messages
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000080845065ee16d66"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x52c.google.com
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

--000000000000080845065ee16d66
Content-Type: text/plain; charset="UTF-8"

>
>  size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
> -                                      TracePrivLevel priv_level)
> +                                      TracePrivLevel priv_level,
> +                                      bool pc_is_branch)
>  {
>      RVTraceSyncPayload payload = {.format = 0b11,
>                                    .subformat = 0b00,
> -                                  .branch = 1,
> +                                  .branch = pc_is_branch,

Spec says that
"Set to 0 if the address points to a branch instruction, and the branch was
taken. Set to 1 if the instruction is
not a branch or if the branch is not taken."

Thanks
Jay Chang

--000000000000080845065ee16d66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFp
bmVyIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+wqBzaXplX3QgcnZfZXRyYWNlX2dlbl9lbmNvZGVkX3N5bmNfbXNnKHVpbnQ4
X3QgKmJ1ZiwgdWludDY0X3QgcGMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRyYWNlUHJpdkxldmVsIHByaXZfbGV2ZWwpPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFRyYWNlUHJpdkxldmVsIHByaXZfbGV2ZWwsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJvb2wgcGNfaXNfYnJhbmNoKTxi
cj4NCsKgezxicj4NCsKgIMKgIMKgUlZUcmFjZVN5bmNQYXlsb2FkIHBheWxvYWQgPSB7LmZvcm1h
dCA9IDBiMTEsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAuc3ViZm9ybWF0ID0gMGIwMCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmJyYW5jaCA9IDEsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5icmFuY2ggPSBwY19p
c19icmFuY2gsPC9ibG9ja3F1b3RlPjxkaXY+U3BlYyBzYXlzIHRoYXQ8L2Rpdj48ZGl2PiZxdW90
O1NldCB0byAwIGlmIHRoZSBhZGRyZXNzIHBvaW50cyB0byBhIGJyYW5jaCBpbnN0cnVjdGlvbiwg
YW5kIHRoZSBicmFuY2ggd2FzIHRha2VuLiBTZXQgdG8gMSBpZiB0aGUgaW5zdHJ1Y3Rpb24gaXM8
YnI+bm90IGEgYnJhbmNoIG9yIGlmIHRoZSBicmFuY2ggaXMgbm90IHRha2VuLiZxdW90Ozxicj48
YnI+VGhhbmtzPGJyPkpheSBDaGFuZzwvZGl2PjwvZGl2PjwvZGl2Pg0K
--000000000000080845065ee16d66--

