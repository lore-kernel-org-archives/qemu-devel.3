Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4FBC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thVaa-0007pa-6B; Mon, 10 Feb 2025 10:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1thVaW-0007od-Ri
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1thVaU-0000se-Pg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739200842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+1vKWq8tav0v5vOrEs4bMdzd3ftwt2N0noMcIDxK+A=;
 b=OkoC1vCU1l0/lB8q70VUuDdoHBOpHV5CjujWD8Lk7L3ExqqaSzu/sqzQVcZz+14xemS3DY
 gh9a+0DzuTEd2V+P6Csx/iqaxbDs5rviY4IL6Ahqmy94KXxA/bwDOz9WgPvuSa9wBWnZgB
 rGQM9iJXoI02FXy5cC0PbER5lD2ajLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-dgWwLAmSMn2f19JyAWRGdQ-1; Mon,
 10 Feb 2025 10:20:36 -0500
X-MC-Unique: dgWwLAmSMn2f19JyAWRGdQ-1
X-Mimecast-MFC-AGG-ID: dgWwLAmSMn2f19JyAWRGdQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA59D19560B1; Mon, 10 Feb 2025 15:20:31 +0000 (UTC)
Received: from localhost (unknown [10.45.225.231])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F032D30001AB; Mon, 10 Feb 2025 15:20:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 15/15] arm/cpu: Add generated files
In-Reply-To: <f5878231-79b8-4e29-bfb0-f9a57ac3f6a4@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-16-cohuck@redhat.com>
 <f5878231-79b8-4e29-bfb0-f9a57ac3f6a4@linaro.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 10 Feb 2025 16:20:28 +0100
Message-ID: <874j117rnn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Feb 07 2025, Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/7/25 03:02, Cornelia Huck wrote:
>> And switch to using the generated definitions.
>> 
>> Generated against Linux 6.14-rc1.
>> 
>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>> ---
>>   target/arm/cpu-sysreg-properties.c | 716 ++++++++++++++++++++++++++++-
>>   target/arm/cpu-sysregs.h           | 116 +----
>>   target/arm/cpu-sysregs.h.inc       | 164 +++++++
>>   3 files changed, 860 insertions(+), 136 deletions(-)
>>   create mode 100644 target/arm/cpu-sysregs.h.inc
>
> Why are we committing generated files and not generating them at build-time?

We'd either have to carry a copy of Linux' sysregs file, or generate a
build dependency on Linux. I think we should handle this similar to the
Linux headers update, where we do an explicit update and check for
anything unexpected that might have crept in. (Same applies if we switch
to any other external source for register definitions.)


