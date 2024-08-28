Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE99C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjL7j-0002xP-G0; Wed, 28 Aug 2024 12:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL7f-0002Ze-4E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL7b-0001Jf-Ab
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724860924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrS2eYGsJHi83cIZXHSxT9rvH8eagcYSz+3Ique12l8=;
 b=CUGkacUlqxmfRZM4STWfoGuZ7g8/IqaQuP1PDj6fu0neUN5iI+lMyIjKI30E03kyF647vO
 BTeQHtNKJ4SUTO2hXk5GvFgc/jHGLbHgKKt85DRE8lSlgX8diYVFOOx7Xt1Vb2iEAuGKgi
 LUjslQI1NLF74eYD2vXdPcvtmU8cphY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-esCDp-4qPRe8gEoCA2gX-Q-1; Wed, 28 Aug 2024 12:02:02 -0400
X-MC-Unique: esCDp-4qPRe8gEoCA2gX-Q-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5de876048c8so5855406eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860921; x=1725465721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrS2eYGsJHi83cIZXHSxT9rvH8eagcYSz+3Ique12l8=;
 b=l4n3+7TJsBlzSq3OcO8Tz43wBp9Xx4Gl2XfwAXGls29vbsvcQvJjmsDnnaDiC/RsGj
 Guf9jxtMIldMhmVonQMTq6Cw93MCo3mAhwSgnT/Y+JSu5LBzRNCu94tVNsRPPDP23uSi
 O2hz/sL08b8LYw8FPFGIK02XVZNw1zxXPmX9U5xTNzApstKqSgPB/ZsfsH/O1ZYixyxv
 gGfhn3Sq//czKLKM92BEPdBmC2uQgcRiwArnteqF8hKU4RqZh2LEMbECQQtBtnSvWM2z
 ct8BKAec7YiJN1yb3AtPjnJ8FBbbQ7eknJAIK+9jp1gJuT96v5ayHye9S8zh8+UNIats
 ryjw==
X-Gm-Message-State: AOJu0YxCcnyK3kAmpeLjdgEO675yD/n3KmLUOR50rQwIFWhoGis74Ljm
 bz0Q56TyV4x2U70nbFYEGvjYaAbC2ELsmqLblTXTp4n3GJR2ENOphogfBSjuGG5el2bPtp4e1C5
 I3EoLKrCrlzU9DJHwaIyyGLn1hwKM2XByAVVt1QISanQeeG7ZJ4fG
X-Received: by 2002:a05:6871:3142:b0:270:187e:f481 with SMTP id
 586e51a60fabf-2779013e0e4mr17320fac.26.1724860921351; 
 Wed, 28 Aug 2024 09:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiiU1p9A0D7e6p+r1HX83E4TcHTsFSMlgIpH0IuSBDwjaulUYxAxDO+r5Dc7Ch52RJjZmwIg==
X-Received: by 2002:a05:6871:3142:b0:270:187e:f481 with SMTP id
 586e51a60fabf-2779013e0e4mr17276fac.26.1724860920881; 
 Wed, 28 Aug 2024 09:02:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-273ce9e0947sm3820598fac.14.2024.08.28.09.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:02:00 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:01:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 4/4] migration/multifd: Add documentation for multifd
 methods
Message-ID: <Zs9J9VyI1WfIjAag@x1n>
References: <20240828145650.15879-1-farosas@suse.de>
 <20240828145650.15879-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828145650.15879-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Aug 28, 2024 at 11:56:50AM -0300, Fabiano Rosas wrote:
> Add documentation clarifying the usage of the multifd methods. The
> general idea is that the client code calls into multifd to trigger
> send/recv of data and multifd then calls these hooks back from the
> worker threads at opportune moments so the client can process a
> portion of the data.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


