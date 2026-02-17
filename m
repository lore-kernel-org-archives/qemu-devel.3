Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80EDE68145
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGK6-0006xj-DZ; Tue, 17 Feb 2026 03:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGK4-0006vh-Bm
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGK1-0001MO-Lv
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771316440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hB3yvoS+htnH3272T88IKKNoaW35/DHilKLDtCL6UNI=;
 b=QT12NtgQnP7NpVGvRyKJHtmx3LYrr3aehhvFjLfbBp6iYKOkkBjUwwJdQJTug4L4mmDY9m
 WnwvobSFlu/uzLCZNQMDpXf95ADakmiks44s19jvbJEM+e8zd4MlhJg8vDxG3EG3OnSfZy
 xm/+4puSucEg2ruJ5iLJM7OqJtJcfE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-vG_LVbWuM1GeDQcaiiQRhA-1; Tue,
 17 Feb 2026 03:20:35 -0500
X-MC-Unique: vG_LVbWuM1GeDQcaiiQRhA-1
X-Mimecast-MFC-AGG-ID: vG_LVbWuM1GeDQcaiiQRhA_1771316433
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F96018001DE; Tue, 17 Feb 2026 08:20:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA23130001A5; Tue, 17 Feb 2026 08:20:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F9CE21E692D; Tue, 17 Feb 2026 09:20:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,
 david@kernel.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 alifm@linux.ibm.com,  brueckner@linux.ibm.com
Subject: Re: [PATCH v8 30/30] docs/system/s390x: Add secure IPL documentation
In-Reply-To: <87bjhnpzeb.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 17 Feb 2026 09:06:36 +0100")
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-31-zycai@linux.ibm.com>
 <87bjhnpzeb.fsf@pond.sub.org>
Date: Tue, 17 Feb 2026 09:20:30 +0100
Message-ID: <87tsvfok6p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Zhuoying Cai <zycai@linux.ibm.com> writes:
>
>> Add documentation for secure IPL
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  docs/system/s390x/secure-ipl.rst | 96 ++++++++++++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>
>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>> index e0af086c38..275aa422c7 100644
>> --- a/docs/system/s390x/secure-ipl.rst
>> +++ b/docs/system/s390x/secure-ipl.rst
>
> [...]
>
>> +Command line options for starting the guest
>> +----------------------------
>
> Does not build:
>
>     docs/system/s390x/secure-ipl.rst:172: WARNING: Title underline too short.
>
>     Command line options for starting the guest
>     ---------------------------- [docutils]
>
> Please test with configure --enable-docs.

With that fixed, I get

    docs/specs/s390x-secure-ipl.rst: WARNING: document isn't included in any toctree [toc.not_included]

>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=cert.pem ...


