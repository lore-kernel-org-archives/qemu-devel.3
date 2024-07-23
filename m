Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718AAC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGId-0002Z6-50; Tue, 23 Jul 2024 10:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIb-0002OV-8S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIY-00072p-Vd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4jqXLR0c2v5lIJARFxGMhramSLLez6ADGH7aFWb5tc=;
 b=gD9UWyFAMcDWl5IGjxkPm5ejEE9NJONUyP9nurm883lrMi745UKcwjmcp4Mt55oD6zMPOV
 pcqqnKh66caAnmNBpnGa+kf4vCBTqx4hha0o6JIpJavpSrjK3WpaYKmVSeq535gZpV0KXN
 mlIG4DHqhH2p9K82pThOxgmb4MjMwPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-LLI_w-FjOwG0qNXHez1GWQ-1; Tue, 23 Jul 2024 10:15:19 -0400
X-MC-Unique: LLI_w-FjOwG0qNXHez1GWQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36831873b39so3087134f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744117; x=1722348917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4jqXLR0c2v5lIJARFxGMhramSLLez6ADGH7aFWb5tc=;
 b=sUBEPKhdi5VLQehOevCrI7dL4mN35SJ740mYH9h4m5sWq61EGwLoXv1z03gfoWr0aR
 9CZTbf6TxHLp/DOTocqBqc8EpAzh93yJ8HUo1XvYvuKeYd7uPvkmJ2TuECdbgHN/iZFd
 dL1wLT5K0SupdZEgs7wbaVcnUQSUmvuChPTxSlUfbacfIXQYw81MSrDXYstLTyqUc6/1
 VIYOVz4Q73axTORlyWR5HFxVTxg60cAcipgFauDAvTWN8oFyfD+E1DsoganXzq3baPST
 jEkfzuvcJ5PrS5fG8cci5mTJfDrGqapK1MzEOvKs+FGlwueTf0htY73i/lOQYWO/vOLg
 r9Qg==
X-Gm-Message-State: AOJu0Ywk4ALxSRKV1jzAqpTgy/r+4mF1KWIkSBYGtexmVKxEhK+0A6xJ
 0Tf2zVoDa+dk8p1AjTjYMqV4EVqxoFv3rzB6fqnecf/tReD4K9JkNqWeHIHoXRVS4GFDR6iA7no
 RYDM5OA7F7OFSaUVVvdWWnM7zR4PEgM3XLfqizFZahQGkPMS24e+duCijeWKVAExNft/4eiPZVI
 WbPsYIzctzZTEkE5l8Vjasb3i1XRU=
X-Received: by 2002:a05:6000:cc7:b0:369:c6d7:7b93 with SMTP id
 ffacd0b85a97d-369dec0cfe1mr2425305f8f.28.1721744117552; 
 Tue, 23 Jul 2024 07:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpC1y3rVv0bhNY38+FQrun0E/DQoyXi8Q6mgaS9pUX6ooO8TisuUVoj4o5FcqD/dKJ/xRZScpza6agmCECeYg=
X-Received: by 2002:a05:6000:cc7:b0:369:c6d7:7b93 with SMTP id
 ffacd0b85a97d-369dec0cfe1mr2425288f8f.28.1721744117176; Tue, 23 Jul 2024
 07:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Jul 2024 16:15:05 +0200
Message-ID: <CABgObfahS8SsZmOGoy4XWiZ8vrtYZz6HNX7gJhgKeO=+ziUsgQ@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on I/O APIC
To: TaiseiIto <taisei1212@outlook.jp>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 25, 2024 at 2:03=E2=80=AFPM TaiseiIto <taisei1212@outlook.jp> w=
rote:
> Before this commit, interruptions from i8254 which should be sent to IRQ0
> were sent to IRQ2. After this commit, these are correctly sent to IRQ0. W=
hen
> I had an HPET timer generate interruptions once per second to test an HPE=
T
> driver in my operating system on QEMU, I observed more frequent
> interruptions than I configured on the HPET timer. I investigated the cau=
se
> and found that not only interruptions from HPET but also interruptions fr=
om
> i8254 were sent to IRQ2 because of a redirection from IRQ0 to IRQ2. This
> redirection is added in hw/apic.c at commit
> 16b29ae1807b024bd5052301550f5d47dae958a2 but this redirection caused wron=
g
> interruptions. So I deleted the redirection. Finally, I confirmed there i=
s
> no problem on 'make check' results and that interruptions from i8254 and
> interruptions from HPET are correclty sent to IRQ0 and IRQ2 respectively.

Hi, did you set the legacy replacement route bit on the HPET?

My understanding is that:
- if you enable legacy-replacement routing, the HPET will take care of
dropping all i8254 interrupts
- if you disable legacy-replacement routing, the i8254 will still
generate interrupts on ISA IRQ 0. If you then enable the IO-APIC and
program the routes according to the ACPI MADT table, the interrupt
from the i8254 (ISA IRQ 0) will be redirected to the IO-APIC's GSI2.

So the solutions would be one of the following if you use HPET timer 0:
- disable the i8254
- enable legacy-replacement routing
- mask GSI2 on the IO-APIC and use a different route for the HPET
(worse, but should also work)

Thanks,

Paolo


> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
> ---
>  hw/intc/ioapic.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 716ffc8bbb..6b630b45ca 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -154,15 +154,8 @@ static void ioapic_set_irq(void *opaque, int vector,=
 int level)
>  {
>      IOAPICCommonState *s =3D opaque;
>
> -    /* ISA IRQs map to GSI 1-1 except for IRQ0 which maps
> -     * to GSI 2.  GSI maps to ioapic 1-1.  This is not
> -     * the cleanest way of doing it but it should work. */
> -
>      trace_ioapic_set_irq(vector, level);
>      ioapic_stat_update_irq(s, vector, level);
> -    if (vector =3D=3D 0) {
> -        vector =3D 2;
> -    }
>      if (vector < IOAPIC_NUM_PINS) {
>          uint32_t mask =3D 1 << vector;
>          uint64_t entry =3D s->ioredtbl[vector];
> --
> 2.34.1
>


