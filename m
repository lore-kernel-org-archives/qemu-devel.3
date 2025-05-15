Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D024C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 20:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFfPN-0001xB-Ge; Thu, 15 May 2025 16:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFfPL-0001wb-9L
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFfPJ-00072S-Nc
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747341739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kzh2DG0hKMbQLD8dnFsbg4ucR+lGRycstwMYFi+DnAw=;
 b=AxW0+MQZETlaeXicEAsqeBD1VP7SY4sLRP3uQSPQJK8Duc1nLZhbFeT0ICD8Hd1uXigMsD
 yzyQiSdpC++UZRIQWjgiw9EjoULtUvkC/QXHGqT06NmDulcEZJ4YJUgFN/xhKOaM/AQ0gv
 ABdvGzSsywoj4FW9mgWhyIzzoRNZORE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-6q9WAnSlPeicK0MGmiMxxg-1; Thu, 15 May 2025 16:42:17 -0400
X-MC-Unique: 6q9WAnSlPeicK0MGmiMxxg-1
X-Mimecast-MFC-AGG-ID: 6q9WAnSlPeicK0MGmiMxxg_1747341736
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e3abea7e8so15884995ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 13:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747341736; x=1747946536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzh2DG0hKMbQLD8dnFsbg4ucR+lGRycstwMYFi+DnAw=;
 b=DClYMK7ZIi0bx6hGzDFvQFC5V2PlQQ58GfrozS8IMB1sLcCfg7vhVZLFLWAGrPc+s/
 KbhtOx3+OIyL44be3gWgv5Sf12pU0I8ahuAWVzHfwhL/gdbkYcAPGLzPhtV7HFwndvej
 DUU3wEigVieTXU2FdDKgvYuFAWwxX+IDqlpRPyz1Hu6XkHBHu80sAlDdRqFFCNjh9jTB
 l8cBW7i/aVRcP+K7uVnSO1kx+fnGQ64Bli8EfcYgPz6oHRP7jsPqbgeKC7v4ii1Qn6lC
 jMr8ZfJuaVz1jlpIcW3y9t29P0G5hyNhZi+lZikCbT6JayTDcnaFiG/BgUwWAZs5eH3g
 WWVQ==
X-Gm-Message-State: AOJu0YzwmgrUZN9psNiQBD87rIZKxlJKi0gI2RioJhglXJ5rpNaBFI42
 PagIb5MxdICUZgLUie7RQcEh79FkvGRRWAzjnT1vPr35PnTEOfGTsFaA7foCkZPxXAuDdgJqbU4
 zHDEMAKfK2C+4kfcHqsP6Cu0N+psBZs9FdYYT/s0Ac275XTWt+GXKc8Ap
X-Gm-Gg: ASbGncs9AaCSDXQ/3vrllYKP2lrYZIfv2S4AtaEExciT6j9rF09OY0wa1f06KLiGVEc
 m1dxppEsLUDYeGKpiw4va8W/7GUGfQEg3y8xNAmgVoDtX+HqLN/AZJAQ35wh+8I9vyTah0Xupd+
 IHpJantNuk3HqPg9vLDoEk81xHNT8TX6dElTQM4CV8QfID79C2WGQ9PUKAcaclK2ljDW2dd30wF
 YJvNYx5tE7S9PyjnJl81+dPerx9AIgHy92uWB4Q9a5vaNb6HUand5hkW+m+0UjCGK/3NkzfWO8C
 abw=
X-Received: by 2002:a17:903:1a68:b0:231:c9bb:60fd with SMTP id
 d9443c01a7336-231d4596c61mr9902775ad.33.1747341736478; 
 Thu, 15 May 2025 13:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+hVQTtiLRg1ndRCMRdUXsX8UMJ32R3L8dOCHCqs6yqDkvEYqrO8kxyqwlpIapOCzC2eSSHQ==
X-Received: by 2002:a17:903:1a68:b0:231:c9bb:60fd with SMTP id
 d9443c01a7336-231d4596c61mr9902615ad.33.1747341736123; 
 Thu, 15 May 2025 13:42:16 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebad00sm1860035ad.169.2025.05.15.13.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 13:42:15 -0700 (PDT)
Date: Thu, 15 May 2025 16:42:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 03/13] migration: Run a post update routine after
 setting parameters
Message-ID: <aCZRozMezmt88WcW@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411191443.22565-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 11, 2025 at 04:14:33PM -0300, Fabiano Rosas wrote:
> Some migration parameters are updated immediately once they are set
> via migrate-set-parameters. Move that work outside of
> migrate_params_apply() and leave that function with the single
> responsibility of setting s->parameters and not doing any
> side-effects.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


