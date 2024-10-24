Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A72FD0BB79
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tmE-0004Ly-V3; Thu, 24 Oct 2024 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3tmD-0004Lp-IN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3tmC-0005lh-3p
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729760703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4ItFu13WA/vAUcr49QAZSF6q0C0GhR1v1axo8wPncg=;
 b=Uwf9EVt0pLtb4sosZNcpEO+jHTmk6sMRDTKj8Ihhcu2CEzsBkQduo9h+UkWmkPyCHLnPTk
 y48NLCRS63AZEFq9PI6syj6BDgRxHzdUc+z+P4rIeoJOSr50alVtMHhEdezeg3MAZgDnz0
 iB/oDqoQTX8ox7kNavAz3aux2wFZdK0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-uUNtgdiRNFC_N2B1CyCEFw-1; Thu, 24 Oct 2024 05:05:02 -0400
X-MC-Unique: uUNtgdiRNFC_N2B1CyCEFw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5ca5bfc8so354595f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729760700; x=1730365500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4ItFu13WA/vAUcr49QAZSF6q0C0GhR1v1axo8wPncg=;
 b=GIdoNOG54OY9IIXQ38KN5mIN/R8MnjfGfDqtGO8PKMfk2VBj/z1/C1chBJRpy2V10H
 qIryVEQ9uDsuPYSsznwWAp2fkFSHiYY6Y9fYhvhsHNy+bUhuiiLeNwSaXJw5Fn87/wSK
 PrBTMj3KkjAc+hs282UfrrK3nU24TbLO140rfiK/kP4EfFQ6w6a0mkgwLPgWwI+rDx7B
 +ONH1tB9MotTiKuCGnaTjcg8caHCuke7sdwUSVWkYa35+q5L+J2dKBtJWUEmkRv+q511
 1YrEmd4QxJWr1Ffti95c1aaut6/hRcGxPbq/p8qOA1rVgnNQRfR7tDkwHDp6lxNrIhb0
 HSgw==
X-Gm-Message-State: AOJu0YyFfUWxwO9MEwklgRZKmb7GGuOVYogL6WgE9ifFi6UM/MXVXHxP
 ArDm/2wB6k1A8jqTiunOrtqDQk9awTBEkxrh8X9IzTsGfXOEzJEdGrS7r4wrhgaKlHK1qDDTlHM
 /EgtnxudvJ803fBhDLwGBHuZCP0GwSGZ3iAe46lxkT4JhnLqq0N1ZtjiDLOuY2ZwpXlN+S6Fr7T
 ukqzxIi58iElo2psiSlq/KexpHfK7WWZblEG21Qw==
X-Received: by 2002:adf:fd8a:0:b0:37d:52bc:72ed with SMTP id
 ffacd0b85a97d-37efcf0626amr3438320f8f.14.1729760700139; 
 Thu, 24 Oct 2024 02:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG7znbDSqxKYGULmnfrSBxg80AbQOWD2XSZge5uWQ6BI0IXgRfkYpv4ZT9YuLjBrugoH2dAnS0f4ysMaDSG/g=
X-Received: by 2002:adf:fd8a:0:b0:37d:52bc:72ed with SMTP id
 ffacd0b85a97d-37efcf0626amr3438307f8f.14.1729760699827; Thu, 24 Oct 2024
 02:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241022085359.186470-1-pbonzini@redhat.com>
 <CAAjaMXaaRGXY4shzF_-9Mzhb69Bs5gEHuMHWGczkfmvGyfkPUA@mail.gmail.com>
In-Reply-To: <CAAjaMXaaRGXY4shzF_-9Mzhb69Bs5gEHuMHWGczkfmvGyfkPUA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 24 Oct 2024 11:04:48 +0200
Message-ID: <CABgObfYRn=eYoO1FEYVkUai7_WixfwzTckYUbh46DE1PVvFdbA@mail.gmail.com>
Subject: Re: [PATCH] arm: Kconfig: disable stellaris if Rust is enabled
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 23, 2024 at 12:28=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> By the way I already have a patch that adds a -luminary version,
> planning on including it with the rest of my procedural macro patches
> I will send.

I'll hold on this patch until I get yours then. It is not needed yet
for CI, since we don't run tests with Rust enabled.

Paolo


