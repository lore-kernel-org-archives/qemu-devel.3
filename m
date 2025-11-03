Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D8ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFspz-0004Ji-5R; Mon, 03 Nov 2025 06:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFspx-0004Iu-D0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:35:01 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFspo-0002mH-G4
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:34:59 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63f97c4eccaso2460618d50.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762169688; x=1762774488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahqYMuaxhg5Tz0yUDhZwbC5EyzH/GynsPmQZmN3sFnY=;
 b=LcICj4rmsnqi8/mCLaIiN9sLe9VTCqpJcr6i4cSCiV8g+JGrrHlC3u/aDpnz8fawnT
 CLTGs8V4XuVsiMulNZBbLTBLWuKeXqYMck3vlZob9u5hjFjCGkLxH9X2FDSd78SNPEq1
 71BpLSoQlH5nUFdakCtj8SKngrIzeLB2iYrqFc4zpHNa9Ljxc9S0z6PJRTR6+JSEeGw7
 3tj+jsq2yvvfKkJHVq0gYm422l4BXCGTvSeQIWJVfCmzniE++ZGtXpQeXWq/Uk3m0XzD
 mtiiUBP0UvDZibKdzSrLviU6HXwRSuSZrnFExlqINWFOwEo8ApoQJjddArELg36T1B2y
 mCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762169688; x=1762774488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahqYMuaxhg5Tz0yUDhZwbC5EyzH/GynsPmQZmN3sFnY=;
 b=Z2d4+PX5QJmhh/G2tydunZuYHRUD9BnDdgwigwFx7Oh5Z4teE1M0/pfTCB6J8VmQxH
 8RI955SsjVIhSzQJOT/Z+n+QsZJYCIlNj0AgfjLzhN7JNd40p6rx6UjqjXWPA6Nw2ybN
 nsXI8Uo7R4Qw4nm8/dZhukzg/sK6RZiKPYEr0dXAhnQHvnlV0tKSrl05ik1gRyVL6/b/
 mchE6E1uG9FvO1De1oagMIYBrM3n6T/3nktePMHT7gnPXRTj77f8UVlgMKZQQBk/VY0N
 OVTOV18NxPA7A8aypJS3+s1Gv3B5Ewl8bW7rZPUcSMKr65N27jcHgBPtl1d8ph5/N3ks
 Dtpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcQpp26q8h7Ke3962AY9TFX5BsR8g8h7aNrzW7tXuSJwkFQa+R4ZJ4NZZ1K8Tx3oF1NotkMtxKJkoO@nongnu.org
X-Gm-Message-State: AOJu0YwjF61KXd0HlhhwLJ5bYA7EgNRn0lOq4LIcPzSD6OW44G1MZxH2
 V3IhX0cHXKGjk/FVefAKriR56tzagrlsBco5XA6FF6GKUnn2MNhpscXjlmJ3VOF+y3KjPc6CfFc
 zsPE4GTiHYJq3ioFG1NeMnsrJm09rVNm916CX7IuD9A==
X-Gm-Gg: ASbGncuziq8XB5ttEc8G36SDUUW3UQXXqhs2tqBaa4iOhkyrVyZzeUfJIEEuD2wCXqk
 L6xUpQvymVHzG+qOduei+hoFLGIo6WzpEc/ZSARWw0OUMUqaQKSSNVEL9D2d/n5no6CIgQYFoWe
 RFZqxbEqGzd/uhc9SeV0m0x8C7szByH4NSH89O3ci+QTVPr9uV/soSBRp06vFg4Cv6a3PP6KBGO
 riz/e81G0RNLfds+lasoPykMj3u8+oGEswrhlgMyklr92Vd0LgKfdOfEah8eBsVECWowplf
X-Google-Smtp-Source: AGHT+IF6nQEHBUMKXfvTh7Lr41C13foa1r+oQNF7NasKB/Q/5dzfOJMnlHa8aV9VcVry1BLxfKd6WFO5eEjmwUF4cMo=
X-Received: by 2002:a05:690e:592:b0:63e:231a:cb5a with SMTP id
 956f58d0204a3-63f9232c0bcmr7413126d50.48.1762169688192; Mon, 03 Nov 2025
 03:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
 <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
 <aQDKmM2FFKAusenB@movementarian.org>
In-Reply-To: <aQDKmM2FFKAusenB@movementarian.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 11:34:36 +0000
X-Gm-Features: AWmQ_bneUEnptyIID9C2T6cy3HM3Usa6BmD1mkBAkAqSKbzCVoVNahgMqqjb_dU
Message-ID: <CAFEAcA-cLQTTeuwcCfYRXwv-434_mttDO0oXr_UuaOmkHX370w@mail.gmail.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
To: John Levon <levon@movementarian.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 28 Oct 2025 at 13:52, John Levon <levon@movementarian.org> wrote:
>
> On Tue, Oct 28, 2025 at 01:35:05PM +0000, Peter Maydell wrote:
>
> > On Thu, 10 Jul 2025 at 13:44, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > >
> > > On Thu, 26 Jun 2025 at 08:47, C=C3=A9dric Le Goater <clg@redhat.com> =
wrote:
> > > >
> > > > From: John Levon <john.levon@nutanix.com>
> > > >
> > > > Add the basic implementation for receiving vfio-user messages from =
the
> > > > control socket.
> > > >
> > >
> > > Hi; Coverity suggests there are some issues with this code
> > > (CID 1611807, 1611808, 1611809):
> >
> > Hi; it looks like 1611807 and 1611808 (the resource leaks)
> > are still present in this code in current git; would somebody
> > like to have a look at this?
>
> Please see https://lore.kernel.org/qemu-devel/aG-4hkfLDEpDsqo6@movementar=
ian.org/
>
> I believe them to be false positives.

That email only seems to talk about the locking issue (1611806,
1611809) which we've marked as false-positives in Coverity.
But 1611807 and 1611808 are "failed to free resources" issues:
we allocate memory into reqfds and msg, but in the error
exit path (e.g. if we "goto fatal" because qio_channel_read()
failed) it doesn't look like we ever free that memory.

thanks
-- PMM

