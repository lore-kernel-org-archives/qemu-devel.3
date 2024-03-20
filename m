Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B352C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmmjd-0004KS-AL; Tue, 19 Mar 2024 23:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rmmjY-0004Ic-IC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rmmjW-0001uQ-Fv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710905717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyFaRj7/DCDom6tlzStomitmLu1Zw1driGD4CoBnZjc=;
 b=acMmRopVHjfbfKnwCsa4TN6YIyuhJBgZiB1L0ECSihbwSAm0zCJWeu/jjX/k94a0/aJ2is
 UI5lOHhxjGTNjKNSo+VhIfiBDHMEoxG+z92jjNxhLI0/pX9cRnXk+2M8neI3qiLT0+WrNu
 jh3HBq1jurIgTVqpUmzzej4sVd4LEq4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-MRxxq8z9PumOjA1Liaz9BA-1; Tue, 19 Mar 2024 23:35:15 -0400
X-MC-Unique: MRxxq8z9PumOjA1Liaz9BA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6e711a00780so3799915b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710905714; x=1711510514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyFaRj7/DCDom6tlzStomitmLu1Zw1driGD4CoBnZjc=;
 b=FDoiaYW9k1UtojSSaZ2SK2ostgtNwu5qG9bpLpihTvqMYaGf+hMGp9hdlJ1pdpauX7
 1NgkpChV927Qko/sjPM4sgtqaGFrZUE2LGjq9lDjTYQSSDLzNRBRlFsaBPh54K1iBlep
 1GP9TplCU+Fn7w4q9Q/j9jJv5QuFklAe5AUL0+L1OjLmxjHCTlzKPiCG93QUsFD1ZM3j
 UQEkadfozKTeuVT/+xmFnHFtkF5VSnt7HYiNaYz6sqOHvWeWpnEboYjUV5pac0Bml+sU
 8d9ImOUsE+bsD4B4FiyjWJ7wNRT2JK7pyYx0C96N6EpIaj9uVzXxxUWGUS+fuD2x4urc
 bevw==
X-Gm-Message-State: AOJu0YylXSrDhrnxmxDjWmA0RbEBzdvoj+am8LxbWnbbSUFvdLRulkbB
 T2ighUIsZrysgInZoDZlXd91qwNpvpnzRvEs7DLEhiGqZcNxB/8URyL0+Dp4TUs8joFCGOy+qmQ
 PjEPeDCPJYV3uuv0yvUBowUDJFHt00ODPZ8WhfqBiW6/RbVRs62qnD/+qrQJKu7qnDi9Y/kGz9o
 xo+U0GWFFReaI3H9j7Ly5yz5V0Ckc=
X-Received: by 2002:a05:6a20:d38d:b0:1a3:5c61:159 with SMTP id
 iq13-20020a056a20d38d00b001a35c610159mr9865759pzb.53.1710905714307; 
 Tue, 19 Mar 2024 20:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExv25Xrf5LrDsKV7k2wkFi2B/FnoOKlalZ5XgRhzqmkDvoOQ3BZ/uLvmCP6tOKCBkH+J9qkA3Q2jGuRQat+Bw=
X-Received: by 2002:a05:6a20:d38d:b0:1a3:5c61:159 with SMTP id
 iq13-20020a056a20d38d00b001a35c610159mr9865750pzb.53.1710905714047; Tue, 19
 Mar 2024 20:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <e500adfd-0911-4e7b-808e-ab1fd0034fa3@daynix.com>
In-Reply-To: <e500adfd-0911-4e7b-808e-ab1fd0034fa3@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 11:35:02 +0800
Message-ID: <CACGkMEtrXG5UHLRi+MT2p2m-=n_aqafbkur_=yoKRmimfX3ggw@mail.gmail.com>
Subject: Re: Pending network patches
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 11:33=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Hi Jason,
>
> I have this and a few other network-related patches not reviewed. Can
> you review them?
> I have the following patches ready for review:
>
> https://patchew.org/QEMU/20240212-tap-v2-1-94e2ee18b925@daynix.com/
> ("[PATCH v2] tap-win32: Remove unnecessary stubs")
>
> https://patchew.org/QEMU/20230921094851.36295-1-akihiko.odaki@daynix.com/
> ("[PATCH v2] Revert "tap: setting error appropriately when calling
> net_init_tap_one()"")
>
> https://patchew.org/QEMU/20231219-glib-v1-0-1b040d286b91@daynix.com/
> ("[PATCH 0/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()")
>
> Regards,
> Akihiko Odaki

Will do.

Thanks

>


