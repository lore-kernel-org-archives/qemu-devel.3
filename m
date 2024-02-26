Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B98C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUHU-0004PD-SW; Mon, 26 Feb 2024 01:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reUHT-0004LN-9J
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reUHR-00067v-8W
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708928160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+AEWktv26H65INx3J2/eTbVF5bB3cUBVbvBoMlSd5mg=;
 b=DNn7btpStlx48Cp0YXP1g/bdYTzYjDNX8zcNUzpFGE5TWeJjRJpVAFuTq+srTiq0INN6jF
 nHe9BCgBBYGlW6GT1AeOG2WfhUW4u0e6+rGBLudqexrh4wAlqEwzpYqgHpcz03V9jjJR/R
 120UxHUlN6cRvRuMHsTumJhPYDMQDLU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-KsJZm8HIMh2x2noVixguIA-1; Mon, 26 Feb 2024 01:15:59 -0500
X-MC-Unique: KsJZm8HIMh2x2noVixguIA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so977045a91.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 22:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708928157; x=1709532957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AEWktv26H65INx3J2/eTbVF5bB3cUBVbvBoMlSd5mg=;
 b=gilj7Y/FSKq/R/1AjbapzQ8hxfYdyxMpYCFEvW8Caw51JhvcpyaqWFeuR9w40tMUXU
 s5pOCX0B0TmgT7xXXAxdOcJSkhDOKwYKjYrXdBd+B8COMnSNsUw/4+gt2RzWv8pUpnsj
 VPVhwJl1JFNT7M6HKnO438E5fkiCdb2XYRdFJmazWBlY4P+2OmEXaWuzNwjXRBKbVevO
 r8hmA7QU0tPtuOvxSTIAwWf8sOklq6bSYv3UPk5NBhiHY3GjF2Ii9B3KaE4HIjounKM5
 cnFxNHrzw24nAav10jveyE6kKdLngsGRCoK91UpF8ALUaWGluHxTfGx1/0u7YW9UFRfc
 /LQA==
X-Gm-Message-State: AOJu0YzB2kzrhkmsJIdgBPVrOE2TCKI3DKM7X9ayhtT912TR+3WWbyGo
 UaFT7bYPAk/ce2UxbP69q6QyXF+DVLmfj/yWsDoMENU3EOScXepDQ1/5tClpj/Z2QLyJK5IOfwS
 t2CMO5S4maQXVVP/4SZdzKo+8XZqXwH0bSE8VdfOa0JvLcnilSutjmzQ6ftFoC5o=
X-Received: by 2002:a17:902:eecd:b0:1db:f23f:676c with SMTP id
 h13-20020a170902eecd00b001dbf23f676cmr7028168plb.0.1708928157736; 
 Sun, 25 Feb 2024 22:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSeCruy55im0hGJtT9/myRRC6ov8OKTKF1B3vX07rGfHolL9znj6QDnlQXVbr8qYqJ3m/gsQ==
X-Received: by 2002:a17:902:eecd:b0:1db:f23f:676c with SMTP id
 h13-20020a170902eecd00b001dbf23f676cmr7028157plb.0.1708928157405; 
 Sun, 25 Feb 2024 22:15:57 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ji22-20020a170903325600b001dc23e877bfsm3126903plb.268.2024.02.25.22.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 22:15:57 -0800 (PST)
Date: Mon, 26 Feb 2024 14:15:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 00/34] migration: File based migration with multifd
 and fixed-ram
Message-ID: <ZdwslcXY7oN20dQX@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Feb 20, 2024 at 07:41:04PM -0300, Fabiano Rosas wrote:
> 0) Cleanups                           [1-5]

While I am still reading the rest.. I queued these five first.

-- 
Peter Xu


