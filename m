Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E80CD98CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLkf-0006Mh-28; Tue, 16 Jun 2026 00:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZLkY-0006LZ-GB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZLkW-0000se-0A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781585404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t59E2aouq/3QjefgJDM5lIaSX+On9iGlsZVXPZNqm54=;
 b=SAtX/dszG1/291KTtPfbUraUperEtb4v1QJrpEbCA6yPwDxch6tJz4m9zYEW5z0u2USASv
 UOrMQRETGuhVYq1VCQ2BbTj3rq03ekXXfj5Gz2Pfh/Sln7x2DjpXydPKDTvcYMs4T3KHHU
 2bKHm1K9UD283TB/756GzNlqU8rh+nk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-pwTaRMFWOECONyXIUhzKPg-1; Tue, 16 Jun 2026 00:50:02 -0400
X-MC-Unique: pwTaRMFWOECONyXIUhzKPg-1
X-Mimecast-MFC-AGG-ID: pwTaRMFWOECONyXIUhzKPg_1781585401
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef66cc579so1924956f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781585401; x=1782190201; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t59E2aouq/3QjefgJDM5lIaSX+On9iGlsZVXPZNqm54=;
 b=ZvZU/3pORq6gdKL6c+UwqqPCl5q5dUDN8LSbLPke3GreyMy6hk9ckICQgFGcuVBbIB
 +awlGBL8CtbWI7snwfcZ1PBae9mcSo0Pgt7S4HiRC9vhUzZaNsud7Ls1dHdMWHQsB/4i
 Ivmn52fHYPvlgBnbS/LCFz1Z805zBMZO6oZMVUPPMyDU6CnjAlsK7J0uOv8ln3N57HCG
 1cdkIHBzz72EH516/3w/m9q77qgML9Jmuzs6vaOvPPbjCJcMVvIPCyWuXbLLTQI/UQfn
 8Ou5ubbW4FgdC0Ns6dwoOL0O2COHPRzWufECPsrXaFFWLoEXzdnikpOQIBfLV/AD6jlo
 wERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781585401; x=1782190201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t59E2aouq/3QjefgJDM5lIaSX+On9iGlsZVXPZNqm54=;
 b=bN5+Re4UgbtHe6ipm/xUUFrbHuxlfK+CH4Zh6YrQ2Ut0TnwNk8D+zY0JAUnWzqTRY/
 ByyiOM3iCF4CNZ/ZIeEGaAfOk5OfyE3kAx824SEH1lZTUIGXK6r53yBg7xr4L/zlhhdv
 nrPafhbhFhm4LbtFC6dKBf5WzUypSOvMcrydqgPMC4yAgpuknMZFokG1Qat3L8kuCdiU
 Vn/g5yikr8gpCX8CEWzQ10RvFowyRGQ1u6M5BCk1C4L4E7Lnj73zTzuBp0TZWzLyVt8u
 M/QcZ9xMM/cuBRhNtjfo2jTDHzHlFSEpdkDchO3NTOYjwtuTQ51zjREGoUf7Kt9nKZ4W
 e/pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C1xwVd00BIlPVSU/AYOHdkGvVm+nt7GPZ+MkbJtuoF0k6TMR3axxzHV/CTnrHn9hRlQ1J6vUv/zVL@nongnu.org
X-Gm-Message-State: AOJu0YyA0rPx0Wg9PdHEpjt456q2LMyBP6coj2jIEY20xLxuYMg0V4Na
 nsWChut9chJ/Ukhm1WuF/b1Agh0/JtuISXjdmy0N6In7TFxoy9HzXS6wzJOgUgETMieiSp8/xsU
 fizEwmx8k3lzsxYOl1zSTs+X900SZw/pj6iw6At3SHO5CJ3qLfGBbOOqq
X-Gm-Gg: Acq92OHzFBVvJZIr9WgdQnLqOfkIoF+KgMOArCnktSIo9y7gz05IDP756SvATHjwkiZ
 oQxkVjK0Jq2cJwD1Maj+jRVxGicv7U6Yg9NWt2HkBhaF/tfRLj106j2l2uCFSdlChYXuv9R8Juj
 r3zQcJtANYer7g+z4mqJL4yi3+oJXDUNtZzfGZWV4pM7m9TjMUiweSw6rAoPvCsoWrl3wGPxbQ3
 wAEZ8Afla70dQTE1W0WIZBF+5RuTvhpImUZcqpBdPhx3NIH4NST9AYkc97PP7tTY9893Yc+4hIN
 XKWbl3xm0R1YoqTN1ZzAVQ69ghigGL9m/pjQXztnJcfvAw2oqowZKW+eGtjg7ZUkIiWfjobtlkh
 1vQyjQfPzfezFAtyLfEKyeC5XA3mEaX2HtXZQGygFQaY=
X-Received: by 2002:a05:600c:3144:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490ec4d523dmr231372345e9.11.1781585401416; 
 Mon, 15 Jun 2026 21:50:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3144:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490ec4d523dmr231372005e9.11.1781585401026; 
 Mon, 15 Jun 2026 21:50:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263923sm41116604f8f.2.2026.06.15.21.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 21:50:00 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:49:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, berrange@redhat.com, philmd@oss.qualcomm.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260616004924-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
 <20260615224658-mutt-send-email-mst@kernel.org>
 <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 15, 2026 at 09:48:00PM -0700, Richard Henderson wrote:
> On 6/15/26 21:23, Michael S. Tsirkin wrote:
> > B. Also on x86, I do not see why we should not use memcpy for large
> > accesses if we can. Better perf.
> 
> We have an example where memcpy writes to the same location 3 times.
> This is not appropriate for any host.
> 
> 
> r~

as in, same byte?  could you share the details pls?


