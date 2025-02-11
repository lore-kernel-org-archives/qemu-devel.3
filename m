Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94DFC021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thxql-0005mY-T1; Tue, 11 Feb 2025 16:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thxqj-0005mP-LM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thxqd-0003N1-82
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739309473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iekK8C8DF2Js0HWqUbtJ3hJVPHGDm8ZufblbEWPHLJE=;
 b=JuUsGvvhHMls5FAnpUxGo+rG5mMO/5yPVZH8rWSAXrCLQtU9LH+ajrRghCwKeDY2vLh8Wg
 8t+lmuvsiVbG4qftysg9RrakWCdZy748/SjrFd6qfKy3561rJvWDIadZ7SX31ztvxMrgtK
 BPjZ0/LHs63cTHE391f/fgmNKV0ROxY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-MbgRNnhRN4SH8kUKN2rhjA-1; Tue, 11 Feb 2025 16:31:06 -0500
X-MC-Unique: MbgRNnhRN4SH8kUKN2rhjA-1
X-Mimecast-MFC-AGG-ID: MbgRNnhRN4SH8kUKN2rhjA
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5fc8530336dso1386102eaf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 13:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739309465; x=1739914265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iekK8C8DF2Js0HWqUbtJ3hJVPHGDm8ZufblbEWPHLJE=;
 b=Bekh06zQOSzkqWbNRtaei6zSVmosSBk/GhOEx/WF7OgXodw8TZNYhkPuB89XYdc2QE
 YANnkq1JqOkfCW9vGivLZbE30ZFepZmFA3NRZ6VqhO0vfoLacaMi3xt52mdfBSB3vkW2
 Z0rQgJul1i7m0ZNwm2X6p8OJw4Ra1vkY5WwGwfrAfH1egLCItK10mZfNTntVgYkJRu2A
 bqJIJdGyDd6Rq7gMcf+sq3dnq3hA0ANRx1k4jRAnUxeFYy5vQvSn5GHK7mN1CwTNkHMr
 tTz9mF2kR95wyAt6250frPkrYQAYnxSdWOj7+5tr7ad9U5P9Agopp9Llbs/4dU/gwmNq
 ztKg==
X-Gm-Message-State: AOJu0Yy9BfQb7WdE2AATtEA7tsEDgPlE2/aROOwOca8sDRbdWEF9swWW
 oY7kNYXosvB4a5qLRlAKRJlGckZWFzYQMxQPpC/yMhSjtldFHKIDGJGC6nyP2etzN0/GTlT5YgQ
 FQ+zqRnhm4Zxo33HTMfiDOtHRhd+iuKO2BiE4/lw9NO966aMtOolP
X-Gm-Gg: ASbGnct/XfyKGmcrJkbQy6wQ63GjJboNVJvrlP7FTc+O5wMybDSjxTKIq9PNGnlEwDn
 MwlUMFa7Dua6xaPufpJbIt8KhAwelbK5zXqGG7Wi81O0mCKjDJR6lypkSZvQ6EO6BBHWyazqdV4
 5UXIENRNKwHEZjmlJibBNbmIsCdLv+WwVO+zaLyN6g1L+8sEjbqE4nawk5rHU1Gp9PSEwb+sbqj
 8QncX22f1hCdEr21t7xFZGPeR9662stRXiY/BxGdKAh9DjoyGv4jR4SvFs=
X-Received: by 2002:a05:6808:2dc3:b0:3f3:afd0:a682 with SMTP id
 5614622812f47-3f3cd600a54mr809071b6e.11.1739309465309; 
 Tue, 11 Feb 2025 13:31:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL+/2HEY4gk7XtKIY1MZDguUE2wjQIWj+F1qcLZ768CLNM+L3Gsmz641swy+2v3LhkPGzF2Q==
X-Received: by 2002:a05:6808:2dc3:b0:3f3:afd0:a682 with SMTP id
 5614622812f47-3f3cd600a54mr809047b6e.11.1739309465019; 
 Tue, 11 Feb 2025 13:31:05 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f389ed1ca2sm3535287b6e.11.2025.02.11.13.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 13:31:04 -0800 (PST)
Date: Tue, 11 Feb 2025 16:31:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/9] tests/qtest/migration: Add a cancel test
Message-ID: <Z6vBlAqGN-GJNCq2@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-9-farosas@suse.de> <Z6urZeOyLYRJzMM8@x1.local>
 <87pljouqev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pljouqev.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 11, 2025 at 06:23:20PM -0300, Fabiano Rosas wrote:
> It gets super boilerplatey:

Let's go with what we have.

Thanks,

-- 
Peter Xu


