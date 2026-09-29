Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F12BCA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBc3Q-0008Qf-Hs; Tue, 29 Sep 2026 13:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBc3O-0008QF-3c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:55:46 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBc3M-0005oj-4r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:55:45 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so36522495e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704542; x=1791309342; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q/BuCOvJ6OZb8JFuCJ8maYEk9B0YbI/S3sL9hGTTcfM=;
 b=sZ9dQowRCmcfkU5tPr7I+BjA7d1TL+I05i8bJtXGJMi6LGqBairo0A2cXznEJZW0bn
 YowGlc+ccA4pEJfSmgyN6DxsfY/d1T2ve/CZ68yes2lqaRul5Xqu4cIBzB8GChG0GgML
 5QEazeygiUdtwCOrZ4lSFbuuxD+xgfTj4qR+KpD2EvxiB1a4JcFkScq3szo9UgyvjcSl
 FyXDkM+aBXJQo2uNFxZu2Sb5QznTnnKuxNaOl5+opkwQjr7QjYgLg2pisFagopAcBNxN
 AhAYUf7DKStPUC6rjEtRx8xvT91rK0zp3PTsMc6N2BRIrOPGGqZC7Lgv8Htgj6l9H70i
 ZlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704542; x=1791309342;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q/BuCOvJ6OZb8JFuCJ8maYEk9B0YbI/S3sL9hGTTcfM=;
 b=z3H9EWtCMZ/i9JGjbwhkD0hFuC5ffXKliKDJcYKlqe+1DPw1WvEzrpjt1TwWXa6+HT
 STfWWjUH1cxK5vZn5WjRY++RhMo/18T/TQmelrMpZjPjpH1UJzwZqlB+BnAQAodeYOfT
 9W08qaCRNfOO7sA/OHOKkWSQpAXZhcC6M7j8689EZH723hHXLCCmHelfdk2J0LF0khpt
 eymjy4qjwedCLjw+eiv8riikd4jW0fkYQm9b2W91oKOgx6+930l6xWV3vC6DfueYQLh3
 VJgnAjKd6ELq4BJwM7SNlSfsI2ZbTAjscYKSRUQn/rdBcHqqgUzKz1gmJ1ZFt0loWxtc
 3Vxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz51BuE+pY57QAIu0AuD66aDu/0rCYfzWdjFwuP+PVJ2RszINpG9Aj8BHRrgt3RCWSsJqBwT0JBtDvd@nongnu.org
X-Gm-Message-State: AFuF++ljWuHaF0cyM/VBbjLNugLqXm3PnfJD87ZqdWwX9vZu/FD7KFtn
 bNlSdtlDVLK/lZrUAd6aL3twEQDkRoQvXmPKoEFMjjoSq7RmCzhTn1L6
X-Gm-Gg: AYBFou0XtzNajHtdYh8YCTd/l7e5vq/uYVifAcz+VHJnABZAXXRNUu8SQLBrqTghHat
 uRl5Yge+HELrNn5Y1YkDFjqP1btPmnFMl56HDpDNnuUSFFYridZbwO/DH9ltSQ/Vahh2VO0qQ35
 5t3TqCM/u8dM+LnIgyehex2QWHpeLgDbz28r83392MTc8+qlvBhccjNi+IcP245DpAC4EzJXP6p
 Hr8BSG1HwcfnXwXNJOWDC4IjrktlkSu6/5hR298QQDBr9aRA8M8leugFvLtecQDRegbAZ5Oj7Lo
 DTAxqR9auc/raFUiBLjlDg1gCNFvFICPMzCtkaUf28Cm/A7gDpK4dnIztwx+o64oTWv0RRiE4HH
 09EutiDy8qfLA+R7m5qGCqrPf9x6iSSdK/gSFgVJxUevM51gbJxuT3X77PoEkyW6RhTAJgU6xzE
 b0InOGZxqPKYnJv41ZFofyIu+A3zrrGW0ekfZPP4LRIJ6cdx3YXIvHFqeC3hmU4dIffkWwcjTok
 V86cEFnzsnT3NCsVkkVC7iVdmS9L/qqTg==
X-Received: by 2002:a05:600c:8718:b0:49c:fa21:1c84 with SMTP id
 5b1f17b1804b1-49fe7bba7e7mr273884345e9.25.1790704542297; 
 Tue, 29 Sep 2026 10:55:42 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48afe69d799sm323505f8f.23.2026.09.29.10.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:55:41 -0700 (PDT)
Message-ID: <bf452c638ccd8461a21efe9115baafb6a9c44729.camel@gmail.com>
Subject: Re: [PATCH v7 00/12] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maximilian Immanuel Brandtner	
 <maxbr@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Cornelia Huck	
 <cohuck@redhat.com>, qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?=
 Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier	 <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus
 Armbruster	 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo
 Habkost	 <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@mailo.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Tue, 29 Sep 2026 19:55:39 +0200
In-Reply-To: <art3zrOdxq5o3Qxz@redhat.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
 <20260928054918-mutt-send-email-mst@kernel.org>
 <7ac1826c-3891-4750-b5b9-c5f2a4217396@linux.ibm.com>
 <art3zrOdxq5o3Qxz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 2026-09-29 at 09:33 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Sep 28, 2026 at 05:21:25PM -0400, Matthew Rosato wrote:
> > On 9/28/26 5:50 AM, Michael S. Tsirkin wrote:
> > > On Mon, Sep 28, 2026 at 11:30:03AM +0200, Maximilian Immanuel Brandtn=
er wrote:
> > > > I would really appreciate it, if this patch-set could be merged. I =
know
> > > > that things can get really busy, but it seems to me that there aren=
't
> > > > any blockers that should prevent this patch-set from being merged
> > > > (apart from some minor refactors), even as is.
> > >=20
> > > Why not address the minor comments you got?
> > >=20
> >=20
> > Just to clarify, Max did not write the subject series; he is expressing
> > interest in it because he wrote a patch that builds upon it for s390x
> > [1].=20
> >=20
> > Now, I'm not asking anyone to take code that isn't ready; but I would
> > like to understand if this series is abandoned or if the developer is
> > planning to send a v8 so we (s390x maintainers) know what to do about
> > Max's patch.
> >=20
> > @Filip, do you plan to respin and address the comments you received?=
=20
> > There isn't much, but it looks like there was at least one real bug
> > identified.
>=20
> The series also has conflicts with Git master, so cannot be applied
> as is.
>=20
> With regards,
> Daniel

Hi all,

I've sent a v8 [1], which is a rebase on master plus the uninitialized
buffer fix suggested by Marc-Andr=C3=A9 Lureau.

Sorry for the delay, and thanks for the nudge, which got me to come
back to it. I do this in my free time, so progress comes in bursts, but
feel free to nag me if I don't respond for a while again.

I originally planned to include a fix for the migration issue in v8
too, but I don't have time right now for implementing the necessary
migration stream changes. I think you can merge it without the fix, as
it's only a minor issue, but I hope it can be fixed in a follow-up. If
someone wants to pick that up, help is welcome. I have a rough WIP
refactor of virtio-serial serialization to use VMState at [2], which
might be useful as a starting point if that is the chosen approach.

Matthew, Max: I hope this unblocks the s390x patch.

[1]: https://lore.kernel.org/qemu-devel/20260929-console-resize-v8-0-2ff918=
3f8750@gmail.com
[2]: https://gitlab.com/filip-hejsek/qemu/-/commits/b4/virtio-serial-vmstat=
e

Best regards,
Filip

