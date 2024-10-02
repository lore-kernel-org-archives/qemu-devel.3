Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572E2CF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 11:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svxGB-0002yM-O0; Wed, 02 Oct 2024 07:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1svxG7-0002xz-9s
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1svxG4-0006CL-JL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727867461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=a21/wkJYLY+j84S3bPGCMVGg5c55wPnU9QfiRr4F9/yDoRCttsbNsRZQGjmLWM0ti/+whj
 Le3IjzzLxFwOATE7MnyQI0RO+e2h405CbF1Zb9mkORMMcE3AjamqTd3UhjW8J3EDJxPWTU
 rmZgCD6HkFeK2ocQHJ2gtVhIItZ4L48=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ISJfJqtwN8OzqbOU8uHTOA-1; Wed, 02 Oct 2024 07:11:01 -0400
X-MC-Unique: ISJfJqtwN8OzqbOU8uHTOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso37448255e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 04:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727867460; x=1728472260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=FhrhDTNHa/EiH+h8lQKiJ5MpGDghi1jfSpP0GBrW6Ix379ZIoKh/QifghDCQQYHayG
 fYe0x234wYI3mHDZM3ok2CoKZO45vrZxaYDlCwx4RKJ8RA4XsBpUrYtYRyD7af0e3aAj
 vnI0hbglFA+ek9YEZeg+ZzNyUx/fJ//pDUk6ivPeRV2L3Z2x80z+2f9EL8a3ub1+E0f6
 5F8jXB5Y1SRxrsqFIVEHPTZO9zhGtV/bT7CMo7qH2SSORRCPR+aSFy0F1NBJqIgL7faw
 49PJT6StwqUXj6kM/dwyLYTZCi6DI3VPrJHX1+rhoivSrBcn8neuOvUqz9zQ4qWEUEIH
 M2Rw==
X-Gm-Message-State: AOJu0Yxgp3bAXDDXIL1MnkzRomTGwmBN1x84Rhctya/jY2Hfo/gD2iQs
 EORNYGG6DP+nsLGuhEhsSnXpDxN9qap3ffbmGcZzHQpgED8kyGkvoJzrms/oNDfcgVgxmoZcAPO
 meLR9x5JqcZNhkX0KqZ6et5YBjwiuvdQe+TNEXmMtYs48B/W9VBQl
X-Received: by 2002:a05:600c:4f50:b0:42b:ac80:52ea with SMTP id
 5b1f17b1804b1-42f777afae3mr18337085e9.6.1727867459759; 
 Wed, 02 Oct 2024 04:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEELUKNNjkYrg41yJv4m5BmdLNxVGhpPshm+zdWNJUyixoIKAoAUmN7pgTjPG8zTyQslkgsXA==
X-Received: by 2002:a05:600c:4f50:b0:42b:ac80:52ea with SMTP id
 5b1f17b1804b1-42f777afae3mr18336905e9.6.1727867459394; 
 Wed, 02 Oct 2024 04:10:59 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fd9asm13765884f8f.75.2024.10.02.04.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 04:10:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] QOM: little improvements to object_resolve_path*()
Date: Wed,  2 Oct 2024 13:10:56 +0200
Message-ID: <20241002111056.461453-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241002080806.2868406-1-marcandre.lureau@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Queued, thanks.

Paolo


