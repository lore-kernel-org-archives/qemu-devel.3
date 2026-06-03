Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08DDCD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUi9I-0000Ar-M3; Wed, 03 Jun 2026 05:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUi9G-0000AP-NI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUi9F-0005Zt-54
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780479867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zVYTt+dKblgACFTYNMAFlQDnG/7abKaaKHcJFfvC24=;
 b=Q3guoik56rbMQV92lwROt2A+9h9UV09faHxYZCvabSpomZJ9ZX8p4pwCISCQv0Gg9R6i/P
 7AHS8Li3NitqMbRZgTqd/OcwRjU6bU43V+h33nueP9W9waQ7H84+hDbGiFWmEV19pNgeTy
 CmkuWl2sGYeInBpOL5lWcaV3bfl2Juc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-ExexyQ27PnmQt_jrvtyukg-1; Wed,
 03 Jun 2026 05:44:13 -0400
X-MC-Unique: ExexyQ27PnmQt_jrvtyukg-1
X-Mimecast-MFC-AGG-ID: ExexyQ27PnmQt_jrvtyukg_1780479852
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85EE0195608A; Wed,  3 Jun 2026 09:44:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7E6C765; Wed,  3 Jun 2026 09:44:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89B0C21E6A01; Wed, 03 Jun 2026 11:44:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 06/38] MAINTAINERS: Drop stale F: from "Overall CPUs
 other accelerators"
In-Reply-To: <a7341ab4-4556-4113-98ef-1438b5f91016@mailo.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 3 Jun 2026 09:32:22
 +0200")
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-7-armbru@redhat.com>
 <a7341ab4-4556-4113-98ef-1438b5f91016@mailo.com>
Date: Wed, 03 Jun 2026 11:44:09 +0200
Message-ID: <87zf1cklg6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> writes:

> On 3/6/26 08:40, Markus Armbruster wrote:
>> We neglected to update MAINTAINERS when we deleted makefiles.  Update
>> it now.
>> Fixes: 1a82878a08 (meson: accel, 2019-08-18)
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   MAINTAINERS | 2 --
>>   1 file changed, 2 deletions(-)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 15793b088e..2dc53c7e2e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -541,8 +541,6 @@ F: include/system/cpus.h
>>   F: include/accel/accel-*.h
>>   F: accel/accel-*.?
>>   F: accel/dummy-cpus.?
>> -F: accel/Makefile.objs
>> -F: accel/stubs/Makefile.objs
>
> Adding:
>
>   +F: accel/meson.build

Will do.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>

Thanks!

>>   F: cpu-common.c
>>   F: cpu-target.c
>>   F: qapi/accelerator.json


