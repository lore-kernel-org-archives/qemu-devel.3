Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQXxbgcc;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ISpZjah+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTIBV-0003JS-KZ; Tue, 17 Nov 2026 07:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTIBU-0003J5-31
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTIBS-00038z-JU
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794918069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1fY5sladKUp27sduUhbv+2c3WbReWZQd5MP19FUMuQ=;
 b=YQXxbgcc5yYHK0JomUq7S6QqMRI+dxHBQbsOZjcbKaxfCdnZ6t9TYOLkzwbrFzwztpQBMN
 Qhz41uFWQIywNqiqofBuZ881bSkHzZrBF49c9gw1fEdAjt4Z/t/a9HU0BNEpZCUwU8b4J9
 mm6NNs7gmNVy+MYACHrffPMLLfZMXU8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-yQILjoD5P4uWzUhw8pcU-w-1; Tue, 17 Nov 2026 07:21:07 -0500
X-MC-Unique: yQILjoD5P4uWzUhw8pcU-w-1
X-Mimecast-MFC-AGG-ID: yQILjoD5P4uWzUhw8pcU-w_1794918067
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4a3052225cbso1197261f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 04:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794918066; x=1795522866; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x1fY5sladKUp27sduUhbv+2c3WbReWZQd5MP19FUMuQ=;
 b=ISpZjah+cw1F2ommUHKSuTZXyt8S0fN6utnJqg/SeP7gZw1QwrsFBbTihw421NMXER
 T6r4MKwTwZFcIcLBcxn/bQkV+zgb3EpyL0CZ7fz4GDQWrp4W2SF+klJeA/GlBo4URn63
 RN74QZ/gr3Z2q2B2RMKx1XFxA0/ukSIZYOLZduJlZxUPpUTa7b+guVGqlr85bNR4v17z
 RZ8a/AdbnvAf5LcRdYrYbiGPZTfrb3Ov5n4cjIoOHqdCn4N4qXQlPAVOb/fMtGUsWYw6
 /HR4KZrx2j6Ulp19HVHPQok1vqiY5+5ZTsi6kxMnkhshvVje8HmnIZjqZyVWKH/Htnbe
 KD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918066; x=1795522866;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x1fY5sladKUp27sduUhbv+2c3WbReWZQd5MP19FUMuQ=;
 b=Opi5W2anBV1FWnyzB4/T4yZIbuz2OfI4j6H0TgjkDJpXFDspUVAIrhqzJ1or6dmLDr
 sm1ikLjQ8MgANR9mkmVCjbMXjuxwj15I09Ni7L2Iq0Pijwj1iIcbFPn77gnylhM+Sg1p
 39eiwYx/tLdfAoFZpurzMpg+Yw8d+TOhD6neyw04FSq6lBNJH0LjFHdFyHA9213r9lgp
 K1xGCzQkMUAmTbvedjtDbTw5UvUYQwojy1/29Ec6IhrI9ZWHqqNicXBy3CqWJuJilWjo
 T0LZIPIQuld+sirjjH45UJ94g43ZSqIC/YYGoyTqbw7YmG54bvN5Fpq+JDpITiMNzblO
 9UBg==
X-Gm-Message-State: APuU4Z89MggD7KANLSJmbSbRxFDXxgDMATQcU9Tj+c9ve4KmHAwLxuM3
 ospPq9bHsDOR4VeVzyhiHSgXlqqWckEvn+9uR9+bqIgtpc7oudEcA1zRtPPG2vcDEH+oTfyrcwK
 XET4WOVASwb6oVGJTNH2OYyZ+wV54fFybd0QNipEzMc0cb9s+wtU4MaeX
X-Gm-Gg: AYBFou0nKasCzqM+nFVnm9LBBBLiDEiaN/Sla2OgqH64jmkdepMvW+wtrr+A4ZcCotZ
 v8l/UAuvecvCBtVmjeBWThHbNw3nnDl3WEQzmo3vt7nUvrR8o3P/yyvffoVEIce5snkrS152HyM
 BrIBMIsE6OTsNvT/jcduqg/mb9iI0aqMI6w/x5IZrs1a+MgWTAWukYId80eanTXkhsrLJQNqbwy
 4lTyDXfRsxbzAMqZvidGfVicyL72fjEI7CLcCEuz4s+2Faqg+P/ve+IZ14XnUqCtxf1XD0IDh9m
 R+wtkS+H1IeMHqgg4MJr0M0ax3oI6BuUgEFze59OSQUxx30VFWd7upxH9Ou8BurnP08mWs+9Tdv
 /o7F9c+8cz+vvXw/wedD7OjDlSy7y4t9fdnQtrIo0XZ4=
X-Received: by 2002:a05:600c:1145:b0:4bb:5fd4:3fd2 with SMTP id
 5b1f17b1804b1-4bb5fd44259mr164071565e9.17.1794918066495; 
 Tue, 17 Nov 2026 04:21:06 -0800 (PST)
X-Received: by 2002:a05:600c:1145:b0:4bb:5fd4:3fd2 with SMTP id
 5b1f17b1804b1-4bb5fd44259mr164071255e9.17.1794918065832; 
 Tue, 17 Nov 2026 04:21:05 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7ad96096sm27938695e9.9.2026.11.17.04.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:21:05 -0800 (PST)
Date: Tue, 17 Nov 2026 07:21:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
Subject: Re: [PATCH 0/2] hw/acpi/aml-build: Fix free ranges calculation in
 crs_replace_with_free_ranges()
Message-ID: <20261117072016-mutt-send-email-mst@kernel.org>
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:59:47AM +0100, Anton Kuchin wrote:
> The assumption that all used ranges lie within the provided window
> bounds resulted in generation of free ranges beyond the limits and
> incorrect address assignment in guest. As used regions are collected
> without any knowledge about which limits will be applied later, some
> non-standard topologies with multiple expanders and devices break free
> ranges calculation. Skipping such used regions fixes the problem.

Could you be more specific please? Was an issue observed?
In which configurations? With which guests?


> While at this fix potential uint64 wrap around if range->limit is
> equal to UINT64_MAX that can add extra free range at the beginning
> of the address space. Not sure this can really happen with some
> combination of virtual topology and firmware version, but this
> check doesn't look expensive and it's better to handle it now than
> spend hours debugging this strange case later.

maybe but it should be documented better.


> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
> ---
> Anton Kuchin (2):
>       hw/acpi/aml-build: Ignore used ranges outside the requested window
>       hw/acpi/aml-build: Avoid overflow when advancing the free_base cursor
> 
>  hw/acpi/aml-build.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> ---
> base-commit: ddb42c53b4d91d12511f49ee4428d9594eb5eb49
> change-id: 20261106-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-761219313073
> 
> Best regards,
> --  
> Anton Kuchin <antonkuchin@nebius.com>


