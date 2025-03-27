Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AF7C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 05:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txfut-0003tH-Pm; Thu, 27 Mar 2025 01:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txfur-0003t3-FX
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 01:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txfup-0004eO-Dk
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 01:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743053789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXyINpsT14diTrqxYmt1neoUXtrwPNBPkVD6X5SwLz8=;
 b=BR0oNu57lkxQFYzI+HJGWQp3uWPeu33Z8yb4XkHUn6kKhajWcxqsJBYfZhqk5WzrQsKhIh
 BTC3uP/mMpK8H7Xw+XwyQ8bNqYYu+GJj9Ce15M5TIV38xobiZ4ROiRgdnw0uywiNgxI2BD
 3ULTRSn9zO0Pem0M3zkYR4cFFh8NsO0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-ifHlPBUCOe-6mHCoQInQNg-1; Thu,
 27 Mar 2025 01:36:23 -0400
X-MC-Unique: ifHlPBUCOe-6mHCoQInQNg-1
X-Mimecast-MFC-AGG-ID: ifHlPBUCOe-6mHCoQInQNg_1743053783
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A579C190308B; Thu, 27 Mar 2025 05:36:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F9321955D81; Thu, 27 Mar 2025 05:36:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C368921E66C7; Thu, 27 Mar 2025 06:36:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/5] python: update missing dependencies from minreqs
In-Reply-To: <CAFn=p-aixsXRdE86tDS9kBd4azBQ7KU-h-utNkCndykbORAZ8w@mail.gmail.com>
 (John Snow's message of "Wed, 26 Mar 2025 16:12:04 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-4-jsnow@redhat.com>
 <87a598fhnp.fsf@pond.sub.org>
 <CAFn=p-aixsXRdE86tDS9kBd4azBQ7KU-h-utNkCndykbORAZ8w@mail.gmail.com>
Date: Thu, 27 Mar 2025 06:36:17 +0100
Message-ID: <87wmcb2fxq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On Wed, Mar 26, 2025 at 2:08=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > A few transitive dependencies were left floating; as a result, pip's
>> > dependency solver can pull in newer dependencies, which we don't
>> > want. Pin them down.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> What problem exactly does this fix?  Make target check-minreqs?
>>
>
> I'm not sure it's a "problem" as such, but an inconsistency. Yes, it's wi=
th
> check-minreqs -- without this patch, pip is free to choose newer versions
> of these dependencies as appropriate. Though unlikely at this point, in
> theory, new dependency updates could be selected by pip and invalidate the
> concept of an entirely fixed/pinned virtual environment.
>
> That these transitive dependencies were not frozen initially was an
> oversight.
>
> check-minreqs is supposed to build the exact same venv every time without
> fail. Without this change, it's *possible* that it might do something
> different on release day if someone releases a new package. No good,
> probably.

I see.

You've been spoiling me with really nice commit messages...  If you'd
like to push this one to that level, I'd suggest to start with a short
paragraph explaining why we pin versions for check-minreq, then state
the issue being fixed: we missed some pins.

[...]


