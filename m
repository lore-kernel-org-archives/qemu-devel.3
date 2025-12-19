Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD11D78784
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWbKq-0004qv-M5; Fri, 19 Dec 2025 09:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWbKm-0004qP-Tb
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 09:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWbKl-0001Hx-4i
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 09:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766153993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+zrN7EQ78ZVrsf4aJs2XNjuilafTaDWXiN2cF7m+lk=;
 b=BhfVJEcn4P5+I3qRH/xc8p+lyEzODDnnmGmFkaFL+BcYjXmfcd4wuC9HcJk3BlVqZ2YoC0
 A+bATPXo0qtBUoJyK0GPVJJqH0QZREPQ+cyLLMbDTG2wPzM3aUIrj73RdaLNx2wnp2qxwy
 rTZSjXHrCccCgjx76Q/RUNawvxjbxPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-kjyqsvz3MTSawZHEUY4SFQ-1; Fri,
 19 Dec 2025 09:19:49 -0500
X-MC-Unique: kjyqsvz3MTSawZHEUY4SFQ-1
X-Mimecast-MFC-AGG-ID: kjyqsvz3MTSawZHEUY4SFQ_1766153988
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5369B1800642; Fri, 19 Dec 2025 14:19:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3577180049F; Fri, 19 Dec 2025 14:19:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 491A621E6A27; Fri, 19 Dec 2025 15:19:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jackson Donaldson <jcksn@duck.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
In-Reply-To: <fa6211c1-c811-470b-b63a-d21e57d044f5@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 19 Dec 2025 14:24:03
 +0100")
References: <20251218214306.63667-1-philmd@linaro.org>
 <fa6211c1-c811-470b-b63a-d21e57d044f5@linaro.org>
Date: Fri, 19 Dec 2025 15:19:45 +0100
Message-ID: <878qey4kqm.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 18/12/25 22:43, Philippe Mathieu-Daud=C3=A9 wrote:
>> Unfortunately while rebasing the series registering the
>> ARM/Aarch64 machine interfaces and getting it merged as
>> commit 38c5ab40031 ("hw/arm: Filter machine types for
>> qemu-system-arm/aarch64 binaries") we missed the recent
>> addition of the MAX78000FTHR machine in commit 51eb283dd0e.
>> Correct that.
>>=20
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
>> Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>   hw/arm/max78000fthr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> Per https://lore.kernel.org/qemu-devel/87ms3e6a79.fsf@pond.sub.org/:
> Tested-by: Markus Armbruster <armbru@redhat.com>

Fair :)


