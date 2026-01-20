Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F342CA5FB9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFJL-0003EO-4x; Tue, 20 Jan 2026 12:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFJI-0003D7-CH
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFJG-00018X-R9
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768929269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoQDvc6A7+//zuquv8zn8ciw1M1QxQZNphCJsrqFf2g=;
 b=ARzQbMgjhZEE0ndGq0tMruvk2wdrOKCsCLtAIaM3IUryTnnKq311luXTifFuUwbvWEdOWw
 HtolCFqQR3Pu7dIsA1Jk67Jra3smDwxSGO/PPl+kpCni/gt6SPpbmGj0hMCLpRgAUeMsSh
 mnStMzXrNFZdqZa/x+ypAqGosYIDKUM=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-C3GswPvqOuiKUVPBUPWIZg-1; Tue, 20 Jan 2026 12:14:28 -0500
X-MC-Unique: C3GswPvqOuiKUVPBUPWIZg-1
X-Mimecast-MFC-AGG-ID: C3GswPvqOuiKUVPBUPWIZg_1768929267
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b6a8b32fa9so23101958eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768929267; x=1769534067; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CoQDvc6A7+//zuquv8zn8ciw1M1QxQZNphCJsrqFf2g=;
 b=ZSq5bVdZNP/E0LySjoZyO7gZ6eyoU9y1sa4Vp00Bo+FhoIbOiQhJOnnFt1mHwPvk8W
 LxghSjiRMZVjZcbWzvH6AENTWtx2mRrIGONY9JMvJn1Ms8vNTb/btLMNULaTRdGO1aMg
 ZaHP9L+4ecVgSvJz9fnA5FGf8mR4rzFaecfXXjkNNdCMTXdalhWiNOu79JOXVRyAl5R6
 gxJIv/nKtKcttM+NU4HX/iCFVhdNWgp98wuWrixBQo/IRJh5ob2qOsLvvZKY/AbSxtVY
 +50LhrG+s8tiFDNDf0l6lfCASyFrFmoj+mN9di3BqSD6qwMF+K7m7T0KQqLxjFuruDhC
 UxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768929267; x=1769534067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoQDvc6A7+//zuquv8zn8ciw1M1QxQZNphCJsrqFf2g=;
 b=cqP9+cjDvYEqKCA1w2LvWolpQChb8gSL4Ssn2WXFu3qklxH0CZvXUzXFxKp1fI8zwM
 U8/1k9MG9TMya/ipv0iU+n6ce7myp/mD/Mwxb3bVCh+9R9NhfJ7D+zl43hXKdCkQpNEU
 0xCo8O36wNkqyKOuf75lm04meJvvjsVJBEDrStD8F+WEOpLPM2wPSDk2zJsuUrQt2Xcw
 KTZKo8epnCVNHFQ1YgQD7AtyKq9wdCdWxBaMbEIpA6VEBTyX0vLiS2KTUb7cdYmCYBTK
 oi5pCoXfNSCXS58bkcFtIqbvp5xDb38iaCya0xwqbAAcUuVY2yeLLyV3baY6K8U2oGAN
 33vQ==
X-Gm-Message-State: AOJu0Yzqo6CL07yDECc2BncsflcsbMuVcMHKftj1bDM6gENFfr6iOsW9
 HyV/3ISjeLl3kOIb7tq0odmv/Y47htsWTab0Qau0waTu9KF5YvIByKM70m/Zg9l2fArZZ0l10vG
 Gxi2eKn5laMMoQKpixOdsu/ECMiXlnaFHRsLHw2QXjkrfZKyQYe2P9f/C
X-Gm-Gg: AZuq6aJrCNX3PrdrgsI9wpeJUMBN3Q/c5kqFA4D3972eBjwMlCLMlYIt/nsGHe+1uz9
 Qu8MCFdOjjXQL8SMAdsJbQ1sTnBm6Q9v+FGYeABiLyEpWJmp/6GrU15NL4Q9v+I3zxgcfIKux8V
 RRMtTYRXSIqAbydZDBtUa2q0SP5OI6So7V6uzt5Cf3P+aHZvrarUT/OC0LfTsndE+7x63xYyTEs
 6VZLN07SjprWaDKUrCXRBhVmQYKhtZVCG7n5BWpK0k7NXtOtmz+80qZDyEJBzyE1S8DAjxIYnsv
 gVi3GIftlp36QiqLrr+08gkIPXK5TO6syjArxFnW+uI7LfZjOC+lcth8G23v1gu6biBj+F7OjbG
 QnO0=
X-Received: by 2002:a05:7300:df4c:b0:2ac:1e9f:a0ed with SMTP id
 5a478bee46e88-2b6b40d9828mr14157060eec.25.1768929265781; 
 Tue, 20 Jan 2026 09:14:25 -0800 (PST)
X-Received: by 2002:a05:7300:df4c:b0:2ac:1e9f:a0ed with SMTP id
 5a478bee46e88-2b6b40d9828mr14156958eec.25.1768929263841; 
 Tue, 20 Jan 2026 09:14:23 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6b364579csm17627802eec.23.2026.01.20.09.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:14:23 -0800 (PST)
Date: Tue, 20 Jan 2026 12:14:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/8] Move ram state receive into
 multifd_ram_state_recv()
Message-ID: <aW-353Qwg_Qi_8yX@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-3-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-3-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Jan 17, 2026 at 03:09:10PM +0100, Lukas Straub wrote:
> This is in preparation for the next patch.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


