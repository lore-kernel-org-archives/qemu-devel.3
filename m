Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E48C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMBO-0000CW-T5; Mon, 15 Jul 2024 09:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMBK-0008Jl-PH
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMBH-0003j7-6U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721051754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEOd4CDp/jbPiha9NPOwXg++RHvWlGdyA56E36AJ3zk=;
 b=fgrpUqcBhGMQkIzpkl9ZjeH231PcVGJR+eO7ujQRltuBvvOPhHDiLRVlSw2xoZdkYScwY8
 vjSPoeTognZEXuQbQPFalR7s10EN29MZmqNioC3sEuvFbSKy5mQv1BBe3CB8v3UoCuObrC
 lznkal3fkcsCref5kmxFGHHLiIynl/s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-9oqqg48TPqmWL5yRnHUx3A-1; Mon, 15 Jul 2024 09:55:53 -0400
X-MC-Unique: 9oqqg48TPqmWL5yRnHUx3A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4279b07cd45so29413955e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721051752; x=1721656552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEOd4CDp/jbPiha9NPOwXg++RHvWlGdyA56E36AJ3zk=;
 b=UPbIeZ++NFcxgfMOXTg5YUgiddAwnp2d0W4SXno+YBzuQeNX5meKLljG+gfZxX2wkJ
 gpIlhI3jeCKreuUr9SzXFuOMgb46+lPI+XRV0zcRPSPIviXj77iVLI33KHTjgMnNrcuE
 Py3uCe4WWp6Ol2mrtT5PU4d2MLMig/eKtuSuZPssumIsteISTbqM/6w5zsB/Q7u5C8fj
 X6RfUBHk+SG8in/LQeqaNNttY2rslSEhal2FtzsNqMLVvHX9l3GCSGYGEbBSdcI9HROG
 MZhoSDuyWEGKo1ehfKkb7cfj6noZ8R6v+TtC6cnDINRkDEoXTKkT25IAVC5nawd5hxAW
 T7+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhrImA1By1y9Cqi1e+iWMpQ7CDlLSE0TEydj5zZ+ijWLIhr0ewCpXomE30GsqnvHCz/c4O3No511+/vKVPBy3EUCZwyg=
X-Gm-Message-State: AOJu0YxGZQQvoRbC3p+D+UnDdT8NGxcheEVwvSqehurC8+o+lYEBqiwT
 2oJi64EPSjGg4Di33ld/LSWmjoBLfdQChY81QYE/s9eYRsDNXTugMk08XL7syeDOXWSMwNIrJvW
 K64ZkwJ16c2+Y6/HBuE9tCjt9PlOClRjOGfuV2le79+LFmPqNlRRH
X-Received: by 2002:adf:9b93:0:b0:367:89d3:5d4f with SMTP id
 ffacd0b85a97d-367cea45c84mr11564690f8f.12.1721051751718; 
 Mon, 15 Jul 2024 06:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbhO9FMNEfJO1zstAaPcvs5SOpVZutajwCYQYNAI32uTue7xDtxscR5hR9bIFzC0hkfMVxoA==
X-Received: by 2002:adf:9b93:0:b0:367:89d3:5d4f with SMTP id
 ffacd0b85a97d-367cea45c84mr11564642f8f.12.1721051751302; 
 Mon, 15 Jul 2024 06:55:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3c38sm6520140f8f.8.2024.07.15.06.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:55:50 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:55:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240715155549.5302e90c@imammedo.users.ipa.redhat.com>
In-Reply-To: <a43a5a1636c84896be5930570c538031@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715071232-mutt-send-email-mst@kernel.org>
 <a43a5a1636c84896be5930570c538031@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 15 Jul 2024 11:27:57 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Michael,
> 
> >  From: Michael S. Tsirkin <mst@redhat.com>
> >  Sent: Monday, July 15, 2024 12:13 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  On Sat, Jul 13, 2024 at 07:25:09PM +0100, Salil Mehta wrote:  
> >  > [Note: References are present at the last after the revision history]  
> >  
> >  Igor any comments before I merge this?  
> 
> Hi Michael,
> 
> Assuming there are no last-minute surprises and If you decide to merge this
> series, could I kindly request that you collect all the Tags (XXX-Bys) including
> the Igor's pending Reviewed/Acked-By Tag for the entire series, so that I won't
> have to churn out another version (V16)?

v16 might be necessary, see cover letter.

> 
> Many thanks!
> 
> Best regards
> Salil
> 
> 
> >  
> >  --
> >  MST
> >    
> 


