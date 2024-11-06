Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FCED59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k6Z-00071z-GU; Wed, 06 Nov 2024 12:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k6O-0006vT-Nb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k6H-0006ol-V4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730915148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SiBrVwamQ1vQgryWgCM1luhKwjYI+AijZ8lrSn/wlvcMqHMLHLNx4o7izIJ1eZ7KAagual
 4NjryRxL/auCWUkuOur09l0JBATNKHuY+btQgdOgDDmrMjguBoabcaVyoKILpOPmGQb2Xt
 b/8WgYh7v8SnHviWqHyRziB8YlJ5vTw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-tyFP3ySUN7u2PoNvz4QNLg-1; Wed, 06 Nov 2024 12:45:45 -0500
X-MC-Unique: tyFP3ySUN7u2PoNvz4QNLg-1
X-Mimecast-MFC-AGG-ID: tyFP3ySUN7u2PoNvz4QNLg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so432335e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915144; x=1731519944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GTGcMAoNdkH6Ji+71gxXh1yfweLILpE5jb3OE+hV3hysXCop1kduM7hMf3dFwYVc8d
 TW9ve3SZM4GenthSV+NwSAkhijSn/tCvIPOqsITNU6tcPIrkj3kx5/Pjw2kcoGfyNXDe
 7T6ac77y72s1koTwLkLez/1qN+GtfD/MJc2nPQJ90Z3YNiBmT5wMAmyJyQMtD0/ICnAJ
 ROCbhRFewhH0rWZGLG6D5T5ZXXVz33t1YBhiXNmeiK1v6D1fGMZOreWyzdHjE4vXLlXF
 Msb61vYLpnWGnZ5V7g4b+9cEmfwr/0BaMSIZ60gIo773pnV3oey2dSTrswGDBA1tuO0P
 vUjQ==
X-Gm-Message-State: AOJu0Yy73ZY9n3VsbEdTsI5xUduQA6GnHeMh1zuZhuBNAR7HlAn7rH6f
 9McwVIXsEhChZ8ibVNeZrceoXQEX9s+IgBpBwyfO/TVPOX8rRtv+zsi+iJv3X7j9TquBkL4upIA
 T2GkdomLNLVw3j9Wf9bq96LxTSJaCxwF8A6nUCi1j/JF6GHPoxknz
X-Received: by 2002:a05:600c:5118:b0:42c:b995:2100 with SMTP id
 5b1f17b1804b1-4319ac75a0amr328756735e9.6.1730915143994; 
 Wed, 06 Nov 2024 09:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYM7HDT1TIperVpiPQ+D0igS4VxYsmwopSoaPsbMaYQJgZQENePHKwarpaZM1+oJtl0vswTw==
X-Received: by 2002:a05:600c:5118:b0:42c:b995:2100 with SMTP id
 5b1f17b1804b1-4319ac75a0amr328756635e9.6.1730915143663; 
 Wed, 06 Nov 2024 09:45:43 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa709ec7sm32399065e9.35.2024.11.06.09.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:45:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] target/i386: Fix legacy page table walk
Date: Wed,  6 Nov 2024 18:45:39 +0100
Message-ID: <20241106174540.558375-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106154329.67218-1-graf@amazon.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


