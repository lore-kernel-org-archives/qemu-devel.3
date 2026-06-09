Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACB1CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuOb-0003JG-Fb; Tue, 09 Jun 2026 07:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wWuOZ-0003J1-HG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:13:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wWuOU-00030E-Qj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:13:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-46015dc517aso4349672f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781003595; x=1781608395; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1IghAgosARcWbQQ3noBtNpja0F6Bfk2uPH/+nYNqAPo=;
 b=hTbepnWRIdgxg5XTlClnTzZQ80sIrFVuSEJh0KrDQbIUA1LY1de37Ai+BfZN/Wkq9x
 xA0jqOklp9Zsu0k1FhswQeQ+DQHDBT8hVbtGltRGL5mHhVpbwgO9rev2+sDko8p3ARpu
 7FL4SRimiBF/SekfbzB72mieKdXWIGr6fgIiJB2iN1nL4OaVvtiCHuocqnDN/L9nfUwV
 s8OeaGKqz2pmOM9kHJd4Tsh4dpKaZkzPABSd5qqwGeKJ1fA/5O2mbhwuBI3V739Oby4a
 kIUTfHwhI6NSOWbvysO63zkJKHPEx8GWsN6HwAh0thDXNg9tB1oCQ4yQfszcYbrvi7CX
 uSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781003595; x=1781608395;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1IghAgosARcWbQQ3noBtNpja0F6Bfk2uPH/+nYNqAPo=;
 b=DP/eEA4ganxMLrSV55ID69QBi7zW3/IkRXfJfNg196bJ1oE00/IUFmUBBHsa7tCsbj
 qSMLhzjQzp0NgnrQzKU0ONyUbotwb42BbIgNJhIOlkL9F1S9NgOBwrP83dGQmN293b1s
 eZhyGFUriE9wWiX+5PxPwGRMhcJnNICR/9pNIumzHh5QOSVM1QLM3OAR5Gdp1b8Y3m4I
 0Hj9ymzpVffJDWLT+7JQKKJRvWTo9DtSEFM2kIoKm+OF501gB432wusmUUhyTKA6O2wJ
 MAeXN/YTilQ77hAqt08fh3Mq6GQdawTjwvl4jUMbSFPGmndEDCdCDNaJmUnaBX+BLkbh
 XXtQ==
X-Gm-Message-State: AOJu0Ywuck6eMLvnmHAGvDGO7mzyvnzQTkNAD8vBgzQ/oPd5+6pm1pHf
 0lO8m+6ESluEomJ4oroSXNQdJRsuGi8dj3+DWOO8u7H1r1t0SZ/qGg6f
X-Gm-Gg: Acq92OFs8bOOmB6I77q9z012EV3QWO78pxVjfJfCI+1i0QULrYkpmuJ61DAl4xltbYc
 EKks6LhuiCYjIvG/D/6chmgaQOOnc05rxUw4ntwIJ6BfeUj/V+j8BeontyDWRvWcjkBddXelyUW
 yGrD4pcVo6mStGGH51PAq5jQsn/BtfctLeACRBRyKIEiwne75R26V2viAcpwAFHPn2QS/WdNf0B
 /krpn7qLKHVnB7uFldki9yKbojDNEbqL/QRAM001f+CSS/krYTSw+/FF1i20j97F7Kj7f85sMYs
 IiAyJO4izgNRJo4NihaMqnMq+4flOnA0/wwZPFtQmJAziXXlP7DmP0c901O1AaVkm3m9psypeI5
 edjkRjsoKNyw6Bm1TfjIGom28owL5cpOfxJInizh1BRYUBALyscqPKsovvYHetqjoDlFwjD7cNz
 L7FCpKyxNYolxNTNn/3nV2yx6QGyvfamtgkVMTqwSartrcskSfA6dCpYHSGjGoP31/oq1W
X-Received: by 2002:adf:f750:0:b0:45e:d8dc:922e with SMTP id
 ffacd0b85a97d-4603063a8ccmr22191925f8f.20.1781003595363; 
 Tue, 09 Jun 2026 04:13:15 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm64785026f8f.6.2026.06.09.04.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 04:13:14 -0700 (PDT)
Message-ID: <ba34daea09f83601c88be90006ca28e3700910d9.camel@gmail.com>
Subject: Re: [PATCH v6 00/12] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Szymon Lukasz
 <noh4hss@gmail.com>
Date: Tue, 09 Jun 2026 13:13:13 +0200
In-Reply-To: <147cee86401993714fa94bd6cc79c4dbbdcaca52.camel@linux.ibm.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
 <20260609040710-mutt-send-email-mst@kernel.org>
 <147cee86401993714fa94bd6cc79c4dbbdcaca52.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2026-06-09 at 10:26 +0200, Maximilian Immanuel Brandtner wrote:
> On Tue, 2026-06-09 at 04:09 -0400, Michael S. Tsirkin wrote:
> > On Tue, Jun 09, 2026 at 10:02:40AM +0200, Maximilian Immanuel
> > Brandtner wrote:
> > > What's the status of this series? It seems to me to have somewhat
> > > stalled, because of the virtio resize event discrepancy that has
> > > been
> > > adressed by backporting the relevant patch. At this point it's been
> > > almost 6 months since any changes have been made to this patch-set,
> > > even though at this point it would have to be refactored to address
> > > changes that have been made to QEMU since. Has progress on this
> > > patch-
> > > set just stalled or are there any remaining concerns about the
> > > implementation of this patch-set I'm unaware of?
> > >=20
> > > Kind regards,
> > > Max Brandtner
> >=20
> > Whom are you asking?
> > There were comments on patches 7 and 8 and Filip seems to have
> > indicated
> > he intends to address them, and even posted diffs.
> > So now, I expect v7 with that.
> I suppose Filip for the most part. It's just that close to 6 months of
> inactivity is quite a while and sometimes as other stuff happens people
> can forget about a patch-series.
>=20
> Kind regards,
> Max Brandtner

Hi all,

Sorry, I did indeed forget about the series.

From what I remember, I was trying to address an issue with the size
not being updated after a migration, and it turned out fixing this
required adding the current size to the migration stream (in order to
avoid sending unnecessary resize events when the size doesn't change,
which MST pointed out would add guest performance overhead).

However, since virtio console serialization still uses save/load
methods rather than VMState macros, I couldn't simply add a subsection,
so I wasn't quite sure how to proceed. It seemed like the right thing
to do was to migrate virtio-console to VMState, but that would have
taken more effort than I was willing to put in at that moment. And then
some other stuff happened in my life and now here we are.

So anyway, in order to make progress on this, I see two approaches:

1. Just bump the migration stream version. Makes the loading code more
convoluted due to version checks and increases tech dept for future
VMState migration, but shouldn't be that hard to do.

2. Do the VMState migration now. This is complicated by the fact the on
load,=C2=A0some of the state shouldn't be restored back into the field that
was saved, but instead should be compared and the guest notified if it
is different. I'm also not quite sure how hard it will be to preserve
migration stream compatibility.

Which one would be preferable to do?

Kind regards,
Filip Hejsek

