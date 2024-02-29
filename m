Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704E9C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfk0r-0003wC-Q2; Thu, 29 Feb 2024 12:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rfk0q-0003vm-2l
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:16:04 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rfk0l-000467-UC
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:16:03 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-428405a0205so501191cf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709226959; x=1709831759; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8WVml8H9GFNzLXcIlN/78SlXq6skFQr/5fNLhBE0EU=;
 b=cYOkJ7JkLw/CWLqEjnz+DRS/iXR7i3NKDLw09514wOgZ0R/uJVOezcpcW5/idv/B6W
 cTEGXGuk1+4UAPJQWMCSfqrJyiHgdzXTR2ND3DBU3XX/3cCAY+jPN6N8mYAd6pjUA0Le
 l6TSWKOhp3nYtucP139iQVARfVgQ/CFRIGeiZiB3gsEXG/eRlQwlEytfwuINcsGLhhwl
 sSN4/sDwkTtYk94i9R1o68Rs5BvYH1Q+xouk7bPdsSw5bcWuE9D4DI3BdpeqTxTlp6oy
 8O6A89klPz2PawLwp+qJbV2r+V6T7JRkFc61EMMdrsNAVTH8wXPU45MbJdsh3XCEaVl+
 XKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709226959; x=1709831759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8WVml8H9GFNzLXcIlN/78SlXq6skFQr/5fNLhBE0EU=;
 b=MdZuXLm7ZEsZGuLwpZhG2Riv9c4ktbqOa5EKDC0anQ5lyI+uaPAUh7NymrYT3oMs3G
 Fl21GJguUhk7rGDF08KV1pnaXoBN/8PVPig7aSfVbEhZ7FTMWHshCPtP7luPORVS6zu0
 YvigAwS/J1K+84YCDTZ+4AhX4563131Eosj4UalN4lPPrtp6z7JumxiRVLvm74F9fT8o
 TSVHoocthoJI8zum7M1dOD6WmqBvirDFLsnMkmEvxRr3yW5AnZCNPnbeyKWFSd4znFhQ
 T5+4d+jev7vzi534SDVE/8XOOI6pqFcDN8O4srWonyzTAKI/m4xHWHwGSt1VZ63VTYCP
 lYOg==
X-Gm-Message-State: AOJu0YxpR3DK/ENDpih5UKCLNBjDIsNqJ46nI8hejeGnKH1VEAbmz0qP
 upc2NIouX765VeqA1yiuQ346RgaYSgUYJp2vffoZJ70D9RPExUvcBAYmGIrJ5GvNWEKjrq/HMyo
 bfiyS9UAs7FrmREMSMA90S840vehrs3PUKWuV
X-Google-Smtp-Source: AGHT+IF3FQAUUsYv1D5879zD2ZseroNpumUYXfoY0cA88RGzhnyw2N1R2f0zgl+qAKbvrFmVMqrlFULrgczzzyglpng=
X-Received: by 2002:ac8:4a12:0:b0:42e:8094:885b with SMTP id
 x18-20020ac84a12000000b0042e8094885bmr235775qtq.21.1709226958574; Thu, 29 Feb
 2024 09:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
 <CAFEAcA-EnsmNkLuJb-dVZbT0+2TPJSw94eeEbx7JNiULsMKgUg@mail.gmail.com>
 <CAGDLtxu-+5-Bc+BGbZZPWfZOjdKJzNDkOz_BxJEmHNoNFnYpbA@mail.gmail.com>
 <CAFEAcA-kT8-=TtkTsS7QoYCV_GGLOY5zA0sXAFnP+ZFi+Lx4_A@mail.gmail.com>
In-Reply-To: <CAFEAcA-kT8-=TtkTsS7QoYCV_GGLOY5zA0sXAFnP+ZFi+Lx4_A@mail.gmail.com>
From: Joe Komlodi <komlodi@google.com>
Date: Thu, 29 Feb 2024 09:15:43 -0800
Message-ID: <CAGDLtxvPVyu-b6H-zG8dGY7Kj-gg+xeEMbUGnRHaVT0-M0GJcg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] memattrs: target/arm: add user-defined and
 requester ID memattrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=komlodi@google.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 1:57=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 29 Feb 2024 at 04:52, Joe Komlodi <komlodi@google.com> wrote:
> > On Wed, Feb 28, 2024 at 6:21=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > > So as far as I can see, this patchset defines a bunch of mechanism,
> > > but no actual users: no device looks at these new memattrs, no board
> > > code sets the properties. I don't really want to add this without
> > > an upstream usecase for it.
> >
> > Yeah, I believe the current use-cases for this series are mostly downst=
ream.
> > It's possible that there's an upstream device that might benefit from
> > it, but I'm not aware of one.
> >
> > Is the concern the usefulness of the series, or the worry about it bit-=
rotting?
> > If it's the latter, would a qtest be alright to make sure it doesn't ro=
t?
>
> My main issues are:
>  * it's hard to review design without the uses of the code
>  * it's extra complexity and maintenance burden that we don't
>    need (upstream): accepting the patches gives upstream extra
>    work to deal with into the future with no benefit to us
>  * dead code is code that typically we would remove
>  * we end up with something we can't refactor or clean up
>    or change because the only reason we have it is for code
>    that we don't have any visibility into: effectively it
>    becomes an API for us that we can't change, which is not
>    something QEMU does except for specific well defined API
>    surfaces (QMP, plugins, etc)
>
> Our usual approach is "submit the patches that add the new core
> feature/mechanism along with the patches that add the new
> device/board/etc that uses it". Compare the recent patches
> also from Google for the ITS and SMMU that try to add hooks
> that aren't needed by anything in upstream QEMU:
> https://patchew.org/QEMU/20240221171716.1260192-1-nabihestefan@google.com=
/20240221171716.1260192-3-nabihestefan@google.com/
> https://patchew.org/QEMU/20240221173325.1494895-1-nabihestefan@google.com=
/20240221173325.1494895-3-nabihestefan@google.com/
> -- we rejected those for the same reason.

Makes sense!
Thanks for taking the time to look over them.

- Joe
>
> thanks
> -- PMM

