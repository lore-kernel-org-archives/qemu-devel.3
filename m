Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72E4C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtHl-00042E-GV; Wed, 20 Mar 2024 06:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtHi-00041j-WF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtHg-0004yN-I7
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=IxMkpudkYanl7VUD1mRpX62IBuGxjsXZl+F3x0Mc9l1/n756YwWT9NxrVWx9IbGtnk0Yq/
 Shy166oeXibPxdUMhGjRlYc4xDD9aXutpXcU4hU+VYWYf3CaynJ+zXaG/2EMZUXUjGpFgD
 aVHLkDIcJ4g5xGhhbOWjFO186Z6JmYw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Sa8bHFF2P2O4DkhvHg9bWw-1; Wed, 20 Mar 2024 06:34:58 -0400
X-MC-Unique: Sa8bHFF2P2O4DkhvHg9bWw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-513e214be2aso3623285e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930897; x=1711535697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XCH0fnWoLyXiOlKmPb4RpyOlXRbJHleFmPCqTYdB1GBNpycWl46H8I/ZG5bukAIY+J
 y0kejVn0xLwwIRCffchjNIfi7GPQUov4uHCuXxkaWTqrIZ/OjCbr6CxVsp1gbs/FC8Ut
 3RN3tszAemxzQkQanWD0MLssk2kHLedzTesERJBWDTJRzjOfm8EeNf+mHJouIg5piL03
 0//cMttoNYwCdG9aQw6qRcrNt9OuOgDI+bCery3YF+47fXzcNJkmEucCG5D3GzhjmtrL
 eW14Faw71CDXhXQviNYagaOmN9HPCncZg8P5CqC2na+r4/cwX9n5TjLdhWnAbXpIumVa
 zg6Q==
X-Gm-Message-State: AOJu0YwVAFZbI+KStcS8TGwh5IgtyJ19Rd0gTRzU4Gt6/w8qYe56f897
 9GHb0XfaCYzuB/e/gsjT6I/Fkr5Gjv/B6yliKwcr+uH4vJiv7y7zGu2Fpjdztkystpy3Sm31UwU
 zgQt3ojOr9oGNttNaNrjke+rKGjCP0yzcgy+qk/6nY6utyJoAH2gX
X-Received: by 2002:a05:6512:2394:b0:513:e348:fbc0 with SMTP id
 c20-20020a056512239400b00513e348fbc0mr12009179lfv.20.1710930897308; 
 Wed, 20 Mar 2024 03:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdi/Fdl/VLw3IIq4dNTxqrlhWFVMyC2wjy6GXpKSDgSxS3RByHYYOGhH2jlL+k0NqBQ6QKNQ==
X-Received: by 2002:a05:6512:2394:b0:513:e348:fbc0 with SMTP id
 c20-20020a056512239400b00513e348fbc0mr12009158lfv.20.1710930896930; 
 Wed, 20 Mar 2024 03:34:56 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 og40-20020a1709071de800b00a4663450fa9sm7140904ejc.188.2024.03.20.03.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:34:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@intel.com
Subject: Re: [PATCH v2] target/i386: Add new CPU model SierraForest
Date: Wed, 20 Mar 2024 11:34:55 +0100
Message-ID: <20240320103455.1048663-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320021044.508263-1-tao1.su@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


