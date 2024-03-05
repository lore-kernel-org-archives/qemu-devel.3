Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8F6C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTJQ-0003AE-0W; Tue, 05 Mar 2024 06:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhTJM-00039g-Gy
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhTJL-00056V-1V
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709639418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2LuSik9203QIGgmA5TyUdWDRCdwOfrnAefEvJn5ZKw=;
 b=MG+LOWF0tUCdioVOCPci12GE/dpfiPa506w9PLs/Ffa+v+DmXaQt+oWWQQlSFkMRwu18eF
 yJbUybdKVbR/PCrDQh2c2pQykitqHxbjQ9ct/8Hc1zE4Hoc2ysq7OGlt1/+PzzcfbDi4Lp
 tQ4LctaavEMhFyMSU838S90rdrkqOrg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-G0FkQWt_MPqj_OXfFsh4Kw-1; Tue, 05 Mar 2024 06:50:17 -0500
X-MC-Unique: G0FkQWt_MPqj_OXfFsh4Kw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5131aa087beso4289326e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709639415; x=1710244215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2LuSik9203QIGgmA5TyUdWDRCdwOfrnAefEvJn5ZKw=;
 b=Rzve8aaFzyKtgUDmxdWfZhvBKKLnW0yPp8rXQnXbiFegU/kzaAmQ/IRtEXW0qQEGlI
 uV3ofHDHgG0fXZ1sNhh+2dVaLj/kXaQzAI59gtqmWRfyAH0/5u9aM0vPc1a4RYl59zLY
 bEilAOOfEurXy4Pu7cIoIStcktgu/zLCDZwFOpSCaPWHjB88H5PXtJC5KKgSfWlUGTKp
 ACqkztbLw7i1yupj3rWi/r+n7eRkDM5FwJAW0gWoHsXU+Wai3QaL/ydDoajfR5os3vUV
 hasF2AyyRY3kGZ20gApORFg84p/kjn7BgWYkVC4ltQzNVYMr/YKf7NfwhxuhEcleTie2
 quEQ==
X-Gm-Message-State: AOJu0YzRJ3noELCyOPqQz444vzfBeMz8BZ8vu0AKBfdTxK2+xGQb7A1P
 S7NrdQcPoyU5yyYw4wxyAZFPYpR6vp5nYKxSrCg7+nV6leH2CjSgmEXO3iualGrnifZpnA1oiny
 Z8gVvNIEHDtoMJ3aK9RjTqRWpUEDc3IM4R49j/J0oyc/ULE12UnP+71xDReIgtwU42zHbnGJ1JL
 lFv2nBUTGzSzk16sFja5UzfwQQvrE=
X-Received: by 2002:ac2:434d:0:b0:512:fd2a:872e with SMTP id
 o13-20020ac2434d000000b00512fd2a872emr1030450lfl.18.1709639415570; 
 Tue, 05 Mar 2024 03:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/+0gdvefekpEL+6+PmYmxmHA+b0Vx7cYP3fJPUX+6kBXUEU/HIqxfTE6rIzJg8pdQ2zdLuAOqBV1Gi83MKxQ=
X-Received: by 2002:ac2:434d:0:b0:512:fd2a:872e with SMTP id
 o13-20020ac2434d000000b00512fd2a872emr1030446lfl.18.1709639415193; Tue, 05
 Mar 2024 03:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20240304220631.943130-1-pbonzini@redhat.com>
 <20240304220631.943130-3-pbonzini@redhat.com>
 <ZebdY6NqEue0Rl3q@redhat.com>
In-Reply-To: <ZebdY6NqEue0Rl3q@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Mar 2024 12:50:02 +0100
Message-ID: <CABgObfY6Zc2A7gbGY4y4SL6Ca_7n4f6NgJmE01hfC=nfUcoTzg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] gitlab-ci: add manual job to run Coverity
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 5, 2024 at 9:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> > +    - 'scripts/coverity-scan/run-coverity-scan --update-tools-only > u=
pdate-tools.log 2>&1 || cat update-tools.log'
>
> Slightly shorter as:
>
>   .....   2>&1 | tee update-tools.log

Note that stdout/stderr are only dumped if the download fails, so tee
cannot be used.

> > +    - 'scripts/coverity-scan/run-coverity-scan --no-update-tools'
> > +  rules:
> > +    - if: '$COVERITY_TOKEN =3D=3D null'
> > +      when: never
> > +    - if: '$COVERITY_EMAIL =3D=3D null'
> > +      when: never
> > +    # Never included on upstream pipelines, except for schedules
> > +    - if: '$CI_PROJECT_NAMESPACE =3D=3D $QEMU_CI_UPSTREAM && $CI_PIPEL=
INE_SOURCE =3D=3D "schedule" && $CI_COMMIT_REF_NAME =3D=3D $CI_DEFAULT_BRAN=
CH'
> > +      when: on_success
> > +    - if: '$CI_PROJECT_NAMESPACE =3D=3D $QEMU_CI_UPSTREAM'
> > +      when: never
> > +    # Forks don't get any pipeline unless QEMU_CI=3D1 or QEMU_CI=3D2 i=
s set
> > +    - if: '$QEMU_CI !=3D "1" && $QEMU_CI !=3D "2"'
> > +      when: never
> > +    # Always manual on forks even if $QEMU_CI =3D=3D "2"
> > +    - when: manual
> > --
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks! There will be a few small changes after I actually tested this
on a schedule, but nothing major.

Paolo


