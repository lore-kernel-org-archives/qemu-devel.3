Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D2606A20A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XIxzpajA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQovG-0000cu-Pq; Tue, 10 Nov 2026 11:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQovF-0000bv-Rg
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:42:13 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQovE-00076D-2o
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:42:13 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b3653df740so7896587b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 08:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794328931; cv=none;
 d=google.com; s=arc-20260327;
 b=Sk5ZX//orKZI6VJ+ZuIXma4M55aTXRbgearLv+z5JfKa7SSAfnZT6WXqAEhap54NT2
 weDOtSdnqNUIoL9/bTjfM7Av3BLkCumTlj7VSebV26avLie+IknmFZ3tY7ueCDCg8YfO
 wqh5wCTAG9z5YVd/W8iu+aclN4ZE6FjddTT73WRlQlBZuZlT62j+6NMJMTPdAe2BDbMZ
 xGS8cxxbuuXUV6X6D+s7hoReckENXc+CkgVqn1zyA8bijNNCALu4FcD/OYf+FzvA/EpA
 xe8Q1if+m2kwmWesN8I8alFFDGJzCWsC5IUWaPZbc6WCDIiy67RE1ceO2JcO9QRHwtjf
 nr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UVoY7eBSuxBzsUjvxGw7TtOq77RBkTHcDJ6sgY+xg4M=;
 fh=+8jhmTTdS+XJXZvdzRzqYdy50ZSR3rg1UrX8G1Tlp7g=;
 b=G3FnR5Rb1WeCek1Tb2BQ/ulYVrRuVyjmnuriah96Yi9ZM+emzANWjjaNjM1Tx8Cap1
 nTDUtkt1Wgzsawcgm+3hQvdA/H3urZ+Xwtc4P3vTBuEBNT0sX0nTLXMJ2ZNgL5NUfj1d
 FkD/naop1K/aXptIcHHKCArlA13cig6eJM4J0wky+z+1C7gKlvJq5aNNH98WEPyCFvi4
 zsBNx8BLnjXLGzTQbILxsXDWHKlI4dir6xBQZX8zMkFyDv/N5h/+Zb+FRWULAqhN+EaE
 sZy91ShDOQ7+sjuIGpRwbe8A7ohbwEMw3kpVuazEHmmsIqwfCpAJVelv42mKapfwAnid
 ZdBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794328931; x=1794933731; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UVoY7eBSuxBzsUjvxGw7TtOq77RBkTHcDJ6sgY+xg4M=;
 b=XIxzpajAgy/MoIqVcx4/ZT1yklU5sF0hYEvRlSLaY8CmcjOneEsnc8rNfGd4CKcCk3
 5Vw/ECgIjRfUVyFRL4/QTRLFxYJKdP9Auau+teHkpAJvChMritMlyvDk0PqSnsPX7Z9x
 phdj+UdCGt6RjmK+Y1asksvy3SzpIPTCNBPaR6kcsjSxBnmpogSdpmGpJ/nFJtEDgW3C
 YoBafpW3i8Ft+SAquJc6Uy1o+iU+ht55hwIvqqntwzDGD7GGHjLOR4j/BftpyOFF5jcv
 h0zXNAkcfW8BFGMsEUu/7BCDyxETfHxiEMBbyvZMwaradHjU3n431aIpoobLBpbhElhp
 nbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794328931; x=1794933731;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UVoY7eBSuxBzsUjvxGw7TtOq77RBkTHcDJ6sgY+xg4M=;
 b=WLlEdvuhnwiFghEImaX1crNLdj5Y0bqpx3teiAPPFjtsYJxOMaKS0VaR4ae28POBIa
 zFdZnKuTdJ6mcOS3KmVJ8lZcKvByYYCF7graItRZeX0Vnj23JZUPM2SQ0b+h4UpACuAj
 9WvBjknLsS1tS9KWam4aFIKwCoT0sszZutn+QWqxxTuFgJTGEBRQy4HXVSq59SY4M5PU
 9BDS2pSbtWbM0tbL/0XZWWRYgd5oP4uYKMYUyiXrSz+JwZDd2iuXtA7zXt1tKLbBF9bm
 KT4hjL1Aue/DkBkKnCc1oRDqmgk8XAyDay3MaLtGVN5l57Ws1g8vqwhg1mERm699d7kj
 HaaQ==
X-Gm-Message-State: APuU4Z+VfmZzFxFa/j6moPCfmUniK6Mxl5hh3V04TsaWdajC+7YlUCgS
 A3aiS7uQ7tKZUko7GYh1FhWbkHf66Vu89h+ixXqosiLxS1BFsecOcaKL77jKjcyvnnYvZ6yccXi
 h0Byp+JZA8bgrk3HDRddF8mYLSOuhT+6A7pnWgIgk+Q==
X-Gm-Gg: AYBFou1HbzRD/2fDnMyMt2XTEiRhD31b+OqxhrKnVl4/PeawkPjTEwSIK3W5vGvkcQ+
 CWP7adrVSS+334RjCgSfWO+3DqRKR0rIRne7aRi+NJz96nO8CojeyipOKtpmMBZhWLQe7nrJ8yu
 XFJsPa4Y84PnzjIf8M+5MgmcOBexiCZoZn9DZaLHpT0Pd4tEsw9RJa2FlcKjGlNq9S9h4kt/+IM
 jmq96S741W3nAD9AI8Nlaf5YmcF/+w1UkB+etukTnGB3f+g1c42BpAyRSmC5NES3tC3uyzp/dbX
 ko3QF5PzohjP/yUe2AbiYwfIB6PnzLy/dXq5sMggGUoLSIZvm9slt7DjOcBhxQIH/y550yihBkI
 YzNJoXiZuGReez5FeNad/sYZMieoNAu82e43OMLAGzto/gIaaXPPIlctfZt0aFMVfnrPk8+lov/
 fQ0aWefl/Y4TbwB+zr3LVhZA==
X-Received: by 2002:a05:690e:134b:b0:67c:2a61:ac27 with SMTP id
 956f58d0204a3-67c66e86a68mr57505d50.41.1794328930617; Tue, 10 Nov 2026
 08:42:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
 <20261027174625.4025878-3-peter.maydell@linaro.org>
 <ac5b6410-3f96-40fa-b9d8-99ac25f8648f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ac5b6410-3f96-40fa-b9d8-99ac25f8648f@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 16:41:58 +0000
X-Gm-Features: AclHuK8WhDi9eS0-aXlKUzCgQJxdRRgzsDhRXkq7ik4VqXW6l30nmdoMNB44cfo
Message-ID: <CAFEAcA-x6OhjgRL69E2dESFeqf4tUdw3Cu7TUqeev_prc5GzcA@mail.gmail.com>
Subject: Re: [PATCH 2/4] net: Set do_not_pad for net backends
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 04:44, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/10/28 2:46, Peter Maydell wrote:
> > Currently our handling of short network packets (i.e.  those which
> > are smaller than the minimum ethernet frame size of 60 bytes) is a
> > little confused.  The intention is that we allow network device
> > models to transmit short packets, but we protect them from having to
> > deal with receiving short packets unless they explicitly opt into it.
> > This means we don't have to have a lot of code in each network device
> > to try to handle the short packet size -- historically that code was
> > untested, and often a source of "carefully crafted packet can cause
> > an out-of-bounds memory access" bugs.
> >
> > Our implementation of the padding is currently done when each network
> > backend feeds a packet into the system via one of the
> > qemu_send_packet family of functions.  This mostly works, except that
> > we missed some of the more obscure backends (e.g.  the socket
> > backend), and it means code duplication in each backend.  We'd like
> > to switch to making qemu_send_packet do the padding itself.  To do
> > that, we first need to make sure that all the NetClientState
> > implementations which do not want padding set the do_not_pad flag.
> > We do this by setting the flag for NetClientState instances created
> > by qemu_new_net_client() and qemu_new_net_control_client().  Emulated
> > network devices use qemu_new_nic(), which does not set the flag.
> >
> > Note that this also causes the net/hub client to request no padding.
> > This is the right behaviour: we want the hub to accept short packets
> > and forward them on to all destinations.  Each destination then gets
> > to choose whether it sees a padded packet or the short one.  The
> > hub.c code is length-agnostic and doesn't look inside the packets it
> > is passing on, so it has no issues with short packets.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> >
> > @@ -301,7 +303,7 @@ NetClientState *qemu_new_net_client(NetClientInfo *info,
> >
> >       nc = g_malloc0(info->size);
> >       qemu_net_client_setup(nc, info, peer, model, name,
> > -                          qemu_net_client_destructor, true);
> > +                          qemu_net_client_destructor, true, true);
>
> This changes hub ports, suppressing existing backend padding before
> patch 3 adds padding to hub forwarding. So a 42-byte frame may reach the
> NIC as 60 bytes at base, 42 after this patch, and 60 after patch 3.
> Perhaps this patch and patch 3 may be squashed.

I missed that wrinkle. I think the simplest thing is probably
to squash patches 2 and 3 here. That also has the advantage
that you can't accidentally cherry-pick the patch marked as
fixing the CVE without also getting this necessary prerequisite.

thanks
-- PMM

