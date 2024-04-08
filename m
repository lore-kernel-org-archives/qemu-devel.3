Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5E1CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk0e-0008LI-Tw; Mon, 08 Apr 2024 04:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtk0d-0008Ks-57
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtk0b-0006Y7-R3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712563541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZHYHLAX1d2luu89RRyn/z2dnJu19NtRIbhGbrZjrUsygDF91/lSLxtxE5FV7yntUlJKx8w
 j5yzKwXJy7/hDOypN7+5N0v1KMeKEPzRgv+Uzl5lJYRrH2mu1OcsI74L1cCrFxyGy5vtxq
 R7d8GMR3dWj6B/fXYKGfWuy6XGIiP7A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-UxDUorYyME20pDulXmsobQ-1; Mon, 08 Apr 2024 04:05:39 -0400
X-MC-Unique: UxDUorYyME20pDulXmsobQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56e4827e584so1302165a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563538; x=1713168338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ufwwactt7y+ycd9mTKh1J/Boj+4InQ0DLGMP0TobSqGVThQ5WzrdV2iYx6cwTJNnD5
 E9sEiEEMW63mxEYmh3BBMTMfbez1R45hHjs7eWs2bpALnsjrrR8HOnuCc61rjRRivbMs
 zS8KpEGu9YU03w59JaWqkkod0J1fFbzyOJnEhBVGgBLOB0iHZfyY4+0CFKC+PSBm0gs9
 cFtOqLfH0zaKj0TLehhjOvvHHtBmrKCitGVVXcjU1F8UYRH7YE4JCow4Qj5JC7ZrVebq
 8gpMKd9RyuE3DObkuIIQM0ryge7z05ps5QyCVNZRMXPRpfGeVIXXAAHbaZQiWaQ+LTRS
 YC5w==
X-Gm-Message-State: AOJu0YwubvN2hJ21AsaL65//b3lx+fgwctR77AV2crHNIxB2/Hg26dLy
 tJOMyGYZqjAFWc1CjCOcsGJeWK9Gt3/yYleAISJTO7hlWHwszzQEtfAK/FJ/jRKTwrGTa46C9Fz
 6jXd3weDWDNsJT16w1EBSqwaRf3IeqCbbT1UV4Jy4mVgfmUV0jrBDaYom1Vof
X-Received: by 2002:a05:6402:4347:b0:56e:2458:eea9 with SMTP id
 n7-20020a056402434700b0056e2458eea9mr6529315edc.20.1712563537918; 
 Mon, 08 Apr 2024 01:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi1lbBQVHIGv5hodqzHPGlXylZA/87iQQBuloMK4PwJEUOKgnOFKL/ORycy/FCysgIRCzCUA==
X-Received: by 2002:a05:6402:4347:b0:56e:2458:eea9 with SMTP id
 n7-20020a056402434700b0056e2458eea9mr6529300edc.20.1712563537637; 
 Mon, 08 Apr 2024 01:05:37 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 k19-20020aa7c393000000b0056bfb7004basm3632166edq.90.2024.04.08.01.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 01:05:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: Re: [PATCH] Makefile: preserve --jobserver-auth argument when calling
 ninja
Date: Mon,  8 Apr 2024 10:05:19 +0200
Message-ID: <20240408080519.315039-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402081738.1051560-1-martin@geanix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Queued, thanks.

Paolo


