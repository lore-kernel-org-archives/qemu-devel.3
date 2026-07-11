Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF21C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 08:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiSdP-00062Q-Dh; Sat, 11 Jul 2026 04:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wiSdN-00061m-0m
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 04:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wiSdK-0007Bt-MV
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 04:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783756820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CYVTOBlmUklmpZLG1jFyXhs1sQxjfRtp4qnO7JRT+Bk=;
 b=Hole68P7Ojln+FlULa0ZqlzzQZbreoo+DobluyJPnF1HjIcWy8VLYB5GlUD51YG9fSV4bI
 heQRt1eCCorvqxf+BpcOPV5CGvUW3FFgHfTIfMk9Re9ThgcI5U64LsJfue6pPSQeyBYG5c
 W1G+GM06vh61il3Fs7froSI6Vsi2Frc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-DAoM8qG9Plu2bDfUaOA2uw-1; Sat, 11 Jul 2026 04:00:16 -0400
X-MC-Unique: DAoM8qG9Plu2bDfUaOA2uw-1
X-Mimecast-MFC-AGG-ID: DAoM8qG9Plu2bDfUaOA2uw_1783756816
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15ce19923fso196161866b.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783756815; x=1784361615; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CYVTOBlmUklmpZLG1jFyXhs1sQxjfRtp4qnO7JRT+Bk=;
 b=WGBsQcksRDetdVhbtWEXdi0ziSScj4QDabHqPwxt8k/30NH4294+iQqeEA0Tn7D9qf
 P48GlH3oE/Fx/eqIWesm5N5JIltwHkrxn7+tRR1Smuj5N2uVxFynuqysn/Fd2b/DmIt4
 LnBT/WwKr/QkSKhUQfMktlPLSx4ZLxjuyqiGLm8Lgxs4TMvsJLJ2RrgAIx+Fdj+UAWGE
 OnbBYlOpYdTo3ERiWHzlh0/mfjej7hKX/pkWLNC+Tr/dOLwnRrH9PLqIQnyNFhynja+4
 dPa06NioUVcvnS53+8A6zhxxjKRDiOsBMtO+nPTeCeYnYslA9M6Z/56XC1F6LueZA9ru
 11Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783756815; x=1784361615;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CYVTOBlmUklmpZLG1jFyXhs1sQxjfRtp4qnO7JRT+Bk=;
 b=YV6t6donBKet9lBY2C5gQF0ELso6msfrLyOcv8DOVrSLLlePAJhmJ9DTDVJJHZujMT
 8Dv9LBJ2w88S2Xe+z+3zgLyOnuMG6dj1MXQXZD0V2yAq9S50KUVnvWNGhetOgHzvOUrg
 SBaxbuh/3sCTAvLfXTYm0C815TCByL8GcgAt4bw4Nr9Zu5UbdsV2TNpFm1Us1iMplv6x
 inheMs+06xR+aRmXGCm1tQn4+TABSpjA/wz07MEHTIdJGbhYubEX48qkZYJXZoX96AoE
 0Gl8cJxshUlnNwNoSwY1LBAjkl8QTOy8wQuP0i5Vso5ktiV1GMZXhrpJKS7UP93I0jaE
 yLNQ==
X-Gm-Message-State: AOJu0Yzfy2SaCXygdydo3aB3T1Mwuio1QPuvrUa5sTyZ3u9/AWiUWG7t
 QI4v3A2D/1KnHgTztUh6WQT4192di0AGcae6CFqQBQfOvYyLfA4Ohs2WySk+dTeN13pLJwYblY4
 rQrq+gwVOD6mgVYK18Hj2FrNY4HWLrd5RupsN69Cf8GJufQ08UIH7CTqT
X-Gm-Gg: AfdE7clfsvVwpLBCcsqwU9yvkt51VvM4x6CggSqLw9CQmU8USulv7nR3TTc1oJwbchS
 B0gCtZSCZHcYljLDRfxme4NSdw+UT7hsEJWeDRuHJEjtMljjIY+pycvQkzsNCKiPdUsPK0+nGGN
 Sa/8an9kRFjNvEPJuWW2CYPYDhTwfS3iNqtR7irZrAFcDi+gxEvCmfgmIruK2Zb+cDBWOAxnvcg
 TDI7Db7U2Bh2q06UAjHKz3PZIuHGt4vUuZhPZrnq4asK6K7DyJcn1Zr++qXcbij/qd6CfCyOWD3
 UQGOghNBa4FaFT4ZRtSl9u3j5XuNa8D4hBGuuNcthg3z8EpCLiz81Ya8NXky3Ecb3hkWzW99Cye
 m48cm/H7pEz6oSbrwktD+OPsCOnh5Dmm5IIjui7LutQ==
X-Received: by 2002:a05:6938:a08e:10b0:c12:7512:18de with SMTP id
 a640c23a62f3a-c161f3cedd3mr49638166b.57.1783756815548; 
 Sat, 11 Jul 2026 01:00:15 -0700 (PDT)
X-Received: by 2002:a05:6938:a08e:10b0:c12:7512:18de with SMTP id
 a640c23a62f3a-c161f3cedd3mr49637166b.57.1783756814914; 
 Sat, 11 Jul 2026 01:00:14 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15d5739621sm470316866b.32.2026.07.11.01.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 01:00:13 -0700 (PDT)
Date: Sat, 11 Jul 2026 04:00:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, sgarzare@redhat.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
Message-ID: <20260711035848-mutt-send-email-mst@kernel.org>
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710114305.2961898-3-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
> device, 2023-06-28) added the section with S: Supported, but no M:.
> This makes no sense.  Downgrade to S: Orphan.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


No, this makes sense. The reason this section was added is so that Milan can
get copied on vhost-user-scmi but not other virtio stuff:

./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
"Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
qemu-devel@nongnu.org (open list:All patches CC here)

Pls drop this patch.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa2df9cbe3..4d558ddee9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
>  
>  vhost-user-scmi
>  R: Milan Zamazal <mzamazal@redhat.com>
> -S: Supported
> +S: Orphan
>  F: hw/virtio/vhost-user-scmi*
>  F: include/hw/virtio/vhost-user-scmi.h
>  F: tests/qtest/libqos/virtio-scmi.*
> -- 
> 2.54.0


