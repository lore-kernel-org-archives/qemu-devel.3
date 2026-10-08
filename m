Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E1DCA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEfkc-0000YZ-4a; Thu, 08 Oct 2026 00:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEfkZ-0000YG-D7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 00:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEfkY-0000qI-0d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 00:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791433737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KYToRkP7py+U+cSGMGjRQ+6D6UCzLLdl1RC4buBvd0=;
 b=QGhrBsQ1hQtm0jfFTgVIi5Np4x0aI+yk+9sSypjIx5hh66cNcCkvIJLLwNTU2ZdIJDXo5I
 rtGxVJ9Y/cf5viirVPJr8GSsBClPjzTxLNpKex0QfWKtZumNoQ8tyLjoFJQpXl2M4NqQbp
 TWdBf+yh7Y85Kjw9LNmWtIYJOGINpbQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-xcppYefYMtiEYB-afTNU8A-1; Thu,
 08 Oct 2026 00:28:52 -0400
X-MC-Unique: xcppYefYMtiEYB-afTNU8A-1
X-Mimecast-MFC-AGG-ID: xcppYefYMtiEYB-afTNU8A_1791433731
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C6331956046; Thu,  8 Oct 2026 04:28:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0648918002B6; Thu,  8 Oct 2026 04:28:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9898221E6A04; Thu, 08 Oct 2026 06:28:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] qapi/control: Turn the reference to qmp-spec.rst into a
 link
In-Reply-To: <CAFn=p-YZUaFkncUis+=YpP1eMKruk1cfWRVu4xaxrtAZxjLf0A@mail.gmail.com>
 (John Snow's message of "Wed, 7 Oct 2026 14:42:05 -0400")
References: <20260929192403.2972132-1-jsnow@redhat.com>
 <CAFn=p-YZUaFkncUis+=YpP1eMKruk1cfWRVu4xaxrtAZxjLf0A@mail.gmail.com>
Date: Thu, 08 Oct 2026 06:28:48 +0200
Message-ID: <87cxtk7r3z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Sep 29, 2026 at 3:24=E2=80=AFPM John Snow <jsnow@redhat.com> wrot=
e:
>>
>> Add a new anchor to qmp-spec that allows us to cross-reference the
>> Out-of-band execution section of the spec directly.
>>
>> Amend the documentation in qapi/control.json to use this new cross
>> reference instead of a plaintext "see also".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>
> Markus: With no feedback, I assume this is good to go?

Queued.  Thanks!


