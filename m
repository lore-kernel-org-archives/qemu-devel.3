Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8544DEDA694
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSPC-00082N-C1; Tue, 03 Mar 2026 11:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSP0-00080K-8G
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSOv-0006E6-K5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772554510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QzTvix6yuzFaBRU9lNQWQekD7vIbvf6n52R1w1yl/HU=;
 b=YVc4wohfyqOjH2hj2pwSN/ovD4uhHaV7AhnKEFlIwhbr9/hyWSNel4SYTf8e/g94GVx8uR
 dprLTrXdEYmri/MAbJGj7kJlnMVEE43DIr58Dtnd5KWhC3uZjL+xYxLyKhjWFcEUDxhUev
 IgIDZh5Cdlpu4fLnKIlONO5da4QGZ4E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-6XrqVQJwM1Krh5b4w1NI1A-1; Tue, 03 Mar 2026 11:15:09 -0500
X-MC-Unique: 6XrqVQJwM1Krh5b4w1NI1A-1
X-Mimecast-MFC-AGG-ID: 6XrqVQJwM1Krh5b4w1NI1A_1772554509
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899e76aa555so88683956d6.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772554509; x=1773159309; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QzTvix6yuzFaBRU9lNQWQekD7vIbvf6n52R1w1yl/HU=;
 b=giME5rStPcKybeCom3yif4tTxvH7y7uG8SPs6qW9px4TlG8elGr71aJtdWn/HgktDn
 /lvLpXeYl7hvpSExICdWFSGvobWZEvKAe/FlN46kW9AwTJ/HayIoXS/0CzW3lqzeepsF
 nE5jF9Sf73G4rJu/GMXq+8b94AesjvPeY2aaxBWQYcT6bZwGbZe08fHTVgjgA16F5XcU
 RDNEMGuVCL133AxOibaAFa7R3woIxN54SPu/f5q3Za10OydBsk96z68zdvZtPL5bLsoO
 nTYiuYmvHWpXEcW9f943mLnuaoU0TsY/2xpr7LgEnOUtCMFlxtTPE0RWlP88T0klKKS9
 xnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554509; x=1773159309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QzTvix6yuzFaBRU9lNQWQekD7vIbvf6n52R1w1yl/HU=;
 b=Z91qjjx+mfn+gbkuhoHiwaA+02hlbhF9xJ6p+J+Wxho/uKOTLQJgHFkwfRlhkJy1LZ
 TCBhIihMmtOoRTXYEbNov5MmfzeYDnvnSEqx7F4e+6jCm3xtyW9fKZ9DFB2qquPxaGPt
 YbwCJajD+A6w28Kn8YLS7Y283Fjknu1V8pAzNPQqPenqOHlY3dFMGmFxwDHoSz7Hwb2J
 L/hf/8weuBQrE5aK+F38vfK2NBNsRCfs/SMVERBwQTiVToWopiUXN8ZGOPMq6xJ6hZiJ
 G+fVQfNH6jZ6b2tQBn0O214vl9rWqEZbXIKVvRELHAOjm0UOq+/YcFlosjrC9rZEVn9Z
 PF9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7yHtlbDhOSiSBKnRi1YZgLfZab3pJJ0yEhgJVAH2AlYBM2omHoATlA2JXN6VtTmekzMNuurL0ziza@nongnu.org
X-Gm-Message-State: AOJu0Yz7JpNhO2hhXRg/W9Gvq1dG/NH8VlkdV7fVu0gb7VARq7EnrlPd
 5KpeRu5rLLHe+yCx/APlwP1YLxeLKUdLITNsfOXHvEbSQbCy0qrlqPNbrT2B18dPB0sIDEVhJtH
 lDeF9sbuHSAhDfC998vwVuTse7ZVqHhhWMQpsBhI/Ogcrp7R0mejljApy0CWQhpRP
X-Gm-Gg: ATEYQzy72NArjPV2KGdZTpTWqF8bkZxLzBR7c4GEIqEHJR7kg9HPTzAJqItp2R7yY0x
 tU/Are3P5xGrZP5gT0wBCHVkZw/X6fcyyHhebvHPBIg8vkPBorkv5tQXPDB5xOJijp0C9/HD3Mm
 OPgfKlDettSweY01ag3lkHEMjgfPrtzsoKtX91BRutqcH4Zh7GIw9moJsZ6/hmZW1X+ss1k2+zZ
 VVs09cKFXF8l3kmlcmAUb/qKADnNT7Z9JeN03J2be5+OMBzrl6Sl+8ueXwsa4BzlgVZA+QpDgxk
 UumdGo7ZxzXQNDc4NHpN0mA+vr1rSuBTwnuo6lD1AZfdlr0swFTUaGKrEU4U4oVwJNKNFMWXg1S
 4woZZqYifkwn4+A==
X-Received: by 2002:a05:6214:5012:b0:899:f45c:be14 with SMTP id
 6a1803df08f44-899f45cc757mr98477946d6.0.1772554508570; 
 Tue, 03 Mar 2026 08:15:08 -0800 (PST)
X-Received: by 2002:a05:6214:5012:b0:899:f45c:be14 with SMTP id
 6a1803df08f44-899f45cc757mr98477266d6.0.1772554508031; 
 Tue, 03 Mar 2026 08:15:08 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a08f23e9asm21711846d6.4.2026.03.03.08.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:15:07 -0800 (PST)
Date: Tue, 3 Mar 2026 11:14:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 09/16] migration: factor out vmstate_load_field() from
 vmstate_load_state()
Message-ID: <aacJALENbLzkb6NR@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-10-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-10-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 21, 2026 at 12:02:07AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Simplify vmstate_load_state() which is rather big, and simplify further
> refactoring.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


