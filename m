Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7363CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXeg-0007OW-SA; Mon, 26 Feb 2024 04:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reXef-0007OL-Dt
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reXed-0002kP-GT
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708941130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pivNeLXapLHiETOSI1vjkecBaMuozhvQfaWmLqTHpXE=;
 b=E4g9PC4/zO3gOpAcz+KBE2MALZp8CPJnyFdScIQgrK7ZD+RNUlUjbJ6YKvPGo235kug0xl
 eKPHHIe3lGWKdqqQPFRR26oQIgOvayarYhv847QOWnvwM1vBPHpT6x1PzLxfnh/bnIFdQF
 pU6Vuz7cgKojdD/i810a0lKOFHhT2UE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-W5zcnLCIMWiTdd-ZXCwoXw-1; Mon, 26 Feb 2024 04:52:08 -0500
X-MC-Unique: W5zcnLCIMWiTdd-ZXCwoXw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d2617b1214so23053181fa.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708941126; x=1709545926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pivNeLXapLHiETOSI1vjkecBaMuozhvQfaWmLqTHpXE=;
 b=VmSuxkWPfN7s9wGMJJT4VzyLq5l5tfKiobMINN/vnZNyl4/fWZQ01peZegpLo+h/tB
 8V4KnesWnA2WUDD9SDCHoPm+DjoPSXp5/Co5R2IU5UtO4Wr2A/KxCHzyd5ibHP2vTtgL
 fxHGxGbufAlb3+ZS+4eP0xbWamqJ4wAlu7KElUxBUchUi/cac8s63hH1Rn83297LP7DL
 ut2Nbzz/EMaRhdp90ZkMfynPlZxLcXD9W7nVnG9gcDfyThQNcrxlV2zX1mCkDV5ooJXR
 LIh07FiKtlQadJNCwXdwfzW7gkf3w6YNEY70wiTwmlOI9OOW+nMH+Zl94ZStS3407iyJ
 eNHQ==
X-Gm-Message-State: AOJu0YxUzB8WhQ4wjpVZCdSw40gMmmaHrRlPSDb3vwUrlxqIbingQLRQ
 DcU1MF3Wg2xmSnuJ0T+SWiIIm5sKvh+Egynt5g74wDke1II7raDLCnuer12UBSylfs67ygcryLx
 4yDl2BFjzIxrgWj2aL3QDUhwoXQNMLFRziHK8iaeoOY3oqmIRGWJJ6VRgk5Zx/0vgvRVJTnfcDs
 niXY3VeG9wL6pF+UBWVEhhMtP1tycCgfQxJcA=
X-Received: by 2002:a2e:97c2:0:b0:2d2:8bb4:179c with SMTP id
 m2-20020a2e97c2000000b002d28bb4179cmr1127173ljj.25.1708941126092; 
 Mon, 26 Feb 2024 01:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKHgVEKap36ZBD9DC0PRl+N2SnbIp9fZfGd8Z1k5h04m6rCY2ewd7Z0I0JK/mHBVj+RP/MPtn0TCakHwQ3T+o=
X-Received: by 2002:a2e:97c2:0:b0:2d2:8bb4:179c with SMTP id
 m2-20020a2e97c2000000b002d28bb4179cmr1127161ljj.25.1708941125762; Mon, 26 Feb
 2024 01:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20240226082941.90364-1-pbonzini@redhat.com>
 <4965a0a5-e161-4953-89a0-09fd1bd73286@tls.msk.ru>
In-Reply-To: <4965a0a5-e161-4953-89a0-09fd1bd73286@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Feb 2024 10:51:53 +0100
Message-ID: <CABgObfYA3vMmAOti7kbXoh4OKUmQvcnXx9_FY7HF49E0ft_GXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ide,
 vl: turn -win2k-hack into a property on IDE devices
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Feb 26, 2024 at 10:24=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
> On another hand, these aren't used often these days.  This particular
> option isn't necessary with windows 2000, at least with two different
> kits of it which I have locally.  So finding the thing when you actually
> need it (if it gets moved elsewhere) will be difficult.
>
> On yet another, the code to handle this stuff is small enough and does
> not require much to maintain, -- at least for now, maybe in future it
> will be more difficult.

Yes, I agree. The purpose of these patches is to keep the
implementation of the options separate from the implementation of the
workaround, and that makes things even simpler.

Paolo


