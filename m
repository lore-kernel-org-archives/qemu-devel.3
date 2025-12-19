Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9163D767C5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 10:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWXf6-0005PP-NW; Fri, 19 Dec 2025 05:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWXf4-0005OY-PP
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 05:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWXf3-0006QG-Ce
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 05:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766139876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqaMyG+Qvhgdrf9U4MZFl0mO4Cc7YlHRoSRawsfUobk=;
 b=bX+6h/lqa4tNAMlrj1VJtlKWcLE/NeglLlObp4iXnJ/gk99m2465xuDJ30xIWai5fsWQae
 fcoeENnSS4mmnyG5Ge6nY0nShBFNemnF/gdB/9EgO4EeCH8efQ/uy+i2hY8woEPQIVfHUW
 c0vxbl0UVPRGCEh3qGHI8cC0Kf3bXrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-kjR5RGTYMGOaXS7pmCXhbA-1; Fri,
 19 Dec 2025 05:24:31 -0500
X-MC-Unique: kjR5RGTYMGOaXS7pmCXhbA-1
X-Mimecast-MFC-AGG-ID: kjR5RGTYMGOaXS7pmCXhbA_1766139869
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F0481800637; Fri, 19 Dec 2025 10:24:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36FF180045B; Fri, 19 Dec 2025 10:24:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90E8721E6A27; Fri, 19 Dec 2025 11:24:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jackson Donaldson <jackson88044@gmail.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: Machine max78000fthr not compiled in?
In-Reply-To: <19c5ae56-35ba-42fe-a330-fec28aad6999@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 19 Dec 2025 10:00:27
 +0100")
References: <875xa27ss1.fsf@pond.sub.org>
 <19c5ae56-35ba-42fe-a330-fec28aad6999@linaro.org>
Date: Fri, 19 Dec 2025 11:24:26 +0100
Message-ID: <87ms3e6a79.fsf@pond.sub.org>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 19/12/25 09:57, Markus Armbruster wrote:
>> docs/system/arm/max78000.rst advises to use
>>
>>    $ qemu-system-arm -machine max78000fthr -kernel max78000.bin -device =
loader,file=3Dmax78000.bin,addr=3D0x10000000
>>
>> My locally built qemu-system-arm rejects this with
>>
>>      qemu-system-arm: unsupported machine type: "max78000fthr"
>>      Use -machine help to list supported machines
>>
>> What's going wrong here?
>
> See the fix:
>
> https://lore.kernel.org/qemu-devel/20251218214306.63667-1-philmd@linaro.o=
rg/

With that, it complains about max78000.bin, which I don't have.  Thank
you!


