Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25426D29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYsQ-0006w0-Cm; Tue, 13 Jan 2026 02:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vfYs6-0006lP-B0
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vfYs5-0006wC-5A
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyGWbBoQl/YBMDZt9YIamxxnb0XIV5twswla+YDG86Q=;
 b=P9xdwDDLNKkK3okNKOCUOAudIo3Oq6cUcvlPJPNthB/2quuUzr4fKfvgHV1cSAsG5l+kL+
 2OIwW28okbyhuKIxtmLGW+aJ8XbbMXniWnYRaDit+Q19eEX+22M//w9fVDogreODkyKPKt
 pZ/LT/YQ8p7rcDy7uPB+z+cV+5mTtgc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-_o0PbCURMCm13A8ChoPx8A-1; Tue, 13 Jan 2026 02:31:18 -0500
X-MC-Unique: _o0PbCURMCm13A8ChoPx8A-1
X-Mimecast-MFC-AGG-ID: _o0PbCURMCm13A8ChoPx8A_1768289477
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so3770153f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289477; x=1768894277; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JyGWbBoQl/YBMDZt9YIamxxnb0XIV5twswla+YDG86Q=;
 b=am0yM90DTv669klsw5BGTY/lki4m2KmEOgAuyWHzH7TJYRyPBPCwr9uwckT/YS5fW9
 nudWK8B0zbX1iqtKZ5dBPinTrWk4XT9PyBKX4V7GLBzb0P5LDlO5dAlOOiG0JKakyVOm
 7mWXanFQv8tbF7TolQzNufXtmADIAXurCaENFiJcBlvthsxxlZrlUinaC1mzCYe4thv/
 NBlZ0OFDNOsF0jvXAxth43NdC0klasLzlUtgOHxlOaGd1cdYbso4hAFKNuQlpGiXS+HI
 UOi40if1WOpQiy+80mFgTnMqkJaUWKrvA5Kg5FWqjzFJKaiYTMa0Ckvf1rkkiEnDoO7E
 CYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289477; x=1768894277;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JyGWbBoQl/YBMDZt9YIamxxnb0XIV5twswla+YDG86Q=;
 b=bECa5EEorj5+/bwp9XavFpSjYRRUk0PBuY8YnEitviFB4+T611T6uxzvnMridhgMMs
 u5f4AA2fOkwFuNzDX5iSyzVMdX/s2BQkVY34uTBTyOH+beg7cVs6bP6cadl8JONGkmef
 jz0nVsgXKz+JYXfN2IsPgtVALrDA4FjFoqxTFcZNnXG7UBhoLIIBSN7FTSbyx7iR0ooP
 hWRJpSlyoAiN+xpmEegmml0a/jDTU5FnhABjGrg+oh+GTaQkyvRaVGNwpbAZPGusb+c0
 w/4WUTCyqHDiR91w/pFozL0P1cTpheR4gpJi5DdDOQxBBAgswrjb+L8w5hQfpe5ccHQ+
 x9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnbY/5m22XK63H7AW8ji9hTEP1u4XToFDvFp4O+dL+ec2TcymSQHeFNRHKWZKLKh54Ql0YNp1mq+ii@nongnu.org
X-Gm-Message-State: AOJu0Yw7exLaL1tSzeGyHUMB5QRplny7aPtgTfpZxCmABTI6GcMFyN11
 YCwIgpwhkgGsbBoeAHJ1rWj8OrySesvLYONRYlEHlIk9i+73RWxBkxnuim2dePnbPkP422EvZoB
 o9/yYsXix9vmNvPeuNuMX7cK2D0plMw6PbN+NEksBP2hPr7gD6NjBVcQT
X-Gm-Gg: AY/fxX61YmIHVWZW376ixs3hRyyQkC8cvnNkz4+cfRFO9w+DdZUM0SK7yPMBbhGWojb
 js3l7/HPDdWNyT0ilEHWETnT2I4nmxNdueMFVixMzHVWE7CFkSqo/LgSFE1+/e4QR0dh/g/3aXE
 G7NyKDte7i26zo3j0Qb2t2jZFEMgtdOpvGYW5yGoUEBg0GrUJquWcJAb5FouzqUOlCjmJoF7tvc
 +KheTg4Z85dA4K9LYsGrtHWgXrLbW6NvRJZlvxNg+rVFZHrw7bwxls5HEZ3pFC/jTnJsCMfO7j5
 nIi20vf05tkB2PsEDcDFEGxWzNa3OzYedYquqXaGLdNgMkngNGw9Rv1f3p70+C6vwRniywKAs5t
 G7xj0sQsH+twaBGV7/KqHia4IqL4Pxew=
X-Received: by 2002:a05:600c:1e24:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d84b32efemr220976245e9.19.1768289477343; 
 Mon, 12 Jan 2026 23:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM/Y2Ef0VRwmEJt6I1+OgxJe1HI6w9h8SCdLM4+cY1wTwMAOuFiTGElz7nx4WoEHnYaMeVvw==
X-Received: by 2002:a05:600c:1e24:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d84b32efemr220975765e9.19.1768289476561; 
 Mon, 12 Jan 2026 23:31:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f661a03sm407695815e9.13.2026.01.12.23.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 23:31:15 -0800 (PST)
Date: Tue, 13 Jan 2026 02:31:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: manos.pitsidianakis@linaro.org, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, quic_tsoni@quicinc.com,
 qemu-devel@nongnu.org, zhiqiang.tu@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-spi: Sync Linux headers and add
 vhost-user-spi device support
Message-ID: <20260113023043-mutt-send-email-mst@kernel.org>
References: <20251216032122.1316684-1-quic_haixcui@quicinc.com>
 <4388d9ee-cdc6-4c65-8afe-938f62c431b6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4388d9ee-cdc6-4c65-8afe-938f62c431b6@quicinc.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 13, 2026 at 03:20:57PM +0800, Haixu Cui wrote:
> Hi QEMU developers,
> 
> I’m following up on my patch posted on 12/16/2025, and haven’t received any
> review yet.
> 
> Could you please take a look when you get a chance? I’m happy to update it
> based on feedback.
> 
> Thanks,
> Haixu

I already tagged this, will follow up shortly.


