Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EF8C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 06:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txJs7-00080D-UN; Wed, 26 Mar 2025 02:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJs6-0007zx-L0
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJs1-00016W-RG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742969047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8V0wOoWpcgb+ZXLHkEKHPYnZEQOB/5pzF7hExASutnE=;
 b=IOMCGSgUUNOviwaWfJQiylai8jZGR59ndrVIE8074joCLuisxkdw9jb/QsbP9Vu/Y70xts
 SoRVpUR3bdhViAxGSFwNzACoyFWEGffh0tB5JsBO7fwMCgIrz67+TjagQ4u42N8DqtZ6jk
 XDWOlH412tjW1xbrAvpGXWZSy61QOaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-hAEbsg8dPHy0YAOznXY-Ng-1; Wed,
 26 Mar 2025 02:04:05 -0400
X-MC-Unique: hAEbsg8dPHy0YAOznXY-Ng-1
X-Mimecast-MFC-AGG-ID: hAEbsg8dPHy0YAOznXY-Ng_1742969044
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58776180AB16; Wed, 26 Mar 2025 06:04:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE04F1801751; Wed, 26 Mar 2025 06:04:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12ED521E66C7; Wed, 26 Mar 2025 07:04:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/5] docs/qapidoc: linting fixes
In-Reply-To: <CAFn=p-a1siA=PTGpO+PsW5x6uvEBV2=nm-8GV7mmxEcKnGQO2g@mail.gmail.com>
 (John Snow's message of "Tue, 25 Mar 2025 12:49:01 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-3-jsnow@redhat.com>
 <87y0wtpnod.fsf@pond.sub.org>
 <CAFn=p-a1siA=PTGpO+PsW5x6uvEBV2=nm-8GV7mmxEcKnGQO2g@mail.gmail.com>
Date: Wed, 26 Mar 2025 07:04:01 +0100
Message-ID: <87jz8cfhv2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Mar 25, 2025 at 3:36=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This restores the linting baseline in qapidoc. The order of some impor=
ts
>> > have changed slightly due to configuring isort a little better: isort
>>
>> Changed since when / what?
>>
>
> Changed as of this patch. Before, I was running isort directly from the
> docs/sphinx folder, but now I'm running it from the Python directory with
> some improved configuration as I explain in this commit: by teaching isort
> that compat and qapidoc_legacy are local modules, isort decides to arrange
> them differently.
>
> Imports should always go in three sections, in order:
>
> 1. Standard library imports
> 2. Third party imports
> 3. First party (local) imports
>
> Before, it was not, because it does not understand "docs/sphinx" as a loc=
al
> package with local modules - I think it gets confused because of the fold=
er
> being named "sphinx".
>
> Really, I am just explaining why some imports get shuffled around a little
> bit - the new order is "correct" and the old order was slightly wrong.

Please use "The order of imorts change" instead of "have changed".
Present tense makes it clear that you're talking about this patch.

>> > was having difficulty understanding that "compat" and "qapidoc_legacy"
>> > were local modules because docs/sphinx "isn't a python package".
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>


