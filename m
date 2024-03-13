Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C5C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMRZ-0001Ao-81; Wed, 13 Mar 2024 07:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkMRQ-000188-G3
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkMRO-00018L-SW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710327993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtKbyvLq8P0p0XprheT//8iI6ErKrjueU88b89AJNsI=;
 b=Rk5ETuMSj+xWkM2p+RFmXf66Oj1GnxodL1cL4hyQ8FogG+Sqa8hqhFn0Jnj1MiulMnE91X
 e6zfeQo6UCrWNVLxi8KyAlI/PTxYP+6EuYfjHeM7pLW4lMCrC80jk9nS7UgKklhnUTLJLE
 mrxlxGZ256ua0TOk6zxrsCthVCFiQ/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-JCDLFh9RM3SRVbjoV4AY-Q-1; Wed, 13 Mar 2024 07:06:28 -0400
X-MC-Unique: JCDLFh9RM3SRVbjoV4AY-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B54A788B7AA;
 Wed, 13 Mar 2024 11:06:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DD8D2024517;
 Wed, 13 Mar 2024 11:06:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45EA321E6A24; Wed, 13 Mar 2024 12:06:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v4 01/23] qapi/parser: fix typo - self.returns.info =>
 self.errors.info
In-Reply-To: <3f0d7531-6b53-4c4a-b605-cf3b62ec7244@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 13 Mar 2024 11:17:19
 +0100")
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-2-jsnow@redhat.com>
 <3f0d7531-6b53-4c4a-b605-cf3b62ec7244@linaro.org>
Date: Wed, 13 Mar 2024 12:06:26 +0100
Message-ID: <87edcefl1p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 13/3/24 05:41, John Snow wrote:
>> Small copy-pasto. The correct info field to use in this conditional
>> block is self.errors.info.
>> Fixes: 3a025d3d1ffa
>
> Reported-by: Markus Armbruster <armbru@redhat.com>

I did?

Messed-up-by: me would be accurate, though!

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/parser.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)


