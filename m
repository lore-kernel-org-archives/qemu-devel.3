Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41521C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPF4B-0006se-63; Thu, 04 Jul 2024 01:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPF4A-0006sM-86
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 01:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPF48-0000dz-MS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 01:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720071091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJs5D/YEQU/uOIEPQnbJW0N706P0dOcexPyILktT0zY=;
 b=AlEHci0W/XzWNoEY19yb/sBb86bJqcGVP4gHbD7tIDJtcWf9qspxBotKdM2BMZRwlWTIhD
 FvAQhKNR81aJU/gTGcX2Njacgv5L66S1IeFpyBPh/OGBYilQ1JCFSAbaRd3lWHI0gsscpT
 toRc9cgikFRjRKbh5wRMw9n99xH7jYg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-7Nr3nwxcPh6gsPn2CJmiKg-1; Thu, 04 Jul 2024 01:31:24 -0400
X-MC-Unique: 7Nr3nwxcPh6gsPn2CJmiKg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36793b39ee5so207059f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 22:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720071083; x=1720675883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJs5D/YEQU/uOIEPQnbJW0N706P0dOcexPyILktT0zY=;
 b=sG6uhK86hW2kxQI4D6p/RQg0vSn8+AE3NNTjT0WGAUmPDvG7RUIEaqX/Argzwj06a/
 XKvePQQa1ltGDBBljDiWOqmztD5v0B5N9YFgJIEgiPEbjyE/s0tdTIdjjYkaeWqMUQoW
 c/oJ+LXTgYu47DKlWcainIPmhJ639UCwwRGkCZwEsLTVkgX9XfUOFXRPWT3W1tJeCg6P
 jXAnzbzKuIWb7HtmIZzErjieSlIKvasasLgTBS4VUYqt1RBMlEPuwM1ru7njqQtIGIVc
 mX5EDhFwmFNcavC/qt/ZQMUFuL7ZzwwL+Wz0CPlvpTvDgHoT3re58oCilZIXgdQP00CG
 i8bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpF8ZdUJlZt12H78oZzRIKh2yCJBRB66C0uymYwQZheqQluE751C+KcrpFynD70qLltu0u5X28Q5w6842Szrd8MKLWay8=
X-Gm-Message-State: AOJu0Yznf9Y49X0QPFXgnJLiHuXYJf3pQfu/25dijtZcZWGFiXNPvuRo
 dHRHEHgYoFRo+T/E2M1nTtM8RUkLy8za5S7geiRITfLhcSWHwVgD7A8gnuIVRXy8XCl35IEQGNC
 GLMwA4gz3NsNC3R6hj7VEunxJ6JNAFfMhQxbd7p030+56W4H5tBW09PHir/M+hHZEMbjCRr8Yir
 6XL6WuBrKuvi5DQ/HrFUoSRgGtMMA=
X-Received: by 2002:adf:fe09:0:b0:367:938c:29cf with SMTP id
 ffacd0b85a97d-3679dd7bb2amr388192f8f.71.1720071083647; 
 Wed, 03 Jul 2024 22:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN4qOO4AVJX2ozxtZrxzLOJCfNwh8Tfcnyl4JAnING0I6YDodUrCDRYotHu9FIOMH4U6gp+LyKJQAIqfi1wwI=
X-Received: by 2002:adf:fe09:0:b0:367:938c:29cf with SMTP id
 ffacd0b85a97d-3679dd7bb2amr388175f8f.71.1720071083285; Wed, 03 Jul 2024
 22:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-21-pankaj.gupta@amd.com>
 <ce80850a-fbd1-4e14-8107-47c7423fa204@intel.com>
 <20240704003406.6tduun5n25kgtojf@amd.com>
 <213b9762-205e-4d48-b7f7-1948d0f3b0d9@intel.com>
In-Reply-To: <213b9762-205e-4d48-b7f7-1948d0f3b0d9@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Jul 2024 07:31:08 +0200
Message-ID: <CABgObfaBa854ugUOHA0GUsfS7M=_XqkaPkAoYHVtwRY-0A0pPw@mail.gmail.com>
Subject: Re: [PATCH v4 20/31] i386/sev: Add support for SNP CPUID validation
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Michael Roth <michael.roth@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, 
 brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 4, 2024 at 6:10=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> wr=
ote:
> > So there are specific ranges that are checked, mainly ones where there
> > is potential for guests to misbehave if they are being lied to. But
> > hypervisor-ranges are paravirtual in a sense so there's no assumptions
> > being made about what the underlying hardware is doing, so the checks
> > are needed as much in those cases.
>
> I'm a little confused. Per your reference above, hypervisor-ranges is
> unchecked because it's not in the standard range nor the extended range.
>
> And your last sentence said "so the checks are needed as much in those
> cases". So how does hypervisor-ranges get checked?

I think "not" is missing in the sentence.

Paolo


