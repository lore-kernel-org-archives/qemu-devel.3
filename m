Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA861C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKf4k-0003Av-FD; Fri, 21 Jun 2024 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKf4h-000392-Ch
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKf4g-0002pK-18
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718979428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCPQmMVDHlv0MwLO73R0s8C5bxK78KjjrxBOkf7Vb2g=;
 b=GNMU7mxLkbB66csr3dDpirNthxPkKmN/pSpZAgqdCu8HUvV9LpgB7A9YyysfFwtXEeafvx
 Mui04bXIEEh2LC1krD+wGxpN0KoLiKhCbmqrBThRqJXP0r1psDA+JKp+xMJJv16JiTgiQH
 BS9xDPb1bjgg7GIaueHUjw/g5IVsAIg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-WdbQRW5nPBipBqerhjqARw-1; Fri, 21 Jun 2024 10:17:02 -0400
X-MC-Unique: WdbQRW5nPBipBqerhjqARw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b0762cfd0bso3558056d6.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718979421; x=1719584221;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TCPQmMVDHlv0MwLO73R0s8C5bxK78KjjrxBOkf7Vb2g=;
 b=U4cbNFA62C4ejQUS7WovG3P1uGA+MJ4y3+jg1+lKGH+3jLkkGgXUbNMEWHq/NXlm+t
 3g0nK8Jy+uFL6p4G28X4JDcRMyhKZwzUZx9b2e8RQ1exz4QIlq3aTqAQ7J1PIKkaJcbH
 q+w5W72NwmkSv3GEc1OPyxxrsKoA6RGr1o86WHW+JEM3G+DpcQc/WJzfcb0D2cZ9dz2c
 MCt/WUVjVl4mb5mDjH397rsF5sibdwF9zdzp7mikEoVEsOIr3TUj6LV/Cu13OcJ1lZgi
 qU3/8U3wpwdBAUfa4brWVuq5iMopky6mnyZoxxBSaRkdphslpHs6r5LgT2M+jkrUqhRk
 0Ztw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvOYIKgexlg6cs+D+PS3KP6qqAKn35okUrALS7/fQEB4SltdvltFBJcbC7gixZUutf37dI0l8/ojT4vsmZbRNWWK2jAxs=
X-Gm-Message-State: AOJu0YxZiMXYVGJaCGRri9y25iCZGuavXyAiSSCFMXCdgSmAFNbqF2J6
 +7oC0G0uiQQDeYoBv2hPpW/sA+0urXKVMdYuUBy2yq9V9KP6Yilnxod5UMpukRRqTy+0lyfuY98
 45aBONy9Vyx4CYrAcGhxkZ83GW9n5lMRszysXJEd8RMDgUn/5dBGy
X-Received: by 2002:ad4:4b24:0:b0:6b5:6a3:7eb with SMTP id
 6a1803df08f44-6b506a30a0dmr78137416d6.5.1718979421516; 
 Fri, 21 Jun 2024 07:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoWt5kA7MVQvCnet1XSC+xkx40S/CORMJss4Ci7pPKxHzAgbK2ra2TFenkekVXuCLxHSJIyA==
X-Received: by 2002:ad4:4b24:0:b0:6b5:6a3:7eb with SMTP id
 6a1803df08f44-6b506a30a0dmr78137156d6.5.1718979421067; 
 Fri, 21 Jun 2024 07:17:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef5ca8fsm8937526d6.119.2024.06.21.07.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 07:17:00 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:16:58 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Remove unused VMSTATE_ARRAY_TEST() macro
Message-ID: <ZnWLWssCoDnALFKo@x1n>
References: <20240621070317.9670-1-philmd@linaro.org>
 <258a78c8-dad3-40ff-8ccb-c3d1c3822131@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <258a78c8-dad3-40ff-8ccb-c3d1c3822131@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Jun 21, 2024 at 08:13:35AM +0000, Zhijian Li (Fujitsu) via wrote:
> 
> 
> On 21/06/2024 15:03, Philippe Mathieu-Daudé wrote:
> > Last use of VMSTATE_ARRAY_TEST() was removed in commit 46baa9007f
> > ("migration/i386: Remove old non-softfloat 64bit FP support"), we
> > can safely get rid of it.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


