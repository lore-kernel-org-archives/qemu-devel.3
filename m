Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqUvC-0003Tc-Op; Fri, 07 Mar 2025 05:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqUvB-0003S3-3R
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqUv9-0004DD-2m
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741343225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsrYu00qSqSWwQcNxn144uxCBY/nfKK5w3z5gVU82Io=;
 b=D71In9Q5tRq2W7HB0ZZCnnLPipXdW5Jb59s+OAy8D8oDYwFnmb2h0aDnrsG/dVxJUwOVs1
 QNiqnnme5MFtn1/dKdbx3PbC5bgXL7gOf0niJUswzbyk98R4P1bvNb8iMsfOiZKOYG1kwT
 2Z94bgvV31hc8PETCOJaDYQKWIDBawU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-6d_jA4UOOQW9OT1Vpo_eiw-1; Fri,
 07 Mar 2025 05:26:52 -0500
X-MC-Unique: 6d_jA4UOOQW9OT1Vpo_eiw-1
X-Mimecast-MFC-AGG-ID: 6d_jA4UOOQW9OT1Vpo_eiw_1741343205
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D80E3180AF7C; Fri,  7 Mar 2025 10:26:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 754681801747; Fri,  7 Mar 2025 10:26:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2BB521E675E; Fri, 07 Mar 2025 11:26:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 19/57] docs/qapi-domain: add qapi:event directive
In-Reply-To: <20250305034610.960147-20-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:28 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-20-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 11:26:41 +0100
Message-ID: <87v7slm90e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> Adds the .. qapi:event:: directive, object, and :qapi:event:`name`
> cross-referencing role.
>
> Adds the :memb type name: field list syntax for documenting event data
> members. As this syntax and phrasing will be shared with Structs and
> Unions as well, add the field list definition to a shared abstract
> class.

docs/devel/qapi-code-gen.rst calls it "event-specific data".  This is
quite a mouthful, so the code usually calls it "arguments".  Not least
because events are kind of like commands going in the other direction
(client to server), and the code dealing with them is often similar.

Both names make more sense to me than "member".  Hmm.  A rename could be
done as a follow-up if that's more convenient for you.

> As per usual, QAPI cross-referencing for types in the member field list
> will be added in a forthcoming commit.
>
> Signed-off-by: John Snow <jsnow@redhat.com>


