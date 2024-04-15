Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CF3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJ0R-0000M9-GA; Mon, 15 Apr 2024 05:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwJ0O-0000Lm-EB
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwJ0M-00088Z-Q0
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713174720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEcy9//jlC/L/E7f1uHpmmakPqaVknws3pe+/RVvmeY=;
 b=NBYtpXMZaZESQn4LCQLD+syuK+MPle6bYXCms7vHphy1jD0zRpUGjfKEARNtqjcLwyMACB
 DOidFlmMJ1Vdc6HRQxycWD0FhLJra6OAXqePHJbg8hVwUQEGG4tsxeNX4FyxV+fVMnqlXj
 JQ2z0yXt6WcNbCMJvc1NieybZD7NYX8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-DQTfkRJcNJOCSWLoRQpfUA-1; Mon, 15 Apr 2024 05:51:58 -0400
X-MC-Unique: DQTfkRJcNJOCSWLoRQpfUA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-345fa9052b7so1938448f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713174717; x=1713779517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEcy9//jlC/L/E7f1uHpmmakPqaVknws3pe+/RVvmeY=;
 b=GRLHCK9eZk0d23hNhPt1Zp2VzADRdU4ZDXUBukxN3UyHPUvZxERIM8NG1eO4c21qmN
 CO41bQUmoGBjSjcPk1du53BGdTbk1ThQ1jSrLsLrHCPogQHDOhDFjcR7ItMcol22BiPh
 x7xGCXPNAGRV+LCSELr7Dd1XN8hOljPhGSoISeFIIeXYlde61KY3Zr2RMBa9MZShQkML
 WxvnSY6+CU07Gd29beBx9WJWwHgxq65QeLqfnlTmntDjAl5ZCqlws0a81t2VHq/1GzJB
 sEnF8NG2nlgOnhXAWBS5EZHuncfe42mGtTviyjg66qRwoRPuCg1Yx2anTj287FoLC90S
 sSDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs6fsUWF38+H+3lzbc+/cOgC+wic1vU/X7whaa9weSiZSQH7vjY8Qrq06rz4N+q6ah6r/zOZuvpkuxMuaqK9XGH13p1jw=
X-Gm-Message-State: AOJu0YyIJd//IESF2zvm0QAVOY1IB1oBG8HTqURFTeLrWHZgs+4aIwV+
 j7axgBlvNBq5QnBnYNm/f2vqhXENgs2ZaIvzHx8QQUnZHXflsXzng4k/D8G84xk6bIgnxfjdj6P
 NrghvgmsvrpXE45RHf9+oYe6EbnZEMHF9hqaNguRJc6vkVaYbDc/P++FJAZH7
X-Received: by 2002:a5d:63c7:0:b0:346:b6c1:1374 with SMTP id
 c7-20020a5d63c7000000b00346b6c11374mr6392521wrw.65.1713174716885; 
 Mon, 15 Apr 2024 02:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKehQjN7oAnzi0gZhIo9egBW1eLn0xDMFG80/3ymmoYtKRf+t35Ys5B6YwKpFGn0AEetlO3Q==
X-Received: by 2002:a5d:63c7:0:b0:346:b6c1:1374 with SMTP id
 c7-20020a5d63c7000000b00346b6c11374mr6392511wrw.65.1713174716409; 
 Mon, 15 Apr 2024 02:51:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
 by smtp.gmail.com with ESMTPSA id
 a14-20020adffb8e000000b00347363b77dasm7366256wrr.33.2024.04.15.02.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 02:51:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 05:51:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, isaku.yamahata@intel.com,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is
 not disabled
Message-ID: <20240415054955-mutt-send-email-mst@kernel.org>
References: <20240403145953.3082491-1-xiaoyao.li@intel.com>
 <20240415094450.268675-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415094450.268675-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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

On Mon, Apr 15, 2024 at 11:44:50AM +0200, Paolo Bonzini wrote:
> Queued, thanks.
> 
> Paolo

I actually had it queued too - it's not 9.0 material though.
If you queue it don't forget to tweak the commit log manually.

-- 
MST


