Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE38C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBPa-0008TV-DN; Mon, 04 Mar 2024 11:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhBPN-0008Ri-Je
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhBPK-0006qO-Ow
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709570597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGund8dWrWdtVg7OgtEi7Hk2WzobqDUR2vASBBvDgzs=;
 b=KFHtEIo17/Xvm5PTXbrftSja/a9NcFM/Ajv3j3KIQl5CE+gCEixBbBheDkz998YtG8HAdD
 IEpnbNoX0mm0Xc36Ev/a+oAAcSdUiE96/OkiF7yi/28QZrn2DJidOWYLoR3RT/xZI1Hx6V
 jL8yUGd07aeNAYZfy1kZ3AiMpFqnsqw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-1C6Aq4SAPHqxPtRzAcTdEg-1; Mon, 04 Mar 2024 11:43:16 -0500
X-MC-Unique: 1C6Aq4SAPHqxPtRzAcTdEg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e0edcf4f4so1432521f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709570595; x=1710175395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGund8dWrWdtVg7OgtEi7Hk2WzobqDUR2vASBBvDgzs=;
 b=SGIoiYdbcMVwPvFUdzyhJ36J/MISYcByATJLSWxNfnTZiQh02UiO7HKviGqlPUN8gv
 dVhN8l4/q4pK8JB4vBCuAdFP2Ki4+07Mf6JqYTR3yzBHQqQ0CxKeaeurNirjy1nQK5Ye
 NLbY4zoGq+/f8Qztse96vQEKuXIVspXehGugFNZuAd/LWft+bBNl2vD93BK96uGF9HW1
 CTfjITC64WnrbxLXNVcDsPdeL/2OR8sttDQftBP5Su3RzGLuA8NYvKNbgpTGGm5E4WQ5
 +Nw9DVM+KkJwXQSkkt3t8J6DFPrHdEphaERo8IRGaeWBfU7bPPCG9Zj/ntQUojL7Oh7Z
 QERg==
X-Gm-Message-State: AOJu0Ywfg5HPEEUP11G8OCaVZnVh/EdW8o49KhgU8HZrr3ZTN64DVeXu
 gIgcUG6DnST2jkNgbSfKv8SrYQ03OL3HyVVSpbQHROEO5gXqB30ff6guUL0GB2l9GoMx5+5FXOr
 NXjAy7/oaB8PHTeaV7DHAj6oBp+kZsQVftxLRZVX/HZnxHsHx0oWt
X-Received: by 2002:adf:e811:0:b0:33d:3072:e38d with SMTP id
 o17-20020adfe811000000b0033d3072e38dmr5851894wrm.21.1709570595113; 
 Mon, 04 Mar 2024 08:43:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHZGwkUK/Cll/ir7xtDqlHocv489+xKu6mj2vLfNWX2QnZIiE/i0QR7rNbfy64L3NQze/SpA==
X-Received: by 2002:adf:e811:0:b0:33d:3072:e38d with SMTP id
 o17-20020adfe811000000b0033d3072e38dmr5851884wrm.21.1709570594776; 
 Mon, 04 Mar 2024 08:43:14 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 p6-20020adf9d86000000b0033e0dd83be1sm12662816wre.91.2024.03.04.08.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 08:43:14 -0800 (PST)
Date: Mon, 4 Mar 2024 17:43:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Alistair
 Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, wangyanan55@huawei.com,
 eblake@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 09/19] smbios: build legacy mode code only for 'pc' machine
Message-ID: <20240304174313.5ff4dc2b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240304152300.1be944ce@imammedo.users.ipa.redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-10-imammedo@redhat.com>
 <BB495028-FC8F-4E80-A58F-B3AC81732DFF@redhat.com>
 <20240304152300.1be944ce@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Mar 2024 15:23:00 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 4 Mar 2024 16:25:03 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
> > > On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
> > >=20
> > > basically moving code around without functional change.
> > > And exposing some symbols so that they could be shared
> > > between smbbios.c and new smbios_legacy.c
> > >=20
> > > plus some meson magic to build smbios_legacy.c only
> > > for 'pc' machine and otherwise replace it with stub
> > > if not selected.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
[...]
> > > +        /*
> > > +         * preserve blob size for legacy mode so it could build its
> > > +         * blobs flavor from 'usr_blobs'
> > > +         */
> > > +        smbios_add_usr_blob_size(size);
> > > +   =20
> >=20
> > Could this have been made as a part of a separate patch? It is extremel=
y hard to understand why you are doing this when it=E2=80=99s a part of a l=
arger code refactoring/modularisation. =20
>=20
> sure, will do on respin

I also has split out variables renaming into a separate patch.
Hope it will make it easier to review.
=20
>=20
[...]


