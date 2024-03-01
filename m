Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6B0C54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfs35-0008N6-MS; Thu, 29 Feb 2024 20:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfs2x-0008Ls-0M
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:50:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfs2v-0006Sc-0t
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709257843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPo9tM+kleTvC5KKn32vdTLXbqhD0PSJJtcDIU345Ps=;
 b=jJT+Ud92TCn9n6aZph+C2RZ9h6+k76Gux1PiSbia7t/7w0k8yA93tebh0JrfwNT5vV8lgq
 rba4VtVgdYqRu5jeIZWw7veNj2yjFBSPWwMPMsynAbbiXg78g00ay5asNwvR5Ll5TM0sPl
 5jPmveE+XFleGRyjWtPZcPrhsveCtNs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-qxTXnIjgODa8RcrFr5GvbQ-1; Thu, 29 Feb 2024 20:50:41 -0500
X-MC-Unique: qxTXnIjgODa8RcrFr5GvbQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so470814a91.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709257840; x=1709862640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPo9tM+kleTvC5KKn32vdTLXbqhD0PSJJtcDIU345Ps=;
 b=iVWFmrjh6makRpOV0j9BT4cRGzIyKCgoY9jR1jJRHIwxFH4gx+EZrWBSP1ljzYKn/I
 ht8wwtJEOiaQoHYHoConAl/jidChN3FJduO1iIWJ+Gsdd7ksOdPLRVkgR8Ca41rrI52Z
 TR4QuyI57SIyaHErNcDql53Hk0o5z/gDf01D4L2K8WwvE9JtsuG3NEEyuw6InGtgR/+5
 NB925JQDjIuMOoDbVKq4mAYA/oQDmdMnem2sSfP9cTSKG/e3pYFWQHhg3AXWtkylYTa/
 hNhg8MMBMG+K7cF1XOK9bATWERf3UxPT8jQyWve2GgcQWaXG4Jd8jDUkp0hg5Q/29uIk
 XCwQ==
X-Gm-Message-State: AOJu0YwvQmVRg5JN6RltvKn1njxvCOJvY/12hD611g/7oWNAZCzMvKZi
 JQ0MG0APDgTLcn22QYHqVtIk/IWAxYULrP3Tzz2dnCAQxEXmSmdzrW0eZQp9wG4LkHPTjOGJYq8
 4S59tsBf/4H9XmQXcU0zJZftLxklSYGFgyvkMNTRd7vYgGzIXmQa5
X-Received: by 2002:a17:902:c38c:b0:1dc:2be8:f61a with SMTP id
 g12-20020a170902c38c00b001dc2be8f61amr317428plg.2.1709257840426; 
 Thu, 29 Feb 2024 17:50:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKcemItg2rjudzYYIAKuEIZXCUqx+AHX6WeIE+0plLjOZrriWHlIquQVisb+z/SyDdMpwhUw==
X-Received: by 2002:a17:902:c38c:b0:1dc:2be8:f61a with SMTP id
 g12-20020a170902c38c00b001dc2be8f61amr317412plg.2.1709257840105; 
 Thu, 29 Feb 2024 17:50:40 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ld15-20020a170902facf00b001d8edfec673sm2173952plb.214.2024.02.29.17.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 17:50:39 -0800 (PST)
Date: Fri, 1 Mar 2024 09:50:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeE0aHAcfREWSFIM@x1n>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> Based-on: 74aa0fb297 (migration: options incompatible with cpr) # peterx/migration-next
> 
> Hi,
> 
> In this v6:
> 
> - Minor fixes to 17/23 and 19/23

The whole set looks good to me now.  I plan to queue it before the
direct-io stuff.  Any other comments / concerns from anyone?

Dan, would it be fine I queue the IO patches together?

Thanks,

-- 
Peter Xu


