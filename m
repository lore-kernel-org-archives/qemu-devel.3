Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B842606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.a=rsa-sha256 header.s=google header.b=bqrQ+NjP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT2mM-0006Mo-6C; Mon, 16 Nov 2026 14:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.li@samsara.com>)
 id 1xT2mK-0006MG-BW
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:54:12 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gavin.li@samsara.com>)
 id 1xT2mI-0001tx-L1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:54:12 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4af81963f35so3061319b6e.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 11:54:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858849; cv=none;
 d=google.com; s=arc-20260327;
 b=FZyO+MOFvpXlcTkhYWKAvKOrDCxtP3OtD94Pnx2nT6pr/dlweNv4qCmyjDDLN7UNno
 fT3MDrlN87LIKunYRcSpnb3cLTu2M9rtsJ2/BfXdi4qq/o+cH9WaAx7GVoCpCz5Tbhx2
 u5a2OkoSd/7sLNRmpteKhGesqq9iP0SlIu0q2YZ0ggTuRJG1A6ElEUwN8re7Bl4tl3Yt
 36Ww5qetyPv3ILdHI4C7vo4yKFeHddBLwHXFBvqQGbOY1G1sQ3F7tYplFwBAGZU44cW3
 ST+wCNcnemcjw91FvkNLtOLEj/4fULgLcQTr8Oz0D0h3yqS33Xu5EMELHWrL94+QQKVU
 rFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9IxRPVUes4vwIhbav5H9RS1073Sfk/Q69n1LiM1a70Q=;
 fh=OKM02RvmQWu7b6nGBQAM1BfCb8iWAWfhGOV3376jpyw=;
 b=NsshZsC7tUlgPJCqzSvpwXnwN7MtbcUtVq7wrVXQb8NVw4I1G5WxIt+bqy+gPcuO3m
 YhuRlechOxySeUvQpbr0RZTBWoQXmR5fhW7Ma0dLrVa+Ez/cen1jZ73V8nmAC2PlqPR2
 u7dmegz/eY96h3Z1EZxqRnPsMk5v7EQKiWnaAQncLDTKaOsT3SgUuuRIoG84noMHbzF4
 UOa0OZfh4t2+1ULrlSe+2ymxtgnm3iMPEhtpYi6Ue2pFBMU7SdjU5mNsQx+DE2pQRayz
 sITbfPRT3/l0oO1H6QXQmTgI84wv8wCabsD6sgzY9NpBtF6OMVpu23z7gRX/d0DE7Ne/
 OysQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=samsara.com; s=google; t=1794858849; x=1795463649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9IxRPVUes4vwIhbav5H9RS1073Sfk/Q69n1LiM1a70Q=;
 b=bqrQ+NjPTUcnxyNe5tUjrHp5g9h0hsHc07iwKKogeCVBhd9++JgbxkgFB2nK7+GtBE
 wjS8iqUfsgVVdbK6wO2UEB/ZPkeCCbE/C3oq7HbFGNadxg0UJFRJmxmdUakIKXMy8zbW
 X37+h7aVp5YLVPl8LUgYUQr6DsSSOnw0Zu8N0nXnGDY2HGsPqdcQU1LDrqwm0XpwMdzS
 30ITzvZ0h+GKl/A004JrmpPZZdXBOhI4nohwO8FUbHtPCzM3afRPIUoLQCaD9xcAnq5z
 2fUlhqhncc3W61CTgP7+/AMIN7aHsfyECrq146CGYz+eZ3KA6bPM3l3mJU3j2XJIbE9H
 HujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794858849; x=1795463649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9IxRPVUes4vwIhbav5H9RS1073Sfk/Q69n1LiM1a70Q=;
 b=fchh/FapLqdemF5OEC+Ny4tpFaKu1kPKrEGYS+172HVVG1o5J1DiQwQPPQ/7sVB8Dd
 +3EucgCUuvcUGNiDrmie7OE14cC2ZrCnFHqcoiw16R6KKLozoaYIFF7CWzciJMqCcvkY
 n+wPOVYMLQYYRVAvSjMAqdqndOSsjU0oLpVS0YT7jIjna6sQaLuLuWFUBSg+JlWA/KMU
 5hrtMsyBpkKFa5v+lgWauQA157gWh0p4c52cDbO0rd8Q+njFBCtppaG516bGJ/M0OO6o
 8vZNRcrAFkTpdJw8og/iSM+wY96AvHpErbc2/z5poBkucdrnZY6l9WtA7AzaaBweBrly
 U3PQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG3qroP/I5UH7ZXgvVEdyMI3PEwsYlo2d+4KtcOPeFExxBru34OoRq0rGWpsnA5BD7ipEBhm9awux40@nongnu.org
X-Gm-Message-State: APuU4Z+wIBW4OabFJ1EYV/tw/7CJPhbwktvSOPD+LCCcaysiAqIHL96u
 6Mbknp+BxV8+KXr9+ArX5YIn48ep3HOkNJTu1OYmnVzhhI0Ga5VUDWA5JqQN6Tp0RQO3aVtOR8X
 +d03nkMcFeBI1llZHg33gJlp3LwWJuL9BQ6ZIDaqM
X-Gm-Gg: AYBFou3d5tLTN71cw/uN4lakmYEGc1EDBOKQeJzCGSEyr7LekBv39xhVYP9sLzVci5a
 p+d8koZZZYBAiHDPMagpJx/BizUCur01VVLexpPLAOrmyGq+t2FaBk9/LFQ5nd7QtARLGga4cog
 r/bsSaThY6QoR+QxJYvknpT1frY4baZ9766LJAev4n85QbQEmqGznaxER69ykbwReEGVJZi/wC5
 Y9SRnD8lXQlz2LcUMni6oy1V1W4KwsujbDQpwPLhorGXmZackHcHhaOxOO3uIBsA+4KdAHfaTn+
 fA2qNGrdrHvm8nwC3ne8ZZMaj9lKF8Y7r2WPaTTiFmwS/VCSN2V1kmB/aodN+2MWQGykQk/Wl96
 /UrP8GkGfGs7C+KuIrQdJfTX3EP/x8zYinciQ2LjJ0PbcS94PVZNlEqNrdHnkZvj8BnNlGb2gxk
 bdXfUACGfPURk6QAI=
X-Received: by 2002:a05:6808:ecb:b0:55c:836:5955 with SMTP id
 5614622812f47-56e64dfa414mr8954304b6e.44.1794858849021; Mon, 16 Nov 2026
 11:54:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107044225.2786-1-gavin.li@samsara.com>
 <avXZcIP3t8DExhse@redhat.com> <avjim5JwouXNASfm@end>
In-Reply-To: <avjim5JwouXNASfm@end>
From: Gavin Li <gavin.li@samsara.com>
Date: Mon, 16 Nov 2026 11:53:57 -0800
X-Gm-Features: AclHuK--gxfiq2-5u8_r7pAYLtTndRrMIM3VCad-TCTtdMV0s9rQ--NbbWTJDjA
Message-ID: <CAKvMnUXZZhT+rTb7L3ybkrLhh0xma6FKQKKogLLWgtyGPtgV5w@mail.gmail.com>
Subject: Re: [PATCH v1] net: add per-connection guestfwd unix support
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=gavin.li@samsara.com; helo=mail-oi1-x236.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the review all. I've posted a v2 patch that shortens
"unix-per-connection" to "unix2" and updates the commit message
for clarity.

Gavin

On Sat, Nov 14, 2026 at 2:37=E2=80=AFPM Samuel Thibault <samuel.thibault@gn=
u.org> wrote:
>
> Hello,
>
> Daniel P. Berrang=C3=A9, le jeu. 12 nov. 2026 15:21:20 +0000, a ecrit:
> > On Fri, Nov 06, 2026 at 11:42:25PM -0500, Gavin Li wrote:
> > > For -netdev user,guestfwd=3D..., add support for unix-per-connection:=
 in
> > > addition to the currently supported tcp: and cmd:. With
> > > unix-per-connection:, a new connection is opened to the given unix
> > > socket.  This is an improvement over the current unix: support, which
> > > does not support 1:1 guest:host connections.
> >
> > I'm not familiar with guestfwd, but from the manpage, I would
> > rather assume that it always opens a new connection to the host
> > socket for each guest connection.
>
> No, qemu opens the unix socket at initialization and just forwards data
> to it.
>
> > What are its current semantics when two guest connections are
> > initiated on the same port, if that's not happening ?
>
> It's just mixing the data coming from the connections into the unix
> connection, and sending all data from the unix connection to one of the
> tcp connection.
>
> > > diff --git a/net/slirp.c b/net/slirp.c
> > > index 451c0fd1ba..b0b03b2bf5 100644
> > > --- a/net/slirp.c
> > > +++ b/net/slirp.c
> > > @@ -1159,6 +1159,12 @@ static int slirp_guestfwd(SlirpState *s, const=
 char *config_str, Error **errp)
> > >                         "forwarding rule '%s'", config_str);
> > >              return -1;
> > >          }
> > > +    } else if (g_str_has_prefix(p, "unix-per-connection:")) {
> >
> > This is rather a mouthful as a parameter name,
>
> It seemed a bit long to me too.
>
> > and including '-' in the name is undesirable, since we're already
> > using '-' as a general separator.
>
> That's indeed a no-go.
>
> > Could it be just 'unix' to match the use of 'unix' in hostfwd ?
>
> That would prevent from being able to get the one-unix-connection
> behavior.
>
> Samuel
>
> > > +        if (slirp_add_unix(s->slirp, &p[20], &server, port) < 0) {
> > > +            error_setg(errp, "Conflicting/invalid host:port in guest=
 "
> > > +                       "forwarding rule '%s'", config_str);
> > > +            return -1;
> > > +        }
> > >      } else {
> > >          Error *err =3D NULL;
> > >          /*
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 5fe9d73eaa..062cd39aa3 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -3553,6 +3553,15 @@ SRST
> > >              # and connect the TCP stream to its stdin/stdout
> > >              |qemu_system| -nic  'user,id=3Dn1,guestfwd=3Dtcp:10.0.2.=
100:1234-cmd:netcat 10.10.1.1 4321'
> > >
> > > +    ``guestfwd=3D[tcp]:server:port-unix-per-connection:path``
> > > +        With ``unix-per-connection:``, a new connection is opened to=
 the
> > > +        given unix socket per TCP connection made by the guest. The =
unix socket
> > > +        need not exist at startup time.
> >
> > I think the existing docs probably benefit from an update to
> > better show how the new parmeter is different from what I
> > would think was already the semantics.
> >
> > > +
> > > +        .. parsed-literal::
> > > +
> > > +            |qemu_system| -nic user,guestfwd=3Dtcp:10.0.2.100:1234-u=
nix-per-connection:/tmp/socket
> > > +
> > >  ``-netdev tap,id=3Did[,fd=3Dh][,ifname=3Dname][,script=3Dfile][,down=
script=3Ddfile][,br=3Dbridge][,helper=3Dhelper]``
> > >      Configure a host TAP network backend with ID id.
> > >
> > >
> > > base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
> > > --
> > > 2.55.0
> > >

