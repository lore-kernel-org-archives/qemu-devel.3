Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E1CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 05:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK8tT-0001py-Ep; Wed, 28 May 2025 00:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK8tL-0001p6-RT
 for qemu-devel@nongnu.org; Wed, 28 May 2025 00:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uK8tJ-0000iu-PO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 00:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748408388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZLdh2gqAhpIpB6aFAtzVAJYWHTVxKFQBjBOZ+RVqMI=;
 b=NFDr0CmFKqpQSlC8DErihy1uVtmutiS4/1Nz9zq4o0011Yx0NiweuJKVkW+jb9jOiAa1HP
 gtEd+KAOSpWQQTuzZCgF4/Kzyz8dqHP+6OkUpl3EuNZxj6W+12jNqoan/YQPmYFhu9l9xr
 8xPxtUwNc8asIsRqDWhDJW+UrWjWSzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-b-tym54sOm6kktZFnY1J4w-1; Wed,
 28 May 2025 00:59:45 -0400
X-MC-Unique: b-tym54sOm6kktZFnY1J4w-1
X-Mimecast-MFC-AGG-ID: b-tym54sOm6kktZFnY1J4w_1748408383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA4F4195608E; Wed, 28 May 2025 04:59:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4492A180049D; Wed, 28 May 2025 04:59:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93AFC21E675E; Wed, 28 May 2025 06:59:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 michael.roth@amd.com,  thuth@redhat.com,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  peter.maydell@linaro.org,
 berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 15/15] qapi/misc-i386: move errors to their own
 documentation section
In-Reply-To: <5e069cf6-0494-4ddb-98b1-be895b1b464e@linaro.org> (Pierrick
 Bouvier's message of "Tue, 27 May 2025 09:58:51 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-16-pierrick.bouvier@linaro.org>
 <87msayqoz1.fsf@pond.sub.org>
 <5e069cf6-0494-4ddb-98b1-be895b1b464e@linaro.org>
Date: Wed, 28 May 2025 06:59:40 +0200
Message-ID: <87r009jpoj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 5/27/25 4:20 AM, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> My comment on the previous patch applies.
>>=20
>
> I'm not sure to which comment exactly you refer to.

Should've been explicit :)

I'd squash this into PATCH 02.  I figure you didn't because PATCH 02 is
Daniel's.  Here's how I would record provenance when squashing:

    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    [Error documentation tidied up]
    Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

If you want to record why, you could add "at Markus's request".


