Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F623C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rho3N-0004Ou-SI; Wed, 06 Mar 2024 04:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rho3L-0004OD-AZ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rho3G-0003O6-Kf
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709719145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjnZmIUcmHzFi9LsiWqY4kNxYi8GVZnUFGXEFsHl6CM=;
 b=H+3JkNJ3iq9afOXZrwRIz3JavhxP05LeyPLqwXWAXi7e6Pv4wX7lSsB6Rq60eVptg/wrP9
 Gnb1+eV0emxZeNCnw4Ii89k3sMvjOMC63tCBAEzra3VU+K8ib1+VqL2uWAK+H1FvMfaAG0
 e976uadil2ph/i2YodjFTj0A5NGjDv4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-N5eMJKzpMeeXjUlC2AMEZA-1; Wed, 06 Mar 2024 04:59:04 -0500
X-MC-Unique: N5eMJKzpMeeXjUlC2AMEZA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7881a1ce399so514918185a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 01:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709719143; x=1710323943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjnZmIUcmHzFi9LsiWqY4kNxYi8GVZnUFGXEFsHl6CM=;
 b=e56Ts81ReDGdbvtq+pu3zO7N/kxoybPd5XdDkcxPxq7CbR8A/6crRuxRRRj3170w7w
 uksZkXywKropl6GZhjvsv2ExGjR2M8Rc/PAe84meIrAxP8BRBZ/wXRAWNy99hye/UxKU
 TP1UcZXpXpBWNc9OP3bue1O8z112oqzBDnNhwZ8q3Oc63Rgt/sOfAtRgW0b3zIYoW0+N
 A0gWCNg1ireTIe+ss1GQcVMe8nLF+V9AiXau63CstGghsdxJq1MwxIymTJVxygMe1cHv
 19KQOTkCJetOEJXlZ53nDdrF0yKp4t0JpbutGHZpIbxspBHdvbDte1INsgOqTZBvYPyI
 E73A==
X-Gm-Message-State: AOJu0YwJUIUvDl6sYMtTKsW15WyUTaYIPvH7PRuVZke5VouzAX+jj9zl
 lJvxRh4wGiNOvYWEQXV1CUq3Iw06rewjWvtN53NzuLP9QEqRIGd+81qfPbLN7e+BROLS5mSHsY+
 Ov6F/pTK6TvlbPpPL0Lof7Y0PAnTLYsQzOA/5Ee6ANFZ+6lGktAx1
X-Received: by 2002:a05:620a:459f:b0:788:384e:394a with SMTP id
 bp31-20020a05620a459f00b00788384e394amr4515387qkb.74.1709719143596; 
 Wed, 06 Mar 2024 01:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYy4lefuNhXLAXxLW3dSfApe44CPKhz9jyRnuSc9StHn9hL+TS5ChkaBsMhkEne9VJkiUI/A==
X-Received: by 2002:a05:620a:459f:b0:788:384e:394a with SMTP id
 bp31-20020a05620a459f00b00788384e394amr4515362qkb.74.1709719143302; 
 Wed, 06 Mar 2024 01:59:03 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 bk5-20020a05620a1a0500b007883b9681a6sm950403qkb.26.2024.03.06.01.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 01:59:02 -0800 (PST)
Date: Wed, 6 Mar 2024 10:58:55 +0100
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
Subject: Re: [PATCH v2 17/20] smbios: clear smbios_type4_count before
 building tables
Message-ID: <20240306105855.232296e4@imammedo.users.ipa.redhat.com>
In-Reply-To: <6A030F09-22CE-4489-9F7A-D7343966DBAC@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-18-imammedo@redhat.com>
 <6A030F09-22CE-4489-9F7A-D7343966DBAC@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 6 Mar 2024 13:17:39 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 05-Mar-2024, at 21:27, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > it will help to keep type 4 tables accounting correct in case
> > SMBIOS tables are built multiple times.  
> 
> 
> I suggest you arrange this before patch 15 where you are actually calling smbios_get_tables_ep() multiple times. That way there is no window where things can break between patches.

it doesn't break in patch by patch test, because auto is not in use yet.
It could be moved but, I'd rather not respin series for the sake of reordering.

Michael can you reorder it before 15/20 when applying?

> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> > hw/smbios/smbios.c | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index bf5c7a8885..b64d3bc227 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -981,6 +981,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
> >            ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
> > 
> >     g_free(smbios_tables);
> > +    smbios_type4_count = 0;  
> 
> Nit: Can you put this before g_free() because gfree(smbios_tables) and smbios_tables = memdup2() etc are related. This is kind of coming in between.
cleanup is not related to memdup, the later works fine without cleanup.
I'd prefer to keep it as is.

> 
> >     smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
> >     smbios_tables_len = usr_blobs_len;
> >     smbios_table_max = usr_table_max;
> > -- 
> > 2.39.3
> >   
> 


