Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8A8C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HXr-00014i-GO; Wed, 15 May 2024 12:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7HXp-000145-U7
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7HXo-00033j-3n
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715790713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKz9jTX0SjVIbKmKK2PGDRuQtBFnZep0+IXsw1Ugmh0=;
 b=Q9sbc7Og+FGuG1QAFoIw4t+TBAj45Y3rLjIksyb53BBpxVG3GH9T6EiE9JFwzOVjDTf2tF
 1tSBNXy5CIySOABouPr8sc15Pc8kzbOVtlv7XHA3AugxfPcx1fD11WXKlnD86iZhHL0SXV
 gXeZ8hH5D5PbtuIGkdGdgVZ9Oh71bfc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-JcU6LAPqPc2jg-EL8ItLDg-1; Wed, 15 May 2024 12:31:46 -0400
X-MC-Unique: JcU6LAPqPc2jg-EL8ItLDg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6f05561060aso51655b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715790705; x=1716395505;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tKz9jTX0SjVIbKmKK2PGDRuQtBFnZep0+IXsw1Ugmh0=;
 b=UETedvCAYPRbe/FhqExfF5R35rGbKV3YY9CvvKDlV0cGFlgUSnAeBhqSBO+oz09s5T
 QJCJ3tl0YFX+FWCAwbKelxuVMlO9j0MIbX5GZvKmXc+RXSb/SxYMKW5j9Ta2H6j3XTxV
 FXpmIhO7lMU3ReDAaO05tb7mf3MwN2naK7EeqZ+sX0u3zH2VForS1/niHqb2pEifJVHw
 SSiUqr+1p2HLPetF6FB206P4hqwNBLmUHK+pRpq/fPDz3tdTNbaI//EGfZ+r0pK5BCMK
 NNRyVX1HzUQ8hPrb/g9rqlXKfrMxQqv6cemcdt0Yc6q8h5lbeTLXzg3QPAQCWI5iOsb2
 Y5Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnNjmDsLYzGiqVnOkQys7QK9cCW2C9MHjlXt6qeok8CE0l54ScmCp3EL4yDMQ+NajzghpiFj48afl7F82U4hD/+eJ8zKI=
X-Gm-Message-State: AOJu0Ywoop9l8BBVe3UehrWSomsLbQ2mk3LfiHZLbN03xvY9NGSYD45X
 zMN/D+WoSFGegFXYE1XWs5jOJFv1lbbr/eWDaGUg9u0DyRwnUNLQrKD1tlEg/9zR4uvaAccIy2M
 VNBr56TxsOkioMQMWhK3XiAln6ZZmW/ItmzVD5UWadxe35h1Siwwa
X-Received: by 2002:a05:6a21:7896:b0:1ae:42c8:4f69 with SMTP id
 adf61e73a8af0-1afddf12a2cmr19760298637.0.1715790705341; 
 Wed, 15 May 2024 09:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpem665WIAOK1nlnF2FnlB+RV5Df0guTpPsAIBllq7YwEzxDXFmIN4xdU0dTy01pXa/p5qtw==
X-Received: by 2002:a05:6a21:7896:b0:1ae:42c8:4f69 with SMTP id
 adf61e73a8af0-1afddf12a2cmr19760255637.0.1715790704735; 
 Wed, 15 May 2024 09:31:44 -0700 (PDT)
Received: from x1n ([50.204.89.32]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f679902e57sm824350b3a.110.2024.05.15.09.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 09:31:44 -0700 (PDT)
Date: Wed, 15 May 2024 10:31:32 -0600
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 5/5] virtio-gpu: fix v2 migration
Message-ID: <ZkTjZCTwIbkZIVZd@x1n>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <20240515141557.1277999-6-marcandre.lureau@redhat.com>
 <20240515120104-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515120104-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Wed, May 15, 2024 at 12:02:49PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 15, 2024 at 06:15:56PM +0400, marcandre.lureau@redhat.com wrote:
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
> > forward/backward version migration. Versioning of nested VMSD structures
> > is not straightforward, as the wire format doesn't have nested
> > structures versions.
> > 
> > Use the previously introduced check_machine_version() function as a
> > field test to ensure proper saving/loading based on the machine version.
> > The VMSD.version is irrelevant now.
> > 
> > Fixes: dfcf74fa ("virtio-gpu: fix scanout migration post-load")
> > Suggested-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> I don't get it. Our standard way to do it is:
> - add a property (begin name with x- so we don't commit to an API)
> - set from compat machinery
> - test property value in VMSTATE macros
> 
> Big advantage is, it works well with any downstreams
> which pick any properties they like.
> Why is this not a good fit here?

I think it'll simplify upstream to avoid introducing one new field + one
new property for each of such protocol change, which fundamentally are the
same thing.  But it's indeed a good point that such helper can slightly
complicate the backport a bit.. I assume a global replacement of versions
over the helper will be needed after downstream settles on how to map
downstream MCs to upstream's.

Thanks,

-- 
Peter Xu


