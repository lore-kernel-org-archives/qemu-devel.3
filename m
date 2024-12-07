Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228BCE77179
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 06:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJo7P-0000jO-4R; Sat, 07 Dec 2024 01:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJo7N-0000j5-Fv
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 01:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJo7L-0005qv-Rm
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 01:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733552199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IndLci3qH0rNwV6wj/O0mA1mXhMlv9zVXl1VfWtqCCE=;
 b=Xv2S3QUWf5WX4cJ9GQ+DBe7iSDYPGj3rYJkretJnm4PT4/h/cihsqG6WvRvJFtHsyb9T6G
 q/aUKHoP0XzWAW6o+zTNSJwzyosqz50gMhQ5Kl0jIhtYczLwxR14AJCuAUDoK4Byt3CUo6
 V/tp5v0MfwV/KZ9pbGi1nL+HxXoulg0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-QpACtTbuNpWzAJcCiT1t4w-1; Sat,
 07 Dec 2024 01:16:35 -0500
X-MC-Unique: QpACtTbuNpWzAJcCiT1t4w-1
X-Mimecast-MFC-AGG-ID: QpACtTbuNpWzAJcCiT1t4w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B051956086; Sat,  7 Dec 2024 06:16:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91881300019E; Sat,  7 Dec 2024 06:16:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4847921E66E2; Sat,  7 Dec 2024 07:16:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Shiju Jose <shiju.jose@huawei.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>,  Igor Mammedov
 <imammedo@redhat.com>,  linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 27/31] DEBUG
In-Reply-To: <CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
 (Ani Sinha's message of "Sat, 7 Dec 2024 09:08:31 +0530")
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
 <6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
 <CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
Date: Sat, 07 Dec 2024 07:16:31 +0100
Message-ID: <87ser02f28.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=ham autolearn_force=no
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

Ani Sinha <anisinha@redhat.com> writes:

> On Fri, Dec 6, 2024 at 10:51=E2=80=AFPM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>  hw/acpi/ghes.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index abca351b18de..1fe4c536611a 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, size=
_t len,
>>      ags =3D &acpi_ged_state->ghes_state;
>>
>>      if (!ags->hest_lookup) {
>> +        fprintf(stderr,"Using old GHES lookup\n");
>
> I don't like this. If you must please have them under #ifdef DEBUG or
> somesuch. See ich9.c

Judging from the subject line, it's not meant to be posted, let alone
merged :)

>>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>>                               &cper_addr, &read_ack_register_addr);
>>      } else {
>> +        fprintf(stderr,"Using new HEST lookup\n");
>>          get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_l=
e),
>>                                  &cper_addr, &read_ack_register_addr, er=
rp);
>>      }
>> --
>> 2.47.1
>>


