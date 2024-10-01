Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8FECEACCD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdng-0005gG-G7; Tue, 01 Oct 2024 10:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1svdm8-0004nH-Hn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:23:00 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1svdm2-0005bH-G6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:22:50 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb321145easo46247176d6.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727792565; x=1728397365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsxWXnfjxGZ3DY3wCUr2eO19f8E2tCESeHOUB5/59yQ=;
 b=Ht3h5sT7mTHp9Bydy3+ZNjNFccd7jxCDlBzI2Pq2Zz5CqRRUYrMGYsuTOE+IwYbivI
 KIdyQf7R8rqXndrLvRGw5wMsvQzg12zUsGjkXonj2aMdrupgahq2zL1tfnBFtp0VrN7d
 wx+kPzxM+7iut2sB5RfqpYKdXa/QFmEPHxfxFOA43sLdEPtmjGYTrqXEC/1GUPJFXatW
 2mQfOM18duqYBIJDzXcTCRYDNw6yEOs3mKIK0gVHe76E/Co/4HuK0d0lG75npCcv8Sue
 jUKKeci+PwuCtjwkwKk+ewTl/3oc1tE3ZXUNmsPQfn7ohAcPmnZ3m7nfq/CrYG4CQO6p
 D8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727792565; x=1728397365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsxWXnfjxGZ3DY3wCUr2eO19f8E2tCESeHOUB5/59yQ=;
 b=ANHfR7IFyXdpIqxGVhKw8JNfb7RP6DAHZBjBZ4ikGSyUBTFMyOBw3VnMhiBLYu/TWs
 Ns1TQag7S0bxtEACHkOfOXRVKboIQWXiwiKizLT4FLMQneyeuJftbddeMvAnYcTIAS0m
 QqNSqEtgJZSg9FC+vzU2A1GpwAlcFCr4tMAyXFHN6vxc7k/IEaowMYUefneFenu523Fy
 lIz+q+h6BSbXAPOoK73RyZTrRH2XacHy0R3Xeia8113qdgbl4Lw9s6uOVhzOheYaskev
 Zycx8X8OTH2sw47CaIp6yhZ0vHEBjqqpduTnH6wF5pqvnk+0zF/9KYOYJGqpmy2RipaW
 IWCA==
X-Gm-Message-State: AOJu0YyVat6Ve7c+nVShH4eM5Aqz1h/pHczLWJ73fH/LRX9eYNU4bPOE
 xMQnNlwvIRkmLFaVR+xXchuOfvoOXzfFwr74lFqQ3O1jjL8hMxOD+IVy20YHG7ucXGsESoqIJTm
 8pUys8Lqifjanyk8fZ+X5eQopidWtMkHH
X-Google-Smtp-Source: AGHT+IHldUhVyMXLnQ7G05SJihFIgGcahVFQevyNBrje/0VHPJEjkqrA6jJIP5kpNnhoHQXU1ZqY+3kl41AVLD0i00k=
X-Received: by 2002:a05:6102:2921:b0:49b:d489:d467 with SMTP id
 ada2fe7eead31-4a3d5d4691bmr1712711137.8.1727789112306; Tue, 01 Oct 2024
 06:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240922094441.23802-1-dorjoychy111@gmail.com>
 <20241001091436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241001091436-mutt-send-email-mst@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 1 Oct 2024 19:25:09 +0600
Message-ID: <CAFfO_h78jFc1w93VXYLjsK89kXMjbJ782Eo77O2XGzQLRxvX+w@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] AWS Nitro Enclave emulation support
To: "Michael S. Tsirkin" <mst@redhat.com>, graf@amazon.com
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, berrange@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=dorjoychy111@gmail.com; helo=mail-qv1-xf34.google.com
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

On Tue, Oct 1, 2024 at 7:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Sep 22, 2024 at 03:44:36PM +0600, Dorjoy Chowdhury wrote:
> > [7] https://lists.oasis-open.org/archives/virtio-comment/202310/msg0038=
7.html
>
> That list is dead, would you mind reposting to the new list,
> so we can vote on it?

Yeah the URL seems to be dead too but I found the lore URL:
https://lore.kernel.org/virtio-comment/20231025235345.17788-1-graf@amazon.c=
om/
Probably Alex needs to repost, right?
cc Alex

Regards,
Dorjoy

