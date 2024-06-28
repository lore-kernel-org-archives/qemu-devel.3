Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2268FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9jn-0000ml-JG; Fri, 28 Jun 2024 07:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sN9jh-0000mA-3M
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sN9jf-000822-AG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719573946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+b1UnD4cU/S/YssrCohfplGL55GIewjxxe+5D/Ivr/0=;
 b=TtxxVzZm3QXdrcYlo8uTbaW/g5SrdptrICkwaBGT7im2GhYt0NxIVdBgUZNEjaJN/eM6OZ
 e4hq22bd884mmDZ0pxKP2yjX0rFT10WBa+hHESUDlLloIYD7Mp3l43fL3ho3h8/2khTTuL
 lH5Cxcotfw4DU+kfr+UeGhknQbMF4fs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-3syHubmDMLyWnWWnQT33nw-1; Fri, 28 Jun 2024 07:25:45 -0400
X-MC-Unique: 3syHubmDMLyWnWWnQT33nw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3670c9e8b7eso345471f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 04:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719573944; x=1720178744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+b1UnD4cU/S/YssrCohfplGL55GIewjxxe+5D/Ivr/0=;
 b=b03/86+dE7mEH7Z1a9GQSgZyhvTWl7DjkmBfsT32bv+ksSsbvQ3rCNt7WsfzCLTaoa
 EYmq61w9aZCzUIIPkfCzNARb57dp15OcnnO8xORDhg3EfnE6J5m9MBuONLtgas5zNptK
 dvFbZp5dzBMZ9dcgxs/zuJbBxcvFmPLz9jIvgq5H3pacBoRkIyp951uVzCfyykektT7E
 5tBohlEzxwUT2s5ra5Bma7mYghqMQMfeE/D3CZ3MG5IRgmal/dj9R+iPzojbxl0N79+H
 sZwjkQjAOiMdvr6iVkqb8B/zqjqbYGPvIj1wwkiRSRnSgG1OKHwz3df+1QkGEZeh/vCW
 RyEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8/UfdHSbN+2tXHsYX1SjQFRngwa61d2WRIaK4KZhuOeUe02jdrNsUpd52mqy1a+jidKmBo1a2v9I1EU+61gACN0hA8Ss=
X-Gm-Message-State: AOJu0YzJUloHLWXbOE9KsA5GG4a4gMBlwZk4xPoS5Dq7w6k6S796SaiI
 hQEtT9XMic6wXs6FiCjNdmVEqlT5KpoIpROD/Oq7ljeIK6L7SkYTW9PQND82zgN5fK6FGYrm3PK
 +Tv5/0qaE5z9abALJST5kyOX/Rw+/a551RWv5viI/xxx5kBpXxlJM
X-Received: by 2002:a5d:5987:0:b0:363:776:821b with SMTP id
 ffacd0b85a97d-3676045b4a0mr1538849f8f.0.1719573944026; 
 Fri, 28 Jun 2024 04:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA6BIAl/VTfTzYmb4K2vxbdnRmHQ7rInN44D2l1ZBCoJLEYpq7FsUxQ0xLLNongvZY/6FqPA==
X-Received: by 2002:a5d:5987:0:b0:363:776:821b with SMTP id
 ffacd0b85a97d-3676045b4a0mr1538828f8f.0.1719573943695; 
 Fri, 28 Jun 2024 04:25:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b068e54sm31627295e9.25.2024.06.28.04.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 04:25:43 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:25:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, Andrea Righi
 <andrea.righi@canonical.com>
Subject: Re: [PATCH v3 1/3] tests/acpi: pc: allow DSDT acpi table changes
Message-ID: <20240628132542.47b5a137@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607141809.1637137-2-ribalda@chromium.org>
References: <20240607141809.1637137-1-ribalda@chromium.org>
 <20240607141809.1637137-2-ribalda@chromium.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  7 Jun 2024 14:17:24 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..b2c2c10cbc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/pc/DSDT",

that's no enough, a lot more tables expected blobs are affected by
the next patch.

before posting, make sure that 'make check-qtest' passes fine


