Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CCCC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 16:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCiUR-0007z1-7d; Thu, 30 May 2024 12:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCiUP-0007yd-80
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCiUN-0001nw-Ng
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717085930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2W+up3g4kzy+w2uXa2MAy9sPqFlnLh7yCCQQDqIXsk=;
 b=OgOPVZbKjmvLz1Wbwcq2yQwHpRtUVm1JUWI/R6jipNvD3wAsre9BZGvsuA9Fow1z35HgZI
 DAKMSfUaorN1s7qljUSGRCzfb5yRlbHwuJZtdHK09tYztegyw2g5bqjqcfF6U8VPyScQu6
 4psUiJFjMSw1uAAHGAy68baQKtvhsjA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-OW-EkNRPM2K8p_KlXx2log-1; Thu, 30 May 2024 12:18:48 -0400
X-MC-Unique: OW-EkNRPM2K8p_KlXx2log-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5b96af36cfaso195854eaf.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 09:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717085928; x=1717690728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2W+up3g4kzy+w2uXa2MAy9sPqFlnLh7yCCQQDqIXsk=;
 b=TbYhpq4f+TBr/P/fXyU/DfywsbnkoL/We3gvQ7uxBhrNAc9qXYKGb0ztcnrHByiyR/
 l0o4niyKTl1oZUHTmZ04FDjpMvYPZ4qgcs0z61VZ+Pw4Wg2UInXeNDg6UBJ5q5hany9w
 rX/0zvGwBpusafGMi3O4GwQxuQrDvHzO4i9lCoCoEAo5iKN0y2vS7ex63PtFW75CF+Ik
 MI4u/IVk5xmj08+lPNk0S5O5OEnZlmVEGVC4PnGFoB9wdy6kPvp/wdKv4wBsP4DRjJdX
 FSJFn2vl244xjww9RjHXFm/+1bje8Ms26ja7xLwsziS5zTIEpiovmOdtXyFyclCCcOE0
 IA2w==
X-Gm-Message-State: AOJu0YwlIm1TR+IMb81TM1qrbBw3Vyufcquc0QT84b8gZs9KJRs9B3pf
 Tyncr7dXG/RwFcrmRJrUuAIY1S7Zhp1zbN251ZR/DiWjgBqBE7BQDYWh9uKl8vfxU+mJme3ZeYc
 KV3+HaPUkt6Qtve+xmAqirn1QLNnnt6/A87HI7XieohQyjMwN18Xm
X-Received: by 2002:a05:6820:280a:b0:5af:be60:ccdc with SMTP id
 006d021491bc7-5b9ebaf8071mr2748496eaf.0.1717085927804; 
 Thu, 30 May 2024 09:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeqObGgSYwGPYeilj7PDqTMpTLUVR7WRqUQxqWURmIz0UCdcVJ0BbsjCL78kI0refy1mFI/w==
X-Received: by 2002:a05:6820:280a:b0:5af:be60:ccdc with SMTP id
 006d021491bc7-5b9ebaf8071mr2748472eaf.0.1717085927195; 
 Thu, 30 May 2024 09:18:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fe8f897e2sm10827281cf.28.2024.05.30.09.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 09:18:46 -0700 (PDT)
Date: Thu, 30 May 2024 12:18:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 03/18] tests/qtest/migration: Add a precopy file test
 with fdset
Message-ID: <Zlim5PwNejMPemaa@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:33PM -0300, Fabiano Rosas wrote:
> Add a test for file migration using fdset. The passing of fds is more
> complex than using a file path. This is also the scenario where it's
> most important we ensure that the initial migration stream offset is
> respected because the fdset interface is the one used by the
> management layer when providing a non empty migration file.
> 
> Note that fd passing is not available on Windows, so anything that
> uses add-fd needs to exclude that platform.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


