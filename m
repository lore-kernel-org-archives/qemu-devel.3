Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39775C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9iB0-0007xc-3f; Wed, 22 May 2024 05:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9iAx-0007vS-O1
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9iAw-0004Rt-AE
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716369741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LPG4WJRSwPLziE6YPjjy0vIx3b2KMNnVMzgOkFQ/CzE1TjaCg5jqadOTZlcInuQ2OseobK
 v1EEc1LETutI698yqr8GramgW5iPT5mHDXGa4KHT5mb+AqFzxXrYofXRlGOSIipvd2wkfn
 /Ew9AbB7dQuJy4t/Var7B/raggoZhGE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-IBjhvd4vMwOhVsSTzLSOfQ-1; Wed, 22 May 2024 05:22:19 -0400
X-MC-Unique: IBjhvd4vMwOhVsSTzLSOfQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59a17f35c8so54796366b.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 02:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716369738; x=1716974538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=n7PyLQ2jf82IS1oe7ZOBxL2H2SkU4XzvheuRe+iBmuJhI1ewQyKjr49U845i92tP0W
 mx/LEO4g7yUP6kwO/jsygUirrrOP8jGL6l94pGhn8f53sFAlFMwJhGUt5kKRrnBnZUXQ
 Kax3v16gp275P3KkdAQbKOZzh044yiQqoMVcUT7ZjmqRDltkPU+5+Ubq/vZihx4r4vAr
 z5xWqS18CF5XreFrDJdPBfhSyhH4GrOzLMcGPq/spCW7paprHBKXVr/N6gmfdPJysH88
 iDiqEAbPUEEzDjWPEdaLTjr6+KRfqKF3zQvvORuP2TQkgyYVt4owmgzdKOxeO9Hy9d70
 iF0g==
X-Gm-Message-State: AOJu0YyZdpn4DrONRPfQbk/hKepzWDzZw1QATl5zpKVLaraH4MPSMPgB
 SyOID17QHgJXOENuHE6sjFt3hpn2ab6/F25XHdu2+htrpDJIFLsFV3YVOBKWhtmqPjbmFai2skl
 oLSm6pQZoXY2UE+CeXvBWp2NM3IAvn4u/U1xDyP0WIoj0cGz0WG90+GaHnQpx
X-Received: by 2002:a17:907:770b:b0:a62:e9c:f621 with SMTP id
 a640c23a62f3a-a622816877emr92720866b.58.1716369738476; 
 Wed, 22 May 2024 02:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyBTpw5GjmhGBKuZs01IpeY3NvwT2UAw87p7A7oSsKnt65xAbsQRFyMINmdjWbeJQLIGtCFg==
X-Received: by 2002:a17:907:770b:b0:a62:e9c:f621 with SMTP id
 a640c23a62f3a-a622816877emr92719666b.58.1716369738137; 
 Wed, 22 May 2024 02:22:18 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a61a00e96c1sm394144866b.151.2024.05.22.02.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 02:22:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Cc: qemu-devel@nongnu.org, rkagan@amazon.de, pbonzini@redhat.com,
 mtosatti@redhat.com
Subject: Re: [PATCH] Hyperv: Correct kvm_hv_handle_exit return value
Date: Wed, 22 May 2024 11:22:14 +0200
Message-ID: <20240522092214.568895-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521200114.11588-1-dongsheng.x.zhang@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


