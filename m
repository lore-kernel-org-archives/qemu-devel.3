Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DE5C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbkQm-0001Hn-13; Wed, 07 Aug 2024 13:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbkQX-0001Gg-P7
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbkQW-0005Jc-0F
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723051576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5QV4+iopPwY0m4DyFRDxo2bCkauQC1irFXatbAdCSc=;
 b=N+akD2lFoQDJlM0ZhoKXXIKh69GhszAMLwTH9asZxBkVm7QZ6wUq/kj1kjn0rr8nc8OP7x
 2vybGEdegsib9TDnowSmvrm18XxA7C/fD/lA1Ynb+M2keyps81ywAQ+jkR2B45z6LLJsgC
 cq7z8we+QhVdMyzfXNDmx2MnH+HOhws=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-f3aqpw7nPV-5m92VzW6fmQ-1; Wed, 07 Aug 2024 13:26:14 -0400
X-MC-Unique: f3aqpw7nPV-5m92VzW6fmQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-64c3f08ca52so1585677b3.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 10:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723051574; x=1723656374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5QV4+iopPwY0m4DyFRDxo2bCkauQC1irFXatbAdCSc=;
 b=EUYMKuJUe/GVqeK3klwnnBN2yh4GSoKu3CjdN2V6h55W+U4hYHAZqQ0euN2/+mPSoD
 sLXrqCCjXL1MobqeEwbHpMBvFE3rHZe6XPETGbs/u3XIBJVFzpxXuptn9AAruYqNwBrD
 YqWjiurcZkakIUvtRyrQ173p5MpFZJ7xmvz3+8nUXPPcUe7yK9aq2Y1pn849yNwKWTen
 Ja8WU5w35QF38uJhH3EFh3nUkZ5QpjovTuncAGTpgxC18ADP2+hQvhr9Nqo/oN8OgzfL
 6htGxFl4Gk91as2jo6RlSCD+2HwfImXB9u7OJLHFuxHITjlQqVN9aHbKwW00O4Ry6yzg
 YcbA==
X-Gm-Message-State: AOJu0YyOrR8muRUommDtuIPK5abZmM4CG+rZxFmbb5Ygh76zwCTzQnMk
 UyxtCXkqBqSzysMCWgcqHSFJKyNOrZ+gO7CcgvUtCna5pfBz35UdPj+AwDed+sS40bC/XwTFvD8
 9ktZBC95HmPLss4cDJT3VH0iwCrNYUvPcMeDxil2KCU7BfFHTHHUr+szvCAE7TJAeC0B1h9j2mw
 8pir7V+xrWsKBJimNxwa/r/WxCTlc=
X-Received: by 2002:a05:690c:2910:b0:632:77ca:dafd with SMTP id
 00721157ae682-6994e688610mr28408437b3.10.1723051574403; 
 Wed, 07 Aug 2024 10:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzODDu5SuLmPC3x0D9XfVYRIqe/hUT4RhAAbLaRi+yjfrc7hm5AZ2wB3etv3qjrV+Oivcb6giYGkElvoa+ze4=
X-Received: by 2002:a05:690c:2910:b0:632:77ca:dafd with SMTP id
 00721157ae682-6994e688610mr28408047b3.10.1723051574034; Wed, 07 Aug 2024
 10:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-9-crosa@redhat.com>
 <fff8c0f4-881a-4317-857a-0d20a72484eb@linaro.org>
In-Reply-To: <fff8c0f4-881a-4317-857a-0d20a72484eb@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 7 Aug 2024 13:26:01 -0400
Message-ID: <CA+bd_6+-9Mqu-qmRowXhRUSVZenY6dugVE+no15coxbCot1Lkg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] tests/avocado/machine_aarch64_sbsaref.py: allow
 for rw usage of image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, 
 Troy Lee <leetroy@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Beraldo Leal <bleal@redhat.com>, kvm@vger.kernel.org,
 Joel Stanley <joel@jms.id.au>, 
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paul Durrant <paul@xen.org>, Eric Auger <eric.auger@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 6, 2024 at 3:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 6/8/24 19:31, Cleber Rosa wrote:
> > When the OpenBSD based tests are run in parallel, the previously
> > single instance of the image would become corrupt.  Let's give each
> > test its own snapshot.
> >
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ?

Yes, sorry about missing that.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Thanks for the review.

Regards,
- Cleber


