Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AB3E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 17:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ94i-0003bw-Qh; Tue, 24 Dec 2024 12:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ94W-0003Qj-OF
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ94U-0005IA-Iq
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735062713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zN5hwMxrD4mp9OZqtCA6Eu7EDpWUHwGELiYYy4yuVWM=;
 b=MF2AfqbQq4M7HUgDemuWs8JTTWpOQF3Hn0eJ+pGpDZwS01FsxJjgZIOiiBVS8FY8Dg7cMi
 NChGrLjEnhNEnKI7cIlAC87rXw/hgNSZSJlJCuWHZ2GnlkFVXjdjfgamu67juHybvrQ3wV
 BZuwgYDDQlcEDdHwK+LIdqfZg8BGiSA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-324lkLhsMxWeDMxL4pcTfg-1; Tue, 24 Dec 2024 12:51:52 -0500
X-MC-Unique: 324lkLhsMxWeDMxL4pcTfg-1
X-Mimecast-MFC-AGG-ID: 324lkLhsMxWeDMxL4pcTfg
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467982f8816so116632531cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 09:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735062712; x=1735667512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zN5hwMxrD4mp9OZqtCA6Eu7EDpWUHwGELiYYy4yuVWM=;
 b=i2+FenmLTQl38L30sPK8Hy7FT8lOCocpHmrBzPXv1uwmoT1ftRhRIXzDxVgAt2/rBL
 7ZEZjHBxeQmSlcvNl2VphxoMSrcAE3wTIymzOaLIM9zG5ge6T7Q1OOzCyvXuI+NfT/34
 fN9i+h8HIhXixfOkMx/s04kpRrkzK3XIQYt6xpRz0UsE9bgniSIRWnK6eLIEf1GBvAcR
 WHfS+hEF1col3VVgFQ15vGDs/rDhg7duHvrYh6rpTo1x09sSPzBEFXpiLFHkfdSmP/Tq
 ng2gfVs99DDgaFbaFryKIPtrVHBtgo5MdSAgeSwVcN5VE7taNdQPZ+w3EbNViEpW6osZ
 yoIg==
X-Gm-Message-State: AOJu0YzgSnfFhPpSygU2kWQaB4SZ/0Lak3IJBzNcdk4kGACqtpaJ4WyS
 oNsmLn9yM2wBsbXI5dsEKawWSCbFRwKYILDW7M5qBI7SOoE2XsupQsoItL5BX/+rROW/yIGjEZn
 Xu5AVXT5vKkmp+5EC6VDBpFHiLvVJhWtttJNk0rZi4lLcfbJXhY80
X-Gm-Gg: ASbGnct1LHInbgIe5Ud0iO7ZWikILLGw15Crm5y51NP91L/v+ZGPhUpzXlv3lATOaTa
 1R6JwA3OuvhOJMx1w5h7+UJfezUZGq50NddFqxX7vJJVG9Uy2vLaKa2xieJ+HvKDa02KtGx6umI
 YLpXKVVz/PxzNO2FN5QMzKOnspPAiKSdzbitXKWJvjDOk46gPxhejsuPHKKBh5L9dBWMhMurbgR
 dg20FkhMt4chN3elPOon9An1IdVj7834stRK2HTQNyr0Z3WVjGjbYE5krjvwGyZZztOIxKw+O98
 hz3Gb6gscMkzLAY8Cw==
X-Received: by 2002:a05:6214:1252:b0:6d8:8a01:64e2 with SMTP id
 6a1803df08f44-6dd233af19amr277727776d6.43.1735062711972; 
 Tue, 24 Dec 2024 09:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJyvjZ5IK2S4i5cP/IbgMN+KpXnnmLtkc2sbMjAbXnu3UQuLhKkeIer+fgGheu5rbAWHehCg==
X-Received: by 2002:a05:6214:1252:b0:6d8:8a01:64e2 with SMTP id
 6a1803df08f44-6dd233af19amr277727616d6.43.1735062711728; 
 Tue, 24 Dec 2024 09:51:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm54640056d6.87.2024.12.24.09.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 09:51:50 -0800 (PST)
Date: Tue, 24 Dec 2024 12:51:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 11/23] migration: incoming channel
Message-ID: <Z2r0tB9LrjB8cmiA@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-12-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 08:16:56AM -0800, Steve Sistare wrote:
> Extend the -incoming option to allow an @MigrationChannel to be specified.
> This allows channels other than 'main' to be described on the command
> line, which will be needed for CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


