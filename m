Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DA7CFB448
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxq1c-0001tl-Pw; Mon, 07 Oct 2024 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxq1a-0001sK-Ku
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxq1Z-00038Q-5b
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728316312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGfBzNauwRh2yHiMgBgqKa6m11HTaarMBwkUsXGACSY=;
 b=JMf1PfeB58646VndEsHZ3yIKFRtIPZygvBYbA5MEFJZNP5t9Cgls3FQynYa8cuNPKPVf8M
 LCfGf/YKmW7rESgSswyVGd906pAf6e26zBGfuMye90gDD7KoynHhsIeMzFvCrg949Fl3/D
 IMhyrGCOtomrRWnEUQyKJ0LSd8omno4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1toJM_2TOlW0o_-pnEcR4w-1; Mon, 07 Oct 2024 11:51:51 -0400
X-MC-Unique: 1toJM_2TOlW0o_-pnEcR4w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37ccc96d3e6so1745928f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728316310; x=1728921110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGfBzNauwRh2yHiMgBgqKa6m11HTaarMBwkUsXGACSY=;
 b=vRIfNhzcwCuNqOUNlEJqVqZBVbHi1vIm1xUXEzTsV6wGV/HokSn0XC48uPv9Q/XXEB
 thWJTbynJLt/mTL2Cp1hODnut2hoqsTSu7jp/WyudIOUUZsB5QmJX1Ft6UUHTrLTwBJt
 FVsvpdJliIQPGdLfmvkuL8TR7X9d2UqwArwsOUwd5xq1HM/TSdia4CMp4qwuHV915n4d
 fg9pvtSTfLQ+6lPQuCXo0urHEuSOsPu9NrUSVz2hEjuAMhJS8HdDNe9wuHRhOfGFCWd5
 lcNQH9q6M2cBNZz2mSInwx7qRTCGJVkXLWswQz12iKX8UpF1U7CJ/duO2aQ2IBc6rm28
 55SQ==
X-Gm-Message-State: AOJu0YxOFUTy7kf1T6+0H1fMDVpw14H2nb/wQX0VsdB+QU8zlKSD6DC1
 HmdTL5Ikv7QtLi72XY203OBXyAbUEp7vcdzu7KrrJ/NDnYhaU3c2rmy+1ufUzk8Ns2oXW4rX1bf
 055Hku3NaYt9gZ+omCAIZoyESvT0qhGGRydtqbYwkLfEq/FjSV+KPpy53RGuSc61SGTbU8Zs1/3
 4/E+uq58aDGhxwtfMtXmPrnV2yLWo=
X-Received: by 2002:adf:e681:0:b0:37c:d1d2:dbe5 with SMTP id
 ffacd0b85a97d-37d0e8e03e5mr7180246f8f.45.1728316309977; 
 Mon, 07 Oct 2024 08:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUVPIE7UJ7XkgzN89XuTQeXfYCuVkJcXDSagx1Y9gv+Dk/e5+gwqNfOPuF0xlWo25V+Y4gZlyjohtuhqF3Des=
X-Received: by 2002:adf:e681:0:b0:37c:d1d2:dbe5 with SMTP id
 ffacd0b85a97d-37d0e8e03e5mr7180235f8f.45.1728316309601; Mon, 07 Oct 2024
 08:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <ZwPB9SnTvkr082NA@redhat.com>
 <CABgObfYZgR9xNnP9mHWU92XZZ_VeFLHimkd-t-63KX_KWeDZ=A@mail.gmail.com>
 <ZwPKPGkpklnY9i5z@redhat.com> <ZwPLlHxQkRbf3QBx@redhat.com>
In-Reply-To: <ZwPLlHxQkRbf3QBx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Oct 2024 17:51:36 +0200
Message-ID: <CABgObfb5ypzdCnZm6OYTLMjEpX_L5A8dK66P_aLwg6iEqjk_Cw@mail.gmail.com>
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@intel.com, pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 7, 2024 at 1:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> > Full CI enablement isn't a requirement until we want to turn on
> > Rust by default. It would be sufficient to have a single job in
> > CI using Fedora 40 that passes '--enable-rust' to demonstrate that
> > this at least working on one platform we expect.
>
> I forgot to say that QEMU's 'refresh' script can customize the
> dockerfiles from lcitool with an arbitrary amount of trailing
> text - see the 'debian12_extras' for example.

Ok, I'll try to concoct something like that.

> > If we want to actually build with the cutting edge, then I'd say
> > it is sufficient to have a container based on Fedora rawhide, since
> > that gives a heads up on what's soon to be impacting the next stable
> > distro release, upto 6 months ahead of time - we don't need to be
> > watching& debugging stuff that hasn't even been released by Rust
> > yet IMHO.

I think it's a good idea to give ourselves early access to lints,
given that clippy and rustc are evolving more rapidly than C compilers
(which already bite us every now and then). It tells us whether we
consider them over-the-top and disable them, or potential bugs/traps
that we want to fix now.

Paolo


