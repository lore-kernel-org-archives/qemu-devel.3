Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C3CC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 08:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ7oE-0004jh-Tt; Mon, 17 Jun 2024 04:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJ7oB-0004jU-N7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJ7o9-0007e7-RG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718613224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+5FenPlsI1UV/F894VVidGq2mH6wzlRLvs+05kUPgY=;
 b=cW/yLwk6mJ7pxmC+Zj1bwFYOGfUKHp+or/hGACZJbdh1ZfdzZPh8XqZyBWkMCYn5CxhTsN
 tArHLbLpj8jYe311qK5dlZu1PZlMuM+/K5q5BkcFWDHD1jux1r7rdZkyivnh6NoBVFzEER
 iYlC3/F+zqcX1m/k6Nl8uSC/vhPg8e4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-ZLh-apfXPCaETJgkdoXNzg-1; Mon, 17 Jun 2024 04:33:40 -0400
X-MC-Unique: ZLh-apfXPCaETJgkdoXNzg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42183fdb37cso29969465e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 01:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718613219; x=1719218019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+5FenPlsI1UV/F894VVidGq2mH6wzlRLvs+05kUPgY=;
 b=qL1g/goxohqZ0QfmvJiJdtP/MK7KJuOy1k/1Kne+21EwmywlN3icHhtS0OWC/KoP0j
 iAEE0JyjjpIjNq57qEw95ZSbek1+4zvYaabT2rQ2UdgIomvencWt/tDPvwH3iGaN00bR
 vY1JwyvUyjR2E8UffYKJPsCw6rvGIAcFHTIbz/BWbSdO3yElz2VIrpxR3v96BkjOW/Dq
 npBw09tqrBOqp6ltYEahdyG48ixz2+8LGcBJc7EossxNdIUrNE6QLep7w6brIe4CL6gg
 E/N5xfBghFoHQGGpUjH26LcXXPjWIg69tcLPXns1tsGHbYJBcACbeYWdDD5W2aeekjMl
 fhMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjoCpnS6C9UQkqeEZLIdCOUgS/Nu2F3YZs+GRwdbqKs+skyLW30Wgg93FdAtjR+cbpvky/feAHt7356c+qCdwSDLLk84A=
X-Gm-Message-State: AOJu0YzOLbZAmY91UZCVPBVgXgBD8Kv69pWqRFC0g1LMkcy9YCgK94ui
 AHWuOyRTBYKn7HEmetvT6NbowoaDxz3o4S3bJF/Nq8NdUJtwbr067A361jEpzgxShPSuevaEwfy
 wxKkXRESvUWOnnTW14iKWaDyEri0OyEwXwvb9+s3lgVT6CaSt79zN89zl54tUvL/Bumuk9XBDix
 PrHoPS7dWm1Ge+MCRP+JV0oYZpoSY=
X-Received: by 2002:a05:600c:4f92:b0:422:6765:2726 with SMTP id
 5b1f17b1804b1-4230484d079mr72899745e9.30.1718613219298; 
 Mon, 17 Jun 2024 01:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRIul7y9OuFwINPw4BcS5t06C/D2RT/7k0xgix+wHN89Oea7FwLMWdPNUtDeO1FFfnvXk4hMYsOiQ3naOFBtM=
X-Received: by 2002:a05:600c:4f92:b0:422:6765:2726 with SMTP id
 5b1f17b1804b1-4230484d079mr72899665e9.30.1718613219004; Mon, 17 Jun 2024
 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240611162021.269457-1-robhenry@microsoft.com>
 <20240611162021.269457-2-robhenry@microsoft.com>
 <71f86082-05df-48c8-9581-68f6417c525e@linaro.org>
 <CAEYr_8mY3cqnL1dsm-dA2k+T+M4YAQpHxeaYoZ805Ax-FSp8rA@mail.gmail.com>
In-Reply-To: <CAEYr_8mY3cqnL1dsm-dA2k+T+M4YAQpHxeaYoZ805Ax-FSp8rA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Jun 2024 10:33:27 +0200
Message-ID: <CABgObfagqi3uLPAN9nXBOjULfQXfxiLRybsaWuEOdcY1HV0_3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] i386/tcg: Allow IRET from user mode to user mode for
 dotnet runtime
To: Robert Henry <rrh.henry@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 "Robert R. Henry" <robhenry@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jun 17, 2024 at 12:45=E2=80=AFAM Robert Henry <rrh.henry@gmail.com>=
 wrote:
> I do not think I will have the time or focus to work on improving this pa=
tch this summer, as I will retire in 2 weeks and need to make a clean break=
 to focus on other things (health, for one) for a while.
> If anyone wants to put into place Richard's ideas, I will not be offended=
!

Great, I'll do the work and make sure your analysis and contribution
to the patch is recognized.

> I do not see any of this chatter in this email thread on the bug report h=
ttps://gitlab.com/qemu-project/qemu/-/issues/249

Yeah, that happens - the discussion in the bug report often focuses
more on what the bug is than how to fix it. I had looked at the patch
and came to roughly the same conclusion as Richard, though he beat me
to answering.

More precisely:

- the main issue with your patch is that it only affects IRETQ and I
think (going from memory) RETFQ. All IRET and RETF operations should
use the CPL for the access.

- a secondary issue with the patch is that you can use the *_data
variant for both CPL0 and CPL3 accesses.

- it's a good idea to also solve the related issue, that interrupts
should use a data access for the DPL of the interrupt/call gate. That
one cannot use *_data, so there are two alternatives: using an if like
you did, or using the *_mmuidx variant with the MMU index computed in
advance.

Yet another related issue (going back to *really* legacy stuff) is
that call gates need to use *_data when reading the parameters from
the stack, so that it's possible to use call gates from CPL3 to CPL0
with CR4.SMAP=3D1.

Paolo


