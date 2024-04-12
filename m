Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C309CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEll-0008NY-Qz; Fri, 12 Apr 2024 07:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvElj-0008MZ-Nr
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvElh-0005Kt-0l
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712920107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7FOY5huWn4O8JB3aXhFdTLL8lkSGoqBoyCHJwWo+QI=;
 b=TM6M8Qs+LOFJhA76uSVzXIu/PIRb1/Y2VZ/hgK3JGIZIITiai2m5oYlT8/VhCUUKI0fVAf
 wG1MecDyFicN74SKKp0pPObo5j1C1zqS+dlkOYaDklhOlvPDt1Vt0DuW6E5KaiGsHyPn/h
 CxaFWDzCpNkpkGfCz7jy8JaWrBshUT4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-O0e1Cx5CMbu2W8dIZfIGoQ-1; Fri, 12 Apr 2024 07:08:26 -0400
X-MC-Unique: O0e1Cx5CMbu2W8dIZfIGoQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343eb273904so483903f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712920105; x=1713524905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J7FOY5huWn4O8JB3aXhFdTLL8lkSGoqBoyCHJwWo+QI=;
 b=Wdm5FfXHXsopIzwqrwTAS/IjUzxU/vOTDqvc/egZCoGr0JCVRiiszyxf5ith4CS3F+
 9rA555oxewhAHAWV2Yj9eZQy0yhY0rCVGO02aP7VMwwkrRDgVfgj40W892DiawuBxyJW
 uUbPxiiucvRlFhV2yAFG3k0JBW275nxcpPPrfe0V0VczySLk2auCxCRYvj+c+IwZsY3v
 Panie/rd2pe/4leScVRurJBAWiZmELSO/wrdyjT1WsG+/8wOIlar89Tv4g7mIy5VnjIv
 FX2igFdFeALTxr5FQnC2HZofHBedTdVKzQbI87CV3wPG69sjEOh4z/8DheaEZ6yi7vTP
 tLaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULeozs5QyUGM6t902GmCk9t19Hb2z21F/CCzU1c2dW9a4pUyKwyifXyH3M5aOTn/px/F8MCn8e05KI3/5z0DESogkL8DI=
X-Gm-Message-State: AOJu0Yzk9FZO4Y0BDdPttHwD7zZ7G71L9rpv3jHJLAdtPJvRqhXwFzPa
 9CXc6elhgenetB/GvpchyAdIMoIMS9tQr32fGas25Pyuk0MnvYbvBlFR7cHjDu/vvQSqwo0R4wQ
 +G+iZLHIcf6shmM9IpRllPs2fP6X2uqcT2BJMz7MThNcdHRC8lYKXSC+D9dAnFYtLUuXzLOn3do
 +OQUINHUVY+qxStWjIt191705gEo4=
X-Received: by 2002:adf:f1c3:0:b0:346:9850:f8bd with SMTP id
 z3-20020adff1c3000000b003469850f8bdmr1532275wro.23.1712920104871; 
 Fri, 12 Apr 2024 04:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWO/LZ4K2IQs0GgQBTB+7iFCKSqs5UPHkXJL2PXTI5ErtjFZlc8Ygn+AC3zD9Bb2hDdFy2nKWXisNqn/eJ3BY=
X-Received: by 2002:adf:f1c3:0:b0:346:9850:f8bd with SMTP id
 z3-20020adff1c3000000b003469850f8bdmr1532262wro.23.1712920104576; Fri, 12 Apr
 2024 04:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240412100401.20047-1-pbonzini@redhat.com>
 <0eb8a3b5-cff2-4ce8-8e6d-ab4dc2dda84a@linaro.org>
In-Reply-To: <0eb8a3b5-cff2-4ce8-8e6d-ab4dc2dda84a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 13:08:12 +0200
Message-ID: <CABgObfbCae+4R7dxxVRMMmMc9BgYaGqVBMFTOSzY47u6_ykuAw@mail.gmail.com>
Subject: Re: [PULL 0/2] Final build system fixes for 9.0
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

> Since these 2 patches don't modify what we can build with v9.0.0-rc3,
> would it be acceptable to merge them without having to produce a
> v9.0.0-rc4 tag before the final release?

I didn't want to ask you about that, but I agree it would not be an issue.

Paolo


