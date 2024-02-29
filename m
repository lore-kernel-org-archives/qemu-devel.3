Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC01C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfntI-0002oy-NF; Thu, 29 Feb 2024 16:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfntG-0002oZ-75
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfntE-0002Hb-TR
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709241867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=R6ylsqxEX6xNDxT59BN5b7ey5tgWYc1homrvmSzpuYG6UgjYBtYUSuLz/zTlWnJYaAPqO+
 dBHFfDXunIfiFTm60YikTzbnlMWw2kprvoSMFDlB1hAse2JWdMEMEHTuYYeg5OUfu0wIM1
 5ZGOVyd1Zxj39CfMkk29oZXeBcmcSWU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Q_ux92vnO8aZtXZJJQ157Q-1; Thu, 29 Feb 2024 16:24:26 -0500
X-MC-Unique: Q_ux92vnO8aZtXZJJQ157Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56484d05dcaso821571a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 13:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709241864; x=1709846664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=UA1l8+UZoSkderpr7PmHETuTnVNGDo6YdS1gR1HhG9UQrUlbclvfLJq82JV9buAs4B
 p0EPvbw05XkNUH9SeCt08U+ZvZgU+L16EQ1FrDiM3WwUtjX8UIzhU3yAK2mAp58dLXEg
 0Kaum2sHVM0XYSuCfnEbl6ZoQ9aAUSf3nHrmvWPaXG1mWHEIq3OiTjxuGFb80HzbICN6
 v+lZHMys/gI2ZbMteEQsSPg5WxEAZMMpuqTfINnkk2mmaeJxin4Kv4oAWW8NkADIf+Hp
 2VtWXIGv3HuIOsSbAZOtRW0kFevGzpMc8tMK2LO3CkshcGDIBmKJ7ip/f4TJ6lOEKrTo
 Br4Q==
X-Gm-Message-State: AOJu0YyVCYCPD/BVhRUO1oXB+HXI8Gj1nI8RxhXWy/W2t57Esfru87ev
 HEXOG1isGa2XRXdeBf7VwLgZYdNfdzqqdtqrVuXGE63hEMmpoxZC4WkMoqN3BD/mQiaVVncAuiv
 4iktoy0PkciPUitW9Ja5khQmhI//H7xMfVxD9PwfE4zDdAZLm4x0e17CwZZl2
X-Received: by 2002:a05:6402:312a:b0:566:51fa:3647 with SMTP id
 dd10-20020a056402312a00b0056651fa3647mr85166edb.10.1709241864733; 
 Thu, 29 Feb 2024 13:24:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEQ8Gkizz+SMyc7fmLHV6/4D6SfB/QvICnkA2h097X3zrgzL2D1zMx4chKYzxNJEOP7SOUIA==
X-Received: by 2002:a05:6402:312a:b0:566:51fa:3647 with SMTP id
 dd10-20020a056402312a00b0056651fa3647mr85159edb.10.1709241864457; 
 Thu, 29 Feb 2024 13:24:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a05640217d900b005661a50b7c5sm945401edy.13.2024.02.29.13.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 13:24:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mlevitsk@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Date: Thu, 29 Feb 2024 22:24:21 +0100
Message-ID: <20240229212421.16204-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


