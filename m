Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B132CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDbl-0008FH-QP; Wed, 27 May 2026 08:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSDbV-0008ES-AN
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSDbS-0008Rm-Rm
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779885788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1hoyLQWkNqzeXM4ZPbqo5pe4bez1RDmqLjbpPQhYYs=;
 b=JRFFR/h/MSBFWndf9EJuBLAIG5Ie31xqvIg2wlmZ7CxIRAwocGTtn+ONtVpdQzXX2Z5EoJ
 zImGjHLr7JUPXq76Z6LrXbbcS8zA1GvBrDEcl/iB3mh/+Y8q5d/KWXCF+OalvhGjyiO5AQ
 au9guOrfEXxzoXvV1MWwkATTj84G1Q4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-pEUo5C5SNnu0EfhjuOBr4Q-1; Wed, 27 May 2026 08:43:06 -0400
X-MC-Unique: pEUo5C5SNnu0EfhjuOBr4Q-1
X-Mimecast-MFC-AGG-ID: pEUo5C5SNnu0EfhjuOBr4Q_1779885786
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44d83e45febso8199139f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779885785; x=1780490585; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M1hoyLQWkNqzeXM4ZPbqo5pe4bez1RDmqLjbpPQhYYs=;
 b=JzkVOdMclD8F1GaZEA4yMB0UeW28YDQYLkCK2npl1g1dq53AO3+DRAWto4hR2p7Ccp
 ELBXXZpAhb9TNDyk0uUFJ2XCb7A2Ziyuh2n/JRCzOXW/0MCUx3OHUO4xn5oJIAyu6R1k
 YsPB4uY46eGzRgKVt75SWk1TgW29HX/PbIcO76v9jXs6fLXQtlQeNXRTHaus9piHqCqI
 5Dq5aGGEm/CPLQftu5petatBzlom4Ko/yB0A3gnFDfgn6YGuVHldt5MGnLAEAjQ4AN3w
 tr2rUccziCV02rF6eeiJD0ufMUCHyp7bzvjFkkau4o1U1U0bVa+Cx6kRwy/94zRNS/Df
 OfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779885785; x=1780490585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1hoyLQWkNqzeXM4ZPbqo5pe4bez1RDmqLjbpPQhYYs=;
 b=d3QRkVYzQpQuo5qFZ6oOZpLXBl34DfHtuBcwp74b6bH940zINYaTVINlDpmGxwn6VR
 A7NJASNrWSeR1f+90XooGgFJWu+qZHw3RU67j45h5SNZbu0nByIZ3zxysNXdQ6nn1g0e
 MhyTImkyUD/HzqbtQrBVwh4akXrwd96nrwhzOp2PoAyc4+pdMiN7j859UnidXggLPtZc
 IEmO8cKKNHIYeC/5AyaYNmmNLI0yvPmtMj8TnUaIpfmSlQk0iwa+fEtz0jdrHVQm3xRm
 QZlu2woVZB11Icr3CfiOYiyc3T6/at3cr2ujq9bmzjToB0A82EPsL6EvG7qnmv4b3MIP
 L4xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kYJqoz5pjz7eC3So2bmwHIdSSWDr23aC2MgOjNNuPs4Kx2cENsBdMjqrWXThLdrtokf83TFL9lpLN@nongnu.org
X-Gm-Message-State: AOJu0YwVig3WVqwofoq01QxNRMzqZSJZb31FqMq4Zg3r3M5Q8qJwjZfs
 l3po3EexiWD7hzcJBBPetdyxiVc7UoxwHGv5o08DXkbWIN/08wNlnELk8Jf3EUOOQ7or97TLffy
 OlIfpFOdVbUuWf6cSfTYqLMEimHWvzfGhZVLJWbfu28tCdC/klLep/A4i
X-Gm-Gg: Acq92OED7vyPEsSsgfz2wg6BvA4YW8jUtI3VatuH8HN0fKNZL3hyWSIyDQG9wEEJr0W
 Ba3M4o823GoUJOv/MgtJkbjBAjU+8AcHuYTdMlcUJS27IkngudY7EfjtdBKC/roNdeU96IR0mc2
 fZ+dsd62x2WG9GMGFM51dUr7I6U7v0YBotuMFU3ibxAUCLRiIb/4eEm9m8RtGlGDjnerBewkW+W
 aR05EiYUf4dFnDWUi3R3CB3szSNW5pSRFgAoUyEthsVmpMa1vd37MTNOOe+B0o3ZLXXrmqwoWDv
 wW+AA577U9g1VtsCJtV9lOepXZiyM9UPV6ExWZR3Q//SijdKx+wnhOHwoIERczhBXQCrLynzqme
 VlN0nmEeHSoZpYRoXI85RxomoDW2YE630tJQ8JHubgLCZ7ANF+3L3eQ==
X-Received: by 2002:a5d:5d81:0:b0:441:29cd:a18e with SMTP id
 ffacd0b85a97d-45ea31a381amr42950315f8f.23.1779885785389; 
 Wed, 27 May 2026 05:43:05 -0700 (PDT)
X-Received: by 2002:a5d:5d81:0:b0:441:29cd:a18e with SMTP id
 ffacd0b85a97d-45ea31a381amr42950274f8f.23.1779885784897; 
 Wed, 27 May 2026 05:43:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a281dsm5630720f8f.24.2026.05.27.05.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:43:04 -0700 (PDT)
Date: Wed, 27 May 2026 08:43:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527084202-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <ahbNQJlv736Ajlkz@redhat.com>
 <d8317a0d-6880-408f-924d-4cebd2f59690@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8317a0d-6880-408f-924d-4cebd2f59690@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 02:33:03PM +0200, Paolo Bonzini wrote:
> The intention of these boundaries is to reduce the risk of maintainer
> burnout from AI contributions, as well as the risk to the project from
> unintentional copyright violations.  They do not apply to other uses of AI,
> such as researching APIs or algorithms, static analysis, or debugging,
> provided the model's output is not included in contributions.

Although I will be frank, "static analysis" can induce maintainer
burnout just as easily) But I don't see what we can do about that.



