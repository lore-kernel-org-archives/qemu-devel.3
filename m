Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580A7CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 21:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrPB1-0004FE-2a; Mon, 01 Apr 2024 17:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rrPAw-0004Ez-H5
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:26:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rrPAt-00026p-OM
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:26:42 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a47385a4379so972178766b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1712006796; x=1712611596; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tq+u5OzCvV2OTLzw94sjtx6pNhPNziYZCiKmRN5/jV8=;
 b=BO39I/xAWNqoPb986jbL69vTUAd0G+w2z0w6jw9V4aJVs4AJjVIC1ihyzjhclWwK4D
 mO7eee3zR1XjOVe7vfU/RHSy+6SPPXcTFFQirg6zB4qun0Kx9kcXnqExfoFxNePQNwbW
 yiVfdXzOICp9oSHquJrx5+oOe8bmhGQXxlY2J6+Q3z4CXx/TQqLbqf+WbR3VnHKk9ufK
 qq2OSzux7Nh4ld+Yf3+N4bfJ1dfIWld44JFqxsp4Mg+7u5bT60+MvMFe1mCCgblzTr1M
 CkJqhh7HhD5DFrY2ln7T890B+56AHaaSEg7N8YPGPpiN9CS4sNhjZrjwmh6b0b5WibTb
 goCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712006796; x=1712611596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tq+u5OzCvV2OTLzw94sjtx6pNhPNziYZCiKmRN5/jV8=;
 b=nk7f7T5lzdmzxLckYAvpvszZU52t80m76h5qpGvwDATPUIi5h9tq3U/+LuiPKbTcSu
 EGbxv+0G8+yII0S+up8aHNLpiSqiPipQfKvGh1m0um9QATvcJrfREVpH8iTNBMowfvZe
 WiNAj+phP8WLgcTbF9mOUhRleh+QwIa6ZaiR6YOCjyZCoPKa/8cmsBtByMi4IPg5/aj9
 PkB09kZq1Q5VNqc6QK1sT0InVAnhArQQ7TVYyNh2gFP6RCVnW3GsQA4opCgmBsj31DJk
 5y1yAalJfY5bAAaJRL68ihP6FMcyu6fzhAGqEEIFSttDFtp1mYbuQsgoTDeFTV9zJSM/
 zo4Q==
X-Gm-Message-State: AOJu0YxCA+v6J7WTcLu6k8ad72SoNjarYGx+Q4q2fQE8VNMkw1tPIztA
 qUS8hG4CEZ0KMEftZkAPszLJNg3IWl2SZ3PNBIL3JO4Y4bdjGt1GED+sAwW0SdzzKQ3NY6z6auL
 WJUdBXjLPXdZjSTTEv/aZFQKjJtqZP5OtLtVHSA==
X-Google-Smtp-Source: AGHT+IGgIZDrHLqI2Ng4kKxqZZh2VwsHyQQ/5JLbQD3lfN0X5cfFeNZDnyCnJ5xLWDM0KSqrpa2fXCaluF9ORVi5jfo=
X-Received: by 2002:a17:906:f216:b0:a4e:86ff:5624 with SMTP id
 gt22-20020a170906f21600b00a4e86ff5624mr161134ejb.5.1712006796212; Mon, 01 Apr
 2024 14:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org>
 <87frwatp7n.fsf@suse.de> <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
In-Reply-To: <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 1 Apr 2024 23:26:25 +0200
Message-ID: <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62a;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Peter und Zhjian,

Thank you so much for letting me know about this. I'm also a bit surprised =
at
the plan for deprecating the RDMA migration subsystem.

> IMHO it's more important to know whether there are still users and whethe=
r
> they would still like to see it around.

> I admit RDMA migration was lack of testing(unit/CI test), which led to th=
e a few
> obvious bugs being noticed too late.

Yes, we are a user of this subsystem. I was unaware of the lack of test cov=
erage
for this part. As soon as 8.2 was released, I saw that many of the
migration test
cases failed and came to realize that there might be a bug between 8.1
and 8.2, but
was unable to confirm and report it quickly to you.

The maintenance of this part could be too costly or difficult from
your point of view.

My concern is, this plan will forces a few QEMU users (not sure how
many) like us
either to stick to the RDMA migration by using an increasingly older
version of QEMU,
or to abandon the currently used RDMA migration.

Best regards,
Yu Zhang

On Mon, Apr 1, 2024 at 9:56=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
> Phil,
>
> on 3/29/2024 6:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>
> >>
> >>> IMHO it's more important to know whether there are still users and
> >>> whether
> >>> they would still like to see it around.
> >>
> >> Agree.
> >> I didn't immediately express my opinion in V1 because I'm also
> >> consulting our
> >> customers for this feature in the future.
> >>
> >> Personally, I agree with Perter's idea that "I'd slightly prefer
> >> postponing it one
> >> more release which might help a bit of our downstream maintenance"
> >
> > Do you mind posting a deprecation patch to clarify the situation?
> >
>
> No problem, i just posted a deprecation patch, please take a look.
> https://lore.kernel.org/qemu-devel/20240401035947.3310834-1-lizhijian@fuj=
itsu.com/T/#u
>
> Thanks
> Zhijian

