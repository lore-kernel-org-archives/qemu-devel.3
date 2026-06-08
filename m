Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEB7CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWajr-0002Oa-Hb; Mon, 08 Jun 2026 10:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wWajp-0002OS-C6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wWajn-0002cv-Vk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780928039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4+4h5fFP1NV0lwD5Y4zUMevjL/wV8Vxk3yfpGhh9WY=;
 b=EsjGh6cmNG9hYxOxXEzOY9LmCWOfp0S6yL3jqlD1RuvlLY8pYQn3g4ipEPaVJ1+JLbTDcH
 SUf5ZSn0FmuPKuyZv4sa0p6L8cLiGIIHtZDrLVBMkfsnkhm3MF5mRyeAZ1gLkdOVpyLr9c
 AzRn/EohAXJ74UPNsksypbB8Bs25jGM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-q_H8wsfuM-OyKhr74QvWTw-1; Mon, 08 Jun 2026 10:13:57 -0400
X-MC-Unique: q_H8wsfuM-OyKhr74QvWTw-1
X-Mimecast-MFC-AGG-ID: q_H8wsfuM-OyKhr74QvWTw_1780928037
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51772325a64so59148361cf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780928037; x=1781532837; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4+4h5fFP1NV0lwD5Y4zUMevjL/wV8Vxk3yfpGhh9WY=;
 b=k/bf14MTeJjMdyPw1cXbKyIyJ7kTm6RRPoGPFhfAXnhPpW7BKrG5TGL1JhoVLpnEDS
 AFzl6TkuKESP6wc3tw6Cbw0UxClSP8w9Fydg6U+yiNXnRjoJt4Md/mkQ7PuPuo/gr0Zi
 iExZLkureLNVtajvx4tu0Asnw3+Z1TvAV7YlRkfPYmUesjjyaFicAcakntZUzQtzTAM9
 9JrNKQpT0bEH7yn8PBfWbR4svQ0mVwwLHwhPTInvJn08uTXouhVwN+PXZaVBUv0nUAjs
 3RBdJ1fiHb+Hb+QdwaI3lXJZrjMOo5HHRUmv6DdlN9rrQszrSeRp9ti8yc+/nPocZHuI
 43JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928037; x=1781532837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4+4h5fFP1NV0lwD5Y4zUMevjL/wV8Vxk3yfpGhh9WY=;
 b=CjNWQNn/rPiLqUaH+J/6C24QfAMQ3QHEceLFu8mhzIeInXVpR/9fGRwhyGl1GzeKuN
 OvKvUjd8D+M2hZaEF+3c7h+PlDBd48KdWFUXW2PI3RhBWdJ6J+SJYuewCc1Sm6elYlLo
 fu/fWPs+Y87bWyKhBEF+KLeV/pQcJI5r++QooyqVfyl8/SaJx+/k1czNZHSVRlvZmMpn
 nJRTYFk0JUvTbef+uJxQRKLhobchACVgrvKrTXBi6JT+9ZkC1aOcuk5dK6e83Jgn2lxr
 Q45znVleNEZRi4ToSqrHxZutn+S0ptbWHNy0iazau5sPAsNKlKj8CoYoEmJ6Ja69dihh
 wZ4Q==
X-Gm-Message-State: AOJu0Ywu5/iKNOyRtp+BYDyJtohisXL1Aa8apEGlgWviYbzFZq311cDi
 ptabkS4hyBqlZzcnDQ8SHXF8S5bj1D6OTRzdYWWoTNAS49s/yjkWe8Vvr+QI1l5ZLU6RpIjopfv
 XMF9EiAzJUZoiT6up/PpTk+W3XjYvVxd7ASW9hh7lldGIGOiepminx+C7
X-Gm-Gg: Acq92OGwOQk7csuIxMYU8UG1WeC0HZUqez6PGVKViiPAc+5PFNBGH4Y1xP81bp1MSri
 YVzQ0V3VNvckjOLAm70JsOW8eXAM8/dra2QeovIB+e1rL50trQSjLZSufvUDsYe1hVzB5JS+FUE
 i6dkgnSXOroNyxctNGjg9sZmkVFFlBGEG72m3nBj6qC79tS0mstP3FhKC8/Lg8WCxkPW+Zr0ok6
 ZWLjO2UBSlYu7xG0t9JNq77CdJzXriolGFiae6S4YKrihk/3X1b9VLZHbwSepNfdj/XpXpcC9mf
 RkMMjSbmonClzMGwjeJLrrIknDS/0zByhKToFSkKDlA2iPxR+x2cp4pejzvFxItoOMafXdDrQdr
 n0IY2SOQ7ovPCNlRxq3QsxyDozA==
X-Received: by 2002:a05:622a:99b:b0:50f:c2f8:4081 with SMTP id
 d75a77b69052e-51795c5b470mr213794921cf.53.1780928037136; 
 Mon, 08 Jun 2026 07:13:57 -0700 (PDT)
X-Received: by 2002:a05:622a:99b:b0:50f:c2f8:4081 with SMTP id
 d75a77b69052e-51795c5b470mr213794151cf.53.1780928036508; 
 Mon, 08 Jun 2026 07:13:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51795d46f12sm98892481cf.16.2026.06.08.07.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:13:56 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:13:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 philmd@mailo.com, shan.gavin@gmail.com
Subject: Re: [PATCH] system/memory: Remove MAX_PHYS_ADDR
Message-ID: <aibOI4LfV7Wci7zt@x1.local>
References: <20260608002303.851456-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608002303.851456-1-gshan@redhat.com>
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

On Mon, Jun 08, 2026 at 10:23:03AM +1000, Gavin Shan wrote:
> Remove MAX_PHYS_ADDR and MAX_PHYS_ADDR_SPACE_BITS as they're not used
> since the addition by commit 052e87b073cb ("memory: make section size
> a 128-bit integer").
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

queued, thanks.

-- 
Peter Xu


