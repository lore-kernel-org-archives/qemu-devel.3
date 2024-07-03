Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7B7C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP2WQ-00067w-TI; Wed, 03 Jul 2024 12:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sP2WP-00066O-EX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sP2WN-0007cc-Jw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720022870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsxnJALMMzgg5cI1/sgKz0n1A6s0eNcUYOZrO7tY/u8=;
 b=TK/O27vEt0Dy2DEXbj5UkBQT/fVdc7PFIKtDRoP8RJ+fLYMB8qbUD5B4hX22yG8eaBQfSK
 vDlf+JGjUcWmFN22f0Ezkd9XnL6d14MooE/1JBpvYhwLGRYc446Xxy/DdSQuRo0ga9AbS+
 O6P09DkjM5ROLtrBLKzihYMHBBzzZEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-LnukBp42M5WpWph4wgRDJg-1; Wed, 03 Jul 2024 12:07:48 -0400
X-MC-Unique: LnukBp42M5WpWph4wgRDJg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42566c4aa0fso44250115e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720022867; x=1720627667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsxnJALMMzgg5cI1/sgKz0n1A6s0eNcUYOZrO7tY/u8=;
 b=QEcOPrMyMGwVuw++ef2FZwGT65fnQYGiWOrJ301TeEVhq/vMLM/Kgn2ziNcIAlFePj
 KWeOPwaHZJgElwJaaoGSRQLQbMiGJ6Q+uGrUqk03HAsuflzLUqies1pRtMd78YAVUh0Z
 rlMpdvR1NFjpA8lmNkvTEDJD6R/iosIiVqfwcVcacA+rPO/N5bgkhqEm7twmPS/3DQM5
 upYIp3aFdFJJXa2C0xoJ3R9uW0PtqM4+1S/RscLMDv1YKS71B0FOxFtHrK6LpBJ2Tc92
 jv4MGFRkcHmhFFBVBbodMpiOPB1fmc50fD47Eu3X54Cf043rC9v3H0j4nVrQ/HcMprL9
 JUyw==
X-Gm-Message-State: AOJu0Yz8zxKgbMinhP2ZVgGoastuT+6vr5C7QakdlbXreH911fyp6eGm
 buR2zgWI+cFWuRgjavnFk8r5O7X96gvG6sykdmJhBrk36xUBMVJ++MJSLhRc1U2Kp51l5QG2cMW
 ZBFpW5vfws+zPn38MdRSBCWAm/+q8eDNQoGU4Qj6V1R4eXIRmBRlY8y5mr8ZF3Oa6R8MCq73cDF
 V09Ah4E6iigEmCdXJ46O0d8ihfTwU=
X-Received: by 2002:a05:600c:491d:b0:425:6d66:e432 with SMTP id
 5b1f17b1804b1-4257a03a6c8mr80425725e9.22.1720022867532; 
 Wed, 03 Jul 2024 09:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHztmedgAI5An/BTtMox7wsPnsORt/wP4r1lqho7ZueQZv7RKlqzTs3rKhqW1gYRwjUk46KU2oBChZYqhyNVLA=
X-Received: by 2002:a05:600c:491d:b0:425:6d66:e432 with SMTP id
 5b1f17b1804b1-4257a03a6c8mr80425645e9.22.1720022867215; Wed, 03 Jul 2024
 09:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240702195903.204007-1-jsnow@redhat.com>
 <20240702195903.204007-2-jsnow@redhat.com>
 <e0302039-dade-43a7-8bdb-a96d1df76f38@redhat.com>
 <CAFn=p-Yqi5umFBPtUYj2EFiRRA2E6VTgDi=TbuwoOSTs+s9OoA@mail.gmail.com>
 <CABgObfZik_bKuZffohNO1fMss+81kTzaHPEHSPu6H2MCoJVZ=w@mail.gmail.com>
 <CAFn=p-atW1AiW8gX6nUm0DzhG4Qrf8A++vArJQhyUo2bTyPqtg@mail.gmail.com>
In-Reply-To: <CAFn=p-atW1AiW8gX6nUm0DzhG4Qrf8A++vArJQhyUo2bTyPqtg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Jul 2024 18:07:35 +0200
Message-ID: <CABgObfZ=vUJeve0wX2HafdxtwH3iFZQHWJeu+XD-MA7Wrq78dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Python: bump minimum sphinx version to 3.4.3
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
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

On Wed, Jul 3, 2024 at 5:25=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
> To be clear I mean offline, isolated RPM builds under RHEL9 where I don't=
 think we can utilize PyPI at all; and vendoring Sphinx is I think not a pr=
actical option due to the number of dependencies and non-pure Python deps.
>
> It's not a problem for developer workflow, just downstream packaging.

Agreed, switching to PyPI packages is not something that should be
done lightly---only after the platform Python is EOL, and only if
there are benefits for QEMU to require 3.9 (like there were for 3.7).

In that case, downstream could still package QEMU but they'd have to
build python39-sphinx or something like that.

Paolo

> Luckily OpenSUSE offers newer Sphinx, but RHEL doesn't yet. Maybe that ca=
n be rectified eventually - possibly after 3.8 is EOL and there is increase=
d demand for newer Python packages to be made available in RHEL... but not =
yet, today.
>
>>
>>
>> Paolo
>>
>
> Thanks for the ack O:-)


