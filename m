Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE00E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 19:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxvF-0001cI-V7; Thu, 09 Jan 2025 14:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVxv4-0001Tw-SN
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVxv3-0000dj-90
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736449811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrBHSRViDf0/eXCR+bUXNC0wt3XffTjlAVW4cZo4lQY=;
 b=UOwmnGz+uza3X/Hk7lFitQTwwtH/yPJYZ/fAVoBkPOfO5q9ynYT6/RO67iHJPjdn7YlRW9
 KCcxCNph6kY8Wlc0eE0mL9nQvkmuDYD8tAKw5HZNmsBrNcYn9v81yY6+9+4VuKSQARNlvA
 7rzvo20CzMmd4tt7HDSs/roea1uETOQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-UU7vU67tMgOrYBIUUnxYFQ-1; Thu, 09 Jan 2025 14:10:08 -0500
X-MC-Unique: UU7vU67tMgOrYBIUUnxYFQ-1
X-Mimecast-MFC-AGG-ID: UU7vU67tMgOrYBIUUnxYFQ
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-46791423fc9so22451701cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 11:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736449808; x=1737054608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrBHSRViDf0/eXCR+bUXNC0wt3XffTjlAVW4cZo4lQY=;
 b=SAQTJsanXpyX4j9zYhUzIwaSsT8cqlsb3rKgWjJYIaPDXtEg7jf3NJTaYenC86HhlP
 5G3HpudJmtd/ha4J0L7yqqd5tQbUOnhm7tNk42+HLdui+K4Ff6cQ6efCRlAQz5MBUq10
 jVd3p1vr1CMKcHlSgdc+ZqD/pVzUbx8lnJHyyh/lJzLkzkIW4Vm2ztc7Y4tzE6ypET6k
 uu4OzvCsNcf2HedTp8E2i/bU377gfLl7dbn7u19tZWofGQ+uRDum2nx65o06KHX8FjSA
 duCTKwmuDNPHEFdA/wwJXup7N9ICJgJCfWkUQMN/9h06r0SbsOKUsrRjksA8AsYAizAD
 ilMg==
X-Gm-Message-State: AOJu0Yy0AVBChyDR1X+v0oXcNrbiL83eUh7Ytb3fYVojpu46EQ8Gmf+A
 v7S0Mqecu4NyovLmRVuXV9hAFOwSzXomtHTai9RAeG/OpbZrIX9raPK+ZH3dy+GLyCHlNreTuOV
 Ea3341VTZI+9+YDLYAip9UeDOmLao471sRTzf16SAD5L1HdQi7/0B
X-Gm-Gg: ASbGncvHhpCOMYINfopyvMmGn6rWwW3J4GPXw2awfaBuA3Qqu8ExF/n5zNws6G85yWj
 wQPqGQKTSobXfdemWFAAHL9MkKFWGGypTxy/7uJ+hQyB/ai3pVD7tj/p1SQO3+tvImTN8G0SxaT
 Y8NvjpEUvSyZM4OPRro9URCKQHuiPuDEIF6e9n3Zj09kCFV5thfEGYF4MI10HEKhQf3tX+i0ysR
 ptFNhevILtwGNyYro3myFixCCghfrvUUKcWiPY0zWMYdjPj7dUgCLNE0d00baEEu9NH3JT+WuFS
 OC3WL4LXOKp6L0VjkA==
X-Received: by 2002:a05:622a:148c:b0:466:b122:5138 with SMTP id
 d75a77b69052e-46c71005797mr113524291cf.17.1736449807843; 
 Thu, 09 Jan 2025 11:10:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq24Pkqg7BcUfSNNT44r1wc3e2RAd1kMYy8tfQHYlxeY6T+zVoKgkWC05A45EkoQOSqq8s8g==
X-Received: by 2002:a05:622a:148c:b0:466:b122:5138 with SMTP id
 d75a77b69052e-46c71005797mr113523991cf.17.1736449807540; 
 Thu, 09 Jan 2025 11:10:07 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873216a0sm1408371cf.10.2025.01.09.11.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 11:10:06 -0800 (PST)
Date: Thu, 9 Jan 2025 14:10:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 4/7] migration: Rename vmstate_info_nullptr
Message-ID: <Z4AfDIkIdxIdQCYZ@x1n>
References: <20250109185249.23952-1-farosas@suse.de>
 <20250109185249.23952-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109185249.23952-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 09, 2025 at 03:52:46PM -0300, Fabiano Rosas wrote:
> Rename vmstate_info_nullptr from "uint64_t" to "nullptr". This vmstate
> actually reads and writes just a byte, so the proper name would be
> uint8. However, since this is a marker for a NULL pointer, it's
> convenient to have a more explicit name that can be identified by the
> consumers of the JSON part of the stream.
> 
> Change the name to "nullptr" and add support for it in the
> analyze-migration.py script. Arbitrarily use the name of the type as
> the value of the field to avoid the script showing 0x30 or '0', which
> could be confusing for readers.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


