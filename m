Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22BDC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpvf-0006j7-NK; Tue, 13 Feb 2024 05:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpve-0006ir-Ht
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpvc-0007X4-EQ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707819735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=chegCdaO3QZ/ZEPRcCFnAXNPywWD3dAHVnjtE5QsBZM=;
 b=LovlvRrx4Bg6gX1/2pJdSkpYILvIT1yqqxN4MNCjCxkE0dropF1Pg1r2Gn/zO32gXYdRAb
 vNj576GkMGI9udmLoCAIhtNWxvR1YHN87wwjRUTHj75lgOjy3lM45Ym55PBSkt/YzSlfEV
 gblIRzcdy94CN7BiGcrDkilifKTKiF4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-vCUyyXWXOb-F0BW3nvTWvA-1; Tue, 13 Feb 2024 05:22:13 -0500
X-MC-Unique: vCUyyXWXOb-F0BW3nvTWvA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50ec9529001so4110643e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707819732; x=1708424532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chegCdaO3QZ/ZEPRcCFnAXNPywWD3dAHVnjtE5QsBZM=;
 b=mBso12Dz5SfL2cscPmFbKPJHRc7gDojTeUcWuOnbvGC6KtfmQrkRIk7gxw5b+5DajD
 CEbpjzbGwLtGoBL8pAZpXowsQRWDvlelkW8aUi5S3irZ2alnszWKOpFSOF3mPHyfhX0C
 lriqYSknaqIAWzeVSHlpO3SBCXW8UkOdiW47bQEi7V2+6wOmwt95Ec+AZUdVEMLulH4E
 Zc+r8ZJk/x1ZOo217AiK+eYHlxRiGEcpPxkPosxtqXQn3HmhTo1+dLwoBxBVoFQIc4ZT
 Ik1+vifFuKKcrxMsPx6kvcjsiEE1+CIhSete6Q8PtmK0VyyBv3P2XrzyL5VrtEZVJbmW
 Laww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSAjp9VdQAT1mm+wb9Ir8uWXV/KZQR3hqp8UMU+opAXbNGS9bu+S+0ijsUdZcq/rJ9LsJclKooexw4+KXBDtUNwIJYAoA=
X-Gm-Message-State: AOJu0YyX+Lv/XrMibLrLlAc59QamUQHt6gIp7B8Zq4p2/r64mVbAl8V+
 gyk+wYZx/nPZOdG8m+XPq/KKUysN4emyjOKNId0rYdH2tfDZWnMtL3ME0BxcTI+HCsa9IEbRbXV
 6u4sTOoDvW8EF6zXIrb1ve+oauPJ7EI6tuySpOjgdqPv8vTmPYolY
X-Received: by 2002:ac2:5616:0:b0:511:882c:7c8c with SMTP id
 v22-20020ac25616000000b00511882c7c8cmr3998960lfd.32.1707819731900; 
 Tue, 13 Feb 2024 02:22:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM7iyv4fG3XUqvu6i2w7rO06i2qXuUDpOP7w/DATPavn+9pBOJd4v6xIs4UyTlZzwctFTECQ==
X-Received: by 2002:ac2:5616:0:b0:511:882c:7c8c with SMTP id
 v22-20020ac25616000000b00511882c7c8cmr3998944lfd.32.1707819731567; 
 Tue, 13 Feb 2024 02:22:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWhTnVrEtZTMuk5h7Yh1d6+4wsVyyLvh53cKNwvtZonmNxOD0jJDWm87chkgRo9yPm7Fa5FxCUrFNTDezh5cg58qCDU46Vy1VetbmpipWof/3b0JeSIFJkZhyo9XuLVL9u0/T3RZv7dLDOZsmuMQl+Rv1Xd8V021OnpKGXP47Qxo0rtFhXzlu2efAqUm21rpXY0yoeQeaEDaWjbYaRvhkd33nZ4Xbl1HRUSgal+ICpzp3cIQloJiueULP5nNCbsh/58PWjPkw4Iw/rGzn2MCXR9ouoyxbiVigQ4YEzVojDqg/rgkPL6WMtsPNJu
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 g22-20020a056402091600b00561623dff71sm3589043edz.59.2024.02.13.02.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:22:10 -0800 (PST)
Date: Tue, 13 Feb 2024 05:22:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
Message-ID: <20240213052102-mutt-send-email-mst@kernel.org>
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
> Hi Eugenio,
> 
> I thought this new code looks good to me and the original issue I saw with
> x-svq=on should be gone. However, after rebase my tree on top of this,
> there's a new failure I found around setting up guest mappings at early
> boot, please see attached the specific QEMU config and corresponding event
> traces. Haven't checked into the detail yet, thinking you would need to be
> aware of ahead.
> 
> Regards,
> -Siwei

Eugenio were you able to reproduce? Siwei did you have time to
look into this? Can't merge patches which are known to break things ...


