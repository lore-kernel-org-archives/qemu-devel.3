Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C76F0181A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRq8-00032I-CR; Fri, 06 Mar 2026 04:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vyRq6-00031V-AU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vyRq4-0005R7-IW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772790678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjUmqcuErT3TcV4gwTK2R6mm8XNAo/OZzt5XgxPx9nU=;
 b=Dv4piMEdYWrQ5IMW+odAyUiPFgkwc40LGbmsJsNOYTLrD42i4T7B0/NA3rgROFwyxhJlLa
 ifFtKediwjjHG1r1DK2xinzKbpJ2umuktrQ3VeoZv33dfV6GQCqPFGqqSU5JhqJ9469F3m
 U/TlxnBgqHvUdDmpqu72a55evytdlWo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-hYp1kqLlOo-NHsnDGq5xNw-1; Fri,
 06 Mar 2026 04:51:15 -0500
X-MC-Unique: hYp1kqLlOo-NHsnDGq5xNw-1
X-Mimecast-MFC-AGG-ID: hYp1kqLlOo-NHsnDGq5xNw_1772790674
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D3621956059; Fri,  6 Mar 2026 09:51:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A06F11958DC5; Fri,  6 Mar 2026 09:51:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 51B1B21E6A04; Fri, 06 Mar 2026 10:51:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] Miscellaneous patches for 2026-03-05
In-Reply-To: <CAFEAcA8FLwV14q_nh3L6Cvw58ZnjfBBuG84ANAm5xDd=6zS5GQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 5 Mar 2026 16:58:37 +0000")
References: <20260305140508.218316-1-armbru@redhat.com>
 <CAFEAcA8FLwV14q_nh3L6Cvw58ZnjfBBuG84ANAm5xDd=6zS5GQ@mail.gmail.com>
Date: Fri, 06 Mar 2026 10:51:11 +0100
Message-ID: <87ldg5i8vk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=1.583, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Thu, 5 Mar 2026 at 14:05, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f004=
6e9:
>>
>>   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu i=
nto staging (2026-03-02 14:01:46 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-03-05
>
> fetching from remote https://repo.or.cz/qemu/armbru.git
> tags/pull-misc-2026-03-05
> fatal: https://repo.or.cz/qemu/armbru.git/info/refs not valid: is this
> a git repository?
>
> Looking at it in a web browser:
>
>> The repo.or.cz site is no longer available in the UK.

https://repo.or.cz/uk-blocked.html

    repo.or.cz / site guide / UK geoblocking

    The repo.or.cz site is no longer available in the UK.

    We hate it as much as you do, but starting 25 July 2025, UK's Online
    Safety Act 2023 would require us to do a prohibitively complicated
    risk assessment for our service. We're talking reading through
    thousands of pages of legal guidelines.

    We're a volunteer operation and would likely be held responsible as
    individuals. There is talk of fines up to 18 million GBP which would
    ruin any single one of us, should they get creative about how to
    actually enforce this.

    Our impression is that this law is deliberately vague, deliberately
    drastic in its enforcement provisions, and specifically aimed
    against websites of all sizes, including hobby projects. In other
    words, this seems to us to be largely indistinguishable from an
    attempt to basically break the internet for all UK citizens.

    If we could afford to just hope for the best, we'd love to. After
    this, I know I will think twice about visiting the UK, but it's not
    like I can be completely certain that I will never have to...

    Our most sincere apologies to our UK-based users.

    For more details, see:

        https://howto.geoblockthe.uk/
        OnlineSafetyAct.co.uk (unofficial page)

To vary the famous motto of the Society for German=E2=80=93Soviet Friendshi=
p:
"Von der Volksrepublik China lernen hei=C3=9Ft siegen lernen."

> If you want your pullreqs applied you'll need to find a different
> place to host them, I'm afraid.

Looks like it.


