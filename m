Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66FDC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 08:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsf12-0006MQ-1x; Fri, 05 Apr 2024 04:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rsf0y-0006LD-2i
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 04:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rsf0w-0007WU-FU
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 04:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712306012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqJCxyWVA58yJs+bAujWgVvLr35iieqccc/qdOhZvIY=;
 b=GF7SE6F5Vat7enLxDtcJ8qWUFdbyEnaL7tX5CYIc87Kn4dFOZGkOBk9iaaXYBBjQi8Lq5b
 qmwc/dg1HpfftRFryTXnbstH0jIQQrEkVT+9uTXWQSya+sk3r/zJI6KffTmz4LyfLEKnm1
 +w2y17rRkQS+8gsr/tLtQyq3aDQ0XNs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-M7fa_uC6MHa8PMObvcVLww-1; Fri, 05 Apr 2024 04:33:30 -0400
X-MC-Unique: M7fa_uC6MHa8PMObvcVLww-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-516d2c322d5so669391e87.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712306009; x=1712910809;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqJCxyWVA58yJs+bAujWgVvLr35iieqccc/qdOhZvIY=;
 b=fi5K99tL0nCGqnfDWrmJOWwj+oVBoTlZaiXo1ufl7IRNmFvw2Q4BYlhwwbRcNALWui
 7Z+bFRljTBVPFdJsHwh1YRWHuDql/r6xC0D9yN3AlKXD0Jl3x1iMPUv7L5m68CEYq/8D
 xmpnjtqURPkkUCIaiGTSNfNVEA6mW4YHsjoz+keLSZh0eOLk70ZUaNQkST1xItl7XhGX
 fav9o3b30OS/jYNWBYdBy4AICqgibh1G4qBW3NcXKQpzrEchljzCgax4qSbX61MMZ81b
 VzpEyY5tBYFi7GcZ8GCetJj6sqnUkc7EHY6EyKCcj+ptFjLzUiH5aTuj+E7naHdrQcF6
 X0Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOA7rxMcT72LkOwseij8+KadRD4KvMaBUIN2+/gwZz0lEeAsPqU95uOzo3rjF0C6TQtIKPStygzwH+VTEgJe8hW2grkPY=
X-Gm-Message-State: AOJu0Yxw+zgEymmE1RQ26+2JSFh/2rNaX6pc5Dj3MBljP9+ugAw+W+y5
 nUfRkEjf3Ork+cPRj4UUPa3Q+LbJCUG5uZGGdDQk4/U6Yb/yMx/amHTp8YJx/fyaQ0eFzI/j6cq
 XT0NHFb3SszawTT+xzhSC5L2ISuXvnNx/dZxjCCtsvF355YMTFOJZ
X-Received: by 2002:ac2:4ac8:0:b0:515:b69e:8ddf with SMTP id
 m8-20020ac24ac8000000b00515b69e8ddfmr646982lfp.55.1712306008978; 
 Fri, 05 Apr 2024 01:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHikh+ovheB3Q2rnWqNuaoWa+ENQSkBwSjycBTnHmazmFilb90kF3EHKpFkJ6c9V4vZ7anviQ==
X-Received: by 2002:ac2:4ac8:0:b0:515:b69e:8ddf with SMTP id
 m8-20020ac24ac8000000b00515b69e8ddfmr646971lfp.55.1712306008591; 
 Fri, 05 Apr 2024 01:33:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 hi23-20020a05600c535700b004146a1bf590sm5440571wmb.32.2024.04.05.01.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 01:33:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Apr 2024 10:33:27 +0200
Message-Id: <D0C1TKCY2WD1.2JMXKVWGWGB8M@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v4 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
User-Agent: aerc/0.15.2-111-g39195000e213
References: <20240318151216.32833-1-aharivel@redhat.com>
 <20240318151216.32833-4-aharivel@redhat.com> <Zfw3teeWGAGiUKq7@redhat.com>
In-Reply-To: <Zfw3teeWGAGiUKq7@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
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

Hi Daniel,

> > +    SocketAddress saddr =3D {
> > +        .type =3D SOCKET_ADDRESS_TYPE_UNIX,
> > +        .u.q_unix.path =3D socket_path
> > +    };
> > +    QIOChannelSocket *sioc =3D qio_channel_socket_new();
> > +    Error *local_err =3D NULL;
> > +
> > +    int r;
> > +
> > +    qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
> > +    qio_channel_socket_connect_sync(sioc,
> > +                                    &saddr,
> > +                                    &local_err);
> > +    g_free(socket_path);
> > +    if (local_err) {
> > +        goto out_close;
> > +    }
>
> In the previous posting I suggested that connectiong to the
> helper again & again for every individual MSR read is a
> high overhead. Connect once, and then just keep the socket
> open forever.
>

Indeed, this would be way more efficient.=20

Does that means that I should create the socket during the=20
initialisation of the main loop (kvm_msr_energy_thread_init) and keep=20
track of the context variable and then just give the QIOChannelSocket=20
pointer has a parameter to the vmsr_read_msr() function to send the=20
data?

Regards,
Anthony


