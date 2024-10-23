Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A947CF5394
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 14:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3cKS-0004SF-RQ; Wed, 23 Oct 2024 10:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t3cKR-0004Rd-F6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 10:27:15 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t3cKQ-0004br-61
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 10:27:15 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e60e57a322so2235175b6e.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729693632; x=1730298432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VO8jVNmhKsZvR6twEKG7SAO/7UY1kiwtGMEOq/cJ9g8=;
 b=OfyN5/sbcgLDLFKXaw3OuwaPpKN6nawP1F1mhoWt/dA2CKKMeXwxdQaAoAinDI0ClP
 gqRgZwPknFLuFrdT+n9xVlVJlMlzoMd9Gk92U4hz/DXgRC0XoD3cRVC66jJw8vu36Rj+
 ayMQvnimBLHsoFmFOVx8m4NupBxYFn56tH+M2G3MbtHNgknORris5vj0PrPqFEcP80Wt
 DTFQYYwjfXCakyNFYp76/2WR4zAuYu/K+iafZLDrW0XmCbUhSi3KG+C9c++7J1KlgoZX
 c1tzoSw33O/ObdPw84KvxOTQx398RXAc+Ul0F9QH6Vu6T/az1ZiK1c5lXFY9xrbgWCDq
 2BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729693632; x=1730298432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VO8jVNmhKsZvR6twEKG7SAO/7UY1kiwtGMEOq/cJ9g8=;
 b=AzoWS0ECfUEaw01CBoWZtxUMQXOgs3zD6OFH041wM3PI2r7RU2soChax2eeKs1JvzP
 OQWOHcO7MJfjYn6hWXvU1S3v42+U5/R7sDOQ53LgZotQVarA+nHmlgUGCylhrcrzzCgy
 dUFnEf3pGFhEClKJApfHYEBuyYhaMzdhj5fAMW27DJsss22rsYksop+hZPtXzARPXxH4
 e6qeE3mB5DE9RgTZnhhFCu3b4Dga8fSjvxEEhQFWpnpEU2C1XxBQ4JMmktZQtsxjr8pD
 AVacO02B7oIOf0fAO3+B5vmyT3cgO/2RJp/8H4fjlhVF+6UHZEGl1e05WMQ4Q2NV/w0G
 wkqw==
X-Gm-Message-State: AOJu0YyRu6JAeXtqSZMLq+3SdTR5kGdmK0m5+9C1bgR7AwMPP6jUt9Mh
 wjD9kw3jzIsU460PNhuGRv/Xll14K7X+sdCpTTwTgF4vsiktHOIWCb03j4nh+C7PJEjqoff+rdI
 I9JnoT9I8EL3TB6VdJFY3POW4IucllQ==
X-Google-Smtp-Source: AGHT+IFtDFYQyH81vHCoIcmSia/5qvBAd0j7jk9WQkWVUDAMntbJLwbMLTFa3zg95PD0ZUJK4fI23eg1STAVzuc/8ZI=
X-Received: by 2002:a05:6808:180b:b0:3e2:8696:4b4f with SMTP id
 5614622812f47-3e62452dd30mr2633819b6e.19.1729693632393; Wed, 23 Oct 2024
 07:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
In-Reply-To: <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 23 Oct 2024 20:27:12 +0600
Message-ID: <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, Alexander Graf <graf@amazon.com>, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x233.google.com
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

On Wed, Oct 16, 2024 at 7:58=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Ping
>
> This patch series has been reviewed by Alex. I am not sure if it needs
> more review. If not, maybe this can be picked up for merging. Thanks!
>

Gentle ping.

This patch series has been reviewed by Alex and there hasn't been any
more reviews. it would be great if this could be picked up for
merging. Thanks!

Regards,
Dorjoy

