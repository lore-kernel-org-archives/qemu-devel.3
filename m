Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA933EA8554
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 04:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSFv-0003lh-N8; Mon, 09 Mar 2026 00:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzSFu-0003jS-4J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzSFr-0003PR-3j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773030604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIPTiVy+ZY2EPH3VU5JxzyKpwVxLNryjg9Z2vc03Bzo=;
 b=BpE5zvpsX/hftL+VzkNXH4GATBdGez/PuGYqSvx9bkAmojCem7SmWWZkAmpgUvwPjubY83
 aVJrHTuI1UJptPJEAjn7kOwE4hM8Xk8qBw/JrwgniqnDWzvUmFgpQhYL9GYOYTpMzW3s2p
 0lOJdrfaSCpxOOq28+Pima1nNuW6uAQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-FKzKRLBYNp27CLZiiiwpiw-1; Mon, 09 Mar 2026 00:30:02 -0400
X-MC-Unique: FKzKRLBYNp27CLZiiiwpiw-1
X-Mimecast-MFC-AGG-ID: FKzKRLBYNp27CLZiiiwpiw_1773030601
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso10911325a91.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773030601; x=1773635401; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIPTiVy+ZY2EPH3VU5JxzyKpwVxLNryjg9Z2vc03Bzo=;
 b=NLMpMiIGlPqQ0a21U+scx0TFe2+MNGLMjK9cizFwz/XekaAzkzzubFroS3slxn7jI3
 Bgm9sn7PsSJq2z63wbEBEgvhZqfKld2FWZ8QH9zQVV9XVyxwArdHQQYDZWzB/FcryzU4
 sh1RzjkT8cu3g78afl0RL1by962d1VbVeZjAzaY4sjjvGrORFcWi7cjTvyurIethrBSd
 em6KHowI0SoulRLaZZfl9siEUuEeSQZNEQqq/Qv56MY2/dIZxnwZmxUV0ECpFEC5o9XR
 VTMKrkgSsb60xbXrh75JhAjv6XxJAajKpoLNGUUVBzm6fIX5L/v03PmK4Axj63r2zwDK
 0MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773030601; x=1773635401;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VIPTiVy+ZY2EPH3VU5JxzyKpwVxLNryjg9Z2vc03Bzo=;
 b=wj2NbkLgHTrWicRX/SOxyVgLAiaxRFeis5LHuX7huLTZMLyWa9CSLKmIEJ1xlDUUtl
 GSDfU8hqraiPIEHh4dEzuK1IUP+c4TJ8SiLIV6zIeVietNPSrQmHF88WE78peeVi4MLc
 7EmEZkEDzj6tzASciA0/DlICElocdxGn14/oocnqUr1TToMEBlN1GHBdor2dsmo5pqTk
 Ilxtywvtmi+gVeKzLWvqxLi4O9Uzqde94eP3cdIp30QK1pSvJZ40XYWic2S1is3CEUob
 IqmyXyemtVi7d7G5ZdoLmz905ZQXIfn7lps6uqmKYZA2yr3bcxBzmj09qKwr2ckpjq25
 SoDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFfC9ieUNl8vJgWlG1N6lyl66L3ufe4um4AczsFibtrd3OUGICis0p6ubwsVy874/UkJ7FS790j9nZ@nongnu.org
X-Gm-Message-State: AOJu0YytYlFJCd9YUNxUHUV/13DGvbVLufhfWOwjrQrHjqmVoKCsZYvR
 sxaqktsXsx8fvGtI94t7oq2b/hI0XVQOsm0hbvysherKoDPzETXITOkxktwf+Kz9h8j0gDLdChf
 eB2dtwMasQ/qhbXUN/PmacoKE9CeJKPwIBdw2lmnEDl9LxJWa2ObGbG5k
X-Gm-Gg: ATEYQzzz7b5c7G7qMDEFFUEmJyXU7yD+LvdNkv855iFguHHwDayb4E6goQcO1dUHjBv
 3cHv0E6KqmbJNB1iLDzRdq1tHWt8fSCRg0hyQLicG8liMEBCRS0QNkrPWrf2kZRkEd/bDu6hTby
 bXDfyn8pDCnKhPBe8WMCyD1rrg9Weagif4xWfSxzTc2rEFwIvu7bJ0OuWrJMM1pZQ5h8lRYUSWh
 QyvCBAjlwlDtsBThAN5r3S2+WDTS7zNtkGQFFhLW89WQqCRGlhFk7uFB8FGHXIwvS1b3WmkBkbf
 kCoRUu+9w8omaPRO+sgk/Rbkt5TXwuAmDJgbWy4j2a2MIL/yz+wKMNGXa9FlsTBb1Fw8rjKcmXj
 MvzXbwSaBIdKIWyrI8ezbntOdrVTw+GuKI3yvmukcYMSIjuZcz5wucpxJ05QKaMBzcfaLTA==
X-Received: by 2002:a17:90b:2b4d:b0:356:24f0:aef5 with SMTP id
 98e67ed59e1d1-359be32a997mr8673874a91.22.1773030601333; 
 Sun, 08 Mar 2026 21:30:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4d:b0:356:24f0:aef5 with SMTP id
 98e67ed59e1d1-359be32a997mr8673859a91.22.1773030600935; 
 Sun, 08 Mar 2026 21:30:00 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359b2c370e8sm13073358a91.0.2026.03.08.21.29.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Mar 2026 21:30:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aaXsj5osdbUNbttY@x1.local>
Date: Mon, 9 Mar 2026 09:59:39 +0530
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Prasad Pandit <pjp@fedoraproject.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0B34254-EB84-4D05-B5B9-BB1B52F19D58@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com> <aZ8xlrL2xQtoN9MI@x1.local>
 <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com> <aaBFxY6PUsNrAYft@x1.local>
 <83E69A6D-EDC8-4380-8C4E-6F77D1E2F078@redhat.com>
 <CAE8KmOzmk195FKCK-J6qVnj=wcDp5HC6+xhbNhturYo-Ls0egw@mail.gmail.com>
 <aaXsj5osdbUNbttY@x1.local>
To: Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 3 Mar 2026, at 1:31=E2=80=AFAM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Mon, Mar 02, 2026 at 04:58:50PM +0530, Prasad Pandit wrote:
>> Hello all,
>>=20
>> On Thu, 26 Feb 2026 at 21:46, Ani Sinha <anisinha@redhat.com> wrote:
>>>>>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
>>>>>>> Currently the code that adds a migration blocker does not check =
if the same
>>>>>>> blocker already exists. Return an EEXIST error code if there is =
an attempt to
>>>>>>> add the same migration blocker again. This way the same =
migration blocker will
>>>>>>> not get added twice.
>>>>>>=20
>>>>>> Could you help explain why it will inject two identical errors in =
the first
>>>>>> place, and why the caller cannot make sure it won't be injected =
twice?
>>>>>=20
>>>>> Likely due to a bug in the code. For example if the init function =
that
>>>>> adds the blocker is called again and the caller does not handle =
the
>>>>> second init call properly.  This came up as a part of the coco =
reset work
>>>>> where migration blockers are added in init methods. They need not =
be
>>>>> added again when init methods are again called during the reset
>>>>> process. The caller can handle it of course but adding a check =
further
>>>>> down the call stack makes things more robust.
>>>>=20
>>>> IMHO if we want to make it more robust, we shouldn't return an =
error
>>>> because the caller may not always check for errors.
>>>>=20
>>>> Would assertion suites more here?  Because migration blockers are =
not
>>>> something the user can manipulate, so it's a solid bug to fix when
>>>> triggered.
>>>=20
>>> If Prasad agrees, I will send something.
>>=20
>> * The majority of the places I see constructs like:
>> =3D=3D=3D
>>        if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
>> OR
>>        ret =3D migrate_add_blocker(&hv_no_nonarch_cs_mig_blocker, =
&local_err);
>>        if (ret < 0) {
>>            error_report_err(local_err);
>> =3D=3D=3D
>>=20
>> * So setting **errp and returning a negative value is consistent with
>> that. Aborting (assert(3)) for trying to add a duplicate blocker
>> object seems like a harsh punishment, considering that'll happen at
>> run time and the user won't be able to do much then.
>=20
> If it's a programming error, then it shouldn't happen at runtime.  The
> current paths to fail this API was not for programming errors.

I have sent a patch with an assertion added
https://mail.gnu.org/archive/html/qemu-devel/2026-03/msg02602.html


>=20
> If this patch isn't required, IMHO we can at least drop it in this =
series
> and make it separate.
>=20
> Thanks,
>=20
> --=20
> Peter Xu



