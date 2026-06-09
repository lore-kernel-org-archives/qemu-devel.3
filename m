Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA1CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwje-0002gs-Ma; Tue, 09 Jun 2026 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwjb-0002gH-M5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwjZ-0004sH-HJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781012592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HFW+xLuQYo4WkFCSqvt+tn5HY58E1SOq5et6O37ZmY=;
 b=J/EJqy/uWNqV96EB54/Zd576cLXPclcmEkYaMO/15dt5FOzOPjZLbO/5Vy0TmUfEubM5A3
 98owg1ECqrnxmTfPcMftXbDJFG60FDEucQQlJBDUdtWbzW8tDXH/YXmwXxfA2/VITfINJf
 IxN4n4YKBNWWW3e3VRjCosLKpE7GDEc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-WPG6ZNG0OKyGAArTROfVeQ-1; Tue,
 09 Jun 2026 09:43:10 -0400
X-MC-Unique: WPG6ZNG0OKyGAArTROfVeQ-1
X-Mimecast-MFC-AGG-ID: WPG6ZNG0OKyGAArTROfVeQ_1781012590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDC7B185FC56
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 13:43:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 835D73008B39
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 13:43:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0460321E6A01; Tue, 09 Jun 2026 15:43:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>,  qemu-devel@nongnu.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] igvm: populate errp in stub functions
In-Reply-To: <aigULaw73khPNxoR@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 9 Jun 2026 14:25:01 +0100")
References: <20260609-igvm_stubs-v1-1-5f39d6e0db4a@redhat.com>
 <aigULaw73khPNxoR@redhat.com>
Date: Tue, 09 Jun 2026 15:43:06 +0200
Message-ID: <87o6hjn82d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jun 09, 2026 at 03:20:14PM +0200, Luigi Leonardi wrote:
>> Use error_setg() to report that IGVM is not available, matching
>> the pattern used by other stubs in the tree.
>>=20
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>>  stubs/igvm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/stubs/igvm.c b/stubs/igvm.c
>> index 9e9f683fc9..dfb85eb548 100644
>> --- a/stubs/igvm.c
>> +++ b/stubs/igvm.c
>> @@ -17,15 +17,18 @@ int qigvm_x86_get_mem_map_entry(int index,
>>                                  ConfidentialGuestMemoryMapEntry *entry,
>>                                  Error **errp)
>>  {
>> +    error_setg(errp, "IGVM not supported on this platform");
>>      return -1;
>>  }
>>=20=20
>>  int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
>>  {
>> +    error_setg(errp, "IGVM not supported on this platform");
>>      return -1;
>>  }
>>=20=20
>>  int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error =
**errp)
>>  {
>> +    error_setg(errp, "IGVM not supported on this platform");
>>      return -1;
>>  }
>
> This is not wrong per-se, so on that  basis
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> but are any of these stubs actually reachable when IGVM is not
> enabled in the build ? Usually with stubs we find that one
> or two methods are the primary entrypoints which must return
> an error, at which point everything else becomes unreachable.
> The latter cases can just be g_assert_not_reached() as a sanity
> check that some unexpected codepath isn't calling in without
> checking status earlier. Those would thus would not need
> error_setg, nor a 'return' statement.

I much prefer g_assert_not_reached() to unreachable (and thus
untestable) errors.


