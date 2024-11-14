Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84CFD6A22C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgSY-0005PL-E1; Thu, 14 Nov 2024 15:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgSX-0005P5-Gj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgSV-0007c9-Vi
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731616133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNk5YH7FG9cRTH1pM1fXNgYutZ4iD4fRxmIpSj6rWOU=;
 b=BWQSiWJxvEA5oBH8JjhUJ0Ko1Uqvo8gB6XR9KGAglkQWKwCWFRXDtkz7wUAt5SCzQIM8Dp
 01GQl+4riCIJQxEs8ovfDTBmFLaoMsuCqQws2dexCoNx79w8XmFPTSGJnxpDbKLwvL/BLa
 shSDOWVfXNDq0++X0ih0x5jSkQwRm04=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-F3lhLlQZPhW6wLkeMA_oFg-1; Thu, 14 Nov 2024 15:28:52 -0500
X-MC-Unique: F3lhLlQZPhW6wLkeMA_oFg-1
X-Mimecast-MFC-AGG-ID: F3lhLlQZPhW6wLkeMA_oFg
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83aba93c01bso104960839f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731616131; x=1732220931;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DNk5YH7FG9cRTH1pM1fXNgYutZ4iD4fRxmIpSj6rWOU=;
 b=PNkEL2xX8+PZtUOhYLPQWUUS0ErlozYXGbUY8R9SAb/qhg/JAmi7qaVeGJPWibbfTv
 VUjsyZXBtuOxzccStxo2OnY3A8kNNTtUKKdgfqnrqw/bgt9m0aYXVDg50kQmmzKosFNG
 XzkcJrZRdJajTVvn5fPz9v1+1okzILgadQiFGvoRvFT5gKGwVHxUuiEB1dG1dzsvqxuT
 l45oN2Bky+WZzeVGG6voQkMtKkNN90FaNQKIPobi2bfbCjmB+QTFexjgJyOpFVQxWuTp
 /fW4daIOS9ikEzRTbqEIfObzF5giq+RanltGjLRBsspkldVEOXCKBomKtu5S4pYXZkI5
 LhhA==
X-Gm-Message-State: AOJu0Yzrfd3fprRkVOvEpkSZn4VRqXO2lYS0MHVaLu64SFCKj7JvlxxK
 2f8QEhNRFT+DuZQ81MQiN3H7oRd0cAB5I0VVPC1Yyq+HyL/cGSi0Z0g0umvLvX9rR/54yHDc0uA
 SQkXrRP0jV5sWNNhdnjN4T/O38gtgxbo/kDN/9FrT6BFaUadFZYl9jGYwk1qb
X-Received: by 2002:a05:6e02:1a6f:b0:3a7:2b7c:f5a3 with SMTP id
 e9e14a558f8ab-3a7480235cbmr902635ab.14.1731616131555; 
 Thu, 14 Nov 2024 12:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9qpLk2SrOkpnCuyx/SniJ7rU857A6n3B1kJ3UeFkNak+NHaO/lKD/Y9B6sUFEioIsrhuTBA==
X-Received: by 2002:a05:6e02:1a6f:b0:3a7:2b7c:f5a3 with SMTP id
 e9e14a558f8ab-3a7480235cbmr902485ab.14.1731616131283; 
 Thu, 14 Nov 2024 12:28:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a74807f006sm75575ab.28.2024.11.14.12.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:28:50 -0800 (PST)
Date: Thu, 14 Nov 2024 15:28:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 5/8] qom: enforce use of static, const string with
 object_new()
Message-ID: <ZzZdgLSdAlpsA2jQ@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-6-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Nov 11, 2024 at 03:55:52PM +0000, Daniel P. Berrangé wrote:
> Since object_new() will assert(), it should only be used in scenarios
> where the caller knows exactly what type it is asking to be created,
> and can thus be confident in avoiding abstract types.
> 
> Enforce this by using a macro wrapper which types to paste "" to the
> type name. This will generate a compile error if not passed a static
> const string, forcing callers to use object_new_dynamic() instead.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


