Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E5FC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2jvZ-0003vX-F4; Thu, 10 Apr 2025 00:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2jvV-0003uH-4m
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 00:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2jvR-0003EH-0x
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 00:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744260842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6npGZAhnPCX07y+85BlXLETuyC/tsAljx6QYhiWe60Y=;
 b=ReJdPIqlTfpByx6U6S9zNqy9nnNShP3E6b7Puy+yhGGJibfyNpw1C7rrmwlBVfJiB/Gyc7
 dTcb1UhHK5A3G2hteMqAI24ehpzQvVgtzSwy4184imOJN2UtUj79PKqDLu0e/CwPlN7kui
 LwrLuTuzlcdzGN/SXz/fKtqkWMyJrB8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-Pe0B1z8YPqOeA0ANLn6qSw-1; Thu,
 10 Apr 2025 00:53:57 -0400
X-MC-Unique: Pe0B1z8YPqOeA0ANLn6qSw-1
X-Mimecast-MFC-AGG-ID: Pe0B1z8YPqOeA0ANLn6qSw_1744260836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 589EF180049D; Thu, 10 Apr 2025 04:53:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B840D180175D; Thu, 10 Apr 2025 04:53:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40BCA21E675E; Thu, 10 Apr 2025 06:53:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  John Snow <jsnow@redhat.com>
Subject: Re: Note improvements to QAPI-generated manuals in ChangeLog/10.0?
In-Reply-To: <CAJSP0QUyZfV8UQmhR5ADgC5Cr9zVrJ53fcWLvY0GUUSKfj8iyw@mail.gmail.com>
 (Stefan Hajnoczi's message of "Wed, 9 Apr 2025 10:18:01 -0400")
References: <87h62x8n6b.fsf@pond.sub.org>
 <CAJSP0QUyZfV8UQmhR5ADgC5Cr9zVrJ53fcWLvY0GUUSKfj8iyw@mail.gmail.com>
Date: Thu, 10 Apr 2025 06:53:53 +0200
Message-ID: <87v7rc4nxa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, Apr 9, 2025 at 9:44=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> John improved looks and usabilibity of the QAPI-generated manuals quite
>> a bit.  These are
>>
>>     QEMU QMP Reference Manual
>>     QEMU Storage Daemon QMP Reference Manual
>>     QEMU Guest Agent Protocol Reference
>>
>> Where should it go?  https://wiki.qemu.org/ChangeLog/10.0 has no section
>> dedicated to the manuals.  We could mention it under System Emulation /
>> Monitor / QMP, and again under Guest Agent.  Thoughts?
>
> I would add a separate Documentation section for changes like this.
> That's also where major docs infrastructure items like changes to
> formats (rST), tooling (Sphinx), etc could be announced.

Insert a "Documentation" section between "Guest agent" and "Build
Information"?


