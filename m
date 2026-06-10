Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F50CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDmG-0006pe-UT; Wed, 10 Jun 2026 03:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDmF-0006pS-BK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDmD-0004VB-Hf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa3ON9HrtKVXV+08lqx5Jh1ud7LVf1/8X2etMtXPxrY=;
 b=BxmZxH17UPV9tU/tpHUxHAE5MwhqOTCPHxGLK/OWe0xDpJ8qc7kaET06rBDdyEWskV98UV
 thX/XpLi/s1w0BnXHZcxtd1zgUflITrcmm64KWn/hFgSljBIgjWWSD55Fz7Ip+rJ8qUXu/
 m7EPeww7eEWpl1MGIFqhomRY0/jh9EU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-XlWE22U0Nq-KM3OqBh-QOg-1; Wed,
 10 Jun 2026 03:55:01 -0400
X-MC-Unique: XlWE22U0Nq-KM3OqBh-QOg-1
X-Mimecast-MFC-AGG-ID: XlWE22U0Nq-KM3OqBh-QOg_1781078100
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49977195608D; Wed, 10 Jun 2026 07:55:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F5E03000203; Wed, 10 Jun 2026 07:54:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F10A421E6A01; Wed, 10 Jun 2026 09:54:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@oss.qualcomm.com,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 06/38] MAINTAINERS: Drop stale F: from "Overall CPUs
 other accelerators"
In-Reply-To: <87zf1cklg6.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 03 Jun 2026 11:44:09 +0200")
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-7-armbru@redhat.com>
 <a7341ab4-4556-4113-98ef-1438b5f91016@mailo.com>
 <87zf1cklg6.fsf@pond.sub.org>
Date: Wed, 10 Jun 2026 09:54:56 +0200
Message-ID: <87wlw6ltin.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Markus Armbruster <armbru@redhat.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> writes:
>
>> On 3/6/26 08:40, Markus Armbruster wrote:
>>> We neglected to update MAINTAINERS when we deleted makefiles.  Update
>>> it now.
>>> Fixes: 1a82878a08 (meson: accel, 2019-08-18)
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   MAINTAINERS | 2 --
>>>   1 file changed, 2 deletions(-)
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 15793b088e..2dc53c7e2e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -541,8 +541,6 @@ F: include/system/cpus.h
>>>  F: include/accel/accel-*.h
>>>  F: accel/accel-*.?
>>>  F: accel/dummy-cpus.?
>>> -F: accel/Makefile.objs
>>> -F: accel/stubs/Makefile.objs
>>
>> Adding:
>>
>>  +F: accel/meson.build
>
> Will do.

Adding

     F: accel/stubs/meson.build=20

as well.

>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>
> Thanks!
>
>>>   F: cpu-common.c
>>>   F: cpu-target.c
>>>   F: qapi/accelerator.json


