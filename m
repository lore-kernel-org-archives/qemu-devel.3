Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41A4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3jf-0008Ba-Pf; Tue, 12 Mar 2024 11:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk3jc-00087H-7G
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk3jR-0004hL-OM
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710256076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VSwMquyssNc/dtu8KuYox2g0/sEa37MilQSl6WjQaaE=;
 b=C8ldXol+9HLlfo+Xgyu58ikA7fRgRyd4BF4LqJt2B/vZhHBKair//CzNIgI/qjixjBecIW
 vaxrLQEjrlBylnCEAB1hPkdWTDqu59RgLzkaq+EY5rggluIog874or4B+o1+DGK7yhK2oY
 z/18onOFiNAnrTzaDFfEi3p63/IyHCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-0o7Q3QquNDmwmDB2mbtw8A-1; Tue, 12 Mar 2024 11:07:55 -0400
X-MC-Unique: 0o7Q3QquNDmwmDB2mbtw8A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e67c6b7bdso2911570f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256074; x=1710860874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSwMquyssNc/dtu8KuYox2g0/sEa37MilQSl6WjQaaE=;
 b=I/Uj5gN0oDvSEUAW8j/RR9EaV+pmQnL/leECdP6Cs1Z/3TKhGiN6MwRjs5BIE1oVlO
 lk+sfx7q8M8j2SWIsh0GpWQqfIi8MMyYRQjKOl4M7L0IR4SSCTFXH+Z2l2wfDbwazFjZ
 KQpsfi9dP+T8ybE60Qd27EB0pS3K5JfnuYnNAmCqEIgv4WRYQUiOiQK5D/jqkhmZ13Dj
 +nghuiPwsk1aNNFS1W9RH6+QAOtNzoU3IP1PutgQU8Q/Z3xBeLhabeeMVS1Bcn6iWElB
 qp47shrR30mLAUCcfV03mSPINAlU3S7SBSqjKZRh6PRWHlnagYXqOR/aTfoSq04M5ETj
 zTaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIhk+k8WNzjph+yKge4FW5yhNSm++GQyaReN0VxzkzmeVhFEfzS9dqsf+gy/nlCHTQ4DhcE8KZktxyImRdf7DQBlYTsnw=
X-Gm-Message-State: AOJu0Yyqia/mhNWCvf3bAT87nc2or39GIhXLesTzkp18A7hVD6Nn47kh
 GRfUJ3GHwXMWcmRQUGwaZZ12l6Cank8qGUrNmj5QIs1DjDPHyEoq0q7ZP4iEAi6WrkU/pHgheoR
 neA4C0Mka0DLqgdmqMSDdTskRcgrmu3UsjFVr+kvUeFXw3er45Vng
X-Received: by 2002:adf:db43:0:b0:33e:78d5:848e with SMTP id
 f3-20020adfdb43000000b0033e78d5848emr425058wrj.12.1710256073741; 
 Tue, 12 Mar 2024 08:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEks91UoQ4puPLkhVFZXKkqlnAMvLbANQjYD6j27/r56e9glh9huntPIWR7GxyA+axuLVKS9A==
X-Received: by 2002:adf:db43:0:b0:33e:78d5:848e with SMTP id
 f3-20020adfdb43000000b0033e78d5848emr425041wrj.12.1710256073285; 
 Tue, 12 Mar 2024 08:07:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a5d61cf000000b0033e2291fbc0sm9212229wrv.68.2024.03.12.08.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:07:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:07:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, joao.m.martins@oracle.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] vhost: dirty log should be per backend type
Message-ID: <20240312110704-mutt-send-email-mst@kernel.org>
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
 <2c8867fc-fce8-4964-b641-09f7903ff594@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8867fc-fce8-4964-b641-09f7903ff594@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Feb 14, 2024 at 10:42:29AM -0800, Si-Wei Liu wrote:
> Hi Michael,
> 
> I'm taking off for 2+ weeks, but please feel free to provide comment and
> feedback while I'm off. I'll be checking emails still, and am about to
> address any opens as soon as I am back.
> 
> Thanks,
> -Siwei

Eugenio sent some comments. I don't have more, just address these
please. Thanks!

-- 
MST


