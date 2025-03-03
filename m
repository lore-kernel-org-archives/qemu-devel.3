Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EB0C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5jh-0007z6-Jo; Mon, 03 Mar 2025 08:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tp5jb-0007sa-K5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:21:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tp5jY-0006u3-LA
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741008083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vstHstZZZ/vycyPcE/Pirc2m5zQ29pAeKebEDZUKeik=;
 b=G7f7xGeRPqxdkZIy3UyMGyfWJNGetJfAWntStOZzhJ1tLFjJuLsnSORB8KQkgg6FviJIEp
 SvtX1D12MtSH3Hnwe5Kwaq9pFWv7OBRymHHCzKtnIdbuF/LedZSLzqVaYCctefFAMufsjv
 3tJ2TGTRztov+jzmfohEqBYP9CtQPfk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-wMMwyI80PzScoyVfTxWmMQ-1; Mon, 03 Mar 2025 08:21:21 -0500
X-MC-Unique: wMMwyI80PzScoyVfTxWmMQ-1
X-Mimecast-MFC-AGG-ID: wMMwyI80PzScoyVfTxWmMQ_1741008081
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abb8e0944bfso452860466b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 05:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741008080; x=1741612880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vstHstZZZ/vycyPcE/Pirc2m5zQ29pAeKebEDZUKeik=;
 b=REcCovnrNlVQSMtG2uqhgDsARmyx3mAe8e3Y8Ueqej7R8KlPlGOw7wPJ3cid7jod+j
 Mz+nl7eVf6rfo1ZLdz2HMiXYvikJCkhbXB5xENjK98Jw5I3v4mYmQkOus64R//ovwwWQ
 te9Q1/k8+An56eMECZ42aw40haLTx7bEKEq5CTaPRnNkQXC60mcEGa26bnhY8C8RCXOc
 X+NM6fChj19fMfSGuo/DrxEf5Q9FktKP5P1mtmoibQ1odtZNHMRd+SkqI0YY4sHeJVNk
 CFS4J0D2G5I8167dexxeVdvwTqPaoUpdb/u2+LcdGjWZxgB5yp9Y1eyLfZxvax5doWfH
 8NQg==
X-Gm-Message-State: AOJu0YwQyYTgXTuOpyKSuKK58hGekOBsNiYo7e+Z8T/QFsSkOW2jN7kr
 /DcQUMAVrDrXUtwZjtVE8dlmJti1Kph4+dAR0vAp6Wc5n6F09hLVfqFyglqCoI6sB0WTIEZlWFc
 V5MMyopN2TlB4mzBl1uZYqHv0PyfhPQDtAkQICjCn9J+2S82bClAuUtS4qRfm8MUa82jPEckp1E
 1XbAj9mw+xe4+ZKuSliBYqKP8h4peQ2WaIXNNs
X-Gm-Gg: ASbGncsqu5g6Lbdyqo0ElffmQXEnep5NlcgXTd1RZ0Bol5uppo+EJ1dkUOoCfbGrieu
 qwWqmB5VQ/ETi7nyAqJ5xzl7IFK95UlE8ouazSKpbFuk8z361NxOuM1Vg/jYSszVDZTPP/BD9zs
 HBh9FOQ5yJr5g8Uj+HC6NZfpAjOGW83TZcIZYbUsyi0o8yTQi6KS0XhRB8aaX5ZuuzJmbcXNNNr
 YF571BiyaKwEGtMDSfSNm7j1K/rF3Jb4sKzp21abC7jpr40orwUXVSyQUz4Qx2lsCAs3MdoImlG
 8I/k40BqdZyOAdMVZeO6H2eS09qe9BXyRr+Txwb0w/m1FKu2jYhJr20IyWCCr0c=
X-Received: by 2002:a17:907:c29:b0:ac1:ea5c:8711 with SMTP id
 a640c23a62f3a-ac1ea5c94d3mr41629466b.1.1741008080189; 
 Mon, 03 Mar 2025 05:21:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+Vkb4h3rKw2S03bMlqtfpt7AbuvTq2vr4NxS72y33li64vdQsAKH9vrcPHbbQ9u/mxDHjfQ==
X-Received: by 2002:a17:907:c29:b0:ac1:ea5c:8711 with SMTP id
 a640c23a62f3a-ac1ea5c94d3mr41626666b.1.1741008079667; 
 Mon, 03 Mar 2025 05:21:19 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ed7d7sm794252066b.87.2025.03.03.05.21.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 05:21:19 -0800 (PST)
Date: Mon, 3 Mar 2025 14:21:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/loongarch: Adjust the cpu reset action to a
 proper position
Message-ID: <20250303142118.7f558c8e@imammedo.users.ipa.redhat.com>
In-Reply-To: <cae24c94-62bf-6876-2f80-1eb91646cd8a@loongson.cn>
References: <20250303063043.3237264-1-lixianglai@loongson.cn>
 <cae24c94-62bf-6876-2f80-1eb91646cd8a@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 3 Mar 2025 17:15:13 +0800
bibo mao <maobibo@loongson.cn> wrote:

> Xianglai,
>=20
> There is a similar modification already, just wait a moment :)
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg01537.html

Please ignore my patch (commit message gives good enough justification
for refactoring but that's it).

this patch commit message however points to the concrete issue
wrong reset ordering causes, hence I think it's better to merge
this variant.

Acked-by: Igor Mammedov <imammedo@redhat.com>
=20
>=20
>=20
> Regards
> Bibo Mao
>=20
> On 2025/3/3 =E4=B8=8B=E5=8D=882:30, Xianglai Li wrote:
> > The commit 5a99a10da6cf ("target/loongarch: fix vcpu reset command word=
 issue")
> > fixes the error in the cpu reset ioctl command word delivery process,
> > so that the command word can be delivered correctly, and adds the judgm=
ent
> > and processing of the error return value, which exposes another problem=
 that
> > under loongarch, the cpu reset action is earlier than the creation of v=
cpu.
> > An error occurs when the cpu reset command is sent.
> >=20
> > Now adjust the order of cpu reset and vcpu create actions to fix this p=
roblem
> >=20
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > ---
> > Bibo Mao <maobibo@loongson.cn>
> > Huacai Chen <chenhuacai@loongson.cn>
> > Song Gao <gaosong@loongson.cn>
> > Xianglai Li <lixianglai@loongson.cn>
> >=20
> >   target/loongarch/cpu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> > index 3788f895c1..67aa7875b6 100644
> > --- a/target/loongarch/cpu.c
> > +++ b/target/loongarch/cpu.c
> > @@ -640,8 +640,8 @@ static void loongarch_cpu_realizefn(DeviceState *de=
v, Error **errp)
> >  =20
> >       loongarch_cpu_register_gdb_regs_for_features(cs);
> >  =20
> > -    cpu_reset(cs);
> >       qemu_init_vcpu(cs);
> > +    cpu_reset(cs);
> >  =20
> >       lacc->parent_realize(dev, errp);
> >   }
> >  =20
>=20
>=20


