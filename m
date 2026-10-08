Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03C9CA6002
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEfoW-00011J-1G; Thu, 08 Oct 2026 00:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEfn5-0000yv-7k
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 00:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEfmz-0001F2-2X
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 00:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791433886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lfbs6vURP/wJw81JKtQq7+bekN84NqaEk+fx0vAiD2g=;
 b=EoKfFG9UBKvj6hlVCQQZlud+KjPUab7GMtwKbOCQuetM6C8QxMwmuFQ7nVb1JEnfTNB1Hs
 RJR+LCxZjAuB2eG7U92gzViP/6Vgn+rsknDJT+jAdSWqHU4Hd2XsWVM0MM7nDRoI74cdGT
 zunHaeZU2eOiRhwje5NOdEyYDA/C4kE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-v_x3h-2ONt6OQigm55DwuQ-1; Thu,
 08 Oct 2026 00:31:24 -0400
X-MC-Unique: v_x3h-2ONt6OQigm55DwuQ-1
X-Mimecast-MFC-AGG-ID: v_x3h-2ONt6OQigm55DwuQ_1791433884
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03ED61954115
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2026 04:31:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B76C518002B6
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2026 04:31:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6047B21E6A04; Thu, 08 Oct 2026 06:31:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] qapi: convert intro sections fixup
In-Reply-To: <CAFn=p-Yoa5pEgVAj_BqiBeACppadzgBBgVTUtq0EquOoWc6u8w@mail.gmail.com>
 (John Snow's message of "Wed, 7 Oct 2026 14:54:39 -0400")
References: <20260929223044.2998391-1-jsnow@redhat.com>
 <87ik3nti0x.fsf@pond.sub.org>
 <CAFn=p-Yoa5pEgVAj_BqiBeACppadzgBBgVTUtq0EquOoWc6u8w@mail.gmail.com>
Date: Thu, 08 Oct 2026 06:31:21 +0200
Message-ID: <878q487qzq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Wed, Sep 30, 2026 at 1:39=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > "We" (Me, I, Myself) missed two last spots during bulk conversion of t=
he
>> > intro section syntax.
>> >
>> > Some definitions are still intentionally left without an intro
>> > section: BlockdevSnapshotSync is the only case I am presently aware
>> > of.
>>
>> There are quite a few more, but BlockdevSnapshotSync is the only one
>> followed by a plain section.
>>
>> > The remaining two were genuinely just missed; convert them now.
>> >
>> > Reported-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/machine-s390x.json |  4 ++--
>> >  qapi/qom.json           | 14 +++++++-------
>> >  2 files changed, 9 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
>> > index 8d8cbe2fb75..9ae559bbc2d 100644
>> > --- a/qapi/machine-s390x.json
>> > +++ b/qapi/machine-s390x.json
>> > @@ -150,8 +150,8 @@
>> >
>> >  ##
>> >  # @DummyBootCertificates:
>> > -#
>> > -# Not used by QMP; hack to let us use BootCertificatesList internally.
>> > +#     Not used by QMP; hack to let us use BootCertificatesList
>> > +#     internally.
>> >  #
>> >  # Since: 11.2
>> >  ##
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index e03ede34421..2d0d0e47fbb 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -1039,13 +1039,13 @@
>> >
>> >  ##
>> >  # @SevSnpGuestProperties:
>> > -#
>> > -# Properties for sev-snp-guest objects.  Most of these are direct
>> > -# arguments for the KVM_SNP_* interfaces documented in the Linux
>> > -# kernel source under
>> > -# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
>> > -# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
>> > -# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
>> > +#     Properties for sev-snp-guest objects.  Most of these are direct
>> > +#     arguments for the KVM_SNP_* interfaces documented in the Linux
>> > +#     kernel source under
>> > +#     Documentation/arch/x86/amd-memory-encryption.rst, which are in
>> > +#     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
>> > +#     commands documented in the SEV-SNP Firmware ABI Specification
>> > +#     (Rev 0.9).
>> >  #
>> >  # More usage information is also available in the QEMU source tree
>> >  # under docs/amd-memory-encryption.
>>
>> Hmm, shouldn't we split this one?
>
> Looping back to stuff that got missed:
>
> Split how? I think I have to rephrase this a bit, because when it gets
> inlined, it (might) be lacking the context of what specifically it
> refers to, i.e. "Most of these" might become ambiguous.

Yes.

Could s/these/the properties/ suffice for now?

  ##
  # @SevSnpGuestProperties:
  #     Properties for sev-snp-guest objects.
  #
  #     Most of the properties are direct arguments for the KVM_SNP_*
  #     interfaces documented in the Linux kernel source under
  #     Documentation/arch/x86/amd-memory-encryption.rst, which are in
  #     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
  #     commands documented in the SEV-SNP Firmware ABI Specification
  #     (Rev 0.9).


