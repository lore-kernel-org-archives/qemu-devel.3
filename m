Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E181C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYpR-0000mn-Bj; Fri, 06 Jun 2025 11:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYpO-0000mT-Hm
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYpM-0007bP-PW
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749223071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jT0Pvlw78/uJ9rake/rLEG8/2Re0fC43ENub0ZFgllU=;
 b=XsgCARAhEnCtR9/fBBUZ3btcq9ueZa0SKeKEiaOFRxqWwhzZKRChq/F2BU4gm+1PRWmsXD
 ayQsh5E/LeZ2u5Ik/LhDXWjdHiAoZ4nSgDjVKLHXT8XkEyyqPXXoaKpGKOrB+aviWD13Hk
 KWAMpj5CDFyJwTiFjO+H+b9ejqZSJCM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-zmDer2zEMpuIrQ_wmV-WMw-1; Fri, 06 Jun 2025 11:17:49 -0400
X-MC-Unique: zmDer2zEMpuIrQ_wmV-WMw-1
X-Mimecast-MFC-AGG-ID: zmDer2zEMpuIrQ_wmV-WMw_1749223069
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f53913e2b6so31431246d6.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 08:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749223069; x=1749827869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jT0Pvlw78/uJ9rake/rLEG8/2Re0fC43ENub0ZFgllU=;
 b=pnVVvXdPIceJ1kwC13r4WBvz9xw000aqHLOyO+N7DCV0nl9aoRqoRj+mPxQY5yNHGx
 Gwd+ruOoADdNoFD7qjp4t43eBctc3FIlbnRDXf9VBbsSwVM1upUwmxZqtM4HBDkaxNfk
 TK7kguWuDjFuMh7D4bApqVvOxoDsvZCv3q9wm7VT8KwvqAmPsY+H7xFg0WSayg1DcVeu
 AcJRoXZ4AKxtZGysSw0GqXMBw5lgLPxqN265bg0xDZ/Cs14eXXgiXu+p/H6SHiH4viGB
 swa0gddGwERa0JnHGYPaANS6CCqAMw8G06pU9i+S0H4+c098zA+jw8T/CNPKA6AXGAt5
 1Efw==
X-Gm-Message-State: AOJu0Yy5hZa2cC4uNxVKKkKV3Hj88roOhRSOh333oEEuFd7GDUbShgsa
 mZUb1Swl0ssmtXLFF+keMRKI3DJ+Y/uz5v6wxB9F1jwuKAbG7rBdntmhOYPYfV+DDvAhADk19ml
 sHLLnMbrnALWbUIw+NBizTbSAfLVlbCGQ4bIGZVlJBsmxNlbrIKmi9pD4
X-Gm-Gg: ASbGnctpIpTTST3r416Y0y/Xdg9B3NKjm3qxFMk0HTBnQSunatY99puJ8hPN5XTiDrS
 fFAkV/MsT8+Uf1hC+pt4grpZPYeT9fcgqCDISozlg1siARQomHJwxQfOGdlosQ8GYQ2ComRYYvU
 AozLxszhV6/l/LBbAn50BFtFR/tccx7/KkODdJMrvyrJMLNfQKgPZYSePJZ/L+Z00x16qM6xFTH
 fEQtCEl5KYxAPH0iJtb5huaJQ970CFv+TJMZgQpUGs5I6UGB3i6DhaoTo7tjPgLnCzdAGN+O2/6
 JuG1UMgoQOrgFA==
X-Received: by 2002:ad4:576b:0:b0:6fa:fdb3:588b with SMTP id
 6a1803df08f44-6fb08fe1a5emr55582886d6.39.1749223069354; 
 Fri, 06 Jun 2025 08:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfdJk7U7y+LRlxCh6TIGzSVuGZF3g9SKsyItLyvG7I06MUZggjfiOt+P0ThhMd1da5+JMJmQ==
X-Received: by 2002:ad4:576b:0:b0:6fa:fdb3:588b with SMTP id
 6a1803df08f44-6fb08fe1a5emr55582656d6.39.1749223069024; 
 Fri, 06 Jun 2025 08:17:49 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b365dfsm12289596d6.112.2025.06.06.08.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:17:48 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:17:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 08/21] migration: Do away with usage of
 QERR_INVALID_PARAMETER_VALUE
Message-ID: <aEMGmhaes8yVMiEW@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 02, 2025 at 10:37:57PM -0300, Fabiano Rosas wrote:
> The QERR_INVALID_PARAMETER_VALUE macro is documented as not to be used
> in new code. Remove the usage from migration/options.c.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


