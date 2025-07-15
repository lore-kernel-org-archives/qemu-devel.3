Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0446AC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubX7N-00019E-Rg; Tue, 15 Jul 2025 00:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubX3C-0007uM-BC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubX39-0007eh-5v
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752552828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kkj667ViCLvZkiJSU23dkS3hxY6bi6u+vpzRPIlZWk=;
 b=ITfUL7/ICSv+3QL4it1uiJ96rggweWJlD4zXDbbgOs7/xWHaTJ7aDNfyOBq6RIlqj1G/N0
 LbVpQFmwbZifKGa/G2WQYB1QecW66X4Jd+LmMhFGutQw+ie5WE3wMDe2+3b5dXwjdH4RXs
 2V1gG014BdDR/WwmOVzdQBHQSosKf1c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-YT3_5_rJPPSNjvg6v9Rajw-1; Tue, 15 Jul 2025 00:13:46 -0400
X-MC-Unique: YT3_5_rJPPSNjvg6v9Rajw-1
X-Mimecast-MFC-AGG-ID: YT3_5_rJPPSNjvg6v9Rajw_1752552826
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-311e98ee3fcso5560980a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 21:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752552825; x=1753157625;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kkj667ViCLvZkiJSU23dkS3hxY6bi6u+vpzRPIlZWk=;
 b=JAhFB5FgWn4ITScVSf4rHqR3p33hB1+Jdktyyn4aC7Q5FTYEO0rua6bLQvaD8kRXw2
 bv57zLAM8dMK7H2QVMPKGx4kF5CYLb8A+paQNzjXwitTtaXaniqPmJvC1v9KnXODQDvO
 fZfZOfQv8NWVH2ywnBDHSLF30xurfKNWWJSWjBpuvKVuBxxxh5+oaaCFD7SyvHJHwfJi
 csk/fkdblgVD7cXQjF21v3GFmQ5c7qRRyWsDWJ6+vqgBuXvhfdOrwFlpvDYh/aFPY48t
 YSl+xBh9GsAM0yvQt92ozsEWo8jSq7GYzHvuwdhRCCPx2x6y3RfSS7LuunQpoUFxDgQe
 aHig==
X-Gm-Message-State: AOJu0Yw4YY6uED9ZNcwmekELDJumzLzvTlX8GveJeCsT1xesUPnQasV9
 +CG23rWLfK6/fm6sH4o476JF0IEj0LiF6nvCzktgLzTeHbrQYxrX9croDyUd4kZ6Ry87t1f2qBk
 D1KMZKc4qcHhngMq9uorI566czYGTLY44gucaWeu+6b+Yy1qXFnwMsUd8PAicWOlTTcOofRt/1z
 Uu7ew0ES11X7Nom5Rsj2OARTiaxNQp6U+/QdIbcuO8NQ==
X-Gm-Gg: ASbGncv+L+BmE151neg3LDAgdzq/JI2IV+cfl3nmrceQrh/jIa1Xih7w37arI+N5S76
 cab15x+ubUU6QqyP5upc6hYvFsVFK6e/5SfoVY6hST7psKJDOy5o68ZXHjikpNKIDZ/Ljb2jg28
 CFTBwxaheBEhPrQji9pjA=
X-Received: by 2002:a17:90a:da83:b0:311:482a:f956 with SMTP id
 98e67ed59e1d1-31c8f7da75emr3132683a91.5.1752552825398; 
 Mon, 14 Jul 2025 21:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1q+ciA1baAO+R+3OwysRaMLIhIXp3sC82bQEvcaz32QErfm34SYa+RW0997RHlo6jthVu+25M+Ys1+cpwCa4=
X-Received: by 2002:a17:90a:da83:b0:311:482a:f956 with SMTP id
 98e67ed59e1d1-31c8f7da75emr3132655a91.5.1752552824875; Mon, 14 Jul 2025
 21:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250714053423.10415-1-jasowang@redhat.com>
In-Reply-To: <20250714053423.10415-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Jul 2025 12:13:32 +0800
X-Gm-Features: Ac12FXz4EZpf5S4Z0oGdqL46s52axZYSpKRKg4CyvY8u0tPzSCenb-tpmW35u9Q
Message-ID: <CACGkMEuLMqECDb-DYqcEQjF+rhYjT1gf0i7q6DiEWtYh0wuu5w@mail.gmail.com>
Subject: Re: [PULL 00/13] Net patches
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jul 14, 2025 at 1:34=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b5433=
36:
>
>   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into s=
taging (2025-07-13 01:46:04 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to da703b06a52bfb5fe1a77b0eddbb8d68d3f70762:
>
>   net/passt: Implement vhost-user backend support (2025-07-14 13:27:09 +0=
800)

 I decided to include Daniel's AF_XDP enhancement, so I will post V2
of the PULL.

Thanks


