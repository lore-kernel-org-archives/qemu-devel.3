Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D93CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTduH-00029y-I6; Tue, 16 Jul 2024 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTduF-00022T-OL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTduE-0007Lr-FS
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=V8ZCV9p0N0t7L3QJ8wOjCf/PR+WvBh7IKM/aMASCeLN7rHfddlFXuvj37sAYY7KtBpGAp3
 ZN5wkJwTMK7JhDu0XIhUlXDR9kSOCYuSGm8lBY5I0SBl3l3mkIy8ztM5ve6P/1ykx9jNfK
 TNJ6CMe1vFWZZXdexqqXbreJh0z6MYE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-eK9oPuBoNU-bjIZei2GPhw-1; Tue, 16 Jul 2024 04:51:27 -0400
X-MC-Unique: eK9oPuBoNU-bjIZei2GPhw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-368255decf3so495878f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119886; x=1721724686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=pgDlCzgVBpSVvC8LEzNzDWSkgyV6Q7i8uIuAC/Zg7o2YSxe/WzbcPvCUSMKTN7SPhZ
 ykzTD2UIvyCyksuamXUC57CN/C/U0gD6qqPDR0+fY3ob92EdqbmsHVcRTBwd7/6RtySW
 +TsI2Bhkp6d3HBQdh+V168MoUA5EBQiAaDtn5pKd7/kseaKMG/nQMgtNV5juW+k3yRMW
 RQ0QfFKRYcB92agrFQ+hQ4V2TS2PESwknBTKkbmzjG80XROhDsIntS7ekU5UogrDplzZ
 ULSVicQe93uUnos0179nBtQtz1o0R0eNxZ4G3457OUyWB61Lx621zMzQ2/J+tSG51Myg
 E9Aw==
X-Gm-Message-State: AOJu0YweJjvJZCK284NL0/r9dkWNBabOPomKxlKySQLu/2ZcGK8BOiWt
 yPR3IIkgkTIdJQfpM/yko8lrEb//TomTVHdK6HaUgkCVBL9YIV/iQCRP450D0V5ONbQttPJs1ml
 UTP+8F6pDNjz7XeLtsiOmLVnEceh2jwx+rGT5PphKGYS+Hhg9Vz70
X-Received: by 2002:adf:f886:0:b0:367:8811:cab7 with SMTP id
 ffacd0b85a97d-368261e8cbcmr975267f8f.41.1721119885793; 
 Tue, 16 Jul 2024 01:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Avpp7k7ETsomMYi7vi4zqY3dolLmSqicOzZ+SXUhk6pjXXo2EjX9acRVNpz8/x67Vk74Pg==
X-Received: by 2002:adf:f886:0:b0:367:8811:cab7 with SMTP id
 ffacd0b85a97d-368261e8cbcmr975246f8f.41.1721119885443; 
 Tue, 16 Jul 2024 01:51:25 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e71sm8342653f8f.12.2024.07.16.01.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:51:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, maobibo@loongson.cn
Subject: Re: [PATCH] qemu/timer: Add host ticks function for LoongArch
Date: Tue, 16 Jul 2024 10:51:21 +0200
Message-ID: <20240716085121.186007-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716031500.4193498-1-gaosong@loongson.cn>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Queued, thanks.

Paolo


