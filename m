Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499F4C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh2fw-0006VM-Sz; Mon, 04 Mar 2024 02:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2fv-0006Uz-Ee
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2ft-0007uW-RP
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709537029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tx2OHJagyKX9iVWfWYAwHFKSVDiDWWbqMAErP9YrgOU=;
 b=TRrMRdr8hFNk9uW7C2HfEEgxOGcbDgZMIwid1NawmASyAtl7kj3RvUL+KTaNOC1OLlrIDH
 r8Y9dWrlqV4n2O3Q2Th+m8XXB3pZR9b17ZttZGUjkU8EpKfs/wVz84fMgm9C+1arNc9JL3
 0Nxn+eCbQrdd9KJxvNzpMAjmWlDLgLQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-Ydgsvkk3PNS3sUArjMIJyA-1; Mon, 04 Mar 2024 02:23:47 -0500
X-MC-Unique: Ydgsvkk3PNS3sUArjMIJyA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so1584515a91.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709537026; x=1710141826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tx2OHJagyKX9iVWfWYAwHFKSVDiDWWbqMAErP9YrgOU=;
 b=cBKxwC7KhtRKgLL7q0dP7vmXBVa+1UtchE8ytto3nS1mwYaYMTepaRJEvYV2nlxPzD
 Tp2C9wWFqcQPC0k2ZAu+l3jFFojKhK0byqBwRwnZu8kPahZillOO2ssK0SYcF5aq6fE9
 cLE1gW2CtW7n6b5S5p7mTyGM1wz9t7XG+izJ+5xcQhMBQMpM8BVNQRUIMOLJG8HYxK+5
 DquXqQhkEyTGoDETLjdExpmFyE2rDivT5O9SQLYSV6LPWenThqEA0tAdXZ79gP5M62KD
 MSpenXwyBmyobs38OOyefySeaiW961IXJopr3OHu3anhF0Q1Jj+gkaImeBZ9DmpnWAa3
 ZPCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo8pRZdrAj9qLBDOOaUZruaqO21sx7TsriDTjLOrGM2XfxR134LSbjiHnrTcT4USAILfWW4HBUMXzHmZ0Y9wCKGdWaGz8=
X-Gm-Message-State: AOJu0YxtmKXqwsvDDOXhN/fcztwDr1A6hPWy3fRhOqCLVE2dX231xtdL
 H6nKYo93W7qDsXLPG9MOSrxieFdfWyXnDDprWdc4vWbaURJbgw0680GHhsa4Q1CPdCGbWCTLoUv
 NkG7c9m8QVZgzLZzAnOH3bR4fatchRmfZO0MVmeZxXT4NOsbETN67
X-Received: by 2002:a17:902:ed55:b0:1db:f23f:676c with SMTP id
 y21-20020a170902ed5500b001dbf23f676cmr9168435plb.0.1709537026652; 
 Sun, 03 Mar 2024 23:23:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRnX96l+BF3vPHEcSun/k58XYFvXpYOhNcma4QutkhxSZE1pf2Lm90SLCdikXo83aRKoezPA==
X-Received: by 2002:a17:902:ed55:b0:1db:f23f:676c with SMTP id
 y21-20020a170902ed5500b001dbf23f676cmr9168420plb.0.1709537026307; 
 Sun, 03 Mar 2024 23:23:46 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s13-20020a170902ea0d00b001dcc0c84721sm7770612plg.99.2024.03.03.23.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:23:46 -0800 (PST)
Date: Mon, 4 Mar 2024 15:23:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 5/7] migration/multifd: Add new migration test cases
 for legacy zero page checking.
Message-ID: <ZeV29gou9Hgk9Av8@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-6-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301022829.3390548-6-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

On Fri, Mar 01, 2024 at 02:28:27AM +0000, Hao Xiang wrote:
> Now that zero page checking is done on the multifd sender threads by
> default, we still provide an option for backward compatibility. This
> change adds a qtest migration test case to set the zero-page-detection
> option to "legacy" and run multifd migration with zero page checking on the
> migration main thread.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


