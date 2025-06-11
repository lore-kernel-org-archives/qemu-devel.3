Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C903AC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPEht-0003tO-CY; Wed, 11 Jun 2025 02:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPEho-0003sJ-ML
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPEhm-0007WR-BO
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749622375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGbW66QEujBlw5k99bAp7vZLYJ8iYvaCzmHJj1Z+8L0=;
 b=DX+Vrok7K81p6HtwePFjwsQLc1Rh/xDOZ3+Z/hePhVC2fBD4aj/eTiypiO03Ap0E6DzvWV
 wmjkRjuAixnPz6OpiAkpBGTt17xgv5Z1cAMN6y1Yj6eV4fGvS8Ran2FFbajNw04xsr3/tJ
 HNjUTgVA40KoFike9MDfxnTQqZO1F+Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-CNTtV6MSN_accB2RTpL1Pg-1; Wed, 11 Jun 2025 02:12:53 -0400
X-MC-Unique: CNTtV6MSN_accB2RTpL1Pg-1
X-Mimecast-MFC-AGG-ID: CNTtV6MSN_accB2RTpL1Pg_1749622372
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d290d542so33596965e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 23:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749622372; x=1750227172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGbW66QEujBlw5k99bAp7vZLYJ8iYvaCzmHJj1Z+8L0=;
 b=EhUVaQq1Sc7AUjCIrFa5ZkORHOXiM0ToRvobdSOquIP73s7qk5W0/FpGJb2bDrzfi7
 aD+K1toh1JGmJfHEyUqVp6lRpLTMgQrbUdJgEzHdKI0PWFtdNoZE9gf7bPsxsLQpIzLm
 9uKSp5z/FZUf60lA/rOhLp+NAwjnBiaWT46y/YAMmsq7/a2xTR3Av5KOd1/PazZAU4Ta
 6zsWWfDbPh8E+xyq8UMCDqlgSiYQRl74/i3jiFhC4V1HaTvnBhW7FrfW1DZ9IXdbjL2u
 7avMjG6VehyAixZrE/jVZFmrdI290kZ2ikm9E0khcDr3ZskmxkPxb0TArZ+yTzTjDNUe
 5Cag==
X-Gm-Message-State: AOJu0YyNzu3ZwgmM+bO1u5PBBzw7oEtrgL+rcLHkkJaSr2QUNew1SYXq
 ztdmP44RpFy6dd6gPsdRWwMg/CnDvQPTBr2K9jYhaFIeCYoZWQ14cjIRRNiJMJjYEPsO3WyVcSQ
 wJQnrlcyCFi0D7oMQf0C6FzO8/38yMgETNyh734olMCLwToTd7tCuWU6xNeS00fQpsGwxbmWK8c
 wAfOdyDHlTDoTSNT6j2vCAxFAteoC2dNg=
X-Gm-Gg: ASbGncuLnw/ZqqbtzEWmyvhEart4Ge5LpCyX4TNhNauWhiNxYFBfB8b544gF+2l4QEi
 KY69m2w8E0JW6ctYp6vVGCC43LWbjqXhSU0paoIBLtFey50cfRHraR/XaZQ8aeBxWdlt1vdwEDM
 pKsA==
X-Received: by 2002:a05:600c:8b08:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-4532490c17amr12683635e9.26.1749622371967; 
 Tue, 10 Jun 2025 23:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFIa+0+NoGy9O19H4M/qQbh3SMx7KYcEKUWhoJoK47X0F0qfdcbL+H8ItxuTsFjKDK+n5XHOl2z8/GIn62lvY=
X-Received: by 2002:a05:600c:8b08:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-4532490c17amr12683485e9.26.1749622371578; Tue, 10 Jun 2025
 23:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250606123447.538131-1-pbonzini@redhat.com>
 <20250606123447.538131-17-pbonzini@redhat.com>
 <92c90e43-35a6-48a9-8634-0075aed2988a@intel.com>
In-Reply-To: <92c90e43-35a6-48a9-8634-0075aed2988a@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jun 2025 08:12:39 +0200
X-Gm-Features: AX0GCFvCH1lJoscWEKnXzARXDVl6XJjzMg_0izseKsjN3yVjUmu4qPkfkBTi9Co
Message-ID: <CABgObfbg5yZ_7xUsotSpbDtU=tKWTu-PONJcgnH98mkSx+PxDQ@mail.gmail.com>
Subject: Re: [PULL 16/31] i386/kvm: Prefault memory on page state change
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jun 11, 2025 at 4:56=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> Paolo,
>
> This one is not supposed to be pulled until we fix KVM as you said:
> https://lore.kernel.org/qemu-devel/d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@r=
edhat.com/

The bug was understood and fix just a few days away, so I included it.
I'll send the fix to Linus today too.

Paolo

> BTW, I have sent the KVM fix:
> https://lore.kernel.org/all/20250611001018.2179964-1-xiaoyao.li@intel.com=
/


