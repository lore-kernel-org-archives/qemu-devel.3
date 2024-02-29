Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF71C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 04:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXvl-0001dF-Dc; Wed, 28 Feb 2024 23:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXvk-0001d4-3m
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXvg-0000Ps-UA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709180516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abqMgpHG/K85C6oOdbKc1wCnJevh2gn57GRpG1LTvpw=;
 b=R/uugu7HKRt3akng0oViqbcp1MFThYYS0MfFRzYxVYADRptVPNkWjk2uOL+I8Ek+UX7qEO
 l3XZKdA7xjZtScyjtJmWC6z8pPpiM9aI5F12GNecLHAyDT3lxFZJZkOA4yXw09R4Hknx4N
 tktbkRC0eCPl9GJ3nnCXP1SXoELpFPg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-H4EMw8hGOwy9N3WcJXOw_Q-1; Wed, 28 Feb 2024 23:21:54 -0500
X-MC-Unique: H4EMw8hGOwy9N3WcJXOw_Q-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso157158a34.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709180513; x=1709785313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=abqMgpHG/K85C6oOdbKc1wCnJevh2gn57GRpG1LTvpw=;
 b=Tk9eZUR0lc28M0YbjUq26RSTwoE0WhZtjMOEKF4wA4vmL4z9xOeKCQMcsgVQp1aZbf
 PkklSZxRVGip8wHn5khgeAECNgCwBdQfjCQk8T3l0+a4q1UufCH6ye8N82uBu2xwCurc
 hYD/v++sAj2ypYtTG24c1x7NtfYAwTEEpPGV5rvV1veth7UAOtflGLYhn8gGKhyE72JF
 730/8sSanTIqA8FPwxTbAJpRPq5DIgIFRJ+7jQ7EQzeHQVPQ6T3YN7yJDX/DfDcam84Q
 kj0BkUgnQsuWrMKJKcj2g5Fhus7LnMptIyktZ0huJTqATQP15t/ejtuGEom1p6RpmC1I
 dY8A==
X-Gm-Message-State: AOJu0Ywrt0r3A9h8XxoivbVyFMpGYi819FfpG682PWRX+pfs5Afqxhdh
 XypRqvaiYdiRnBZoNK+Xf1Z4A1Ls7YpnoLAq5z0wFmro0ZHR1syaJNb9lhnpX3w7ctvRxmH39eB
 BwWuYJbr3DJojevBpjp5qnVGD9DSjvl4bzBCiVw7TNCIT1HvJWXTi
X-Received: by 2002:a4a:625e:0:b0:5a0:4d78:975d with SMTP id
 y30-20020a4a625e000000b005a04d78975dmr1076653oog.1.1709180513619; 
 Wed, 28 Feb 2024 20:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWpQgrCiRJ32/2vMwrq6zio3wlW+IfMYqTVBUyFZSBwptO4296Yz9VPJ+7ASzHu2uKKBbFXQ==
X-Received: by 2002:a4a:625e:0:b0:5a0:4d78:975d with SMTP id
 y30-20020a4a625e000000b005a04d78975dmr1076648oog.1.1709180513400; 
 Wed, 28 Feb 2024 20:21:53 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u30-20020a056a00099e00b006e48b04d8c0sm247433pfg.64.2024.02.28.20.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 20:21:53 -0800 (PST)
Date: Thu, 29 Feb 2024 12:21:44 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 07/21] migration: Add Error** argument to
 .load_setup() handler
Message-ID: <ZeAGWAW3JCzIw9s2@x1n>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-8-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227180345.548960-8-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Tue, Feb 27, 2024 at 07:03:31PM +0100, Cédric Le Goater wrote:
> This will be useful to report errors at a higher level, mostly in VFIO
> today.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


