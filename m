Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B9EC54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWXz-0000KE-Ns; Wed, 28 Feb 2024 21:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWXy-0000Jz-5C
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfWXw-0004Gr-OC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709175199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJOWxmkUXM+kPUm2XqXvfb8UwSCYVnbJukHP52Kww2E=;
 b=YH0G4g/htcyGdv7vPpEhs0e9Okv6+oTMcWwE6nkt7u/tDUmGUjfHnAJe0APT+Ny3MOd/uG
 pkW3Dlcb6sfDW2O8ezGveJd6AAnx8aM7ihKc/EgrAD6k8rwJ/Zez1evqgH3PNASawR+2mB
 BU2M3/tEjzPTQ/d6t0QWHsd8za6qb6g=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-08ZNYOxlNLiKR_cjcua3sw-1; Wed, 28 Feb 2024 21:53:15 -0500
X-MC-Unique: 08ZNYOxlNLiKR_cjcua3sw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-21e4604101bso123110fac.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709175194; x=1709779994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJOWxmkUXM+kPUm2XqXvfb8UwSCYVnbJukHP52Kww2E=;
 b=ntHH/zMloYA/1SR7OVW501fuxJ0lXL/Id+hrFeDgYjdXCTatLTNQ3A5ykKvRY1qLnF
 Ium8WtLEILLjQN1iOlJAv0LkQr9lhBCCjT5af7eiLeMFWJGHWv18tUWXfOpkz2la64Ho
 tHo7HxvtlHQMTfdfVZEVbX7o1bFueHBD3AT6Mrofg1fMQoI11KCH5ha+P7mYPhbNXuKn
 Yqsv/B+hpA3d+SEFec0wgJ3WcP8HdqOWxqafGkhqCpDcPKetUf9NbL/nY8h8izUF9Kn3
 t/yp7lrmoZQVAjiQRf33IU4s6Gq2TWCt4LjlhVK6YYeoK89hHaKudRKEWm8h0GytiaGP
 i3CQ==
X-Gm-Message-State: AOJu0YyrC2evBxKVt9rp1n/1iDhTSPvcSGWbe9iK3r0smyCDOsdZ+ObW
 UT/VFLAXhUswgtNnan2rUKlQQE+RWauy7w0/GyiseJ++Xhr9xMykNjftWeK/fH1aEdPzB4EWnXY
 P10QxOXpPD2n/qgHQyGBYc58OmT/ZxeLSBET3pfmsye+bLOrp2oJZ
X-Received: by 2002:a05:6870:9585:b0:21f:c693:781d with SMTP id
 k5-20020a056870958500b0021fc693781dmr783540oao.4.1709175194812; 
 Wed, 28 Feb 2024 18:53:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnrnL92noTT4yX362xN90wwh9Lzr162S2d7BBxNEfeMGu79R0bdxJBvJnYdbxZ8UoGlq3KfA==
X-Received: by 2002:a05:6870:9585:b0:21f:c693:781d with SMTP id
 k5-20020a056870958500b0021fc693781dmr783526oao.4.1709175194567; 
 Wed, 28 Feb 2024 18:53:14 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b006e559bc3250sm156981pfq.68.2024.02.28.18.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 18:53:14 -0800 (PST)
Date: Thu, 29 Feb 2024 10:53:07 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 18/23] migration/multifd: Add incoming QIOChannelFile
 support
Message-ID: <Zd_xk7Xea8IfGNIC@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 28, 2024 at 12:21:22PM -0300, Fabiano Rosas wrote:
> On the receiving side we don't need to differentiate between main
> channel and threads, so whichever channel is defined first gets to be
> the main one. And since there are no packets, use the atomic channel
> count to index into the params array.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


