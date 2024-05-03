Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86630C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2t7T-0000mc-Oo; Fri, 03 May 2024 09:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2t7O-0000lu-Qa
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2t7M-0006MR-U3
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714743507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnRGLphLEwX5zXF60XHDCUiljjhSH/yzXZq+JHKh1SQ=;
 b=h4m1G0ziUAdzxufC5L/6akJKyYolPpc35UiJwf7Kr6uRUQ2WUw2Ih9ZnQkkN68U7fNLUMx
 1/65vGUhEDFckKmo//LPibOSo1CQKfltAsGCQfCtSYlZHbJFHqT/AFaC/VCgf+pyCxRH2v
 jbzGINa7JONB1sGJT2GfdvdNOGrKXqk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-hQ4g4LPhMpao6uzqzzjlKQ-1; Fri, 03 May 2024 09:38:25 -0400
X-MC-Unique: hQ4g4LPhMpao6uzqzzjlKQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51acf60fd95so7043506e87.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714743504; x=1715348304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnRGLphLEwX5zXF60XHDCUiljjhSH/yzXZq+JHKh1SQ=;
 b=X1Of3BNOVdcoLU4Cw91eva4L99qX3beq5OyMoPrxex5alEXgXDBiIU/QO9HKnFM1yr
 Xg77cILwxPhM+2uN90MS81U0+25OExc+VluPvCm22SEYsy0nxvfIZuHkMpzib/N4feGE
 Tr9yJ/UROlQi9/mu7Ihu+W/y9jTZEOfEyzGRNodCPOINRxJCMr8e4DzUeTrptvXhtt9Z
 ykyQNC12NrbOUl2iOgB59pwl7/5XAo+li6wYWDWC/nuhR7rV4k8cWCns/yOJB5G/N+Vn
 YJWFW5h1M3c0EckXSJ6BpqeikptjV+apLYjnzyfHNl9YxNCj3feQb9NWHHVQgGBMbUm2
 BzWQ==
X-Gm-Message-State: AOJu0YxZjoSneqTyw1OzFAWl8kTNYsupxeY24YJx6ACCMtRfQR97+VeH
 IFN3z7l6CaOufe1ufuyIHOD8SACnmsoLo6Wk7Z8TIrmFTV0SPQaDTOTN0w3+cy5+1iUW3VO3M0L
 Mq6hQ+Ni9MxopCJr+mb/mNLqeeHx74bICiqDaaelUG5Avl5BkM3m5gwRXtR1UeFP/fdcCTFFfic
 Yy1JWmdReYzyGX0S6KpwH+2OI2uAU=
X-Received: by 2002:a05:6512:71:b0:51e:f177:a1db with SMTP id
 i17-20020a056512007100b0051ef177a1dbmr1683779lfo.57.1714743504138; 
 Fri, 03 May 2024 06:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFk3coB5uzi3hfKqhsQ/3xPhIImsGEsEDvBqtjcmsmaXJDKvT1/NXhF9v9AEuF75E/XPSdHXIeucKjGYwKLws=
X-Received: by 2002:a05:6512:71:b0:51e:f177:a1db with SMTP id
 i17-20020a056512007100b0051ef177a1dbmr1683764lfo.57.1714743503701; Fri, 03
 May 2024 06:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240503121509.219567-1-pbonzini@redhat.com>
 <ZjTYlDXkLXNtGgGR@redhat.com>
In-Reply-To: <ZjTYlDXkLXNtGgGR@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 3 May 2024 15:37:00 +0200
Message-ID: <CABgObfaAvfAn9Lfrv2ie11hUwjo1ctcaWydXnu=48qP1UuohRw@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: adjust msys2-64bit to be able to run qtest
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On Fri, May 3, 2024 at 2:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> We have compile coverage of x86_64-softmmu on the cross-win64 mingw
> job. So we're not loosing any compile coverage in aggregate with
> this change, in fact we improve it by compiling sparc here.
>
> The msys2-64bit job currently takes 50mins wallclock just to compile
> and run unit tests though, which is quite long already.
>
> What's the new running time when you enable qtest too ?

It's very variable. The run I did to test it
(https://gitlab.com/bonzini/qemu/-/jobs/6773108916) took 80 minutes,
but it seemed to be a slow one. Yesterday afternoon I had a run that
took 80 minutes and failed the build (so it didn't run "make check" at
all).

There are just a dozen qtests that run, the useful part is checking
that you can run qtests at all under Windows.

Paolo


