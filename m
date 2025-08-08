Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A893C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukGhl-0001JW-LW; Fri, 08 Aug 2025 02:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukGhj-0001IW-V6
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukGhh-0001am-VK
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754634948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNKkH58xD67GRdATg81kxt5+wxc0oCm6Rudn3KSKJ7I=;
 b=awp/TBMCFgXSc1rCbSfSb40r+DH05ehwzCbV/AGDxBwp2mHCN5B8xqNxmKL0O6lzcvwFPj
 UDv2X/OiPrV6RbWwkCEW7h6yp7n/G5DQsYq7jNZVoQh7t2dcCp9TdT0Rbg1aKOcLBuTAPJ
 qj8rPLC4Pdc4GB6Wv3DEOPPHNYb2byk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-9GmpnuJ5O5KuCMTKKAtQ0Q-1; Fri,
 08 Aug 2025 02:35:46 -0400
X-MC-Unique: 9GmpnuJ5O5KuCMTKKAtQ0Q-1
X-Mimecast-MFC-AGG-ID: 9GmpnuJ5O5KuCMTKKAtQ0Q_1754634946
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1DE3195608B; Fri,  8 Aug 2025 06:35:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6316D180028A; Fri,  8 Aug 2025 06:35:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6BCC21E6A27; Fri, 08 Aug 2025 08:35:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  peter.maydell@linaro.org,
 eblake@redhat.com
Subject: Re: [PATCH 3/3] docs/devel/qapi-code-gen: Update cross-reference
 syntax
In-Reply-To: <CAFn=p-bYKEjGX-DYPNbxFn=52-dJH29-SwmPvWYZ7tgo9ZBS+w@mail.gmail.com>
 (John Snow's message of "Thu, 7 Aug 2025 17:31:34 -0400")
References: <20250731054044.4011789-1-armbru@redhat.com>
 <20250731054044.4011789-4-armbru@redhat.com>
 <CAFn=p-bYKEjGX-DYPNbxFn=52-dJH29-SwmPvWYZ7tgo9ZBS+w@mail.gmail.com>
Date: Fri, 08 Aug 2025 08:35:42 +0200
Message-ID: <87ikiymibl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Jul 31, 2025 at 1:40=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> The new QAPI code generator creates a cross-reference target for each
>> definition documentation.  Enabled for the QEMU QMP Reference manual
>> in commit a377f39f38f, and for the QEMU Storage Daemon QMP Reference
>> Manual and the QEMU Guest Agent Protocol Reference in commit
>> a6af5443440.  We've put these targets to use since, but neglected to
>> update doc comment markup documentation.  Do that now.
>>
>> Co-developed-by: John Snow <jsnow@redhat.com>
>
> No need for this in my opinion, the SOB suffices to say the same thing
> in my book. I don't insist you remove it, just seems ... oddly
> pretentious to say I "co-developed" a single paragraph of text ;)

It wasn't obvious to me how to best credit you, so I tried this.  The
Co-developed-by serves as an explanation why your S-o-b is there.

Please pick one:

1. Do nothing.

2. Delete Co-developed-by.

3. Delete Co-developed-by, your Signed-off-by, add your Reviewed-by.

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!


