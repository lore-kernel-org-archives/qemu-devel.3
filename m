Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B31FC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40kP-0003T2-GC; Mon, 06 May 2024 11:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s40kK-0003Qj-9s
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s40kI-0005mU-NU
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715011157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uY6FVCTOvlK6OyM5iWUTILj8iYBKU5exginYpKXQtPM=;
 b=X4PaidPinm3b59dNrfIJf0iK99/BZRaFk9n4y3z8ecEKUU6Y8oI1RKqpTqSFwaF4lxa/q0
 rOAmwwtGBTvxJTzGGgXqEYbywYQM6p7mLBHw+AtqcxawEr8YyyUB1umdL0pVih1dzr5qpv
 n8NNooLc8wchry9CG91KtHTE0s+PS2M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-eZAuNmKbPt2jGBH0vYb4KQ-1; Mon, 06 May 2024 11:59:15 -0400
X-MC-Unique: eZAuNmKbPt2jGBH0vYb4KQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34d9055c7e0so1605122f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715011155; x=1715615955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uY6FVCTOvlK6OyM5iWUTILj8iYBKU5exginYpKXQtPM=;
 b=ekPpTDdaaEuAu/4pVpMQd3Dorj5VFS7WfWxAbkRJBZOPee3IJZ3k8/lTzH/86yx045
 LaTAp45dd5C2bIfZH+QcvLvBhKqgYL8I6yJd7n+RRbaIMlESlG1dKDl2aukyKlwJ5HVU
 00TOfBjFJUYMMoLe53TbK6FSXEhLPevQ+cagqDAXuNG1ykfA5sT3xgqFTr0pNtr6aQm9
 tX3d8vz0xxesCunQEcb1st3eiyccFUaqdnIigkzm+aSgNFfuj21riD/43PB+xtgeSLWP
 +/4Ymwrtor2ENBUp08/QxQGahwX+A+fKqj26pdjq3vSK5nplQDebYbYsQn6RBDwdGbCc
 CLTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvQM3WIbZQRvqjKkEKBIaNZ7em8182bMb7XjH/VxE+U6sKyeMn8FDYJC8df8lpt3e48NyCu6GwW/V2MYWca51gSui3bgo=
X-Gm-Message-State: AOJu0YwseDp8fAYhZg85GFHnMBG7S/orr/1BoG+J66BQBDMatPaTiC4h
 slgl7Wp4Ia+6OK9qSoVsFTAVZSxqoRTljcfLXKNWHEwzA/HcvivA1IxOamHxwicqrvFlphWAzIO
 bIll51617A6tQCwtFQvHrp5GDP5zoAYwhFTXHRlefq74tasidWGnK9Un931HofBN/Mf4DE5SXZE
 SWiAVmCfD+yuc/2hKKEctGSCK6Zg4=
X-Received: by 2002:adf:f282:0:b0:34f:4e40:c05c with SMTP id
 k2-20020adff282000000b0034f4e40c05cmr1795099wro.34.1715011154848; 
 Mon, 06 May 2024 08:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3vgeOQt99KCbycbEIms8fPf0KGZb2Jxtfw7VY/QaxXxuj6pr6ZMqZyf9gB2iwhpsyetw81bJfrlx8hl2hvWA=
X-Received: by 2002:adf:f282:0:b0:34f:4e40:c05c with SMTP id
 k2-20020adff282000000b0034f4e40c05cmr1795084wro.34.1715011154548; Mon, 06 May
 2024 08:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240425184315.553329-1-thuth@redhat.com>
In-Reply-To: <20240425184315.553329-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 May 2024 17:59:02 +0200
Message-ID: <CABgObfZ9cyt1_W+u-bPhRUbYGtLEr57qNonASEqJkRSD-=8ALQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Make it possible to compile the x86 binaries without
 FDC
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Thu, Apr 25, 2024 at 8:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
> OTOH, it seems
> to work fine, and the FDC is only disabled when it is not available
> in the binary, so I hope this patch is fine, too.

We do the same for parallel so i think it should be fine---definitely
for -nodefaults, and I'd say in general too.  The CMOS byte already
has a way to communicate no-floppy (0, see cmos_get_fd_drive_type).

Paolo


