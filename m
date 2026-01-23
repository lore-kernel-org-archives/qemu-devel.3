Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951DCD6CFA7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGNU-0004Kg-KG; Fri, 23 Jan 2026 07:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjGNR-0004H0-FU
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:35:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjGNP-00011f-C4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769171697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GuaM5QZWrzPhMgMHGFD+LPWPBPdMRyucP5psZS8/K6Q=;
 b=YXwGd2IUIifbSBrZqTSrVmUl0GgOmL9n913NtZUj/+096CGDqPePBjIveaNKVKHU10Dj00
 pa8TGinIoL3yos36+rlfMybR5krGK5CkiKXOcq64DuE8T3EL7OM2FIF9mBgm3juEON6NdM
 1dQ9iBI73CGgaOfkAQaiJJuwtUpWStM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-OLWx6Co3N8GtK408F607Lw-1; Fri,
 23 Jan 2026 07:34:53 -0500
X-MC-Unique: OLWx6Co3N8GtK408F607Lw-1
X-Mimecast-MFC-AGG-ID: OLWx6Co3N8GtK408F607Lw_1769171692
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE3721955D97; Fri, 23 Jan 2026 12:34:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C5251958DC1; Fri, 23 Jan 2026 12:34:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D90D821E692D; Fri, 23 Jan 2026 13:34:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 3/4] qemu-options.hx: Drop uses of @var
In-Reply-To: <CAFEAcA8GamFCGxPwptjQS5XKGVU=sX1t4yjZWLZDVq+uoAWNdA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 20 Jan 2026 13:07:57 +0000")
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-4-peter.maydell@linaro.org>
 <87o6mplkjk.fsf@pond.sub.org>
 <CAFEAcA8=psrFCnssVUdSwUrw16x3rBRjB=BV0VmGc1MiMDxPZA@mail.gmail.com>
 <CAFEAcA8GamFCGxPwptjQS5XKGVU=sX1t4yjZWLZDVq+uoAWNdA@mail.gmail.com>
Date: Fri, 23 Jan 2026 13:34:48 +0100
Message-ID: <878qdobj87.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 19 Jan 2026 at 15:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 19 Jan 2026 at 14:55, Markus Armbruster <armbru@redhat.com> wrote:
>> >
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> >
>> > > A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
>> > > when documenting an option that takes an argument. This syntax isn't
>> > > consistently used, and the documentation generation has no support for
>> > > it: it just appears literally in the HTML output.
>> >
>> > TexInfo leftovers?
>> >
>> > > Switch these uses to the more common "my-option=<name>". This also
>> > > doesn't have any particular support in the documentation generation
>> > > and so appears literally in the output, but it is a little less odd
>> > > looking to the end-user.
>> >
>> > Note for later: rewrite 1 is from KEY=@var{VALUE} to KEY=<VALUE>.
>>
>> More generally, any uses of @var{} to KEY=<VALUE>.
>>
>> > > The other common pattern we have is "my-option=name" with no marking
>> > > at all that the right hand side of the '=' is not literal text;
>> > > using <> seems preferable to me, as it makes it more distinct from
>> > > cases where the right hand side is documenting that only certain
>> > > values are permitted, as in "my-option=on|off".
>> >
>> > Rewrite 2 is from KEY=VALUE to KEY=<VALUE>.
>>
>> This patch is not trying to do any rewrite 2; this part of
>> the commit message is just noting that we are not consistent
>> about KEY=<VALUE> currently, and so we had another option for
>> how to fix the @var{} usage, and explaining why I didn't take
>> that other option.

Ah, I didn't get that.

>> > > We don't change the uses of @var in the colo-compare documentation,
>> > > as that part deserves a slightly more wide-ranging overhaul that
>> > > is better in its own commit.
>> > >
>
>
>> > So, what this patch actually does is rewrite 1 plus add missing values.
>> > Could be separate patches, up to you.  Regardless, the commit message
>> > should match what the patch does.
>>
>> I think it does. Perhaps it could be more clearly stated...
>
> So if we make the commit message be this:
>
> ===begin===
> A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
> (or @var{} with no name specified) when documenting an option that takes
> an argument. This syntax isn't consistently used, and the documentation
> generation has no support for it: it just appears literally in the
> HTML output.
>
> Switch these uses to the more common "my-option=<name>". This also
> doesn't have any particular support in the documentation generation
> and so appears literally in the output, but it is a little less odd
> looking to the end-user.
>
> The other common pattern we have is "my-option=name" with no marking
> at all that the right hand side of the '=' is not literal text;
> using <> seems preferable to me, as it makes it more distinct from
> cases where the right hand side is documenting that only certain
> values are permitted, as in "my-option=on|off". This patch doesn't
> do anything about existing uses of this pattern (except in one case
> which was so confused as to use "my-option=@var{}" in the --help
> output and "my-option=" in the RST output, where we change both
> for consistency), but prefers not to add more of them.
>
> We don't change the uses of @var in the colo-compare documentation,
> as that part deserves a slightly more wide-ranging overhaul that
> is better in its own commit.
> ===endit===
>
> is that clearer ?

Yes, it is.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


