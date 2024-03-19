Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4C4CD11DC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmhSn-0007PG-2J; Tue, 19 Mar 2024 17:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmhSk-0007Mj-IP
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmhSj-0007Fv-3d
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710885456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQON40HmMvKUBjLdWHB6cunt6US3Hyg+9PVDUnvKtCY=;
 b=Bs0G4IyiI4sOQoteVWr3X1FGz0yFesNKTYEkS81GKMN2rWuLV++5xs3mt6eTpcV9/ZKkhL
 SSJcjx97LtF3X05n+TYNppMnKkIwV0bzz1qOwms0JrPZM83Il8yVzfqP+sREx13RwfGgov
 mXPY1/PbVzl+KOo++plbbGNcO2fOZMs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-52_Hw1HxPfOrSpSIYHvXrA-1; Tue, 19 Mar 2024 17:57:34 -0400
X-MC-Unique: 52_Hw1HxPfOrSpSIYHvXrA-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc6c5a52a3fso1912510276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710885454; x=1711490254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQON40HmMvKUBjLdWHB6cunt6US3Hyg+9PVDUnvKtCY=;
 b=SXHzXubJcI1PidDyYNCO6NTDe16Rfx0YTa7vPDuLHk9+juBXheUPhuTUAFHeOS9RM/
 2ZBBofEfAk6rIbqjEoQKQBeXuWuuipbSqzrp9svjS/cLqOBsMyblraF0rbJUcG7dGvYS
 MSb9apAgm0rapl2J6VjCsobhqbZREFcNg4GFJmawJa5m4SZsV++EYBmD8DfPvNwz7MkJ
 aBinVZuuA+XmxXMlX+cG/425hWp1nimsY1VJ1+asHMqwlJDtWHRKsWw42TsgVleT3heE
 f/59/LllvBb2jN14rAkUOEJgJS7lHLmc70kPDsp1mAYAZ2ezsKD5l0j4jk0eZgx4gD8Q
 PfrQ==
X-Gm-Message-State: AOJu0Ywg+l75stxNiCdhyIFYYvkbPPsXe10YeLm1nQVkDdPj5YeiaLtO
 IzzFDSBK1/c1v+AKTRuTsXiY6npn2CnaCenZLXajt4BO6AjY+Y3G0phguUovqiZnkw0cIeUo2KV
 uKlCzTmiGw7NOHp3hZ4GXdXSmthTavA99WyWwY5L4UbZee8G+kYhK
X-Received: by 2002:a25:e047:0:b0:dcc:f9ce:ec1d with SMTP id
 x68-20020a25e047000000b00dccf9ceec1dmr6345ybg.0.1710885453776; 
 Tue, 19 Mar 2024 14:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUbcN25PCF3wjsHiENmKEXtKt32wtuBiN7sEmrWuQGncUtxQys9DvXx1iOrwuBvBW1e2/LzA==
X-Received: by 2002:a25:e047:0:b0:dcc:f9ce:ec1d with SMTP id
 x68-20020a25e047000000b00dccf9ceec1dmr6331ybg.0.1710885453304; 
 Tue, 19 Mar 2024 14:57:33 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fp41-20020a05622a50a900b0042f3fa77602sm6637192qtb.2.2024.03.19.14.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:57:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:57:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
Subject: Re: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
Message-ID: <ZfoKSgJ9LN1Q7R1V@x1n>
References: <20240319204840.211632-1-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319204840.211632-1-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 08:48:39PM +0000, Het Gala wrote:
> 'object' can return NULL if there is no socket-address, such as with a
> file migration. Then the visitor code below fails and the test crashes.
> 
> Ignore and return NULL when socket-address is missing in the reply so
> we don't break future tests that use a non-socket type.

Hmm, this patch isn't as clear to me.  Even if this can return NULL now,
it'll soon crash at some later point, no?

IMHO such patch is more suitable to be included in the same patch where
such new tests will be introduced, then we're addressing some real test
code changes that will work, rather than worrying on what will happen in
the future (and as I mentioned, i don't think it fully resolved that either..)

Thanks,

> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index b2a90469fb..fb7156f09a 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
>      QObject *object;
>  
>      rsp = migrate_query(who);
> +
> +    if (!qdict_haskey(rsp, "socket-address")) {
> +        return NULL;
> +    }
>      object = qdict_get(rsp, "socket-address");
>  
>      iv = qobject_input_visitor_new(object);
> -- 
> 2.22.3
> 

-- 
Peter Xu


