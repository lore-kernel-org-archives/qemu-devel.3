Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04941C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPDx-00063V-4c; Wed, 27 Mar 2024 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpPDv-000633-CA
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpPDt-0008V9-TL
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711530328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5ZPAYUbe7OyUCREHa3Q1YnYrSTvUzQahxmBWxD9nLM=;
 b=a/v+VhS6iq6eygM2zoyURT3kf9s5EwboFH51eXsQfCJX9TiH8+9OZTN6cK7KeuuZVshQdX
 tuM6E/8iN92Ne6JxJwNAU+/CvMD8/LMt+ULZyalS8go6PCawD2yYqWVEQBE0g/TgHtuzVx
 p5TRkSx1zQ5sAIyQhx7KfA7QVwU2wj0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-QajUs_mgOy6hIqWEhQiAzA-1; Wed, 27 Mar 2024 05:05:27 -0400
X-MC-Unique: QajUs_mgOy6hIqWEhQiAzA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed2555b61so3555866f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711530326; x=1712135126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5ZPAYUbe7OyUCREHa3Q1YnYrSTvUzQahxmBWxD9nLM=;
 b=f+oKcGDCxQ5BUvgquH3nkEDNLwZ/3E9DupmeHejPd8AdY8eN7qyzy1Gtb0f4cDBl5V
 Sr87O9FGzrfy3Wk4k7OGJ/9kE4zoch9Dn+oSUk9j2wgoZw1bP5m6LvP3tDFKAd4v3a6k
 0vF6r+4t9xofEI2/SKNgh+pvjxSl+FTHpPR2NCZANE3GOHlpDcsS5ymvWbbwRWPgeS+K
 a185mbUJIvcisUSdeZI/NIu+7YeT8sXI/d83PrZot9UGOXrF8qV4J/RFtyxgqmc5Qtjo
 jVpoT956vyY4ruYfjgYNekDLfDLZfzJByX28rVyI1TmPgYGdHxqileIfnRY94A4WgMkJ
 gzWA==
X-Gm-Message-State: AOJu0YygvmRzpqvALThAhZNiHaHN6MMMqHEo5BDwNBaXxp81HPuLG4iI
 JEL/wIKpirjrF0EVBzyvwwJPk6QEi6BtBwLdgof3QET0L4EeLbPk1hVj2W6klfNRQWgnAThXosb
 bfT9KkGJZwLThw4zgTsQoLalkvyJy4MRqDB2bDqQQPkA1TwFLg6+P7vjdjJxXpIcCf3ERfmadSH
 tV5gtHi1C3q7nagXUZfjJg85zbLgM=
X-Received: by 2002:adf:fd52:0:b0:341:aec7:c583 with SMTP id
 h18-20020adffd52000000b00341aec7c583mr2234076wrs.53.1711530325976; 
 Wed, 27 Mar 2024 02:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeV8wphIHwQzWpk0YDbkfPeij8q127QBHcniiVcm1s6ICcGkh7EiU706IyBL/qND0i/k1oLQf0/JpGrlbc02I=
X-Received: by 2002:adf:fd52:0:b0:341:aec7:c583 with SMTP id
 h18-20020adffd52000000b00341aec7c583mr2234067wrs.53.1711530325695; Wed, 27
 Mar 2024 02:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-13-pbonzini@redhat.com>
 <62c24e8e-4b6a-4710-a4b8-a26197d0143e@intel.com>
In-Reply-To: <62c24e8e-4b6a-4710-a4b8-a26197d0143e@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Mar 2024 10:05:13 +0100
Message-ID: <CABgObfZbOSwBJ8E6Pqx8MDZEiKhnSAbNEEO8SDOugZWL7xmPiw@mail.gmail.com>
Subject: Re: [PATCH 12/26] KVM: track whether guest state is encrypted
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Tue, Mar 26, 2024 at 4:48=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
> So, this requires confidential guests to call
> kvm_mark_guest_state_protected() in its machine_init_done notifier callba=
ck?
>
> But for TDX, the guest_state is protected at the beginning, not some
> time later when machine_init_done.

Good point, I will change this to an "if".

Paolo


