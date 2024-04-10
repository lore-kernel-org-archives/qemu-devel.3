Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D839CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXwi-0004Q9-5u; Wed, 10 Apr 2024 09:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ruXwf-0004Pz-64
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ruXwa-0007Z3-5d
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712755490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIWo8A3JPrKdxexVi+GT31J1A4sA/6xqRhg9IBIL44M=;
 b=Jv7zqyIj9ueTMUkkPilu+MSm2OFXuqRv3c9JZEoq2MlYlahutN2DdlkxepBhHXSCLnOAeq
 2hFnzcsoLoRXDWT7EetTPWbe8uXcDEhzoYIMHN/Id4kf76jk0YGNGnPA/mFj6iqEO7Ii0B
 FZ/x2ZPeybkmTitBccSQxKd2WjcqMu4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-3q5hVt_OMzuLSeNj2EVk1g-1; Wed, 10 Apr 2024 09:24:48 -0400
X-MC-Unique: 3q5hVt_OMzuLSeNj2EVk1g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5684bf1440dso2726200a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 06:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712755487; x=1713360287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIWo8A3JPrKdxexVi+GT31J1A4sA/6xqRhg9IBIL44M=;
 b=RLlL+oiolHmOeF1445c5mb1WgoQq2YWMBa3fuTXqv6ejBxJh9i/1Eql7Hn43keJgvn
 KvfO153Tf2AYcnkRtGmhwG/3ggPrhelfmPm5gzZ8d4zAeS6zm8cyYzgM8CYhDNUk7dsd
 fhmmfNeFaoTR00E9ie1fEjJrm3qopk1bUlXGZGio9pU+m9CabynWjHENRJLhN3u96UPx
 NEVsjKQquS8FIv4xRjpwByGAHAIXIQjuVg81TNlCIXGXKXsU4jUJbfUI+vVKLzqtnCwX
 GdzTLq8OPKMoMGvE/Or21lmjWqcTb3bv18g920q8VbpeeYMHbWjvEowAvJhLSm495jqU
 GEWQ==
X-Gm-Message-State: AOJu0YwqI0aBnpNkMkwlpFRDNPivIUMYrcAkOcDelPBzx7XgsuaKAzbm
 XFUFOkOdkTKd96uHt+aBgw8dYC4dCFt552c1GcU33l4pNMaXtppG/xQauEclrCIdC56ziOUdvnr
 yPgLbdtlEYEDQk74X1z9QZVw76TiCwPFF3guECMyanapAA8Yw98L1iF146OtmqdxZSDrYv4h9qi
 O/K9L4iIPE6aPY/tpBvVD0zTZMtsE=
X-Received: by 2002:a50:d6c1:0:b0:56e:2a12:e9ca with SMTP id
 l1-20020a50d6c1000000b0056e2a12e9camr1475938edj.41.1712755487108; 
 Wed, 10 Apr 2024 06:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs6R4FOM8Hd5/n29sJ9sf9Mlpy3AEIe1dqOPYuvC8mVdopQO3a5Oj15epfAKkjFXIO7jNNWA7h5h1/VDd7uCo=
X-Received: by 2002:a50:d6c1:0:b0:56e:2a12:e9ca with SMTP id
 l1-20020a50d6c1000000b0056e2a12e9camr1475929edj.41.1712755486731; Wed, 10 Apr
 2024 06:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_BE1012EC266132443B1FA040EF8A60D1EC0A@qq.com>
In-Reply-To: <tencent_BE1012EC266132443B1FA040EF8A60D1EC0A@qq.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Apr 2024 17:24:35 +0400
Message-ID: <CAMxuvazoMKnhU8bcSnON2daO7Am4h4oTYrvPjgRhKL8uUCzTFA@mail.gmail.com>
Subject: Re: [PATCH RFC v1]display: fix heap use after free in cursor_put
To: =?UTF-8?B?44KebHlt?= <707242047@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kraxel <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Hi

On Wed, Apr 10, 2024 at 2:06=E2=80=AFPM =E3=82=9Elym <707242047@qq.com> wro=
te:
>
>

Please send the patch as inline:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#do-not-send-=
as-an-attachment

The patch is doing too much changes to the ssd.lock usage without
explaining in detail which race and how it solved it.

In particular, ui/spice-display.c usage seems safer before your
change, since it takes the lock on display_refresh and
display_mouse_define. It properly temporarily releases the lock before
calling the dpy_mouse_set() and dpy_cursor_define() as well.

To me, it looks like the only offender is qxl_spice_reset_cursor(),
which lacks locking before unrefing.

Could you confirm this hypothesis if you are able to reproduce the issue?

thanks


