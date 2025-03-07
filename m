Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F83C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqYoN-0003Fi-2w; Fri, 07 Mar 2025 09:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqYoL-0003F3-8U
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqYoJ-0007bj-N9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741358178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ9CYuJv1fQ7i/4GVoO3JvzYbjxZVldMDGg+EMRQHR0=;
 b=NWTkeWeQtQVTaDz/gV08U/eYlFR2r2aVCHtRmW/HnvTpcxDRCk12wxi0NdoYUcPxLWnTOI
 l6pW77LDOmQ/nkiQOUPNWAZx8qa1TU8LwqxQFnrS5X/mH+my6L+EvlsqZRpovtRbOtnF1r
 7oj06kTxGMDqFKVPqu0UjZxq+Gvr2T0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-SJYzWxjmOuCiOt5ZiJDuGA-1; Fri, 07 Mar 2025 09:36:17 -0500
X-MC-Unique: SJYzWxjmOuCiOt5ZiJDuGA-1
X-Mimecast-MFC-AGG-ID: SJYzWxjmOuCiOt5ZiJDuGA_1741358176
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390ee05e2ceso1346742f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 06:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741358176; x=1741962976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJ9CYuJv1fQ7i/4GVoO3JvzYbjxZVldMDGg+EMRQHR0=;
 b=u+Tz8tz7VuZy9dBtReuQ4oe91RBDHIXhG6L+zDNMu+V27PfH42Aa/Mfdn3NSxwrQLy
 4q/Uiw/QnOpH2CL//HdwhJY3GrJzcPT6E292KEAKK7Im7XYMCSWX08G7ylBkEXrwNVvz
 muF+cXLb/HOkV9B3xpA9MbUCBIzjwZb/Z9qtieR4WMln4AQK9nW62tfs/C8XyS7S519y
 xI+ba9yKnVgJ57B38A5og1pX9Z5Eal2I385ck6GIofzX3cPOSv9z1hq5IGVPwWR2d5Rb
 DgKXk/evUeVHNNhFpzkdilmnXNIcoF3hYruMWb2zxKgRWbfu+1lL4K1NHT7rDFSS5Acd
 uebg==
X-Gm-Message-State: AOJu0Ywto7lmdZkPnTlLG/pilAttgRKEVX0FumM5n5qUSKUvYRphYFzY
 iTczxKjcvdYChX3uVtdnOWnqqLT2mayhIt7a+g9xVVdYc2a508NmaorQnN+ELLNZro59HheA4bK
 R2bic4ntk3SjtKmIapjvR1VFjhV9kLCu/fJx6xTkqiXBFRdLlL0Q52Oo+E44mXtsX1nOIIVToah
 fegvgbxEEzFVaKaFFvbqErOuN5PjQ=
X-Gm-Gg: ASbGncuPGJWQhbTKGMC+rm1m29wvgVOKfqgv2FFP18MEVLN283muxv9Cq4PpTmcLfcB
 MkDpBMMnxPjvGk/VbCEpyVLiS5m1/e8DhR5mun98zsux0xVilrGD0KIRIBMnbtTaSDlyn+EqosA
 ==
X-Received: by 2002:a5d:6d09:0:b0:38f:4fa6:68df with SMTP id
 ffacd0b85a97d-39132dbca7amr2842428f8f.51.1741358175456; 
 Fri, 07 Mar 2025 06:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9YOkD9R3kL/03jmv+SwbOdXtWVMGXMk1JvNctTvQ+oX0xDvJvox3JMYWPws9nQFVdLbWT4od4AtMUfr4TQp4=
X-Received: by 2002:a5d:6d09:0:b0:38f:4fa6:68df with SMTP id
 ffacd0b85a97d-39132dbca7amr2842406f8f.51.1741358175150; Fri, 07 Mar 2025
 06:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20250306161631.2477685-1-alex.bennee@linaro.org>
In-Reply-To: <20250306161631.2477685-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Mar 2025 15:36:01 +0100
X-Gm-Features: AQ5f1JqotSwpM7T-QSu9j6AQXc9CYYWDmUedzOdXJgR8TGnPN76H6acktX7AjCY
Message-ID: <CABgObfbcTqr7LNDumDXo7wXf=WigZ2U0Kwv97NRFAHgPoCQ8WQ@mail.gmail.com>
Subject: Re: [PATCH v3] meson.build: default to -gsplit-dwarf for debug info
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Mar 6, 2025 at 5:16=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
> +if get_option('debug')
> +  qemu_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g'=
]
> +endif

Since -g is already added by meson, it's enough to do

-if get_option('debug')
-  qemu_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g']
+if get_option('debug') and get_option('split_debug')
+  qemu_cflags +=3D '-gsplit-dwarf'
 endif

Applied with this change, then.

Paolo


