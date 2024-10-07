Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC2ACFB44E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqvb-00041a-0n; Mon, 07 Oct 2024 12:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqvS-000413-Hd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqvQ-0001id-LN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728319776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2d7C+GNSvGCo5+p/uoE0UbGBHIaPIUCTehZKTSVV+M=;
 b=bgRw8uoB/8l7DK/7teoMM2/06MIl+1kyPUMVB2SlkPY+e77q5pVm5Ak0JB5dF+3fHB84ex
 g67zalZCZvg4HUI59monbe/K5xG++4KnzxyeyLRHnuq118+w0MtQzUzcRtv+qcaR5Vj6Rx
 8Mddi3REPcTvOYpVdu7m8604jm5P5+I=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-FQ7TRSb_OyG-9VmUr_tKzQ-1; Mon, 07 Oct 2024 12:49:34 -0400
X-MC-Unique: FQ7TRSb_OyG-9VmUr_tKzQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a19665ed40so34669095ab.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319774; x=1728924574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2d7C+GNSvGCo5+p/uoE0UbGBHIaPIUCTehZKTSVV+M=;
 b=uGFIUF8EZBZoHLLLuYU/5WZ/yoau8ruAzf/fZNcuU6DQDzbkEVcWS/oN5xH6lTGqub
 Hk/NQt7nBriW/5GLc1n27vofv7IFjaLPVuED16Vpraf6iNemqfJtvNxmKEmQSvTd9acd
 Ym7u/UYLb9hx1LHP0AyEx+suZjaK9SFjnZvJU2v7GGXdk1uIq3x3Cy3vqC8ih20xE3Hj
 e64a3v3yNJCVhRrvdXSk8nXSbWx3I9rF0VCFIJNh1ArkiBvPOmWj9CuTVqRvgcxHM7gw
 jz6qhEB6CZu7HAH+7Fjz3MQyAtsObV4Ce1GFPVfj9BgPm7n/l0RJU1I/fGV5bOWxkoy0
 +72w==
X-Gm-Message-State: AOJu0YyrhqSq5E5eeyouHHd+0OSrwQZD/ViFNHjvDd/VuWKDS1TEroco
 s/P3xDQEHWA3yfB4o6rKyLGMz6StpjJ1KAWDAy6yMwBXgy0N9okW4+V3dMNKWPXptFz820daZgE
 CJZTBLfHMRHKSe0UCiLyAlHZvlk9/oY/iCpD9Tqui/YuImz643OXG
X-Received: by 2002:a05:6e02:1c41:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a38af1565amr2145145ab.1.1728319774219; 
 Mon, 07 Oct 2024 09:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo2+ClRa/4wuN2Skfx19B0UCReFrYlHIlmf0krmtEBUIMeLNLf+RWni4vndqcteoU/v6JvoQ==
X-Received: by 2002:a05:6e02:1c41:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a38af1565amr2144905ab.1.1728319773918; 
 Mon, 07 Oct 2024 09:49:33 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a7fd529sm13977825ab.22.2024.10.07.09.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:49:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:49:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 10/13] migration: cpr-uri parameter
Message-ID: <ZwQRF6FY4-G88KuM@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-11-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-11-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:40:41PM -0700, Steve Sistare wrote:
> Define the cpr-uri migration parameter to specify the URI to which
> CPR vmstate is saved for cpr-transfer mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


