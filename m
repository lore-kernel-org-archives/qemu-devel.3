Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A934C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVD6-0003E5-1n; Fri, 08 Mar 2024 03:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVCy-0003CB-Q1
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVCw-000454-TY
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG6Wbo7wdC6Crve+i9EUGvTqdlHW7G6tvbI/T2P2+ro=;
 b=KFePxKyYEysWX1X7XGxTl6zahP0HIaIAbBXiyXGLrvmvr1H1u2PASxsE+4Afh8fKF5vwN7
 Q6/3WEPdGsFqLSGeM99QyXwV8EJmbQ6+rGhZp9Zi0qn/GOnIw3y1i8NwVmms9Msi/5yBUG
 KGTyKS7zsd1qhHhC43j9Tp5Nm7bQ9Zg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-WWMyBcjSNGitwHPwaTGipA-1; Fri, 08 Mar 2024 03:03:55 -0500
X-MC-Unique: WWMyBcjSNGitwHPwaTGipA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so457786a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885034; x=1710489834;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gG6Wbo7wdC6Crve+i9EUGvTqdlHW7G6tvbI/T2P2+ro=;
 b=jSkJEoMXz+tL7p6owOgT1TFRB7MBr7jSen7PBUmXAeyoxeP0BnXkHUFfXXjhOFfI4e
 S+sVq7kDosbBqmjkb7kgK4fSQHIXhGpKDY1lLfIv1OOOk9Azsg4nOY2uDxUTjdonn8xv
 TfaJD7zFN/ZbjHE4ZqxRPEpx76p9EX2ym+8XlTKEq9jCP30t6NNrzteclP22c5Ez5jUS
 GmQQjnox/ibMDTcbDOV5GjKAKgfTYmhjVViP5o4ZA0b+1p/bithikE4EDawR/u8ILk5K
 Ycy6EoqkQZqTsjwIQCfVeEvMO9gyijuEQ32FQw0UibBGW/VDQRHw6jl5hCq3OhdHFn69
 2b4A==
X-Gm-Message-State: AOJu0Yy61KKbQ85ozyDPJVdTi530+EWVAcJKMDRa+7P5/XeLJ3Es5DKd
 hR52tEhbmX6gdVbHKJ0eCaYSn5FG22UeKSr1w+Q/drmmmXXiaOY8KLItuVaXZuqkMjixwJupUgy
 6TPangVBcq70z3yk7dEYqL4zg45apZWm+GWJZtDhobmehiaQjAA0+
X-Received: by 2002:a05:6a20:9188:b0:1a1:4766:5b1a with SMTP id
 v8-20020a056a20918800b001a147665b1amr1784834pzd.1.1709885033908; 
 Fri, 08 Mar 2024 00:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2c00WA4bz3TW15lSCDeAEmbqdG8Iq0UqxBwmapJ8bmhqerdVa91AEjrHofUWXkW3gQcqnrQ==
X-Received: by 2002:a05:6a20:9188:b0:1a1:4766:5b1a with SMTP id
 v8-20020a056a20918800b001a147665b1amr1784811pzd.1.1709885033585; 
 Fri, 08 Mar 2024 00:03:53 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fa18-20020a17090af0d200b0029b9b7302acsm1964825pjb.21.2024.03.08.00.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:03:53 -0800 (PST)
Date: Fri, 8 Mar 2024 16:03:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/5] include/exec: remove warning_printed from MemoryRegion
Message-ID: <ZerGXRR7yF0u9tzc@x1n>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307181105.4081793-4-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On Thu, Mar 07, 2024 at 06:11:03PM +0000, Alex Bennée wrote:
> Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
> field is unused.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


