Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021B4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 11:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uER9e-0003dv-LG; Mon, 12 May 2025 07:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uER9c-0003df-U2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 07:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uER9a-0003Fv-HM
 for qemu-devel@nongnu.org; Mon, 12 May 2025 07:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747048620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1kvcC3FsLKBAc9CN+yFiunK3h9AePkQN+lWwQY/DUs=;
 b=I5DHyiqRNWiy0gXYsoCyPb8hLgMw0oUeZu0HnYOUg7YikExQ4CSmoZWJ/zl0griNYCqNct
 P9KB+PVGAFPTIR6zSs+U4fHSKuA29PbQ35ktkl3Up6IhDjNKZyNrFpBeSD6J/s69+XnPkF
 X1QOyZAtEyHh61B4BDAmDXN0ccWdAWI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-rn1gO14AMCW-cjVHKBYzFw-1; Mon, 12 May 2025 07:16:59 -0400
X-MC-Unique: rn1gO14AMCW-cjVHKBYzFw-1
X-Mimecast-MFC-AGG-ID: rn1gO14AMCW-cjVHKBYzFw_1747048618
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so22462705e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 04:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747048618; x=1747653418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R1kvcC3FsLKBAc9CN+yFiunK3h9AePkQN+lWwQY/DUs=;
 b=DqbnCmOslf/aRBczIjWH8MaT5bdyyqZx6llFzoCgXUQ//070W39vZh+uCUagyRNwtS
 10a5QV3r58z+W/oz/Xcg2+Tps3oAbsitfK8H4tbmdtaBu0rHS7Z6wewVivxhBODCDuYl
 vi2AEVSBoqaKiNlD6pJrXOvNhIkdey1Bo0dwt+TOu2L1h56NkhWYtXw7Mqe6fYWGbN2/
 cDGW+bhPu1Von8/irrb+pjIP5r7FngaBVujsaHIntF1bvn2bTTFwDnHa3tgnCPY84oOA
 ebsmtD5b4eHw5JPnfEqm43d2qCqxCTKj5OrZwKNOyrinRCmmcKudSY/6sGZ+mfXn78Ld
 tjhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3/x8BdFEdaBhEPX2A0ZgmBBBIEabQxZzIp/e0FozTLpHVfgQYRRv585pY4dOZgZxOSeuWLAIXgush@nongnu.org
X-Gm-Message-State: AOJu0YwsfVZNXJ77Lrm7wr5QALRqbx+5CZhN6c7zQJsoRA67Sd0SmmF0
 hDpWNttxog8uFowNMctHI2Se3psP7AMBCknFAnq9Iv7KsVWKOpavIJ+8Bpeq28cE+pmHGHex+S1
 bjlZ8uBF1/yHSIVR9q0e8Z7QUf7TdRVSwlnkuLuPPeDYSHyuIf0KT
X-Gm-Gg: ASbGncvubI4Tmq+9hYbfpCy7qhB/+CBogup3jJqBIRK1jhpLa6iWbsK+jgDKGif85M5
 1+EKrxi/RlZgGLtuj9Abh3qTOK1xhhBhm3W8yY+7yMJ/lFDpXPISg+0CXJeMmkKZokK5Jk9gfdG
 vAy9R6R9ezdlyiUyAiNQtCssCrhSwGTkt7lyBnY0A5TUZSHEn5KSgHaGaqqMwyXOf0RV9WCRD5Q
 8v+tkZKxAPDet/VHEvNYtXfYFt77bMgP/L4C4kty/xxGbPXDNKOVf7fYyRhDdyRSue1To8BQnXY
 nWyUvI9CmN6aCPXefyX1mW90HhfNGSOVw44O4xLr5BW4chdW4DwKstt+yXHVj3JD2deduWliXCe
 E5qQQPct3kUALbmTd9IcyyqWowoxeqMBMuwxU7tCb
X-Received: by 2002:a05:600c:8208:b0:43b:ca39:6c7d with SMTP id
 5b1f17b1804b1-442d6d19269mr123056315e9.3.1747048617845; 
 Mon, 12 May 2025 04:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi97I/9U6HybXKvmoABEn+06DEh9/UfrPfWc0lnQiUgRIE2J54r+5+mqM0W2OFB5cCUg9kFQ==
X-Received: by 2002:a05:600c:8208:b0:43b:ca39:6c7d with SMTP id
 5b1f17b1804b1-442d6d19269mr123056115e9.3.1747048617483; 
 Mon, 12 May 2025 04:16:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d728:a04f:9b31:367d:c7f0:219d?
 (p200300cfd728a04f9b31367dc7f0219d.dip0.t-ipconnect.de.
 [2003:cf:d728:a04f:9b31:367d:c7f0:219d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bc2fsm58996845e9.20.2025.05.12.04.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 04:16:56 -0700 (PDT)
Message-ID: <a1aa1173-5362-44f6-8b64-6d44f1b5eb82@redhat.com>
Date: Mon, 12 May 2025 13:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: add for_commit option to measure
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20250416071654.978264-1-jean-louis@dupond.be>
 <20250416071654.978264-2-jean-louis@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250416071654.978264-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 16.04.25 09:16, Jean-Louis Dupond wrote:
> To specify we use measure call for commit size calculations, we add a
> new 'for_commit' option to the measure call.
> This will be used in following commit to do a different measurement.

Why not allow specifying the node name (or filename) of the commit 
target instead of this just being a boolean?

(That was my main problem with the original series, that it wasn’t 
possible to specify the commit target (in an obvious way at least). I’m 
not a fan of deferring to JSON parameters for this, although I’m aware 
that to specify the node name of the commit target you would have to use 
JSON again, unless qemu-img can do some translation on behalf of the 
user: Looking at `commit -b`, that takes a filename; it could make sense 
to have the internal QAPI parameter use a node name, and qemu-img 
translating the filename parameter into a node name.  Actually, 
`measure` could just accept the same `-b` option as `commit`, which it 
would then translate into the QAPI `for-commit=<node-name>` option.)

Hanna

> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2.c                    | 16 +++++++++++++
>   include/block/block_int-common.h |  4 ++++
>   qapi/block-core.json             | 28 ++++++++++++++++++++++
>   qemu-img.c                       | 40 ++++++++++++++++++++++++++++----
>   4 files changed, 83 insertions(+), 5 deletions(-)


