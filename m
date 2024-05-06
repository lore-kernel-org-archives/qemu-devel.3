Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D95C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xmI-0001yo-O5; Mon, 06 May 2024 08:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3xm3-0001ex-Ej
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3xm0-00025v-O5
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714999731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AM8yQKUviphKxXBt8/T0JxyZbniwk5EiFhsmfTnHERg=;
 b=K7Thx6JsCdXKmxyMCfjeJtWsT0bStqMgBUYiQ9aBZMb79OArFIAn2VxdmjVsheN2vxl80O
 sMiuR3SYujPNBwBVYBal6VN02riDDknw/cqiu4L1Ly+lJ9CauWN+m08Tck5pWRzuApr0sd
 U45pszVJrDJ5QsebqpLyNxUynT3zcWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-tUdYrz2sNCiGpM9Vz_UgSg-1; Mon,
 06 May 2024 08:48:48 -0400
X-MC-Unique: tUdYrz2sNCiGpM9Vz_UgSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 643E129AA3AF;
 Mon,  6 May 2024 12:48:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44EED40C6CC1;
 Mon,  6 May 2024 12:48:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 544BF21E6806; Mon,  6 May 2024 14:48:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org
Subject: Re: [PATCH 1/7] qapi: make since sections special WIP
In-Reply-To: <73ae70ff-0e20-437a-b5d9-72de6a948264@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 6 May 2024 13:44:34
 +0200")
References: <20240506110254.3965097-1-armbru@redhat.com>
 <20240506110254.3965097-3-armbru@redhat.com>
 <73ae70ff-0e20-437a-b5d9-72de6a948264@linaro.org>
Date: Mon, 06 May 2024 14:48:47 +0200
Message-ID: <87y18nm7gw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 6/5/24 13:02, Markus Armbruster wrote:
>> since moves to end in generated output
>> ---
>>   docs/sphinx/qapidoc.py         | 22 +++++++++++++++++-----
>>   scripts/qapi/parser.py         |  5 +++--
>>   tests/qapi-schema/test-qapi.py |  2 ++
>>   3 files changed, 22 insertions(+), 7 deletions(-)
>
> Alternatively use git-publish to send pull requests :)

Touch=C3=A9; I'm a troglodyte ;)

> $ git publish --pull-request --sign-pull
>
> https://github.com/stefanha/git-publish/blob/master/git-publish.pod


