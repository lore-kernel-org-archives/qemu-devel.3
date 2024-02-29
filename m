Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46347C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 04:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXtD-0000FT-D8; Wed, 28 Feb 2024 23:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXtC-0000Ew-1Q
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXt7-0006Fh-J3
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709180356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHYhrAAHuCI4CA4oC7bvcUSqB56IiXYf7xnKzn/Ge4c=;
 b=BH6UpbQKVDXX0Y8tn3ZxNNV7/XlHudivnJR5rQ1+zJ9ParfYUgg94eBJ6/I5vRrlAkkq3Y
 ij3gJOhPNreFtIv0GSK1LOlnVa6QBGYcibhd1utlyZ+ZDLlWTSK6cal/7lBXSXWVUPNqof
 obLfEV7XBFES18Vr1ICPhISMMhbtZ4Y=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-6Lt65OSlPya9nr1zm07rfQ-1; Wed, 28 Feb 2024 23:19:15 -0500
X-MC-Unique: 6Lt65OSlPya9nr1zm07rfQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6e4bb1d0f3aso74957a34.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709180354; x=1709785154;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHYhrAAHuCI4CA4oC7bvcUSqB56IiXYf7xnKzn/Ge4c=;
 b=Wy0qAZXcfppsr+LTA+2UpBPKZ03BNA2jbNJ4V/q3UtVjP5Vqw5Z3+1x58dp0g2UZy3
 hgiOt/pepPmTZx4t5SUYYo05QaydGphFBPTMy5QseGRN9cV6rbs5d6OvNtPjV8WGppdM
 qHcI6J2Yo8EbWIuDZcBz/tOTYObursTGOVQdxRscB1IBZu7DFbz92qFbGp3pLtrveRcT
 Xit79c2gGup/PzQ7q4L49ac/cdd9dafcyCkXvJuovnP6toOnXnswVRCCiIGl5fL0+dfa
 F56nl3A5EBQgCYSbLnFwrW0JcqjUihFz466MY5LJSAyU7Jg1qN6KfN4v4nrGee7kWyBa
 jE3Q==
X-Gm-Message-State: AOJu0YycjPcsIaf6TH8py81bNgMZ9tUh41P1xzH+MPC3ciwcvvVFMud7
 KAAnnQLG839mWuMAoEn/fcMwe+EUDXIOUk0RxIx2rxl5rr81Zf/UIBSgjkB5AxQTb0E/RpFne3J
 RD0cg1sGkM15EpBvwH9cLkVFn0D2+LhLJD2+eJTHzeX3G2sNGQLSI
X-Received: by 2002:a05:6870:44d1:b0:21f:9eaa:3f1 with SMTP id
 t17-20020a05687044d100b0021f9eaa03f1mr943257oai.5.1709180354201; 
 Wed, 28 Feb 2024 20:19:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3nsPeSi9HZcmgJDhRlAURKi7uzbVIkCLaZ6f4A744pen7S/xBq0nJ8PG0fCZ1wMm5UqxfEg==
X-Received: by 2002:a05:6870:44d1:b0:21f:9eaa:3f1 with SMTP id
 t17-20020a05687044d100b0021f9eaa03f1mr943245oai.5.1709180353939; 
 Wed, 28 Feb 2024 20:19:13 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p25-20020a056a0026d900b006e55dc361cbsm240648pfw.218.2024.02.28.20.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 20:19:13 -0800 (PST)
Date: Thu, 29 Feb 2024 12:19:04 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 05/21] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZeAFuMXOmus-yxTA@x1n>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-6-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227180345.548960-6-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Tue, Feb 27, 2024 at 07:03:29PM +0100, Cédric Le Goater wrote:
> @@ -3469,9 +3479,15 @@ static void *bg_migration_thread(void *opaque)
>  
>      bql_lock();
>      qemu_savevm_state_header(s->to_dst_file);
> -    qemu_savevm_state_setup(s->to_dst_file);
> +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>      bql_unlock();
>  
> +    if (ret) {
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +        goto fail;
> +    }

This chunk may need to be moved above bql unlock.

> +
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
>  

-- 
Peter Xu


