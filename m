Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21C9C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWKMq-00006C-C8; Tue, 23 Jul 2024 14:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWKMm-0008VI-1I
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWKMj-0006VQ-QL
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721759761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO49+1Ol3/GcmN9bhJXXgVAFGN391SmMx2XTs4GUXAE=;
 b=N0tqF0R2t++IbrAt7YSQc4/rDC6+VaL+D7D9Qx+IAPX9blRp7MCjGgyGbPxZWqm42s1ygv
 LglUsqnkJgHTkPlnecYxWZBttIuknkmqBJBdAfevPme5wimf4/BnOPleDCFJ+MtzrBt+RK
 zPKoOafjzv0f75Bi+Zcf0wcAust9f1o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Z7XgghNTM-iKAiIU_exVrg-1; Tue, 23 Jul 2024 14:35:58 -0400
X-MC-Unique: Z7XgghNTM-iKAiIU_exVrg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d9404e1d54so693681b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721759758; x=1722364558;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rO49+1Ol3/GcmN9bhJXXgVAFGN391SmMx2XTs4GUXAE=;
 b=XC6VM5ZaD5LNch0JJKE9YA+l4kzPETojCs/OF74pTnDwfRY+v+3gkoFuV7HjlrKpyQ
 c/dHhGZjgoxp7QEQSv1oUzjil0yPtfpM2qBOW7yVBI6bNprjkM6CemmXfKonsh2Wk3ph
 KkgaUnUUUBh/zNTD2PdkQjLBa/FJ2roLpq/s+ZIm7IpaEWzeC1MN5MH7CtaOkQmsORH1
 3PDUP2bFQVlF0RlnZkgFgcWcC8Z+Q0+3bmVKwN4YJ0KOV0rxwhcUiaooVJe29Y5TStzB
 /LClBL+xi5cO8x/qqgd3+nXdIEfDRQC8XWcJ+yBQ2ofdTqz0zZbsPd+LqWZ8onCtOmUO
 lMVA==
X-Gm-Message-State: AOJu0Yz5vbneWAcTPM720go8C4G4KRJrK2NGtAtM5/qd2Q/kSinYwNAh
 lxl7RHuNt/nGDkYn1D28TQ44en9VNZeRW6wW741UAvAa80fo+ViyTcRZu9QO+ejRVAjN5mMdaF2
 E42Cl6Ldev/AXXk6IVQog6rieM/WN+QLG2Z3ISE+QzauzEe4golDa
X-Received: by 2002:a05:6830:46a4:b0:706:d9dc:f109 with SMTP id
 46e09a7af769-708fda7cf96mr5654789a34.1.1721759757556; 
 Tue, 23 Jul 2024 11:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVbk7EdILPtzy1Xt+GSq7WFAC+AcSw/p7pz+VZJ927RhCZn1fDbIzQcqrg2miTylSu7F+TwQ==
X-Received: by 2002:a05:6830:46a4:b0:706:d9dc:f109 with SMTP id
 46e09a7af769-708fda7cf96mr5654771a34.1.1721759757162; 
 Tue, 23 Jul 2024 11:35:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b95ddc9254sm37831216d6.106.2024.07.23.11.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:35:56 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:35:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] hw/char/goldfish: Use DMA memory API
Message-ID: <Zp_4CiTghaq_ABLi@x1n>
References: <20240723181850.46000-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723181850.46000-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 23, 2024 at 08:18:50PM +0200, Philippe Mathieu-Daudé wrote:
> Rather than using address_space_rw(..., 0 or 1),
> use the simpler DMA memory API which expand to
> the same code. This allows removing a cast on
> the 'buf' variable which is really const. Since
> 'buf' is only used in the CMD_READ_BUFFER case,
> we can reduce its scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


