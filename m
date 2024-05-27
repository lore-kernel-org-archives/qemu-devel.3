Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D517C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBefr-0008WI-F0; Mon, 27 May 2024 14:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBefp-0008V0-1Y
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBefm-0003z1-Ph
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716832933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eZS8FToWO+XGQkmIlN5SmwScGpwe/aP5/M83MehcMg=;
 b=bmnkzE/VCBB10uaUe/5SbdxPOHW6oJLJ2ejM2L5azkPCOtivXXuRe+2qFWoszCpT24T3eZ
 TOdAAAUzp3oDZuVbGH1RILWytwQDQaezosH+oI6tqir/UH/rFGZl3c3iGoDuFN5ZPj7/nZ
 oaFMldOPEYUcZCzVxRKcmbGabz7L5rc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-zOOtP5zvPLuhqTCxXsrlVQ-1; Mon, 27 May 2024 14:02:12 -0400
X-MC-Unique: zOOtP5zvPLuhqTCxXsrlVQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ab89f69cd8so75816d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716832932; x=1717437732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eZS8FToWO+XGQkmIlN5SmwScGpwe/aP5/M83MehcMg=;
 b=JT6Lwx008R31wwia1sKWPYIRtGnDbvHPXi/z85N2Y09tIhaBVCIkvqrvFaeFcnB1Fw
 QW7J8e3eYSE0N4SJQ1/X0I3b2GsXP7kV9VFAhjxm5O+h/bzqhxiddnl5Y56PKQ62cOXk
 9qbQvrpmaDQFed5O8zO/Eh+mf8ZuvHEU1niUHhP47j7TiYYHob5tw1Y2jtQ5vZ5UephI
 /cOTFbHkRDK8FhqEnqLU5FpsTk3g+9vhU5jI3ATKqxNgM5kWhT+mr9aE9On8d1QzOlNO
 BQtoTYNGFZDJMHGEJsGiiEpxB+pEJUXnttIZ83Vz5cjmYVzg+IpshVe75RNXDIXOoFCc
 1Bgg==
X-Gm-Message-State: AOJu0YwRNrnIou9pi2jIesKkdej0QJRvJVq0zQXiIFaOB4Y0liEe8FS9
 57gDvlxY3glF128aTRXaFlsYEmqSfQ/BydR/Pve7XoTIKA4GPRCfUvtazv3fp3JYxNX0wA6cE/T
 yzd6EoqiyruPcLZwreltifgtNcUvzQZXqhrpEo+nN9isuPRR7AcRQ
X-Received: by 2002:ac8:590c:0:b0:437:98be:259d with SMTP id
 d75a77b69052e-43fb0b4c5a5mr109941341cf.0.1716832931725; 
 Mon, 27 May 2024 11:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEHS9XJl8ureQ1qi6vuWxI9U+XVHkUCL/gGuwvTQdYuQ249Nm8DCIpVxd+s/w8/g8VBd5AIQ==
X-Received: by 2002:ac8:590c:0:b0:437:98be:259d with SMTP id
 d75a77b69052e-43fb0b4c5a5mr109940821cf.0.1716832930876; 
 Mon, 27 May 2024 11:02:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb16b7983sm35999731cf.14.2024.05.27.11.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 11:02:10 -0700 (PDT)
Date: Mon, 27 May 2024 14:02:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 04/26] migration: delete unused parameter mis
Message-ID: <ZlTKn5_JoOzX8M6D@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, Apr 29, 2024 at 08:55:13AM -0700, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


