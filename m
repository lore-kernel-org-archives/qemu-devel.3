Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F9C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOQG-0003Hn-TA; Wed, 29 May 2024 14:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOQF-0003HP-HF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOQD-0004xH-VP
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717008792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGD9MqR3i1Ye2vqyYg4lbcKkke9fvmJnO2qDS/siTXo=;
 b=V33Nqm6NShWxCIiSE24xPjqujFcp9lPOTFvkg3Sv0xCogSq5dC8H9uRQgS156K1AOTh6At
 ui5xyTlkdLKpgY0HGUv50DOAaPjCAIAzO7SoLoUhjBigdShRrLSlR8NUQh2WHtC+aJh+SL
 ykAxYPAgaBmvYFGwEvjVytfHcCvnqns=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-lm6x00AMPAelLO1MLTLZoA-1; Wed, 29 May 2024 14:53:11 -0400
X-MC-Unique: lm6x00AMPAelLO1MLTLZoA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab960d4c84so94156d6.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 11:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717008790; x=1717613590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGD9MqR3i1Ye2vqyYg4lbcKkke9fvmJnO2qDS/siTXo=;
 b=JQabwFZdHlOis/gAeC+VNT049oCUIIm408UQNyChPjIhPn/vMidrtfXPgiXNXbsCF4
 BZBUtqTHEql+/odyaUelN4UR3YFi3oEH6q5jJsHRSxKBxuLGIe93ZUkGRuBTV5xBK2vF
 RLAQyVCgkSBG+YpMBt+mMLaanELv9S4ct7fSIuL0Z+xRK5rFXhEvLUPNP3mp1QDz8Au3
 tK7uCTqBzyQnyfjkd/QrJ2F6zETQ65DzWxSHsk1jbCg7TxVWtVQILA+8szjGvsT2DfEf
 fw+c7AGg4hZ4SpPqIwuOeMKenuGr2P2WWvU/yapWkyDhqdfMD7O5oyTPB4UpqCPm9rLf
 P9AQ==
X-Gm-Message-State: AOJu0YxlZWjc/7q3STBSovgpwcpLZIX0lyNFFLlxK4/aZ2zQI/+8EUuS
 /MuBzVdtl/NTKtdvIEjU43z/XNASGvuIfPxrynzO6CtuQ6MfMkT1rG5ThfAI5U5NLmsOFyBVjah
 /dLYLFEMM2vX8jhtJfnnJtlmNSBgXqcni6OqAWfVjBkhsbDIauJqacHf3350u
X-Received: by 2002:a05:620a:284d:b0:790:e856:7cc9 with SMTP id
 af79cd13be357-794e9d96bb6mr5911585a.1.1717008789271; 
 Wed, 29 May 2024 11:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+oyd8oxZkWfJ4rG9NUEWdxaVfE62l/lq4eh2dR+mEh+1N8inpjJAHuMprsbhmSo+CsJGUwg==
X-Received: by 2002:a05:620a:284d:b0:790:e856:7cc9 with SMTP id
 af79cd13be357-794e9d96bb6mr5906985a.1.1717008788429; 
 Wed, 29 May 2024 11:53:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd064c3sm493011985a.84.2024.05.29.11.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 11:53:07 -0700 (PDT)
Date: Wed, 29 May 2024 14:53:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 07/26] migration: VMStateId
Message-ID: <Zld5kdnOB9CqyRYq@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
 <ZlTO9fVYG50r3XL9@x1n>
 <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
 <ZlYX4BWLU19f1vaI@x1n>
 <18f8bba1-b687-43ba-9f2c-4cfafe005ac1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18f8bba1-b687-43ba-9f2c-4cfafe005ac1@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

On Wed, May 29, 2024 at 01:30:18PM -0400, Steven Sistare wrote:
> How about a more general name for the type:
> 
> migration/misc.h
>     typedef char (MigrationId)[256];

How about qemu/typedefs.h?  Not sure whether it's applicable. Markus (in
the loop) may have a better idea.

Meanwhile, s/MigrationID/IDString/?

> 
> exec/ramblock.h
>     struct RAMBlock {
>         MigrationId idstr;
> 
> migration/savevm.c
>     typedef struct CompatEntry {
>         MigrationId idstr;
> 
>     typedef struct SaveStateEntry {
>         MigrationId idstr;
> 
> 
> - Steve
> 

-- 
Peter Xu


