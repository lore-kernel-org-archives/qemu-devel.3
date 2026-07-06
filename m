Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C8C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgooJ-0005Wj-O6; Mon, 06 Jul 2026 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgooI-0005WG-8B
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgooG-0004UK-UI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783365411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88yuMG/BDV00mgWEL/fD1x+Hzn553eBkKiEM4gPinYg=;
 b=dgmoTlqkB0aYMg1fVp2pimBbEF87yjz5S9xzbXs+NrkuoIm0x/DLe4hyDxmdBOECv/wxyt
 GPo7L6/GX7gcnt5+Ia/qynn2GuTrQYpx83nYm18YOc2jgi56Ex03QR0wuHYAa+GPPaVP4a
 gXFmGvRFzB7GAQkIlNqNCRKxbZk6yHY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-JZLQmu74M6SttZkpmgDr4w-1; Mon, 06 Jul 2026 15:16:50 -0400
X-MC-Unique: JZLQmu74M6SttZkpmgDr4w-1
X-Mimecast-MFC-AGG-ID: JZLQmu74M6SttZkpmgDr4w_1783365410
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f08560ea44so40138136d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783365410; x=1783970210; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=88yuMG/BDV00mgWEL/fD1x+Hzn553eBkKiEM4gPinYg=;
 b=GXHbHrEySYw9ekpx7SEhxJsC+fDpc53IZ/4j1dvpLYvj/PtwtYwfKUw5OLjwlJVGvf
 JyIqP4MbyD3i3/QCXi5fO1hQdde9Lgg3x3yFrKd6GaZp8OC24ULmdlVc2fYDqaiBtj6F
 08Y50VdZkMxtdtuAMda8njGCXMyzG6pGh76rZ6V9ScWJ/xlSkTMFHbe2J/edEcdZ27nV
 TsiYWqovBrx3B+WtmTZIPpsWGN2ryPV0B4sVLHWoz/gP7CBQz5AmaQSaMB4gx9D3BNQ+
 VeQcNXB/FabrgJTcvSAotwmzjiXcsrWXSDpVbpYOi50gm5YOB2P1fQUTI1KWnplpbhIK
 vmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783365410; x=1783970210;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=88yuMG/BDV00mgWEL/fD1x+Hzn553eBkKiEM4gPinYg=;
 b=GX9USrLGqFcYbOsG+PWJ5j5ab35myGvNdzPSkCi5ev3CCWwh4IH+7ebuU0/qYAnKue
 rRJPzNiPaRlHsio/6QlTFYP5usnp6n8Lwy7gRJraIvyZE0/07dfV2bk0oQuAu2JPgR+i
 91ITdMdqywPbiy575avYcC7mOmLPaPnTLvYcNk72ah8pfY8GN5Hp8eSk6LOjcWrFJzSr
 m979Ixm0fJQv4x0lHU9uqxRZxfMdEDuSo/T0mvw7QqEFRJwH+xi9BKhfTYwElIuMsind
 N9IWa/7l0FGZda+mvcug3jMPd3EH9wiwodOpglEW7BassN9JjU5bgVelpZeAo3wEwssV
 DUBw==
X-Gm-Message-State: AOJu0Yx9Q0NTSweJubpCU9HIfX/e4vPxMORYow5dRyXH6on4X9G/l8ft
 mG7G3V5RXOPresMaBA7NiIHf+jh/5S+3r0KlEcMjBZjc+1CWsXUYl2sACCz7cV0MKwuCvdqNHww
 38gk1Y16tICAECpHlvccRo2ebo09AhTmhq5Kg6T5pF13q3f7+8H4AfluX
X-Gm-Gg: AfdE7cnL05AbmpDKM2ar2YrlEl8KkB9+CI4HVV9CBaYQERc3tXsmN5ixFYUWMPoIAug
 7czwweqwQnwNPFDCNePjzGDPMtQ69/wBzPI00Ey54pCfGQAsI8mwmgGSe8ggwmJ6qqzRWzOMPcP
 /QwdVzfuAtbgG70s2d/v9stMenRpcAEPlekupk/kcr9cAy8U6M4U1s7S2mF02SnPP5T40E46xnQ
 D1+Wmqo7MJVqCd86EVA0ZtrtdCKlddTggoj9e4yNrE1qNJIhGOwiK4HExBHVGD8G21k6MTfWn+L
 MwWcYm+RnQcnd3++23NuWjeU/GaWPVA9LPzs/TvRqKCQXeSN0sRgE353zJNsEMtFN8/XkBuVVQe
 LEbC+6jySgnTWMlo6/0uK3XeyQfRU2K2WefcUb22tlZ1MXcZx2lDsJ2jUB+/APP5k0sYkgg==
X-Received: by 2002:a05:6214:628:b0:8e7:8d53:240f with SMTP id
 6a1803df08f44-8fcb4903b8emr23660816d6.43.1783365409280; 
 Mon, 06 Jul 2026 12:16:49 -0700 (PDT)
X-Received: by 2002:a05:6214:628:b0:8e7:8d53:240f with SMTP id
 6a1803df08f44-8fcb4903b8emr23660376d6.43.1783365408693; 
 Mon, 06 Jul 2026 12:16:48 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471813d49sm141089746d6.27.2026.07.06.12.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 12:16:48 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:16:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 0/7] migration: fast snapshot load
Message-ID: <akv_HvRFc_J7Pm-5@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 01:49:33PM +0530, Aadeshveer Singh wrote:
> Future direction:
> - Add support for hugepages
> - Add support for multifd
> - Add support for vhost-user

When send the formal patchset, you can add one more patch before the
testing changes, but after the rest, to explicitly fail the migration when
any of above was detected (e.g. update migrate_caps_check).

It's just to make sure when your feature enabled (but with some unsupported
setup) it won't crash QEMU but instead gracefully fail migrate QMP command
(or migrate-set-parameters / migrate-set-capabilities).

Thanks,

-- 
Peter Xu


