Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B426606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=W9jygdQS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxco-0007sz-E1; Wed, 28 Oct 2026 02:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxcm-0007sa-4F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:59:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxck-0007qv-4F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:59:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c468bd799ecso73010066b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793170740; x=1793775540; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TUL41p1sRr04sthV9etnejH/dU+ulBNsksLF0BLrBjY=;
 b=W9jygdQS0mqK6bAHHw6pMTF8j/z/fv8D1Gd4yWBdkPog+6hfTfQpYwei68YyKls3L1
 y6T3y7bewaFec/IjY01oELRq9yZwv6m52KIml+nzjjh6R3y/dajiM98Q8Jfh3wgeMFLG
 1UqAZ4BBsWKGvblA3uJ25fbJQQ07xaACw1PheUgDkF5HhklQfM7doI0LKVoT3gufUu+c
 cuR7hrRnMPKiWa4LsYRCut+aJEfYJX1sTZn320hH7MbtT5EBlTpu826z34e298d4P4oi
 xlt3+T6eAgHSGLrk5+NAat3P6/JWrKgAEvikavPprv0xOylbpU0FO27ib4NbuoflOLf7
 xdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793170740; x=1793775540;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TUL41p1sRr04sthV9etnejH/dU+ulBNsksLF0BLrBjY=;
 b=PCiNThlHslVjFDdeLh5qTqap+tVuB7zw9bTCo81Tc+UG52a37inXdbCbPnXt/vu5JD
 Xr7plwXF/WwNPzB9c/V+x6ZeOQrnMvOjhq+hThWpATs0cbjHqSNTA3t7vS50LTDEQ7Io
 nZO5IUv7wx/0shDtdkTmdH+buhEen7TgdEE4So+3oCopOguVGoW2+bn/wJ5F7Z6PJc4y
 M9i9D/aXZ/8b+Z7/Y0zN324CpjGbOzzPK1JPVCa3nDlMqmEoGxizLCTvl2e2esq384o1
 lWjYO7GYYumaE6HJ5o4oST9BUqfUMlgficTKV7ylyoY6m2r8uUX61BpzQu4ogstsRgLL
 QBWA==
X-Gm-Message-State: AFq9FYLJP9YwNS6x8GzY/+TGfE8DaNr9Xci4eNmt/yJmn6ydeyqwmWTi
 7STIkjHLFlr6trYFPJ8DRfv+7Z5Ep8uEnh70+Y+jWF6NNVG++wISadHgPKmTi78AJtBfBRElb+A
 nRswxo+8myQuzYGQIV0CsoBZLaaC5sqLH5R2UiykDVLx1+NCRf7Rz1ngSdNvGCSFd0KPvPRjlZG
 HkoAjzpvRal+s+/TmKgRmk2Ja1D3e3JDJftEmExMUpaHk=
X-Gm-Gg: AYBFou2D8PZI6PVV12iYZVajieG0wOEOLJNzc2Y+RRXy5/yuaj8t6CpOp5OHdyC1sCq
 tM9ouMxZW3upc7EYN9sOT2p95zJc4wLiKilJ5jjQvVuqgRG0dFbWpOZSiv8NcdkHXal3p3t/wWG
 ZUtdc67eH5n7BgXEbji0nOB91vXDJACOv+5VuiEVm6OeS4rzd+HMVQ4Bwi79pusUrBlSZPKIgTd
 wmv+z7UslLdkFPkd4mxt35N9h0FM77Rvnk0Dg9FsyIQohuTrg4Yt/gR4JUAyxKeVOORBJQkw/n+
 S2xhLQHKDbi0gtf+FEi7DVn0vzc/yEukSrU8G5REPLkUAVb6RSt1tAikwOoXU2j1WvuZZPzSDaz
 qO94wtlARxwUOX+Ou2f0dCV4DP6hqatrGMK0jEZNMvz7aikDG9Pp3akdizrweZR1/OXQ+UEpXTT
 Yd3lkfejnv6FjbGPJxpClcm+0Oso+8YdBCQqlZJ9pUKryjG0PqVhKEEreguQtZeXRbimtV5U0H2
 dA8E/lLQVYW39Xpm23ph/dgJm6abOWFG3H6AFFM9+eWgHScaLrCNFrbrmCN6JYPX6qfX+nFOFuL
 EOTY8qvhHbwl7YJy9/pIoJPPRfG/HvGEZLMpxRtpAf4IVgX7nzl9ksKfnRsvM6HmJzk=
X-Received: by 2002:a17:907:3ea1:b0:c40:c6c8:6bd8 with SMTP id
 a640c23a62f3a-c49bdf6c56fmr114800866b.20.1793170740206; 
 Tue, 27 Oct 2026 23:59:00 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com.
 [209.85.218.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7bbdc6sm559161966b.87.2026.10.27.23.58.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 23:58:59 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c468bd799ecso73000566b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:58:57 -0700 (PDT)
X-Received: by 2002:a17:906:9f8e:b0:c3f:98d4:dfd0 with SMTP id
 a640c23a62f3a-c49be0a32c0mr109713566b.45.1793170736862; Tue, 27 Oct 2026
 23:58:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-16-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-16-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 14:58:45 +0800
X-Gmail-Original-Message-ID: <CAMXXpfaFNemWZ3dWOuKbTwn4OcVJOxVJvAZ7AS3zrnT4aQYv-w@mail.gmail.com>
X-Gm-Features: AclHuK_a5AqeoA3pIAlIaTjMHoH0AVcld8rWvFjbleQ_Cg5z0F8LLuu4-Hr9DL4
Message-ID: <CAMXXpfaFNemWZ3dWOuKbTwn4OcVJOxVJvAZ7AS3zrnT4aQYv-w@mail.gmail.com>
Subject: Re: [PATCH v4 15/18] hw/riscv/rv-trace-messages: add format 1 msgs
 with branch info
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000cae2b6065ee118a3"
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

--000000000000cae2b6065ee118a3
Content-Type: text/plain; charset="UTF-8"

>
> +size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
> +                                     uint8_t branches, uint32_t
> branch_map,
> +                                     uint64_t addr,
> +                                     bool notify, bool updiscon)
> +{
> +    RVTraceMessageHeader header = {.flow = 0, .extend = 0};
> +    RVTraceFormat1Payload payload = {.format = 0b01,
> +                                     .branches = branches,
> +                                     .notify = notify,
> +                                     .updiscon = updiscon};
>
Should we also initialize .branch_map here with .branch_map = branch_map?
The function accepts branch_map, but it is not included in this payload
initializer.

Thanks
Jay Chang

--000000000000cae2b6065ee118a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFp
bmVyIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+K3NpemVfdCBydl9ldHJhY2VfZ2VuX2VuY29kZWRfZm9ybWF0MSh1aW50OF90
ICpidWYsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdWludDhfdCBicmFuY2hlcywgdWludDMyX3QgYnJhbmNoX21hcCw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1
aW50NjRfdCBhZGRyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJvb2wgbm90aWZ5LCBib29sIHVwZGlzY29uKTxicj4NCit7PGJy
Pg0KK8KgIMKgIFJWVHJhY2VNZXNzYWdlSGVhZGVyIGhlYWRlciA9IHsuZmxvdyA9IDAsIC5leHRl
bmQgPSAwfTs8YnI+DQorwqAgwqAgUlZUcmFjZUZvcm1hdDFQYXlsb2FkIHBheWxvYWQgPSB7LmZv
cm1hdCA9IDBiMDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLmJyYW5jaGVzID0gYnJhbmNoZXMsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLm5vdGlmeSA9IG5v
dGlmeSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAudXBkaXNjb24gPSB1cGRpc2Nvbn07PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxw
IGNsYXNzPSJnbWFpbC13bmZkbnQxMCBnbWFpbC1fMWliaTBzM2ZkIGdtYWlsLV8xaWJpMHMzY2Ug
Z21haWwtXzFpYmkwczNlZyIgZGlyPSJhdXRvIj5TaG91bGQgd2UgYWxzbyBpbml0aWFsaXplIDxj
b2RlPi5icmFuY2hfbWFwPC9jb2RlPiBoZXJlIHdpdGggPGNvZGU+LmJyYW5jaF9tYXAgPSBicmFu
Y2hfbWFwPC9jb2RlPj8gVGhlIGZ1bmN0aW9uIGFjY2VwdHMgPGNvZGU+YnJhbmNoX21hcDwvY29k
ZT4sIGJ1dCBpdCBpcyBub3QgaW5jbHVkZWQgaW4gdGhpcyBwYXlsb2FkIGluaXRpYWxpemVyLjxi
cj48YnI+VGhhbmtzPGJyPkpheSBDaGFuZzwvcD48L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--000000000000cae2b6065ee118a3--

