Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A048EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOWf-0007CO-5K; Tue, 03 Mar 2026 07:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOWd-0007B6-57
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:06:55 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOWb-000852-7Q
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:06:54 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7986d231b3cso76282627b3.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 04:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772539611; cv=none;
 d=google.com; s=arc-20240605;
 b=WGpJaWUQFu0vJ87TvENCnfNJB/PsrhyXI5XHQfksr9XCRBkNMbjc3rJ40rKlZ5QaqC
 EAAX7aXHTFzg6qcsXi2FIFKw8UXHhecf4EpWM99rRozA9b7VILehsyJBwfzIb1XkGGwU
 GCsRvjGtAExk5eA7PB2bUSp+0ZjKINO4jXjbThVPscf0TRiv6IFxooUP2PqBIVabbyJZ
 FXKpeITHQMbp4i3m+LXJAyUxbtEaCn1k0Xit5aqJRrEVWvsJWdq8UOOC/RsdPdSssCvP
 uljkPE/qlf0si7uDi2JWq3pt4e1a+Qn2ZeMfMA9GNT8gJfg2msOxkZWlA6atjOdvnvVF
 tfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ehkCGb5/hqMEmuZhMWfCZTFaXcJ9oco12dClte5n6zg=;
 fh=hCnxJSjimeeAy9ELrG71kZckpkzTWvhp+22WYPqq2ew=;
 b=d8Ku/B7H/edlaOYjfP62U9XfF3KjbosBf3X3Ji7Z+pIXsqRSM4KWYAEUgfiNGX+zPB
 l6hmnYGP9PFhQk4RuIiD3tD0bWSq/m6Uk+7hxYMuI+KgCO3hPJT++IXvrl84xsFC8GxD
 isAU8S+RAhZD3rl+atzlepey0NitUje5eBayONaQSIyJuhlEO8ICTiSLN6sCXrIRIGd0
 J3onHuzdxM/i68QpvmLXfNicnMGgcruPRIV74zC8N8BvS7IXOpTPM+3XmJ6no0/2arDf
 8/JODegfgWSwIla7+tUXaewD1PcpqNsQW7a7/Bi3MCKixBaBd09vrfi5m6S7RajH1iSF
 ZZBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772539611; x=1773144411; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehkCGb5/hqMEmuZhMWfCZTFaXcJ9oco12dClte5n6zg=;
 b=mwBNdywfWWdo+Q5fUG7q1oxu8V3vKOlUMOeeHbCgECm+/Dj9kgwKGPwn3k4cyGQfkX
 sF2Tw/Kta4PBma8XI7QFBwpM+Vjnzb3qm6Gq+cIp7b+Rq+6EKu4zaIOEYHITsFb4EILk
 bHrzm5vb7Sc8cholLynRIjVpAwu09UXDtV9ZYbljFYuECSX76WJEGvYor92GoRvk1NHD
 Z9G/DwrD1M0Q0J6luUyQabC7U+1E7JYE8Gq4/uwqCL8yYl6JX9cOC1nYT6hVbr6Yici9
 dqu+D4B1Dn0Vci22d7TuB0VXNAZmqDIB+gOh/DxGR4YYWImWv4x94LXhMuhYO1mrYddw
 Bffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772539611; x=1773144411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ehkCGb5/hqMEmuZhMWfCZTFaXcJ9oco12dClte5n6zg=;
 b=JdrEOQQOA7LtUILRQaizcUsNrSmamoyAOur9YtCNKWJ0SOXEXfk+bel6MFnE/fxnMR
 rheVeLrdsMDV/10aAMusFjExWSjDErxbVeiPPPmpSniosg1+8Bfj3E292KAMsEPKF4y0
 71qxXFQ/r+lgiU8f6RZaOwXa0Wgzz6oa6m9ggOPOaNE9R206sPnRrqwhlKRYv6G/Ai24
 Hu0yO737CVXul5czEBNHRVKEhxM0rIGsXzqo+vg1zQ78zYoNVWhwnlBnpttbO9Fi8GG3
 M+saZyAc5lPJ6rI52vS6DDtocu+ub8Z5Wb0Wnfp537kfwbd4jDg5O1tNpYWF4N07XIoC
 5x0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYOteONWqHvjm/DxbJbKTncMbbWUpq+rjtgb6LT43K4/kPkyEELkptf7Pe5eGAYY3A6oAw9xYtoM4Z@nongnu.org
X-Gm-Message-State: AOJu0YyrWPtU7bJari56gyjHGZ0+tEa5bwT8Ap0hoX+EhHNVdt0KFZKR
 6VXd3koP2S77L8zOcx1y2hzzy1WGufQfv87q3E6QkYSaCUTL16X2V8jNLe9XX+PuYM5tDL+Hi2k
 +R8kBi8Qbq66gAN0vqIszJWPJkdkY7mq9XGvztW/pBQ==
X-Gm-Gg: ATEYQzzqtHZ8wUyyL79+2SIpWsqFVSNvrcqjy+Jdy5L2s6bYv2kMjM8wMbCNMaalx+N
 HWiJnw1xbxsOWMfDxnEaPbu7Cycx3x1wVifxsuHgCLsRa7u6i5869yvIQfiT6E1rxcawgTnxiji
 QKg3kq0xWj3GuXKLcqaakn1LGP0cwrGylgHM2vahdRzVrg5d3ChyMu4QfsS4kj2+WA4ALBCPadT
 vAlc0H4+7ezGbbIxIe7yhUx8nhnvIULSw3+HPiAGMolv2EUDnUeNdy+SEZ2+3Tr6a5bDvTLViOJ
 QQJr0IR1SnNMbh0M+RpsVux+aXWO1sFC8c5jyy8D7v9Q5QoYLcrLKZytH5dDTX9iKTk=
X-Received: by 2002:a05:690e:1686:b0:64a:d18a:66c3 with SMTP id
 956f58d0204a3-64cedd494a9mr1198183d50.48.1772539611222; Tue, 03 Mar 2026
 04:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20260226175549.1319476-1-peter.maydell@linaro.org>
 <65e0593f-d5d6-4e22-a730-ebe65bc1a332@linaro.org>
In-Reply-To: <65e0593f-d5d6-4e22-a730-ebe65bc1a332@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 12:06:39 +0000
X-Gm-Features: AaiRm51C0S1WaXaJRwJhDW5kTXSffAuX06l7M_9kNo6a__BHx-7jq0mMzpLw1aQ
Message-ID: <CAFEAcA-U0T9c6cZpyoPs7iGqLM=hFks8212no+_H5hp0jcNb6g@mail.gmail.com>
Subject: Re: [PATCH] hw/net/smc91c111: Don't allow negative-length packets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 26 Feb 2026 at 21:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 26/2/26 18:55, Peter Maydell wrote:
> > The smc91c111 data frame format in memory (figure 8-1 in the
> > datasheet) includes a "byte count" field which is intended to be the
> > total size of the data frame, including not just the packet data but
> > also the leading and trailing information like the status word and
> > the byte count field itself.  It is therefore possible for the guest
> > to set this to a value so small that the leading and trailing fields
> > won't fit and the packet has effectively a negative area.
> >
> > We weren't checking for this, with the result that when we subtract 6
> > from the length to get the length of the packet proper we end up with
> > a negative length, which is then inconsistently handled in the
> > qemu_send_packet() code such that we can try to transmit a very large
> > amount of data and read off the end of the device's data array.
> >
> > Treat excessively small length values the same way we do excessively
> > large values.  As with the oversized case, the datasheet does not
> > describe what happens for this software error case, and there is no
> > relevant tx error condition for this, so we just log and drop the
> > packet.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3304
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/net/smc91c111.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

