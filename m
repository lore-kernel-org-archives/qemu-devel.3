Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C93C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9VE-00059w-2e; Mon, 04 Mar 2024 09:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rh9VA-00059b-Un
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rh9V6-0005pF-G5
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709563265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJDcs1ar0Orj5hXR/KtSZqM9Hjpf0BJr5/FNJEV0ha4=;
 b=PwPQhPignaI3xtziHHbxK8HHz4CobQyLn3gdtf8lZeXAuW8c6MV6ZHmwQpTs3KplGpeXh4
 D9eRUjmRZIxlvS6nHNBTJYU6XYR78t8rm6cmXLyAE9dszJs9XYrEDwrwVTWkbUSA2q2IvF
 vsCDHGw/P10fRnwmenm/g5ZYoX4mdn4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-pxFtjGdmOriDYezUdQn8JQ-1; Mon, 04 Mar 2024 09:41:04 -0500
X-MC-Unique: pxFtjGdmOriDYezUdQn8JQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412dbc77740so11728575e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 06:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563263; x=1710168063;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vJDcs1ar0Orj5hXR/KtSZqM9Hjpf0BJr5/FNJEV0ha4=;
 b=URKikjzVv2Gb0Ji8kUsyNJh/0mvuykgXJiN1N4r1Fa+aVoK5bc5UrVruARyO85Rme4
 00YOyu20L5bv2zSbQ4qonGrVElafTJEpm0u3bpi1xT+fdLRNP892sQFLSxbWWpjLPQxN
 xdLKLY6BiHykepMKoCULOnkEovzQzrt+Pf2gWTHWiiIM36oaHRXWGsCn4GixBnHtw2eY
 GrCoL08kLoU1UoRDys9n6jeclEaJHBINsJX7Jr2OEDejRtBmUbNxDpin3EgimGtt8bzY
 LVY3Ax1TMxf4VUcwq5EPjTwJwEETwXe6nBGnTxlNwOAFv/l5Fcit9Aax/5ryQuOfjC+j
 XT9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYcSg6RjlpFEJMUh0Rj40p4ed8tGJ4eEgZo6W6fIIDFLv2XdeRfDennmp3ifHJSN2P2XhRwVjXrqZDE0Bun1wkcCEWl/U=
X-Gm-Message-State: AOJu0Yx2jTiZ8Q4B613eUiWa9msFzbr98LCx5XNs0C4X4FryKSFGYxuf
 GOZAjOW+eGH8i3D8GTZ8+9zJhdekcOEtVEKjB8LjwbXrBV48nLYfuk91e/+HBqlH83DxLK73yc/
 MfuABKwb7fDKDOTu352/MHdc3qjDNqssYnpnRaoRVr/0T8WvzYThW
X-Received: by 2002:a05:600c:190a:b0:412:c9e7:202d with SMTP id
 j10-20020a05600c190a00b00412c9e7202dmr6442150wmq.6.1709563263583; 
 Mon, 04 Mar 2024 06:41:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcKBcrvSztZ6mse/+6mI/nSPUdrI0xHKjeQX+b6WDFe7k0n5Yq2H7DG/eckEbdMOmnzQwNOQ==
X-Received: by 2002:a05:600c:190a:b0:412:c9e7:202d with SMTP id
 j10-20020a05600c190a00b00412c9e7202dmr6442137wmq.6.1709563263239; 
 Mon, 04 Mar 2024 06:41:03 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00412a31d2e2asm14925891wmq.32.2024.03.04.06.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 06:41:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Mar 2024 15:41:02 +0100
Message-Id: <CZL1LKPLC005.2WG9X653U6H6D@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <Zbi9vjPCsia58LG4@redhat.com>
In-Reply-To: <Zbi9vjPCsia58LG4@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Hi Daniel,

> > +        if (s->msr_energy.enable =3D=3D true) {
>
> This looks to be where we need to check that both the host CPU
> vendor is intel, and the guest CPU vendor is intel, and that
> the host CPU has the RAPL feature we're using.
>
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Checking for the host cpu and RAPL enable is fine and done.=20

But checking for guest CPU is confusing me.=20
The RAPL feature is enable only with KVM enable.=20
This means "-cpu" can only be "host" or its derivative that essentially=20
copy the host CPU definition, no?
That means if we are already checking the host cpu we don't need to do=20
anything for the guest, do we ?

Regards,
Anthony


