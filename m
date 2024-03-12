Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB38C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Cd-00050R-15; Tue, 12 Mar 2024 08:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk1Cb-000502-Qo
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk1CZ-00052L-OX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710246350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMzmP+7C1XRfwwc2TBZzTnqSVn0u4XzfmIRf+MKiYeo=;
 b=Y0xRwCMIYuGOH6FlCFA6h2bsRuLwnZMDoSBL0KdgE+w474+GiiKIZ6magFTWVaL/SzWJOf
 guUVPtiUNHrYzcItnRUsP24iQwyGLhn1F61KlRqPdrcOrGOMNBXvpUTuwVRN3HCzSZDfKb
 7EkzK/7mGmdZv57U9/gYBwqXKyq4GGo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-G5CVVXvRONyBvgiV2YiqSg-1; Tue, 12 Mar 2024 08:25:48 -0400
X-MC-Unique: G5CVVXvRONyBvgiV2YiqSg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso1312826a34.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246348; x=1710851148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nMzmP+7C1XRfwwc2TBZzTnqSVn0u4XzfmIRf+MKiYeo=;
 b=ODBpXdGgSBgcVyB9olQW5n3/MzXArox6ARTuv9Ymzk54y7frzBr4jOm1SS5D5HgnzO
 +oCE8TZFbra8my4KLMuSWenRe6xidZTjUpUEIm/YXFYpauMEOgHOihXibsdl4tWX1MqJ
 zZQ/3fpIwMxTw6q7ghbsytrQ3k5Ympu0e1jjhz81MMTzfm4omdCsvbH6LQmhFwmD0xMT
 95Ru6UzdxWu6RsoiWmJJuvEqkWz2iGczjeW7jt3y4HvttdjhusNvEBbsOIWvCaQu0LiD
 50E5fYeRJuPLWFhp/tFJfV9vCTiY7xTraK6KMlzMSVHPDcWbqPQyMQTZyzQCExnBGwsw
 ZAdw==
X-Gm-Message-State: AOJu0YzC0tye/kmMWZ0TpJLCjJHVzaO2zJHzm/9CwrA/HYSsU+6CD6XL
 x9cx9q4EXSkgCmz3tssfZG+P1D4gmECrvgXCB6vrduY/6yxk6E/WOUZr3uZVb5AZ/vTLeO2Akd0
 OkQtFGk7I80DDSQAcM9GiYG42clcr3wou1611NAc08ZLRXWhYmucx
X-Received: by 2002:a05:6808:30a5:b0:3c1:dc86:8277 with SMTP id
 bl37-20020a05680830a500b003c1dc868277mr10437038oib.5.1710246347687; 
 Tue, 12 Mar 2024 05:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7HeP9dXt/mOpRDkNcVQ+uDFfP/oHKkgbSB8K5ZJHTw1o4Qz3PKGVFeH6SOxFCP7I95Lpp4g==
X-Received: by 2002:a05:6808:30a5:b0:3c1:dc86:8277 with SMTP id
 bl37-20020a05680830a500b003c1dc868277mr10437024oib.5.1710246347369; 
 Tue, 12 Mar 2024 05:25:47 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 v18-20020a05620a091200b0078812f8a042sm3645002qkv.90.2024.03.12.05.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:25:46 -0700 (PDT)
Date: Tue, 12 Mar 2024 08:25:45 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Message-ID: <ZfBJycn9pt43rS1Y@x1n>
References: <20240306133441.2351700-1-clg@redhat.com> <ZerJDAdaakTCtECF@x1n>
 <Ze9ogyFZT73gB-La@x1n>
 <0a1c329e-e6ab-4329-815d-e6be3e64c2ae@redhat.com>
 <5ca62745-deae-41b5-a9ef-2269a7220830@redhat.com>
 <ZfBBnWcBTFqlH2wf@x1n>
 <5f727597-3a2c-45c4-aab1-f4ee4cedfb20@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f727597-3a2c-45c4-aab1-f4ee4cedfb20@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Tue, Mar 12, 2024 at 01:09:42PM +0100, Cédric Le Goater wrote:
> I was hoping to fix the test case instead. I can try to improve the hack
> I sent this afternoon.

Thanks, please go whatever way you think is the right approach.

-- 
Peter Xu


