Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BBCD0BB56
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MNG-0001CW-UY; Fri, 25 Oct 2024 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MNF-0001CC-4T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MND-0001vQ-J3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729870629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaQTCEqsfZ+6HSH6ERGUkS6mDWs5zP1bAjIaMcG3DE4=;
 b=XSzTSd3xnO4S2NAnC+YsSDSlnA31xb3dEd6WcWMcpqK5lczEe7DLAX9FxgZ3mgQJKGgHNf
 0ATkY+17Xh4F9Zk9qIBEyrH+KG3d4uiJSMEpSs+mLLNl5w2TC6dhKvoiki0yipYoiVkDSz
 AmfUocUqR2hNVjAttt8yNfvSrQEqjNs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Lh7dWMybMN6gll5QM44mqw-1; Fri, 25 Oct 2024 11:37:07 -0400
X-MC-Unique: Lh7dWMybMN6gll5QM44mqw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso14594065e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729870626; x=1730475426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaQTCEqsfZ+6HSH6ERGUkS6mDWs5zP1bAjIaMcG3DE4=;
 b=IJEISoSPvtgcqj2Du3ZzZSLddPhTwCmi06WIvyL6LAGKrktLkmORoQY1+4rmcHsIfg
 3azWhPyYMzHUmNy8+Kw60Rilcn8DRj//3cXqbz+LGaqC5eti6V8yt/HTFEcvtSNwAopz
 bEMwVhBZVO2vo2n+UGp8RpcTESWyN0lzk++I8sUVGXl6RGCNgCkT3LrMS+9oBv9dGZ4S
 PL6EgVWh+4N3bQ3IPFIgPoZ8NTGgFGvyirA0FsgiRqTwO2nkUlGXaVXUZ6Oa1s9+63Cy
 O6dSc7yGazKU5fshYc6gLcZflsQiHfuYCiZ+4slkF8LwXCX/Us7DXgPiOzB8m3y3F1B2
 9BsQ==
X-Gm-Message-State: AOJu0YwIjXi008e4YjmHZgDNEA9FQHMij9qupk9pr7Xo6Rw8QKvNko+E
 2Phn9PVowatNzchss7DJ0UBVeyVOaxkjSet/BM+XrbIKU3y/spiAInGY0gnpsz+4POR6c7eNFPp
 yh61Zc+LO23RtvXkYGqnIWGAfHx4ADO2PEKHoCiUkK8/i34fKmBxbxwO1Oofdhhc=
X-Received: by 2002:a05:600c:584b:b0:431:9397:9ace with SMTP id
 5b1f17b1804b1-43193979de0mr24469125e9.10.1729870625872; 
 Fri, 25 Oct 2024 08:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4CRmTt1x0IrNWGrzCEn+ucImYuSbLnm2PM+bdub2Gh10vXJzBqX+cupirFXEWqx/cUG1FDg==
X-Received: by 2002:a05:600c:584b:b0:431:9397:9ace with SMTP id
 5b1f17b1804b1-43193979de0mr24468985e9.10.1729870625521; 
 Fri, 25 Oct 2024 08:37:05 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5430edsm51468545e9.2.2024.10.25.08.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 08:37:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of x86 general
 architecture support
Date: Fri, 25 Oct 2024 17:36:56 +0200
Message-ID: <20241025153655.188892-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022023628.1743686-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Queued, thanks for offering to help!

Paolo


