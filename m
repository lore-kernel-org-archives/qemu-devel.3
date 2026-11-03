Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F782606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GMAQ07Hz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEVA-0006oY-Ue; Tue, 03 Nov 2026 08:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOEV2-0006n3-KG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:24:30 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOEUx-0004kh-Ow
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:24:26 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b2d14968c9so21779907b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 05:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793712262; cv=none;
 d=google.com; s=arc-20260327;
 b=ixUm38pzgBGFQDizbx0j7ICZXCZ7mkZ2qRQ0V6SeK3WJBSXWVqVLeAMT+NuyL8dA8W
 393vqTlpbzFDYO4xlSxS/kTRtD2g93pRsGiuSoJCKZT/pu2RP322SyaBL8T8kL0PUziq
 x4fw9A6LvAj1AX5y0JNnltp+vbwXcM2QNMB+dZVvCMnOqi+GljrZ0dBxhrlNSLihuTFG
 wK/m0n2iXBDVyzLEu9/eueKsJe4FE0jQUXmdC4cS+gnja/AKQq5z6MQHnUZJIhSX94JV
 6xAdFOpFVe+YcsO5mrZbMbeMNWM1OnoGX61QcM9kk/xPcHtLrEF0LWEhNG4p0bpcyZ6r
 HZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x5BZrrDZBUor4QQ8VF83nkDlYgyXyb8C8ITOsmo+z9k=;
 fh=ipTwV/016Nc1aTW+i4jxQbKUeQFBE66mB/hWTwPNHqk=;
 b=EKSU0hIrSENTDfa7GAAFM7FJKzw4YuErFXTMQs2iUrty1w1CiBNWePy37UUP75gHr5
 mNmgK6Ic0EP/sDyQUz/gf7S2X8325ed9LNm08FRrnsKfQD4F5kVEybjCraBg1jgDvngR
 uGoJ/LnFycCIgfevASIe7athHKQkvK8t06ORa+GGtQw6xAi1KNtSoLWBZsU2c4cFliij
 yjYAmZ7YWX8h0TJyPrDCs2VzgT7nwnpMRZ1nLSJQS5Vyd1D83hxWqMn22qiygAj+RuTH
 xDZbOqtRucBaeTBQN2AAaEiEgQrehx7/RDu+QwsKIR5eFyGKHg0riB6yvD9k2Rg8mY1c
 jbfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793712262; x=1794317062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x5BZrrDZBUor4QQ8VF83nkDlYgyXyb8C8ITOsmo+z9k=;
 b=GMAQ07HzVd4wlSQTcZXu13BZulBiEzPorKUjm3aSU4boqbpluZtY5nptyIbpUoSYLy
 AfhgFZBGWQkaiZvgyz7ZLKeXpGRdMemot8qgvHaTMMr+VTwfO1a2YPVW5BCDoMByRLWf
 LPGtdoDRz/OzlQ5KNK4+YJRtEp3v2nr/NY2ViZLuni7OnRnnSG49FoSBWZhjRHpZI3tQ
 /jkHUOdjuxetkVTSgKZahTDClkigsAx5zJe/8OKkTe1fbktY6rRTTXpyZWfKgKbJfH3a
 D2YPVHZzgvgKBOCBcW2zPjsZZ0ecN32warS46Z6FenLNel6o/eSBhnrxumVKuMEhhzql
 C6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712262; x=1794317062;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x5BZrrDZBUor4QQ8VF83nkDlYgyXyb8C8ITOsmo+z9k=;
 b=SEqHzk6XI/GsDt7JMVai4Ov1F02iGpOtjo1WeB6UG7cdpNjw/HnCX35oRi/9etJKFx
 YD6B1Ttws36m3EK8Xm9J46wGa4aCCNmqoJyg1ZkHKfNTZpMLA4tQ20fxfNSZQK3i5qv3
 iY3YY0oqjFRN4ICcq5SW2vSt3zMkdiccN+CThGIWcATVdwA0w/5BdpoOqeyuSCmGXIrD
 Y5TACM9NfW8XskeMMGJz5dLCRyFTcXCr34XdHcF4674KY2GBhhk860hVV8cyfzFBHU3y
 ExyW+JfDEx6Oql6qC+CVcFF6FkbVM/YwN/4DaNHPyfT0UpY6JlapDckr0XJkldeRShO6
 dvDg==
X-Gm-Message-State: APuU4Z+DMh5QnEMC2dzHUtZ8Aq5kGGCfwCciC70FpOAJKOvxNyFflB7Z
 nnMjNw48O8iypM8PnXsXb1d+OA85+3iRpI3DJmM04fI5jwkg+onEyfQA9tahdfL5AebUlUxY0o6
 +lE51ladU/9FIxXh/cYE8I3gNQ/CnLc6LsTCKK5+S3w==
X-Gm-Gg: AYBFou0EpoAC11uk7Mq7niAcLg6YccozD0zlihMOIOnHS8iVnF5zTuLBDBdibUPmo2y
 CwOQk3AaILI84SYJzfCRBE5w1NtJXmJFKenjjhBAFPwMCUGAHrhb5352IUHwl3Q00C0DDzSWUoL
 wWv3Qhwgb5MOYJPkQPJrYrb9mQMtMawcrdz9IU8MI/EgK0yMbZpuFb+QbN2wWvrXgPdT2dVkfn/
 KpUTCsOSOGljFJqyTa/JDHxhhsBga6dfGNPemJLy14qbFEVcPBXQF/xKoNzOQDhu+2jtgMqotGQ
 zM7B+RB4yrOGTRDR0HPLPC4STpxp/nVbUG21AKe+UwwMwz6nI25g/gnh2/83N13vHMRwF4glv/o
 491GEHZxMcwTIFbWhSqejRpoKi9/iUimKd+PDRyy0lLFbnvKpQfGW0KAhGedCN8JzoI72Gu7AV/
 z8uuYCK1vwTV/wWHl/2/KVuw==
X-Received: by 2002:a05:690c:e214:20b0:873:17c9:b054 with SMTP id
 00721157ae682-8b2b66df92dmr52275717b3.21.1793712261881; Tue, 03 Nov 2026
 05:24:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
 <20261102201828.1879576-4-peter.maydell@linaro.org>
 <865c4fd3-ea62-474c-97fb-7940068553eb@oss.qualcomm.com>
In-Reply-To: <865c4fd3-ea62-474c-97fb-7940068553eb@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 13:24:10 +0000
X-Gm-Features: AclHuK8Kmi2J8NzMOieF2pAllrrP2Vzs0IzuxB8n4sPCDAVMgYQWP6iZA1dK_V0
Message-ID: <CAFEAcA9uA6isj0Q5aLtD=LcFrMaAYfP9cq4hdxwU2Eik-zuRzA@mail.gmail.com>
Subject: Re: [PATCH 03/11] net/eth.c: In eth_get_protocols(), don't report
 SCTP header off end of packet
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 3 Nov 2026 at 11:51, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 2026-11-02 21:18, Peter Maydell wrote:
> > eth_get_protocols() parses an ethernet packet and tells the caller
> > about various offsets into it and other properties of the packet.
> > For the L4 protocol, in both the IP_PROTO_TCP and IP_PROTO_UDP
> > branches we implicitly check that the packet does contain a whole TCP
> > or UDP header at the l4hdr_off offset, because _eth_copy_chunk() will
> > fail if the input packet size isn't big enough for the whole header
> > we are copying out of it.  But for IP_PROTO_SCTP we don't copy the
> > SCTP common header.  In this case we should still do the length
> > check, so we don't set l4hdr_info->proto to say there's an SCTP
> > header present when there isn't.
> >
> > This shouldn't have any visible effects if the downstream consumers
> > of the l4hdr_info are conservative about checking before they access
> > into the packet, but checking here too adds defence in depth, hence
> > the cc to stable.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 907209e311 ("igb: Implement Rx SCTP CSO")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/net/eth.h | 2 ++
> >   net/eth.c         | 9 ++++++++-
> >   2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/eth.h b/include/net/eth.h
> > index 46dc9ed5acd..e10684ed923 100644
> > --- a/include/net/eth.h
> > +++ b/include/net/eth.h
> > @@ -394,6 +394,8 @@ typedef struct eth_l4_hdr_info_st {
> >       bool has_tcp_data;
> >   } eth_l4_hdr_info;
> >
> > +#define SCTP_COMMON_HEADER_LEN 12
> > +
> >   void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t=
 iovoff,
> >                          bool *hasip4, bool *hasip6,
> >                          size_t *l3hdr_off,
> > diff --git a/net/eth.c b/net/eth.c
> > index bc26d38dc21..341d3bdf02b 100644
> > --- a/net/eth.c
> > +++ b/net/eth.c
> > @@ -213,7 +213,14 @@ void eth_get_protocols(const struct iovec *iov, si=
ze_t iovcnt, size_t iovoff,
> >           break;
> >
> >       case IP_PROTO_SCTP:
> > -        l4hdr_info->proto =3D ETH_L4_HDR_PROTO_SCTP;
> > +        /*
> > +         * We don't copy the SCTP common header into l4hdr_info, but
> > +         * don't report SCTP as present if the packet isn't big enough
> > +         * to actually have an SCTP header.
> > +         */
> > +        if (*l4hdr_off > input_size - SCTP_COMMON_HEADER_LEN) {
>
> Hmm don't we want the opposite "is SCTP common header complete" check?
>
>             if (input_size >=3D *l4hdr_off
>                 && input_size - *l4hdr_off >=3D SCTP_COMMON_HEADER_LEN) {

Whoops, yes, I have the sense of the test the wrong way around,
should be
   (*l4hdr_off <=3D input_size - SCTP_COMMON_HEADER_LEN)

Doing it this way we know we aren't going to underflow on
the subtraction (input_size must be bigger than 12 if we got here)
so we don't need to explictly also check for
input_size >=3D *l4hdr_off, but maybe that's being too
clever and your way of writing it is better?

-- PMM

