Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4869DC54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLmm-0001Rp-7p; Wed, 13 Mar 2024 06:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkLmk-0001Rb-JS
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkLmj-00011m-3n
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710325471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGdCTtaBkWpySlbT2fgD7tlfNPniQUDCJY7aqb16hRI=;
 b=LVWM3Fv5A8q+qCZNeeAGeUbBr5mF/59HMN7ZZYPb5fGoF8yEuHQWkh/lL6aL+b1xrPC/hE
 qJfqW7lY2CaqpkdTxcHEKbGjl8u803HgyHsk5yyG5kwdPLrsrX3x3wPWjtfa/sJbxlXTYb
 D3ar6kJPtWP1vpb8O0Ti7Fa9o2bDUn8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-i5KDJxtaPc68nrBL-kuwcQ-1; Wed, 13 Mar 2024 06:24:30 -0400
X-MC-Unique: i5KDJxtaPc68nrBL-kuwcQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45acc7f07cso52074166b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325469; x=1710930269;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MGdCTtaBkWpySlbT2fgD7tlfNPniQUDCJY7aqb16hRI=;
 b=wT8Z9dE5sdKl4X64/eFp53XMRnfwcTh/gyWaijeFqKOcYo4e1w7+hur7D4G01zwOdb
 pXwT6eHDey5h5/2nnN5iCxxjOal92UU3WW/RlCPpdGNJ8wZ+zJQzSXUFbtco96nG4HdV
 BKtzXtZhKPXdlO409LNw5lqvDerQ9dINiO+4QbLEaF1GxAHHZTswYL5wZyatm+O8tMGq
 qiFxwbZMzB+VuXN7kSh3JCqaAHmM8IN4djS7ah08UJLq/YHR/zDd6vLetGZaOzQDo9qm
 NeWBogOKt/WX3zRgAlbLGNdGvFv0UI/17l6N7ToMF8FLrUwI0+dPwNOx4X/K60ssAHfq
 fzZA==
X-Gm-Message-State: AOJu0Yz9M3YAi9m2to6VEgE77jofZKU6eHW9Q8AG4P85fPo1lIZlYzzS
 FrLfPMt+3loXguGRkD99tgQ3u2LorMV8gniw+FPy0mFYqEHyDS0oNHJU/GKGApuhHpyhgODPSO7
 MB1dAiO5+q7abtlpySMdkIsOwqV+cjZbBBWbuTOlZSDwx9qQASALs
X-Received: by 2002:a17:907:8b90:b0:a46:5f7d:862d with SMTP id
 tb16-20020a1709078b9000b00a465f7d862dmr791248ejc.75.1710325469201; 
 Wed, 13 Mar 2024 03:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCD2a0OejuEoxd5RCM88T/9i4E/4tUykTndeTsoyk4h+iPje/eSKvWOlUjUpZU1RecGSPnxQ==
X-Received: by 2002:a17:907:8b90:b0:a46:5f7d:862d with SMTP id
 tb16-20020a1709078b9000b00a465f7d862dmr791229ejc.75.1710325468658; 
 Wed, 13 Mar 2024 03:24:28 -0700 (PDT)
Received: from redhat.com ([85.190.233.128]) by smtp.gmail.com with ESMTPSA id
 gn40-20020a1709070d2800b00a45a72fadfcsm1544061ejc.23.2024.03.13.03.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:24:27 -0700 (PDT)
Date: Wed, 13 Mar 2024 06:24:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Lukas Stockner <lstockner@genesiscloud.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: document PCIe Gen5/Gen6 speeds since 9.0
Message-ID: <20240313062349-mutt-send-email-mst@kernel.org>
References: <7a27998637b347c287b6a1c1394669e2769fa8e4.1710312598.git.mst@redhat.com>
 <c74d58f3-ea02-4596-b5a6-15122709b9b9@linaro.org>
 <b1607b82-cfca-4461-a2cd-ac3cf8344bba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1607b82-cfca-4461-a2cd-ac3cf8344bba@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 13, 2024 at 11:22:43AM +0100, Philippe Mathieu-Daudé wrote:
> On 13/3/24 11:14, Philippe Mathieu-Daudé wrote:
> > On 13/3/24 07:50, Michael S. Tsirkin wrote:
> > > Document that PCIe Gen5/Gen6 speeds are only in QAPI
> > > since 9.0 - the rest is since 4.0.
> > > 
> > > Cc: Lukas Stockner <lstockner@genesiscloud.com>
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Fixes: c08da86dc4 ("pcie: Support PCIe Gen5/Gen6 link speeds")
> 
> (BTW if you have to repost your pullreq as v2, you could
> squash this change).

Does not break bisect in any way, it's a comment so I do
not see a reason to squash.

> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   qapi/common.json | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > 
> > 


