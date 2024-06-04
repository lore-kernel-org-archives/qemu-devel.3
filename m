Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922F6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 20:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEadf-0006nH-GG; Tue, 04 Jun 2024 16:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEadd-0006mv-6v
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEada-00005Z-Pw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717532405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4tWmedTKEOSjNMnG1l2EwkkTdat3uEs+uQkbqZQYsA=;
 b=MQqHTklGtt+Ym4H4BqrvfsqPZ30N/5D9VKItOauEH5MTRwWOTl3VnE2uhdh/ATb9pjyIOT
 yXM2X8H9/QNYqofuYqZq+jTA+rVB5SsGbIGoH2h7PAGxiS1DES6K30nQZ6ef/tP7vHAmx7
 SNQmp38nsWrdPSuvinxFT0X49X4eWeI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-WEi1E2unNf2C9wyEfc9KvA-1; Tue, 04 Jun 2024 16:19:59 -0400
X-MC-Unique: WEi1E2unNf2C9wyEfc9KvA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5b970b125fcso1326729eaf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 13:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717532397; x=1718137197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4tWmedTKEOSjNMnG1l2EwkkTdat3uEs+uQkbqZQYsA=;
 b=dujSmAsmZ7Ajv2SQKDgXSRTkYnQ3OMUNFpTLB+pkvATQqQzv6YJvnrdCv8qqjYcyeL
 b1xlZ3KRMMkyBA7xKSFRJVSPG+JlLXNWR7B9Vpyin/Yv1WqORSYlC844IOKz0WtxyHJv
 nxYbepoDPfJhZTqD05rL6JppSzWdkoa1uljyxK2cXgb+cT73EsY6GSPRFReSOQNNmxdl
 mDUzKBm3Sl4RwqrZqDxRwTCjLTwNAyvCMFqwytg4F7QheEKoH9POLkUXcDmTSYoG8ddi
 8JiV39OEj5fqiPphLIQLrBLfNGvaeE1eIKJP1/RnZ3vQZ4IZvaVlrLXGkZ3ZY8kipRbI
 EnCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGs6zY4uvXlykS7wjYhoQTsf4y8B7O1S8fx4MXoyjY1HejWeLdl1XvH7typaCV6rEgrPknu27UePEXd/BoSHFtPymLLQE=
X-Gm-Message-State: AOJu0YyuYL2y3tLsRkulNLYMymKBozD8zDUvJGvc+rGvlqAhtfP8sJ2a
 HdDFkWTflVKVY249l877L2yNG9CH1JRLZpTVBINHiCxFjDinClmV9zCedkvUHwiqSgsWRc45Ezm
 +lqH2pIBOp35ieE4Y7xN7MxhPuLBhika1yZgGXF6NXI5LfsUUM+8U
X-Received: by 2002:a4a:2450:0:b0:5ba:6959:edf8 with SMTP id
 006d021491bc7-5ba7904cd39mr757105eaf.1.1717532396933; 
 Tue, 04 Jun 2024 13:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV9EGDpHxWl7dp8Hd84jUR8rbVVa0eFm/Juqea+CTVl4GDIcwhgwd+Jm/WoNIdsI/LwWzgrA==
X-Received: by 2002:a4a:2450:0:b0:5ba:6959:edf8 with SMTP id
 006d021491bc7-5ba7904cd39mr757075eaf.1.1717532396481; 
 Tue, 04 Jun 2024 13:19:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b406617sm42436716d6.95.2024.06.04.13.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 13:19:55 -0700 (PDT)
Date: Tue, 4 Jun 2024 16:19:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v7 1/7] docs/migration: add qpl compression feature
Message-ID: <Zl926XxG5ZrZ04tD@x1n>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
 <20240603154106.764378-2-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240603154106.764378-2-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 03, 2024 at 11:41:00PM +0800, Yuan Liu wrote:
> add Intel Query Processing Library (QPL) compression method
> introduction
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


