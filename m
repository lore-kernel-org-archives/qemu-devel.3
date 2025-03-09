Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CAEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNk2-0004ib-2t; Sun, 09 Mar 2025 16:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNjj-0004Si-FF
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNjX-0007EF-TH
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741553821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ro8XkoWL2wyA0+551wDEq005vzKjyzvoRrDng2tN6Aw=;
 b=LOX0A/W14FjESFO6uWuyQqxn+rrldBhF2nvy14qxtyfp09Anku1zgSOUTfnKEalnqO6fB6
 EUOB7RFUr4CYsgFSDKUK7DMayY8qWciYg4AgkgA5C5n7C7KP0f17qF6ZihBCiRNrYEFEcW
 ng3jnkOwJu5F7h097dZHUHM/KRASHYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-5oUufa6fNVyswBvnSfLkaQ-1; Sun,
 09 Mar 2025 16:51:27 -0400
X-MC-Unique: 5oUufa6fNVyswBvnSfLkaQ-1
X-Mimecast-MFC-AGG-ID: 5oUufa6fNVyswBvnSfLkaQ_1741553486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 869A9180035C; Sun,  9 Mar 2025 20:51:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28847180094A; Sun,  9 Mar 2025 20:51:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B3C0121E675F; Sun, 09 Mar 2025 21:51:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell
 <peter.maydell@linaro.org>,  Harmonie Snow <harmonie@gmail.com>
Subject: Re: [PATCH v2 23/62] docs/qapi-domain: add :deprecated: directive
 option
In-Reply-To: <20250309083550.5155-24-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:10 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-24-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 21:51:23 +0100
Message-ID: <87y0xeylkk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

> Although "deprecated" is a feature (and *will* appear in the features
> list), add a special :deprecated: option to generate an eye-catch that
> makes this information very hard to miss.
>
> (The intent is to modify qapidoc.py to add this option whenever it
> detects that the features list attached to a definition contains the
> "deprecated" entry.)
>
> -
>
> RFC: Technically, this object-level option is un-needed and could be
> replaced with a standard content-level directive that e.g. qapidoc.py
> could insert at the beginning of the content block. I've done it here as
> an option to demonstrate how it would be possible to do.
>
> It's a matter of taste for "where" we feel like implementing it.
>
> One benefit of doing it this way is that we can create a single
> containing box to set CSS style options controlling the flow of multiple
> infoboxes. The other way to achieve that would be to create a directive
> that allows us to set multiple options instead, e.g.:
>
> .. qapi:infoboxes:: deprecated unstable
>
> or possibly:
>
> .. qapi:infoboxes::
>    :deprecated:
>    :unstable:
>
> For now, I've left these as top-level QAPI object options. "Hey, it works."

I think we agreed to delete the text from RFC: until here.

> P.S., I outsourced the CSS ;)
>
> Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> Signed-off-by: John Snow <jsnow@redhat.com>


