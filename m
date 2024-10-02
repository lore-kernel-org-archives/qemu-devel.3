Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4BCCF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 11:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svxCC-0000hW-2Z; Wed, 02 Oct 2024 07:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1svxCA-0000gv-L6
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1svxC8-0005fm-Ui
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 07:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727867218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WbHOWPqsDYFnTNViuKfNl6jIxRFgDycYPJzFviXhA+AhBkB6RV5TE4VRX86RsD6qlV2lXK
 2alSnTV9tZkJOm2kXiWvXRUL0VcPKACRjU3jE5Q8lOObU4apKMUlFMs1mxqiJPHk8pP3Fu
 pXGitCClPli8PL9oBYk+2g9vXJpKk1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-m9y3HQZGOLaX1SaHeQgIGg-1; Wed, 02 Oct 2024 07:06:57 -0400
X-MC-Unique: m9y3HQZGOLaX1SaHeQgIGg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37ccd39115bso4116773f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 04:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727867216; x=1728472016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VBwFnXDcli5aHtiafjDicXC+yL5xb/Yo7UBTd6+zUvpXCC0lGaUg+4h8GOMa+S8wIz
 oEXWYGe7pRdT8WDzL4Re43vQmq/MmXqzsnirq70nm51Z2Snli6r8TCMzemCuKAUKIC0b
 6iVGWmJ40qPMCYmpuJHE2PxA9t7LVru08nKrtCwaQHIntSyTrhvJkp9WEk31mP/iVkpF
 aDG1nKbP3Ktwh46tfxLW/W70LRTsJLPIPBXoFSds4w0CfU7bglytoooa/FPmWnNgcChW
 eAg7L+n84fdw5OxZIj+PWFaZaE5j4V3Mkso+5eKLdBtmSDt55zK+Bze+SmBjlmzI86nd
 YJMg==
X-Gm-Message-State: AOJu0Yw40tMHFulqo7/3+GgIaK5OBIljsIVcKlPQWo4ZTyO3yeVYHBLV
 TLYWg1t9cKfL9eu1l4IKJ636ySn5RhTUhaiKfS0JAp9fRJsKFvQc8eFKM9gUNRcaz7r9DAjQyG8
 wgzeNFvVPuM0n8sKM11duJ38vgPsxQQUuBL/SqxcUbiifxkWyU8I3
X-Received: by 2002:a05:6000:2a6:b0:374:c8a0:ca8c with SMTP id
 ffacd0b85a97d-37cfba058f8mr2027406f8f.43.1727867216258; 
 Wed, 02 Oct 2024 04:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG54i823P9b5hFHlYWTlsq/iNuGQS4OZZRWJONdj70LbTZNbq+wnG9J/pULcTseDOX6QeJ1oQ==
X-Received: by 2002:a05:6000:2a6:b0:374:c8a0:ca8c with SMTP id
 ffacd0b85a97d-37cfba058f8mr2027381f8f.43.1727867215860; 
 Wed, 02 Oct 2024 04:06:55 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a00a501sm15629885e9.44.2024.10.02.04.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 04:06:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 0/2] kvm: Improve register failure reports for migration
Date: Wed,  2 Oct 2024 13:06:51 +0200
Message-ID: <20241002110651.458405-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927104743.218468-1-jusual@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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


