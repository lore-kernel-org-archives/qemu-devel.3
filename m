Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C949C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtHQ-0001vV-7o; Thu, 25 Jul 2024 03:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtHM-0001uG-D8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtHJ-0005Ve-Mn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721893961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tka8ETjbdxZ6csf0UKM8VZCFpTJCGKUcpgiFSXFuGV4=;
 b=BRm8Yiuop4Uj1a4Zm/Mr6vmDz8LoT66jVrbTDbLQGDUxih953R1N/XHbi4/UMYExbDgl6D
 kP60OsvLSeTGfB8JLV/aOvj7OvhiRqfYQQl5gGYBCfqjPHT7VpHha3DL8XopeiPtq4h7I1
 xbFAvxSVroQ7NuXD+RVrABx+MbXSxo0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Ho4AWkDZPu2mC-bl_RRMQA-1; Thu, 25 Jul 2024 03:52:38 -0400
X-MC-Unique: Ho4AWkDZPu2mC-bl_RRMQA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4266d0183feso4811105e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 00:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721893957; x=1722498757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tka8ETjbdxZ6csf0UKM8VZCFpTJCGKUcpgiFSXFuGV4=;
 b=M46/zp12NMJXY5geiL7HmrwogsRLH63eCyDa9tc8tyrLjXct9iSKc4RFPIQwNm63Mk
 hTuLUTDZmDEzagAdJfcow/7DKiGYLEi6YTE2CtAboviBu7ObnMmbc8vCRh0buGlXSjsZ
 I1GW0GSlmNb6vLm5wcz+2WvPcqwOtI/IeDKZjDvpTX4dhabBDv19RP4q4bboXsbZG+I0
 SDG1jrhbXWijrdwSgUCidcBjZKjf2TrAdg++PQHX2sm1EwZJjnXe7ejnqYnoBeabWhne
 +3QhV+//hpdd0kcGs7jsBD1y0U9UA7tde8o4WrHiRCoygobkdus3IJzPSRnADcEC0b35
 Kxng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYjAdxBqQFNIqkrABm+Ye2TD7kGX6LTKqSr0m/GRWYgUYcCM1n+yGtp3aOf+K9gP8jx+xMeOm3mE4GtV4eHJpa4zxLkFg=
X-Gm-Message-State: AOJu0YyUeLp/PSRUs1KXfqRYrYSytf+tRx7mG/rCI6fG7A3GyUEAy6pT
 XpGfLGf/Welx4MP4YaiYY5KNop4AOu6ebVXZieaOjreQuY+Xvx+/Xz5jX/yyD0itPl7CG05suk6
 maADhpFRwdoYlkdVjiGUNxX/iqyTSHvYpbc9qQ6fGSmf0Fgji3JXZ
X-Received: by 2002:a05:600c:4514:b0:426:6eb9:2643 with SMTP id
 5b1f17b1804b1-42805704459mr8814305e9.11.1721893956818; 
 Thu, 25 Jul 2024 00:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkm3f6tABm21TOSoI9wzrmq1lPinX1bINQ5H/a0dQHHHLnvB3yG+Ty9jPgQ+KE/6o8sGh6eQ==
X-Received: by 2002:a05:600c:4514:b0:426:6eb9:2643 with SMTP id
 5b1f17b1804b1-42805704459mr8814085e9.11.1721893956454; 
 Thu, 25 Jul 2024 00:52:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057a6368sm21435015e9.38.2024.07.25.00.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 00:52:35 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:52:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Song Gao
 <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
Message-ID: <20240725095234.0bcf00ef@imammedo.users.ipa.redhat.com>
In-Reply-To: <d331a79a-0b4e-4146-ea9c-16e3a36e55cf@loongson.cn>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <002b6625-9fed-beeb-700c-93438023d873@loongson.cn>
 <ac2dbd67-97f7-4748-b545-3d05cb1d9a36@app.fastmail.com>
 <b1aacf5a-382f-99fc-9901-fdbce07c8381@loongson.cn>
 <ZmxNx81Hr9u53_Hs@redhat.com>
 <d331a79a-0b4e-4146-ea9c-16e3a36e55cf@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

On Sat, 15 Jun 2024 09:45:48 +0800
maobibo <maobibo@loongson.cn> wrote:

> On 2024/6/14 =E4=B8=8B=E5=8D=8810:03, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Jun 14, 2024 at 01:17:39PM +0800, maobibo wrote: =20
> >>
> >>
> >> On 2024/6/14 =E4=B8=8B=E5=8D=8812:27, Jiaxun Yang wrote: =20
> >>>
> >>>
> >>> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=
=8A=E5=8D=884:32=EF=BC=8Cmaobibo=E5=86=99=E9=81=93=EF=BC=9A =20
> >>>> It is interesting.
> >>>>
> >>>> How to wakeup VM if it sleeps in S3/S4, from emulated keyboard or
> >>>> ethernet magic packet or qemu monitor command in background? =20
> >>>
> >>> Hi Bibo,
> >>>
> >>> The best way to wake the guest is system_wakeup command in monitor. =
=20
> >> Ok, I see.
> >>
> >> It is useful and it can be used to test S3/S4 in TCG mode at least.
> >>
> >> Can we add feature capability, enabled in TCG mode, disabled in KVM mo=
de by
> >> default? If vm deploys in cloud, users in general help it is power-on
> >> always. =20
> >=20
> > Please avoid creating differing defaults between TCG and KVM where
> > practical. =20
> There is bad experience for me, remote VM suddenly freezes and all=20
> network connection are lost if virt-machine does not support S3/S4 on=20
> LoongArch machines.
>=20
> However it does not happen on x86 machine, how does x86 KVM VM machine=20
> stop this?

S3 support in linux was rather unreliable (that's the reason why RHEL
disables it downstream even for x86), it might be even more so for
LoongArch machines.

The best approach would be to find the actual reason why your guest
freezes in KVM mode. (it might be be a bug on qemu/kvm side or
a guest bug that needs fixing)

> Regards
> Bibo Mao
> >=20
> > With regards,
> > Daniel
> >  =20
>=20


