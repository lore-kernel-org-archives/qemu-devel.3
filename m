Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6FC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBPh0-0006iD-GG; Tue, 29 Sep 2026 00:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBPgy-0006i5-4z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 00:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBPgw-0006TC-Hu
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 00:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790657024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbMac7WsA4/X9UryRwGgbgUYmznIqoy5e8PcNouIPxY=;
 b=Z8GAYR5bA+JB2TvXnjViGhX2MvjK65JmPNmUfmeONi0Ih59w47ODICW2xVLUAeKUDZZQew
 EayOjMVunhtpak51HNC/8ECqbmgqC3TFITJDufhnseg3yeeyOsOC21lSJU0jZegmhSZ2m+
 UyaFyfFqn+52yDacL/oAyZ5YyCoqUBs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-vH7_iV3nPmmZ8mmM20wOgw-1; Tue,
 29 Sep 2026 00:43:42 -0400
X-MC-Unique: vH7_iV3nPmmZ8mmM20wOgw-1
X-Mimecast-MFC-AGG-ID: vH7_iV3nPmmZ8mmM20wOgw_1790657021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84F8118011F3; Tue, 29 Sep 2026 04:43:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26AA1180049F; Tue, 29 Sep 2026 04:43:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DF0E21E6A04; Tue, 29 Sep 2026 06:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  michael.roth@amd.com
Subject: Re: [PATCH] qapi/control: Turn the reference to qmp-spec.rst into a
 link
In-Reply-To: <CAFn=p-bv4rF_VzVPQBLvcNxrnbvJDNpsAHQR9_iH1q0coc7rig@mail.gmail.com>
 (John Snow's message of "Mon, 28 Sep 2026 14:03:07 -0400")
References: <20260928063231.2158073-1-armbru@redhat.com>
 <CAFn=p-bv4rF_VzVPQBLvcNxrnbvJDNpsAHQR9_iH1q0coc7rig@mail.gmail.com>
Date: Tue, 29 Sep 2026 06:43:38 +0200
Message-ID: <87tsn83bwl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Sep 28, 2026 at 2:32=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/control.json | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qapi/control.json b/qapi/control.json
>> index 9898552814..c56aabacff 100644
>> --- a/qapi/control.json
>> +++ b/qapi/control.json
>> @@ -46,7 +46,7 @@
>>  # connection, used for agreeing on particular QMP extension behaviors.
>>  #
>>  # @oob: QMP ability to support out-of-band requests.  (Please refer to
>> -#     qmp-spec.rst for more information on OOB)
>> +#     :doc:`/interop/qmp-spec` for more information on OOB)
>>  #
>>  # Since: 2.12
>>  ##
>> --
>> 2.55.0
>>
>
> I have a similar patch coming up in my rework of the @oob feature that:
>
> (1) Adds an anchor to the OOB section of the qmp spec explicitly,
> (2) Uses a standard form text with the above reference when generating
> docs for commands with the @oob property.
>
> The second doesn't apply to this command as it's an arg and not a
> feature/property; but we can do better and link directly to the OOB
> section of the spec doc.

I'm glad I cc'ed you.  Would you like me to drop this patch?  Or should
I merge it, and you improve on top?


