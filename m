Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52141C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXWJ-0007yL-GN; Wed, 28 Feb 2024 22:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXWH-0007y5-Bg
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXWG-0006UA-0z
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709178937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeAs52hGkPv1QVAWlIyo0Ppq06zGpKGm0jvEDCckoiw=;
 b=DAUFUvkIzjkt/2H3Ag+M11EIksBRqDLmuEiqIwLVBTcVX2ChGPjEmgfs8PfvcSBS1WRS2r
 nJZi2ozce4qJvJDfDKojC3ITz+rxeLrp2RzbNpCT8nOuxnQh2ilBMrIwo4z4dXL38cG18u
 zF0DoX99eZxWm4lVxpNFZyAPFcBnqh0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-tKrRMSxHODCxwC0Ig9pNHA-1; Wed, 28 Feb 2024 22:55:36 -0500
X-MC-Unique: tKrRMSxHODCxwC0Ig9pNHA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso135945a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709178935; x=1709783735;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeAs52hGkPv1QVAWlIyo0Ppq06zGpKGm0jvEDCckoiw=;
 b=f+uiqjaVGPKhjFV68CxCK10LUfLoEHh9H9MUU8Y/K1AZWVjDLWIIsZE2RMshpwl0ig
 bhJx42cCtnREWLoytcSC/xOwyLyHJ5CgjgL47YeuL+9aiUa8QrXScmvSkVeYBCQ95JzB
 ZGyGj5DRujSBEAwz2xo7fvZGwcDGfL7FWjOsK4/u0vCUVwMsyWnBU8Ec3S8UKZ6AXMWw
 uzD93pYNglKdyptN9egeFfKXc1eX9S6YlnBr9dxNpzDlLWWFxKo65GaEuVA+rYouBsVI
 4763qH5xWrcXP+MToID6yboTo/OFEunGuJ27TWjezXVUraNPpSnjp+dYWUTA7k6Q0cq1
 OsPw==
X-Gm-Message-State: AOJu0YzKR2eUNIXVx6wGGpP4szHJ5qZOokoHQ1OYNgudol7w+5dkH4/4
 ccjfE/Qr3cpaZ0b7UlDY2KSPIsn1PZPcRudlbFirOcK/D4xN0kBOQei823teGv2LORB/IRw8vI4
 Ba6x4Hq7sPk49cCFztV2Ux5tH+F3o4WSMqLW8jAqZ8DjmnJ+GRbc4
X-Received: by 2002:a17:902:a60e:b0:1dc:825e:42a with SMTP id
 u14-20020a170902a60e00b001dc825e042amr904842plq.3.1709178935380; 
 Wed, 28 Feb 2024 19:55:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4OsfbY5WAO5jiIdyAXcZfWs5BDgr9pyj3mMYAd54hJfa7kn4zbPI9UNaQaj+iRLbxkHKCzg==
X-Received: by 2002:a17:902:a60e:b0:1dc:825e:42a with SMTP id
 u14-20020a170902a60e00b001dc825e042amr904833plq.3.1709178935061; 
 Wed, 28 Feb 2024 19:55:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170902c3cc00b001dca9a6fdf1sm239784plj.183.2024.02.28.19.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 19:55:34 -0800 (PST)
Date: Thu, 29 Feb 2024 11:55:25 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 02/21] migration: Remove SaveStateHandler and
 LoadStateHandler typedefs
Message-ID: <ZeAALeT24PU_Sy1i@x1n>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-3-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227180345.548960-3-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 07:03:26PM +0100, Cédric Le Goater wrote:
> They are only used once.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


