Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C73BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCbK6-0007Ad-G9; Fri, 02 Oct 2026 07:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCbK4-00079D-RU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCbK3-0002Xz-44
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790940060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UAFkqquxeQox2MVLbIf4YS5Fk7ngyqaEgHnNDemgDM=;
 b=eukNqPNvxa7atahTEmQWnn/GavDgyrGARsLCAZe+g6hHXR5U0587eF8nemJeeLJU9pstHL
 TIoX9BKFPFWbeVrvpEH5QrdKLtkhSe57nOkEomIBb7qgtShC1LlNpiFO6rFbVIgZsFfg7E
 iknd23cj1vfNSPu5m3/WZNF1+pBiqfc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-NeXnrxMrN2ayt6XFeJu94A-1; Fri,
 02 Oct 2026 07:20:57 -0400
X-MC-Unique: NeXnrxMrN2ayt6XFeJu94A-1
X-Mimecast-MFC-AGG-ID: NeXnrxMrN2ayt6XFeJu94A_1790940056
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 840491955BD9; Fri,  2 Oct 2026 11:20:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26329766; Fri,  2 Oct 2026 11:20:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D9A1621E6A04; Fri, 02 Oct 2026 13:20:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
In-Reply-To: <1362570a-8bb8-4303-88aa-418eb55b9ef9@nutanix.com> (Mark
 Cave-Ayland's message of "Fri, 2 Oct 2026 11:57:33 +0100")
References: <20260924135634.2626603-1-berrange@redhat.com>
 <1362570a-8bb8-4303-88aa-418eb55b9ef9@nutanix.com>
Date: Fri, 02 Oct 2026 13:20:53 +0200
Message-ID: <874if42vsa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 24/09/2026 14:56, Daniel P. Berrang=C3=A9 wrote:

[...]

>> +  Ignoring any of the above rules may lead to the bugs being
>> +  mass closed without further triage, even if valid reports.
>> +  In cases where the filing limits are grossly exceeded,
>> +  the reporter's GitLab account may be reported for abuse
>> +  (spam), potentially leading to termination.
>
> Do we know if people are doing this purely for the recognition? Perhaps w=
e could suggest that if these rules are broken, all bug reports submitted b=
y the reporter will remain private (to reporters) on GitLab: if a maintaine=
r decides to fix a reported bug at their discretion, the original reporter =
will not be credited in the commit message.

Reducing the reward might be a possible partial replacement for
friction.

However, to not give credit for a bug we first need to fix the bug.
This has turned out to be pretty much infeasible in the cases covered by
the proposed policy.

[...]


