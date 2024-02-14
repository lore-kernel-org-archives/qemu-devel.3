Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276DAC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHcI-00088M-W3; Wed, 14 Feb 2024 10:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHcF-00086g-Nm
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raHc1-0001IX-7t
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707926152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4MCvdBJA95aMmrClkQ/1mSx4rXDKtFq8xdTOOZiE7A=;
 b=a1Q+Ktu8g4pzhYFwWA0X0Rt2CUe9WRVBVdykJzvOibvFg8h1NKbqQywaoFymOKfAevZqMV
 OdwwA7bARvWeJpTeJCasjdANj5QG0cUBMftse+DytcUvSwPc5l345wTCao0MxMap9pCtDi
 kx8WQn+uBUMYQKu4A6lK8bTriajJPcQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-p49p44DlPvuPKY7Vwbkeng-1; Wed, 14 Feb 2024 10:55:50 -0500
X-MC-Unique: p49p44DlPvuPKY7Vwbkeng-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40fd2fe490bso4421505e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707926150; x=1708530950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4MCvdBJA95aMmrClkQ/1mSx4rXDKtFq8xdTOOZiE7A=;
 b=uGenAi/Pemb8nfWTl6j6FpJaxu3e/9+LMWjnYeLs5sq1b5rK4TbeuglNfXOErfpqmW
 oVkicIOEzbm3bpZqW1CeyDRe3O0qtRReDRE3O0t2fHQ8r8MbR7a9p1lhZi3oaoUXEMah
 GG4L8fJoG7jpmYjcxOi7d3FfgwXmLKv8xaU5rWO2KuRebrasrN/M37bPkii4V3lG8v3v
 bHXWpX+WlxP7YVPJNdIIbVftCAO1arn7A2vfAudAGzcGWj5LUzL5HtqYHyo7bT4wNjlJ
 LXa8U4vdoO5+wHO4S4jjUbbAYOZ/AQehxtnjqzeqoFGQyK2VoaMpjY19KY/hR+jxMR9k
 vCkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhrHLMPta5x7bODkuJo9V26kOXzlmYwUbyrQOAOyUlBhk5eoknb5x/tAAebuaPq0xWCda2RabJbKe14NOque1Oi1LJ5GI=
X-Gm-Message-State: AOJu0YwBez+mpSbc3oK41PhzeOV2PexMC16CYtUHKEJRvHU7xzKj9Ed2
 GZPcHJtrYaW2eglugQ/j3pJeUsUZnmz+SDZTGo9t37DrbXhYFKkbu5gy9GlMwC4DA8X+t98Digp
 n6ToCy1S4iZY4/4j8q3v8oQT63ghR/rRROCwhCsH0wJPkc946pvJJ
X-Received: by 2002:a05:600c:444b:b0:411:f6f7:6b1d with SMTP id
 v11-20020a05600c444b00b00411f6f76b1dmr1214675wmn.17.1707926149893; 
 Wed, 14 Feb 2024 07:55:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHelWmPF1M2uin3qf/7n0uMBuyuZwAgvXCYY7wpAtezKtMyFNXJUSePuuJP1vguUQvRszGCOA==
X-Received: by 2002:a05:600c:444b:b0:411:f6f7:6b1d with SMTP id
 v11-20020a05600c444b00b00411f6f76b1dmr1214660wmn.17.1707926149486; 
 Wed, 14 Feb 2024 07:55:49 -0800 (PST)
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 k19-20020a7bc413000000b00410d897765asm2274648wmi.17.2024.02.14.07.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 07:55:49 -0800 (PST)
Date: Wed, 14 Feb 2024 10:55:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
Message-ID: <20240214105534-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
 <bd6328d1-6568-4ac1-9be4-293bccc722e3@tls.msk.ru>
 <56e83476-f607-482e-a9f2-e473148de839@daynix.com>
 <0282c0e6-1e1b-4960-ad74-3e186062b4d7@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0282c0e6-1e1b-4960-ad74-3e186062b4d7@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 14, 2024 at 06:53:43PM +0300, Michael Tokarev wrote:
> Nope, I don't remember how to request a CVE ;)

https://www.qemu.org/contribute/security-process/


