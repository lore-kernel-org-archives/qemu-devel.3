Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69ECC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZ4H-0004Vz-Lc; Thu, 29 Feb 2024 00:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfZ4E-0004VZ-ON
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfZ4D-0000fS-B6
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709184888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDWrhxdWvTqA5Gs079Z/W4Wn/J3m+T6BoGhNu/Kl57Y=;
 b=K5reeYlbJMZHfiLL2nJzPdLzeVHhD0xE6+hkrwpA9T5FDaSIpiq6uAaTi09xEkT8k/sSkN
 i4mMXxbppy7wVsWxhH2xUIXArZ8j9tEPqSX/OyOyoKwWWiejNhncaO/mjhgGWkXN9jh5nN
 AUyBA0y8fA6TKpS51jgav1wUi5n32aY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-z_8KLg5_NIqRDOJgABUgDQ-1; Thu, 29 Feb 2024 00:34:46 -0500
X-MC-Unique: z_8KLg5_NIqRDOJgABUgDQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so115704a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709184885; x=1709789685;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDWrhxdWvTqA5Gs079Z/W4Wn/J3m+T6BoGhNu/Kl57Y=;
 b=fSR9fQAISaeNrxtYrbmICsLYIHpAj6vE4nXA3V/WUmQDamA5wx9P5UflJEvp6Xc7XA
 iSL4V4t12eJ/k84wus7zb7UW1OX6Hj7UC1ADPP29lLlTpo+tBLPVd62fyErNvtnv+3XW
 HtAWYaYPINngv1+fHiKIEvwqMRlCx643V4EhA4EbvV9Xcrl8HQijRQj/OzndDXc/scQW
 V17+nxtB9yBoAgbDO3PYGoKyTDil7XLUmVr5l3hrdRjsm+sU0ImlVmWOKwWeiYoQgbG3
 o6dkk6e5Vanuo6/aESBMcqSmIQ9rn6vHC34bVPVRUZvzLX7e6HU+F6NIbxlNzZoGj2DN
 t0Qw==
X-Gm-Message-State: AOJu0YyeLU3cEqv/4wJdevJ2gd/YjTtErDhwtvwRxKUvqFeUE7zjBYEQ
 Q5RUd3/nPx4S6qdsSmf2IjNRy/3ODl0BDWXNON6JN2VTOzlscJbsACsps7FsxeudFUe0mMpstbG
 sr0IuQIij5sWqu2Y8YV7npVyr1SGBorG6t3IhHxEz88YtrFSjKS3M
X-Received: by 2002:a05:6a20:a108:b0:1a1:1f73:4d3d with SMTP id
 q8-20020a056a20a10800b001a11f734d3dmr1541575pzk.4.1709184885503; 
 Wed, 28 Feb 2024 21:34:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfXGmh81d+eb2+ISFQ3+r+lcAoO8LkqTLh5NxALqrzXmvwKGcU94z2XUGMnzECQ3c4r27UTA==
X-Received: by 2002:a05:6a20:a108:b0:1a1:1f73:4d3d with SMTP id
 q8-20020a056a20a10800b001a11f734d3dmr1541568pzk.4.1709184885251; 
 Wed, 28 Feb 2024 21:34:45 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001d9641003cfsm427937pll.142.2024.02.28.21.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:34:44 -0800 (PST)
Date: Thu, 29 Feb 2024 13:34:36 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 11/21] migration: Fix migration termination
Message-ID: <ZeAXbNy22xq4_SPm@x1n>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-12-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227180345.548960-12-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 07:03:35PM +0100, Cédric Le Goater wrote:
> Handle migration termination when in SETUP state. This can happen if
> qemu_savevm_state_setup() fails.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  migration/migration.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c1a62b696f62c0d5aca0505e58bc4dc0ff561fde..63294417ff9cae868ad8a167094a795fc30e4da0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3161,6 +3161,8 @@ static void migration_iteration_finish(MigrationState *s)
>              }
>          }
>          break;
> +    case MIGRATION_STATUS_SETUP:
> +        break;
>  
>      default:
>          /* Should not reach here, but if so, forgive the VM. */
> @@ -3192,6 +3194,8 @@ static void bg_migration_iteration_finish(MigrationState *s)
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          break;
> +    case MIGRATION_STATUS_SETUP:
> +        break;
>  
>      default:
>          /* Should not reach here, but if so, forgive the VM. */

Would this cause "query-migrate" to keep reporting "SETUP" even if setup()
failed?

IIUC we may need to set state to FAILED when setup() failed.  If so, this
patch might not be needed.

Thanks,

-- 
Peter Xu


