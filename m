Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB90C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsLxE-0002yc-3R; Fri, 07 Aug 2026 10:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsLxC-0002y9-Ms
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsLxA-0000a2-IM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786114423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQLcC+zxd8SCT7v+FwTH7k8jGMHO/GfWVn6ICbnVkq8=;
 b=B12xxnV1M/rUJjpxWiyGPd7l5SU2r8WfcH39fp42hVOOZxMyCEfAJi/DlhAbekjJIEYlgV
 A0ZuOZJYoSAJ9knQIGSvSRwZN2kcCLhAv93MN1Aa6Bn/tjvKrOjpATHbdCQ0scglw3kcrX
 SSsddaXnv4n4hw56Muoi29gii0dzh8w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-wE1AEl-5N6C9Ty9oY1fhzQ-1; Fri,
 07 Aug 2026 10:53:31 -0400
X-MC-Unique: wE1AEl-5N6C9Ty9oY1fhzQ-1
X-Mimecast-MFC-AGG-ID: wE1AEl-5N6C9Ty9oY1fhzQ_1786114397
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F90A18005B2; Fri,  7 Aug 2026 14:53:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C123C30001A2; Fri,  7 Aug 2026 14:53:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63A3B21E6920; Fri, 07 Aug 2026 16:53:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Alistair
 Francis <alistair.francis@wdc.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Warner
 Losh <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <anXuqbBXERqn4lPu@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 7 Aug 2026 15:41:45 +0100")
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
 <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
 <anXuqbBXERqn4lPu@redhat.com>
Date: Fri, 07 Aug 2026 16:53:13 +0200
Message-ID: <878q6infs6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 07, 2026 at 01:39:32PM +0100, Peter Maydell wrote:

[...]

>> I don't think we should have AI generated docs, including
>> developer docs, as I noted somewhere up thread. That's not for
>> any particular copyright reasons, it's because we need actual
>> humans to be understanding and writing the documentation,
>> because it can't be easily cross-checked by tests.
>
> IME, it is by writing docs for a feature, that you come to learn about
> the flaws / gaps in the thing that is implemented, which feeds back to
> improve the code.  Generating docs you're just going get text that
> reflects the state of the code without the learning & improvement
> experiance.

100%.  Attempting to write contracts for crap I wrote has made me
recognize it as crap so many times.

> I don't think we should have an exception for tests either. If we
> have code in the tests directory that is generalized to become
> part of the broader codebase, we shouldn't have to think about the
> history of whether the tests code was AI generated.
>
> The boundary between docs and code is also not entirely clear cut
> and intermingled in areas like command line help, QAPI inline
> docs, API doc comments,and so on.
>
> IMHO all content in the repository should be treated the equivalently
> and held to a common standard. IOW, *if* we decide it is reasonable to
> allow limited AI/LLM usage in some manner, prefer to do that universally
> rather than trying to be very selective across sub-directories/files.
>
> Simplicity & clarity of rules makes it more likely that people will
> actually be able to follow them.

Also reduces rules-lawyering temptation.


