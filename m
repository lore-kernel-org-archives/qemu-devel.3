Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBF7D15DA0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tWg-0005Eu-9c; Mon, 21 Oct 2024 10:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2tWZ-00058d-7j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2tWW-00008R-UH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729521401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iat23E9BK4y0LDSuZNzsEB6dDPDorXPdTce6kZ++ACw=;
 b=PHHshb1b+Bov6PBb1zFoTswLnaRQM1YKu0mXslHR0QyDU52hg+8+vtLF1ygXgmwbS0MUtF
 yW/C/WCo/BrxxRGrhiizJN7+9dsRmcASC1hMaFvjOsE53wG0MUMUJffQPrm5WAdTdFXB+Q
 Njv7Ffk3nfxBcjZG5NOqQlJteFHwrMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610--ZHyIK6KOCOBqS5M1gQAqQ-1; Mon, 21 Oct 2024 10:36:40 -0400
X-MC-Unique: -ZHyIK6KOCOBqS5M1gQAqQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d589138a9so2503103f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729521399; x=1730126199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iat23E9BK4y0LDSuZNzsEB6dDPDorXPdTce6kZ++ACw=;
 b=LATs/axZrEwhygr7o+r1zw3nUALUbCPXnOcYem6D92lAVSh4wocXc4kVtfEmz9hmxV
 wNS9K0iU8IbJnSXOsetj8w8UPCqbT14MzYNOyvE4EZlULrDCphAX+WVsYJ1GorT+pMgk
 qu7dtacSrokdqdwaY35ly4ai36AlQx8xdDaTKcwtZopw5Gl3sfSs2WKxENWosRdw3Qa4
 E7UPbuEpN6CEbnIPVG4TWsLvlXAK9nsTdjo8AitJr7QccUsNkr21DI//o0cST5DbdghH
 SK1da8qmHkVDzmbOdrCxY9v/xCKIUy06dNEv1yo/VLZ0HUMSpEyQ9mQo6V9usj8p5OSZ
 /p+Q==
X-Gm-Message-State: AOJu0Yx39Cxmmh0vbqug3Bq//843AgMCrd9xMkVPLDWon+LWhldnRhqa
 EPt9nTq9+KYRwyLnQlgsWpXuMk5UhejQJinFovZ/BfCAfSOUMYZF1ONFuhQUfv6FtXRBxVnTe0J
 Uadhlwj+DlzBeVqjsR7HRueq5wLmIxeVZBytPyGmaXYEXE+ESXjhbA48czZP/iKgiqkaUOIx1Rc
 JOtSvcovXfo8EWcja/Nq7tIwVu7GbSpsnSJ8et5g==
X-Received: by 2002:a05:600c:8719:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-431616331ddmr86372175e9.7.1729521398936; 
 Mon, 21 Oct 2024 07:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoQmADG2o7JQhKkaiteDt0guFpgEc+sbzhWV+fI2E8+tisbKeti42nsyutKX8nV/+RFFAYE/l8Y1PjuzfKAXo=
X-Received: by 2002:a05:600c:8719:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-431616331ddmr86372045e9.7.1729521398589; Mon, 21 Oct 2024
 07:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-9-pbonzini@redhat.com>
 <ZxZqcuYx16BVXMK1@intel.com>
In-Reply-To: <ZxZqcuYx16BVXMK1@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 16:36:24 +0200
Message-ID: <CABgObfZzG92rj0vNuQMEKPmxQ+U+Yyuak6gMaNSmf4Jcex6Xug@mail.gmail.com>
Subject: Re: [PATCH 08/16] rust: build tests for the qemu_api crate
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

On Mon, Oct 21, 2024 at 4:35=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> On Tue, Oct 15, 2024 at 03:17:26PM +0200, Paolo Bonzini wrote:
> > Date: Tue, 15 Oct 2024 15:17:26 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 08/16] rust: build tests for the qemu_api crate
> > X-Mailer: git-send-email 2.46.2
> >
> > Fix some bitrot in tests.rs, and allow the unit tests to be run via
> > "meson test".
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/qemu-api/meson.build  | 3 +++
> >  rust/qemu-api/src/tests.rs | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
>
> Codes look good to me,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Note that, in the extracted series (to which I am moving your
Reviewed-by tags, so no need to go through it again), I'm changing
this to an integration test and making it actually create the object
it defines.

Paolo


