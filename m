Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B4C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 14:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSGH3-0002p3-GA; Thu, 19 Jun 2025 10:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uSGH1-0002on-BZ
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 10:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uSGGy-00037K-Ty
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 10:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750343386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jw4+AfBdpsqpQGJ0mcxwqiIcpsICB6zMjxgca9zqplM=;
 b=UTFMOwgVlc4vchNRUYwlLD4cQluVSoA+PEPTjPmJPI1gIi0KKYN4jcItRSQb20256Ga9Ol
 mIjkKmcEGnSfRqspLXO4ZmbNP0CLbk8GTLYv/kVK80znIJYkQMeDrL2JFfeuZM47xASsKZ
 JdZAFiecavnkcn09blJV7U4eRp2vVj0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-_4KEaXebOeeUj7AJpHfscA-1; Thu, 19 Jun 2025 10:29:45 -0400
X-MC-Unique: _4KEaXebOeeUj7AJpHfscA-1
X-Mimecast-MFC-AGG-ID: _4KEaXebOeeUj7AJpHfscA_1750343384
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a442d07c5fso18028381cf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 07:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750343384; x=1750948184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jw4+AfBdpsqpQGJ0mcxwqiIcpsICB6zMjxgca9zqplM=;
 b=mtavVaJpM15BE+a8339Ur2PEoUpPHwGoTbrQM0Sfpytsv+pzwraRtfP0oL2vtWSeDD
 qsvt/drR29Xsnyhlc4avhp7Hr4Rxge09wS3yDDH2Y3Xq5xSJP8Wq1xhjX8ylHD7T4lJR
 MS3hEyvpHgk0JKlIu0zilzFM6bIkaqEUNYWQSDQ//e9LfCg/9aWY47JujTDVtChiAc2F
 WGfl7qg3QipvQoV6l7KC8LwU8dwm4SHJYHS39C+A2O0akoqXXl2fljU3XDKo+F71fLAH
 GSW8PvNnXIC0kiIu8JCaA35Ko0EgTpU/4LvqR7VpKPNS25J/pqBPRZRSFEUr9r2orXXH
 oUrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEZsKINNMYgd/XC+GbxoI0cz9W4q8q02Eu8QNTMkDniGTn/R1WBFzZvUwg94be+n/nn6rDa3Kj7nZp@nongnu.org
X-Gm-Message-State: AOJu0Yzl6QCNRuulBtqmUkiVJ0wAQNFAD8K42HZbvkqASETC/L9pdUr2
 WT37WTw7uxsem54/eQ+4caAEyFXDlKZlxqvMJ0YXb3aHPsYq6Fd2mfIM8EsztOTikAK7kmtXcS3
 wKK93Ozqo3p+4MIYw6b8JBxnqEXMq5ymfqxVldmeKHbtiQNS3TfwNB/ej
X-Gm-Gg: ASbGncteGuZ8xG6YLlqRkVvSwonx6jnhhQe/JT8xQxzZ0jTxhKlJYqDG/nH+qkmekrL
 TqtdZtZnEnvoHMcU94dSeGYUExHcr1ZSvBBsnSPW40fPUxMQ4VYuTZffd/GYT7aQm35wfQVMFTX
 dpk8uAnooMTaVXFoV/ZYbP5jjEcomUz5cKV/EdVn2+uq5iO272pAldikb9vOIDuqI01u12+aPmd
 GbQvnA0PN7Ip18GkWBwGGfkJAfzVxBj4UTPWn3O8QsK5KZTbvO4qW/PEqBjOz2UMx9gzj+3+GKN
 I2hbgp5BbGFtTQ==
X-Received: by 2002:ac8:7548:0:b0:4a6:f774:dec5 with SMTP id
 d75a77b69052e-4a744b38ecdmr257416561cf.31.1750343384384; 
 Thu, 19 Jun 2025 07:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCo4NFNd2eVXjNyKWheRktH1dIovpHIBm3XaBDiAXDGMbj37MfoGzfHeFmCUjPQXbgIGALvw==
X-Received: by 2002:ac8:7548:0:b0:4a6:f774:dec5 with SMTP id
 d75a77b69052e-4a744b38ecdmr257416181cf.31.1750343383959; 
 Thu, 19 Jun 2025 07:29:43 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a3112b8sm82903861cf.31.2025.06.19.07.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:29:43 -0700 (PDT)
Date: Thu, 19 Jun 2025 10:29:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 3/5] memory: Unify the definiton of
 ReplayRamPopulate() and ReplayRamDiscard()
Message-ID: <aFQe1NcMSyCTiDoF@x1.local>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
 <20250612082747.51539-4-chenyi.qiang@intel.com>
 <0de41d54-31da-466c-a6bb-f45ff919ced5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0de41d54-31da-466c-a6bb-f45ff919ced5@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jun 19, 2025 at 11:06:46AM +0800, Chenyi Qiang wrote:
> To fix the build error with --enable-docs configuration, Add the below fixup

Thanks, this works for me.

Though I just noticed it has more than the doc issue.. please see:

https://gitlab.com/peterx/qemu/-/jobs/10403528070

So 6 failures (and you can ignore the rust warnings):

https://gitlab.com/peterx/qemu/-/pipelines/1878653850

WASM complains a bit more than others, but worth double check from your
side too.

Thanks,

-- 
Peter Xu


