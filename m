Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE459D49C9B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 11:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlmED-0006H1-Bp; Fri, 30 Jan 2026 05:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vlmEA-0006GI-1i
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 05:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vlmE8-0003kn-Ca
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 05:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769770786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZM1ucTgT0GURbBfuxyhpnjEWNgwIL9W/G7RUWEvU4w=;
 b=UktUYz0Ja2lyJVLBqy3mlNkDJzUsPK1UtN+N2/NVTmBbcsB7tO1PqaG2X0U8ISplYnyEyQ
 LzpRjRpfgP4yzQcL2tBXD764JJmio65/XVnYcnXL0CEYW9ySwPB209GnoK/4C/m6jRqupz
 dJmBqDnZbBE+VUK2jJSlHzKLH3JDe64=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-_rLxg-z1MK6k0knWuDoyLQ-1; Fri,
 30 Jan 2026 05:59:43 -0500
X-MC-Unique: _rLxg-z1MK6k0knWuDoyLQ-1
X-Mimecast-MFC-AGG-ID: _rLxg-z1MK6k0knWuDoyLQ_1769770781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36DB91956080; Fri, 30 Jan 2026 10:59:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E1EE19560A2; Fri, 30 Jan 2026 10:59:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E06A21E692D; Fri, 30 Jan 2026 11:59:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Roman
 Kiryanov <rkir@google.com>,  qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  mjt@tls.msk.ru,  whollins@google.com,
 jansene@google.com,  jpcottin@google.com,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
In-Reply-To: <CAFEAcA-ShmtJ2tOO_bz+d_oKJaDTG15bc9s775mND=FLWQdRpw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 30 Jan 2026 09:19:32 +0000")
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
 <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
 <0954062c-c032-42be-ad0d-df2559360963@linaro.org>
 <CAFEAcA-ShmtJ2tOO_bz+d_oKJaDTG15bc9s775mND=FLWQdRpw@mail.gmail.com>
Date: Fri, 30 Jan 2026 11:59:37 +0100
Message-ID: <87sebnfjs6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 29 Jan 2026 at 21:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> Hi Peter,
>>
>> (+Paolo / Eric)
>>
>> On 29/1/26 21:31, Peter Maydell wrote:
>> >
>> > What are we trying to achieve here, and why does it benefit
>> > us as an upstream project ?
>> >
>> > cf previous email thread from 2024
>> > https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/
>> > about "drip-feeding" of this kind of patch with no clear take
>> > on what the end state is or how much churn it's going to induce.
>>
>> I clearly know QEMU is not a C++ project. Now I don't see why we should
>> be reluctant to have headers being usable by a C++ compiler, as long as
>> it doesn't make our project worst to maintain.
>
> Every bit of code that is written by some downstream in C++ is
> some thing that will essentially then never be upstreamed without
> a big rewrite. So making it easier for downstreams to use C++
> reduces our chances of seeing them contribute what they do back to us.
>
> It's also extra work for us (for instance in this thread you
> proposed adding a CI job, which is more CI minutes cost to
> the project, more work for maintainers when something that
> builds fine locally falls over in the CI, and so on).
>
> Each individual fix might be trivial, but they add up.
> So it matters whether this one is "this is the only thing
> we tripped over since 2024" or "we just rebased to a new
> QEMU version and are going to be submitting dozens of these
> over the next few weeks".
>
>> See for example non-invasive commit 7246c4cc470 ("exec: don't use void*
>> in pointer arithmetic in headers"):
>
>> or commit 17c7df806b3 ("exec: avoid using C++ keywords in function
>> parameters"):
>
> For the record, I wasn't really enthusiastic about those changes
> either, for essentially the same reasons.

+1

[...]


