Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ABECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHWp-0005jg-81; Wed, 27 Aug 2025 10:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1urHWl-0005ib-Th
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1urHWj-00036K-Gx
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756306405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbHHeknEsZl6F+kgG0EA6Cce+BFXRbEJHNnPRKfG+7w=;
 b=HNRjsGehZnx7+oQrnnh8fLCigup5/hIaizyuopNlyoU6ZN/vNzQ0iP86Cpyv0WnjiIZsA0
 kJd9S0F70It2fDR8sDYOcc3qRzZdfvbEm6HUedTKIZHIh45wDjL8e9YlFIPOI9dgprV5cR
 EHTr2kiR6eEnzwweEFjdAuTuNYBkWrg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-wkmeklUONyG7vJutt4jm1g-1; Wed, 27 Aug 2025 10:53:24 -0400
X-MC-Unique: wkmeklUONyG7vJutt4jm1g-1
X-Mimecast-MFC-AGG-ID: wkmeklUONyG7vJutt4jm1g_1756306403
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b2d09814efso56676831cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756306403; x=1756911203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vbHHeknEsZl6F+kgG0EA6Cce+BFXRbEJHNnPRKfG+7w=;
 b=NBAoGM8Lo8MMxjy14Iu5BiL2SexE955g9y8q73bV4e00YwMSIyUJPrj1HfKR2T55eR
 MVJua0RJ5AyybBrLUCn2rWRhGqNzUGbJPtPLCQw79reLYDthmkuaxqazztFEos7GRPZl
 y3C3ggO+DMn1mGcyn1Rw9Kk3lMOIPgqj0JFPJZEJfvBw5S5kNDTiAU1GlbKdU+7Fq5Xz
 XYrL46mpsOi4IPNU+IqQF6q1gCPKGNXWWF+OZYejbheFIjEfH9StiN8rb6YjqUvdb0wn
 pHiM3jknTkeeXyW2d5Gn48cQ5NehCTf0NZfaTu5JF9pRswnK5BZf43Q47z4Uq3Q1sjTQ
 qBaQ==
X-Gm-Message-State: AOJu0Yz7prlSSid6bwjG2anAsyNHr96+fU1eeC8Pw01Dt6iU6YcxcBk2
 LqNSiu/vZEuXPpfrlGGWnU/ddhOsi9If/N9FAVDh74TeYLyT2LGpHa7d66vDpX/gwnlsuArRgcj
 l+ICm0vO+2GPtpzeL+89R7HwPONX19cLVvyKZ+a/VQDVmn/r6vGieExoch0n57NhY1jbAieBvC7
 bHVJ77SCFg/ZX0bPpoE0IdUbPLaHb1cD/MuolO6pE=
X-Gm-Gg: ASbGncudR4nzvE4PrapzdS9s77C+QEjO7Eu710STQu+q3zEVT4aYllXOa70UpuIPKks
 cp1C01WypageGipnEseeOhUGMZsF246vj8I+QPpS4BcyMEub2sKDjVpAkI/cWmqFo8IVFRqjeqf
 7evxJkFQZ9DnW92661GORkfA==
X-Received: by 2002:ac8:5ac7:0:b0:4b2:8ac4:ef93 with SMTP id
 d75a77b69052e-4b2aab694a8mr239138661cf.78.1756306402595; 
 Wed, 27 Aug 2025 07:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyibpN68iauMRsWOreIE91OVrOYnAXUvfrX6qquBoyNw8ATQGhbYqj071EZ8Be0hGpY2y9dEo8Txw072Q4Vek=
X-Received: by 2002:ac8:5ac7:0:b0:4b2:8ac4:ef93 with SMTP id
 d75a77b69052e-4b2aab694a8mr239138381cf.78.1756306402044; Wed, 27 Aug 2025
 07:53:22 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Aug 2025 09:53:20 -0500
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Aug 2025 09:53:20 -0500
From: Andrea Bolognani <abologna@redhat.com>
References: <CABJz62PiQ9ipaJqr+X6AQvTJWZdAug5--4LOXa0i95DZkorNHw@mail.gmail.com>
 <f920ea53-c75f-4a45-9e30-e49af3c7bd44@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <f920ea53-c75f-4a45-9e30-e49af3c7bd44@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 09:53:20 -0500
X-Gm-Features: Ac12FXwZKHyQQsWs9W5pdOMc63aCqLVRiuo3PSpBMnpO9F1zr-0bNLAnUHZM1lY
Message-ID: <CABJz62O6JGk__PrAsW31t8ToCrkbtcSiPWV7z1jbAb=5RWWGhA@mail.gmail.com>
Subject: Re: PGP keysigning at KVM Forum 2025
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 26, 2025 at 02:17:31PM -0500, Brian Cain wrote:
> On 8/25/2025 7:17 AM, Andrea Bolognani wrote:
> > If you are attending KVM Forum and are interested in strenghtening
> > the PGP web of trust, prepare little paper slips with your key's
> > details on them ahead of time and bring them to the conference; then,
>
> Specifically what information should be on the slips?=C2=A0 uids, fingerp=
rint,
> and ... anything else?

The output of `gpg --list-keys YOURKEY` is all you need.

> Is there a quick command to maybe dump gpg output to a pdf with N copies =
of
> this info on a page?

Apparently there used to exist one or more websites that would
generate this for you, but they're not longer operational due to
the... Unfortunate state of the keyserver network.

Last year I created my own template using LibreOffice Writer. I was
able to fit 2x13 copies per A4 page, and it only took maybe 15
minutes to prepare the whole thing.

--=20
Andrea Bolognani / Red Hat / Virtualization


