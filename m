Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9FC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmhT3-0007SY-Hr; Tue, 19 Mar 2024 17:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmhT0-0007SH-5f
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmhSy-0007Hb-P7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710885471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++i/QIppHyT8SWXVP1mOSo6XdapxsHqVuH/tc9iCfWg=;
 b=EPfecKshvG6dxAoYQ62HSjhAorBgwvoj9P3G57FTS+1Rfmc9tMGAR91QTUwLgUoCQolvJ8
 FolB5//pc0+zcLHbelg5fDDCkVLuDko5/tV9Sa/a5MeHcxUwwjJbxf2bWfV+wZrXngKsUV
 Bftn6Byi6f93r8fFAWN4Hjte5Z6x21A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-rVByGepmNvqi8o-Vj-WfIg-1; Tue, 19 Mar 2024 17:57:47 -0400
X-MC-Unique: rVByGepmNvqi8o-Vj-WfIg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-69152af7760so9048006d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710885467; x=1711490267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++i/QIppHyT8SWXVP1mOSo6XdapxsHqVuH/tc9iCfWg=;
 b=jJtvmly+dJAU94ZrSwmd+AlEBeahXeV/WzrUwZT9PdhrOAMtRiZKMTaKtC3VtyYyUf
 lzOJKEy88b0DpPflkGU/mnbP5eK2mVzdOmU/z6gA5ugVAemxggr/JSAImaS8305r0neA
 BkcJ1m4/8pNTqUfhsCgcigTRIJiJb4BenVDFuzTEpSiFArtC0TwVM6/70mHHzvrWRTKr
 eNmFQmLvhuS7viP9FqDLOQ9fPzq5mGC6r4PI638/PJ7eoif41VYEeuGRPcxNJ3Mn2Wju
 XXwU7njVHnHlIdRxbvV4XBtTJBjQhMkC/95YG2rr18KdQ+rCaymJ8BedrUeuiC18Ctk9
 OsiQ==
X-Gm-Message-State: AOJu0Ywqd/fU3HIBfR7vUZQTOQObpJmMuQSAfZsJqTyeaA4vaEmPnA/w
 OyP5U/8sgk3hMCdvDmI9ELY8EmtuBQYRDgC8ajnhju/4hFqUavoDVWJ0Nd0D7njK7wDC/oQ+IpJ
 towWR+BFO692SfowkRJEMSzuJDfOUVadCmTKF6U29jwN3vh2M/lr6
X-Received: by 2002:a05:6214:5345:b0:690:3c85:c5b with SMTP id
 kv5-20020a056214534500b006903c850c5bmr15172532qvb.3.1710885466685; 
 Tue, 19 Mar 2024 14:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY1e2st36yy+J/BfKXfZDylFuO4HCsF0tWMXTOxNGIwe4X6dwjo81h9IpHF6sGO15MLGYDtQ==
X-Received: by 2002:a05:6214:5345:b0:690:3c85:c5b with SMTP id
 kv5-20020a056214534500b006903c850c5bmr15172509qvb.3.1710885466241; 
 Tue, 19 Mar 2024 14:57:46 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 i14-20020a0c9c8e000000b0069160557ec1sm6843648qvf.136.2024.03.19.14.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:57:45 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:57:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
Subject: Re: [PATCH 2/2] tests/qtest/migration: Fix typo for vsock in
 SocketAddress_to_str
Message-ID: <ZfoKWHF4SeyN18Gw@x1n>
References: <20240319204840.211632-1-het.gala@nutanix.com>
 <20240319204840.211632-2-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319204840.211632-2-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Mar 19, 2024 at 08:48:40PM +0000, Het Gala wrote:
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index fb7156f09a..651c6c555a 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -42,7 +42,7 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>      case SOCKET_ADDRESS_TYPE_FD:
>          return g_strdup_printf("fd:%s", addr->u.fd.str);
>      case SOCKET_ADDRESS_TYPE_VSOCK:
> -        return g_strdup_printf("tcp:%s:%s",
> +        return g_strdup_printf("vsock:%s:%s",
>                                 addr->u.vsock.cid,
>                                 addr->u.vsock.port);
>      default:

Queued for 9.1, thanks.

-- 
Peter Xu


