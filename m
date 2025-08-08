Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BBFC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPvS-0002TK-Sh; Fri, 08 Aug 2025 12:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ukPvM-0002Q8-UT
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ukPvK-00035l-U3
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754670389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQcg/yvq/AS8691EuiY3/B63e1mjimPVj2ylK6a0nc4=;
 b=YGTy/uP1VBV9ZGEycFkwcE2doTJ7+KzzmZIMdxRivZqAr1UL0ILOJ4Tz5d79Y0PU9m/U58
 SDI8dOsftfyJKd1tnM5MLnya6IT+psmLZMeVHNh0MJeujaNS1bKuNkcTaF+p24+6rDT4CO
 ss6oy/Xo2C4c4vhG25bN1D7KBbrxIWg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Kuel7i1GOFOF_g-xtqL7Rw-1; Fri, 08 Aug 2025 12:26:27 -0400
X-MC-Unique: Kuel7i1GOFOF_g-xtqL7Rw-1
X-Mimecast-MFC-AGG-ID: Kuel7i1GOFOF_g-xtqL7Rw_1754670387
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23fe98c50daso19367435ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754670387; x=1755275187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQcg/yvq/AS8691EuiY3/B63e1mjimPVj2ylK6a0nc4=;
 b=QfMlosYMv35q80hDTu5f5Ya4M1zSimKAvWkZVP2DP6cVJPNwKTKwd8JrNke+/GbrvO
 bBU7oC0mF1zMa5HGwZRmpRw/4QoSw/oKYQ2rUQpo/EB2N7By+PCM2KDl0YEpk1QT4ime
 2uyCkHLx84k85BneHAUEluZEG1/gMqZ5cVx7142UANLyM1s/bbwEYoqz25HnGl8lD5wR
 Qtn1/iGzdjNGIfdVc3d2rsdSirn9oOLCtc6GbyDyq4zXAsMwgDlUgAT/256BoeEsjDxf
 X4VjKowqkxLKNRW2uaNPrsocYeRDso/FLzCEWebLPpTLSWO5teUtJb7USsDEB/yc/dKu
 rDOA==
X-Gm-Message-State: AOJu0YxVH9Fy5231wjmrCt0kVpJh+qr0SdXicJc7DCv3YRMj39aJnmet
 4yTn/l9x5h/+9GFN/WhRinwVGn1DaYcHtq3d1N4xqLoY1YCRZ8Fe7Sl51AvWZUmiEMstSyyYk9e
 wt5jte1wiomNCOWQddyP3O7nClWcgbnVPfJv4QxtMVaXbcdp7I/nAnse5BBivj+KCsAx5+DnR/d
 qwBl/rOlxTi6K2zrd0T/rbah8fvZixe0U=
X-Gm-Gg: ASbGncvjZipQYsjn6nYSm/gFY/CsiWq/RkzLnO3Vwcfi/ijCEhxvESHBE3PzOtf08A7
 djDQcqLl+z7TJiXUXQxPt1RkkoNgZLwWBfINP0aUWaau+pnBicQdm13PY5jx3XA5gNcNzIqeOfK
 pgojQZoGQrstyU3BQc+CSCV+31QM/MrjXx8978q7GVSdbLvu5fARK9
X-Received: by 2002:a17:903:1105:b0:240:63a9:30c9 with SMTP id
 d9443c01a7336-242c2044621mr59353635ad.17.1754670386765; 
 Fri, 08 Aug 2025 09:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6HMY5AJYrS9cTPMUVn6P5glD3gH9vXuh7tBGYLQB50AQ7Vzt6zp8gcNIBAhV4EFcpcXFpL2dfepTgbJp+2pI=
X-Received: by 2002:a17:903:1105:b0:240:63a9:30c9 with SMTP id
 d9443c01a7336-242c2044621mr59353305ad.17.1754670386356; Fri, 08 Aug 2025
 09:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250731054044.4011789-1-armbru@redhat.com>
 <20250731054044.4011789-4-armbru@redhat.com>
 <CAFn=p-bYKEjGX-DYPNbxFn=52-dJH29-SwmPvWYZ7tgo9ZBS+w@mail.gmail.com>
 <87ikiymibl.fsf@pond.sub.org>
In-Reply-To: <87ikiymibl.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 8 Aug 2025 12:26:14 -0400
X-Gm-Features: Ac12FXybjJVQzsskJlGSoKBRvIOGZXHEnlN-ITbyUCfCbV1jORUfQlygjmch7iY
Message-ID: <CAFn=p-ZtydXfO7a9rmn2RVx0U+O2+ovPH0R-QVV_3xTWmnsxaw@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs/devel/qapi-code-gen: Update cross-reference
 syntax
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 8, 2025 at 2:35=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Jul 31, 2025 at 1:40=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> The new QAPI code generator creates a cross-reference target for each
> >> definition documentation.  Enabled for the QEMU QMP Reference manual
> >> in commit a377f39f38f, and for the QEMU Storage Daemon QMP Reference
> >> Manual and the QEMU Guest Agent Protocol Reference in commit
> >> a6af5443440.  We've put these targets to use since, but neglected to
> >> update doc comment markup documentation.  Do that now.
> >>
> >> Co-developed-by: John Snow <jsnow@redhat.com>
> >
> > No need for this in my opinion, the SOB suffices to say the same thing
> > in my book. I don't insist you remove it, just seems ... oddly
> > pretentious to say I "co-developed" a single paragraph of text ;)
>
> It wasn't obvious to me how to best credit you, so I tried this.  The
> Co-developed-by serves as an explanation why your S-o-b is there.
>
> Please pick one:
>
> 1. Do nothing.

You're on vacation now, so by process of elimination, we'll do this ;)

>
> 2. Delete Co-developed-by.
>
> 3. Delete Co-developed-by, your Signed-off-by, add your Reviewed-by.
>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > Reviewed-by: John Snow <jsnow@redhat.com>
>
> Thanks!
>


