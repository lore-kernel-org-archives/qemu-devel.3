Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04F8C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 14:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl81K-0006IC-JG; Thu, 20 Feb 2025 09:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl81J-0006Hx-Gd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl81H-0004Tr-RC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740063558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SN4qPlDrZn5XXYbCNxjhCL8T0QNUvNxBf0X7ZMWVGQ=;
 b=Gdr7RWvLU8f7W2ebWP8+tSkzAQxhBc98E8mg8zWL8csPFpDe6lhv2J1b9qFc+edXlvLVyd
 YF42cjf1IF/0xIIDcaOkmK1xhnANJJABKXgqFPrI4iJnzCDzgieGOIKFXyZ3MZjXW5CqoJ
 OHITc+uPDrmgny/wzWmpFcwmEs+v09c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-0ywWUoCwOU-bFLMqpbx4Lw-1; Thu, 20 Feb 2025 09:59:16 -0500
X-MC-Unique: 0ywWUoCwOU-bFLMqpbx4Lw-1
X-Mimecast-MFC-AGG-ID: 0ywWUoCwOU-bFLMqpbx4Lw_1740063554
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb9b2831b7so210354666b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 06:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740063554; x=1740668354;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0SN4qPlDrZn5XXYbCNxjhCL8T0QNUvNxBf0X7ZMWVGQ=;
 b=QzPkDUihyCxiMHMq1HPkVmr0qqev9C9F8SNAxeHCDUkaGSv7wtNAz+J23EiIJhmHpq
 +2qBEv+VTLOpEg9ICVfqLuvBkPyhm9h/wgzGDPz9EuFaD5DiXCi8E8v3trWDDroeuMJi
 pFqz4B2mT+AK4WThOdEMPCq4JYXV073PQ0gfsh7Qc3gq0sTcTiKNekV7+CY8CMVnvErk
 gkZw4WRD7IOyVeBxweTyKS8rj4Hk4t7ePlMYb5BMeMv4OWXjggwZF5zyk/KznHlF1AgF
 PTaJzImIa8gRItpu43A3xXu3tZgalNfnmBZXRBYQG0EEeIYyEYKdK9v7ziLwXV5gFrwq
 637w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqMQViDb/JyeRJDJbIWNTWTvklQQY2dbnXKSqxWEwPRRC8ma9/R92UHpFHyHmy9gtlQ1fbeQIxwqF3@nongnu.org
X-Gm-Message-State: AOJu0Yzmg6D3G55UHJ00Fe6sa34pWjauEvP6WblH+rI/T5QcO4pehzNC
 AOYvwU+GArdaTDY0TTSL4Ia8UAaaAI9RowAmQq4IiJncJP8ndY8i0ac/2jLWLkt8Rz9GUDZIutj
 Pj3UgevpA7usx/xVlFKAH+vilBpSEzVo7tXA8odZolAp3WnQCv3H9
X-Gm-Gg: ASbGnctyRf9ePbdphqEr4V1foLG+FsazsV1VfDmrQvSJQ9r3wx/CI+yEtkcNgkHUy6c
 Pgx3sojm4OH0TS2zNOlB3/8zmLI2bHdEpWQbcGoe2EuYFAihIHdHL99XWIdoTTblNJ60Yc/cYga
 3htUuW6RQHNjWokyS/Vm6lSzcWW/lr5d3YzfrCWNHj0uOl0v18N6RlmVZ4LtNgQHTx8VG+sog2F
 LI418XrVKp4flM99RSDZpFA3MXGvH3kbp5CQMZjW7bWykVDa/IOWJ80ma3HkcOQCTGA6Q==
X-Received: by 2002:a17:907:7848:b0:abb:ec29:d40f with SMTP id
 a640c23a62f3a-abbeddfc2a0mr325340066b.13.1740063554243; 
 Thu, 20 Feb 2025 06:59:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0uPd8tIWchCqg/SYthF2Ce22c6Gr/+0KluhrrH9f4nv8h3Bmwh7YOsy2pvHoX22TdsvF2sg==
X-Received: by 2002:a17:907:7848:b0:abb:ec29:d40f with SMTP id
 a640c23a62f3a-abbeddfc2a0mr325336466b.13.1740063553782; 
 Thu, 20 Feb 2025 06:59:13 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb8209a2cbsm997538666b.133.2025.02.20.06.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 06:59:13 -0800 (PST)
Date: Thu, 20 Feb 2025 09:59:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] docs/about: Change notes on x86 machine type deprecation
 into a general one
Message-ID: <20250220095733-mutt-send-email-mst@kernel.org>
References: <20250116064644.65670-1-thuth@redhat.com>
 <ad3d06df-f0ae-4508-b979-c838b3647510@linaro.org>
 <Z4jPGGezEK3XRMl8@redhat.com> <Z4jmfnfLdsTbHRFd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4jmfnfLdsTbHRFd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 16, 2025 at 10:59:10AM +0000, Daniel P. Berrangé wrote:
> On Thu, Jan 16, 2025 at 09:19:20AM +0000, Daniel P. Berrangé wrote:
> > On Thu, Jan 16, 2025 at 09:48:50AM +0100, Philippe Mathieu-Daudé wrote:
> > > On 16/1/25 07:46, Thomas Huth wrote:
> > > > We now have a general note about versioned machine types getting
> > > > deprecated and removed at the beginning of the deprecated.rst file,
> > > > so we should also have a general note about this in removed-features.rst
> > > > (which will also apply to versioned non-x86 machine types) instead of
> > > > listing individual old machine types in the document.
> > > > 
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   docs/about/deprecated.rst       |  7 -------
> > > >   docs/about/removed-features.rst | 11 +++++------
> > > >   2 files changed, 5 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > > index 4a3c302962..7b42d6eecc 100644
> > > > --- a/docs/about/deprecated.rst
> > > > +++ b/docs/about/deprecated.rst
> > > > @@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
> > > >   better reflects the way this property affects all random data within
> > > >   the device tree blob, not just the ``kaslr-seed`` node.
> > > > -``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
> > > > -''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > > > -
> > > > -These old machine types are quite neglected nowadays and thus might have
> > > > -various pitfalls with regards to live migration. Use a newer machine type
> > > > -instead.
> > > > -
> > > >   PPC 405 ``ref405ep`` machine (since 9.1)
> > > >   ''''''''''''''''''''''''''''''''''''''''
> > > > diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> > > > index c6616ce05e..156c0c253c 100644
> > > > --- a/docs/about/removed-features.rst
> > > > +++ b/docs/about/removed-features.rst
> > > > @@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
> > > >   System emulator machines
> > > >   ------------------------
> > > > +Note: Versioned machine types that have been introduced in a QEMU version
> > > > +that has initially been released more than 6 years before are considered
> > > > +obsolete and will be removed without further notice in this document.
> > > > +Please use newer machine types instead.
> > > 
> > > This is an improvement. I still wonder if we shouldn't list them removed
> > > machines here, to help old users.
> > > 
> > >   Removed in 4.0:
> > >     - pc-0.10
> > >     - ...
> > >   Removed in 9.0:
> > >     - pc-i440fx-2.3
> > >   Remove in 10.0:
> > >     - pc-i440fx-2.4
> > >     - pc-i440fx-2.5
> > >     - pc-i440fx-2.6
> > >     - pc-q35-2.4
> > >     - pc-q35-2.5
> > >     - pc-q35-2.6
> > >     - ARM virt-2.6
> > >     ...
> > > 
> > > ?
> > 
> > A big part of the reason for the macros for machine type deprecation & then
> > skipping machine registration, was to eliminate repeated manual work that is
> > visible to users if forgotten. 
> > 
> > We still have the actual code deletion which is manual, but that's harmless
> > as even if forgotten, such that the code exists, the machine type will have
> > been entirely removed from view.
> > 
> > As such I'm pretty reluctant to suggest we create a new place which needs
> > manually updating when we remove machine types.
> > 
> > I wonder if its possible to get an auto-generated version number into the
> > documentation though ?
> 
> To answer my own question, yes with something like this:
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index 31bb9a3789..899ad13305 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -110,6 +110,22 @@
>      else:
>          version = release = "unknown version"
>  
> +bits = version.split(".")
> +major = int(bits[0])
> +minor = int(bits[1])
> +micro = int(bits[2])
> +
> +# Dev snapshot, adjust to next release version
> +if micro >= 50:
> +    micro = 0
> +    minor += 1
> +    if minor == 3:
> +        major += 1
> +        minor = 0
> +
> +ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
> +ver_machine_deletion_version = "%d.%d.%d" % (major - 6, minor, micro)
> +
>  # The language for content autogenerated by Sphinx. Refer to documentation
>  # for a list of supported languages.
>  #
> @@ -138,7 +154,18 @@
>  # environment variable is not set is for the benefit of readthedocs
>  # style document building; our Makefile always sets the variable.
>  confdir = os.getenv('CONFDIR', "/etc/qemu")
> -rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> +
> +vars = {
> +    "CONFDIR": confdir,
> +    "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
> +    "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
> +}
> +
> +rst_epilog = "".join([
> +    ".. |" + key + "| replace:: ``" + vars[key] + "``\n"
> +    for key in vars.keys()
> +])
> +
>  # We slurp in the defs.rst.inc and literally include it into rst_epilog,
>  # because Sphinx's include:: directive doesn't work with absolute paths
>  # and there isn't any one single relative path that will work for all
> 
> 
> Then....
> 
> 
> > 
> > eg, so we can have an entry in 'deprecated.rst'
> > 
> >   Versioned machine types for x86_64, i386, aarch64  <other targets here>
> >   -----------------------------------------------------------------------
> > 
> >   In accordance with our versioned machine type deprecation policy,
> >   all machine types older than 7.0.0 have been deprecated.
> 
> use   |VER_MACHINE_DEPRECATION_VERSION|  here 
> 
> > 
> > and in 'removed-features.rst'
> > 
> >   Versioned machine types for x86_64, i386, aarch64  <other targets here>
> >   -----------------------------------------------------------------------
> > 
> >   In accordance with our versioned machine type removal policy,
> >   all machine types older than 4.1.0 have been removed.
> 
> use   |VER_MACHINE_DELETION_VERSION|  here 
> 
> though, we should not add to removed-features.rst until 10.1.0 cycle
> since we don't start to do automatic deletion until then.
> 
> With regards,
> Daniel

It's been quiet. Thomas, wdyt?


