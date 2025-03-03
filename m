Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD59C282D0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 19:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpBdq-0001Wn-FG; Mon, 03 Mar 2025 14:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpBdk-0001Vt-Tx
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpBdg-000854-Cv
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741030775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0FAYiX35mfGCYALTAhPBtlmhtOHKLfz0gUh5zifew=;
 b=epPWbtUZziyjgVkwMSWNc+QLGK5UNHSQK32Eb7klLX/XTBoMcykMnIB9VrX+9EtAM7KC50
 q1fiuUUul35m+UE1psCKPR2xeBP8UJedu2tMscjiDzDJ2L03d+vft6Qyks72RFuHOt1xvH
 gDxyT/1WdeDYEG3uThWVx1lA0YLQJhg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-XzpVuNqHMiq1_45cbAHEcg-1; Mon,
 03 Mar 2025 14:39:22 -0500
X-MC-Unique: XzpVuNqHMiq1_45cbAHEcg-1
X-Mimecast-MFC-AGG-ID: XzpVuNqHMiq1_45cbAHEcg_1741030761
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63CFB1954B20; Mon,  3 Mar 2025 19:39:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08E11800361; Mon,  3 Mar 2025 19:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7184021E675F; Mon, 03 Mar 2025 20:39:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] scripts/checkpatch: Fix a typo
In-Reply-To: <114e31e0-2085-4843-9ef2-3539d53eefd5@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 3 Mar 2025 18:35:06
 +0100")
References: <20250303172508.93234-1-philmd@linaro.org>
 <114e31e0-2085-4843-9ef2-3539d53eefd5@linaro.org>
Date: Mon, 03 Mar 2025 20:39:16 +0100
Message-ID: <8734ft3nvf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 3/3/25 18:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> When running checkpatch.pl on a commit adding a file without
>> SPDX tag we get:
>>    Undefined subroutine &main::WARNING called at ./scripts/checkpatch.pl=
 line 1694.
>> The WARNING level is reported by the WARN() method. Fix the typo.
>> Fixes: fa4d79c64da ("scripts: mandate that new files have SPDX-License-I=
dentifier")
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>> Possible candidate to apply on /master as buildfix
>
> buildfix: because otherwise everybody running checkpatch and adding
> new file without SPDX tag will have to debug checkpatch.pl.
>
>> ---
>>   scripts/checkpatch.pl | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 83b59fb4436..6ae9d7febee 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1691,8 +1691,8 @@ sub process {
>>   				  "'SPDX-License-Identifer'");
>>   			} else {
>>   			    # Other files MAY have SPDX license if appropriate
>> -			    WARNING("Does new file '$expect_spdx_file' need " .
>> -				    "'SPDX-License-Identifer'?");
>> +			    WARN("Does new file '$expect_spdx_file' need " .
>> +				 "'SPDX-License-Identifer'?");
>>   			}
>>   		    }
>>   		    $expect_spdx =3D 1;

Reviewed-by: Markus Armbruster <armbru@redhat.com>


