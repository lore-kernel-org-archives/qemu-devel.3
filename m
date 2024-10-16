Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2E2D1AD5D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 13:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t14Xu-0005Pg-1s; Wed, 16 Oct 2024 09:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t14Xs-0005PK-D8
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:58:36 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t14Xq-0007YS-BI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:58:36 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-50c9f4efd09so1920827e0c.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729087113; x=1729691913; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j47TvtHb61X7alWntQmLYbp6A+uTBHYw7hPs9TqivvI=;
 b=We2WjTx4zixlFHgMz+icRC7UdFXgALKpjUqxSZY5SyaQH7IoCza+OSrQHr+cEQa/kE
 VGPtcquKyCvLoco8WO2D2oAwaFxA+Q5FREH0l/a1dmtSTYhe5XBheWzg2tL3dIfUFWs/
 /kZ7qGbQ4Ex4RN13vO9BtZA8yLYvMJxMRxCcXaLw5p/oBR8IFwiZEkC1gNKygSKDRCBJ
 JGmiYyjee8ClLPzvWj4HRdzLYkpD6qGjeWq8zKSwF/3IkF50PFl75boENlWIdo+0NWO4
 W/DLiwoHNzzPznZPXph2f216ct7efRtlWSQ5JEAK97QHVXOzcQS/Ej3DHvRbCbgrojWv
 7sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729087113; x=1729691913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j47TvtHb61X7alWntQmLYbp6A+uTBHYw7hPs9TqivvI=;
 b=OCtI03Aru0ma8ZWt4fG70EzytcpTfKEXSXFpLH2AGZ/OqSpCMV4jNfaE5gh3aMvInc
 deJLIw6PhMV+Zyma8BAeD0NmSGPKJ16U7/7iIlmGvr4nhtbpPC7ouiyMuVz5K7AK93AY
 zat/DsIpyuxapc3UNm2kG/94B1dbidzd42k2azJbueCj1pJaXGQxNno6h2RA+MQRd31S
 1jQwxVLcHI2vOcBLZ+GuXyDXNdhHFVO+qtj8XX51tVsmqSxaXkRS/rnpT54VWgcapQsw
 cYImiFB8yUDoQR0pyy60jBtZ8xJGX39u63H/nuGkoZ+rLGCwuDkzEjKxB3BwH/OF4U6H
 sQyA==
X-Gm-Message-State: AOJu0YxQtNUYxD1oJ30BwwjiYoENsDhFG9IMjsOcCZ6Sau/pQgIncPMm
 5N2YVhpTdtjPfo5ZWhsXiQP6mGzEdG5GhBvOqj98mKueVrQ+SfoO56I8U5mIoJUTxUxmY8y2jlo
 X6ZOzA1hf4MXn6Eql4SO9kZ2YeDemjA==
X-Google-Smtp-Source: AGHT+IFSLtbAIykmyEQQBx5G8SdpDOCEPeK7MiXjPnQS82f6/qUU3Z8htKNOEMvQh4A0SvmwAGRrZwT1tJHpLTyrVUU=
X-Received: by 2002:a05:6122:3c51:b0:50d:2df1:4c46 with SMTP id
 71dfb90a1353d-50d37763861mr9107116e0c.13.1729087112862; Wed, 16 Oct 2024
 06:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
In-Reply-To: <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 16 Oct 2024 19:58:32 +0600
Message-ID: <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, Alexander Graf <graf@amazon.com>, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping

This patch series has been reviewed by Alex. I am not sure if it needs
more review. If not, maybe this can be picked up for merging. Thanks!

Regards,
Dorjoy

