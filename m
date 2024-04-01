Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE00CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 14:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrIJS-0008OG-9z; Mon, 01 Apr 2024 10:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrIJR-0008Nl-72
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrIJP-0004X8-Cw
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711980418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZZHqP2dXWcjJ9Xguxj80QmPlHq9USBKyq4q8uaYKUs=;
 b=YhNJv7fuQogJjGwHc4KiXBepUqspPshqtLWk2ZTygGIthy8yKtEE4+7SUA3yfWQm9uAwBA
 qyoR5stIovCtBiwHlV1M+0QonQ0UGPdIhSvocFrIWcvEzJwlpGULZRlGcNupT61KqpqjuV
 nPsJXJUWFI6WfsVX1+ltEM2nhqTFgTU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-h8VlwKJONBCUFBSQWFh3Mw-1; Mon, 01 Apr 2024 10:06:54 -0400
X-MC-Unique: h8VlwKJONBCUFBSQWFh3Mw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69627b26a51so1881166d6.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 07:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711980414; x=1712585214;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZZHqP2dXWcjJ9Xguxj80QmPlHq9USBKyq4q8uaYKUs=;
 b=bxEf7qpWkzONEVeSFYxfjpeayCMqEEcw+09eXsZ2LORPYWlE+bOAzbtMw0YY8kw/Rq
 mEpwLDpvKkfGvLuN7OvJ5V6NQA39GcusHSzwfWVVIMJlPwl9C7pWIEjeE8wlY8wvSdmh
 +iQuzzmRQovYMdiPit1Mt3d4tBRHjlg4C7Uwm65qecBcz/n0Hf2HSmfGTsy7ewPJBFtk
 AnNFiq7BzPCiSr7pS77xPRhSsjE7AbozCS5oi4Aha4wh5Zg5DaF0bOU9EwTNsL4tIgOS
 dlJxPmK+dRgst34nDtYYvnAiEfSqMwUWq56WP57N5LzYRmsLEK8QKKHu7gbD6YBpaibX
 YueA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKUcoOTwrcuEn/68gUcPTmcK6OEXxdWdgJK4scFx1p06Fu66zot8flcBWGm3XzWs2QHKLGhUd455UeM4LyQNA23f1Kj70=
X-Gm-Message-State: AOJu0YwnCq6UxTlUxehVO/BTkQtxyzemVh/G+q3c6bWpAkTu3I70tMM4
 asnqbwS6QVf6movT8Oes29HcKmaCgg+FQ88tGg4RQ7m8/WuY9o7ttUyrWCQ4QUSpgFO8td9kCEd
 +w52+sOETIKceBQ03owHm3ywd1zRN8VUzRqrUqDtms5VYqdIQUNN7
X-Received: by 2002:a0c:9c82:0:b0:699:4a1:e12d with SMTP id
 i2-20020a0c9c82000000b0069904a1e12dmr3355086qvf.0.1711980413922; 
 Mon, 01 Apr 2024 07:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9W+zz/G+4UpRUOlfNRtSTdtEJ2sGBdeSqdS5Lt28JN7m0WPLYf4W224agNxVLbsOrX3Few==
X-Received: by 2002:a0c:9c82:0:b0:699:4a1:e12d with SMTP id
 i2-20020a0c9c82000000b0069904a1e12dmr3355050qvf.0.1711980413412; 
 Mon, 01 Apr 2024 07:06:53 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 kc21-20020a056214411500b00698fccd2e02sm2338917qvb.43.2024.04.01.07.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 07:06:53 -0700 (PDT)
Date: Mon, 1 Apr 2024 10:06:51 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH for-9.1] migration: Add Error** argument to
 add_bitmaps_to_list()
Message-ID: <Zgq_e_9POf4AjCLC@x1n>
References: <20240329105627.311227-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329105627.311227-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Mar 29, 2024 at 11:56:27AM +0100, Cédric Le Goater wrote:
> This allows to report more precise errors in the migration handler
> dirty_bitmap_save_setup().
> 
> Suggested-by Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  To apply on top of : 
>  https://lore.kernel.org/qemu-devel/20240320064911.545001-1-clg@redhat.com/

queued, thanks.

-- 
Peter Xu


