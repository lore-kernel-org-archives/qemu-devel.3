Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD3AC5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLXw-0004C9-Jy; Mon, 04 Mar 2024 22:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhLXv-0004C1-Cq
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhLXt-0006tx-Ra
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709609568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFf79QHDdfX0YhT4LNJSMiZwWojpS9TKQzLjOwB2CR8=;
 b=Knetvd6lBuja0Q2/smFsZHLljj4q7+rCVn1rbjPE9DI/LDfih+xPzVB88jXYefV5QPfFhR
 f1YD84m1ZESootXRYfpB6sybQaJ+KabyoUNUKkb3GPzFRRZxFc0Di5vDj+clyXGVl+PuFD
 J1YMmbc8VuLuHBXpbUunmogPjUYbWGU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-L39qYdvFPv-P00EQ9viqkA-1; Mon, 04 Mar 2024 22:32:47 -0500
X-MC-Unique: L39qYdvFPv-P00EQ9viqkA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc44987075so4421955ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 19:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709609565; x=1710214365;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFf79QHDdfX0YhT4LNJSMiZwWojpS9TKQzLjOwB2CR8=;
 b=hPxaX2+wb3WCPf8B8HrL0wORlxRNtIu6o2q8JLzdjYqSDYWGgWJIh6x5lD3t/eU5JG
 hNqReq3HMIOMNBQCs7YgmK5EOAtJVCWeNDc86BGpzHLip1JWeR024KKBSSiQMRcZVFpP
 yHjRwr+gxrkvDRrutx4VXTCHDH1AVu32kbXXljLGc+hwQr4BBdVy1UIS+0KyKtLYQbcV
 MCSyhGM2tlsI2kbfFecTa+yxsRshmEDj2DYXmu1HxG286xDSGIdk+cNZO0PgVlGEpE02
 9CdIBATRxHLkkhykK75hqHBtqJkThq2a1J/5jIEv9Z+Fo0IVba4X2hGTtbw4lsBzxUYg
 sDeQ==
X-Gm-Message-State: AOJu0YwkcwlNwBsZP91yU9F8KkrnK74efTJHgQWgvW1Xqv/CqDJmwMfZ
 1QOFzHk13PqlHN1m8TFBHmkedbVS6waWEzmocUPZqNLhOohIOgG3UjHr7s1a00Uz5X7sCaCxf4M
 Wc6pZWG85mRwIzlHwlnRSqil3MuhEN0GrMq6BXpCsusBDw3r7LE7tZowNyo5qjuk=
X-Received: by 2002:a17:902:7c13:b0:1dc:fcde:853a with SMTP id
 x19-20020a1709027c1300b001dcfcde853amr695431pll.1.1709609565671; 
 Mon, 04 Mar 2024 19:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc2UM/BNAbX8A7/ThvwHTE9uXocCKHd6dcWvR+qdRsCM1bHshgtlJeprO2maIyCU90ImPIQQ==
X-Received: by 2002:a17:902:7c13:b0:1dc:fcde:853a with SMTP id
 x19-20020a1709027c1300b001dcfcde853amr695417pll.1.1709609565344; 
 Mon, 04 Mar 2024 19:32:45 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170903409300b001d913992d8csm9288224plc.242.2024.03.04.19.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 19:32:44 -0800 (PST)
Date: Tue, 5 Mar 2024 11:32:37 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 10/26] migration: Move cleanup after after error
 reporting in qemu_savevm_state_setup()
Message-ID: <ZeaSVc8hOOPReF60@x1n>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-11-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304122844.1888308-11-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 04, 2024 at 01:28:28PM +0100, Cédric Le Goater wrote:
> This will help preserving the error set by .save_setup() handlers.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

IIUC this is about the next patch.  I got fully confused before reading
into the next one.  IMHO we can squash it into where it's used.

Thanks,

> ---
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 31ce9391d49c825d4ec835e26ac0246e192783a0..e400706e61e06d2d1d03a11aed14f30a243833f2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1740,10 +1740,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>          qemu_savevm_state_complete_precopy(f, false, false);
>          ret = qemu_file_get_error(f);
>      }
> -    qemu_savevm_state_cleanup();
>      if (ret != 0) {
>          error_setg_errno(errp, -ret, "Error while writing VM state");
>      }
> +    qemu_savevm_state_cleanup();
>  
>      if (ret != 0) {
>          status = MIGRATION_STATUS_FAILED;
> -- 
> 2.44.0
> 
> 

-- 
Peter Xu


