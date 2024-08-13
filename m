Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BDC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdsah-0001GJ-Bv; Tue, 13 Aug 2024 10:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sdsaf-0001Ff-Iw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sdsae-0006Cw-62
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723559613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=S9qL8VCo+dWsBeKCJ3AD8DygJ91nYYeGsrTD39o9KxFoGc8zi+gDB2LFCVZV4MnRS+yP53
 WkGerJs05XCSOwZlkgpaX9zuOCvqKTijtWkk5z0vRDF95cox+DChP9Fv29MYpKkS37cI/8
 Iuj4DGic6WP/V41H5iJz13nZVXuU3Rw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-eIwHsc_OPuuwB68uIUKtLA-1; Tue, 13 Aug 2024 10:33:32 -0400
X-MC-Unique: eIwHsc_OPuuwB68uIUKtLA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5bb35b28f82so3919719a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 07:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723559611; x=1724164411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=mPjQEize5vKAXf7p430HkjGZle/ZenFUCXQx7aOiOXnjyeph31dUlOrxnGzLy19cGm
 uOoTMyZm18gF54za/81brYulsVmGquJs1XB/lb9B87r9sSy2R6zxwoPOmoKgRBQkHd4/
 4DacjWTIWhy2DGIiRKrgSYbbTYTvsjXuRp+hCELSJsI4gVckkW7JZlqpE+My6jZoXe4/
 uuzfTMtdziHc0D22xrXZZEJT8nQAPQRwSl44Rbb3kmxFGaPG7qbuYBDg8FO5vqEWKcsZ
 a0iTqt2KXCJFakOKt5tEUP0p1vztudWHT0zia+P8gS+X8LWnIlu+Q60nrWLvaCYlbfqv
 PSsQ==
X-Gm-Message-State: AOJu0YyDfCtXFFMBZYGYJywgn/eYiaW889K5AEKpcMO+eXFzoFrP5zYD
 02LZ38rp3ASnJ9TmKThhtKOFoi6iJWJDhee3/FnwB5PmYkY2XkKKHfRhE/Tj8UPSiOYgwGXwEEr
 YAHStLRoYZPPGF603Ld5aDZM9IWjo50DqyvTg+vQAGnfkCM9ytLz7
X-Received: by 2002:a05:6402:35cf:b0:584:8feb:c3a1 with SMTP id
 4fb4d7f45d1cf-5bd44c0d345mr3101123a12.1.1723559611161; 
 Tue, 13 Aug 2024 07:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH81rnq+nw+m6oagBCzGKkuuoPLhTKtHUGMsL2c1VrQ8trdQSm5v1t8PIUUWitLarEuWfshQQ==
X-Received: by 2002:a05:6402:35cf:b0:584:8feb:c3a1 with SMTP id
 4fb4d7f45d1cf-5bd44c0d345mr3101101a12.1.1723559610763; 
 Tue, 13 Aug 2024 07:33:30 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd47c1e686sm678294a12.43.2024.08.13.07.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 07:33:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 cfontana@suse.de, kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
Subject: Re: [PATCH 0/1] module: Prevent crash by resetting local_err in
 module_load_qom_all()
Date: Tue, 13 Aug 2024 16:33:23 +0200
Message-ID: <20240813143323.75213-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


