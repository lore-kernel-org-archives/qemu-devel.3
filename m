Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4C6C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfVU-0001Qs-O7; Mon, 11 Mar 2024 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjfVI-0001Md-2E
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjfVF-0003Es-2x
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710162940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Avp14Xh3earAWU8RRCCJSsK7gNBFC151UXNJX1hknBw=;
 b=IHevytoJNQkhb+gP3E7fuQoKKiQUU9pJMKjrNIGEtBZWvGhcpZI+u99jfyYO8XJ9BoacM5
 QeeTv4lV2AeyOJsEo9mKywHalU+IU/CniaWgtZV7Jqtg7apGru0UOoAezqEHvA5fVVaFF9
 ecdvdT4i3Pg7D2rspTudmVAtol298IQ=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-E9SVC_HHM_WNzhCDsbI5cw-1; Mon, 11 Mar 2024 09:15:22 -0400
X-MC-Unique: E9SVC_HHM_WNzhCDsbI5cw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7dc03020e3bso121630241.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710162921; x=1710767721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avp14Xh3earAWU8RRCCJSsK7gNBFC151UXNJX1hknBw=;
 b=DOarsS80WhXCBcuAtQPPQPNHY6nlV1oGrDGa/+cDCOFjFRzwFCj4jLb8CQTO9Tk+36
 Av1lwMHM0vtE1yhJ7/sBFZHjkjLAIQ6SZcrlAiBxN5LKMAj2mB51V8PC6SKOlhP7YIsM
 AEyoOviotP9c7yoDyCjmtu3QZmOEEwCvgpfUTxn3EEhZ1ILUviCt9P8kNZM1NL3rfk0R
 6JplTTHUcXQlJBkZDf8QDN8eg+dYZqeSozHzwjEPGE/tD5BcbUIYngha+CQTyt2Wz08r
 KAvRH71uY5vpJf0KT/Rwyh1/5P0VBW9xxhvQ8yyvtnQvG7hRRiN1dt1TON23gHzEUIUW
 aguw==
X-Gm-Message-State: AOJu0YwzSLK3gZMgXehD2NpYRLUb1JBXWWSsiBdV2F7bw/xTWSiK5QOj
 +zO8XfHCdxrrFlB15sM461TCVD9ZzWI0CgGe/7qxpUsMn02b/df3nLe8vHLAu7GO1anqE81+Avs
 HvtQwBHJonoB4PYlCLmYTTZ/lvnvmtSvtmvSr+GTT5Ny3r8+3O5+J
X-Received: by 2002:a05:6122:2654:b0:4c8:e3a0:6631 with SMTP id
 dr20-20020a056122265400b004c8e3a06631mr2685559vkb.1.1710162921600; 
 Mon, 11 Mar 2024 06:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtCLrJKIS1Wi6/y/EWPiHE4VW0pE6ZdoIfGUBYvPosRcJOxxDd5umEbSrEjqft++NxGufLug==
X-Received: by 2002:a05:6122:2654:b0:4c8:e3a0:6631 with SMTP id
 dr20-20020a056122265400b004c8e3a06631mr2685520vkb.1.1710162921179; 
 Mon, 11 Mar 2024 06:15:21 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fp4-20020a0561223a0400b004d13bb918c4sm597683vkb.33.2024.03.11.06.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:15:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:15:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Fix format in error message
Message-ID: <Ze8D5xYwXfTNHCob@x1n>
References: <20240311123439.16844-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311123439.16844-1-anthony.perard@citrix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 11, 2024 at 12:34:39PM +0000, Anthony PERARD wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> In file_write_ramblock_iov(), "offset" is "uintptr_t" and not
> "ram_addr_t". While usually they are both equivalent, this is not the
> case with CONFIG_XEN_BACKEND.
> 
> Use the right format. This will fix build on 32-bit.
> 
> Fixes: f427d90b9898 ("migration/multifd: Support outgoing mapped-ram stream format")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Rather than waiting for a trivial pull, I'll queue this for 9.0.  Thanks.

-- 
Peter Xu


