Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FBACA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up118-00066x-1j; Thu, 21 Aug 2025 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1up110-0005rM-Eg
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1up10q-0002EF-Gm
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ea3px+MqrveLKF10x/fbITggG/2goZ+flPBmHqFp/q0=;
 b=GoQLv5jmVAZA4WJZF9z8Yug3T6W7GkCFfKUoVpf8gXsJz/8mboVf7kEn70wh985wgZdsqo
 H/xdkBtjf2xuxksws8ppB0ParQgxL9qGZhzDBb3250ObAF1qcZ0SjW3AV/DWZqG2HNUMTU
 uGAuiwGYt/jrVTuAVXW9zQivibmQexQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-82n9dfP9OxSs4s_lHuNmpg-1; Thu, 21 Aug 2025 04:51:08 -0400
X-MC-Unique: 82n9dfP9OxSs4s_lHuNmpg-1
X-Mimecast-MFC-AGG-ID: 82n9dfP9OxSs4s_lHuNmpg_1755766267
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59cso4744825e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766267; x=1756371067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ea3px+MqrveLKF10x/fbITggG/2goZ+flPBmHqFp/q0=;
 b=iW5eVq61a518hTK2Sf4pomupBt8w/iuBuZ/OWyZVcYPAOhAfQb1pOkfdCKpI1ANONp
 93bws4ObFDvvePrgof5xS1AervtyopGrmjERxsNhGhugntYpmMoix+TmRsD7CMunX9B/
 MfzOARRDI+CVTAlR74SAMpP793I4HTzRs2Mog3ZlVCV5H+SFcjhC50t8ILF1BZNljVkG
 EBE01ifxe6TCln4+VaECblIyDjxLfuhL/4OR9f1Tm9BczpDRrsoFIJGdUkg3ypUHBsAB
 QQYSIHwvr8YtjGpWjcbJ2lnU5B+kataBtmcqUcKQ4vuIcC/gJAhgN2yqQ1hSx5hQQ+a2
 174g==
X-Gm-Message-State: AOJu0YwDZmU4IqMBb7V288B5OtpPpyEYgVJCRapymmI4I2M9nylt3AQM
 prG30VD7jhXgxg+Ei2UnEs3fwCFVd4j8ttaw7lQPRbAuAfExIYAuNIwD0YDB9wP9sSgNprKi5Ai
 0XdZnuz7NHsWA+aQToF0MIlENEr8fDTHjsJqXuuvdsBHO+d4xvHkAQAKF
X-Gm-Gg: ASbGncvI5We3Uikz38snPa1WgxIWLDdYR9Rreba2+qg92b+0WlPcAHPuABXHjFfbSP1
 SqnjQ7c5a97E+7eOGqPy9CE+nqIjpoPKLAneNU/mCNhwoPKRh41y02+5BaZsZLuf4MTR4Llah8l
 5VEXbTfS92uuFo8OEo8oRw7bnmQJOEaFmGocCZuB+/HpBsjpwoRIuPJwHOsL/XNRP53dbmwh6w6
 WRhSKwzK2dfffkAYqu0iRaGlQLcDtOthYd3xukZthrBaFlZ46cWpJkrQw1+cpIZ2pEXox4yoZh+
 M2pwFY4tl3wcyEA/iX/uyFkJXkDx12+Q
X-Received: by 2002:a05:600c:3b8e:b0:459:d616:25e8 with SMTP id
 5b1f17b1804b1-45b4d7d0f91mr13192465e9.8.1755766266777; 
 Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUoI1CrORXVqdzgfxJPK0BUeGk8xX/zj/h8qMIuGGWf8WFnoJFCyGMQeLxl6feD1AQZxpmQ==
X-Received: by 2002:a05:600c:3b8e:b0:459:d616:25e8 with SMTP id
 5b1f17b1804b1-45b4d7d0f91mr13192215e9.8.1755766266355; 
 Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4db1b9aasm19825735e9.5.2025.08.21.01.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:51:05 -0700 (PDT)
Date: Thu, 21 Aug 2025 04:51:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Message-ID: <20250821045043-mutt-send-email-mst@kernel.org>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 21, 2025 at 07:19:43AM +0000, Duan, Zhenzhong wrote:
> Kindly ping, any more comments?
> 
> Thanks
> Zhenzhong

I think there's been enough comments to spin v5.

-- 
MST


