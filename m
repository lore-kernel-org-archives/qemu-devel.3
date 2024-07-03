Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F32AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP6Eb-00086z-CN; Wed, 03 Jul 2024 16:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP6EY-00080Y-EX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP6EW-0006ha-Rs
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720037139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTh6V3vpan2DAyh2Tcf4cHA0MOOo4Jzl0WxFWsqv6YI=;
 b=RncE5TLl4jVC2PAl2n4gnVO3bmhGZmgLf2QlQHEYQdTo72jrI4Zem3ajl3KN70Ho2eVEA5
 VGOeQpP2XmmE7PO0U6EzyvUcYIWeAoS/OXhLqwCxFwT0LSJKIsAcIhRMoFbUWghvZODYte
 USk9DDnENfrvyxmSmL54yFuaKDZZbWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-A-JVi13jMxiri7eTREWZeA-1; Wed, 03 Jul 2024 16:05:35 -0400
X-MC-Unique: A-JVi13jMxiri7eTREWZeA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367960f4673so490397f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 13:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720037134; x=1720641934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTh6V3vpan2DAyh2Tcf4cHA0MOOo4Jzl0WxFWsqv6YI=;
 b=ppCDXzP0BtP1z88Dk8GEL3/mOkrReKTOShhGvTEXuRAA77ZAU5VxbVWHJTRJ1NJXSw
 vX1Fhrxp4zmbQYQf1y8tZNXeC14u/EsdRf3ZGNokM5hdV2vMnvaNVKMJ8RYEbmPLGfvJ
 yee2tXDmErv7ufaf4jlJs4DfQcBFhxePHoW2sglVG0DW/r1ibzD0/yuDwlA7axPp+5qv
 lAV2dANa+RwIJBKeUgWkxpEy6jrTL6mwhoZ5Uc4GTaUAIsB0oHQ8YoOvjHHMi9s3/zF/
 bUgVPEsvdR4ngcV3yJ3v/KUDL8OBVXOAoiLHtY7ncYaAKBYYbFadBFRGMW5ySRdwLb+l
 H08w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjrN8CG5GAcOOGnFqxX28CxrwqaCkqCOERur5lVsaQk4nlRn5cyQ3Zv743V7sqIpQr8g8hNLp9CjTaGTYcH0nTiZSqtiQ=
X-Gm-Message-State: AOJu0YzIsTpxJpY/EAW6deyYrwQ3J3gunmPLRzUIz3BXw7Iqi1ISED9v
 USgRPsEHhnLie52fp0vDDapUlQgsY6rPuCBVtKIvgPMUiUm0Bb//cuUugBbtWOlyoSJ/D7SKS0Z
 wY0GjBdMcgIHi+pAXB1bpAhAj083Ulfdlo/uHq/h5CPuAnXWZqUr2
X-Received: by 2002:a5d:660a:0:b0:35f:fd7:6102 with SMTP id
 ffacd0b85a97d-367947cadbemr2145110f8f.35.1720037134567; 
 Wed, 03 Jul 2024 13:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1FnafM1hF+jyjDSfe9Q+MJhc6zQI9eccOyCVtgwbxcmzGHXKnz+xWCPJ0gXGcuZGneqUWhw==
X-Received: by 2002:a5d:660a:0:b0:35f:fd7:6102 with SMTP id
 ffacd0b85a97d-367947cadbemr2145089f8f.35.1720037133975; 
 Wed, 03 Jul 2024 13:05:33 -0700 (PDT)
Received: from redhat.com ([31.187.78.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36797718618sm1363335f8f.31.2024.07.03.13.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 13:05:33 -0700 (PDT)
Date: Wed, 3 Jul 2024 16:05:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Krasheninnikov <krashmisha@gmail.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio: Implement Virtio Backend for SD/MMC in QEMU
Message-ID: <20240703160451-mutt-send-email-mst@kernel.org>
References: <20240703145956.16193-1-krashmisha@gmail.com>
 <87le2ipigb.fsf@draig.linaro.org>
 <7c281582-e5a3-265b-f6fc-80f7a1f01078@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c281582-e5a3-265b-f6fc-80f7a1f01078@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 03, 2024 at 10:55:17PM +0300, Mikhail Krasheninnikov wrote:
> 
> Hello, Alex!
> 
> No, there's no patch to the VirtIO specification yet. This is 
> proof-of-concept solution since I'm not sure that I did everything 
> correct with the design (and as folks' reviews show, for a good reason). 
> As soon as most obvious issues would be out of the way, I think I'll 
> submit a patch.


Mikhail, if you want people to review your patches but not merge
them yet, pls use an RFC tag in the subject to avoid confusion.

Thanks,

-- 
MST


